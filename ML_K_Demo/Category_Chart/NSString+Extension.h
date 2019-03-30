//
//  NSString+Extension.h
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/30.
//  Copyright © 2019 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

/**
 计算文字的宽度
 
 @param font font description
 @param size size description
 @return return value description
 */
- (CGSize)sizeWithConstrained:(UIFont *)font constraintRect:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
