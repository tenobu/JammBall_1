//
//  GameScene.m
//  Game_008
//
//  Created by 寺内 信夫 on 2014/10/09.
//  Copyright (c) 2014年 寺内 信夫. All rights reserved.
//

#import "GameScene.h"

#import <CoreMotion/CoreMotion.h>
#import "ViewController.h"

@interface GameScene ()
{
	
@private
	
	//AppDelegate *app;
	
	NSString *string_1;
	
	NSTimer *timer, *timer2;
	
	NSInteger integer_MyTensu;
	
	//加速度センサー
	CMMotionManager *motionManager;
	
	NSInteger integer_BallCount;
	
	//穴の複数管理
	NSInteger integer_AnaCount, integer_LevelCount, integer_PlayCount;
	NSDate *date_Play;
	
	NSMutableArray *array_Ana;
	CGPoint point_XY[10];
	
	//ボールの複数管理
	NSMutableArray *array_Ball;
	
	NSTimer *timer_Kieru, *timer_LevelClear, *timer_LabelClear;

	SKLabelNode *label_MyLevel;
	SKLabelNode *label_Label;
	
	SKLabelNode *label_My;
	SKLabelNode *label_MyTensu;
	SKLabelNode *label_Teki_1;
	SKLabelNode *label_TekiTensu_1;
	SKLabelNode *label_Teki_2;
	SKLabelNode *label_TekiTensu_2;
	SKLabelNode *label_Teki_3;
	SKLabelNode *label_TekiTensu_3;
	SKLabelNode *label_Teki_4;
	SKLabelNode *label_TekiTensu_4;
	
}

@end

@implementation GameScene

- (void)didMoveToView: (SKView *)view
{
	
	//		x = (295 : 728);
	//		y = (  0 : 768);
	
	/* Setup your scene here */
	label_MyLevel = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_MyLevel.text      = @"";
	label_MyLevel.fontSize  = 50;
	label_MyLevel.position  = CGPointMake( CGRectGetMidX( self.frame ),
										   CGRectGetMidY( self.frame ));
	label_MyLevel.zPosition = 10;
	
	[self addChild: label_MyLevel];
	
	
	label_Label = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_Label.text      = @"";
	label_Label.fontSize  = 20;
	label_Label.position  = CGPointMake( CGRectGetMidX( self.frame ),
										 CGRectGetMidY( self.frame ) + 50 );
	label_Label.zPosition = 10;
	
	[self addChild: label_Label];
	
	
	NSInteger x1 = 320, y1 = 700;

	label_My = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_My.text = @"自分";
	label_My.fontSize  = 20;
	label_My.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	label_My.position  = CGPointMake( x1, y1);
	label_My.zPosition = 10;
	
	[self addChild: label_My];
	
	
	label_MyTensu = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_MyTensu.text = @"000000";
	label_MyTensu.fontSize = 20;
	label_MyTensu.position = CGPointMake( x1 + 250, y1);
	label_MyTensu.zPosition = 10;
	
	[self addChild: label_MyTensu];
	
	
	y1 -= 30;
	
	
	label_Teki_1 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_Teki_1.text = @"";
	label_Teki_1.fontSize = 20;
	label_Teki_1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	label_Teki_1.position = CGPointMake( x1, y1 );
	label_Teki_1.zPosition = 10;
	
	[self addChild: label_Teki_1];
	
	
	label_TekiTensu_1 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_TekiTensu_1.text = @"000000";
	label_TekiTensu_1.fontSize = 20;
	label_TekiTensu_1.position = CGPointMake( x1 + 250, y1);
	label_TekiTensu_1.zPosition = 10;
	
	[self addChild: label_TekiTensu_1];
	
	
	y1 -= 30;
	
	
	label_Teki_2 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_Teki_2.text = @"";
	label_Teki_2.fontSize = 20;
	label_Teki_2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	label_Teki_2.position = CGPointMake( x1, y1 );
	label_Teki_2.zPosition = 10;
	
	[self addChild: label_Teki_2];
	
	
	label_TekiTensu_2 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_TekiTensu_2.text = @"000000";
	label_TekiTensu_2.fontSize = 20;
	label_TekiTensu_2.position = CGPointMake( x1 + 250, y1);
	label_TekiTensu_2.zPosition = 10;
	
	[self addChild: label_TekiTensu_2];
	
	
	y1 -= 30;
	
	
	label_Teki_3 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_Teki_3.text = @"";
	label_Teki_3.fontSize = 20;
	label_Teki_3.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	label_Teki_3.position = CGPointMake( x1, y1 );
	label_Teki_3.zPosition = 10;
	
	[self addChild: label_Teki_3];
	
	
	label_TekiTensu_3 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_TekiTensu_3.text = @"000000";
	label_TekiTensu_3.fontSize = 20;
	label_TekiTensu_3.position = CGPointMake( x1 + 250, y1);
	label_TekiTensu_3.zPosition = 10;
	
	[self addChild: label_TekiTensu_3];
	
	
	y1 -= 30;
	
	
	label_Teki_4 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_Teki_4.text = @"";
	label_Teki_4.fontSize = 20;
	label_Teki_4.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	label_Teki_4.position = CGPointMake( x1, y1 );
	label_Teki_4.zPosition = 10;
	
	[self addChild: label_Teki_4];
	
	
	label_TekiTensu_4 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_TekiTensu_4.text = @"000000";
	label_TekiTensu_4.fontSize = 20;
	label_TekiTensu_4.position = CGPointMake( x1 + 250, y1);
	label_TekiTensu_4.zPosition = 10;
	
	[self addChild: label_TekiTensu_4];
	
	
	integer_LevelCount = 1;
	integer_AnaCount   = 3;
	integer_PlayCount  = 60;
	
	
	[self initGame];
	
}

- (void)touchesBegan: (NSSet *)touches
		   withEvent: (UIEvent *)event
{

	/* Called when a touch begins */
//    for (UITouch *touch in touches) {
//		
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed: @"Spaceship"];
//        
//        sprite.xScale = 0.5;
//        sprite.yScale = 0.5;
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//		
//    }
	
//	[self removeAllAna];
//	
//	[self initAna];
	
}

- (void)update: (CFTimeInterval)currentTime
{

	/* Called before each frame is rendered */

}

- (void)initGame
{
	
	motionManager = [[CMMotionManager alloc] init];
	
	if ( motionManager.accelerometerAvailable ) {
		
		// センサーの更新間隔の指定
		motionManager.accelerometerUpdateInterval = 0.03;
		
		// ハンドラを設定
		CMAccelerometerHandler handler = ^( CMAccelerometerData *data, NSError *error )
		{
			
			// 加速度センサー
			double xac = data.acceleration.x;
			double yac = data.acceleration.y;
			
			for ( NSMutableDictionary *dic in array_Ball ) {
				
//				UIImageView *imageView = [dic objectForKey: @"image_view"];
				SKSpriteNode *ball = [dic objectForKey: @"SKSpriteNode"];
				
				NSNumber *number   = [dic objectForKey: @"speed_x"];
				float speed_x = number.floatValue;
				
				number             = [dic objectForKey: @"speed_y"];
				float speed_y = number.floatValue;
				
				speed_x += xac;
				speed_y += yac;
				
				CGFloat posX = ball.position.x + speed_x;
				CGFloat posY = ball.position.y + speed_y;
				
				//		x = (295 : 728);
				//		y = (  0 : 768);
				//端にあたったら跳ね返る処理
//				if ( posX < 0.0 ) {
				if ( posX < 295 ) {
				
//					posX = 0.0;
					posX = 295;
					
					//左の壁にあたったら0.4倍の力で跳ね返る
					speed_x *= -0.4;
					
				} else if ( posX > 728/*self.view.bounds.size.width*/ ) {
					
					posX = 728;//self.view.bounds.size.width;
					
					//右の壁にあたったら0.4倍の力で跳ね返る
					speed_x *= -0.4;
					
				}
				if (posY < 0.0) {
					
					posY = 0.0;
					
					//上の壁にあたっても跳ね返らない
					speed_y = 0.0;
					
				} else if ( posY > 768/*self.view.bounds.size.height*/ ) {
					
					posY = 768;//self.view.bounds.size.height;
					
					//下の壁にあたったら1.4倍の力で跳ね返る
					speed_y *= -1.4;//-1.5
					
				}
				
				ball.position = CGPointMake( posX, posY );
				
				NSNumber *number_x = [[NSNumber alloc] initWithFloat: speed_x];
				NSNumber *number_y = [[NSNumber alloc] initWithFloat: speed_y];
				
				[dic setObject: ball      forKey: @"SKSpriteNode"];
				[dic setObject: number_x  forKey: @"speed_x"];
				[dic setObject: number_y  forKey: @"speed_y"];
				
			}
			
		};
		
		// 加速度の取得開始
		[motionManager startAccelerometerUpdatesToQueue: [NSOperationQueue currentQueue]
											withHandler: handler];
		
	}
	
}

- (void)initAna
{
	
	//		x = (295 : 728);
	//		y = (  0 : 768);
	
	for ( int i = 0; i < integer_AnaCount; i ++ ) {
		
		int x = arc4random_uniform( 728 - 295 - 100 ) + ( 295 + 50 );
		int y = arc4random_uniform( 768       - 100 ) +         50;
		

		NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
		
		CGPoint location = CGPointMake( x, y );
		
		SKSpriteNode *blackhall = [SKSpriteNode spriteNodeWithImageNamed: @"Blackhall"];
		
		blackhall.xScale    = 0.08;
		blackhall.yScale    = 0.08;
		blackhall.position  = location;
		blackhall.zPosition = 0;
		
		[self addChild: blackhall];

		
		[dic setObject: blackhall forKey: @"SKSpriteNode"];

		
		[array_Ana addObject: dic];
		
		
		point_XY[i] = blackhall.position;
		
	}
	
}

- (void)removeAllAna
{
	
	for ( NSDictionary *dic in array_Ana ) {
		
		SKSpriteNode *blackhall = [dic objectForKey: @"SKSpriteNode"];

		[blackhall removeFromParent];

	}

	[array_Ana removeAllObjects];

}

- (void)initBall
{
	
	NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];

	CGPoint location = CGPointMake( ( 728 - 295 ) / 2 + 295 , 768 / 2 ); //self.view.center;//CGPointMake( x, y );
	
//	SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed: @"Ball"];
	SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed: @"Sudachi"];
	
	//		x = (295 : 728);
	//		y = (  0 : 768);
	ball.xScale    = 0.05;//1.5;
	ball.yScale    = 0.05;//1.5;
	ball.position  = location;
	ball.zPosition = 1;
	
	[self addChild: ball];
	
	
	float speed_x = 0.0, speed_y = 0.0;
	NSNumber *number_x = [[NSNumber alloc] initWithFloat: speed_x];
	NSNumber *number_y = [[NSNumber alloc] initWithFloat: speed_y];
	
	[dic setObject: ball     forKey: @"SKSpriteNode"];
	[dic setObject: number_x forKey: @"speed_x"];
	[dic setObject: number_y forKey: @"speed_y"];
	
	
	[array_Ball addObject: dic];
	
	
	integer_BallCount ++;
	
}

- (void)removeAllBall
{
	
	for ( NSDictionary *dic in array_Ball ) {
		
		SKSpriteNode *ball = [dic objectForKey: @"SKSpriteNode"];
		
		[ball removeFromParent];
		
	}
	
	[array_Ball removeAllObjects];
	
	integer_BallCount = 0;
	
}

- (void)startGame
{
	
	[self removeAllAna];

	[self setTextLevel: [NSString stringWithFormat: @"LEVEL %d", (int)integer_LevelCount]];
	
	
	array_Ana  = [[NSMutableArray alloc] init];
	
	array_Ball = [[NSMutableArray alloc] init];
	
	
	[self initAna];
	
	[self initBall];
	
	
	date_Play = [NSDate date];
	
	
	timer = [NSTimer scheduledTimerWithTimeInterval: 0.5
											 target: self
										   selector: @selector( timer_Action )
										   userInfo: nil
											repeats: YES];

	timer2 = [NSTimer scheduledTimerWithTimeInterval: 10.0
											  target: self
											selector: @selector( timer_2_Action )
											userInfo: nil
											 repeats: YES];

	
	[self timer_2_Action];
	
}





- (void)timer_Action
{
	
	NSDate *date_now = [NSDate date];
	
	if ( [date_now timeIntervalSinceDate: date_Play] > integer_PlayCount ) {
		
		[timer invalidate];
		
		[self gameEnd];
		
		return;
		
	}
	
	[self tamaDown];
	
}

- (void)timer_2_Action
{
	
	NSString *string = [NSString stringWithFormat: @"%06d", (int)integer_MyTensu];
	
	label_MyTensu.text = string;
	
	string = [NSString stringWithFormat: @"F0%@", string];
	
	UIView *view = (UIView *)self.view;
	ViewController *viewCont = (ViewController *)view.window.rootViewController;
	
	[viewCont setSendData: string];
	
}

- (void)tamaDown
{
	
	int index;
	
loop:
	
	index = 0;
	
	for ( NSMutableDictionary *dic in array_Ball ) {
		
//		UIImageView *imageView = [dic objectForKey: @"image_view"];
		SKSpriteNode *ball = [dic objectForKey: @"SKSpriteNode"];
		
		NSInteger ix = ball.position.x;
		NSInteger iy = ball.position.y;
		
		for ( NSInteger j = 0; j < integer_AnaCount; j ++ ) {
			
			NSInteger ax = point_XY[j].x;
			NSInteger ay = point_XY[j].y;
			
			if ( ix > ax - 20 && ix < ax + 20 &&
				 iy > ay - 20 && iy < ay + 20    ) {
				
				integer_MyTensu += 10;
				
				NSString *string = [NSString stringWithFormat: @"%06d", (int)integer_MyTensu];
				
				label_MyTensu.text = string;
				
				string = [NSString stringWithFormat: @"A0%@", string];
				
				UIView *view = (UIView *)self.view;
				ViewController *viewCont = (ViewController *)view.window.rootViewController;
				
				[viewCont setSendData: string];
				
				[ball removeFromParent];
				
				[array_Ball removeObjectAtIndex: index];
				
				integer_BallCount --;
				
				if ( integer_BallCount == 0 ) {
					
					timer_Kieru = [NSTimer scheduledTimerWithTimeInterval: 1.0
																   target: self
																 selector: @selector( tabaArawaru )
																 userInfo: nil
																  repeats: NO];
					
				}
				
				goto loop;
				
			}
			
		}
		
		index ++;
		
	}
	
}

- (void)tabaArawaru
{
	
	[self initBall];
	
}

- (void)setTextLevel: (NSString *)string
{
	
	label_MyLevel.text = string;
	
	NSLog( @"my level = %@", string );
	
	timer_LevelClear = [NSTimer scheduledTimerWithTimeInterval: 10.0
														target: self
													  selector: @selector( setTextLevelClear )
													  userInfo: nil
													   repeats: NO];
	
}

- (void)setTextLevelClear
{
	
	label_MyLevel.text = @"";
	
}

- (void)setTextLabel: (NSString *)string
{
	
	label_Label.text = string;
	
	NSLog( @"label = %@", string );
	
	timer_LabelClear = [NSTimer scheduledTimerWithTimeInterval: 10
														target: self
													  selector: @selector( setTextLabelClear )
													  userInfo: nil
													   repeats: NO];
	
}

- (void)setTextLabelClear
{
	
	label_Label.text = @"";
	
}

- (void)setIndex: (NSInteger)index
			name: (NSString *)name
			 tag: (NSString *)tag
		  tensuu: (NSString *)tensuu
{
	
	if ( [tag isEqualToString: @"F"] ) {
		
		switch ( index ) {
				
			case 0:
				
				label_Teki_1.text      = name;
				
				break;
				
			case 1:
				
				label_Teki_2.text      = name;
				
				break;
				
			case 2:
				
				label_Teki_3.text      = name;
				
				break;
				
			case 3:
				
				label_Teki_4.text      = name;
				
				break;
				
			default:
				
				break;
				
		}
		
	} else if ( [tag isEqualToString: @"A"] ) {
		
		switch ( index ) {
				
			case 0:
				
				label_Teki_1.text      = name;
				label_TekiTensu_1.text = tensuu;
				
				break;
				
			case 1:
				
				label_Teki_2.text      = name;
				label_TekiTensu_2.text = tensuu;
				
				break;
				
			case 2:
				
				label_Teki_3.text      = name;
				label_TekiTensu_3.text = tensuu;
				
				break;
				
			case 3:
				
				label_Teki_4.text      = name;
				label_TekiTensu_4.text = tensuu;
				
				break;
				
			default:
				
				break;
				
		}

		if ( integer_BallCount < 10 ) {
			
			[self initBall];

		}
		
	}
	
}

- (void)gameEnd
{

	[self setTextLevel: @"Game End"];
	
}

@end
