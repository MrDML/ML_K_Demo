//
//  NSDate+Extension.m
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/30.
//  Copyright © 2019 ML Day. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)


/**
 把时间戳转换为用户格式时间

 @param timestamp timestamp description
 @param format format description
 @return return value description
 */
- (NSString *)getTimeByStamp:(int)timestamp format:(NSString *)format
{
    
    NSString *time = @"";
    if (timestamp == 0) {
        return @"";
    }
    NSDate *confromTimesp = [[NSDate alloc] initWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    time = [formatter stringFromDate:confromTimesp];
    return time;
}





@end
