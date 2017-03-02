//
//  MyOperation.m
//  JHBlock
//
//  Created by admin on 2017/3/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MyOperation.h"

@implementation MyOperation


- (BOOL)isConcurrent {
    return YES;
}

- (void)start {
    if ([self isCancelled])
    {
        [self willChangeValueForKey:@"MyOperationIsFinished"];
        finished = YES;
        [self didChangeValueForKey:@"MyOperationIsFinished"];
        return;
    }
    
    [self willChangeValueForKey:@"MyOperationIsExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"MyOperationIsExecuting"];
}

- (void)main {
    @try {
        // Do some work.
        
        [self willChangeValueForKey:@"MyOperationIsFinished"];
        [self willChangeValueForKey:@"MyOperationIsExecuting"];
        executing = NO;
        finished = YES;
        [self didChangeValueForKey:@"MyOperationIsExecuting"];
        [self didChangeValueForKey:@"MyOperationIsFinished"];
        
    }
    @catch(...) {
        // Exception handle.
    } 
} 

@end
