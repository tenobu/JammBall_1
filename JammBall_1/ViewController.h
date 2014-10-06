//
//  ViewController.h
//  JammBall_1
//
//  Created by 寺内 信夫 on 2014/10/01.
//  Copyright (c) 2014年 寺内 信夫. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@import MultipeerConnectivity;

#define SERVICE_TYPE @"MCStepper"

@interface ViewController : UIViewController < MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate, NSStreamDelegate,MCBrowserViewControllerDelegate, MCSessionDelegate, MCAdvertiserAssistantDelegate >
{

@private

}


@property MCAdvertiserAssistant *assistant;

@property (strong, nonatomic) MCPeerID *myPeerID;
@property (strong, nonatomic) NSString *serviceType;
@property (strong, nonatomic) MCNearbyServiceAdvertiser *nearbyServiceAdvertiser;
@property (strong, nonatomic) MCNearbyServiceBrowser *nearbyServiceBrowser;
@property (strong, nonatomic) MCSession *session;
//@property id stepDelegate;
//@property (assign,nonatomic)id<UIPageViewControllerDelegate>delegate;


- (IBAction)connect:(UIButton *)sender;
//- (void)sendData:(NSString *)str;

//@property (weak, nonatomic) IBOutlet UILabel *myself;
//@property (weak, nonatomic) IBOutlet UILabel *companion;
//@property (weak, nonatomic) IBOutlet UILabel *companion1;
//@property (weak, nonatomic) IBOutlet UILabel *companion2;
//@property (weak, nonatomic) IBOutlet UILabel *companion3;
//@property (weak, nonatomic) IBOutlet UILabel *companion4;
//
//
//@property (weak, nonatomic) IBOutlet UIImageView *hosi;
//@property (weak, nonatomic) IBOutlet UIImageView *hosi1;
//@property (weak, nonatomic) IBOutlet UIImageView *hosi2;
//@property (weak, nonatomic) IBOutlet UIImageView *hosi3;
//@property (weak, nonatomic) IBOutlet UIImageView *hosi4;

@property (weak, nonatomic) IBOutlet UILabel *label_MyTensu;
@property (weak, nonatomic) IBOutlet UILabel *label_TekiTensu_1;
@property (weak, nonatomic) IBOutlet UILabel *label_TekiTensu_2;
@property (weak, nonatomic) IBOutlet UILabel *label_TekiTensu_3;
@property (weak, nonatomic) IBOutlet UILabel *label_TekiTensu_4;

@end
