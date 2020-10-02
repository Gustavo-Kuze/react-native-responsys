
#import "RNResponsysBridge.h"
#import <PushIOManager/PushIOManager.h>

@implementation RNResponsysBridge

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

+ (void)didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
  [[PushIOManager sharedInstance] didRegisterUserNotificationSettings:notificationSettings];
}

+ (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
  [[PushIOManager sharedInstance] didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

+ (void)didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(RNCRemoteNotificationCallback)completionHandler
{
  [[PushIOManager sharedInstance] didReceiveRemoteNotification:userInfo fetchCompletionResult:UIBackgroundFetchResultNewData fetchCompletionHandler:completionHandler];
}

+ (void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
  [[PushIOManager sharedInstance] didFailToRegisterForRemoteNotificationsWithError:error];
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(registerUserId:(NSString *)userId) {
    [[PushIOManager sharedInstance] registerUserID:userId];
}

RCT_EXPORT_METHOD(trackEvent:(NSString *)eventName) {
    [[PushIOManager sharedInstance] trackEvent:eventName];
}

RCT_EXPORT_METHOD(setDeviceToken:(NSString *)deviceToken) {
    [[PushIOManager sharedInstance] didRegisterForRemoteNotificationsWithDeviceToken:[deviceToken dataUsingEncoding:NSUTF8StringEncoding]];
}

RCT_EXPORT_METHOD(registerApp:(bool *)useLocation) {
    [[PushIOManager sharedInstance] configureWithFileName:@"pushio_config.json" completionHandler:^(NSError *error, NSString *response) {
        if(error != nil) {
            NSLog(@"PushIO - Unable to configure SDK, reason: %@", error.description);
            return;
        }
    }];
}

RCT_EXPORT_METHOD(getDeviceId:(RCTResponseSenderBlock)callback) {
    NSString *deviceID =  [[PushIOManager sharedInstance] getDeviceID];
    callback(@[[NSNull null], deviceID]);
}

RCT_EXPORT_METHOD(getUserId:(RCTResponseSenderBlock)callback) {
    NSString *userID =  [[PushIOManager sharedInstance] getUserID];
    callback(@[[NSNull null], userID]);
}

@end
