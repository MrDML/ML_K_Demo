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

- (instancetype)initWithTimeLine;

- (instancetype)initWithema:(int)value;

@property (nonatomic, strong) NSMutableArray *extVals;

@end

NS_ASSUME_NONNULL_END
