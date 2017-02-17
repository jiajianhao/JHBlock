//
//  ViewController.m
//  JHBlock
//
//  Created by admin on 2017/2/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController.h"
#import "ParaBlockViewController.h"
/////看样式，和函数指针差不多。^代表block，*代表指针
typedef int (^MySum) (int,int);
typedef int (*FP)(int, int) ;
/////直接定义的block
int (^MySum1) (int,int)=^(int a,int b){return a+b;};

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MySum sum1 = ^(int a , int b){
        return a+b;
    };
    
    NSLog(@"%d",sum1(1,2));
    NSLog(@"%d",MySum1(10,20));

    //////
    [self mineFuncPointer];
    //////
}

//////////瞅瞅在.m里面的函数指针

int sum(int a, int b)
{
    NSLog(@"sum: a+b=%d", a + b);
    return a+b;
}
void logSome()
{
    
    NSLog(@"我是void型的输出函数");
    
}

-(void)mineFuncPointer{
    int (*p)(int, int) = sum;
    p(2, 3);

    //指向无参数的函数logSome()函数
    void (*logP)() = logSome;
    // 调用指向函数的指针函数
    logP();
    
    ////////
    FP pp =sum;
    NSLog(@"FP: %d", pp(3,3));

    
    
}

//////////
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ParaBlockViewController *para = [[ParaBlockViewController alloc]init];
    [self.navigationController pushViewController:para animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
