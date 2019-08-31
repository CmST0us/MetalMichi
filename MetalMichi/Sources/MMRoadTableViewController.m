//
//  MMRoadTableViewController.m
//  MetalMichi
//
//  Created by CmST0us on 2019/8/29.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "MMRoadTableViewDataSource.h"
#import "MMRoadTableViewController.h"

static NSString * const MMRoadTableViewCellId = @"cell";

@interface MMRoadTableViewController ()
@property (nonatomic, strong) MMRoadTableViewDataSource *dataSource;
@end

@implementation MMRoadTableViewController

#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        _dataSource = [[MMRoadTableViewDataSource alloc] init];
    }
    return self;
}

#pragma mark - Lazy

#pragma mark - Getter Setter

#pragma mark - Private
- (void)registerTableViewCellClass {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MMRoadTableViewCellId];
}
#pragma mark - Method

#pragma mark - Slot

#pragma mark - Action

#pragma mark - Life Cycle
- (void)viewDidLoad {
}
#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.roadClass.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MMRoadTableViewCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MMRoadTableViewCellId];
    }
    cell.textLabel.text = self.dataSource.roadClass[indexPath.row].allKeys[0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *targetClassString = self.dataSource.roadClass[indexPath.row].allValues[0];
    Class targetClass = NSClassFromString(targetClassString);
    if (targetClass == nil) return;
    UITableViewController *vc = [[targetClass alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
