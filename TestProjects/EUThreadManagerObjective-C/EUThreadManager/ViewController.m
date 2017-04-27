//
//  ViewController.m
//  EUThreadManager
//
//  Created by Vitaliy Yarkun on 4/22/17.
//  Copyright © 2017 Vitaliy Yarkun. All rights reserved.
//

#import "ViewController.h"
#import "EUThreadManager.h"

@interface ViewController ()

@property (nonatomic, strong) EUThreadManager* threadManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    simpleBlock task = ^{
        for (NSInteger i = 0; i < 100000; i++) {
            NSLog(@"Current i: %li", (long)i);
        }
    };
    self.threadManager = EUThreadManager.sharedInstance;
    [self.threadManager runOnBackgroundSimpleTask:task withPriority:kDefaultPriorityExecution andResultMethod:@selector(resultMethod) fromObject:self];
}

-(void) resultMethod {
    NSLog(@"Done!");
}
@end
