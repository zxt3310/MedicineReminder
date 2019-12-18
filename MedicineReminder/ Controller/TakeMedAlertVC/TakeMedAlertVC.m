//
//  TakeMedAlertVC.m
//  MedicineReminder
//
//  Created by 张信涛 on 2019/12/18.
//  Copyright © 2019年 张信涛. All rights reserved.
//

#import "TakeMedAlertVC.h"
#import <UserNotifications/UserNotifications.h>

@implementation TakeMedAlertVC

- (void)viewDidLoad{
    [self loadWAV];
}

- (void)alertSet{
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"测试提醒";
    content.subtitle = @"测试提醒每日吃药日程";
    content.body = @"起来起来！该吃药了！不吃药就送你去医院！";
    content.sound = [UNNotificationSound criticalSoundNamed:@"4948.wav"];
    content.badge = @1;
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.calendar = [NSCalendar currentCalendar];
    components.timeZone = [NSTimeZone localTimeZone];
    components.hour = 18;
    components.minute = 6;
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    
    UNNotificationRequest *req = [UNNotificationRequest requestWithIdentifier:@"test" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:req withCompletionHandler:^(NSError *error){
        NSLog(@"%@",error.localizedDescription);
    }];
    
}

- (void)alertDel{
    [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
        for (UNNotificationRequest *request in requests) {
            if ([request.identifier isEqualToString:@"test"]) {
                UNCalendarNotificationTrigger *trigger = (UNCalendarNotificationTrigger *) request.trigger;
                NSDate *next = trigger.nextTriggerDate;
                NSLog(@"%@",next);
//                [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[@"test"]];
//                NSLog(@"已取消");
            }
        }
    }];
}

- (void)loadWAV{
    NSString *sourceStr = [[NSBundle mainBundle] pathForResource:@"4948" ofType:@"wav"];
    if (!sourceStr) {
        NSLog(@"资源文件不存在");
        return;
    }
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *pathStr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES)[0];
    
    pathStr = [pathStr stringByAppendingPathComponent:@"Sounds"];
    
    BOOL isDirectry;
    
    BOOL exist = [manager fileExistsAtPath:pathStr isDirectory:&isDirectry];
    
    if (!exist || !isDirectry) {
        [manager createDirectoryAtPath:pathStr withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    pathStr = [pathStr stringByAppendingPathComponent:@"4948.wav"];
    
    exist = [manager fileExistsAtPath:pathStr isDirectory:&isDirectry];
    
    NSError *error;
    
    if (!exist || isDirectry) {
        [manager copyItemAtPath:sourceStr toPath:pathStr error:&error];
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }
    }
}

@end
