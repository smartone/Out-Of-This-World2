//
//  OWOuterSpaceTableViewController.h
//  Out Of This World2
//
//  Created by me on 10/17/13.
//  Copyright (c) 2013 me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWAddSpaceObjectViewController.h"


@interface OWOuterSpaceTableViewController : UITableViewController
 <OWAddSpaceObjectViewControllerDelegate>

@property (strong, nonatomic ) NSMutableArray *planets;
@property (strong,nonatomic) NSMutableArray * addedSpaceObjects;


@end

