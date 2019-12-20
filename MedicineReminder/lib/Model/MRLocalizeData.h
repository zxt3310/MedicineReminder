//
//  MRLocalizeData.h
//  MedicineReminder
//
//  Created by zhangxintao on 2019/12/19.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface MRLocalizeData : MRCodeBaseObj

@property NSArray <MRAlert *> *alerts;

@property NSArray <MRMedicine *> *medicines;

+ (instancetype)sharedData;

- (void)save;

+ (instancetype)load;
//读取音频文件
- (void)loadWAV;

@end

NS_ASSUME_NONNULL_END
