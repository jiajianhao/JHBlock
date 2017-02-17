//
//  CalculatorManager.h
//  JHKVOProject
//
//  Created by admin on 2017/2/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorManager : NSObject
/** 结果值*/
@property(assign, nonatomic) int result;
-(instancetype)add1:(int)value;

-(void)add2:(int)value;
-(CalculatorManager *(^)(int))add;
@end
