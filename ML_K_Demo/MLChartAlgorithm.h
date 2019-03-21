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


//#pragma mark - 《MA简单移动平均数》 处理算法
//@interface MLChartAlgorithm (ChartAlgorithm_MA)
///**
// 处理MA运算
// C:收盘价
// N:周期
// MA（N）=（C1+C2+……CN）/N
// @param num 天数
// @param datas 数据集
// @return return value description
// */
//- (NSArray<ChartItem *>*)handle_MA_WithNum:(int)num datas:(NSArray <ChartItem *>*)datas;
//@end
//
//#pragma mark - 《EMA指数移动平均数》 处理算法
//@interface MLChartAlgorithm (ChartAlgorithm_EMA)
//
///**
// 处理EMA指标
//
// @param num 周期
// @param datas 数据集
// @return 设置完成的数据集
// */
//- (NSArray<ChartItem *>*)handle_EMA_WithNum:(int)num datas:(NSArray <ChartItem *>*)datas;
//@end
//
//#pragma mark - 《时分价格》 处理算法
//@interface MLChartAlgorithm (ChartAlgorithm_TimeLine)
///**
// 处理时分价格运算
// 使用收盘价作为时分价
// 
// @param datas 数据集
// @return 返回处理后的数据集
// */
//- (NSArray<ChartItem *>*)handle_TimeLine_datas:(NSArray <ChartItem *>*)datas;
//@end
//
//#pragma mark - 《RSI》 处理算法
//@interface MLChartAlgorithm (ChartAlgorithm_RSI)
//- (NSArray<ChartItem *>*)handle_RSI_WithNum:(int)num WithDats:(NSArray <ChartItem *>*)datas;
//@end
//
//#pragma mark - 《KDJ随机指标》 处理算法
//@interface MLChartAlgorithm (ChartAlgorithm_KDJ)
//- (NSArray<ChartItem *>*)handle_KDJ_WithP1:(int)p1 P2:(int)p2 P3:(int)p3 WithDats:(NSArray <ChartItem *>*)datas;
//@end
//
//#pragma mark - 《MACD随机指标》 处理算法
//@interface MLChartAlgorithm (ChartAlgorithm_MACD)
//- (NSArray<ChartItem *>*)handle_MACD_WithP1:(int)p1 P2:(int)p2 P3:(int)p3 WithDats:(NSArray <ChartItem *>*)datas;
//@end

NS_ASSUME_NONNULL_END
