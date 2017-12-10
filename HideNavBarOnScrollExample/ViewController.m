//
//  ViewController.m
//  HideNavBarOnScrollExample
//
//  Created by Danila Gusev on 12/6/17.
//  Copyright © 2017 josshad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIView *headerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.headerView = ({
        UIView *view = [UIView new];
        view.backgroundColor = UIColor.blueColor;
        [self.view addSubview:view];
        view;
    });
    
    self.tableView = ({
        UITableView *tV = [UITableView new];
        tV.delegate = self;
        tV.dataSource = self;
        [self.view addSubview:tV];
        tV;
    });
    
    
    
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UILayoutGuide *guide = self.view.safeAreaLayoutGuide;
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.headerView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0],
                                                  [self.headerView.bottomAnchor constraintEqualToAnchor:guide.topAnchor constant:64],
                                                  [self.headerView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0],
                                                  [self.headerView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0]
                                                  ]];
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.tableView.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor constant:0],
                                                  [self.tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0],
                                                  [self.tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0],
                                                  [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0]
                                                  ]];
       
        
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
