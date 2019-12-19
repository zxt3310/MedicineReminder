//
//  MedAleartUtil.m
//  MedicineReminder
//
//  Created by zhangxintao on 2019/12/18.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "MedAleartUtil.h"
#import <UserNotifications/UserNotifications.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
// 这部分使用到的过期api
@implementation MedAleartUtil

+ (NSString *)makeReminderWithTitle:(nonnull NSString *)title
                     SubTitle:(nullable NSString *)subTitle
                         Body:(nonnull NSString *)body
                       reType:(reType) type
                         Date:(nonnull NSDate *)date
                        Sound:(nullable NSString *)sound{
    
    NSCalendarUnit unit;
    BOOL repeat = YES;
    switch (type) {
        case reTypeEveryday:
            unit = NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitSecond;
            break;
        case reTypeEveryweek:
            unit = NSCalendarUnitWeekday | NSCalendarUnitMinute |NSCalendarUnitHour | NSCalendarUnitSecond;
        break;
        case reTypeEveryMonth:
            unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        break;
        default:
            unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            repeat = NO;
            break;
    }
    
    NSTimeInterval interval = [date timeIntervalSince1970];
    NSString *indentifer = [NSString stringWithFormat:@"%ld",(long)interval];
    
    if (@available(iOS 10, *)){
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = title;
        content.subtitle = subTitle;
        content.body = body;
        content.launchImageName = @"med_p";
        if (@available(iOS 12, *)) {
            content.sound = [UNNotificationSound criticalSoundNamed:sound?sound:@"4948.wav"];
        }else{
            content.sound = [UNNotificationSound soundNamed:sound?sound:@"4948.wav"];
        }
        NSDateComponents *components = [[NSCalendar currentCalendar] components:unit fromDate:date];
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:repeat];
        
        UNNotificationRequest *req = [UNNotificationRequest requestWithIdentifier:indentifer content:content trigger:trigger];
        
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:req withCompletionHandler:^(NSError *error){
            NSLog(@"%@",error.localizedDescription);
        }];
    }else{
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = date;
        notification.timeZone = [NSTimeZone localTimeZone];
        
        switch (type) {
            case reTypeEveryday:
                notification.repeatInterval = kCFCalendarUnitDay;
                break;
            case reTypeEveryweek:
                notification.repeatInterval = kCFCalendarUnitWeekday;
            break;
            case reTypeEveryMonth:
                notification.repeatInterval = kCFCalendarUnitMonth;
            break;
            default:
                notification.repeatInterval = 0;
                break;
        }
        notification.alertTitle = title;
        notification.alertBody = body;
        notification.soundName = KIsBlankString(sound)?sound:@"";
        NSDictionary *userDic = [NSDictionary dictionaryWithObject:indentifer forKey:@"key"];
        notification.userInfo = userDic;
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    
    
    return indentifer;
}

+ (void)removeAlertWithIndentifer:(NSString *)indentifer{
    if (@available(iOS 10, *)){
        [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
            for (UNNotificationRequest *request in requests) {
                if ([request.identifier isEqualToString:indentifer]) {
                    UNCalendarNotificationTrigger *trigger = (UNCalendarNotificationTrigger *) request.trigger;
                    NSDate *next = trigger.nextTriggerDate;
                    NSLog(@"%@",next);
                    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[indentifer]];
                    NSLog(@"已取消");
                }
            }
        }];
    }else{
        //设置取消本地推送
        //获取所有本地通知数组
       NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
       
       for (UILocalNotification *notification in localNotifications) {
           NSDictionary *userInfo = notification.userInfo;
           if (userInfo) {
               // 根据设置通知参数时指定的key来获取通知参数，这个key要和你设置的保持一致
               NSString *info = userInfo[@"key"];
               // 如果找到需要取消的通知，则取消
               if ([info isEqualToString:indentifer]) {
                   [[UIApplication sharedApplication] cancelLocalNotification:notification];
                   break;
               }
           }
       }
    }
}

+ (void)removeAllpendingAlert{
    if (@available(iOS 10, *)){
        [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    }else{
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}
@end
