//
//  MLChartAlgorithm.m
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/18.
//  Copyright © 2019年 ML Day. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MLChartAlgorithm.h"
#import "MLChartConst.h"



#define VA_LIST(values, array)  va_list arglist;\
                                va_start(arglist, values);\
                                id arg;\
                                while ((arg = va_arg(arglist, id))) {\
                                if ([arg isKindOfClass:[NSNumber class]] ) {\
                                [array addObject:arg];\
                                }\
                                }\
                                va_end(arglist)\



#pragma mark - MLChartAlgorithm
@interface MLChartAlgorithm ()
@property (nonatomic, strong) NSMutableArray *data_vals;
@property (nonatomic, assign) ChartAlgorithmType type;
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
        NSAssert(value != nil, @"Pass in at least one parameter");
       
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
         NSAssert(value != nil, @"Pass in at least one parameter");
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
         NSAssert(values != nil, @"Pass in at least one parameter");
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
         NSAssert(values != nil, @"Pass in at least one parameter");
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
        NSAssert(values != nil, @"Pass in at least one parameter");
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
        NSAssert(values != nil, @"Pass in at least one parameter");
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
        NSAssert(value != nil, @"Pass in at least one parameter");
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
         NSAssert(value != nil, @"Pass in at least one parameter");
        self.type = ChartAlgorithmType_RSI;
        [self.data_vals addObject:value];
    }
    return self;
}



// 私有方法
/**
 根据name组装key

 @param name name
 @return 组装完成的key
 */
- (NSString *)getKeyWithName:(NSString *)name
{
    NSString *result = nil;
    switch (self.type) {
        case ChartAlgorithmType_NONE:
            
            break;
        case ChartAlgorithmType_TimeLine:
            result = [NSString stringWithFormat:@"%@_%@",MLSeries_Timeline,name];
            
            break;
        case ChartAlgorithmType_MA:
          
             result = [NSString stringWithFormat:@"%@_%@_%@",MLSeries_MA,[self.data_vals firstObject],name];
            break;
        case ChartAlgorithmType_EMA:
             result = [NSString stringWithFormat:@"%@_%@_%@",MLSeries_EMA,[self.data_vals firstObject],name];
            break;
        case ChartAlgorithmType_KDJ:
            result = [NSString stringWithFormat:@"%@_%@",MLSeries_KDJ,name];
            break;
        case ChartAlgorithmType_MACD:
            result = [NSString stringWithFormat:@"%@_%@",MLSeries_MACD,name];
            break;
        case ChartAlgorithmType_BOLL:
            result = [NSString stringWithFormat:@"%@_%@",MLSeries_BOLL,name];
            break;
        case ChartAlgorithmType_SAR:
            result = [NSString stringWithFormat:@"%@%@",MLSeries_SAR,name];
            break;
        case ChartAlgorithmType_SAM:
             result = [NSString stringWithFormat:@"%@_%@_%@",MLSeries_SAM,[self.data_vals firstObject],name];
            break;
        case ChartAlgorithmType_RSI:
            result = [NSString stringWithFormat:@"%@_%@_%@",MLSeries_RSI,[self.data_vals firstObject],name];
            break;
            
        default:
            break;
    }
    
    
    return result;
}




- (NSArray<ChartItem *> *)handleAlgorithm:(NSArray<ChartItem *> *)datas
{
    switch (self.type) {
        case ChartAlgorithmType_NONE:
           
            break;
        case ChartAlgorithmType_TimeLine:
            return  [self handle_TimeLine_datas:datas];
            break;
        case ChartAlgorithmType_MA:
            return  [self handle_MA_WithNum:[[self.data_vals firstObject] intValue] datas:datas];
            break;
        case ChartAlgorithmType_EMA:
            return  [self handle_EMA_WithNum:[[self.data_vals firstObject] intValue] datas:datas];
            break;
        case ChartAlgorithmType_KDJ:
            
            break;
        case ChartAlgorithmType_MACD:
            
            break;
        case ChartAlgorithmType_BOLL:
            
            break;
        case ChartAlgorithmType_SAR:
            
            break;
        case ChartAlgorithmType_SAM:
            
            break;
        case ChartAlgorithmType_RSI:

            break;
            
        default:
            break;
    }
   

    return nil;
}

@end

#pragma mark - 《时分价格》 处理算法
@implementation MLChartAlgorithm (ChartAlgorithm_TimeLine)
/**
 处理时分价格运算
 使用收盘价作为时分价

 @param datas 数据集
 @return 返回处理后的数据集
 */
- (NSArray<ChartItem *>*)handle_TimeLine_datas:(NSArray <ChartItem *>*)datas
{
    [datas enumerateObjectsUsingBlock:^(ChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj.extVal setObject:[NSNumber numberWithFloat:obj.closePrice] forKey:[self getKeyWithName:MLSeries_Timeline]];
         [obj.extVal setObject:[NSNumber numberWithFloat:obj.vol] forKey:[self getKeyWithName:MLSeries_Volume]];
        // 组合
        // Timeline_Timeline: data.closePrice
        // Timeline_Volume: data.vol
    }];
    
    return datas;
}
@end

#pragma mark - 《MA简单移动平均数》 处理算法
@implementation MLChartAlgorithm (ChartAlgorithm_MA)

- (NSArray<ChartItem *>*)handle_MA_WithNum:(int)num datas:(NSArray <ChartItem *>*)datas
{
    
    [datas enumerateObjectsUsingBlock:^(ChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // {@"price":value,@"vol":value}; 交易量和价格
        NSDictionary *dict = [self getMAValueWithNum:num index:(int)idx datas:datas];
        [obj.extVal setObject:dict[@"price"] forKey:[self getKeyWithName:MLSeries_Timeline]];
        [obj.extVal setObject:dict[@"vol"] forKey:[self getKeyWithName:MLSeries_Timeline]];
    }];
    
    return datas;
}


/**
 计算移动平均数MA
 
 @param num 周期
 @param index 索引(天数)
 @param datas 数据集
 @return 处理后的数据集
 */
- (NSDictionary *)getMAValueWithNum:(int)num index:(int)index datas:(NSArray <ChartItem *>*)datas
{
    // 价格 和 交易量
    // {@"price":value,@"vol":value};
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    // 价格
    CGFloat price_Val = 0.f;
    // 交易量
    CGFloat vol_Val = 0.f;
    if (index + 1 >= num) { // 索引是从0开始 没有第0天 从第一天开始 index + 1 >= N 累计N天内的
        
        for (int i = index; i > index + 1 - num; i--) {
            vol_Val += datas[i].vol;
            price_Val += datas[i].closePrice;
        }
        
        vol_Val = vol_Val / num;
        price_Val = price_Val / num;
        
        
        [dict setObject:[NSNumber numberWithFloat:price_Val] forKey:@"price"];
        [dict setObject:[NSNumber numberWithFloat:vol_Val] forKey:@"vol"];
        
        return dict;
        
    }else{ //  index + 1 < N 累计 index+1 天内的
        
        for (int i = index; i > 0; i--) {
            vol_Val += datas[i].vol;
            price_Val += datas[i].closePrice;
        }
        vol_Val = vol_Val / num;
        price_Val = price_Val / num;
        
        [dict setObject:[NSNumber numberWithFloat:price_Val] forKey:@"price"];
        [dict setObject:[NSNumber numberWithFloat:vol_Val] forKey:@"vol"];
        
        return dict;
    }
    
    
    
    return dict;
}

@end

#pragma mark - 《EMA指数移动平均数》 处理算法
@implementation MLChartAlgorithm (ChartAlgorithm_EMA)

/**
 处理EMA运算
EMA(N) = 2/(N + 1) * (C - 昨日EMA) + 昨日EMA
 == > 推导... 得出下面的公式
EMA(N) = 2/(N + 1) * C + (N - 1)/(N + 1) * 昨日EMA
 eg:EMA(12) = 2/13 * C + 11/13 * 昨日的EMA(12)

 @param num 周期
 @param datas 数据集
 @return 处理技术指标完成的数据集
 */
- (NSArray<ChartItem *> *)handle_EMA_WithNum:(int)num datas:(NSArray<ChartItem *> *)datas
{
    
    CGFloat prev_ema_price = 0.f;
    CGFloat pre_ema_vol = 0.f;
    
    [datas enumerateObjectsUsingBlock:^(ChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat c = datas[idx].closePrice; // 收盘价
        CGFloat v = datas[idx].vol; // 交易量
        // 价格
        CGFloat ema_price = 0.f;
        CGFloat ema_vol = 0.f;
        // EMA(N)=2/(N+1) * (C -昨日EMA) + EMA
        if (idx > 0) {
            ema_price = prev_ema_price + (c - prev_ema_price) * 2 / (num + 1);
            ema_vol = pre_ema_vol + (v - pre_ema_vol) * 2 / (num + 1);
        }else{
            ema_price = c;
            ema_vol = v;
        }
       
        // EMA_5_Timeline = ema_price; EMA 类型组成的时间线
         [obj.extVal setObject:[NSNumber numberWithFloat:ema_price] forKey: [self getKeyWithName:MLSeries_Timeline]];
        // EMA_5_Volume = ema_vol; EMA 类型组成的交易量
         [obj.extVal setObject:[NSNumber numberWithFloat:ema_vol] forKey: [self getKeyWithName:MLSeries_Volume]];
        
    }];
    return datas;
 
}

@end

#pragma mark - 《RSI》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_RSI)

- (NSArray<ChartItem *>*)handle_RSI_WithNum:(int)num WithDats:(NSArray <ChartItem *>*)datas;

@end

@implementation MLChartAlgorithm (ChartAlgorithm_RSI)

- (NSArray *)getAAndB:(int)a B:(int)b withDatas:(NSArray<ChartItem *>*)datas
{
    return nil;
}

- (NSArray<ChartItem *>*)handle_RSI_WithNum:(int)num WithDats:(NSArray <ChartItem *>*)datas;
{
    
    
    return nil;
}

@end



#pragma mark - 《KDJ随机指标》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_KDJ)

@end

@implementation MLChartAlgorithm (ChartAlgorithm_KDJ)

@end


#pragma mark - 《MACD随机指标》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_MACD)

@end

@implementation MLChartAlgorithm (ChartAlgorithm_MACD)

@end


#pragma mark - 《BOLL随机指标》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_BOLL)

@end

@implementation MLChartAlgorithm (ChartAlgorithm_BOLL)

@end


#pragma mark - 《SAR指标》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_SAR)

@end

@implementation MLChartAlgorithm (ChartAlgorithm_SAR)

@end

#pragma mark - 《SAM指标》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_SAM)

@end

@implementation MLChartAlgorithm (ChartAlgorithm_SAM)

@end
