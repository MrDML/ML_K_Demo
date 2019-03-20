//
//  LineChartView.m
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/17.
//  Copyright © 2019 ML Day. All rights reserved.
//

#import "LineChartView.h"
#import "MLTextLayer.h"
#import "MLShapeLayer.h"
#import "Section.h"
#import "ChartItem.h"

static dispatch_group_t group_t;

static dispatch_queue_t queue_t;

inline static void initDispatch()
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue_t  = dispatch_queue_create("www.k.com", DISPATCH_QUEUE_SERIAL);
        
        group_t  = dispatch_group_create();
        
    });
    
}

@interface LineChartView ()
@property (nonatomic, strong) MLShapeLayer *drawLayer;


@property (nonatomic, strong) dispatch_group_t group_t;

@property (nonatomic, strong)  dispatch_queue_t queue_t;
/**
 总共有多少个数据点
 */
@property (nonatomic, assign) int plotCount;

/**
 可见区域的开始索引位
 */
@property (nonatomic, assign) int rangeFrom;

/**
 可见区域的结束索引位
 */
@property (nonatomic, assign) int rangeTo;

/**
 显示在可见区域的数据个数 默认 77
 */
@property (nonatomic, assign) int range;

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *datas;


@end


@implementation LineChartView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
@property (nonatomic, strong) MLShapeLayer *drawLayer;    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 初始化队列组
        initDispatch();
       
        // 初始化默认数据
        [self defaultValue];
        
        // 添加视图
        [self addSubViews];
    }
    return self;
}


/**
 初始化默认数据
 */
- (void)defaultValue
{
    self.plotCount = 77;
}


- (void)addSubViews
{
    [self.layer addSublayer:self.drawLayer];
}


// 绘制图标 （该方法会多次调用）
- (void)drawLayerView
{
    // 先清空所有的子图层
    
    // 初始化图形数据
    dispatch_group_async(group_t, queue_t, ^{
        [self initChart];
    });

    
    dispatch_group_notify(group_t,queue_t, ^{
        // 绘制每个分区
        [self buildSection:^(Section *section, int index) {
            
            
        }];
    });
    
   
    
    
    
    
   
}



- (void)initChart
{
    // 删除所有的数据源
    [self.datas removeAllObjects];
    
    // 通过代理获取总共的数据点个数
    if ( [self.delegate respondsToSelector:@selector(numberOfPointsInKLineChart:)]) {
        self.plotCount = [self.delegate numberOfPointsInKLineChart:self];
    }
    
    do {
        if (self.plotCount <= 0) {
            break;
        }
        
        // 通过代理获取数据源对象
        for (int i = 0; i < self.plotCount - 1; i ++) {
            
            if ([self.delegate respondsToSelector:@selector(lineChart:vlaueForPointAtIndex:)]) {
                  ChartItem *item  =   [self.delegate lineChart:self vlaueForPointAtIndex:i];
                // 将获取到的对象，添加到数据源中
                [self.datas addObject:item];
            }
        }
    
    } while (0);
    
}





/**
 初始化各个分区

 @param completeBlock completeBlock description
 */
- (void)buildSection:(void (^)(Section *section, int index))completeBlock
{
    
    CGFloat height = self.frame.size.height - (self.padding.top + self.padding.bottom);
    CGFloat weight = self.frame.size.width - (self.padding.left + self.padding.right);
    
    // x 轴的起始高度
    CGFloat xAxisHeight = 0;
   
    if ( [self.delegate respondsToSelector:@selector(heightForXAxisInKLineChart:)]) {
        xAxisHeight  = [self.delegate heightForXAxisInKLineChart:self];
    }
    // 区剩余高度
    height = height - xAxisHeight;
    
    // 获取总比例
    CGFloat total_rations = [self getSectionRatioTotal];
    
    CGFloat offsetY = self.padding.top;
    
    for (int i = 0; i < self.sections.count; i++) {
        
        Section *section = self.sections[i];
        
        // 每个区的高度
        CGFloat heightOfSection = 0.f;
        // 每个区的宽度
        CGFloat widthofSection= weight;
        
        // 开始计算每个区的高度
        if (section.hidden) {
            continue;
        }
        if (section.fixHeight > 0) {
            // 当前区的高度
            heightOfSection = heightOfSection;
            // 请区域所剩高度
            height = height - heightOfSection;
        }else{
            // 当前区域高度
           heightOfSection = height * (section.rations / total_rations) ;
            
        }
        // 设置y 轴标签的宽度
        if ([self.delegate respondsToSelector:@selector(widthForYAxisLabelInKLineChart:)]) {
            self.yAxisLabelWidth = [self.delegate widthForYAxisLabelInKLineChart:self];
        }
        
        // 设置分区的 padding
        [self setSectionPadddingWtihShowYAxisLabel:section];
     

        // 计算每个section的frame

        CGRect rect = {
            {0 + self.padding.left,offsetY},
            {widthofSection,heightOfSection}
        };
        
        section.frame = rect;
        
        // 计算下一个分区的偏移量
        offsetY = offsetY + section.frame.size.height;
       
        // 如果该分区需要显示X轴， 则下一个分区的Y 起始位置需要加上Y轴的(起始)高度
        if (self.showXAxisOnSectionIndex == i) {
            
            offsetY += xAxisHeight;
        }

        // 回调给外界使用
        if (completeBlock) {
            completeBlock(section,i);
        }

        
    }
    
    
}


/**
 设置区的padding
 */
- (void)setSectionPadddingWtihShowYAxisLabel:(Section *)section
{
    switch (self.showYAxisLabel) {
        case YAxisShowPostion_left: // 左侧显示 是否需要把Y轴内嵌到图标中
        {
            UIEdgeInsets padding = section.padding;
            padding.left = self.isInnerYAxis?section.padding.left:self.yAxisLabelWidth;
            padding.right = 0;
            section.padding = padding;
        }
            break;
        case YAxisShowPostion_right: // 右侧显示
        {
            UIEdgeInsets padding = section.padding;
            padding.right = self.isInnerYAxis?section.padding.right:self.yAxisLabelWidth;
            padding.left = 0;
            section.padding = padding;
            
        }
            break;
        case YAxisShowPostion_none: // 都不显示
        {
            UIEdgeInsets padding = section.padding;
            padding.right = 0;
            padding.left = 0;
            section.padding = padding;
            
        }
            break;
            
        default:
            break;
    }
    
}



/**
 获取每个区域的所占比例总和
 如果使用fixHeight, rations 需要设置为 0
 @return total Ratio Value
 */
- (CGFloat)getSectionRatioTotal
{
    int total = 0;
    for (int i = 0; i < self.sections.count; i++) {
        Section *section = self.sections[i];
        section.index = i;
        
        if (section.hidden == NO) {
            total += section.rations;
        }
    }
    return total;
}

- (MLShapeLayer *)drawLayer
{
    if (_drawLayer == nil) {
        _drawLayer = [MLShapeLayer new];
    }
    return _drawLayer;
}


@end
