//
//  ParaBlockViewController.m
//  JHBlock
//
//  Created by admin on 2017/2/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ParaBlockViewController.h"
#import "MyStringManager.h"
#import "CalculatorManager.h"
@interface ParaBlockViewController ()

@end

@implementation ParaBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /////////bolck 的链式编程思想
    MyStringManager *manager = [[MyStringManager alloc]init];
    manager.mySpliceString(@"你好").mySpliceString(@"Hello");
    
    ////////block作为参数
    [self getBlock:^(NSDictionary*json){
        NSLog(@"%@",json);
    }andPostDataByURL:@"https://api.douban.com/v2/book/1220560"];

    
}
////////////////////////////////

- (void)getBlock:(void (^)(NSDictionary* json))susscess andPostDataByURL:(NSString*)urldata{
    NSURL *url = [NSURL URLWithString:urldata];
    //    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/1220560"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
    
    NSURLSessionDataTask *task =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        NSError *error1;
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error1];
        NSLog(@"%@",dic);
        
        susscess(dic);
        
        //        return dic;
    }];
    
    [task resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
