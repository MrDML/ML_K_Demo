//
//  MLChartAlgorithm.h
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/18.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import "ChartAlgorithm.h"

typedef NS_ENUM(NSInteger, ChartAlgorithmType)
{
    ChartAlgorithmType_NONE = 0,
    ChartAlgorithmType_TimeLine,
    ChartAlgorithmType_MA,
    ChartAlgorithmType_EMA,
    ChartAlgorithmType_KDJ,
    ChartAlgorithmType_MACD,
    ChartAlgorithmType_BOLL,
    ChartAlgorithmType_SAR,
    ChartAlgorithmType_SAM,
    ChartAlgorithmType_RSI,
};

NS_ASSUME_NONNULL_BEGIN

@interface MLChartAlgorithm : ChartAlgorithm

- (instancetype)init;
/**
 时分

 @return return value description
 */
- (instancetype)initWithTimeLine;

/**
 简单移动平均数

 @param value value description
 @return return value description
 */
- (instancetype)initWithMA:(NSNumber *)value;

/**
 指数移动平均数

 @param value value description
 @return return value description
 */
- (instancetype)initWithEMA:(NSNumber *)value;

/**
 随机指标 KDJ 初始化 ps:(三个参数)

 @param values 三个参数
 @return return value description
 */
- (instancetype)initWithKDJ:(NSNumber *)values, ... NS_REQUIRES_NIL_TERMINATION;

/**
 指数平滑异同平均线 MACD 初始化 ps:(三个参数)

 @param values 三个参数
 @return return value description
 */
- (instancetype)initWithMACD:(NSNumber *)values, ... NS_REQUIRES_NIL_TERMINATION;

/**
  布林线 Bool 初始化 ps:(两个参数)

 @param values 两个参数
 @return return value description
 */
- (instancetype)initWithBool:(NSNumber *)values, ... NS_REQUIRES_NIL_TERMINATION;

/**
 停损转向操作点指标(判定周期，加速因子初值，加速因子最大值) ps:(三个参数)

 @param values 三个参数
 @return return value description
 */
- (instancetype)initWithSAR:(NSNumber *)values, ... NS_REQUIRES_NIL_TERMINATION;

/**
 SAM指标公式

 @return return value description
 */
- (instancetype)initWithSAM:(NSNumber *)value;

/**
 RSI指标公式

 @return return value description
 */
- (instancetype)initWithRSI:(NSNumber *)value;


/**
 类型
 */
@property (nonatomic, assign, readonly) ChartAlgorithmType type;

@end

NS_ASSUME_NONNULL_END
