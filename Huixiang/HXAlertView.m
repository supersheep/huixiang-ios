//
//  HXAlertViewController.m
//  Huixiang
//
//  Created by Hsu Spud on 14/11/15.
//  Copyright (c) 2014年 ltebean. All rights reserved.
//

#import "HXAlertView.h"
#define OK_BUTON_TAG 888
#define CANCEL_BUTTON_TAG 999
#define ANIMATION_DURATION 0.25

@interface HXAlertView ()
-(void)addOrRemoveButtonWithTag:(int)tag andActionToPerform:(BOOL)shouldRemove;
@end

@implementation HXAlertView

-(id)init{
    self = [super init];
    if(self){
        [self.view setFrame:CGRectMake(0, 0, 320, 180)];
        [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]];
        [_lblMessage setFrame:CGRectMake(_lblMessage.frame.origin.x, _lblMessage.frame.origin.y, _lblMessage.frame.size.width, _viewMessage.frame.size.height - _toolbar.frame.size.height)];
        [_btnOk setTag:OK_BUTON_TAG];
        [_btnCancel setTag:CANCEL_BUTTON_TAG];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showCustomAlertInView:(UIView *)targetView withMessage:(NSString *)message{
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    CGFloat statusBarOffset = statusBarSize.height;
    CGFloat width, height, offsetX, offsetY;
    width = targetView.frame.size.width;
    height = targetView.frame.size.height;
    
    offsetX = 0;
    offsetY = 0;
    
    // 初始化容器大小
    [self.view setFrame:CGRectMake(targetView.frame.origin.x, targetView.frame.origin.y, width, height)];
    [self.view setFrame:CGRectOffset(self.view.frame, offsetX, offsetY)];
    [targetView addSubview:self.view];
    
    
    // 起始位置 设到 target 外面去
    [_viewMessage setFrame:CGRectMake(0.0, -_viewMessage.frame.size.height, _viewMessage.frame.size.width, _viewMessage.frame.size.height)];
    
    // 跑动画
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationBeginsFromCurrentState:ANIMATION_DURATION];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [_viewMessage setFrame:CGRectMake(0.0, 0.0, _viewMessage.frame.size.width, _viewMessage.frame.size.height)];
    [UIView commitAnimations];
    
    [_lblMessage setTag:message];
    
}

-(void)removeCustomAlertFromView{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationBeginsFromCurrentState:ANIMATION_DURATION];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [_viewMessage setFrame:CGRectMake(0.0, -_viewMessage.frame.size.width, _viewMessage.frame.size.width, _viewMessage.frame.size.height)];
    [UIView commitAnimations];
    
    [self.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:ANIMATION_DURATION];
}

-(void)removeCustomAlertFromViewInstantly{
    [self.view removeFromSuperview];
}

-(BOOL)isOkayButtonRemoved{
    if([[_toolbar items] indexOfObjectIdenticalTo:_btnOk] == NSNotFound){
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)isCancelButtonRemoved{
    if([[_toolbar items] indexOfObjectIdenticalTo:_btnCancel] == NSNotFound){
        return YES;
    }else{
        return NO;
    }
}

-(void)addOrRemoveButtonWithTag:(int)tag andActionToPerform:(BOOL)shouldRemove{
    NSMutableArray *items = [[_toolbar items] mutableCopy];
    int flexSpaceIndex = [items indexOfObject:_flexSpace];
    int btnIndex = (tag == OK_BUTON_TAG) ? flexSpaceIndex + 1 : 0;
    
    if(shouldRemove){
        [items removeObjectAtIndex:btnIndex];
    }else{
        if(tag == OK_BUTON_TAG){
            [items insertObject:_btnOk atIndex:btnIndex];
        }else{
            [items insertObject:_btnCancel atIndex:btnIndex];
        }
    }
    
    [_toolbar setItems:(NSArray *)items];
}

-(void)removeOkayButton:(BOOL)shouldRemove{
    if([self isOkayButtonRemoved] != shouldRemove){
        [self addOrRemoveButtonWithTag:OK_BUTON_TAG andActionToPerform:shouldRemove];
    }
}


-(void)removeCancelButton:(BOOL)shouldRemove{
    if([self isCancelButtonRemoved] != shouldRemove){
        [self addOrRemoveButtonWithTag:CANCEL_BUTTON_TAG andActionToPerform:shouldRemove];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnCancelTap:(id)sender {
    [self removeCustomAlertFromView];
    if([self.delegate respondsToSelector:@selector(customAlertCancel:)]){
        [self.delegate customAlertCancel];
    }
}

- (IBAction)btnOkTap:(id)sender {
    if([self.delegate respondsToSelector:@selector(customAlertOk:)]){
        [self.delegate customAlertOk];
    }
}
@end
