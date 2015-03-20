//
//  LZPopAnimationView.m
//  Anmi
//
//  Created by 罗 建镇 on 15/3/20.
//  Copyright (c) 2015年 L. All rights reserved.
//

#import "LZPopAnimationView.h"

@interface LZPopAnimationView()
@property (nonatomic,strong)UIView *contentV;
@property (nonatomic,strong)UIToolbar*toolBar;
@end

@implementation LZPopAnimationView

+ (LZPopAnimationView *)addContentView:(UIView *)contentView{
    LZPopAnimationView *an = [[LZPopAnimationView alloc]initPopViewWithContentView:contentView];
    an.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0, [UIScreen mainScreen].bounds.size.height / 2.0);
    return an;
}



- (id)initPopViewWithContentView:(UIView *)contentv
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.contentV = contentv;
        self.contentV.center = self.center;
        
        /**
         类似IOS7的blur效果，我这用到了ToolBar来实现。不知道苹果是否允许这么使用。
         */
        self.toolBar = [[UIToolbar alloc]initWithFrame:self.bounds];
        self.toolBar.autoresizingMask = self.autoresizingMask;
        self.toolBar.alpha = 1.0;
        [self insertSubview:self.toolBar atIndex:0];
        [self addSubview:self.contentV];
        UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissPop)];
        [self.toolBar addGestureRecognizer:dismissTap];
        
    }
    return self;
}

- (void)dismissPop{
    CABasicAnimation *toolAlpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    toolAlpha.fromValue = [NSNumber numberWithFloat:1.0];
    toolAlpha.toValue =[NSNumber numberWithFloat:0.0];
    toolAlpha.fillMode = kCAFillModeForwards;
    toolAlpha.removedOnCompletion = NO;
    toolAlpha.duration = 0.4;
    [self.toolBar.layer addAnimation:toolAlpha forKey:@"toolOpacity"];

    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[
                            [NSValue valueWithCATransform3D:CATransform3DIdentity],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            ];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    popAnimation.delegate = self;
    popAnimation.fillMode = kCAFillModeForwards;
    popAnimation.removedOnCompletion=NO;
    [self.contentV.layer addAnimation:popAnimation forKey:nil];
    
    
}

- (void)showPop{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self insertSubview:self.toolBar atIndex:0];
    
    CABasicAnimation *toolAlpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    toolAlpha.fromValue = [NSNumber numberWithFloat:0.0];
    toolAlpha.toValue =[NSNumber numberWithFloat:1.0];
    toolAlpha.duration = 0.4;
    [self.toolBar.layer addAnimation:toolAlpha forKey:@"toolOpacity"];
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    popAnimation.removedOnCompletion=NO;
    [self.contentV.layer addAnimation:popAnimation forKey:nil];

    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.contentV removeFromSuperview];
    [self.toolBar removeFromSuperview];
    [self removeFromSuperview];
}

@end
