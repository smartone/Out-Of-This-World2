//
//  OWSpaceImageViewController.h
//  Out Of This World2
//
//  Created by me on 10/23/13.
//  Copyright (c) 2013 me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"

@interface OWSpaceImageViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property(strong,nonatomic) UIImageView *imageView;
@property(strong, nonatomic) OWSpaceObject  *spaceObject;



@end
