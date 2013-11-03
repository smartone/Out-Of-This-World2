//
//  OWSpaceDataViewController.m
//  Out Of This World2
//
//  Created by me on 10/25/13.
//  Copyright (c) 2013 me. All rights reserved.
//

#import "OWSpaceDataViewController.h"

@interface OWSpaceDataViewController ()

@end

@implementation OWSpaceDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor blackColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDataSource 

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIndentifier =@"DataCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier forIndexPath:indexPath];
    
    cell.textLabel.text =@"Data";





    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text =@"Nickname :";
            cell.detailTextLabel.text = self.spaceObject.nickname;
            break;
            
        case 1:
            cell.textLabel.text = @"Diameter (km) :";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f" ,self.spaceObject.diameter];
            break;
            
        case 2:
            cell.textLabel.text = @"Gravitational Force :";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f" ,self.spaceObject.gravitationalForce];
            break;
        
        case 3:
            cell.textLabel.text = @"Length of Year (days) :";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f" ,self.spaceObject.yearLength];
            break;
            
        case 4:
            cell.textLabel.text = @"Length of Day (hours) :";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f" ,self.spaceObject.dayLength];
            break;
            
        case 5:
            cell.textLabel.text = @"Temparture (celsius):";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f" ,self.spaceObject.temperature];
            break;
            
        case 6:
            cell.textLabel.text = @"Number of Moon :";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%i" ,self.spaceObject.numberOfMoons];
            break;
            
        case 7:
            cell.textLabel.text = @"Interesting Fact :";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@" ,self.spaceObject.interestFact];
            break;
            
        default:
            break;
    
     
    }
    
    return cell;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return 8;
}





@end
