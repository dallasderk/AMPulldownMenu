//
//  UIViewController+Extension.m
//  Demo-PullDown Menu
//
//  Created by 刘ToTo on 15/11/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "AMToolBarView.h"

@implementation UIViewController (Extension)

- (void)viewWillDisappear:(BOOL)animated
{
    NSArray *arr = [self setToolMenus];
    if (arr) {
        NSLog(@"clear ++%@",self);
        [[AMToolBarView sharedToolsWithTypes:arr toViewController:self] clearToolBar];
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    NSArray *arr = [self setToolMenus];
    if (!arr) {
        NSLog(@"请设置数据源 ++%@",self);
        
        return;
    }
    
     [AMToolBarView sharedToolsWithTypes:arr toViewController:self];
}
- (void)selectItemValue:(id)value
{
    
}
- (NSArray *)setToolMenus
{
    return nil;
}

@end
