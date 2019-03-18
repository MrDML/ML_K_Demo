//
//  ChartAlgorithm.m
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/18.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import "ChartAlgorithm.h"


#define AbstractMethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]

@implementation ChartAlgorithm

- (instancetype)init
{
    NSAssert(![self isMemberOfClass:[ChartAlgorithm class]], @"ChartAlgorithm is an abstract class, you should not instantiate it directly.");
    self = [super init];
    return self;
}

- (ChartItem *)handleAlgorithm:(NSArray<ChartItem *> *)datas
{
    AbstractMethodNotImplemented();
}

@end
