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
@interface ParaBlockViewController (){
 }
@property(nonatomic,assign)BOOL runloop;
@end

@implementation ParaBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /////////bolck 的链式编程思想
    MyStringManager *manager = [[MyStringManager alloc]init];
    manager.mySpliceString(@"你好").mySpliceString(@"Hello");
    
    ////////block作为参数
//    [self getBlock:^(NSDictionary*json){
//        NSLog(@"%@",json);
//    }andPostDataByURL:@"https://api.douban.com/v2/book/1220560"];
    
//    [self groupQueueTest];
//    [self serialQueueTest];
//    [self concurrentQueueTest];
//    [self useRunLoop];
    [self useGCD];
    
}
-(void)useRunLoop{
    _runloop = YES;
    
    __weak typeof (self) weakself =self;
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/1220560"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
    NSURLSessionDataTask *task =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        NSError *error1;
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error1];
        NSLog(@"%@",dic);
        NSLog(@"ok1");
        weakself.runloop = NO;
        
    }];
    
    [task resume];
    
    while (_runloop)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    NSLog(@"ok2");
}
-(void)useGCD{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    
    dispatch_group_async(group, queue , ^{
        dispatch_group_enter(group);
        NSLog(@"queue");

//        __weak typeof (self) weakself =self;
        NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/1220560"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
        NSURLSessionDataTask *task =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
            NSError *error1;
            NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error1];
            NSLog(@"%@",dic);
            NSLog(@"ok1");
            dispatch_group_leave(group);
            
        }];
        
        [task resume];
       
    });
    dispatch_group_async(group, queue1 , ^{
        dispatch_group_enter(group);
        NSLog(@"queue1");

        //        __weak typeof (self) weakself =self;
        NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/1220561"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
        NSURLSessionDataTask *task =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
            NSError *error1;
            NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error1];
            NSLog(@"%@",dic);
            NSLog(@"ok2");
            dispatch_group_leave(group);
            
        }];
        
        [task resume];
        
    });

    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"okkkkkkkk");
    });
}

-(void)mineQueue{
    // 创建一个队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    // 设置最大线程数
    queue.maxConcurrentOperationCount = 1;
    // 创建一个A操作
    NSBlockOperation *operationA = [NSBlockOperation blockOperationWithBlock:^{
//        for (int i = 0; i<10; i++) {
//            NSLog(@"i的值是:%d",i);
//        }
//        NSURL *url = [NSURL URLWithString:urldata];
        
        NSLog(@"i的值是:%d",1);

        NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/1220560"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
        
        NSURLSessionDataTask *task =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
            NSError *error1;
            NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error1];
            NSLog(@"%@",dic);
            
            //        return dic;
        }];
        
        [task resume];

    }];
     // 创建一个B操作
     NSBlockOperation *operationB = [NSBlockOperation blockOperationWithBlock:^{
//         for (int j = 0; j<20; j++) {
//             NSLog(@"j的值是:%d",j);
//         }
         NSLog(@"i的值是:%d",2);
         NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/1220561"];
         
         NSURLSession *session = [NSURLSession sharedSession];
         NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
         
         NSURLSessionDataTask *task =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
             NSError *error1;
             NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error1];
             NSLog(@"%@",dic);
             
             //        return dic;
         }];
         
         [task resume];

    }];
    // 添加依赖 B要在A打印完在进行打印 所以是B依赖于A 那么只需要添加如下代码即可完成
    [operationB addDependency:operationA];
    // 分别加入到队列中

    [queue addOperation:operationA];
    [queue addOperation:operationB];
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

     -(void) groupQueueTest
    
    {
        
        //获取concurrent queue
        
        //dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_queue_t aQueue = dispatch_queue_create("shunxun", DISPATCH_QUEUE_SERIAL);
        
        //创建1个queue group
        
        dispatch_group_t queueGroup = dispatch_group_create();
        
        //任务1
        
        dispatch_group_async(queueGroup, aQueue, ^{
            
            NSLog(@"task 1 begin.");
            
            
            NSLog(@"task 1 end.");
            
        });
        
        //任务2
        
        dispatch_group_async(queueGroup, aQueue, ^{
            
            NSLog(@"task 2 begin.");
            
            
            
            NSLog(@"task 2 end.");
            
        });
        
        //任务3
        
        dispatch_group_async(queueGroup, aQueue, ^{
            
            NSLog(@"task 3 begin.");
            
            
            
            NSLog(@"task 3 end.");
            
        });
        
        NSLog(@"wait task 1,2,3.");
        
        //等待组内任务全部完成
        
        dispatch_group_wait(queueGroup, DISPATCH_TIME_FOREVER);
        
        NSLog(@"task 1,2,3 finished.");
        
        //释放组
        
//        dispatch_release(queueGroup);
        
        //重新创建组
        
        queueGroup = dispatch_group_create();
        
        //任务4
        
        dispatch_group_async(queueGroup, aQueue, ^{
            
            NSLog(@"task 4 begin.");
            
            
            
            NSLog(@"task 4 end.");
            
        });
        
        //任务5
        
        dispatch_group_async(queueGroup, aQueue, ^{
            
            NSLog(@"task 5 begin.");
            
            
            
            NSLog(@"task 5 end.");
            
        });
        
        //任务6
        
        dispatch_group_async(queueGroup, aQueue, ^{
            
            NSLog(@"task 6 begin.");
            
            
            
            NSLog(@"task 6 end.");
            
        });
        
        NSLog(@"wait task 4,5,6.");
        
        //等待组内任务全部完成
        
        dispatch_group_wait(queueGroup, DISPATCH_TIME_FOREVER);
        
        NSLog(@"task 4,5,6 finished.");
        
        //释放组
        
//        dispatch_release(queueGroup);
        
 }

-(void) serialQueueTest

{
    
    //获取concurrent queue
    
    dispatch_queue_t aQueue = dispatch_queue_create("shunxun", DISPATCH_QUEUE_SERIAL);
    
    //任务1
    
    dispatch_async(aQueue, ^{
        
        NSLog(@"task 1 begin.");
        
        
        
        NSLog(@"task 1 end.");
        
        
        
    });
    
    //任务2
    
    dispatch_async(aQueue, ^{
        
        NSLog(@"task 2 begin.");
        
        
        
        NSLog(@"task 2 end.");
        
    });
    
    //任务3
    
    dispatch_async(aQueue, ^{
        
        NSLog(@"task 3 begin.");
        
        
        
        NSLog(@"task 3 end.");
        
    });
    
    
    
//    dispatch_release(aQueue);
    
    //另一个串行队列
    
    dispatch_queue_t aQueue2 = dispatch_queue_create("shunxun", DISPATCH_QUEUE_SERIAL);
    
    //任务4
    
    dispatch_async(aQueue2, ^{
        
        NSLog(@"task 4 begin.");
        
        
        
        NSLog(@"task 4 end.");
        
        
        
    });
    
    //任务5
    
    dispatch_async(aQueue2, ^{
        
        NSLog(@"task 5 begin.");
        
        
        
        NSLog(@"task 5 end.");
        
    });
    
    //任务6
    
    dispatch_async(aQueue2, ^{
        
        NSLog(@"task 6 begin.");
        
        
        
        NSLog(@"task 6 end.");
        
    });
    
    
    
//    dispatch_release(aQueue2);
    
}
-(void)jhConcurrentQueueTest{
    dispatch_semaphore_t jh_sema = dispatch_semaphore_create(2);
    
    dispatch_queue_t aQueue =dispatch_queue_create("flaseConcurrent", DISPATCH_QUEUE_CONCURRENT);
    ////////////////////
    dispatch_semaphore_wait(jh_sema, DISPATCH_TIME_FOREVER);
    
    dispatch_async(aQueue, ^{
        NSLog(@"task 1 begin.");
        
        sleep(2);
        
        NSLog(@"task 1 end.");
        
        dispatch_semaphore_signal(jh_sema);
    });
    ////////////////////
    dispatch_semaphore_wait(jh_sema, DISPATCH_TIME_FOREVER);

    dispatch_async(aQueue, ^{
        NSLog(@"task 2 begin.");
        
        sleep(2);
        
        NSLog(@"task 2 end.");
        
        dispatch_semaphore_signal(jh_sema);
    });
    ////////////////////
    
    
    
    ////////////////////
    
}
//并发
-(void) concurrentQueueTest

{
    
    dispatch_semaphore_t fd_sema = dispatch_semaphore_create(4);
    
    
    
    //获取concurrent queue
    
    dispatch_queue_t aQueue = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    
    
    dispatch_semaphore_wait(fd_sema, DISPATCH_TIME_FOREVER);
    
    
    
    //任务1
    
    dispatch_async(aQueue, ^{
        
        NSLog(@"task 1 begin.");
        
        
        
        sleep(10);
        
        NSLog(@"task 1 end.");
        
        dispatch_semaphore_signal(fd_sema);
        
        
        
    });
    
    
    
    dispatch_semaphore_wait(fd_sema, DISPATCH_TIME_FOREVER);
    
    
    
    //任务2
    
    dispatch_async(aQueue, ^{
        
        NSLog(@"task 2 begin.");
        
        
        
        sleep(9);
        
        NSLog(@"task 2 end.");
        
        dispatch_semaphore_signal(fd_sema);
        
    });
    
    
    
    dispatch_semaphore_wait(fd_sema, DISPATCH_TIME_FOREVER);
    
    
    
    //任务3
    
    dispatch_async(aQueue, ^{
        
        NSLog(@"task 3 begin.");
        
        sleep(8);
        
        NSLog(@"task 3 end.");
        
        dispatch_semaphore_signal(fd_sema);
        
    });
    
    
    
    dispatch_semaphore_wait(fd_sema, DISPATCH_TIME_FOREVER);
    
    
    
    //任务4
    
    dispatch_async(aQueue, ^{
        
        NSLog(@"task 4 begin.");
        
        sleep(7);
        
        NSLog(@"task 4 end.");
        
        dispatch_semaphore_signal(fd_sema);
        
        
        
    });
    
    
    
    dispatch_semaphore_wait(fd_sema, DISPATCH_TIME_FOREVER);
    
    
    
    //任务5
    
    dispatch_async(aQueue, ^{
        
        NSLog(@"task 5 begin.");
        
        sleep(6);
        
        NSLog(@"task 5 end.");
        
        dispatch_semaphore_signal(fd_sema);
        
    });
    
    
    
    dispatch_semaphore_wait(fd_sema, DISPATCH_TIME_FOREVER);
    
    
    
    //任务6
    
    dispatch_async(aQueue, ^{
        
        NSLog(@"task 6 begin.");
        
        sleep(5);
        
        NSLog(@"task 6 end.");
        
        dispatch_semaphore_signal(fd_sema);
        
    });
    
    
    
    dispatch_semaphore_wait(fd_sema, DISPATCH_TIME_FOREVER);
    
    
    
    dispatch_async(aQueue, ^{
        
        NSLog(@"task 7 begin.");
        
        sleep(4);
        
        NSLog(@"task 7 end.");
        
        dispatch_semaphore_signal(fd_sema);
        
    });
    
    
    
    dispatch_semaphore_wait(fd_sema, DISPATCH_TIME_FOREVER);
    
    
    
    dispatch_async(aQueue, ^{
        
        NSLog(@"task 8 begin.");
        
        sleep(3);
        
        NSLog(@"task 8 end.");
        
        dispatch_semaphore_signal(fd_sema);
        
    });
    
    
    
    dispatch_semaphore_wait(fd_sema, DISPATCH_TIME_FOREVER);
    
    
    
    dispatch_async(aQueue, ^{
        
        NSLog(@"task 9 begin.");
        
        sleep(2);
        
        NSLog(@"task 9 end.");
        
        dispatch_semaphore_signal(fd_sema);
        
    });
    
    
    
    dispatch_semaphore_wait(fd_sema, DISPATCH_TIME_FOREVER);
    
    
    
    dispatch_async(aQueue, ^{
        
        NSLog(@"task 10 begin.");
        
        sleep(1);
        
        NSLog(@"task 10 end.");
        
        dispatch_semaphore_signal(fd_sema);
        
    });
    
    
    
    dispatch_semaphore_wait(fd_sema, DISPATCH_TIME_FOREVER);
    
    
    
    dispatch_async(aQueue, ^{
        
        NSLog(@"task 11 begin.");
        
        
        
        NSLog(@"task 11 end.");
        
        dispatch_semaphore_signal(fd_sema);
        
    });
    
//    dispatch_release(aQueue);
    
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
