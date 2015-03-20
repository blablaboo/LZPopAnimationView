//
//  LZPopAnimationView.h
//  Anmi
//
//  Created by 罗 建镇 on 15/3/20.
//  Copyright (c) 2015年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZPopAnimationView : UIView

/**
 *  pop类方法，将需要显示的view加入到动画中
 *
 *  @param contentView 子view
 *
 *  @return
 */
+ (LZPopAnimationView *)addContentView:(UIView *)contentView;

/**
 *  显示pop动画
 */
- (void)showPop;

@end
