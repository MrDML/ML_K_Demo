//
//  Section.h
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/17.
//  Copyright © 2019 ML Day. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "Series.h"
#import "YAxis.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SectionValueType){
    SectionValueType_master, // 主图
    SectionValueType_assistant // 幅图
    
};

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
@property (nonatomic, assign) BOOL hidden;
/**
 保留小数位 默认2位
 */
@property (nonatomic, assign) int decimal;
/**
 升的颜色
 */
@property (nonatomic, strong) UIColor *upColor;
/**
 跌的颜色
 */
@property (nonatomic, strong) UIColor *downColor;

/**
 字体大小
 */
@property (nonatomic, strong) UIFont *lableFont;

/**
 当前区是主区还是副区， 默认是主区
 */
@property (nonatomic, assign) SectionValueType type;

/**
 未知类型
 */
@property (nonatomic, copy) NSString *key;

/**
 区域的名字
 */
@property (nonatomic, copy) NSString *name;

/**
 是否要分页显示
 */
@property (nonatomic, assign) BOOL paging;


/**
 如果区中有分页 该值会被使用
 */
@property (nonatomic, assign) int selectedIndex;

/**
 每个分区包含多组系列，每个系列包含多个点线模型
 */
@property (nonatomic, strong) NSArray <Series *>*series;

@property (nonatomic, assign)  int tickInterval;

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 标题是否显示在外面
 */
@property (nonatomic, assign) BOOL titleShowOutSide;


/**
 是否要显示标题文本
 */
@property (nonatomic, assign) BOOL showTitle;

/**
 默认黑色
 */
@property (nonatomic, strong) UIColor *backgroundColor;



/**
 Y轴参数
 */
@property (nonatomic, strong) YAxis *yAxis;


/**
 X轴参数
 */
@property (nonatomic, strong) YAxis *xAxis;





@end

NS_ASSUME_NONNULL_END
