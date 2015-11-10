//
//  AMDetailView.m
//  Demo-PullDown Menu
//
//  Created by 刘ToTo on 15/11/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "AMDetailView.h"

@interface AMDetailView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation AMDetailView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        self.backgroundColor = [UIColor redColor];
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.rowHeight = 50;
    }
    return self;
}

- (void)setSources:(NSArray *)sources
{
    _sources = sources;
    //重写设置视图的frame
    CGRect rect = self.frame;
    rect.size.height = self.rowHeight * sources.count;
    self.frame = rect;
    //刷新
    [self reloadData];
}
#pragma mark - 数据源  《=====================    - [Amer] 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sources.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.sources[indexPath.row];
    cell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    return  cell;
}

#pragma mark - 代理方法  《=====================    - [Amer]
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@",self.sources[indexPath.row]);
    if (self.removeCallBack) {
        self.removeCallBack(self.sources[indexPath.row]);
    }
}
@end
