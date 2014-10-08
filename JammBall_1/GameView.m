//
//  GameView.m
//  JammBall_1
//
//  Created by 寺内 信夫 on 2014/10/06.
//  Copyright (c) 2014年 寺内 信夫. All rights reserved.
//

#import "GameView.h"

#import <CoreMotion/CoreMotion.h>
#import "ViewController.h"

@interface GameView ()

@end

@implementation GameView
{

@private

	//加速度センサー
	CMMotionManager *motionManager;
	
	NSInteger integer_BallCount;
	
	//穴の複数管理
	NSInteger integer_AnaCount;
	NSMutableArray *array_Ana;
	CGPoint point_XY[10];
	
	//ボールの複数管理
	NSMutableArray *array_Ball;
	
	NSTimer *timer_Kieru;
	
}

//+ (GameView *)loadInstanceOfViewFromNib
//{
//	
//	return [[[NSBundle mainBundle] loadNibNamed: @"GameView"
//										  owner: nil
//										options: nil] lastObject];
//	
//}
//
//- (id) awakeAfterUsingCoder: (NSCoder *)aDecoder
//{
//	
//	BOOL loadedFromSimpleVuew = ( [[self subviews] count] == 0 );
//	
//	if ( loadedFromSimpleVuew ) {
//		
//		GameView *game_view = [GameView loadInstanceOfViewFromNib];
//		
//		game_view.frame                  = self.frame;
//		game_view.autoresizingMask       = self.autoresizingMask;
//		game_view.alpha                  = self.alpha;
//		game_view.userInteractionEnabled = self.userInteractionEnabled;
//		
//		return game_view;
//		
//	}
//	
//	return self;
//	
//}

- (void)awakeFromNib
{
	
	[super awakeFromNib];
	
//	self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
//
//	skView.showsFPS = YES;
//	​skView.showsNodeCount = YES;
	[self initGame];
	
}

- (void)initGame
{
	
//	self.label_MyTensu.hidden     = NO;
//	self.label_TekiTensu_2.hidden = YES;
//	self.label_TekiTensu_3.hidden = YES;
//	self.label_TekiTensu_4.hidden = YES;

	
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
				
				UIImageView *imageView = [dic objectForKey: @"image_view"];
				
				NSNumber *number = [dic objectForKey: @"speed_x"];
				float speed_x = number.floatValue;
				
				number           = [dic objectForKey: @"speed_y"];
				float speed_y = number.floatValue;
				
				speed_x += xac;
				speed_y += yac;
				
				CGFloat posX = imageView.center.x + speed_x;
				CGFloat posY = imageView.center.y - speed_y;
				
				//端にあたったら跳ね返る処理
				if ( posX < 0.0 ) {
					
					posX = 0.0;
					
					//左の壁にあたったら0.4倍の力で跳ね返る
					speed_x *= -0.4;
					
				} else if ( posX > self.bounds.size.width ) {
					
					posX = self.bounds.size.width;
					
					//右の壁にあたったら0.4倍の力で跳ね返る
					speed_x *= -0.4;
					
				}
				if (posY < 0.0) {
					
					posY = 0.0;
					
					//上の壁にあたっても跳ね返らない
					speed_y = 0.0;
					
				} else if ( posY > self.bounds.size.height ) {
					
					posY = self.bounds.size.height;
					
					//下の壁にあたったら1.4倍の力で跳ね返る
					speed_y *= -1.4;//-1.5
					
				}
				
				imageView.center = CGPointMake( posX, posY );
				
				NSNumber *number_x = [[NSNumber alloc] initWithFloat: speed_x];
				NSNumber *number_y = [[NSNumber alloc] initWithFloat: speed_y];
				
				[dic setObject: imageView forKey: @"image_view"];
				[dic setObject: number_x  forKey: @"speed_x"];
				[dic setObject: number_y  forKey: @"speed_y"];
				
			}
			
		};
		
		// 加速度の取得開始
		[motionManager startAccelerometerUpdatesToQueue: [NSOperationQueue currentQueue]
											withHandler: handler];
		
	}
	
	
	integer_AnaCount = 3;
	array_Ana  = [[NSMutableArray alloc] init];
	
	array_Ball = [[NSMutableArray alloc] init];
	
	[self initAna];
	
	[self initBall];

}

- (void)initAna
{
	
	CGRect r = [[UIScreen mainScreen] applicationFrame];
	
	for ( int i = 0; i < integer_AnaCount; i ++ ) {
		
		NSInteger x = ( arc4random() % (NSInteger)( r.size.width  - 100 ) + 50 );
		NSInteger y = ( arc4random() % (NSInteger)( r.size.height - 100 ) + 50 );
		
		NSLog( @"%@", NSStringFromCGRect( r ));
		NSLog( @"x = %ld, y = %ld", x , y );
		
		//	for ( NSDictionary *old_dic in array_Ana ) {
		//
		//
		//	}
		
		NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
		
		//UIImageView追加
		UIImage* image = [UIImage imageNamed: @"blackhall.png"];
		
		UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
		
		imageView.frame  = CGRectMake( x, y, 50, 50 );
		
		imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
		
		[self          addSubview: imageView];
		//[self bringSubviewToFront: imageView];
		
		[dic setObject: imageView forKey: @"image_view"];
		
		
		[array_Ana addObject: dic];
		
		
		point_XY[i] = imageView.center;
		
	}
	
}

- (void)removeAllAna
{
	
	for ( NSDictionary *dic in array_Ana ) {
		
		UIImageView *imageView = [dic objectForKey: @"image_view"];
		
		[imageView removeFromSuperview];
		
	}
	
	[array_Ana removeAllObjects];
	
}

- (void)initBall
{
	
	NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
	
	//UIImageView追加
	UIImage* image = [UIImage imageNamed: @"ball.png"];
	
	UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
	
	imageView.center = self.center;
	
	imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	
	[self addSubview:imageView];
	
	
	float speed_x = 0.0, speed_y = 0.0;
	NSNumber *number_x = [[NSNumber alloc] initWithFloat: speed_x];
	NSNumber *number_y = [[NSNumber alloc] initWithFloat: speed_y];
	
	[dic setObject: imageView forKey: @"image_view"];
	[dic setObject: number_x  forKey: @"speed_x"];
	[dic setObject: number_y  forKey: @"speed_y"];
	
	
	[array_Ball addObject: dic];
	
	
	integer_BallCount ++;
	
}

- (void)drawRect: (CGRect)rect
{
	
	[self tamaDown];

//	CGRect frame = self.frame;
//	
//	CGContextRef context = UIGraphicsGetCurrentContext();  // コンテキストを取得
//	CGContextStrokeRect( context, frame );  // 四角形の描画

}

- (void)tamaDown
{
	
	int index;
	
loop:
	
	index = 0;
	
	for ( NSMutableDictionary *dic in array_Ball ) {
		
		UIImageView *imageView = [dic objectForKey: @"image_view"];
		
		NSInteger ix = imageView.center.x;
		NSInteger iy = imageView.center.y;
		
		for ( NSInteger j = 0; j < integer_AnaCount; j ++ ) {
			
			NSInteger ax = point_XY[j].x;
			NSInteger ay = point_XY[j].y;
			
			NSLog( @"%ld > %ld && %ld < %ld && %ld > %ld && %ld < %ld", ix, ax - 20, ix, ax + 20, iy, ay - 20, iy, ay + 20 );
			
			if ( ix > ax - 20 && ix < ax + 20 &&
				 iy > ay - 20 && iy < ay + 20     ) {
				
				imageView.hidden = YES;
				
//				integer_MyTensu += 10;
//				
//				NSString *string = [NSString stringWithFormat: @"%06ld", integer_MyTensu];
//				self.label_MyTensu.text = [NSString stringWithFormat: @"自分    %@", string];
				
				NSString *string = @"";
				
				[self.viewCont setSendData: string];
				
//				NSError *error = nil;
//				
//				//送信する文字列を作成
//				//NSData へ文字列を変換
//				NSData *data = [string dataUsingEncoding: NSUTF8StringEncoding];
//				
//				//送信先の Peer を指定する
//				NSArray *peerIDs = self.session.connectedPeers;
//				
//				[self.session sendData: data
//							   toPeers: peerIDs
//							  withMode: MCSessionSendDataReliable
//								 error: &error];
//				
//				if ( error ) {
//					
//					NSLog( @"%@", error );
//					
//				}
				
				[imageView removeFromSuperview];
				
				[array_Ball removeObjectAtIndex: index];
				
				integer_BallCount --;
				
				if ( integer_BallCount == 0 ) {
					
					timer_Kieru = [NSTimer scheduledTimerWithTimeInterval: 5.0
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

- (IBAction)button_Ana_Action: (id)sender
{
	
	[self removeAllAna];
	
	[self initAna];
	
}

- (IBAction)button_BallIn_Action: (id)sender
{
	
//	integer_MyTensu += 10;
//	
//	NSString *string = [NSString stringWithFormat: @"%06ld", integer_MyTensu];
//	self.label_MyTensu.text = [NSString stringWithFormat: @"自分 %@", string];
	
//	NSError *error = nil;
//	
//	//送信する文字列を作成
//	//NSData へ文字列を変換
//	NSData *data = [string dataUsingEncoding: NSUTF8StringEncoding];
// 
//	//送信先の Peer を指定する
//	NSArray *peerIDs = self.session.connectedPeers;
// 
//	[self.session sendData: data
//				   toPeers: peerIDs
//				  withMode: MCSessionSendDataReliable
//					 error: &error];
//	
//	if ( error ) {
//		
//		NSLog( @"%@", error );
//		
//	}

	NSString *string = @"";
	
	[self.viewCont setSendData: string];
	
}

@end
