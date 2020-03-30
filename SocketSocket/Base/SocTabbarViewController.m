//
//  SocTabbarViewController.m
//  SocketSocket
//
//  Created by 黎永杰 on 2020/3/26.
//  Copyright © 2020 黎永杰. All rights reserved.
//

#import "SocTabbarViewController.h"
#import "SocNavigationController.h"
#import "SocMessageListViewController.h"

@interface SocTabbarViewController ()

@property (nonatomic, strong) SocNavigationController *messageListVC;

@end

@implementation SocTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addViewController];
}

#pragma mark - getter
- (SocNavigationController *)messageListVC {
    if (!_messageListVC) {
        SocMessageListViewController *listVc = [[SocMessageListViewController alloc] init];
        _messageListVC = [[SocNavigationController alloc] initWithRootViewController:listVc];
        _messageListVC.tabBarItem.title = @"消息";
    }
    return _messageListVC;
    
}


- (void)addViewController {
    
    [self.tabBarController addChildViewController:self.messageListVC];
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
