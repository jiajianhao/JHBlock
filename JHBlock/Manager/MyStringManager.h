//
//  MyStringManager.h
//  JHKVOProject
//
//  Created by admin on 2017/2/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyStringManager : NSObject
@property(nonatomic,strong)NSString *myString;

-(MyStringManager*(^)(NSString*))mySpliceString;
@end
