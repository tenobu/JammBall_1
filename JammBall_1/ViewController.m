//
//  ViewController.m
//  JammBall_1
//
//  Created by 寺内 信夫 on 2014/10/01.
//  Copyright (c) 2014年 寺内 信夫. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
{
	
@private
	
	AppDelegate *app;

	NSString *string_1;
	
	NSTimer *timer, *timer2;
	
	NSInteger integer_MyTensu;
	
	//加速度センサー
	CMMotionManager *motionManager;
	
	NSInteger integer_BallCount;
	
	//穴の複数管理
	NSInteger integer_AnaCount;
	NSMutableArray *array_Ana;
	CGPoint point_XY[10];
	
	//ボールの複数管理
	NSMutableArray *array_Ball;
	//敵の管理
	NSMutableArray *array_Teki;
	
	NSTimer *timer_Kieru;

}

@end

@implementation ViewController

- (void)viewDidLoad
{
	
	[super viewDidLoad];

	
//	self.label_Teki_1.text      = @"";
//	self.label_TekiTensu_1.text = @"";
//	self.label_Teki_2.text      = @"";
//	self.label_TekiTensu_2.text = @"";
//	self.label_Teki_3.text      = @"";
//	self.label_TekiTensu_3.text = @"";
//	self.label_Teki_4.text      = @"";
//	self.label_TekiTensu_4.text = @"";

	
	self.serviceType = SERVICE_TYPE;
	
	
	MCPeerID *peerID = [[MCPeerID alloc] initWithDisplayName: [UIDevice currentDevice].name];
	
	self.session = [[MCSession alloc] initWithPeer: peerID
								  securityIdentity: nil
							  encryptionPreference: MCEncryptionOptional];
	
	self.session.delegate = self;

	
	NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity: 10];

	[info setObject: @"1.0" forKey: @"version"];
	
	self.assistant = [[MCAdvertiserAssistant alloc] initWithServiceType: self.serviceType
														  discoveryInfo: info
																session: self.session];
	self.assistant.delegate = self;
	
	[self.assistant start];
	

	array_Teki = [[NSMutableArray alloc] init];
	
	
	NSNotificationCenter*   nc = [NSNotificationCenter defaultCenter];
	[nc addObserver: self
		   selector: @selector( success )
			   name: @"tuuti"
			 object: nil];
	
	
	timer = [NSTimer scheduledTimerWithTimeInterval: 0.5
											 target: self
										   selector: @selector( aprivate )
										   userInfo: nil
											repeats: YES];
	
	//背景色を白に指定
	self.view.backgroundColor = [UIColor whiteColor];
	
	[self initGame];
	
}

- (void)didReceiveMemoryWarning
{

	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.

}

- (void)setSendData: (NSString *)string
{
	
	NSError *error = nil;
	
	//送信する文字列を作成
	//NSData へ文字列を変換
	NSData *data = [string dataUsingEncoding: NSUTF8StringEncoding];
	
	//送信先の Peer を指定する
	NSArray *peerIDs = self.session.connectedPeers;
	if ( [peerIDs count] == 0 ) {
		
		self.textView_String.text = @"この端末は、誰にも繋がっていない！！";
	
		return;
		
	}
	
	self.textView_String.text = [peerIDs componentsJoinedByString: @", "];
	
	
	[self.session sendData: data
				   toPeers: peerIDs
				  withMode: MCSessionSendDataReliable
					 error: &error];
	
	if ( error ) {
		
		NSLog( @"%@", error );
		
	}
	
}

// dataを受け取った
// サブスレッドで受けてる
- (void)session: (MCSession *)session
 didReceiveData: (NSData *)data
	   fromPeer: (MCPeerID *)peerID
{
	
	NSString *display_name = peerID.displayName;
	
	NSLog(@"-session: didReceiveData: fromPeer:%@", display_name);
	
 //   NSError *error;
	
	//	dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	//
	//	NSString *title = [dic objectForKey:@"title"];
	//	NSString *note = [dic objectForKey:@"note"];
	//
	//	NSLog(@"タイトル %@ 本文　%@", title, note);
	//	[self saveRiminder:title note:note];
	
	//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
	//    if (!error) {
	//        NSLog(@"data = %@", json);
	//        [self.stepDelegate recvDictionary:json];
	//    }
	
	NSString *string = [[NSString alloc] initWithData: data
											 encoding: NSUTF8StringEncoding];
	
	NSString *command = [string substringToIndex: 1];
	string = [string substringFromIndex: 1];
	
	//NSString *teki    = [string substringToIndex: 1];
	string = [string substringFromIndex: 1];
	
	if ( [command isEqualToString: @"A"] ) {
		
		NSMutableDictionary *dic;
		NSString *name;
		BOOL flag = NO;
		
		for ( dic in array_Teki ) {
			
			name = [dic objectForKey: @"name"];
		
			if ( [name isEqualToString: display_name] ) {
				
				[dic setObject: string forKey: @"敵点数"];
				
				flag = YES;
				
				break;
				
			}
			
		}
		
		if ( flag == NO ) {
			
			dic = [[NSMutableDictionary alloc] init];
			
			[dic setObject: display_name forKey: @"name"];
			[dic setObject: string       forKey: @"敵点数"];

			[array_Teki addObject: dic];
			
		}
		
		
	}
	
	//self.label_TekiTensu_1.text = [NSString stringWithFormat: @"敵１    %@", string];
	//string_1 = [NSString stringWithFormat: @"敵１    %@", string];

	[self aprivate];

	
	[self initBall];
	
	//	NSLog( @"count = %d", [array_Ball count] );
	
	//	timer2 = [NSTimer scheduledTimerWithTimeInterval: 0.1
	//											  target: self
	//											selector: @selector( tamaDown )
	//											userInfo: nil
	//											 repeats: NO];
	
}






- (void)showAlert: (NSString *)title
		  message: (NSString *)message
{

	UIAlertView *alert= [[UIAlertView alloc] initWithTitle: title
												   message: message
												  delegate: self
										 cancelButtonTitle: @"OK"
										 otherButtonTitles: nil];

	[alert show];
	
}

- (void)            browser: (MCNearbyServiceBrowser *)browser
didNotStartBrowsingForPeers: (NSError *)error
{
	
	// BLog();
	if ( error ) {
	
		//        NSLog(@"[error localizedDescription] %@", [error localizedDescription]);
	
	}
	
}

-(BOOL)shouldAutorotate
{
	return NO;
}

- (void)        advertiser: (MCNearbyServiceAdvertiser *)advertiser
didNotStartAdvertisingPeer: (NSError *)error
{

	if ( error ) {
	
		//        NSLog(@"%@", [error localizedDescription]);
		[self showAlert: @"ERROR didNotStartAdvertisingPeer"
				message: [error localizedDescription]];

	}

}

- (void)          advertiser: (MCNearbyServiceAdvertiser *)advertiser
didReceiveInvitationFromPeer: (MCPeerID *)peerID
				 withContext: (NSData *)context
		   invitationHandler: ( void (^)( BOOL accept, MCSession *session ))invitationHandler
{
	
	invitationHandler( TRUE, self.session );

	[self showAlert: @"didReceiveInvitationFromPeer"
			message: @"accept invitation!"];

}


// Multipeer Connectivityで接続先を見つけるUIを表示する
- (IBAction)connect: (UIButton *)sender;
{
	
	//AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
	
	MCBrowserViewController *_browserViewController = [[MCBrowserViewController alloc] initWithServiceType: self.serviceType session: self.session];
	
	_browserViewController.delegate = self;
	_browserViewController.minimumNumberOfPeers = kMCSessionMinimumNumberOfPeers;
	_browserViewController.maximumNumberOfPeers = kMCSessionMaximumNumberOfPeers;
	
	[self presentViewController:_browserViewController animated:YES completion:NULL];
	
	
	//    NSLog(@"kokohatottayo-------------------");
	
}

//キャンセルでviewを隠す
-(void)browserViewControllerWasCancelled: (MCBrowserViewController *)browserViewController
{

	[browserViewController dismissViewControllerAnimated:YES completion:NULL];

}

//完了でviewをかくす
-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController;
{

	[self aprivate];
	
	[browserViewController dismissViewControllerAnimated:YES completion:NULL];

}
// デバイスの表示可否
- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController shouldPresentNearbyPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info;
{
	//    NSLog(@"browserViewController:%@ shouldPresentNearbyPeer:%@ withDiscoveryInfo:%@", browserViewController, peerID, info);
	NSString *version = [info objectForKey:@"version"];
	if ([@"1.0" isEqualToString:version]) {
		return YES;
	};
	return NO;
}

-(void)success {
	
}

//perrIDを！！！！
- (void)aprivate
{

	//送信先の Peer を指定する
	//小さなデータをすべての接続先に送信する場合は、connectedPeers
	//送信先を制限したい場合届けたい送信先のみで構成したNSArrayを指定する
	//self.session = app.session;
	//NSArray *peerIDs = self.session.connectedPeers;
	
	int index = 0;
	
	for ( NSDictionary *dic in array_Teki ) {

		NSString *name = [dic objectForKey: @"name"];
		
		switch ( index ) {
				
			case 0:
				
				self.label_Teki_1.text      = name;
				self.label_TekiTensu_1.text = [dic objectForKey: @"敵点数"];
				
				break;
				
			case 1:
				
				self.label_Teki_2.text      = name;
				self.label_TekiTensu_2.text = [dic objectForKey: @"敵点数"];
				
				break;
				
			case 2:
				
				self.label_Teki_3.text      = name;
				self.label_TekiTensu_3.text = [dic objectForKey: @"敵点数"];

				break;
				
			case 3:
				
				self.label_Teki_4.text      = name;
				self.label_TekiTensu_4.text = [dic objectForKey: @"敵点数"];
				
				break;
				
			default:
				
				break;
				
		}
		
	}

	[self tamaDown];

}

//    NSMutableArray *labels = [[NSMutableArray alloc] init];
//
//    for (peerIDs in dic)
//    {
//        //ラベル配置スタート
//        aiteno= [[UILabel alloc]initWithFrame:CGRectMake(0, 600+(i*90), 230 , 80)];
//        aiteno.backgroundColor = [UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:0.3];
//
//
//        [labels addObject:aiteno];
//
//        i++;
//    }

// Found a nearby advertising peer
- (void)  browser: (MCNearbyServiceBrowser *)browser
	    foundPeer: (MCPeerID *)peerID
withDiscoveryInfo: (NSDictionary *)info{
	
}

// A nearby peer has stopped advertising
- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID{
	
}
#pragma mark - MCAdvertiserAssistantDelegate
// 接続要求が来た
- (void)advertiserAssitantWillPresentInvitation:(MCAdvertiserAssistant *)advertiserAssistant;
{
	NSLog(@"-advertiserAssitantWillPresentInvitation:%@", advertiserAssistant);
	
}

// 接続要求が完了した
- (void)advertiserAssistantDidDismissInvitation:(MCAdvertiserAssistant *)advertiserAssistant;
{
	NSLog(@"-advertiserAssistantDidDismissInvitation:%@", advertiserAssistant);
	
}
////ループ------------------------------
//-(void)loop
//{
//	//    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:10];
//	//    [info setObject:@"1.0" forKey:@"version"];
//	MCAdvertiserAssistant *assistant = [[MCAdvertiserAssistant alloc] initWithServiceType:self.serviceType discoveryInfo:nil session:_session];
//	assistant.delegate = self;
//	
//	NSLog(@"11111111111111111111111111111");
//	[self.assistant start];
//	[self loop2];
//	
//}
//-(void)loop2
//{
//	
//	time = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(loop) userInfo:nil repeats:YES];
//}
//---------------------------------------------------
#pragma mark - MCSessionDelegate
// 接続相手の状態が変わった
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state;
{
	NSLog(@"-session:peer: %@ didChangeState: %@", peerID.displayName, (state == MCSessionStateNotConnected ? @"NotConnected" : (state == MCSessionStateConnecting ? @"Connecting" : @"Connected")));
	
	switch (state) {
		case MCSessionStateNotConnected:// 切断した
			
			break;
		case MCSessionStateConnecting:		// 接続中
			break;
		case MCSessionStateConnected:		// 接続できた
			NSLog(@"ココ通ってる？");
			self.session = session;
			
			break;
		default:
			break;
	}
}

// 相手からストリームデータを受けた
- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID;
{
	NSLog(@"-session: didReceiveStream: withName:%@ fromPeer:%@", streamName, peerID.displayName);
	// Stream をdelegateで処理するように設定
	[stream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
	stream.delegate = self;
	[stream open];
}

// リソースの受信が始まった
- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress;
{
	NSLog(@"-session: didStartReceivingResourceWithName:%@ fromPeer:%@ withProgress:", resourceName, peerID.displayName);
	// progress に進捗が入る
	[progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:nil];
}

// リソースの受信を完了した
- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error;
{
	NSLog(@"-session: didFinishReceivingResourceWithName:%@ fromPeer:%@ atURL: withError:", resourceName, peerID.displayName);
	// localURLにファイルがある
	dispatch_async(dispatch_get_main_queue(), ^{
	});
}

// 接続先の証明書を確認して接続可否を判断する
- (void)session:(MCSession *)session didReceiveCertificate:(NSArray *)certificate fromPeer:(MCPeerID *)peerID certificateHandler:(void (^)(BOOL accept))certificateHandler;
{
	NSLog(@"-session: didReceiveCertificate:%@ fromPeer:%@ certificateHandler:", certificate, peerID.displayName);
	certificateHandler(YES);
}


#pragma mark - KVO
// KVOの通知を受ける
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;
{
	NSLog(@"%@ -observeValueForKeyPath:%@ ofObject:%@ change:%@ context:", NSStringFromClass(self.class), keyPath, object, change);
	if ([@"fractionCompleted" isEqualToString:keyPath]) {
		NSNumber *number = [change objectForKey:@"new"];
		dispatch_async(dispatch_get_main_queue(), ^{
			// 進捗値を評価
			// number.doubleValue;
			NSLog(@"-> %@", number);
		});
	}
}


#pragma mark - NSStreamDelegate
// ストリームの状態が変化した
- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent;
{
//	NSLog(@"-stream: handleEvent: %@%@%@%@%@%@",
//		  streamEvent & NSStreamEventNone ? @"NSStreamEventNone, " : @"",
//		  streamEvent & NSStreamEventOpenCompleted ? @"NSStreamEventOpenCompleted, " : @"",
//		  streamEvent & NSStreamEventHasBytesAvailable ? @"NSStreamEventHasBytesAvailable, " : @"",
//		  streamEvent & NSStreamEventHasSpaceAvailable ? @"NSStreamEventHasSpaceAvailable, " : @"",
//		  streamEvent & NSStreamEventErrorOccurred ? @"NSStreamEventErrorOccurred, " : @"",
//		  streamEvent & NSStreamEventEndEncountered ? @"NSStreamEventEndEncountered, " : @""
//		  );
	// データ受信
	if (streamEvent & NSStreamEventHasBytesAvailable) {
		int32_t steps;
		NSInputStream *input = (NSInputStream*)theStream;
		[input read:(uint8_t*)&steps maxLength:sizeof(int32_t)];
		// read
	}
	// 終了
	if (streamEvent & NSStreamEventEndEncountered) {
		[theStream close];
		[theStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
	}
}

- (void)saveRiminder: (NSString *)title
				note: (NSString *) note
{
	
	EKEventStore *eventStore = [[EKEventStore alloc] init];
	
	EKReminder *postReminder = [EKReminder reminderWithEventStore:eventStore];
	
	postReminder.title = title;
	postReminder.notes = note;
	postReminder.calendar = [eventStore defaultCalendarForNewReminders];
	
	//   postReminder.alarms = [EKAlarm alarmWithAbsoluteDate:alarmDate];
	NSError *error;
	BOOL success = [eventStore saveReminder:postReminder commit:YES error:&error];
	if (!success) {
		// 投稿失敗時
		NSLog(@"%@",[error description]);
		
		
		NSLog(@"!!!!!!!!!!!!!!!!!!!!!!");
		
	} else {
		
		UILocalNotification *noti = [UILocalNotification new];//alloc] init];
		[noti setAlertBody:note];
  //      [noti setAlertAction:@"open"];
		//       [noti setSoundName:UILocalNotificationDefaultSoundName];
		[[UIApplication sharedApplication] scheduleLocalNotification:noti];//presentLocalNotificationNow:noti];
		
		//        NSNotification *noti = [NSNotification notificationWithName:@"tuuti" object:self userInfo:dic];
		//        [[NSNotificationCenter defaultCenter] postNotification:noti];
	}
	
	
	//- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action {
	
}



#pragma mark - MCBrowserViewControllerDelegate
//- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController;
//{
//	[browserViewController dismissViewControllerAnimated:YES completion:NULL];
//}
//- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController;
//{
//	[browserViewController dismissViewControllerAnimated:YES completion:NULL];
//}
//- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info;
//{
//	
//}
//- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID
//{
//}
//- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void(^)(BOOL accept, MCSession *session))invitationHandler
//{
//	
//}
//

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
					
				} else if ( posX > self.view.bounds.size.width ) {
					
					posX = self.view.bounds.size.width;
					
					//右の壁にあたったら0.4倍の力で跳ね返る
					speed_x *= -0.4;
					
				}
				if (posY < 0.0) {
					
					posY = 0.0;
					
					//上の壁にあたっても跳ね返らない
					speed_y = 0.0;
					
				} else if ( posY > self.view.bounds.size.height ) {
					
					posY = self.view.bounds.size.height;
					
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
		
		int x = ( arc4random() % (NSInteger)( r.size.width  - 100 ) + 50 );
		int y = ( arc4random() % (NSInteger)( r.size.height - 100 ) + 50 );
		
//		NSLog( @"%@", NSStringFromCGRect( r ));
//		NSLog( @"x = %d, y = %d", x , y );
		
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
		
		[self.view addSubview: imageView];
		
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
	
	imageView.center = self.view.center;
	
	imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	
	[self.view addSubview:imageView];
	
	
	float speed_x = 0.0, speed_y = 0.0;
	NSNumber *number_x = [[NSNumber alloc] initWithFloat: speed_x];
	NSNumber *number_y = [[NSNumber alloc] initWithFloat: speed_y];
	
	[dic setObject: imageView forKey: @"image_view"];
	[dic setObject: number_x  forKey: @"speed_x"];
	[dic setObject: number_y  forKey: @"speed_y"];
	
	
	[array_Ball addObject: dic];
	
	
	integer_BallCount ++;
	
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
			
//			NSLog( @"%ld > %ld && %ld < %ld && %ld > %ld && %ld < %ld", ix, ax - 20, ix, ax + 20, iy, ay - 20, iy, ay + 20 );
			
			if ( ix > ax - 20 && ix < ax + 20 &&
				 iy > ay - 20 && iy < ay + 20    ) {
				
				imageView.hidden = YES;
				
				integer_MyTensu += 10;
				
				NSString *string = [NSString stringWithFormat: @"%06d", (int)integer_MyTensu];
				
				self.label_MyTensu.text = string;
				
				string = [NSString stringWithFormat: @"A0%@", string];
				
				[self setSendData: string];
				
				[imageView removeFromSuperview];
				
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

- (IBAction)button_Ana_Action: (id)sender
{
	
	[self removeAllAna];
	
	[self initAna];
	
}

- (IBAction)button_BallIn_Action: (id)sender
{
	
	integer_MyTensu += 10;
	
	NSString *string = [NSString stringWithFormat: @"%06d", (int)integer_MyTensu];
	self.label_MyTensu.text = string;
	
	string = [NSString stringWithFormat: @"A0%@", string];
	
	[self setSendData: string];
	
}

@end
