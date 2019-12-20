//
//  MRMedicineAddVC.m
//  MedicineReminder
//
//  Created by zhangxintao on 2019/12/20.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "MRMedicineAddVC.h"
const NSArray * unitAry;

@implementation MRMedicineAddVC
{
    UITextField *medComNameTF;
    UITextField *medProNameTF;
    UITextField *companyTF;
    UITextField *funcTF;
    UITextField *unitTF;
    UITextField *doseTF;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        unitAry = @[@"mg",@"g",@"片",@"粒",@"袋",@"ml",@"滴"];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
}

- (void)confirm{
    
}

@end
