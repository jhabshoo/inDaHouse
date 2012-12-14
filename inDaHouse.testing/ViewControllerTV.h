//
//  ViewControllerTV.h
//  inDaHouse.testing
//
//  Created by Jeff Hurray on 11/26/12.
//  Copyright (c) 2012 Newton South High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Places.h"
#import "ViewControllerTC.h"

@interface ViewControllerTV : UIViewController <UITabBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) IBOutlet UITabBar *tab;
@property (nonatomic, strong) IBOutlet UITableView *table;
@property (nonatomic, strong) ViewControllerTC *cellView;


@end
