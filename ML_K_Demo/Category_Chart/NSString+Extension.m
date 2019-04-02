//
//  NSString+Extension.m
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/30.
//  Copyright © 2019 ML Day. All rights reserved.
//

#import "NSString+Extension.h"
#import "MLTools.h"

@implementation NSString (Extension)



/**
 截取数字字符串，小数位大于8位则截取小数8位后的数字

 @param def  默认 8
 @return return value description
 */
- (NSString *)subString:(int)def
{
   NSArray *array = [self componentsSeparatedByString:@"."];
    NSString *newString = @"";
    if (array.count > 2) {
        NSString *secStr = array[1];
        if (secStr.length > def) {
            NSString *formatStr = [NSString stringWithFormat:@"%%0.%df", def];
            
            newString = [NSString stringWithFormat:formatStr, [self toDouble:0 decimal:0]];
            
        }else{
            newString = self;
        }
        
        if (newString) {
            newString = @"0";
        }
    }
    
    return newString;
}



/**
 计算文字的宽度

 @param font font description
 @param size size description
 @return return value description
 */
- (CGSize)sizeWithConstrained:(UIFont *)font constraintRect:(CGSize)size
{
  return  [self boundingRectWithSize:CGSizeMake(MAXFLOAT, size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}



/**
 转 double

 @param def 默认值 0.0
 @param decimal 舍弃小数为精度
 @return return value description
 */
- (double)toDouble:(double)def decimal:(int)decimal
{
    if (self.length > 0 && self != nil) {
         double doubleValue = [self doubleValue];
        if (decimal > 0) {
            doubleValue = [[MLTools defaultInstance] getDownNum:doubleValue decimals:decimal];
        }
         return doubleValue;
    }else{
        return def;
    }
}

- (float)toFloat:(double)def decimal:(int)decimal
{
    if (self.length > 0 && self != nil) {
        double floatValue = [self floatValue];
        
        return floatValue;
    }else{
        return def;
    }
}

- (float)toInt:(double)def
{
    if (self.length > 0 && self != nil) {
        int intValue = [self intValue];
        
        return intValue;
    }else{
        return def;
    }
}


/**
 转 bool

 @param def 默认 NO
 @return <#return value description#>
 */
- (BOOL)toBool:(double)def
{
    if (self.length > 0 && self != nil) {
        int intValue = [self intValue];
        return intValue > 0 ? YES : NO ;
    }else{
        return def;
    }
}







@end
