//
//  SCWaveView.m
//  SCWatreWave
//
//  Created by Aevit on 16/8/3.
//  Copyright © 2016年 Aevit. All rights reserved.
//
//  正弦型函数解析式：y = a * sin(ωx + φ) + h

#import "SCWaveView.h"

@interface SCWaveView() {
    CGFloat a; // 决定峰值；这个值变化，视觉上会呈现出不同的波动速度
    BOOL toAdd; // 形成上下波动的视觉效果
    
    CGFloat offset;
    CGFloat waveWidth; // 水波的宽度（即 SCWaveView 实例对象的宽）
    CGFloat leftUpPointY; // 水波左上角的点的y值
}

//@property (nonatomic, strong) CADisplayLink *waveLink;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) CAShapeLayer *waveLayer; // 水波layer

@end

@implementation SCWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    // default value
    _speed = 2;
    _waveColor = [UIColor colorWithRed:105/255.0 green:186/255.0 blue:241/255.0 alpha:1];
    self.depthPercent = 0.65;
    
    a = 0;
    toAdd = YES;
    offset = 0;
    waveWidth = self.frame.size.width;
    leftUpPointY = 0;
    
    // wave layer
    [self.layer addSublayer:self.waveLayer];
}

- (CAShapeLayer *)waveLayer {
    if (!_waveLayer) {
        _waveLayer = [CAShapeLayer layer];
        _waveLayer.frame = self.bounds;
    }
    return _waveLayer;
}

- (void)setDepthPercent:(CGFloat)depthPercent {
    _depthPercent = depthPercent;
    
    // 通过 _depthPercent 计算
    leftUpPointY = (1 - MAX(0, MIN(1, _depthPercent))) * self.frame.size.height;
}

#pragma mark - wave and stop methods
- (void)wave {
    
    // 60帧/秒，1/60 = 0.017s就刷新一次，发现CPU会升得比较多，所以改用 NSTimer 了
//    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(doWaveAnimation:)];
//    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//    self.waveLink = link;
    
    // 每次0.05秒执行一次动画
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(doWaveAnimation:) userInfo:nil repeats:YES];
}

- (void)stop {
//    [self.waveLink invalidate];
//    self.waveLink = nil;
    
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - wave animation
- (void)doWaveAnimation:(id)sender {
    a = (toAdd ? a + 0.01 : a - 0.01);
    toAdd = (a <= 1 ? YES : (a >= 2.5 ? NO : toAdd));
    
    offset = (offset < MAXFLOAT ? offset + _speed : offset - _speed);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    [path moveToPoint:CGPointMake(0, leftUpPointY)];
    for (CGFloat x = 0.0; x < waveWidth; x++) {
        CGFloat y = 2 * a * sin(2.5 * M_PI / waveWidth * x + offset * M_PI / waveWidth) + leftUpPointY;
        [path addLineToPoint:CGPointMake(x, y)];
    }
    [path addLineToPoint:CGPointMake(waveWidth, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path closePath];
    
    _waveLayer.path = path.CGPath;
    _waveLayer.fillColor = _waveColor.CGColor;
    _waveLayer.strokeColor = _waveColor.CGColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
