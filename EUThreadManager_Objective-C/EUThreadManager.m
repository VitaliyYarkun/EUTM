//
//  EUThreadManager.m
//  EUThreadManager
//
//  Created by Vitaliy Yarkun on 4/22/17.
//  Copyright © 2017 Vitaliy Yarkun. All rights reserved.
//

#import "EUThreadManager.h"

@implementation EUThreadManager

+(instancetype) sharedInstance {
    
    static EUThreadManager* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EUThreadManager alloc] init];
    });
    
    return instance;
}

-(void) runOnBackgroundSimpleTask:(simpleBlock) task withPriority:(TaskPriorityExecution) priority andResultMethod:(SEL) resultMethod fromObject:(id) object{
    
    switch (priority) {
        case kHighPriorityExecution:
            [self runHighPriorityTask:task withResultMethod:resultMethod fromObject:object];
            break;
        case kDefaultPriorityExecution:
            [self runDefaultPriorityTask:task withResultMethod:resultMethod fromObject:object];
            break;
        case kLowPriorityExecution:
            [self runLowPriorityTask:task withResultMethod:resultMethod fromObject:object];
            break;
        case kBackgroundPriorityExecution:
            [self runBackgroundPriorityTask:task withResultMethod:resultMethod fromObject:object];
            break;
        default:
            break;
    }
}

-(void) runHighPriorityTask:(simpleBlock) task withResultMethod:(SEL) resultMethod fromObject:(id) object {
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        task();
        dispatch_async(dispatch_get_main_queue(), ^{
            [object performSelector:resultMethod];
        });
    });
}

-(void) runDefaultPriorityTask:(simpleBlock) task withResultMethod:(SEL) resultMethod fromObject:(id) object {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        task();
        dispatch_async(dispatch_get_main_queue(), ^{
            [object performSelector:resultMethod];
        });
    });
}

-(void) runLowPriorityTask:(simpleBlock) task withResultMethod:(SEL) resultMethod fromObject:(id) object {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        task();
        dispatch_async(dispatch_get_main_queue(), ^{
            [object performSelector:resultMethod];
        });
    });
}

-(void) runBackgroundPriorityTask:(simpleBlock) task withResultMethod:(SEL) resultMethod fromObject:(id) object {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        task();
        dispatch_async(dispatch_get_main_queue(), ^{
            [object performSelector:resultMethod];
        });
    });
}

@end
