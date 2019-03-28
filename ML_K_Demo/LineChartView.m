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
#import "CommonModel.h"


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
    BOOL res = [self initChart];
    if (res) {
        
        // 待绘制的x坐标标签（数组中防暑的是i）
        NSMutableArray<XAxisToDraw *>* xAxisToDraws = [NSMutableArray array];
        
        // 绘制每个分区        (section区对象， index保留小数位)
        [self buildSection:^(Section *section, int index) {
            
            
            int decimal = 2;
            // 获取各个分区保留位数 如果代理没有设置那么就默认保留两位小数
            if ([self.delegate respondsToSelector:@selector(lineChart:decimalAt:)]) {
               decimal = [self.delegate lineChart:self decimalAt:index];
            }
            // 设置小数点保留参数
            section.decimal = decimal;
            
            // 初始化Y轴数据
//            self
            
            
        }];
    }
    
   
   
    
    
    
    
   
}




/**
 初始化分区上各个线的Y轴

 @param section section description
 */
- (void)initYAxis:(Section *)section
{
    
    if (section.series.count > 0) {
        // 建立分区没每条线的坐标系
    
    }
    
    
   
}







/**
 重置数据
 */
- (void)resetData
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
        
        // 执行算法方程式计算值，添加到对象中
        for (ChartAlgorithm *Algorithm in self.handlerOfAlgorithms) {
            [Algorithm handleAlgorithm:self.datas];
        }

    } while (0);
    
}


/**
 初始化图标结构
 */
- (BOOL)initChart
{
    // 通过代理获取总共的数据点个数
    if ( [self.delegate respondsToSelector:@selector(numberOfPointsInKLineChart:)]) {
        self.plotCount = [self.delegate numberOfPointsInKLineChart:self];
    }
    // 数据条数不一致，需要重新计算
    if (self.plotCount != self.datas.count) {
        // 重新初始化数据
        [self resetData];
    }
    
    // 计算显示起始点 以及范围
    do {
        // 如果数据 小于等于0 不在执行 该部分的代码
        if (self.plotCount <= 0 ) {
            break;
        }
        
        // 如果现实全部，显示范围为全部数据
        if (self.isShowAll) {
            // 数据范围
            self.range = self.plotCount;
            // 开始位置
            self.rangeFrom=0;
            // 结束位置
            self.rangeTo = self.plotCount;
        }
        
        // 图标刷新滚动默认时， 如果第一次初始化，就默认滚动到最后显示 (设定好位置，下面代码使用)
        if (self.scrollToPosition == ChartViewScrollPosition_None) {
            // 如果图表的索引为0，则进行初始化
            if (self.rangeTo == 0 || self.plotCount < self.rangeTo) {
                self.scrollToPosition = ChartViewScrollPosition_End;
            }
        }
        
        
        if (self.scrollToPosition == ChartViewScrollPosition_Top) { // 计算rangTo的长度
            self.rangeFrom = 0;
            if (self.rangeFrom + self.range < self.plotCount) {
                self.rangeTo = self.rangeFrom + self.range;
            }else{
                self.rangeTo = self.plotCount;
            }
            self.selectedIndex = -1;
        }else if (self.scrollToPosition == ChartViewScrollPosition_End){
            self.rangeTo = self.plotCount;
            if (self.rangeTo - self.range > 0) {
                self.rangeFrom = self.rangeTo - self.range;
            }else{
                self.rangeFrom = 0;
            }
            self.selectedIndex = -1;

        }
        
        
        
        
        
        
    } while (0);
    
    // 重置图表刷新滚动 默认不处理
    self.scrollToPosition = ChartViewScrollPosition_None;
    
    // 超出范围，选择最后一个元素选中
    if (self.selectedIndex < 0 || self.selectedIndex >= self.rangeTo) {
        self.selectedIndex = self.range - 1;
    }
    
    // 创建背景
    
    
    MLShapeLayer *backgroundLayer = [[MLShapeLayer alloc] init];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    UIBezierPath *backgroundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, height) cornerRadius:0];
    backgroundLayer.path = backgroundPath.CGPath;
    backgroundLayer.fillColor = self.backgroundColor.CGColor;
    [self.drawLayer addSublayer:backgroundLayer];
    
    // 数据重置后， 判断是否存在
    return self.datas > 0 ? YES : NO;
    
    
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
