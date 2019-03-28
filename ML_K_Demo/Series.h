//
//  Series.h
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/28.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartModel.h"

/// 线段组
/// 在图表中一个要显示的“线段”都是以一个CHSeries进行封装。
/// 蜡烛图线段：包含一个蜡烛图点线模型（CHCandleModel）
/// 时分线段：包含一个线点线模型（CHLineModel）
/// 交易量线段：包含一个交易量点线模型（CHColumnModel）
/// MA/EMA线段：包含一个线点线模型（CHLineModel）
/// KDJ线段：包含3个线点线模型（CHLineModel），3个点线的数值根据KDJ指标算法计算所得
/// MACD线段：包含2个线点线模型（CHLineModel），1个条形点线模型
NS_ASSUME_NONNULL_BEGIN

@interface Series : NSObject
// 可以值
@property (nonatomic, copy) NSString *key;
// 标题
@property (nonatomic, copy) NSString *title;
// 点线模型数组
@property (nonatomic, strong) NSArray<ChartModel *>*chartModels;
// 是否隐藏
@property (nonatomic, assign) BOOL hidden;
// 是否显示标题文本
@property (nonatomic, assign) BOOL showTitle;
// 是否以固定基值显示最小或最大值， 若超出范围
@property (nonatomic, assign) BOOL baseValueSticky;
// 是否以固定的基值为中位数，对称显示最大值最小值
@property (nonatomic, assign) BOOL symmetrical;




@end

NS_ASSUME_NONNULL_END
