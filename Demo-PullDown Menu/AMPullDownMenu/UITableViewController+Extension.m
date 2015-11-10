//
//  UIViewController+Extension.m
//  Demo-PullDown Menu
//
//  Created by 刘ToTo on 15/11/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "UITableViewController+Extension.h"
#import "AMToolBarView.h"

@interface UITableViewController ()
@end

@implementation UITableViewController (Extension)
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSArray *arr = [self setToolMenus];
    if (arr) {
        NSLog(@"clear ++%@",self);
        [[AMToolBarView sharedToolsWithTypes:arr toViewController:self] clearToolBar];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSArray *arr = [self setToolMenus];
    if (!arr) {
        NSLog(@"请设置数据源");
        return;
    }
    //1>
    [AMToolBarView sharedToolsWithTypes:arr toViewController:self];

}
/// 2 > 设置数据数组
///
/// @return 返回数据源数组
- (NSArray *)setToolMenus
{
    return nil;
}
/// 3 > 获取选择数据
///
/// @param value 选择的数据
- (void)selectItemValue:(id)value
{
    
}

@end
