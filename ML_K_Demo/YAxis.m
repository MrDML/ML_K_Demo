//
//  YAxis.m
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/28.
//  Copyright © 2019年 ML Day. All rights reserved.
//
#import "YAxis.h"


@interface AxisReferenceObj ()
@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) NSArray *pattern;
@end

@implementation AxisReferenceObj


- (instancetype)init
{
    self = [super init];
    if (self) {
     
    }
    return self;
}

- (instancetype)initWithDash:(UIColor *)color pattern:(NSArray *)pattern
{
    self = [super init];
    if (self) {
        self.color = color;
        self.pattern = pattern;
    }
    return self;
}


- (instancetype)initWithSolid:(UIColor *)color pattern:(NSArray *)pattern
{
    self = [super init];
    if (self) {
        self.color = color;
        self.pattern = pattern;
    }
    return self;
}

@end
// =================================================================

@interface YAxis ()

@end

@implementation YAxis


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}






@end

// =================================================================

@interface XAxis ()


@end

@implementation XAxis

@end


