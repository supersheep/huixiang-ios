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

@implementation AddPieceController

@synthesize writingTextfield;

- (void)viewDidLoad{
    
    [writingTextfield becomeFirstResponder];
    
    
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
