
#import "RNResponsysBridge.h"
#import <PushIOManager/PushIOManager.h>

@implementation RNResponsysBridge

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

- (NSData *)dataFromHexString:(NSString *)string
{
    string = [string lowercaseString];
    NSMutableData *data= [NSMutableData new];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i = 0;
    int length = string.length;
    while (i < length-1) {
        char c = [string characterAtIndex:i++];
        if (c < '0' || (c > '9' && c < 'a') || c > 'f')
            continue;
        byte_chars[0] = c;
        byte_chars[1] = [string characterAtIndex:i++];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}

RCT_EXPORT_MODULE()

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

RCT_EXPORT_METHOD(registerUserId:(NSString *)userId) {
    [[PushIOManager sharedInstance] registerUserID:userId];
}

RCT_EXPORT_METHOD(trackEvent:(NSString *)eventName) {
    [[PushIOManager sharedInstance] trackEvent:eventName];
}

RCT_EXPORT_METHOD(setDeviceToken:(NSString *)deviceToken) {
    [[PushIOManager sharedInstance] didRegisterForRemoteNotificationsWithDeviceToken:[self dataFromHexString:deviceToken]];
}

RCT_EXPORT_METHOD(registerApp:(BOOL *)useLocation) {
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
