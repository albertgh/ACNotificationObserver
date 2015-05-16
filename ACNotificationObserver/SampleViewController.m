//
//  SampleViewController.m
//  ACNotificationObserver
//
//  Created by ac_mba on 15/5/16.
//  Copyright (c) 2015年 ac. All rights reserved.
//

#import "SampleViewController.h"

#import "ACNotificationObserver.h"


@interface SampleViewController ()

@property (nonatomic, strong)   UILabel                     *orientationLabel;

@property (nonatomic, strong)   ACNotificationObserver      *orientationChangeObserver;

@end


@implementation SampleViewController


- (void)dealloc {
    NSLog(@"SampleVC dealloc call");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"SampleVC";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self ac_initializeSubviews];

    [self addOrientationChangeNotificationObserver];
}

- (void)ac_initializeSubviews {
    self.orientationLabel =
    [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 150.0) / 2.0,
                                              220.0,
                                              150.0,
                                              40.0)];
    self.orientationLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.orientationLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.orientationLabel];
    
    // initial text value
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    self.orientationLabel.text = @"portrait";
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.orientationLabel.text = @"landscape";
    }
}

- (void)addOrientationChangeNotificationObserver {
    __weak __typeof(self)weakSelf = self;
    self.orientationChangeObserver = [[ACNotificationObserver alloc] init];
    [self.orientationChangeObserver
     listenNotificationName:UIApplicationWillChangeStatusBarOrientationNotification
     withActionBlock:^(id anObject, NSDictionary *aUserInfo) {
         __strong __typeof(weakSelf)strongSelf = weakSelf;
         [strongSelf orientationChangeActionWith:aUserInfo];
     }];
}

- (void)orientationChangeActionWith:(NSDictionary *)aUserInfo {
    NSLog(@"aUserInfo: %@", aUserInfo);
    
    UIInterfaceOrientation newOrientation =
    [(NSNumber *)(aUserInfo[UIApplicationStatusBarOrientationUserInfoKey]) integerValue];
    
    if (UIInterfaceOrientationIsLandscape(newOrientation)) {
        self.orientationLabel.text = @"landscape";
    }
    else {
        self.orientationLabel.text = @"portrait";
    }
}

@end
