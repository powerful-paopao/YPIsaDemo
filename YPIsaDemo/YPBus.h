//
//  YPBus.h
//  YPIsaDemo
//
//  Created by 张义沛 on 2025/1/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPBus : NSObject


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
