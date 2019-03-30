//
//  NSDate+Extension.h
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/30.
//  Copyright © 2019 ML Day. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extension)
/**
 把时间戳转换为用户格式时间
 
 @param timestamp timestamp description
 @param format format description
 @return return value description
 */
- (NSString *)getTimeByStamp:(int)timestamp format:(NSString *)format;
@end

NS_ASSUME_NONNULL_END
