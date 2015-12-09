//
//  FKGoodsCell.h
//  FKWaterflowLayoutExample
//
//  Created by frank on 15/12/9.
//  Copyright © 2015年 zmosa. All rights reserved.
//  存放商品的cell

#import <UIKit/UIKit.h>
@class FKGoods;

@interface FKGoodsCell : UICollectionViewCell
@property (nonatomic, strong) FKGoods *goods;
@end
