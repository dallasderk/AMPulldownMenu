//
//  AMDetailView.h
//  Demo-PullDown Menu
//
//  Created by 刘ToTo on 15/11/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^removeAllViews)(id value);
@interface AMDetailView : UITableView

/// 数据源
@property (nonatomic, strong) NSArray *sources;
/// 关闭所有视图
@property (copy, nonatomic) removeAllViews removeCallBack;
@end
