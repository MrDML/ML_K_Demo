//
//  NSString+Extension.m
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/30.
//  Copyright © 2019 ML Day. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


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





@end
