//
//  OWSpaceDataViewController.h
//  Out Of This World2
//
//  Created by me on 10/25/13.
//  Copyright (c) 2013 me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"

@interface OWSpaceDataViewController : UIViewController <UITableViewDelegate , UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) OWSpaceObject *spaceObject;

@end
