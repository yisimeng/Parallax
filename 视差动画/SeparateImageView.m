//
//  SeparateImageView.m
//  视差动画
//
//  Created by 忆思梦 on 16/3/2.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

#import "SeparateImageView.h"

@interface SeparateImageView ()

@property (nonatomic, strong) UIImageView * mainImageView;
@property (nonatomic, strong) UIImageView * topImageView;
@property (nonatomic, strong) UIImageView * bottomImageView;

@end

@implementation SeparateImageView

- (id)init{
    if ([super init]) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        _selected = NO;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        _selected = NO;
    }
    return self;
}

- (void)setBgImage:(UIImage *)BgImage{
    _BgImage = BgImage;
    
    _mainImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _mainImageView.image = [UIImage imageNamed:@"header-back"];
    _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_mainImageView];
    
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2)];
    [self addSubview:_topImageView];
    CGImageRef topImage = CGImageCreateWithImageInRect(_BgImage.CGImage, CGRectMake(0, 0, _BgImage.size.width*2, _BgImage.size.height));
    _topImageView.image = [UIImage imageWithCGImage:topImage];
    
    _bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2)];
    [self addSubview:_bottomImageView];
    CGImageRef bottomImage = CGImageCreateWithImageInRect(_BgImage.CGImage, CGRectMake(0, _BgImage.size.height, _BgImage.size.width*2, _BgImage.size.height));
    _bottomImageView.image = [UIImage imageWithCGImage:bottomImage];
}

- (void)tap:(UITapGestureRecognizer *)tap{
    if (_selected == YES) {
        [UIView animateWithDuration:0.5 animations:^{
            _topImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2);
            _bottomImageView.frame = CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2);
        }];
        _selected = NO;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _topImageView.frame = CGRectMake(0, -self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2);
            _bottomImageView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height/2);
        }];
        _selected = YES;
    }
}
- (void)setSelected:(BOOL)selected{
    _selected = selected;
    [self tap:nil];
}

@end
