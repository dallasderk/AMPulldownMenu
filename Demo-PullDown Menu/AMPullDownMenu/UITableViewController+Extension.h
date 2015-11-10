//
//  UIViewController+Extension.h
//  Demo-PullDown Menu
//
//  Created by 刘ToTo on 15/11/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

///控制器不可见消息
#define kControllerDisapearNotify @"kControllerDisapearNotify"

@interface UITableViewController (Extension)
/// 设置下拉列表的数据
///
/// @return 返回数据数组
- (NSArray *)setToolMenus;
/// 获取下拉列表的结果
///
/// @param value 选择的结果
- (void)selectItemValue:(id)value;
@end
