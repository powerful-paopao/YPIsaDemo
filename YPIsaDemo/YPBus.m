//
//  YPBus.m
//  YPIsaDemo
//
//  Created by 张义沛 on 2025/1/2.
//

#import "YPBus.h"

#define LHDirectionUpMask    0b00001000
#define LHDirectionDownMask  0b00000100
#define LHDirectionLeftMask  0b00000010
#define LHDirectionRightMask 0b00000001

@interface YPBus() {
    union{
        char bits;
        struct{
            char up   : 1;
            char down : 1;
            char left : 1;
            char right: 1;
        };
        
    }_upDownLeftRight;
 
}
@end

@implementation YPBus

- (instancetype)init
{
    self = [super init];
    if (self) {
        _upDownLeftRight.bits = 0b00000000;
    }
    return self;
}

- (void)setUp:(BOOL)up
{
    if (up) {
 
        _upDownLeftRight.bits |= LHDirectionUpMask;
    }else{
        _upDownLeftRight.bits &= ~LHDirectionUpMask;
    }
 
    
}

-(void)setDown:(BOOL)down
{
    if (down) {
        _upDownLeftRight.bits |= LHDirectionDownMask;
    }else{
        _upDownLeftRight.bits &= ~ LHDirectionDownMask;
    }
     
}

- (void)setLeft:(BOOL)left
{
    if (left) {
        _upDownLeftRight.bits |= LHDirectionLeftMask;
    } else {
        _upDownLeftRight.bits &= ~LHDirectionLeftMask;
    }
}

- (void)setRight:(BOOL)right
{
    if (right) {
        _upDownLeftRight.bits |= LHDirectionRightMask;
    } else {
        _upDownLeftRight.bits &= ~LHDirectionRightMask;
    }
}
 
- (BOOL)isUp
{
    return !!(_upDownLeftRight.bits & LHDirectionUpMask);
}
-(BOOL)isDown
{
    return !!(_upDownLeftRight.bits & LHDirectionDownMask);
 }

- (BOOL)isLeft
{
     return !!(_upDownLeftRight.bits & LHDirectionLeftMask);
}

- (BOOL)isRight
{
    return !!(_upDownLeftRight.bits & LHDirectionRightMask);
 
}
@end
