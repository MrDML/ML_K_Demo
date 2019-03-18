//
//  MLChartAlgorithm.m
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/18.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import "MLChartAlgorithm.h"


#define VA_LIST(values, array)  va_list arglist;\
                                va_start(arglist, values);\
                                id arg;\
                                while ((arg = va_arg(arglist, id))) {\
                                if ([arg isKindOfClass:[NSNumber class]] ) {\
                                [array addObject:arg];\
                                }\
                                }\
                                va_end(arglist)\


@interface MLChartAlgorithm ()
@property (nonatomic, strong) NSMutableArray *data_vals;
@property (nonatomic, assign,) ChartAlgorithmType type;
@end




@implementation MLChartAlgorithm



- (instancetype)init
{
    self = [super init];
    if (self) {
   
    }
    return self;
}
/**
 时分
 
 @return return value description
 */
- (instancetype)initWithTimeLine
{
    return [self init];
}


/**
 简单移动平均数
 
 @param value value description
 @return return value description
 */
- (instancetype)initWithMA:(NSNumber *)value
{
    self = [super init];
    if (self) {
        self.type = ChartAlgorithmType_MA;
        [self.data_vals addObject:value];
    }
    return self;
}

/**
 指数移动平均数
 
 @param value value description
 @return return value description
 */
- (instancetype)initWithEMA:(NSNumber *)value
{
    self = [super init];
    if (self) {
        self.type = ChartAlgorithmType_EMA;
        [self.data_vals addObject:value];
    }
    return self;
}

/**
 随机指标 KDJ 初始化
 
 @param values 三个参数
 @return return value description
 */
- (instancetype)initWithKDJ:(NSNumber *)values, ...
{
    
    self = [super init];
    if (self) {
        self.type = ChartAlgorithmType_KDJ;
        // 初始化数组
        self.data_vals = [NSMutableArray array];
        // 添加首个参数
        [self.data_vals addObject:values];
        // 添加后续的参数
        VA_LIST(values, self.data_vals);
        NSLog(@"==>%@",self.data_vals);
        NSAssert(self.data_vals.count == 3, @"The argv quantity needs to be equal to 3");
        
    }
    return self;
}

/**
 指数平滑异同平均线 MACD 初始化
 
 @param values 三个参数
 @return return value description
 */
- (instancetype)initWithMACD:(NSNumber *)values, ...
{
    
    self = [super init];
    if (self) {
        self.type = ChartAlgorithmType_MACD;
        // 初始化数组
        self.data_vals = [NSMutableArray array];
        // 添加首个参数
        [self.data_vals addObject:values];
        // 添加后续的参数
        VA_LIST(values, self.data_vals);
        NSLog(@"==>%@",self.data_vals);
        NSAssert(self.data_vals.count == 3, @"The argv quantity needs to be equal to 3");
        
    }
    return self;
    
}

/**
 布林线 Bool 初始化
 
 @param values 两个参数
 @return return value description
 */
- (instancetype)initWithBool:(NSNumber *)values, ...
{
    
    self = [super init];
    if (self) {
        self.type = ChartAlgorithmType_BOLL;
        // 初始化数组
        self.data_vals = [NSMutableArray array];
        // 添加首个参数
        [self.data_vals addObject:values];
        // 添加后续的参数
        VA_LIST(values, self.data_vals);
        NSLog(@"==>%@",self.data_vals);
        NSAssert(self.data_vals.count == 2, @"The argv quantity needs to be equal to 2");
        
    }
    return self;
    
}

/**
 停损转向操作点指标(判定周期，加速因子初值，加速因子最大值)
 
 @param values 三个参数
 @return return value description
 */
- (instancetype)initWithSAR:(NSNumber *)values, ...
{
    
    self = [super init];
    if (self) {
        self.type = ChartAlgorithmType_SAR;
        // 初始化数组
        self.data_vals = [NSMutableArray array];
        // 添加首个参数
        [self.data_vals addObject:values];
        // 添加后续的参数
        VA_LIST(values, self.data_vals);
        NSLog(@"==>%@",self.data_vals);
        NSAssert(self.data_vals.count == 3, @"The argv quantity needs to be equal to 3");
        
    }
    return self;
    
}

/**
 SAM指标公式
 
 @return return value description
 */
- (instancetype)initWithSAM:(NSNumber *)value
{
    self = [super init];
    if (self) {
        self.type = ChartAlgorithmType_SAM;
        [self.data_vals addObject:value];
    }
    return self;
}

/**
 RSI指标公式
 
 @return return value description
 */
- (instancetype)initWithRSI:(NSNumber *)value
{
    self = [super init];
    if (self) {
        self.type = ChartAlgorithmType_RSI;
        [self.data_vals addObject:value];
    }
    return self;
}


- (ChartItem *)handleAlgorithm:(NSArray<ChartItem *> *)datas
{
   
    return [ChartItem new];
}


@end
