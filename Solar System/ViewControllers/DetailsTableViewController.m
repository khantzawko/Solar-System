//
//  DetailsTableViewController.m
//  Solar System
//
//  Created by Khant Zaw Ko on 28/5/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

#import "DetailsTableViewController.h"
#import "DetailsTableViewCell.h"

@interface DetailsTableViewController ()

@property (nonatomic) NSString *htmlString;
@property (nonatomic) UIView *headerView;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIButton *closeButton;
@property (nonatomic) CAShapeLayer *headerMaskLayer;
@property (nonatomic) CGFloat contentHeights;

@end

@implementation DetailsTableViewController

const int tableViewHeaderHeight = 400;
const int tableViewCutAway = 60;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    CGRect headerRect = CGRectMake(0, 0, self.tableView.bounds.size.width, tableViewHeaderHeight);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationActual)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];

    _headerView = [[UIView alloc] initWithFrame:headerRect];
    [self.tableView addSubview:_headerView];

    int effectiveHeight = tableViewHeaderHeight - (tableViewCutAway/2);
    self.tableView.contentInset = UIEdgeInsetsMake(effectiveHeight, 0, 0, 0);
//    self.tableView.contentOffset = CGPointMake(100, -effectiveHeight);

    _headerMaskLayer = CAShapeLayer.new;
    _headerMaskLayer.fillColor = UIColor.blackColor.CGColor;
    _headerView.layer.mask = _headerMaskLayer;
    [self updateHeaderView];
    [self setupImageView];
    [self setupCloseButton];
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    _htmlString = [NSString stringWithFormat:@"<body style=\"font-family: %@; font-size:%i\"> <h1> %@ </h1> %@</body>",font.fontName, (int) font.pointSize, _planetName, _planetDescription];
}

- (void) orientationActual {
    [self updateHeaderView];
}

- (void)updateHeaderView {
    int effectiveHeight = tableViewHeaderHeight - (tableViewCutAway/2);
    
    CGRect headerRect = CGRectMake(0, -effectiveHeight, self.tableView.bounds.size.width, tableViewHeaderHeight);
    
    if (self.tableView.contentOffset.y < -effectiveHeight) {
        headerRect.origin.y = self.tableView.contentOffset.y;
        headerRect.size.height = -self.tableView.contentOffset.y + (tableViewCutAway / 2);
    }
    
    _headerView.frame = headerRect;
    
    UIBezierPath *path = UIBezierPath.new;
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(headerRect.size.width, 0)];
    [path addLineToPoint:CGPointMake(headerRect.size.width, headerRect.size.height)];
    [path addLineToPoint:CGPointMake(0, headerRect.size.height - tableViewCutAway)];
    _headerMaskLayer.path = path.CGPath;
}

- (void)setupImageView {
    _imageView = UIImageView.new;
    _imageView.image = [UIImage imageNamed:_planetImagePath];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_headerView addSubview:_imageView];
    
    [_imageView.topAnchor constraintEqualToAnchor:_headerView.topAnchor constant:0].active = YES;
    [_imageView.leadingAnchor constraintEqualToAnchor:_headerView.leadingAnchor constant:0].active = YES;
    [_imageView.trailingAnchor constraintEqualToAnchor:_headerView.trailingAnchor constant:0].active = YES;
    [_imageView.bottomAnchor constraintEqualToAnchor:_headerView.bottomAnchor constant:0].active = YES;
}

- (void)setupCloseButton {
    _closeButton = UIButton.new;
    [_closeButton setTitle:@"Close" forState:UIControlStateNormal];
    _closeButton.layer.cornerRadius = 10;
    _closeButton.backgroundColor = UIColor.grayColor;
    _closeButton.alpha = 0.6;
    _closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_headerView addSubview:_closeButton];
    
    [_closeButton.topAnchor constraintEqualToAnchor:_headerView.topAnchor constant:10].active = YES;
    [_closeButton.trailingAnchor constraintEqualToAnchor:_headerView.trailingAnchor constant:-10].active = YES;
    [_closeButton.widthAnchor constraintEqualToConstant:80].active = YES;
    
    [_closeButton addTarget:self action:@selector(pressedCloseButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailsTableViewCell *cell = [[DetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WebViewCell"];
    [cell.planetWebView loadHTMLString:_htmlString baseURL:nil];
    cell.planetWebView.delegate = self;
    cell.backgroundView = cell.planetWebView;
    cell.planetWebView.opaque = NO;
    cell.planetWebView.backgroundColor = UIColor.whiteColor;
    return cell;
}

- (void)pressedCloseButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateHeaderView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return _contentHeights;
    } else {
        return 300;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (_contentHeights == webView.scrollView.contentSize.height) {
        return;
    }

    _contentHeights = webView.scrollView.contentSize.height;
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    NSArray *arryIndices = [[NSArray alloc] initWithObjects:index, nil];
    
    [self.tableView reloadRowsAtIndexPaths:arryIndices withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
