//
//  AMPullDownView.m
//  Demo-PullDown Menu
//
//  Created by 刘ToTo on 15/11/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "AMPullDownView.h"


@interface AMPullDownView ()
/// 数据源
@property (nonatomic, strong) NSMutableArray *array;
@end
@implementation AMPullDownView

- (void)viewDidLoad
{
    self.tableView.bounces = NO;
//    [self.array addObject:@"   "];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.array addObject:@"   "];
}
- (NSArray *)setToolMenus
{
//    NSString *path =[[NSBundle mainBundle] pathForResource:@"source.plist" ofType:nil];
//    return  [NSArray arrayWithContentsOfFile:path];
    
    NSArray *arr = @[@{@"山东":@[@"济南",@"菏泽",@"青岛",@"泰安"]},
  @{@"江苏":@[@"无锡",@"常州",@"江阴"]},
  @{@"山西":@[@"大同",@"太原",@"阳泉",@"运城",@"临汾"]}];
    return arr;
}
- (void)selectItemValue:(NSString *)value
{
    NSLog(@"%@",value);
    [self.array addObject:value];
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.array[indexPath.row];
    cell.backgroundColor = [UIColor orangeColor];
    return  cell;
}

- (NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
@end
