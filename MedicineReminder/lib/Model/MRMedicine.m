//
//  MRMedicine.m
//  MedicineReminder
//
//  Created by zhangxintao on 2019/12/19.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "MRMedicine.h"

@implementation MRCodeBaseObj

- (instancetype)initWithCoder:(NSCoder *)coder{
    return [self yy_modelInitWithCoder:coder];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [self yy_modelEncodeWithCoder:coder];
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

@end

@implementation MRMedicine


@end
