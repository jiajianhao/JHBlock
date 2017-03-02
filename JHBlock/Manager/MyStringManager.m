//
//  MyStringManager.m
//  JHKVOProject
//
//  Created by admin on 2017/2/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MyStringManager.h"

@implementation MyStringManager
-(MyStringManager*(^)(NSString*))mySpliceString{
    if (_myString==nil) {
        _myString=@"";
    }
    return ^MyStringManager *(NSString * value){
        
        _myString =[NSString stringWithFormat:@"%@%@",_myString,value];
         return self;
    };
}
@end
