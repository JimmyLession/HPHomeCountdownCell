//
//  CountDownViewController.m
//  HPHomeCountdownCell
//
//  Created by 雷建民 on 16/12/4.
//  Copyright © 2016年 雷建民. All rights reserved.
//

#import "CountDownViewController.h"
#import "NSString+Extension.h"
#import "HPHomePageViewModel.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface CountDownViewController ()
@property (nonatomic ,strong)HPHomePageViewModel *homePageViewModel;

@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(weakSelf);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.homePageViewModel countDownWithPER_SECBlock:^{
        [weakSelf updateTimeInVisibleCells];
    }];
}

#pragma mark - Custom Method
- (void)updateTimeInVisibleCells
{
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ( [obj isKindOfClass:[UITableViewCell class]]) {
           obj.textLabel.text = [NSString stringToCurtDownString:self.homePageViewModel.rushArray[obj.tag]];
        }
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.homePageViewModel.rushArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringToCurtDownString:_homePageViewModel.rushArray[indexPath.row]];
    // Configure the cell...
    cell.tag = indexPath.row;
    return cell;
}

- (HPHomePageViewModel *)homePageViewModel
{
    if (!_homePageViewModel) {
        _homePageViewModel = [[HPHomePageViewModel alloc]init];
    }
    return _homePageViewModel;
}
@end
