//
//  ViewController.m
//  LZPopAnimationView
//
//  Created by 罗 建镇 on 15/3/20.
//  Copyright (c) 2015年 L. All rights reserved.
//

#import "ViewController.h"
#import "LZPopAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 135);
    btn.center  = self.view.center;
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTitle:@"Pop" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showPopAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)showPopAlert{
    
    UIView *subV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 250)];
    subV.center = self.view.center;
    [subV setBackgroundColor:[UIColor blueColor]];
    subV.layer.cornerRadius = 10.0;
    
    LZPopAnimationView *pop = [LZPopAnimationView addContentView:subV];
    [pop showPop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
