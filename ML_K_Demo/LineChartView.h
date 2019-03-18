//
//  LineChartView.h
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/17.
//  Copyright © 2019 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, YAxisShowPostion) {
    YAxisShowPostion_left,
    YAxisShowPostion_right,
    YAxisShowPostion_none
};


@class LineChartView;
@class ChartItem;

@protocol LineChartViewDelegate <NSObject>
/**
 X轴的布局高度

 @param chart LineChartView *
 @return x 轴的起始高度
 */
- (CGFloat)heightForXAxisInKLineChart:(LineChartView *)chart;


/**
 设置y轴标签的宽度

 @param chart chart description
 @return return value description
 */
- (CGFloat)widthForYAxisLabelInKLineChart:(LineChartView *)chart;


/**
 数据源的总数

 @param chart chart description
 @return return value description
 */
- (int)numberOfPointsInKLineChart:(LineChartView *)chart;



/**
 数据源索引为对应的对象

 @param chart chart description
 @param index index description
 @return return value description
 */
- (ChartItem *)lineChart:(LineChartView *)chart vlaueForPointAtIndex:(int)index;



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

/**
 设置y轴标签的宽度
 */
@property (nonatomic, assign) CGFloat yAxisLabelWidth;

/**
 y 轴显示的位置， 默认显示在右侧
 */
@property (nonatomic, assign) YAxisShowPostion showYAxisLabel;


/**
 是否把y坐标内嵌到图标中， 默认是NO
 */
@property (nonatomic, assign, getter=isInnerYAxis) BOOL innerYAxis;


/**
 把X轴坐标内容显示到那个索引分区上， 默认是-1， 标识最后一个， 如果用户设置溢出的数值，也是最后一个
 */
@property (nonatomic, assign) int showXAxisOnSectionIndex;


@end

NS_ASSUME_NONNULL_END
