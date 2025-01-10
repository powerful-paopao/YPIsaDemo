//
//  YPCar.m
//  YPIsaDemo
//
//  Created by 张义沛 on 2024/12/26.
//

#import "YPCar.h"

@implementation YPCar

- (instancetype)init
{
    self = [super init];
    if (self) {
//        _upDownLeftRight = 0;
    }
    return self;
}


-(void)setUp:(BOOL)up
{
    if (up) {
        /// 如果需要将值置为1，将源码和掩码进行按位或运算
        _upDownLeftRight |= LHDirectionUpMask;
    }else{
        /// 如果需要将值置为0 // 将源码和按位取反后的掩码进行按位与运算
        _upDownLeftRight &= ~LHDirectionUpMask;
    }
    
}

-(void)setDown:(BOOL)down
{
    if (down) {
        _upDownLeftRight |= LHDirectionDownMask;
    }else{
        _upDownLeftRight &= ~ LHDirectionDownMask;
    }

}

- (void)setLeft:(BOOL)left
{
    if (left) {
        _upDownLeftRight |= LHDirectionLeftMask;
    } else {
        _upDownLeftRight &= ~LHDirectionLeftMask;
    }
}

- (void)setRight:(BOOL)right
{
    if (right) {
        _upDownLeftRight |= LHDirectionRightMask;
    } else {
        _upDownLeftRight &= ~LHDirectionRightMask;
    }
}

-(BOOL)isUp
{
    return !!(_upDownLeftRight & LHDirectionUpMask);
}
-(BOOL)isDown
{
    return !!(_upDownLeftRight & LHDirectionDownMask);

}

-(BOOL)isLeft
{
    return !!(_upDownLeftRight & LHDirectionLeftMask);
 
}
-(BOOL)isRight
{
    return !!(_upDownLeftRight & LHDirectionRightMask);
}

@end
