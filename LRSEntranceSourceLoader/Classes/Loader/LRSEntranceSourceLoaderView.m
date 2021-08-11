//
//  LRSEntranceSourceLoaderView.m
//  LRSEntranceSourceLoaderView
//
//  Created by sama 刘 on 2021/8/11.
//

#import "LRSEntranceSourceLoaderView.h"
#import <MASonry/MASonry.h>

@interface LRSEntranceSourceLoaderView ()

@property (nonatomic, strong) UILabel *progressTitleLabel;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation LRSEntranceSourceLoaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.layer.cornerRadius = 8;
        self.contentView.layer.masksToBounds = YES;
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(258, 186));
        }];
        [self.contentView addSubview:self.progressTitleLabel];
        [self.contentView addSubview:self.progressView];
        [self.progressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@75);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(@20);
        }];
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@4);
            make.left.equalTo(@21);
            make.width.equalTo(@216);
            make.top.equalTo(self.progressTitleLabel.mas_bottom).offset(11);
        }];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    [self.progressView setProgress:progress animated:YES];
    self.progressTitleLabel.text = [NSString stringWithFormat:@"正在加载组件(%.0f%%)", MIN(progress, 1)*100];
}

- (UILabel *)progressTitleLabel {
    if (!_progressTitleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label .alpha = 1.0;
        label.font = [UIFont systemFontOfSize:15 weight:(UIFontWeightMedium)];
        label.textColor = [UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:1.0];
        label.text = @"正在加载数据";
        _progressTitleLabel = label;
    }
    return _progressTitleLabel;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.progressTintColor = [UIColor colorWithRed:120/255.0 green:184/255.0 blue:90/255.0 alpha:1.0];
        _progressView.trackTintColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
        _progressView.layer.cornerRadius = 2;
        _progressView.layer.masksToBounds = YES;
    }
    return _progressView;
}

@end
