//
//  YPBusinessCar.h
//  YPIsaDemo
//
//  Created by 张义沛 on 2024/12/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPBusinessCar : NSObject

{
    struct {
        char up    : 1;
        char down  : 1;
        char left  : 1;
        char right : 1;
    }_upDownLeftRight;
}



- (void)setUp:(BOOL)up;
- (void)setDown:(BOOL)down;
- (void)setLeft:(BOOL)left;
- (void)setRight:(BOOL)right;

- (BOOL)isUp;
- (BOOL)isDown;
- (BOOL)isLeft;
- (BOOL)isRight;

@end

NS_ASSUME_NONNULL_END
