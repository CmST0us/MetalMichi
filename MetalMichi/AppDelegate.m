//
//  AppDelegate.m
//  MetalMichi
//
//  Created by CmST0us on 2019/8/29.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "AppDelegate.h"
#import "MMRoadTableViewController.h"
@interface AppDelegate ()
@property (nonatomic, strong) MMRoadTableViewController *roadTableViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    self.roadTableViewController = [[MMRoadTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.window.rootViewController = self.roadTableViewController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
