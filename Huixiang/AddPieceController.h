//
//  AddPieceController.h
//  Huixiang
//
//  Created by Hsu Spud on 14/10/29.
//  Copyright (c) 2014年 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "HXAlertView.h"

@interface AddPieceController : UIViewController
<
    UIActionSheetDelegate,
    UIImagePickerControllerDelegate,
    UIAlertViewDelegate,
    UIBarPositioningDelegate,
    UITextViewDelegate
>

@property (nonatomic, retain) IBOutlet UIPlaceHolderTextView *writingTextfield;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (nonatomic, weak) IBOutlet UIButton *imageUploadButton;
@property (weak, nonatomic) IBOutlet UILabel *textCounter;
@end
