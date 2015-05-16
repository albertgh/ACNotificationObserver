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
    
    
    
    // testing ActionBlock
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]
         postNotificationName:UIApplicationWillChangeStatusBarOrientationNotification
         object:@"object"
         userInfo:@{@"userInfoK":@"userInfoV"}];
    });
    
    
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
    self.orientationLabel.text = @"";
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        self.orientationLabel.text = @"portrait";
    }
    else if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.orientationLabel.text = @"landscape";
    }
    else {
        self.orientationLabel.text = @"unknow orientation";
    }
}

- (void)addOrientationChangeNotificationObserver {
    __weak __typeof(self)weakSelf = self;
    self.orientationChangeObserver = [[ACNotificationObserver alloc] init];
    [self.orientationChangeObserver
     listenNotificationName:UIApplicationWillChangeStatusBarOrientationNotification
     withActionBlock:^(id anObject, NSDictionary *aUserInfo) {
         NSLog(@"anObject: %@", anObject);
         NSLog(@"aUserInfo: %@", aUserInfo);

         __strong __typeof(weakSelf)strongSelf = weakSelf;
         [strongSelf orientationChangeActionWith:aUserInfo];
     }];
}

- (void)orientationChangeActionWith:(NSDictionary *)aUserInfo {
    UIInterfaceOrientation newOrientation =
    [(NSNumber *)(aUserInfo[UIApplicationStatusBarOrientationUserInfoKey]) integerValue];
    
    if (UIInterfaceOrientationIsPortrait(newOrientation)) {
        self.orientationLabel.text = @"portrait";
    }
    else if(UIInterfaceOrientationIsLandscape(newOrientation)) {
        self.orientationLabel.text = @"landscape";
    }
    else {
        self.orientationLabel.text = @"unknow orientation";
    }
}

@end
