//
//  ViewController.m
//  ACNotificationObserver
//
//  Created by ac_mba on 15/3/27.
//  Copyright (c) 2015年 ac. All rights reserved.
//

#import "ViewController.h"

#import "ACNotificationObserver.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *orientationLabel;

@property (nonatomic, strong) ACNotificationObserver *orientationChangeObserver;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    self.orientationLabel.text = @"portrait";
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.orientationLabel.text = @"landscape";
    }
    
    
    self.orientationChangeObserver = [[ACNotificationObserver alloc] init];
    [self.orientationChangeObserver
     listenNotificationName:UIApplicationWillChangeStatusBarOrientationNotification
     withActionBlock:^(id anObject, NSDictionary *aUserInfo) {
         
         NSLog(@"uuu%@", aUserInfo);

         UIInterfaceOrientation newOrientation =
         [(NSNumber *)(aUserInfo[UIApplicationStatusBarOrientationUserInfoKey]) integerValue];
         
         if (UIInterfaceOrientationIsLandscape(newOrientation)) {
             self.orientationLabel.text = @"landscape";
         }
         else {
             self.orientationLabel.text = @"portrait";
         }
         
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
