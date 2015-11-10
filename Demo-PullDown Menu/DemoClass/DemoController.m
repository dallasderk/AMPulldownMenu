//
//  DemoController.m
//  Demo-PullDown Menu
//
//  Created by 刘ToTo on 15/11/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "DemoController.h"
//#import "UIViewController+Extension.h"

@interface DemoController ()
@property (weak, nonatomic) IBOutlet UILabel *valuetext;

@end
@implementation DemoController
- (NSArray *)setToolMenus
{
    NSArray *arr = @[@{@"A":@[@"A--1",@"A--2",@"A--3",@"A--4"]},
                     @{@"B":@[@"B--1",@"B--2",@"B--3"]},
                     @{@"C":@[@"C--1",@"C--2",@"C--3",@"C--4",@"C--5"]}];
    return arr;
}
- (void)selectItemValue:(NSString *)value
{
    self.valuetext.text = value;
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
