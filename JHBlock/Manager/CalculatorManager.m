//
//  CalculatorManager.m
//  JHKVOProject
//
//  Created by admin on 2017/2/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CalculatorManager.h"

@implementation CalculatorManager
-(instancetype)add1:(int)value
{
    _result += value;
    return self;
}

-(void)add2:(int)value
{
    _result += value;
}

-(CalculatorManager *(^)(int))add
{
    //方法本身返回一个blockd代码块
    return ^CalculatorManager *(int value){
        _result += value;
        //block块内部再返回一个instance实例
        return self;
    };
}
@end
