//
//  AMToolBarView.m
//  Demo-PullDown Menu
//
//  Created by 刘ToTo on 15/11/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "AMToolBarView.h"
#import "AMDetailView.h"
#import "AMCoverView.h"
#import "UITableViewController+Extension.h"
#import "UIViewController+Extension.h"

/// 屏幕宽度高度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
///toolframe
#define kToolFrame CGRectMake(0, 64, kScreenWidth, 44)
/// 工具条高度
#define kToolHeight 44
/// 工具条高度
#define kToolReuseCell @"kToolReuseCell"
/// arrow宽高
#define kArrowWidth 11
#define kArrowHeight 7



#pragma mark - Layout  《=====================    - [Amer]
@interface AMLayout : UICollectionViewFlowLayout

/// item计数
@property (nonatomic, assign) CGFloat itemCount;

@end
@implementation AMLayout
- (instancetype)initWithItemCount:(NSInteger) count
{
    if (self = [super init]) {
        self.itemCount = (CGFloat)count;
    }
    return self;
}
- (void)prepareLayout
{
    self.itemSize = [self getItemSize];
    self.minimumInteritemSpacing = 1;
    self.minimumLineSpacing = 0;
}

- (CGSize)getItemSize
{
    CGFloat width = (kScreenWidth - (self.itemCount + 1)) / self.itemCount;
    return  CGSizeMake(width, kToolHeight - 2);
}
@end

#pragma mark - 自定义cell  《=====================    - [Amer]
@interface AMCollectionCell : UICollectionViewCell

/// 名称
@property (nonatomic, strong) UILabel *typeName;
/// 图片
@property (nonatomic, strong) UIImageView *arrowIcon;
/// 选中之后改变状态
- (void)didselectedWithIsDetail:(BOOL) isDetail;

@end
@implementation AMCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self addSubview:self.arrowIcon];
        [self addSubview:self.typeName];
    }
    return self;
}

- (void)didselectedWithIsDetail:(BOOL) isDetail
{
    if (isDetail) {
        self.arrowIcon.image = [UIImage imageNamed:@"buddy_header_arrow_detail"];
        self.typeName.textColor = [UIColor orangeColor];
    }else
    {
        self.arrowIcon.image = [UIImage imageNamed:@"buddy_header_arrow"];
        self.typeName.textColor = [[UIColor alloc] initWithWhite:0.5 alpha:1];
    }
    self.arrowIcon.transform = CGAffineTransformRotate(self.arrowIcon.transform, M_PI);
    
}
#pragma mark - 懒加载cell控件  《=====================    - [Amer] 
- (UILabel *)typeName
{
    if (!_typeName) {
        //计算宽高
        CGFloat height = self.bounds.size.height;
        CGFloat width = self.arrowIcon.frame.origin.x;
        
        //初始化并设置属性
        _typeName = [[UILabel alloc] initWithFrame:CGRectMake(0,0,width, height)];
        _typeName.text = @"全球直播";
        _typeName.textAlignment = NSTextAlignmentCenter;
        _typeName.font = [UIFont systemFontOfSize:16];
        _typeName.textColor = [[UIColor alloc] initWithWhite:0.5 alpha:1];
    }
    return _typeName;
}
- (UIImageView *)arrowIcon
{
    if (!_arrowIcon) {
        _arrowIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,kArrowWidth, kArrowHeight)];
        CGFloat width = self.bounds.size.width - kArrowWidth-2;
        _arrowIcon.center = CGPointMake(width, self.center.y);
        _arrowIcon.image = [UIImage imageNamed:@"buddy_header_arrow"];
    }
    return _arrowIcon;
}
@end

#pragma mark - 工具条  《=====================    - [Amer]
@interface AMToolBarView () <UICollectionViewDataSource,UICollectionViewDelegate>

/// 详情界面
@property (nonatomic, strong) AMDetailView *detailView;
/// 是否展开
@property (nonatomic, assign) BOOL isDetail;
/// 上一个展开的cell
@property (nonatomic, strong) AMCollectionCell *lastCell;
/// 工具条所属控制器
@property (nonatomic, weak) UIViewController *blowVC;
/// 遮盖视图
@property (nonatomic ,strong) AMCoverView *cover;

@end

@implementation AMToolBarView
#pragma mark - 拉拉菜单工具条的添加和清除  《=====================    - [Amer] 
- (void)insertToViewController:(UIViewController*)blowViewController
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self];
    [window bringSubviewToFront:self];
    self.blowVC = blowViewController;
    
    //判断是否有导航条
    if (!blowViewController.navigationController.navigationBar) {
        CGRect rect = self.frame;
        rect.origin.y = blowViewController.view.frame.origin.y;
        self.frame = rect;
//        [blowViewController.view addSubview:self];
    }else
    {
        self.frame = kToolFrame;
        NSInteger index =  blowViewController.navigationController.navigationBar.subviews.count;
//        [blowViewController.navigationController.navigationBar insertSubview:self atIndex:index];
    }
    self.detailView.frame = [self resetDetail];
    self.cover.frame = [self resetCover];
}

- (void)clearToolBar
{
    [self removeAllView];
    [self removeFromSuperview];
}
- (void)removeAllView
{
    [self.detailView removeFromSuperview];
    [self.cover removeFromSuperview];
    //选中条目恢复原样
    [self.lastCell didselectedWithIsDetail:!self.isDetail];
    self.lastCell = nil;
}

#pragma mark - collection初始化  《=====================    - [Amer]
static id instance;
+ (instancetype)sharedToolsWithTypes:(NSArray *)types
                    toViewController:(UIViewController *)blowViewController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithTypes:types toViewController:blowViewController];
    });
    ((AMToolBarView *)instance).collectionViewLayout =[[AMLayout alloc] initWithItemCount:types.count];
    ((AMToolBarView *)instance).types = types;
    [instance insertToViewController:blowViewController];
    return instance;
}
- (instancetype)initWithTypes:(NSArray *)types
{
    self = [super initWithFrame:kToolFrame collectionViewLayout:[[AMLayout alloc] initWithItemCount:types.count]];
    if (self) {
        self.types = types;
        [self prepareCollectionView];
        self.isDetail = YES;
    }
    return self;
}
- (instancetype)initWithTypes:(NSArray *)types toViewController:(UIViewController *)blowViewController
{
    
    if(self = [self initWithTypes:types])
    {
        [self insertToViewController:blowViewController];
    }
    return self;
}
/// 准备collectionView
- (void)prepareCollectionView
{
    self.backgroundColor = [[UIColor alloc] initWithWhite:0.85 alpha:1];
    self.contentInset = UIEdgeInsetsMake(1, 0, 1, 0);
    self.bounces = NO;
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[AMCollectionCell class] forCellWithReuseIdentifier:kToolReuseCell];
}
#pragma mark - 数据源  《=====================    - [Amer]
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.types.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AMCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kToolReuseCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSDictionary *dict = self.types[indexPath.item];
    NSString *str = [dict.allKeys lastObject];
    cell.typeName.text = str;

    return cell;
}

#pragma mark - 代理方法  《=====================    - [Amer]
/// cell被选中
///
/// @param collectionView collectionView
/// @param indexPath      cell的indexpath
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AMCollectionCell *cell = (AMCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.lastCell != cell) {
        [cell didselectedWithIsDetail:self.isDetail];
        [self.lastCell didselectedWithIsDetail:!self.isDetail];
        
        //添加详情视图
        UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
        [window addSubview:self.detailView];
        
        //提那家遮盖视图
        [window insertSubview:self.cover belowSubview:self];
        
        //拿到详情数据
        NSDictionary *dict = self.types[indexPath.item];
        NSString *str = [dict.allKeys lastObject];
        NSArray *details = dict[str];
        self.detailView.sources = details;
        
        //记录当前cell为上一个
        self.lastCell = (AMCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    }
}
#pragma mark - 懒加载数据  《=====================    - [Amer]
- (void)setTypes:(NSArray *)types
{
    _types = types;
    [self reloadData];
}
- (AMDetailView *)detailView
{
    if (!_detailView) {
        
        _detailView = [[AMDetailView alloc] initWithFrame:[self resetDetail] style:UITableViewStylePlain];
        __weak typeof(self) weakSelf = self;
        _detailView.removeCallBack = ^(id value){
            [weakSelf removeAllView];
            [weakSelf.blowVC selectItemValue:value];
        };
    }
    return _detailView;
}
- (AMCoverView *)cover
{
    if (!_cover) {
        _cover = [[AMCoverView alloc] initWithFrame:[self resetCover]];
        __weak typeof(self) weakSelf = self;
        _cover.removeCallBack = ^{[weakSelf removeAllView];};
    }
    return _cover;
}
/// 计算detailViewframe
- (CGRect)resetDetail
{
    /// tool的最大Y
    CGFloat toolMaxY = CGRectGetMaxY(self.frame);
    CGFloat height = kScreenHeight * 0.6;
    return CGRectMake(0, toolMaxY, kScreenWidth, height);
}
/// 计算coverframe
- (CGRect)resetCover
{
    CGFloat y = CGRectGetMaxY(self.frame);
    CGFloat height = kScreenHeight - y;
    //判断底部是否有TabBar
    if (self.blowVC.tabBarController.tabBar) {
        height -= self.blowVC.tabBarController.tabBar.bounds.size.height;
    }
    return CGRectMake(0, y, kScreenWidth,height);
}
@end
