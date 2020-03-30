//
//  SocMessageListTableView.m
//  SocketSocket
//
//  Created by 黎永杰 on 2020/3/26.
//  Copyright © 2020 黎永杰. All rights reserved.
//

#import "SocMessageListTableView.h"

@interface SocMessageListTableView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SocMessageListTableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}


@end
