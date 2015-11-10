//
//  AMToolBarView.h
//  Demo-PullDown Menu
//
//  Created by 刘ToTo on 15/11/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 下拉工具条
@interface AMToolBarView: UICollectionView

/// 类型数组
@property (nonatomic, strong) NSArray *types;

+ (instancetype)sharedToolsWithTypes:(NSArray *)types
                    toViewController:(UIViewController *)blowViewController;
/// 实例方法
///
/// @param types 类型数组数据源
///
/// @return 实例对象
- (instancetype)initWithTypes:(NSArray *)types;

- (instancetype)initWithTypes:(NSArray *)types toViewController:(UIViewController*)blowViewController;

//// 将下拉工具条添加到vc
///
/// @param blowViewController 目标vc
- (void)insertToViewController:(UIViewController*)blowViewController;
/// 清除下拉菜单工具条
- (void)clearToolBar;
@end
