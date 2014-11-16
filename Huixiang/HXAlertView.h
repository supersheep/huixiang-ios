//
//  HXAlertViewController.h
//  Huixiang
//
//  Created by Hsu Spud on 14/11/15.
//  Copyright (c) 2014年 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HXAlertViewDelegate
-(void)customAlertOk;
-(void)customAlertCancel;
@end


@interface HXAlertView : UIViewController
@property (nonatomic, retain) NSObject<HXAlertViewDelegate>* delegate;
@property (strong, nonatomic) IBOutlet UIView *viewMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnCancel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnOk;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *flexSpace;
- (IBAction)btnCancelTap:(id)sender;
- (IBAction)btnOkTap:(id)sender;

-(void)showCustomAlertInView:(UIView *)targetView withMessage:(NSString *)message;
-(void)removeCustomAlertFromView;
-(void)removeCustomAlertFromViewInstantly;
-(void)removeOkayButton:(BOOL)shouldRemove;
-(void)removeCancelButton:(BOOL)shouldRemove;
-(BOOL)isOkayButtonRemoved;
-(BOOL)isCancelButtonRemoved;

@end