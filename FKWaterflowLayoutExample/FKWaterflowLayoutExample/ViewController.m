//
//  ViewController.m
//  FKWaterflowLayoutExample
//
//  Created by frank on 15/12/9.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "FKGoods.h"
#import "FKWaterflowLayout.h"
#import "FKGoodsCell.h"
#import "MJRefresh.h"
static NSString *const cellID = @"cell";

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, FKWaterflowLayoutDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *goodsArray;
@end

@implementation ViewController

/**
 *  懒加载
 */
- (NSMutableArray *)goodsArray
{
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化数据
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"goods.plist" ofType:nil];
    NSArray *dataArray = [FKGoods objectArrayWithFile:filePath];
    [self.goodsArray addObjectsFromArray:dataArray];
    
    // 创建布局并根据布局创建collectionView
    FKWaterflowLayout *layout = [[FKWaterflowLayout alloc] init];
    layout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[FKGoodsCell class] forCellWithReuseIdentifier:cellID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 增加刷新控件
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreGoods)];
    self.collectionView.footerRefreshingText = @"正在玩命加载中....";
}

- (void)loadMoreGoods
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"goods.plist" ofType:nil];
        NSArray *dataArray = [FKGoods objectArrayWithFile:filePath];
        [self.goodsArray addObjectsFromArray:dataArray];
        [self.collectionView reloadData];
        [self.collectionView footerEndRefreshing];
    });
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FKGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[FKGoodsCell alloc] init];
    }
    cell.goods = self.goodsArray[indexPath.item];
    return cell;
}


#pragma mark - UICollectionViewDelegate


#pragma mark - FKWaterflowLayoutDelegate

- (CGFloat)waterflowLayout:(FKWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    FKGoods *goods = self.goodsArray[indexPath.item];
    return (goods.h / goods.w) * width;
}

@end
