//
//  ChartItem.h
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/18.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NormModel.h"
NS_ASSUME_NONNULL_BEGIN


/**
 趋势类型

 - ChartItemTrend_UP: 上升趋势
 - ChartItemTrend_DOWN: 下降趋势
 - ChartItemTrend_EQUAL: 相等
 */
typedef NS_ENUM(NSInteger, ChartItemTrend) {
    ChartItemTrend_UP,
    ChartItemTrend_DOWN,
    ChartItemTrend_EQUAL
};

/**
 数据元素
 */
@interface ChartItem : NSObject

/**
 时间
 */
@property (nonatomic, assign) int time;

/**
 开盘价
 */
@property (nonatomic, assign) CGFloat openPrice;

/**
 收盘价
 */
@property (nonatomic, assign) CGFloat closePrice;

/**
 最低价
 */
@property (nonatomic, assign) CGFloat lowPrice;

/**
 最高价
 */
@property (nonatomic, assign) CGFloat highPrice;


/**
 交易量
 */
@property (nonatomic, assign) CGFloat vol;

/**
 各项指标值(下个属性字典中的值)
 */
@property (nonatomic, assign) CGFloat value;


/**
 技术指标值
 */
@property (nonatomic, strong) NSMutableDictionary *extVal;

/**
 技术指标值模型
 */
@property (nonatomic, strong) NormModel *norm;

/**
 趋势类型
 */
@property (nonatomic, assign) ChartItemTrend trend;


@end

NS_ASSUME_NONNULL_END
