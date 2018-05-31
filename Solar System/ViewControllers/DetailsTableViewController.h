//
//  DetailsTableViewController.h
//  Solar System
//
//  Created by Khant Zaw Ko on 28/5/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsTableViewController : UITableViewController <UIWebViewDelegate>

@property (nonatomic) NSString *planetName;
@property (nonatomic) NSString *planetDescription;
@property (nonatomic) NSString *planetImagePath;

@end
