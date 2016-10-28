//
//  ParallaxTableViewCell.m
//  视差动画
//
//  Created by 忆思梦 on 16/2/29.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

#import "ParallaxTableViewCell.h"
#import "SeparateImageView.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ParallaxTableViewCell ()

@property (nonatomic, strong) SeparateImageView * BGImageView;
@property (nonatomic, strong) UILabel * text;
@property (nonatomic, strong) UIView * maskView;
@property (nonatomic, assign) BOOL isHide;

@property (nonatomic, strong) UIImageView * mainImageView;
@property (nonatomic, strong) UIImageView * topImageView;
@property (nonatomic, strong) UIImageView * bottomImageView;

@end

@implementation ParallaxTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialization];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)initialization{
    _BGImageView = [[SeparateImageView alloc]initWithFrame:CGRectMake(0, -25, kWidth, 300)];
    _BGImageView.BgImage = [UIImage imageNamed:@"cell"];
    [self.contentView  addSubview:_BGImageView];
    
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 250)];
    _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
    _maskView.userInteractionEnabled = NO;
    [self.contentView addSubview:_maskView];
    
    _text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, 30)];
    _text.text = @"忆思梦";
    _text.textColor = [UIColor whiteColor];
    _text.center = CGPointMake(kWidth/2, 250/2);
    _text.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_text];
}

- (void)configWithDic:(NSDictionary *)dic{
    
}

- (CGFloat)cellOffset {    
    CGRect centerToWindow = [self convertRect:self.bounds toView:self.window];
    CGFloat centerY = CGRectGetMidY(centerToWindow);
    CGPoint windowCenter = self.superview.center;
    CGFloat cellOffsetY = centerY - windowCenter.y;
    CGFloat offsetDig =  cellOffsetY / self.superview.frame.size.height*3;
    CGFloat offset =  -offsetDig * 50/2;
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0,offset);
    _BGImageView.transform = transY;
    return offset;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    _BGImageView.selected = !selected;
}

@end

