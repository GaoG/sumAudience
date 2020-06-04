//
//  AnswerView.h
//  SumAudience
//
//  Created by  GaoGao on 2020/5/24.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnswerView : UIView

/// 结果 1回答完毕 2 成功 3失败
-(void)setAnswerResult:(NSInteger )result;

@end

NS_ASSUME_NONNULL_END
