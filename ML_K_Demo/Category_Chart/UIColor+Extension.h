//
//  UIColor+Extension.h
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/30.
//  Copyright © 2019 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)
/**
 十六进制表示颜色
 
 @param hex hex description
 @param alpha alpha description
 @return return value description
 */
- (UIColor *)color_hex:(uint)hex alpha:(float)alpha;
@end

NS_ASSUME_NONNULL_END
