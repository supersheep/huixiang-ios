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

@implementation AddPieceController

@synthesize writingTextfield;
@synthesize imageUploadButton;
@synthesize back;

- (void)viewDidLoad{
    
    [writingTextfield becomeFirstResponder];
    
    UIFont* font = [UIFont fontWithName:@"Typicons" size:26.0];
    NSDictionary* attrs = @{NSFontAttributeName:font};
    
    [back setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [back setTitle:@"\ue006"];
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
    [SVProgressHUD showWithStatus:@"发送"];
    [HTTP sendRequestToPath:@"/add" method:@"POST" params:@{@"content":content,@"share":@""} cookies:@{@"cu":user[@"client_hash"]} completionHandler:^(id data) {
        if(data){
            [SVProgressHUD showSuccessWithStatus:@"成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }
        
        [self performSegueWithIdentifier:@"backToHome" sender:self];
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
