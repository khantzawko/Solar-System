//
//  ListViewCell.m
//  Solar System
//
//  Created by Khant Zaw Ko on 28/5/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

#import "ListViewCell.h"

@implementation ListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"ListViewCell"];
    
    if (self) {
        [self setupPlanetImage];
        [self setupLabel];
    }
    
    return self;
}

- (void)setupPlanetImage {
    _planetImage = UIImageView.new;
    _planetImage.translatesAutoresizingMaskIntoConstraints = NO;
    _planetImage.layer.cornerRadius = 10;
    _planetImage.clipsToBounds = YES;
    
    [self addSubview:_planetImage];
    
    [_planetImage.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = YES;
    [_planetImage.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
    [_planetImage.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10].active = YES;
    [_planetImage.widthAnchor constraintEqualToConstant:100].active = YES;
}

- (void)setupLabel {

    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _planetName = UILabel.new;
    _planetName.font = [UIFont boldSystemFontOfSize:25];
    _planetName.translatesAutoresizingMaskIntoConstraints = NO;
    _planetName.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:_planetName];

    [_planetName.leadingAnchor constraintEqualToAnchor:_planetImage.trailingAnchor constant:10].active = YES;
    [_planetName.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
    [_planetName.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;
    [_planetName.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10].active = YES;
}


@end
