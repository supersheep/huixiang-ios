//
//  PieceCell.h
//  Huixiang
//
//  Created by ltebean on 13-7-3.
//  Copyright (c) 2013年 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LABEL_SIZE CGSizeMake(260, 800)
#define LABEL_FONT_NAME @"Kannada Sangam MN"
#define LABEL_FONT_SIZE 18

@interface PieceCell : UITableViewCell

@property(nonatomic,strong) NSDictionary* piece;
@end
