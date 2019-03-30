
//
//  UIColor+Extension.m
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/30.
//  Copyright © 2019 ML Day. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)




/**
 十六进制表示颜色

 @param hex hex description
 @param alpha alpha description
 @return return value description
 */
- (UIColor *)color_hex:(uint)hex alpha:(float)alpha
{
    
   return  [[UIColor alloc] initWithRed:((hex & 0xFF0000) >> 16) / 255.0 green:((hex & 0x00FF00) >> 8) / 255.0 blue:((hex & 0x0000FF)) / 255.0 alpha:alpha];
    
}


@end
