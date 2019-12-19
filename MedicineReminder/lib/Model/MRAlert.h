//
//  MRAlert.h
//  MedicineReminder
//
//  Created by zhangxintao on 2019/12/19.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRMedicine.h"

NS_ASSUME_NONNULL_BEGIN

@interface MRAlert : NSObject <YYModel>

@property NSString *title;

@property NSArray <MRMedicine *> *meds;

@property NSString *indentifier;

@property NSInteger hour;

@property NSInteger minite;

@property NSInteger repeatType; //0每天 1每周 2每月 3不重复


@end

NS_ASSUME_NONNULL_END
