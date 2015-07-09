//
//  midViewController.m
//  Menu
//
//  Created by 柴东鹏 on 15/6/27.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "midViewController.h"

@interface midViewController ()

@end

@implementation midViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50,100,100,40)];
    label.text=@"中间主视图";
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UILabel *otherLabel=[[UILabel alloc] initWithFrame:CGRectMake(10,14,self.view.bounds.size.width-20,self.view.bounds.size.height-140)];
    otherLabel.text=@"目前有两种推出菜单模式,左右菜单推出模式可不一样\n可自设推出动画时间、是否有阴影、平移模式下推出菜单时主视图位移长度\n详情看demo";
    otherLabel.textAlignment=NSTextAlignmentCenter;
    otherLabel.numberOfLines=0;
    [self.view addSubview:otherLabel];
    
    UIButton *leftButton=[[UIButton alloc] initWithFrame:CGRectMake(30,50,30,30)];
    leftButton.backgroundColor=[UIColor darkGrayColor];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setTitle:@"左" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    UIButton *rightButton=[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-60,50,30,30)];
    rightButton.backgroundColor=[UIColor darkGrayColor];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"右" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
}

//左菜单
-(void)leftClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CDPMenuViewControllerPushLeft" object:nil];
}

//右菜单
-(void)rightClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CDPMenuViewControllerPushRight" object:nil];
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
