//
//  ViewController.m
//  HideNavBarOnScrollExample
//
//  Created by Danila Gusev on 12/6/17.
//  Copyright © 2017 josshad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const kCellIdentifier = @"kSettingsCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
    }
    NSParameterAssert(indexPath.row >= 0);
    cell.textLabel.text = [@(indexPath.row) stringValue];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= 0) {
        [self.navigationController setNavigationBarHidden:NO animated: YES];
    } else {
        [self.navigationController setNavigationBarHidden:YES animated: YES];
    }
    [UIView animateWithDuration:[CATransaction animationDuration]
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}
@end
