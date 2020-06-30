//
//  LxmTabBarVC.m
//  salaryStatus
//
//  Created by 李晓满 on 2019/1/25.
//  Copyright © 2019年 李晓满. All rights reserved.
//

#import "LxmTabBarVC.h"
#import "LxmHomeVC.h"
#import "LxmHomeSeeMoreVC.h"
#import "LxmMineVC.h"

@interface LxmTabBarVC () <UITabBarControllerDelegate>

@end

@implementation LxmTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *color = [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0];
    UIColor *color_n = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbarwhite"];
    self.tabBar.shadowImage = [UIImage new];
    self.tabBar.barTintColor = UIColor.whiteColor;
    self.tabBar.tintColor = UIColor.whiteColor;
    self.tabBar.layer.shadowColor = [CharacterDarkColor colorWithAlphaComponent:0.2].CGColor;
    self.tabBar.layer.shadowRadius = 5;
    self.tabBar.layer.shadowOpacity = 0.5;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, 0);
    self.delegate = self;
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *tabBarAppearance = [[UITabBarAppearance alloc] init];
        tabBarAppearance.backgroundImage = [UIImage imageNamed:@"tabbarwhite"];
        tabBarAppearance.shadowColor = UIColor.whiteColor;
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = @{NSForegroundColorAttributeName : color};
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = @{NSForegroundColorAttributeName : color_n};
        self.tabBar.standardAppearance = tabBarAppearance;
    }
    
    LxmHomeVC *homeVC = [[LxmHomeVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    homeVC.tabBarItem.image = [[UIImage imageNamed:@"ico_shouye_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"ico_shouye_y"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [homeVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateSelected];
    [homeVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:color_n} forState:UIControlStateNormal];
    homeVC.tabBarItem.title = @"首页";
    BaseNavigationController *nav1 = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
    
    LxmHomeSeeMoreVC *kabaoVC = [[LxmHomeSeeMoreVC alloc] init];
    kabaoVC.isTab = YES;
    kabaoVC.tabBarItem.image = [[UIImage imageNamed:@"ico_kabao_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    kabaoVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"ico_kabao_y"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [kabaoVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateSelected];
    [kabaoVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:color_n} forState:UIControlStateNormal];
    kabaoVC.tabBarItem.title = @"分类";
    BaseNavigationController *nav2 = [[BaseNavigationController alloc] initWithRootViewController:kabaoVC];
    
    LxmMineVC *mineVC = [[LxmMineVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    mineVC.tabBarItem.image = [[UIImage imageNamed:@"ico_mine_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"ico_mine_y"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [mineVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateSelected];
    [mineVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:color_n} forState:UIControlStateNormal];
    mineVC.tabBarItem.title = @"我的";
    BaseNavigationController *nav3 = [[BaseNavigationController alloc] initWithRootViewController:mineVC];
    self.viewControllers = @[nav1,nav2,nav3];
}

@end
