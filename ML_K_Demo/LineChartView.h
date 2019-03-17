//
//  LineChartView.h
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/17.
//  Copyright © 2019 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LineChartView;

@protocol LineChartViewDelegate <NSObject>
/**
 X轴的布局高度

 @param chart LineChartView *
 @return x 轴的起始高度
 */
- (CGFloat)heightForXAxisInKLineChart:(LineChartView *)chart;



@end

@interface LineChartView : UIView


/**
 视图内容的内边距
 */
@property (nonatomic, assign) UIEdgeInsets padding;


/**
 代理对象
 */
@property (nonatomic, weak) id <LineChartViewDelegate>delegate;


/**
 区数组
 */
@property (nonatomic, strong) NSMutableArray *sections;


@end

NS_ASSUME_NONNULL_END
