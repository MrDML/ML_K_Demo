//
//  MLTools.m
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/4/2.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import "MLTools.h"
#import "NSString+Extension.h"

@implementation MLTools

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+ (instancetype)defaultInstance
{
  return  [[self alloc] init];
}


/**
 向下取第几位小数
 
 15.96 * 10.0 = 159.6
 floor(159.6) = 159.0
 159.0 / 10.0 = 15.9
 
 @param num 数字
 @param index 第几位  15.96 =  15.9
 */
- (double)getDownNum:(double)num decimals:(int)index
{
    
    double divisor = pow(10.0, num);
    return floor(num * divisor);
    
}


/**
 截取到第几位小数

 @param places <#places description#>
 @return <#return value description#>
 */
- (NSString *)toFloorNum:(double)num places:(int)places
{
    double divisor = pow(10.0, places);
    return [self toStringNum:(floor(num * divisor) / divisor) minF:0 maxF:places minI:1];
}





/**
 转化为字符串格式
 
 @param num num description
 @param minF minF description 默认 0
 @param maxF maxF description 默认 10
 @param minI minI description 默认 1
 @return return value description
 */
- (NSString *)toStringNum:(double)num minF:(int)minF maxF:(int)maxF minI:(int)minI
{
    
    NSDecimalNumber *valueDecimalNumber =  [[NSDecimalNumber alloc] initWithDouble:num];
    NSNumberFormatter *twoDecimalPlacesFormatter = [[NSNumberFormatter alloc] init];
    
    //maximumFractionDigits 最大保留几位小数
    twoDecimalPlacesFormatter.maximumFractionDigits = maxF;
    // minimumFractionDigits 最少保留几位小数  默认最少保留0位小数
    twoDecimalPlacesFormatter.minimumFractionDigits = minF;
    // minimumIntegerDigits 最少保留几位整数
    twoDecimalPlacesFormatter.minimumIntegerDigits = (NSUInteger)minI;
    return [twoDecimalPlacesFormatter stringFromNumber:valueDecimalNumber];
    
}


/**
 缩倍数

 @param num 被除数
 @param multiole 除数 不为0 默认值为1
 @param def 保留几位小数 默认值为6
 @return return value description
 */
- (NSString *)toMultipleNum:(double)num multiole:(int)multiole def:(int)def{
    NSString *str = @"0";
    if (num > 1000) {
       str =  [NSString stringWithFormat:@".%ffk",num/1000];
    }else{
        str = [[self toStringNum:num minF:0 maxF:10 minI:1] subString:def];;
    }
    
    return str;
}


/**
 乘积换成String

 @param num
 @param divisor 乘数
 @param dec 保留位小数
 @return return value description
 */
- (NSString *)divideResultToStringNum:(double)num divisor:(double)divisor dec:(int)dec
{
    if (divisor <= 0 || num<= 0) {
        return @"";
    }
    
    NSString *formatStr = [NSString stringWithFormat:@"%%0.%df", dec];
    return [NSString stringWithFormat:formatStr, num/divisor];
   
}

/**
 乘积转换成String

 @param num
 @param multi 乘数
 @param dec 保留位小数
 @return return value description
 */
- (NSString *)multiResultToStringNum:(double)num multi:(double)multi dec:(int)dec
{
    if (multi <= 0 || num<= 0) {
        return @"";
    }
    NSString *formatStr = [NSString stringWithFormat:@"%%0.%df",dec];
    return  [NSString stringWithFormat:formatStr,num * multi];
}



/**
 转换为非0字符串

 @param num 数值
 @param replace 如果数值为0用replace替换 默认为@""
 @param minF 默认为 0
 @param maxF 默认 为 10
 @param minI 默认为1
 @return return value description
 */
- (NSString *)toNonZeroStringNum:(double )num replace:(NSString *)replace minF:(int)minF maxF:(int)maxF minI:(int)minI
{
    if (num <= 0) {
        return replace;
    }else{
       return  [self toStringNum:num minF:minF maxF:maxF minI:minF];
    }
}




@end
