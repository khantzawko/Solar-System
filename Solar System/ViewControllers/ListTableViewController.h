//
//  ListTableViewController.h
//  Solar System
//
//  Created by Khant Zaw Ko on 28/5/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Planet.h"

@interface ListTableViewController : UITableViewController

@property (nonatomic) NSMutableArray<Planet *> *planets;

@end
