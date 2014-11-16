//
//  AddPieceController.m
//  Huixiang
//
//  Created by Hsu Spud on 14/10/29.
//  Copyright (c) 2014年 ltebean. All rights reserved.
//

#import "AddPieceController.h"
#import "Settings.h"
#import "SVProgressHUD.h"
#import "HTTP.h"
#import <QiniuSDK.h>

#define MIN_LENGTH 5;
#define MAX_LENGTH 240;


@interface AddPieceController()
@property (nonatomic, strong) UIAlertView* alert;
@end

@implementation AddPieceController

@synthesize writingTextfield;
@synthesize imageUploadButton;
@synthesize back;
@synthesize textCounter;


- (void)viewDidLoad{
    
    [writingTextfield becomeFirstResponder];
    writingTextfield.delegate = self;
    
    UIFont* font = [UIFont fontWithName:@"Typicons" size:26.0];
    NSDictionary* attrs = @{NSFontAttributeName:font};
    
    [back setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [back setTitle:@"\ue006"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillCounterLabel:) name:UITextViewTextDidChangeNotification object:writingTextfield];
    
    [self fillCounterLabel:nil];
}


-(void) showAlertWithTitle:(NSString*)title andMessage:(NSString*)message{
    _alert = [[UIAlertView alloc] init];
    [_alert setDelegate:self];
    [_alert setTitle:title];
    [_alert setMessage:message];
    [_alert addButtonWithTitle:@"好的"];
    [_alert show];
    
    [self.view endEditing:YES];
    [self.view becomeFirstResponder];
}


-(void)fillCounterLabel:(NSNotification *)notification{
    int maxLength = MAX_LENGTH;
    NSUInteger length = [[writingTextfield text] length];
    NSString* countText = [@(length) stringValue];
    countText = [countText stringByAppendingString:@" / "];
    countText = [countText stringByAppendingString:[@(maxLength) stringValue]];
    [textCounter setText:countText];
}


- (void)geTokenWith:(void (^)(NSString* fileName, NSString* token))handle{
    NSDictionary* user = [Settings getUser];
    [HTTP sendRequestToPath:@"/upload/token" method:@"GET" params:@{} cookies:@{@"cu":user[@"client_hash"]}  completionHandler:^(id data) {
        if(!data){
            [SVProgressHUD showErrorWithStatus:@"网络连接出错啦"];
            return;
        }
        
        handle(data[@"fileName"],data[@"token"]);
        
    }];
}

- (IBAction)uploadImage:(id)sender {
    
    [self geTokenWith: ^(NSString* fileName, NSString* token){
            QNUploadManager *upManager = [[QNUploadManager alloc] init];
            NSData *data = [@"Hello, World!" dataUsingEncoding : NSUTF8StringEncoding];
            [upManager putData:data key:@"hello" token:token
                      complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                          NSLog(@"%@", info);
                          NSLog(@"%@", resp);
                      } option:nil];
    }];

}

-(void)sharePiece:(NSString*) content
{
    NSDictionary* user=[Settings getUser];
    int maxLength = MAX_LENGTH;
    int minLength = MIN_LENGTH;
    int currentLength = [[writingTextfield text] length];
    if(currentLength < minLength){
        [self showAlertWithTitle:@"太简短咯" andMessage:@"\n至少5个字"];
        return;
    }
    if(currentLength > maxLength){
        [self showAlertWithTitle:@"超出长度限制" andMessage:@"\n已经有很多地方可以用来讲故事咯 :)"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"发送"];
    
    [HTTP sendRequestToPath:@"/add" method:@"POST" params:@{@"content":content,@"share":@""} cookies:@{@"cu":user[@"client_hash"]} completionHandler:^(id data) {
        if(data){
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            [self performSegueWithIdentifier:@"backToHome" sender:self];
        }else{
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }
        
    }];
}

- (IBAction)sendContent:(id)sender {
    NSString* content = [[self writingTextfield] text];
    [self sharePiece:content];
}


- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar{
    return UIBarPositionTopAttached;
}

@end
