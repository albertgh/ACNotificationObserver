//
//  RootViewController.m
//  ACNotificationObserver
//
//  Created by ac_mba on 15/5/16.
//  Copyright (c) 2015年 ac. All rights reserved.
//

#import "RootViewController.h"

#import "SampleViewController.h"


@interface RootViewController ()

@end


@implementation RootViewController

- (void)buttonClicked:(id)sender {
    SampleViewController *sampleVC = [[SampleViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:sampleVC animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"RootNC";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.bounds.size.width - 150.0) / 2.0, 120.0, 150.0, 40.0);
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    button.backgroundColor = [UIColor orangeColor];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"Show sample" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
}


@end
