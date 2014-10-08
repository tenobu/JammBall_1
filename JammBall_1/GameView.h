//
//  GameView.h
//  JammBall_1
//
//  Created by 寺内 信夫 on 2014/10/06.
//  Copyright (c) 2014年 寺内 信夫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface GameView : UIView

@property ViewController *viewCont;

//@property (weak, nonatomic) IBOutlet UILabel *label_MyTensu;
//@property (weak, nonatomic) IBOutlet UILabel *label_TekiTensu_1;
//@property (weak, nonatomic) IBOutlet UILabel *label_TekiTensu_2;
//@property (weak, nonatomic) IBOutlet UILabel *label_TekiTensu_3;
//@property (weak, nonatomic) IBOutlet UILabel *label_TekiTensu_4;

- (void)initGame;
- (void)initAna;
- (void)removeAllAna;
- (void)initBall;

@end
