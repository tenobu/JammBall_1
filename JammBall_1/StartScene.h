//
//  StartScene.h
//  JammBall_1
//
//  Created by 寺内 信夫 on 2014/10/17.
//  Copyright (c) 2014年 寺内 信夫. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface StartScene : SKScene

- (void)  setStatusData: (NSString *)string;
- (void)setReceivedData: (NSString *)string;

- (void)setIndex: (NSInteger)index
			name: (NSString *)name
		 command: (NSString *)command
		  tensuu: (NSString *)tensuu
		 message: (NSString *)message;

@end
