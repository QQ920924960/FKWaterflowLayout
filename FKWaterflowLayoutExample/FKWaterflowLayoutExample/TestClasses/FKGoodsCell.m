//
//  FKGoodsCell.m
//  FKWaterflowLayoutExample
//
//  Created by frank on 15/12/9.
//  Copyright © 2015年 zmosa. All rights reserved.
//  存放商品的cell

#import "FKGoodsCell.h"
#import "FKGoods.h"
#import "UIImageView+WebCache.h"

@interface FKGoodsCell ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *priceLabel;
@end

@implementation FKGoodsCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *priceLable = [[UILabel alloc] init];
        priceLable.textAlignment = NSTextAlignmentCenter;
        priceLable.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        priceLable.textColor = [UIColor whiteColor];
        [self.contentView addSubview:priceLable];
        self.priceLabel = priceLable;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    CGFloat priceLabelH = 30;
    CGFloat priceLabelY = self.frame.size.height - priceLabelH;
    self.priceLabel.frame = CGRectMake(0, priceLabelY, self.frame.size.width, priceLabelH);
}

- (void)setGoods:(FKGoods *)goods
{
    _goods = goods;
    
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:goods.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    // 价格
    self.priceLabel.text = goods.price;
}

@end
