//
//  AnswerView.m
//  SumAudience
//
//  Created by  GaoGao on 2020/5/24.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "AnswerView.h"

@interface AnswerView ()

@property (weak, nonatomic) IBOutlet UIButton *tipsBut;

@property (weak, nonatomic) IBOutlet UIImageView *answerImage;

@end

@implementation AnswerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/// 结果 1回答完毕 2 成功 3失败
-(void)setAnswerResult:(NSInteger )result {
    
    if(result ==1){
        self.answerImage.image = [UIImage imageNamed:@"answer_finish.jpg"];
    }else if (result==2){
        self.answerImage.image = [UIImage imageNamed:@"answer_succeed.jpg"];
    }else if (result==3){
        self.answerImage.image = [UIImage imageNamed:@"answer_fail.jpg"];
    }else{
        self.answerImage.image = [UIImage imageNamed:@"logo_icon.jpg"];
    }
    
}
@end
