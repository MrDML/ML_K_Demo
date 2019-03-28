//
//  ChartModel.h
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/28.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartItem.h"
#import "MLLineChartStyle.h"


@interface TrendObj : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) BOOL isSolid;

- (instancetype)initWithColor:(UIColor *)color isSolid:(BOOL)isSolid;

@end


NS_ASSUME_NONNULL_BEGIN

@interface ChartModel : NSObject

// 升的颜色
@property (nonatomic, strong) TrendObj *upStyle;
// 跌的颜色
@property (nonatomic, strong) TrendObj *downStyle;
// 标题文本的颜色
@property (nonatomic, strong) UIColor *titleColor;
// 点 模型数组 数据值
@property (nonatomic, strong) NSArray<ChartItem *>*datas;
// 小数位长度
@property (nonatomic, assign) int decimal;
// 是否显示最大值
@property (nonatomic, assign) BOOL showMaxVal;
// 是否显示最小值
@property (nonatomic, assign) BOOL showMinVal;
// 标题
@property (nonatomic, copy) NSString *title;
// 是否使用标题颜色
@property (nonatomic, assign) BOOL useTitleColor;
// key 值 （是取出指标的关键）
@property (nonatomic, copy) NSString *key;
// 最大值最小值显示样式 默认是none
@property (nonatomic, strong) MLULtimateValueStyle *ultimateValueStyle;
// 线段宽度 默认0.6
@property (nonatomic, assign) CGFloat lineWidth;
// 点与点之间间断所占宽的比例 默认0.165
@property (nonatomic, assign) CGFloat plotPaddingExt;
// 获取指标值
- (ChartItem *)getChartItemExtval:(int)index;
@end

NS_ASSUME_NONNULL_END
