//
//  SCWaveView.h
//  SCWatreWave
//
//  Created by Aevit on 16/8/3.
//  Copyright © 2016年 Aevit. All rights reserved.
//
//  正弦型函数解析式：y = a * sin(ωx + φ) + h

#import <UIKit/UIKit.h>

@interface SCWaveView : UIView

/**
 *  水波速度，值越大，速度越快
 */
@property (nonatomic, assign) CGFloat speed;

/**
 *  水波的深度，占当前view的百分比，值在 0 - 1 之间
 */
@property (nonatomic, assign) CGFloat depthPercent;

/**
 *  水波的颜色
 */
@property (nonatomic, strong) UIColor *waveColor;


/**
 *  开始波动
 */
- (void)wave;

/**
 *  停止波动
 */
- (void)stop;

@end
