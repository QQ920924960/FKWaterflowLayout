//
//  FKWaterflowLayout.m
//  FKWaterflowLayoutExample
//
//  Created by frank on 15/12/9.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "FKWaterflowLayout.h"

@interface FKWaterflowLayout ()
/** 存储每一列最大的Y值(每一列的高度) */
@property (nonatomic, strong) NSMutableDictionary *maxYDict;
/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
@end

@implementation FKWaterflowLayout

- (NSMutableDictionary *)maxYDict
{
    if (!_maxYDict) {
        _maxYDict = [NSMutableDictionary dictionary];
    }
    return _maxYDict;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

/**
 *  初始化的时候给一些默认值
 */
- (instancetype)init
{
    if (self = [super init]) {
        self.columnMargin = 10;
        self.rowMargin = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnsCount = 3;
    }
    return self;
}

/**
 *  当bounds改变的时候是否让layout失效
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  每次布局之前的准备
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 清空最大的Y值
    for (int index = 0; index < self.columnsCount; index++) {
        NSString *column = [NSString stringWithFormat:@"%d", index];
        self.maxYDict[column] = @(self.sectionInset.top);
    }
    
    // 计算所有cell的属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int index = 0; index < count; index++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}

/**
 *  返回所有的尺寸
 */
- (CGSize)collectionViewContentSize
{
    __block NSString *maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull column, NSNumber * _Nonnull maxY, BOOL * _Nonnull stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInset.bottom);
}

/**
 *  返回indexPath这个位置的Item的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 假设最短的那一列是第0列
    __block NSString *minColumn = @"0";
    // 找出最短的那一列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull column, NSNumber * _Nonnull maxY, BOOL * _Nonnull stop) {
        if ([maxY floatValue] < [self.maxYDict[minColumn] floatValue]) {
            minColumn = column;
        }
    }];
    
    // 计算尺寸
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columnsCount - 1) * self.columnMargin) / self.columnsCount;
    CGFloat height = [self.delegate waterflowLayout:self heightForWidth:width atIndexPath:indexPath];
    
    // 计算位置
    CGFloat x = self.sectionInset.left + (width + self.columnMargin) * [minColumn intValue];
    CGFloat y = [self.maxYDict[minColumn] floatValue] + self.rowMargin;
    
    // 更新这一列的最大Y值
    self.maxYDict[minColumn] = @(y + height);
    
    // 创建属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(x, y, width, height);
    return attrs;
}

/**
 *  返回rect范围内的布局属性
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

@end
