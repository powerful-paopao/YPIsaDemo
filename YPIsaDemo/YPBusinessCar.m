
//
//  YPBusinessCar.m
//  YPIsaDemo
//
//  Created by 张义沛 on 2024/12/30.
//

#import "YPBusinessCar.h"

@implementation YPBusinessCar

-(void)setUp:(BOOL)up
{
    _upDownLeftRight.up = up;
}

-(void)setDown:(BOOL)down
{
    _upDownLeftRight.down = down;
    
}

- (void)setLeft:(BOOL)left
{
    _upDownLeftRight.left = left;
}

- (void)setRight:(BOOL)right
{
    _upDownLeftRight.right = right;
}

-(BOOL)isUp
{
    return !!_upDownLeftRight.up;
}

-(BOOL)isDown
{
    return !!_upDownLeftRight.down;
}

-(BOOL)isLeft
{
    return !!_upDownLeftRight.left;
    
}
-(BOOL)isRight
{
    return !!_upDownLeftRight.right;
}
@end
