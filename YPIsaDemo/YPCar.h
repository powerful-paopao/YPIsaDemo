//
//  YPCar.h
//  YPIsaDemo
//
//  Created by 张义沛 on 2024/12/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define LHDirectionUpMask    0b00001000
#define LHDirectionDownMask  0b00000100
#define LHDirectionLeftMask  0b00000010
#define LHDirectionRightMask 0b00000001

@interface YPCar : NSObject
{
    char _upDownLeftRight;
    
}

@property (nonatomic, assign) BOOL up;
@property (nonatomic, assign) BOOL down;
@property (nonatomic, assign) BOOL left;
@property (nonatomic, assign) BOOL right;

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
