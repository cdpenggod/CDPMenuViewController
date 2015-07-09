//
//  rightViewController.m
//  Menu
//
//  Created by 柴东鹏 on 15/6/27.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "rightViewController.h"

@interface rightViewController ()

@end

@implementation rightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-100,100,100,40)];
    label.text=@"右边菜单栏";
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    [self.view addSubview:label];
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
