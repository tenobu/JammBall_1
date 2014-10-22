//
//  StartScene.m
//  JammBall_1
//
//  Created by 寺内 信夫 on 2014/10/17.
//  Copyright (c) 2014年 寺内 信夫. All rights reserved.
//

#import "StartScene.h"

#import "ViewController.h"

@implementation StartScene
{

@private
	
	SKLabelNode *label_Send;
	SKLabelNode *label_SendStatus;
	SKLabelNode *label_Received_1;
	SKLabelNode *label_Received_2;
	SKLabelNode *label_Received_3;
	SKLabelNode *label_Received_4;
	SKLabelNode *label_Received_5;
	SKLabelNode *label_Received_6;
	SKLabelNode *label_Received_7;

	NSTimer *timer_Received;

}

- (void)didMoveToView: (SKView *)view
{
	
	NSLog( @"didMoveToView" );
	
	//		x = (295 : 728);
	//		y = (  0 : 768);
	
	/* Setup your scene here */
	
	label_Send = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_Send.text = @"送る　　: ";
	label_Send.fontSize  = 20;
	label_Send.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	label_Send.position  = CGPointMake( 300, 700 );
	label_Send.zPosition = 10;
	
	[self addChild: label_Send];
	
	
	label_SendStatus = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_SendStatus.text = @"no status";
	label_SendStatus.fontSize  = 15;
	label_SendStatus.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	label_SendStatus.position  = CGPointMake( 300, 680 );
	label_SendStatus.zPosition = 10;
	
	[self addChild: label_SendStatus];
	
	
	SKLabelNode *label_Received = label_Received_1 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_Received.text = @"受ける１: ";
	label_Received.fontSize  = 20;
	label_Received.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	label_Received.position  = CGPointMake( 300, 650 );
	label_Received.zPosition = 10;
	
	[self addChild: label_Received];
	
	
	label_Received = label_Received_2 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_Received.text = @"受ける２: ";
	label_Received.fontSize  = 20;
	label_Received.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	label_Received.position  = CGPointMake( 300, 600 );
	label_Received.zPosition = 10;
	
	[self addChild: label_Received_2];
	
	
	label_Received = label_Received_3 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_Received.text = @"受ける３: ";
	label_Received.fontSize  = 20;
	label_Received.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	label_Received.position  = CGPointMake( 300, 550 );
	label_Received.zPosition = 10;
	
	[self addChild: label_Received];
	
	
	label_Received = label_Received_4 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_Received.text = @"受ける４: ";
	label_Received.fontSize  = 20;
	label_Received.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	label_Received.position  = CGPointMake( 300, 500 );
	label_Received.zPosition = 10;
	
	[self addChild: label_Received];
	
	
	label_Received = label_Received_5 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_Received.text = @"受ける５: ";
	label_Received.fontSize  = 20;
	label_Received.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	label_Received.position  = CGPointMake( 300, 450 );
	label_Received.zPosition = 10;
	
	[self addChild: label_Received];
	
	
	label_Received = label_Received_6 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_Received.text = @"受ける６: ";
	label_Received.fontSize  = 20;
	label_Received.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	label_Received.position  = CGPointMake( 300, 400 );
	label_Received.zPosition = 10;
	
	[self addChild: label_Received];
	
	
	label_Received = label_Received_7 = [SKLabelNode labelNodeWithFontNamed: @"Arial Bold"];
	
	label_Received.text = @"受ける７: ";
	label_Received.fontSize  = 20;
	label_Received.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	label_Received.position  = CGPointMake( 300, 350 );
	label_Received.zPosition = 10;
	
	[self addChild: label_Received];
	
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
	
	NSString *string = [NSString stringWithFormat: @"%06d", (int)10];
	
	string = [NSString stringWithFormat: @"T%@Test", string];
	
	UIView *view = (UIView *)self.view;
	ViewController *viewCont = (ViewController *)view.window.rootViewController;
	
	[viewCont setSendData: string];
	
	
	label_Send.text = [NSString stringWithFormat: @"送る　: %@", string];
	
}

- (void)update: (CFTimeInterval)currentTime
{
	
	//NSLog( @"update" );
	
	/* Called before each frame is rendered */
	
	//	if ( [mode isEqualToString: @"Game"] ) {
	//
	////		NSLog( @"update" );
	//
	//
	//		[self tamaDown];
	//		
	//	}
	
}

- (void)setStatusData: (NSString *)string
{

	label_SendStatus.text = [NSString stringWithFormat: @"%@", string];
	
}

- (void)setReceivedData: (NSString *)string
{

//	label_Received.text = [NSString stringWithFormat: @"受ける: %@", string];
	
}

- (void)setIndex: (NSInteger)index
			name: (NSString *)name
		 command: (NSString *)command
		  tensuu: (NSString *)tensuu
		 message: (NSString *)message

{
	
	NSLog( @"setIndex:%d:%@:%@:%@:%@", (int)index, name, command, tensuu, message );
	
	NSString *string = [NSString stringWithFormat: @"%@: %@%@%@", name, command, tensuu, message];
	
	SKAction *action = [SKAction customActionWithDuration: 10.0
											  actionBlock: ^( SKNode *node, CGFloat elapsedTime ) {

												  SKLabelNode *label_node = (SKLabelNode *)node;
												  label_node.text = @"aaaaaaaaaaa";// string;
												  
	}];
	
	switch ( index ) {
			
		case 0:
			
			label_Received_1.text = [NSString stringWithFormat: @"%@", string];
			[label_Received_1 runAction: action];
			
			break;
			
		case 1:
			
			label_Received_2.text = [NSString stringWithFormat: @"%@", string];
			[label_Received_2 runAction: action];
			
			break;
			
		case 2:
			
//			label_Received_3.text = [NSString stringWithFormat: @"%@", string];
			[label_Received_3 runAction: action];
			
			break;
			
		case 3:
			
//			label_Received_4.text = [NSString stringWithFormat: @"%@", string];
			[label_Received_4 runAction: action];
			
			break;
			
		case 4:
			
//			label_Received_5.text = [NSString stringWithFormat: @"%@", string];
			[label_Received_5 runAction: action];
			
			break;
			
		case 5:
			
//			label_Received_6.text = [NSString stringWithFormat: @"%@", string];
			[label_Received_6 runAction: action];
			
			break;
			
		case 6:
			
//			label_Received_7.text = [NSString stringWithFormat: @"%@", string];
			[label_Received_7 runAction: action];
			
			break;
			
		default:
			
			break;
			
	}
	
	NSNumber *number = [[NSNumber alloc] initWithInteger: index];
	
	NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
						 number, @"index", nil];
	
	timer_Received = [NSTimer scheduledTimerWithTimeInterval: 10.0
													  target: self
													selector: @selector( timer_Received_Action: )
													userInfo: dic
													 repeats: NO];
	
}

- (void)timer_Received_Action :(NSTimer *)timer
{
	
	NSMutableDictionary *dic = [timer userInfo];
	
	NSNumber *number = [dic objectForKey: @"index"];
	NSInteger index = number.integerValue;
	
	NSString *string = [NSString stringWithFormat: @"受ける%d: ", (int)index + 1];
	
	switch ( index ) {
			
		case 0:
			
			label_Received_1.text = string;
			
			break;
			
		case 1:
			
			label_Received_2.text = string;
			
			break;
			
		case 2:
			
			label_Received_3.text = string;
			
			break;
			
		case 3:
			
			label_Received_4.text = string;
			
			break;
			
		case 4:
			
			label_Received_5.text = string;
			
			break;
			
		case 5:
			
			label_Received_6.text = string;
			
			break;
			
		case 6:
			
			label_Received_7.text = string;
			
			break;
			
			
		default:
		
			break;
	
	}
	
}

@end
