//
//  ViewController.m
//  YPIsaDemo
//
//  Created by 张义沛 on 2024/12/26.
//

#import "ViewController.h"
#import "YPCar.h"
#import "YPBusinessCar.h"
#import "YPBus.h"
#import <objc/runtime.h>
#import "yp-printf.h"
#import "YPObjectStructure.h"
#import "YPSubBus.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
# if __arm64__
    NSLog(@"当前是 ARM64 架构");
#else
    NSLog(@"当前不是 ARM64 架构");
#endif

    [self testUnion];
    [self testIsa];
}

- (void)testUnion {
    YPCar *car = [[YPCar alloc] init];
    [car setDown:YES];
    NSLog(@"car isUp = %d, isDown = %d, isLeft = %d, isRight = %d", car.isUp, car.isDown, car.isLeft, car.isRight);
    unsigned long size = class_getInstanceSize(car.class);
    NSLog(@"car对象所占用内存为：%lu", size);
    
    YPBusinessCar *businessCar = [[YPBusinessCar alloc] init];
    [businessCar setDown:YES];
    NSLog(@"businessCar isUp = %d, isDown = %d, isLeft = %d, isRight = %d", businessCar.isUp, businessCar.isDown, businessCar.isLeft, businessCar.isRight);
    
    YPBus *bus = [[YPBus alloc] init];
    [bus setDown:YES];
    [bus setLeft:YES];
    NSLog(@"bus isUp = %d, isDown = %d, isLeft = %d, isRight = %d", bus.isUp, bus.isDown, bus.isLeft, bus.isRight);
    
}

- (void)testIsa {
    YPBus *bus = [[YPBus alloc] init];

    //    objc_setAssociatedObject(bus, @"12", @"11111", OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    for (int i = 0; i < 10; i++) {
        [bus retain];
    }
    NSLog(@"retainCount = %ld", [bus retainCount]);

//    uintptr_t isa = [YPObjectStructure printObjectISA:bus];
//    isa_t *t = [YPObjectStructure printObjectISA_T:bus];
    [YPObjectStructure printObjectStructure:bus];
//    [YPObjectStructure printISAStructure:bus];
    
    YPSubBus *subBus = [[YPSubBus alloc] init];

    [YPObjectStructure printObjectStructure:subBus];
//    [YPObjectStructure printISAStructure:subBus];
    NSObject *obj = [[NSObject alloc] init];
    [YPObjectStructure printObjectStructure:obj];

}

@end
