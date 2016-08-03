//
//  ViewController.m
//  SCWatreWave
//
//  Created by Aevit on 16/8/3.
//  Copyright © 2016年 Aevit. All rights reserved.
//

#import "ViewController.h"
#import "SCWaveView.h"
#import "SCWaveMaskView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupSCWaveView:NO];
    [self setupSCWaveView:YES];
    [self setupSCWaveMaskView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSCWaveView:(BOOL)isCircle {
    
    SCWaveView *aView = [[SCWaveView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:aView];
    aView.center = CGPointMake(self.view.center.x, self.view.center.y - (isCircle ? 0 : 150));
    aView.backgroundColor = [UIColor whiteColor];
    aView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    aView.layer.borderWidth = 1.f;
    if (isCircle) {
        aView.layer.cornerRadius = 50;
        aView.clipsToBounds = YES;
    }
    
    aView.speed = 2;
    aView.depthPercent = 0.65;
    aView.waveColor = [UIColor colorWithRed:105/255.0 green:186/255.0 blue:241/255.0 alpha:1];
    
    [aView wave];
}

- (void)setupSCWaveMaskView {
    
    SCWaveMaskView *aView = [[SCWaveMaskView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) bottomImage:[UIImage imageNamed:@"bottom"] upImage:[UIImage imageNamed:@"up"]];
    [self.view addSubview:aView];
    aView.center = CGPointMake(self.view.center.x, self.view.center.y + 150);
    aView.backgroundColor = [UIColor whiteColor];
    
    aView.speed = 3;
    aView.depthPercent = 0.42;
    
    [aView wave];
}

@end
