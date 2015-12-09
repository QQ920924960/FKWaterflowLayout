//
//  FKGoods.h
//  FKWaterflowLayoutExample
//
//  Created by frank on 15/12/9.
//  Copyright © 2015年 zmosa. All rights reserved.
//  商品模型

#import <UIKit/UIKit.h>

@interface FKGoods : NSObject
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *price;
@end
