//
//  LRSViewController.m
//  LRSEntranceSourceLoader
//
//  Created by 刘sama on 08/11/2021.
//  Copyright (c) 2021 刘sama. All rights reserved.
//

#import "LRSViewController.h"
#import <LRSEntranceSourceLoader/LRSEntranceSourceLoader.h>
#import <LRSEntranceSourceLoader/UIImageView+LRSEntranceLoader.h>
#import <BlocksKit/NSArray+BlocksKit.h>
#import <SDWebImage/SDImageCache.h>

@interface LRSViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imagevView;

@end

@implementation LRSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.imagevView lr_entrance_set_imageWithImageInfo:@"board_zoo_1" placeholderImage:nil];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)start:(id)sender {
    NSArray<NSString *> *source = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"mock" withExtension:@"plist"]];
    NSArray *filtered = [[LRSEntranceSourceLoader filterRemoteConfigures:source] bk_map:^id(NSString *obj) {
        return [[obj stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    }];
    if (filtered.count != 0) {
        [LRSEntranceSourceLoader loadEntranceSourceLoaderViewWithBuilder:^(LRSEntranceSourceLoadViewConfigure * _Nonnull configure) {
            configure.originProgress = 0.25;
            configure.result = ^(BOOL success, NSError * _Nullable error) {
                NSLog(@"%@, %@", success?@"成功": @"失败", error.localizedDescription);
            };
            configure.minDuration = 3;
            configure.superView = self.view;
            configure.sourceURLs = filtered;
        }];
    } else {
        NSLog(@"无需下载");
    }
}

- (IBAction)cleanCache:(id)sender {
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        NSLog(@"清理成功");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
