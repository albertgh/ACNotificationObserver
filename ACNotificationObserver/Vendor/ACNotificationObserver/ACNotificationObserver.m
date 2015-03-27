//
//  ACNotificationObserver.m
//
//  Created by Albert Chu on 15/1/28.
//
//

#import "ACNotificationObserver.h"


typedef void (^ACNOActionBlock)(id anObject, NSDictionary *aUserInfo);


@interface ACNotificationObserver ()

@property (nonatomic, retain) NSString *notificationName;

@property (copy) ACNOActionBlock actionBlock;

@end


@implementation ACNotificationObserver

#pragma mark - Public

- (void)listenNotificationName:(NSString *)notificationName
                        object:(id)notificationSenderOrNil
               withActionBlock:(void (^)(id anObject, NSDictionary *aUserInfo))actionBlock {
    self.notificationName = notificationName;
    self.actionBlock = actionBlock;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(triggerActionBlock:)
                                                 name:notificationName
                                               object:notificationSenderOrNil];
}

#pragma mark - Private

- (void)triggerActionBlock:(id)sender {
    NSNotification *notification = (NSNotification *)sender;
    if (self.actionBlock) {
        self.actionBlock(notification.object, notification.userInfo);
    }
}

- (void)dealloc {
    if (self.notificationName) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:self.notificationName
                                                      object:nil];
    }
}

@end
