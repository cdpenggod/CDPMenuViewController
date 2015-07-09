//
//  CDPMenuViewController.h
//  Menu
//
//  Created by 柴东鹏 on 15/6/27.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    //平移缩放模式(默认)
    CDPScaleMode=0,
    //平移模式
    CDPTranslationMode,
};
typedef NSInteger CDPMenuPushMode;

@interface CDPMenuViewController : UIViewController{
    UIViewController *_leftViewController;
    UIViewController *_midViewController;
    UIViewController *_rightViewController;
    
}

//统一设置推出菜单模式(默认为CDPScaleMode模式)
@property (nonatomic,assign) CDPMenuPushMode mode;

//推出左菜单模式
@property (nonatomic,assign) CDPMenuPushMode modeOfLeft;

//推出右菜单模式
@property (nonatomic,assign) CDPMenuPushMode modeOfRight;

//推出菜单动画时长(默认为0.35s)
@property (nonatomic,assign) NSTimeInterval animationDuration;

//是否开启阴影边框(默认为YES)
@property (nonatomic,assign) BOOL isShadow;

//在平移模式(CDPTranslationMode)下主视图的平移长度(默认为视图的3/4长)
@property (nonatomic,assign) NSInteger length;

//初始化设置
-(id)initWithRootViewController:(UIViewController *)rootViewController leftViewController:(UIViewController *)leftViewController rightViewController:(UIViewController *)rightViewController;

//推出左菜单
-(void)pushLeftMenu;

//推出右菜单
-(void)pushRightMenu;

//回到主视图,隐藏菜单
-(void)restoreViewController;

@end
