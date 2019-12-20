//
//  MRLocalizeData.m
//  MedicineReminder
//
//  Created by zhangxintao on 2019/12/19.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "MRLocalizeData.h"

@implementation MRLocalizeData

static MRLocalizeData *data = nil;

+ (instancetype)sharedData{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [self load];
        if (!data) {
            data = [[self alloc] init];
        }
    });
    return data;
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
        @"alerts":[MRAlert class],
        @"medicines":[MRMedicine class]
    };
}

- (void)save{
    if (@available(iOS 11.0, *)) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self requiringSecureCoding:YES error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:LocalStore];
    } else {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:LocalStore];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (instancetype)load{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:LocalStore];
    if (!data) {
        return nil;
    }
    
    if (@available(iOS 11.0, *)) {
        return [NSKeyedUnarchiver unarchivedObjectOfClass:[self class] fromData:data error:nil];
    } else {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
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
