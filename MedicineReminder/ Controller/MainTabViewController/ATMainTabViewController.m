//
//  ATMainTabViewController.m
//  AsrTtsDemo
//
//  Created by zhangxintao on 2019/12/5.
//  Copyright © 2019 zhangxintao. All rights reserved.
//

#import "ATMainTabViewController.h"
#import "TakeMedAlertVC.h"
#import "TakeMedicienVC.h"
#import <AxcAE_TabBar.h>

@interface ATMainTabViewController()<AxcAE_TabBarDelegate>

@property AxcAE_TabBar *axcTabBar;

@end

@implementation ATMainTabViewController
{
    NSInteger lastIdx;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //构造配置字典
    NSArray <NSDictionary *> *vcDicAry = @[@{@"vc":[[TakeMedicienVC alloc] init],@"normalImg":@"med_n",@"selectImg":@"med_p",@"itemTitle":@"药品"},@{@"vc":[[UIViewController alloc] init],@"normalImg":@"add",@"selectImg":@"add",@"itemTitle":@""},@{@"vc":[[TakeMedAlertVC alloc] init],@"normalImg":@"plan_n",@"selectImg":@"plan_p",@"itemTitle":@"提醒"}];
    //构造配置模型数组
    NSMutableArray *tabBarConfs = [NSMutableArray array];
    //构造页面数组
    NSMutableArray *tabBarVCs = [NSMutableArray array];
    
    [vcDicAry enumerateObjectsUsingBlock:^(NSDictionary *obj,NSUInteger idx,BOOL *stop){
        AxcAE_TabBarConfigModel *model =[[AxcAE_TabBarConfigModel alloc] init];
        model.itemTitle = [obj objectForKey:@"itemTitle"];
        model.selectImageName = [obj objectForKey:@"selectImg"];
        model.normalImageName = [obj objectForKey:@"normalImg"];
        model.titleLabel.font = [UIFont systemFontOfSize:14];
        if (idx == 1) {
            model.bulgeStyle = AxcAE_TabBarConfigBulgeStyleCircular;
            model.itemSize = CGSizeMake(80, 80);
            model.bulgeHeight = 30;
            model.isRepeatClick = YES;
            model.interactionEffectStyle = AxcAE_TabBarInteractionEffectStyleAlpha;
        }else{
            model.interactionEffectStyle = AxcAE_TabBarInteractionEffectStyleSpring;
        }
        
        UIViewController *vc = [obj objectForKey:@"vc"];
        [tabBarVCs addObject:vc];
        [tabBarConfs addObject:model];
    }];
    
    self.viewControllers = tabBarVCs;
    self.axcTabBar = [[AxcAE_TabBar alloc] initWithTabBarConfig:tabBarConfs];
    //self.axcTabBar.tabBarConfig = tabBarConfs;
    self.axcTabBar.delegate = self;
    
    
    
    [self.tabBar addSubview:self.axcTabBar];
}

- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    if (index == 1) {
        AxcAE_TabBarItem *item = tabbar.tabBarItems[lastIdx];
        item.isSelect = YES;
        return;
    }
    [self setSelectedIndex:index];
    lastIdx = index;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.axcTabBar.frame = self.tabBar.bounds;
    [self.axcTabBar viewDidLayoutItems];
}
    
@end

@interface UITabBar(overHit)

@end

@implementation UITabBar(overHit)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    for (UIView *subView in self.subviews) {
        CGPoint myPoint = [subView convertPoint:point toView:self];
        if (myPoint.y < 0) {
            if ([subView isKindOfClass:[AxcAE_TabBar class]]) {
                for (UIView * axcTabBarItem in subView.subviews) {
                    if ([axcTabBarItem isKindOfClass:[AxcAE_TabBarItem class]]) {
                        if (CGRectContainsPoint(axcTabBarItem.frame, myPoint)) {
                            return axcTabBarItem;
                        }
                    }
                }
            }
        }
    }
    return view;
}
    
@end
