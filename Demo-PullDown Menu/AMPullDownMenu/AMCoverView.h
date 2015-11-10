//
//  AMCoverView.h
//  Demo-PullDown Menu
//
//  Created by 刘ToTo on 15/11/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^coverRemoveAllViews)(void);
@interface AMCoverView : UIView
/// 关闭所有视图
@property (copy, nonatomic) coverRemoveAllViews removeCallBack;
@end
