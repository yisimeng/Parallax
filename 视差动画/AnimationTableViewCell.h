//
//  AnimationTableViewCell.h
//  视差动画
//
//  Created by 忆思梦 on 16/3/3.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface AnimationTableViewCell : UITableViewCell
- (CGFloat)cellOffset;
- (void)configWithDic:(NSDictionary *)dic;
@end
