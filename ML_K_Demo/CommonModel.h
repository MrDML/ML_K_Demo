//
//  CommonModel.h
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/28.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonModel : NSObject

@end


@interface XAxisToDraw : NSObject
@property (nonatomic, assign) CGRect x_frame;
@property (nonatomic, copy) NSString *sring;
@end

NS_ASSUME_NONNULL_END
