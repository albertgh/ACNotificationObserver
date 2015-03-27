//
//  ACNotificationObserver.h
//
//  Created by Albert Chu on 15/1/28.
//
//

#import <Foundation/Foundation.h>

@interface ACNotificationObserver : NSObject

- (void)listenNotificationName:(NSString *)notificationName
               withActionBlock:(void (^)(id anObject, NSDictionary *aUserInfo))actionBlock;

@end
