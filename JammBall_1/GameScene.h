//
//  GameScene.h
//  Game_008
//

//  Copyright (c) 2014年 寺内 信夫. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

- (void)startGame;

- (void)  setText: (NSString *)string;

- (void)setIndex: (NSInteger)index
		    name: (NSString *)name
		  tensuu: (NSString *)tensuu;

@end
