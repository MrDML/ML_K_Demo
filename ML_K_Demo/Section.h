//
//  Section.h
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/17.
//  Copyright © 2019 ML Day. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Section : NSObject

/**
 每个区的frame
 */
@property (nonatomic, assign) CGRect frame;


/**
 section 
 */
@property (nonatomic, assign) UIEdgeInsets padding;

/**
 当前区的索引值
 */
@property (nonatomic, assign) NSInteger index;

/**
 每个区所占比例
 */
@property (nonatomic, assign) int rations;

/**
 指定固定高度,如果该值等于0,每个区的高度则通过rations 计算
 */
@property (nonatomic, assign) CGFloat fixHeight;


/**
 当前区是否隐藏
 */
@property (nonatomic, assign) BOOL hiddent;



@end

NS_ASSUME_NONNULL_END
