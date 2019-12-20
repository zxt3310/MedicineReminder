//
//  MRMedicine.h
//  MedicineReminder
//
//  Created by zhangxintao on 2019/12/19.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface MRCodeBaseObj : NSObject <YYModel,NSSecureCoding>

@end

@interface MRMedicine : MRCodeBaseObj

@property NSString *com_name;
@property NSString *pro_name;
@property NSString *function;
@property NSString *unit;
@property float dose;
@property NSString *supplier;

@end

NS_ASSUME_NONNULL_END
