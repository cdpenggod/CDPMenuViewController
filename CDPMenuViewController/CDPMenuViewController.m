//
//  CDPMenuViewController.m
//  Menu
//
//  Created by 柴东鹏 on 15/6/27.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "CDPMenuViewController.h"

#define _midView _midViewController.view //主视图
#define _leftView _leftViewController.view //左菜单视图
#define _rightView _rightViewController.view //右菜单视图
@interface CDPMenuViewController ()

@end

@implementation CDPMenuViewController{
    NSInteger _state;//记录目前ViewController状态,为1时显示主视图，为2时显示左菜单，为3时显示右菜单
    
    UITapGestureRecognizer *_tapGR;//显示菜单状态下主视图单击手势
    
    UIPanGestureRecognizer *_panGR;//显示菜单状态下主视图拖动手势
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushLeftMenu) name:@"CDPMenuViewControllerPushLeft" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushRightMenu) name:@"CDPMenuViewControllerPushRight" object:nil];
    
    _midView.frame=self.view.bounds;
    [self.view addSubview:_midView];
    
}

//初始化设置
-(id)initWithRootViewController:(UIViewController *)rootViewController leftViewController:(UIViewController *)leftViewController rightViewController:(UIViewController *)rightViewController{
    if (self=[super init]) {
        _midViewController=rootViewController;
        _leftViewController=leftViewController;
        _rightViewController=rightViewController;
        
        _animationDuration=0.35;
        
        _isShadow=YES;
        
        _mode=CDPScaleMode;
        
        _length=self.view.bounds.size.width/4*3;
        
        if (_midViewController==nil) {
            NSLog(@"未设置主视图");
        }
        
        _state=1;
        
        _tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(restoreViewController)];
        
        _panGR=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGR:)];
    }
    
    return self;
}
-(void)setLength:(NSInteger)length{
    if (length>=0) {
        _length=length;
    }
    else{
        NSLog(@"长度不能设置为负数");
    }
}
-(void)setMode:(CDPMenuPushMode)mode{
    _mode=mode;
    _modeOfLeft=mode;
    _modeOfRight=mode;
}
#pragma mark 推出菜单
//推出左菜单
-(void)pushLeftMenu{
    if (_leftViewController==nil||_midViewController==nil) {
        NSLog(@"未设置左菜单或主视图");
        return;
    }
    if (_state==1) {
        _leftView.frame=self.view.bounds;
        [self.view insertSubview:_leftView belowSubview:_midView];

        _state=2;
        
        _mode=_modeOfLeft;
        
        //设置阴影
        if (_isShadow==YES) {
            _midView.layer.shadowOpacity=0.8;
            _midView.layer.cornerRadius=4;
            _midView.layer.shadowOffset=CGSizeZero;
            _midView.layer.shadowRadius=4;
            _midView.layer.shadowPath=[UIBezierPath bezierPathWithRect:_midView.bounds].CGPath;
        }
        else{
            _midView.layer.shadowOpacity=0;
        }
        //模式判断
        if (_mode==CDPScaleMode) {
            [self scaleMode];
        }
        if (_mode==CDPTranslationMode) {
            [self translationMode];
        }
        
    }
}

//推出右菜单
-(void)pushRightMenu{
    if (_rightViewController==nil||_midViewController==nil) {
        NSLog(@"未设置右菜单或主视图");
        return;
    }
    if (_state==1) {
        _rightView.frame=self.view.bounds;
        [self.view insertSubview:_rightView belowSubview:_midView];

        _state=3;
        
        _mode=_modeOfRight;
        
        //设置阴影
        if (_isShadow==YES) {
            _midView.layer.shadowOpacity=0.8;
            _midView.layer.cornerRadius=4;
            _midView.layer.shadowOffset=CGSizeZero;
            _midView.layer.shadowRadius=4;
            _midView.layer.shadowPath=[UIBezierPath bezierPathWithRect:_midView.bounds].CGPath;
        }
        else{
            _midView.layer.shadowOpacity=0;
        }
        //模式判断
        if (_mode==CDPScaleMode) {
            [self scaleMode];
        }
        if (_mode==CDPTranslationMode) {
            [self translationMode];
        }
        
    }
}
#pragma mark CDPMenuPushMode各模式
//CDPScaleMode平移缩放模式
-(void)scaleMode{
    if (_state==2) {
        //左菜单状态
        [UIView animateWithDuration:_animationDuration animations:^{
            //进行缩放平移
            CGAffineTransform midTransform=CGAffineTransformMakeScale(0.5,0.5);
            _midView.transform=CGAffineTransformTranslate(midTransform,_midView.bounds.size.width,0);
        } completion:^(BOOL finished) {
            //添加手势
            [_midView addGestureRecognizer:_tapGR];
            
            [_midView addGestureRecognizer:_panGR];
        }];
    }
    if (_state==3) {
        //右菜单状态
        [UIView animateWithDuration:_animationDuration animations:^{
            //进行缩放平移
            CGAffineTransform midTransform=CGAffineTransformMakeScale(0.5,0.5);
            _midView.transform=CGAffineTransformTranslate(midTransform,-_midView.bounds.size.width,0);
        } completion:^(BOOL finished) {
            //添加手势
            [_midView addGestureRecognizer:_tapGR];
            
            [_midView addGestureRecognizer:_panGR];
        }];
    }
}

//CDPTranslationMode平移模式
-(void)translationMode{
    if (_state==2) {
        //左菜单状态
        [UIView animateWithDuration:_animationDuration animations:^{
            //进行平移
            _midView.transform=CGAffineTransformMakeTranslation(_length,0);
        } completion:^(BOOL finished) {
            //添加手势
            [_midView addGestureRecognizer:_tapGR];
            
            [_midView addGestureRecognizer:_panGR];
        }];
    }
    if (_state==3) {
        //右菜单状态
        [UIView animateWithDuration:_animationDuration animations:^{
            //进行平移
            _midView.transform=CGAffineTransformMakeTranslation(-_length,0);
        } completion:^(BOOL finished) {
            //添加手势
            [_midView addGestureRecognizer:_tapGR];
            
            [_midView addGestureRecognizer:_panGR];
        }];

    }
}
#pragma mark 手势方法
//回到主视图，隐藏菜单
-(void)restoreViewController{
    if (_state!=1) {
        [UIView animateWithDuration:_animationDuration animations:^{
            CGAffineTransform midTransform=CGAffineTransformMakeScale(1,1);
            _midView.transform=midTransform;
        } completion:^(BOOL finished) {
            [_leftView removeFromSuperview];
            
            [_rightView removeFromSuperview];
            
            _midView.layer.shadowOpacity=0;

            //删除手势
            [_midView removeGestureRecognizer:_tapGR];
            
            [_midView removeGestureRecognizer:_panGR];
        }];
        _state=1;
    }
}

//拖动手势
-(void)panGR:(UIPanGestureRecognizer *)panGR{
    CGPoint panPointOfSelf=[panGR locationInView:self.view];
    
    if (_mode==CDPScaleMode) {
        //平移缩放模式
        if (panPointOfSelf.x<=self.view.bounds.size.width/4*3&&panPointOfSelf.x>=self.view.bounds.size.width/4) {
            [self layoutMidViewWithPanPointOfSelf:panPointOfSelf];
        }
    }
    if (_mode==CDPTranslationMode) {
        //平移模式
        if (panPointOfSelf.x<=_length&&panPointOfSelf.x>=self.view.bounds.size.width-_length) {
            [self layoutMidViewWithPanPointOfSelf:panPointOfSelf];
        }
    }
    
    if (panGR.state==UIGestureRecognizerStateEnded) {
        if (_state==2) {
            //左菜单状态
            if (panPointOfSelf.x<=self.view.bounds.size.width/2) {
                [self restoreViewController];
            }
            else{
                if (_mode==CDPScaleMode) {
                    //平移缩放模式
                    CGAffineTransform midTransform=CGAffineTransformMakeScale(0.5,0.5);
                    _midView.transform=CGAffineTransformTranslate(midTransform,_midView.bounds.size.width,0);
                }
                if (_mode==CDPTranslationMode) {
                    //平移模式
                    _midView.transform=CGAffineTransformMakeTranslation(_length,0);
                }
            }
        }
        if(_state==3){
            //右菜单状态
            if (panPointOfSelf.x>=self.view.bounds.size.width/2) {
                [self restoreViewController];
            }
            else{
                if (_mode==CDPScaleMode) {
                    //平移缩放模式
                    CGAffineTransform midTransform=CGAffineTransformMakeScale(0.5,0.5);
                    _midView.transform=CGAffineTransformTranslate(midTransform,-_midView.bounds.size.width,0);
                }
                if (_mode==CDPTranslationMode) {
                    //平移模式
                    _midView.transform=CGAffineTransformMakeTranslation(-_length,0);
                }
                
            }
        }
        
    }
    
    
}

//拖动状态下主视图变换
- (void)layoutMidViewWithPanPointOfSelf:(CGPoint)point{
    if (_state==2) {
        //左菜单状态
        if (_mode==CDPScaleMode) {
            //平移缩放模式
            CGFloat scale=ABS(point.x-self.view.bounds.size.width/4*3)/(self.view.bounds.size.width/2)*0.5+0.5;
            CGAffineTransform midTransform=CGAffineTransformMakeScale(scale,scale);
            _midView.transform=CGAffineTransformTranslate(midTransform,self.view.bounds.size.width/2-ABS(point.x-self.view.bounds.size.width/4*3),0);
        }
        if (_mode==CDPTranslationMode) {
            //平移模式
            _midView.transform=CGAffineTransformMakeTranslation(point.x,0);
        }
    }
    if (_state==3) {
        //右菜单状态
        if (_mode==CDPScaleMode) {
            //平移缩放模式
            CGFloat scale=(point.x-self.view.bounds.size.width/4)/(self.view.bounds.size.width/2)*0.5+0.5;
            CGAffineTransform midTransform=CGAffineTransformMakeScale(scale,scale);
            _midView.transform=CGAffineTransformTranslate(midTransform,-(self.view.bounds.size.width/2-(point.x-self.view.bounds.size.width/4)),0);
        }
        if (_mode==CDPTranslationMode) {
            //平移模式
            _midView.transform=CGAffineTransformMakeTranslation(-(self.view.bounds.size.width-point.x),0);
        }
    }
}



-(void)dealloc{
    _midViewController=nil;
    _leftViewController=nil;
    _rightViewController=nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CDPMenuViewControllerPushLeft" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CDPMenuViewControllerPushRight" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
