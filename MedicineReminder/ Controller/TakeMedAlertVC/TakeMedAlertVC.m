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
