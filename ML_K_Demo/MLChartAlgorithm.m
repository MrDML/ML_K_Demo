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
// ==============================   华丽非分割线   ==============================
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

#pragma mark - 《EMA指数移动平均数》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_EMA)

/**
 处理EMA指标
 
 @param num 周期
 @param datas 数据集
 @return 设置完成的数据集
 */
- (NSArray<ChartItem *>*)handle_EMA_WithNum:(int)num datas:(NSArray <ChartItem *>*)datas;
@end

#pragma mark - 《时分价格》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_TimeLine)
/**
 处理时分价格运算
 使用收盘价作为时分价
 
 @param datas 数据集
 @return 返回处理后的数据集
 */
- (NSArray<ChartItem *>*)handle_TimeLine_datas:(NSArray <ChartItem *>*)datas;
@end

#pragma mark - 《RSI》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_RSI)
- (NSArray<ChartItem *>*)handle_RSI_WithNum:(int)num WithDats:(NSArray <ChartItem *>*)datas;
@end

#pragma mark - 《KDJ随机指标》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_KDJ)
- (NSArray<ChartItem *>*)handle_KDJ_WithP1:(int)p1 P2:(int)p2 P3:(int)p3 WithDats:(NSArray <ChartItem *>*)datas;
@end

#pragma mark - 《MACD随机指标》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_MACD)
- (NSArray<ChartItem *>*)handle_MACD_WithP1:(int)p1 P2:(int)p2 P3:(int)p3 WithDats:(NSArray <ChartItem *>*)datas;
@end

#pragma mark - 《BOLL随机指标》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_BOLL)
- (NSArray<ChartItem *>*)handle_BOLL_WithNum:(int)num K:(int)k Dats:(NSArray <ChartItem *>*)datas;
@end

#pragma mark - 《SAR指标》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_SAR)
- (NSArray<ChartItem *>*)handle_SAR_WithNum:(int)num minAF:(int)minAF maxAF:(int)maxAF Dats:(NSArray <ChartItem *>*)datas;
@end

#pragma mark - 《SAM指标》 处理算法
@interface MLChartAlgorithm (ChartAlgorithm_SAM)
- (NSArray<ChartItem *>*)handle_SAM_WithNum:(int)num datas:(NSArray <ChartItem *>*)datas;
@end


#pragma mark - 扩展方法
@interface MLChartAlgorithm (ChartAlgorithm_Extension)
/**
 获取某日的EMA数据
 
 @param num 天数周期
 @param index 当前索引
 @param datas 数据集
 @return EMA的成交价和成交量
 */
- (NSDictionary *)getEMAWithNum:(int)num currentIndex:(int)index datas:(NSArray <ChartItem *>*)datas;

/**
 获取某日的EMA数据
 
 @param num 天数周期
 @param index 当前索引
 @param datas 数据集
 @return EMA的成交价和成交量
 */
- (NSDictionary *)getMAWithNum:(int)num currentIndex:(int)index datas:(NSArray <ChartItem *>*)datas;

@end

// ==============================   华丽非分割线   ==============================

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
- (NSString *)getKeyWithName:(NSString * _Nullable)name
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
           return  [self handle_KDJ_WithP1:[self.data_vals[0] intValue] P2:[self.data_vals[1] intValue] P3:[self.data_vals[2] intValue] WithDats:datas];
            break;
        case ChartAlgorithmType_MACD:
            [self handle_MACD_WithP1:[self.data_vals[0] intValue] P2:[self.data_vals[1] intValue] P3:[self.data_vals[2] intValue]  WithDats:datas];
            break;
        case ChartAlgorithmType_BOLL:
            [self handle_BOLL_WithNum:[self.data_vals[0] intValue] K:[self.data_vals[1] intValue] Dats:datas];
            break;
        case ChartAlgorithmType_SAR:
            [self handle_SAR_WithNum:[self.data_vals[0] intValue]  minAF:[self.data_vals[1] intValue]  maxAF:[self.data_vals[2] intValue]  Dats:datas];
            break;
        case ChartAlgorithmType_SAM:
            [self handle_SAM_WithNum:[[self.data_vals firstObject] intValue] datas:datas];
            break;
        case ChartAlgorithmType_RSI:
            [self handle_RSI_WithNum:[[self.data_vals firstObject] intValue] WithDats:datas];

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
// MARK: - 《RSI》 处理算法
/** https://www.douban.com/note/121946923/
 
 二、RSI指标的计算方法
 相对强弱指标RSI的计算公式有两种
 
 其一：
 
 假设A为N日内收盘价的正数之和，B为N日内收盘价的负数之和乘以（—1）这样，A和B均为正，将A、B代入RSI计算公式，则
 
 RSI（N）=A÷（A＋B）×100
 
 其二：
 
 RS（相对强度）=N日内收盘价涨数和之均值÷N日内收盘价跌数和之均值
 
 RSI（相对强弱指标）=100－100÷（1+RS）
 
 这两个公式虽然有些不同，但计算的结果一样。
 
 以14日RSI指标为例，从当起算，倒推包括当日在内的15个收盘价（idx + 1 = 14 + 1 = 15, 不包含1），以每一日的收盘价减去上一日的收盘价，得到14个数值，这些数值有正有负。这样，RSI指标的计算公式具体如下：
 
 A=14个数字中正数之和
 
 B=14个数字中负数之和乘以（—1）
 
 RSI（14）=A÷（A＋B）×100
 
 式中：A为14日中股价向上波动的大小
 
 B为14日中股价向下波动的大小
 
 A＋B为股价总的波动大小
 
 RSI的取值介于0—100之间
 
 */
@implementation MLChartAlgorithm (ChartAlgorithm_RSI)
// [1 - 14]
- (NSDictionary *)getAAndB:(int)a B:(int)b withDatas:(NSArray<ChartItem *>*)datas
{
    // 这里的a值有可能为负数， 要进行拦截
    int s = a;
    if (s < 0) {
        s = 0; // 从 0 开始
    }
    
    CGFloat sum = 0, dif = 0,closeT = 0.f,closeY = 0.f;
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    // 假设 num = 14, b = 13 a = 0
    // [1, 14]
    for (int i = s; i <= b; i ++) { // range:s - b
        if (i > s) { // 不包含 第s天
            closeT = datas[i].closePrice;
            closeY = datas[i - 1].closePrice;
            // 以每一日的收盘价减去上一日的收盘价
            CGFloat close = closeT - closeY;
            
            if (close > 0) {
                sum = sum + close;
            }else{
                dif = sum + close;
            }
            dif = fabs(dif);
        }
    }
    
    NSNumber *number_sum = [NSNumber numberWithFloat:sum];
    NSNumber *number_dif = [NSNumber numberWithFloat:dif];
   
    [result setObject:number_sum forKey:@"sum"];
    [result setObject:number_dif forKey:@"dif"];
    
    
    return result;
}
- (NSArray<ChartItem *>*)handle_RSI_WithNum:(int)num WithDats:(NSArray <ChartItem *>*)datas;
{
    // 注意这里的 num 是从1开始计算的
    // RSI的取值介于0—100之间
    int maxVal  = 100;
    // 当  i = 10 其实已经有11个数了 包含了 0， 这里求索引对应的值
    int index = num - 1;
  __block CGFloat sum = 0.f;
  __block  CGFloat dif = 0.f;
  __block  CGFloat rsi = 0.f;
    
    [datas enumerateObjectsUsingBlock:^(ChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (num == 0) {
            sum = 0;
            dif = 0;
        }else{
            // 天数大于13的 从13开始往后推14天计算
            // 天数小于13的 默认为100
            // i = 13  第14天
            int s = (int)idx - num + 1; //
            int e = (int)idx;
            // 求 sum  和  dif (往后倒推)（周期是14 从13开始往后推算14天 知道 0）
            // 计算的范围是[0 - 13] 总共14天
            NSDictionary *sumAndDif =  [self getAAndB:s B:e withDatas:datas];
            sum = [sumAndDif[@"sum"] floatValue];
            dif = [sumAndDif[@"dif"] floatValue];
        }
        
        
        if (dif != 0) {
            CGFloat h = sum + dif;
            rsi = sum / h * maxVal;
        }else{
            rsi = maxVal;
        }
        
        if (idx < index) { // 0 - 13 执行14次 一个周期
            rsi = maxVal;
        }
        
        
        // 每遍历一次 都会有一个rsi
        [obj.extVal setObject:[NSNumber numberWithFloat:rsi] forKey:[self getKeyWithName:MLSeries_Timeline]];
        
        
        
    }];
    
    
    
    
    return nil;
}

@end

#pragma mark - 《KDJ随机指标》 处理算法
@implementation MLChartAlgorithm (ChartAlgorithm_KDJ)

/**
 处理KDJ

 @param p1 指标分析周期
 @param p2 指标分期周期
 @param p3 指标分析筑起
 @param datas 未处理的数据集
 @return 处理完成的数据集
 */
- (NSArray<ChartItem *>*)handle_KDJ_WithP1:(int)p1 P2:(int)p2 P3:(int)p3 WithDats:(NSArray <ChartItem *>*)datas
{
    
   __block CGFloat prev_k = 50;
   __block CGFloat prev_d = 50;
    [datas enumerateObjectsUsingBlock:^(ChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       // 计算RSV值
        CGFloat rsv = [self getRSVWithNum:p1 currentIndex:(int)idx datas:datas];
        
        // 计算k,d,j值
        CGFloat k = (2 * prev_k + rsv) / 3;
        CGFloat d = (2 * prev_k + k) / 3;
        CGFloat j = 3 * k - 2 * d;
        
        prev_k = k;
        prev_d = d;

        [obj.extVal setObject:[NSNumber numberWithFloat:k] forKey:[self getKeyWithName:@"K"]];
        [obj.extVal setObject:[NSNumber numberWithFloat:d] forKey:[self getKeyWithName:@"D"]];
        [obj.extVal setObject:[NSNumber numberWithFloat:j] forKey:[self getKeyWithName:@"J"]];
    }];
    
    
    
    return nil;
}


/**
 RSV计算

 @param num 计算当前的范围（周期）
 @param index 当前的索引位
 @param datas 数据集
 @return RSV 值
 */
- (CGFloat)getRSVWithNum:(int)num currentIndex:(int)index datas:(NSArray <ChartItem *>*)datas
{
    CGFloat rsv = 0;
   __block CGFloat c = datas[index].closePrice;
   __block CGFloat h = datas[index].highPrice;
   __block  CGFloat l = datas[index].lowPrice;
    
    
    // 获取最高价和最低价
    void(^block)(int idx) = ^(int idx){
        // 获取当前索引对应的点对象
        ChartItem *item = datas[idx];
        
        // 获取最高价
        if (item.highPrice > h) {
            h = item.highPrice;
        }
        
        // 获取最低价
        if (item.lowPrice < l) {
            l = item.lowPrice;
        }
        
    };
    
    // 索引为 0 也是要算进去的
    if (index + 1 >= num) { // index + 1 >= N 累计N天内的
        // 从第0天开始算 周期为num天数内最低价，最高价（倒序遍历）
        for (int i = index; i <= index + 1 - num; i --) {
            block(i);
        }
    }else{ // index + 1 < N, 累计index + 1 天内的
        for (int i = index; i <= 0; i --) { // 包含第0天
            block(i);
        }
    }
    
    if (h != l) {
        rsv  = (c - l) / (h - l) * 100;
    }

    return rsv;
}


@end


#pragma mark - 《MACD随机指标》 处理算法
@implementation MLChartAlgorithm (ChartAlgorithm_MACD)

/**
 处理MACD运算

 EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA；
 EMA（12）=昨日EMA（12）*11/13+C*2/13；
         = C * 2/(N+1) + EMA` * (N - 1)/(N + 1)
 @param p1 指标分析周期
 @param p2 指标分析周期
 @param p3 指标分析周期
 @param datas 未处理数据集
 @return return 处理过的数据集
 */
- (NSArray<ChartItem *>*)handle_MACD_WithP1:(int)p1 P2:(int)p2 P3:(int)p3 WithDats:(NSArray <ChartItem *>*)datas
{
    
    __block CGFloat pre_dea = 0.f;
    [datas enumerateObjectsUsingBlock:^(ChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // EMA (p1) = 2 / (p1 + 1) * (C - 昨日EMA) +   昨日EMA
         NSDictionary *result_one =  [self getEMAWithNum:p1 currentIndex:(int)idx datas:datas];
         NSDictionary *result_two =  [self getEMAWithNum:p2 currentIndex:(int)idx datas:datas];
        
        NSNumber *ema_price_one = [result_one objectForKey:@"price"];
        NSNumber *ema_price_two = [result_two objectForKey:@"price"];
        
        if (ema_price_one != nil && ema_price_two != nil) {
            
            CGFloat ema_one = [ema_price_one floatValue];
            CGFloat ema_two = [ema_price_two floatValue];
            // DIF = 今日的EMA(p1) - 今日EMA(p2)
            CGFloat dif = ema_one - ema_two;
            // dea (p3) = 2/(p3 + 1) * (dif - 昨日dea * ) 昨日dea
            CGFloat dea = pre_dea + (dif - pre_dea) - 2 / (p3 + 1);
            // BAR = 2 * (dif - dea )
            CGFloat bar = 2 * (dif - dea);
            
           
             [obj.extVal setObject:[NSNumber numberWithFloat:dif] forKey: [self getKeyWithName:@"DIF"]];
             [obj.extVal setObject:[NSNumber numberWithFloat:dea] forKey: [self getKeyWithName:@"DEA"]];
             [obj.extVal setObject:[NSNumber numberWithFloat:bar] forKey: [self getKeyWithName:@"BAR"]];
            
            pre_dea = dea;
            
        }
        
    }];
    
    return datas;
}
@end


#pragma mark - 《BOLL随机指标》 处理算法
@implementation MLChartAlgorithm (ChartAlgorithm_BOLL)


/**
 布林线处理方法

 @param num 天数
 @param k 默认 2
 @param datas 未处理的数据集
 @return 处理后的数据集
 */
- (NSArray<ChartItem *>*)handle_BOLL_WithNum:(int)num K:(int)k Dats:(NSArray <ChartItem *>*)datas
{
    
   __block CGFloat md = 0.f, mb = 0.f, up = 0.f, dn = 0.f;
    [datas enumerateObjectsUsingBlock:^(ChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       // 计算标准
        md = [self handleBOLLSTDNum:num index:k datas:datas];
        mb = [[[self getMAValueWithNum:num index:k datas:datas] objectForKey:@"price"] floatValue];
        up = mb + k * md;
        dn = mb - k * md;
     
        [obj.extVal setObject:[NSNumber numberWithFloat:mb] forKey:[self getKeyWithName:@"BOLL"]];
        [obj.extVal setObject:[NSNumber numberWithFloat:up] forKey:[self getKeyWithName:@"UB"]];
        [obj.extVal setObject:[NSNumber numberWithFloat:dn] forKey:[self getKeyWithName:@"LB"]];
        
    }];

    return datas;
}

- (CGFloat)handleBOLLSTDNum:(int)num index:(int)index datas:(NSArray <ChartItem *>*)datas
{
    CGFloat dx = 0.f, md = 0.f;
    NSDictionary * dict_ma = [self getMAValueWithNum:num index:index datas:datas];
    CGFloat ma = [dict_ma[@"price"] floatValue];
    
    if ((index + 1) >= num) { // index + 1 >= N, 计算N日的平方差
        for (int i = index; i <= (index + 1) - num; i --) {
            dx +=  pow(datas[i].closePrice - ma, 2);
        }
        md = dx/num;
    }else{  // index + 1 < N, 计算index+ 1日的平方差
        for (int i = index; i <= 0; i --) {
            dx +=  pow(datas[i].closePrice - ma, 2);
        }
        md = dx/(num + 1);
        
    }
    // 平方根
    md = pow(md, 0.5);
    return md;
}


@end


#pragma mark - 《SAR指标》 处理算法
@implementation MLChartAlgorithm (ChartAlgorithm_SAR)
/**
 SAR指标又叫抛物线指标或停损转向操作点指标
 
 计算Tn周期的SAR值为例，计算公式如下：
 SAR(Tn)=SAR(Tn-1)+AF(Tn)*[EP(Tn-1)-SAR(Tn-1)]
 其中，SAR(Tn)为第Tn周期的SAR值，SAR(Tn-1)为第(Tn-1)周期的值
 AF为加速因子(或叫加速系数)，EP为极点价(最高价或最低价)
 在计算SAR值时，要注意以下几项原则：
 1、初始值SAR(T0)的确定
 若T1周期中SAR(T1)上涨趋势，则SAR(T0)为T0周期的最低价，若T1周期下跌趋势，则SAR(T0)为T0周期 的最高价；
 2、极点价EP的确定
 若Tn周期为上涨趋势（SAR在K线下方），EP(Tn-1)为Tn-1周期的最高价，若Tn周期为下跌趋势（SAR在K线上方）EP(Tn-1)为Tn-1周期的最低价；
 3、加速因子AF的确定
 (a)加速因子初始值为0.02，即AF(T0)=0.02；
 (b)若Tn-1，Tn周期都为上涨趋势时，当Tn周期的最高价>Tn-1周期的最高价,则AF(Tn)=AF(Tn-1)+0.02， 当Tn周期最高价<=Tn-1周期的最高价,则AF(Tn)=AF(Tn-1)，但加速因子AF最高不超过0.2；
 (c)若Tn-1，Tn周期都为下跌趋势时，当Tn周期的最低价<Tn-1周期的最低价,则AF(Tn)=AF(Tn-1)+0.02， 当Tn周期最低价>=Tn-1周期的最低价,则AF(Tn)=AF(Tn-1)；
 (d)任何一次行情的转变，加速因子AF都必须重新由0.02起算；
 比如，Tn-1周期为上涨趋势，Tn周期为下跌趋势(或Tn-1下跌，Tn上涨)，AF(Tn)需重新由0.02为基础进 行计算，AF(Tn)=AF(T0)=0.02；
 (e)加速因子AF最高不超过0.2,当AF>0.2时，维持最大值；
 4、确定今天的SAR值
 (a)通过公式SAR(Tn)=SAR(Tn-1)+AF(Tn)*[EP(Tn-1)-SAR(Tn-1)]，计算出Tn周期的值；
 (b)若Tn周期为上涨趋势，当SAR(Tn)>Tn周期的收盘价，则Tn周期最终 SAR值应为基准周期段的最高价中的最大值，
 当SAR(Tn)<=Tn周期的收盘价，则Tn周期最终SAR值为SAR(Tn)，即 SAR=SAR(Tn)；
 (c)若Tn周期为下跌趋势，当SAR(Tn)<Tn周期的收盘价，则Tn周期最终 SAR值应为基准周期段的最低价中的最小值，
 当SAR(Tn)>=Tn周期的收盘价，则Tn周期最终SAR值为SAR(Tn)，即 SAR=SAR(Tn)；
 5、SAR指标周期的计算基准周期的参数为2，如2日、2周、2月等，其计算周期的参数变动范围为2—8。（多数推荐4）
 6、SAR指标的计算方法和过程比较烦琐，对于投资者来说只要掌握其演算过程和原理，在实际操作中并不 需要投资者自己计算SAR值，重要的是投资者要灵活掌握和运用SAR指标的研判方法和功能。
 
 - Parameter num: 基准周期数N
 - Parameter minAF: 加速因子AF最小值（初始值）
 - Parameter maxAF: 加速因子AF最大值
 - Parameter datas: 待处理的数据集合
 - Returns: 处理后的数据集合
 */
- (NSArray<ChartItem *>*)handle_SAR_WithNum:(int)num minAF:(int)minAF maxAF:(int)maxAF Dats:(NSArray <ChartItem *>*)datas
{
    
  __block  CGFloat sar = 0.f , af = minAF , ep = 0.f;
    
  __block  ChartItem *pre_data = nil;
   __block BOOL isUP = YES;

    do {
        // 这个指标至少两条数据才显示
        if (num < 2 || datas.count < 2) {
            break;
        }
        
        // 1. 初始值SAR(T0)的确定
        // 若T1周期中SAR(T1)上涨趋势, 则SAR(T0)为T0周期的最低价;
        // 若T1周期下跌趋势,则SAR(T0)为周期的最高价;
        if (datas[1].closePrice > datas[0].closePrice) { // 上涨趋势
            sar = datas[0].lowPrice;
            isUP = YES;
        }else{ // 下跌趋势
            sar = datas[0].highPrice;
            isUP = NO;
        }
        
        // 记录第一日的价位
        pre_data = datas[0];
        
        [datas enumerateObjectsUsingBlock:^(ChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            
            if (idx > 0) { // 忽略索引为0的值
                // 确定今天的SAR值
               NSDictionary *res_dict = [self getFinal_SAR_withNum:num sar:sar index:(int)idx isUP:isUP datas:datas];
                
                CGFloat finalSAR = [res_dict[@"sar"] floatValue];
                BOOL finalIsUp = [res_dict[@"isup"] boolValue];
                // 出现行情反转, 充值AF加速因子
                if (isUP != finalIsUp) {
                    af = minAF;
                }
                sar = finalSAR;
                isUP = finalIsUp;
            }

            // 确定今天的SAR
            [obj.extVal setObject:[NSNumber numberWithFloat:sar] forKey:[self getKeyWithName:nil]];
            
            // 预算明天的SAR的值
            
            // SAR(Tn)=SAR(Tn-1) + AF(Tn) * [EP(Tn-1) - SAR(Tn-1)]
            // SAR(1) = SAR(0) + AF(1)*[EP(0)-SAR(0)] 第一天
            // 2. 极点价EP(最高价/最低价)的确定
            //    若Tn周期为上涨趋势(SAR在K线下方), EP(Tn-1)为Tn-1周期的最高价, 若Tn周期为下跌趋势(SAR在K线上方),EP(Tn-1)为Tn-1周期的最低价
            
            if (isUP) {
                ep = pre_data.highPrice;
            }else{
                ep = pre_data.lowPrice;
            }
            
            // 3. 加速因子AF的确定
            //    a. 加速因子初始值为0.02,即AF(T0)=0.02;
            //    b. 若Tn-1, Tn周期都为上涨趋势时,
            //       当Tn周期的最高价>Tn-1周期的最高价,则AF(Tn)=AF(Tn-1)+0.02,
            //       当Tn周期的最高价<=Tn-1周期的最高价,则AF(Tn)=AF(Tn-1),
            //       单加速因子AF最高不超过0.02
            //    c. 若Tn-1, Tn周期都为下跌趋势时,
            //       当Tn周期的最低价<Tn-1周期的最低价,则AF(Tn)=AF(Tn-1)+0.02,
            //       当Tn周期的最低价>=Tn-1h周期的最低价,则AF(Tn)=AF(Tn-1),
            //    d. 任何一次行情的转变,加速因子AF都必须重新由0.02起算
            //    比如,Tn-1周期为上涨趋势,Tn周期为下跌趋势(或Tn-1下跌,Tn上涨),AF(Tn)需重新由0.02为基础进行计算,即AF(Tn)=AF(T0)=0.02;
            //    e. 加速因子最高不超过0.2,当AF>0.2时,维持最大值
            if (isUP) {
                if (obj.highPrice > pre_data.highPrice) {
                    af = af + minAF;
                }
            }else{
                if (obj.lowPrice < pre_data.lowPrice) {
                    af = af + minAF;
                }
            }
            if (af > maxAF) {
                af = minAF;
            }
            
            sar = sar + af * (ep - sar);
            
            // 记录明天的SAR值
             [obj.extVal setObject:[NSNumber numberWithFloat:sar] forKey:[self getKeyWithName:@"tomorrow"]];
            
            pre_data = obj;
            
        }];

    } while (0);

    return  datas;
    
}


/**
 取得当前最终的SAR值

 @param num 趋势判断周期
 @param sar 预算的sar值
 @param index 该周期的位置
 @param isUP 趋势
 @param datas 数据集合
 @return @{"sar":value, @"isup":@"YES"}
 */
- (NSDictionary *)getFinal_SAR_withNum:(int)num sar:(CGFloat)sar index:(int)index isUP:(BOOL)isUP datas:(NSArray <ChartItem *>*)datas
{
    // 4. 确定今天的SAR值
    // a. 通过公式SAR(Tn)=SAR(Tn-1)+AF(TN)*[EP(Tn-1)-SAR(Tn-1)] 计算出Tn周期的值;
    // b. 若Tn周期为上涨趋势, 当SAR(Tn)>Tn周期的收盘价,则Tn周期最终 SAR值应为num天周期段的最高价中的最大值
    //    当SAR(Tn)<=Tn周期的收盘价,则Tn周期最终SAR值为SAR(Tn), 即ASAR=SAR(Tn);
    // c. 若Tn周期为下跌趋势, 当SAR(Tn)<Tn周期的收盘价,则Tn周期最终 SAR值应为num天周期的最低价中的最小值
    //    当SAR(Tn)>=Tn周期的收盘价, 则Tn周期最终SAR值为SAR(Tn), 即 SAR=SAR(Tn);
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    CGFloat finalSAR = sar;
    
    BOOL finalIsUp = isUP;
    
    int start = index;
    
    if (isUP) {
        
        if (sar > datas[index].closePrice) { // 收盘价跌破SAR,转向做空
            do {
                finalSAR = MAX(datas[start].highPrice, finalSAR); // 获取周期中的最大值
                start -= 1;  // 递减知道num天前
            } while (start >= MAX(index - num + 1, 0)); // eg: index = 3,(索引是从0开始) 其实已经过3 + 1 天了
            finalIsUp = NO;
        }
        
    }else{
        if (sar < datas[index].closePrice) {// 收盘价突破SAR, 转向做多
            // 从今天开始数前num天的最低价
            do {
                finalSAR = MIN(datas[start].lowPrice, finalIsUp); // 获取周期中的最小值
                start -= 1; // 递减知道num天前
            } while (start >= MAX(index - num + 1, 0));
            finalIsUp = YES;
        }
    }
    
    
    [result setObject:[NSNumber numberWithFloat:finalIsUp] forKey:@"sar"];
    [result setObject:[NSNumber numberWithBool:finalIsUp] forKey:@"isup"];
    
    return result;
}




@end

#pragma mark - 《SAM指标》 处理算法
@implementation MLChartAlgorithm (ChartAlgorithm_SAM)


/**
 处理SAM运算
 1.计算每个点往后num周期内的最高交易量，最后少于num的条数，只计算最后个数的最高交易量
 2.在主图蜡烛柱边框加颜色显示
 3.在主图收盘价记录点线
 4.在副图交易量柱边框加颜色显示
 5.在副图交易量记录点线
 @param num 天数
 @param datas 未处理的数据集
 @return 处理过后的数据集
 */
- (NSArray<ChartItem *>*)handle_SAM_WithNum:(int)num datas:(NSArray <ChartItem *>*)datas
{
    // 最大交易量的收盘价
   __block CGFloat max_vol_price = 0.f;
    // 最大交易量
   __block CGFloat max_vol =0.f;
    // 最大交易量位置
   __block int max_index = 0;
    
    [datas enumerateObjectsUsingBlock:^(ChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       // 超过了num周期都没找到最大值，重新在index后num个寻找
        if (idx - max_index == num) {
            
            max_vol_price = 0;
            max_vol = 0;
            max_index = 0;
            
            for (int i = (int)idx - num + 1; i <= (int)idx ; i ++) {
                
                CGFloat c = datas[i].closePrice;
                CGFloat v = datas[i].vol;
                if (v > max_vol) {
                    max_vol_price = c;
                    max_vol = v;
                    max_index = i;
                }
            }
            
            // 重置最大值之后的计算数值
            
            for (int i = max_index; i <= (int)idx ; i ++) {
                
                 [datas[i].extVal setObject:[NSNumber numberWithFloat:max_vol_price] forKey:[self getKeyWithName:MLSeries_Timeline]];
                  [datas[i].extVal setObject:[NSNumber numberWithFloat:max_vol] forKey:[self getKeyWithName:MLSeries_Volume]];
                
            }
            
            
        }else{
            // 每位移一个数，计算是否最大交易量
            CGFloat c = datas[idx].closePrice;
            CGFloat v = datas[idx].vol;
            
            if (v > max_vol) {
                max_vol_price = c;
                max_vol = v;
                max_index = (int)idx;
            }
            
        }
        
        
        if (idx > num - 1) {
            [obj.extVal setObject:[NSNumber numberWithFloat:max_vol_price] forKey:[self getKeyWithName:MLSeries_Timeline]];
            [obj.extVal setObject:[NSNumber numberWithFloat:max_vol] forKey:[self getKeyWithName:MLSeries_Volume]];
            
            // 记录填充颜色的最大值
            NSString *priceName = [NSString stringWithFormat:@"%@_BAR",MLSeries_Timeline];
            NSString *volumeName = [NSString stringWithFormat:@"%@_BAR",MLSeries_Volume];
            // 取出最大值
            ChartItem *maxData  = datas[max_index];
             [maxData.extVal setObject:[NSNumber numberWithFloat:max_vol_price] forKey:[self getKeyWithName:priceName]];
             [maxData.extVal setObject:[NSNumber numberWithFloat:max_vol] forKey:[self getKeyWithName:volumeName]];
            
        }else if (idx == num - 1){
            // 补充开头没有画的线
            for (int i = max_index; i <= idx; i ++) {
                [datas[i].extVal setObject:[NSNumber numberWithFloat:max_vol_price] forKey:[self getKeyWithName:MLSeries_Timeline]];
                [datas[i].extVal setObject:[NSNumber numberWithFloat:max_vol] forKey:[self getKeyWithName:MLSeries_Volume]];
            }
        }
        
    }];
    
    for (int i = max_index; i < datas.count; i ++) {
        [datas[i].extVal setObject:[NSNumber numberWithFloat:max_vol_price] forKey:[self getKeyWithName:MLSeries_Timeline]];
        [datas[i].extVal setObject:[NSNumber numberWithFloat:max_vol] forKey:[self getKeyWithName:MLSeries_Volume]];
    }
    
    
    return datas;
}
@end


#pragma mark - 扩展方法
@implementation MLChartAlgorithm (ChartAlgorithm_Extension)
/**
 获取某日的EMA数据
 
 @param num 天数周期
 @param index 当前索引
 @param datas 数据集
 @return EMA的成交价和成交量
 */
- (NSDictionary *)getEMAWithNum:(int)num currentIndex:(int)index datas:(NSArray <ChartItem *>*)datas
{
    MLChartAlgorithm * algorithm_EMA = [[MLChartAlgorithm alloc] initWithEMA:@(num)];
    ChartItem *item = datas[index];
    
    NSString *key_price = [algorithm_EMA getKeyWithName:MLSeries_Timeline];
     NSString *key_vol= [algorithm_EMA getKeyWithName:MLSeries_Volume];
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    [result setObject:item.extVal[key_price] forKey:@"price"];
    [result setObject:item.extVal[key_vol] forKey:@"vol"];
    
    return result;
    
}

/**
 获取某日的EMA数据
 
 @param num 天数周期
 @param index 当前索引
 @param datas 数据集
 @return EMA的成交价和成交量
 */
- (NSDictionary *)getMAWithNum:(int)num currentIndex:(int)index datas:(NSArray <ChartItem *>*)datas
{
    
    
    MLChartAlgorithm * algorithm_MA = [[MLChartAlgorithm alloc] initWithMA:@(num)];
    ChartItem *item = datas[index];
    
    NSString *key_price = [algorithm_MA getKeyWithName:MLSeries_Timeline];
    NSString *key_vol= [algorithm_MA getKeyWithName:MLSeries_Volume];
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    [result setObject:item.extVal[key_price] forKey:@"price"];
    [result setObject:item.extVal[key_vol] forKey:@"vol"];
    
    return result;
    
    
}
@end
