//
//  EUThreadManager.h
//  EUThreadManager
//
//  Created by Vitaliy Yarkun on 4/22/17.
//  Copyright © 2017 Vitaliy Yarkun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^simpleBlock)(void);

typedef enum : NSUInteger {
    kHighPriorityExecution = 1000,
    kDefaultPriorityExecution,
    kLowPriorityExecution,
    kBackgroundPriorityExecution
} TaskPriorityExecution;

@interface EUThreadManager : NSObject

+(instancetype) sharedInstance;

-(void) runOnBackgroundSimpleTask:(simpleBlock) task withPriority:(TaskPriorityExecution) priority andResultMethod:(SEL) method fromObject:(id) object;

@end
