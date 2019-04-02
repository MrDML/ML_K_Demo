//
//  MLTools.h
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/4/2.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLTools : NSObject

+ (instancetype)defaultInstance;

- (double)getDownNum:(double)num decimals:(int)index;
- (NSString *)toFloorNum:(double)num places:(int)places;
- (NSString *)toStringNum:(double)num minF:(int)minF maxF:(int)maxF minI:(int)minI;
- (NSString *)toMultipleNum:(double)num multiole:(int)multiole def:(int)def;
- (NSString *)divideResultToStringNum:(double)num divisor:(double)divisor dec:(int)dec;
- (NSString *)multiResultToStringNum:(double)num multi:(double)multi dec:(int)dec;
- (NSString *)toNonZeroStringNum:(double )num replace:(NSString *)replace minF:(int)minF maxF:(int)maxF minI:(int)minI;
@end

NS_ASSUME_NONNULL_END
