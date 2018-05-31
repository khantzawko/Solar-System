//
//  DetailsTableViewCell.m
//  Solar System
//
//  Created by Khant Zaw Ko on 28/5/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

#import "DetailsTableViewCell.h"

@implementation DetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self) {
        [self setupWebView];
    }
    
    return self;
}

- (void)setupWebView {
    _planetWebView = UIWebView.new;
    _planetWebView.translatesAutoresizingMaskIntoConstraints = NO;
    _planetWebView.scrollView.scrollEnabled = NO;
    
    [self addSubview:_planetWebView];
    
    [_planetWebView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [_planetWebView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0].active = YES;
    [_planetWebView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = YES;
    [_planetWebView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;
}


@end
