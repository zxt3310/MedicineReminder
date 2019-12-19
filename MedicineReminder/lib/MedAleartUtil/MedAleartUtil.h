//
//  MedAleartUtil.h
//  MedicineReminder
//
//  Created by zhangxintao on 2019/12/18.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    reTypeEveryday,     //每天
    reTypeEveryweek,    //每周
    reTypeEveryMonth,   //每月
    reTypeOnce          //不重复
} reType;

@interface MedAleartUtil : NSObject

/*
* 闹铃通知创建接口
* 创建本地定时通知(音乐、文字提醒)，后台唤醒App处理服药日志
* @author ZXT
* @version 1.0, 2019-12-19
* @param title 通知标题
* @param subTitle 通知副标题
* @param body 通知内容
* @param type 重复周期（每日、每周、每月）
* @param date 定制日期
* @param sound 闹铃音（文件名）默认文件 4849.wav
*/
+ (NSString *)makeReminderWithTitle:(nonnull NSString *)title
                     SubTitle:(nullable NSString *)subTitle
                         Body:(nonnull NSString *)body
                       reType:(reType) type
                         Date:(nonnull NSDate *)date
                        Sound:(nullable NSString *)sound;

/*
* 闹铃通知移除接口
* 移除本地指定通知
* @author ZXT
* @version 1.0, 2019-12-19
* @param indentifer 识别码
*/
+ (void)removeAlertWithIndentifer:(NSString *)indentifer;

/*
* 移除所有本地通知
* @author ZXT
* @version 1.0, 2019-12-19
*/
+ (void)removeAllpendingAlert;
@end

NS_ASSUME_NONNULL_END
