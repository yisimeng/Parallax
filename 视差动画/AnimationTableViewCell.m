//
//  AnimationTableViewCell.m
//  视差动画
//
//  Created by 忆思梦 on 16/3/3.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

#import "AnimationTableViewCell.h"

@interface AnimationTableViewCell ()

@property (nonatomic, strong) UIImageView * BGImageView;
@property (nonatomic, strong) UILabel * text;
@property (nonatomic, strong) UIView * maskView;
@property (nonatomic, assign) BOOL isHide;

@property (nonatomic, strong) UIImageView * mainImageView;
@property (nonatomic, strong) UIImageView * topImageView;
@property (nonatomic, strong) UIImageView * bottomImageView;


@property (nonatomic, strong) UIView * view;
@end

@implementation AnimationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialization];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)initialization{
    
    _BGImageView = [[UIImageView alloc] init];
    _BGImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView  addSubview:_BGImageView];

    _view = [[UIView alloc] init];
    _view.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_view];
    
    _topImageView = [[UIImageView alloc] init];
    [_view addSubview:_topImageView];
    
    _bottomImageView = [[UIImageView alloc] init];
    [_view addSubview:_bottomImageView];
    
//    _maskView = [[UIView alloc] init];
//    _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
//    _maskView.userInteractionEnabled = NO;
//    [self.contentView addSubview:_maskView];
    
    _text = [[UILabel alloc]init];
    _text.textColor = [UIColor whiteColor];
    
    _text.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_text];
}

- (void)configWithDic:(NSDictionary *)dic{
    UIImage * image = [UIImage imageNamed:@"cell"];
    _BGImageView.image = [UIImage imageNamed:@"header-back"];
    _text.text = @"忆思梦吧";
    
    CGImageRef topImage = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, image.size.width*2, image.size.height));
    _topImageView.image = [UIImage imageWithCGImage:topImage];
    
    CGImageRef bottomImage = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, image.size.height, image.size.width*2, image.size.height));
    _bottomImageView.image = [UIImage imageWithCGImage:bottomImage];
    
    [_text sizeToFit];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _BGImageView.frame = CGRectMake(0, -25, kWidth, self.bounds.size.height+50);
    _BGImageView.center = CGPointMake(kWidth/2, self.bounds.size.height/2);
    
    _view.frame = CGRectMake(0, 0, kWidth, self.bounds.size.height);
    
    _maskView.frame = CGRectMake(0, 0, kWidth, self.bounds.size.height);
    _text.center = CGPointMake(kWidth/2, self.bounds.size.height/2);
}

- (CGFloat)cellOffset {
    CGRect centerToWindow = [self convertRect:self.bounds toView:self.window];
    CGFloat centerY = CGRectGetMidY(centerToWindow);
    CGPoint windowCenter = self.superview.center;
    CGFloat cellOffsetY = centerY - windowCenter.y;
    CGFloat offsetDig =  cellOffsetY / self.superview.frame.size.height;
    CGFloat offset =  -offsetDig * 50/2;
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0,offset);
//    _BGImageView.transform = transY;
    _view.transform = transY;
//    _topImageView.transform = CGAffineTransformMakeTranslation(0,offset);
//    _bottomImageView.transform = CGAffineTransformMakeTranslation(0,offset);
    return offset;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (!selected) {
        [UIView animateWithDuration:0.5 animations:^{
            _topImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/2);
            _bottomImageView.frame = CGRectMake(0, self.bounds.size.height/2, self.bounds.size.width, self.bounds.size.height/2);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _topImageView.frame = CGRectMake(0, -self.bounds.size.height/2, self.bounds.size.width, self.bounds.size.height/2);
            _bottomImageView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height/2);
        }];
    }
}

@end
