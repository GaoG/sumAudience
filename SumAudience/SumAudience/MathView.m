//
//  MathView.m
//  SumAudience
//
//  Created by  GaoGao on 2020/5/27.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "MathView.h"

@interface MathView ()

@property (weak, nonatomic) IBOutlet UILabel *numberL;

@end

@implementation MathView



-(void)setNumber:(NSString *)number {
    
    _number = number;
    
    self.numberL.text = number;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
