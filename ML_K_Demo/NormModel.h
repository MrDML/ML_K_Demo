//
//  NormModel.h
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/27.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NormModel : NSObject


- (void)setMA_value:(CGFloat)value num:(int)num type:(NSString *)type;
- (CGFloat)getMA_num:(int)num type:(NSString *)type;


- (void)setEMA_value:(CGFloat)value num:(int)num type:(NSString *)type;
- (CGFloat)getEMA_num:(int)num type:(NSString *)type;


- (void)setSAM_value:(CGFloat)value num:(int)num type:(NSString *)type;
- (CGFloat)getSAM_num:(int)num type:(NSString *)type;


- (void)setRSI_value:(CGFloat)value num:(int)num type:(NSString *)type;
- (CGFloat)getRSI_num:(int)num type:(NSString *)type;


- (void)setTimeline_value:(CGFloat)value type:(NSString *)type;
- (CGFloat)getTimeline_type:(NSString *)type;


- (void)setKDJ_value:(CGFloat)value type:(NSString *)type;
- (CGFloat)getKDJ_type:(NSString *)type;


- (void)setMacd_value:(CGFloat)value type:(NSString *)type;
- (CGFloat)getMacd_type:(NSString *)type;


- (void)setBOLL_value:(CGFloat)value type:(NSString *)type;
- (CGFloat)getBOLL_type:(NSString *)type;

- (void)setSAR_value:(CGFloat)value type:(NSString *)type;
- (CGFloat)getSAR_type:(NSString *)type;


@end

NS_ASSUME_NONNULL_END
