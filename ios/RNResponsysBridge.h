
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif
#import <UIKit/UIKit.h>

@interface RNResponsysBridge : NSObject <RCTBridgeModule>

typedef void (^RNCRemoteNotificationCallback)(UIBackgroundFetchResult result);

+ (void)didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings;
+ (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
+ (void)didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(RNCRemoteNotificationCallback)completionHandler;
+ (void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

@end
