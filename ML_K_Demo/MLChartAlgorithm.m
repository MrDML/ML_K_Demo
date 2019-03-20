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




#pragma mark - 《MA简单移动平均数》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_MA)


/**
 处理MA运算
 C:收盘价
 N:周期
 MA（N）=（C1+C2+……CN）/N
 @param num 天数
 @param datas 数据集
 @return return value description
 */
- (NSArray<ChartItem *>*)handle_MA_WithNum:(int)num datas:(NSArray <ChartItem *>*)datas;

@end

@implementation MLChartAlgorithm (ChartAlgorithm_MA)

- (NSArray<ChartItem *>*)handle_MA_WithNum:(int)num datas:(NSArray <ChartItem *>*)datas
{
    
    [datas enumerateObjectsUsingBlock:^(ChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       NSDictionary *dict = [self getMAValueWithNum:num index:idx datas:datas];
        
//        obj.extVal[]
        
        
    }];
    
    return datas;
}


/**
 计算移动平均数MA

 @param num <#num description#>
 @param index <#index description#>
 @param datas <#datas description#>
 @return <#return value description#>
 */
- (NSDictionary *)getMAValueWithNum:(int)num index:(int)index datas:(NSArray <ChartItem *>*)datas
{
    // 价格 和 交易量
    // {@"price":value,@"val":value};
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
        [dict setObject:[NSNumber numberWithFloat:vol_Val] forKey:@"price"];
        
        return dict;
        
    }else{ //  index + 1 < N 累计 index+1 天内的
        
        for (int i = index; i > 0; i--) {
            vol_Val += datas[i].vol;
            price_Val += datas[i].closePrice;
        }
        vol_Val = vol_Val / num;
        price_Val = price_Val / num;
        
        [dict setObject:[NSNumber numberWithFloat:price_Val] forKey:@"price"];
        [dict setObject:[NSNumber numberWithFloat:vol_Val] forKey:@"price"];
        
         return dict;
    }
    
    
    
    return dict;
}


@end


#pragma mark - 《EMA指数移动平均数》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_EMA)

@end

@implementation MLChartAlgorithm (ChartAlgorithm_EMA)

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

#pragma mark - 《时分价格》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_RSI_TimeLine)

@end

@implementation MLChartAlgorithm (ChartAlgorithm_RSI_TimeLine)

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
            result = [NSString stringWithFormat:@"%@_%@",MLChart_Timeline,name];
            
            break;
        case ChartAlgorithmType_MA:
          
             result = [NSString stringWithFormat:@"%@_%@_%@",MLChart_MA,[self.data_vals firstObject],name];
            break;
        case ChartAlgorithmType_EMA:
             result = [NSString stringWithFormat:@"%@_%@_%@",MLChart_EMA,[self.data_vals firstObject],name];
            break;
        case ChartAlgorithmType_KDJ:
            result = [NSString stringWithFormat:@"%@_%@",MLChart_KDJ,name];
            break;
        case ChartAlgorithmType_MACD:
            result = [NSString stringWithFormat:@"%@_%@",MLChart_MACD,name];
            break;
        case ChartAlgorithmType_BOLL:
            result = [NSString stringWithFormat:@"%@_%@",MLChart_BOLL,name];
            break;
        case ChartAlgorithmType_SAR:
            result = [NSString stringWithFormat:@"%@%@",MLChart_SAR,name];
            break;
        case ChartAlgorithmType_SAM:
             result = [NSString stringWithFormat:@"%@_%@_%@",MLChart_SAM,[self.data_vals firstObject],name];
            break;
        case ChartAlgorithmType_RSI:
            result = [NSString stringWithFormat:@"%@_%@_%@",MLChart_RSI,[self.data_vals firstObject],name];
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
            
            
            break;
        case ChartAlgorithmType_MA:
            
            
            break;
        case ChartAlgorithmType_EMA:
            
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
           return  [self handle_RSI_WithNum:[self.data_vals[0] intValue] WithDats:datas];
            break;
            
        default:
            break;
    }
   

    return nil;
}




@end

