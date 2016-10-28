//
//  TextParallaxView.m
//  视差动画
//
//  Created by 忆思梦 on 2016/10/29.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

#import "TextParallaxView.h"

@interface TextParallaxView ()
/**
 *  最外层的View
 */
@property(nonatomic,strong) UIView * outSideView;

/**
 *  最里层的View
 */
@property(nonatomic,strong) UIView * inSideView;

/**
 *  中间的View
 */
@property(nonatomic,strong) UIView * midView;

/**
 *  单个格子的高度
 */
@property(nonatomic,assign) CGFloat  height;

@end

@implementation TextParallaxView
{
    NSTimer *timer;
}

- (instancetype)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)titleArr{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _height = self.frame.size.height / titleArr.count;
        
        //添加最里层Label
        _inSideView = ([self returnLabel:@"里层" andFrame:CGRectMake(0, 0, self.frame.size.width, _height) andColor:[UIColor blueColor]]);
        [self addSubview:_inSideView];
        
        _midView = ({
            UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(0, -_height, self.frame.size.width, _height)];
            midView.backgroundColor = [UIColor whiteColor];
            //设置不显示超出的部分
            midView.clipsToBounds = YES;
            midView.userInteractionEnabled = YES;
            midView;
        });
        [self addSubview:_midView];
        
        _outSideView = ({
            UIView * labelView = [[UIView alloc]initWithFrame:CGRectMake(0, _height, _midView.frame.size.width, _midView.frame.size.height)];
            [labelView addSubview:[self returnLabel:@"外层" andFrame:CGRectMake(0, 0, self.frame.size.width, _height) andColor:[UIColor blackColor]]];
            labelView;
        });
        [_midView addSubview:_outSideView];
        
        [self startTimer];
    }
    return self;
}

- (void)move{
    if (CGRectGetMaxY(_midView.frame)<CGRectGetHeight(self.frame)) {
        CGPoint midCenter = _midView.center;
        CGPoint labelCenter = _outSideView.center;
        midCenter.y += 1;
        labelCenter.y -= 1;
        _midView.center = midCenter;
        _outSideView.center = labelCenter;
    }else{
        [self stopTimer];
        [self addSubview:_outSideView];
        _midView.frame = CGRectMake(0, -_height, self.frame.size.width, _height);
        _inSideView.frame = CGRectMake(0, _height, self.frame.size.width, _height);
        [_midView addSubview:_inSideView];
        
        UIView * tempView = _outSideView;
        _outSideView = _inSideView;
        _inSideView = tempView;
        [self bringSubviewToFront:_midView];
        [self startTimer];
    }
}

- (void)startTimer{
    if (timer) {
        [self stopTimer];
    }
    timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(move) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    [timer invalidate];
    timer = nil;
}

//自定义一个快速创建Label的方法 避免重复代码
- (UILabel *)returnLabel:(NSString *)title andFrame:(CGRect)rect andColor:(UIColor *)color{
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = color;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
