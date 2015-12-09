//
//  FKWaterflowLayout.h
//  FKWaterflowLayoutExample
//
//  Created by frank on 15/12/9.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FKWaterflowLayout;

@protocol FKWaterflowLayoutDelegate <NSObject>
- (CGFloat)waterflowLayout:(FKWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;
@end

@interface FKWaterflowLayout : UICollectionViewLayout

@property (nonatomic, assign) UIEdgeInsets sectionInset;
/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 显示多少列 */
@property (nonatomic, assign) int columnsCount;

@property (nonatomic, weak) id<FKWaterflowLayoutDelegate> delegate;

@end
