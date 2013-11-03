//
//  OWOuterSpaceTableViewController.m
//  Out Of This World2
//
//  Created by me on 10/17/13.
//  Copyright (c) 2013 me. All rights reserved.
//

#import "OWOuterSpaceTableViewController.h"
#import "AstronomicalData.h"
#import "OWSpaceObject.h"
#import "OWSpaceImageViewController.h"
#import "OWSpaceDataViewController.h"

@interface OWOuterSpaceTableViewController ()

@end

@implementation OWOuterSpaceTableViewController
#define ADD_SPACE_OBJECTS_KEY @"Added Space Objects Arrary"

#pragma mark - Lazy INstantiation of Properties

-(NSMutableArray *)planets
{
    if (!_planets){
        _planets = [[NSMutableArray alloc]init];
    }
    return _planets;
}

-(NSMutableArray *)addedSpaceObjects
{
    if (!_addedSpaceObjects){
        _addedSpaceObjects =[[NSMutableArray alloc]init];
    }
    return _addedSpaceObjects;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
 
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets]){
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
        OWSpaceObject *planet = [[OWSpaceObject alloc] initWithData:planetData andImage:[UIImage imageNamed: imageName]];
        [self.planets addObject:planet ];
    
    }
    
    NSArray *myPlanetsAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ADD_SPACE_OBJECTS_KEY];
    for (NSDictionary *dictionary in myPlanetsAsPropertyLists) {
        OWSpaceObject *spaceObject = [self spaceObjectForDictionary:dictionary];
        [self.addedSpaceObjects addObject:spaceObject];
    }

    
}

    
    
//    NSMutableDictionary *mydictionary = [[NSMutableDictionary alloc] init];
//    NSString *firstColor = @"red";
//    [mydictionary setObject:firstColor forKey:@"firetruck Color"];
//    [mydictionary setObject:@"blue" forKey:@"ocean color"];
//    [mydictionary setObject:@"yellow" forKey:@"star color"];
//    
//    NSLog(@"%@" , mydictionary);
//    
//    NSString *blueString  = [mydictionary objectForKey:@"ocean color"];
//       NSLog(@"%@" , blueString);
    
 //   NSNumber *myNumber = [NSNumber numberWithInt:5];
    


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
        if ([sender isKindOfClass:[UITableViewCell class]])
        {
            
            if ([segue.destinationViewController isKindOfClass:
                 [OWSpaceImageViewController class]])
            {
                OWSpaceImageViewController *nextViewController = segue.
                destinationViewController;
                NSIndexPath *path = [self.tableView indexPathForCell:sender];
                OWSpaceObject *selectedObject;
                
                if (path.section == 0) {
                    selectedObject = self.planets[path.row];
                }
                else if (path.section == 1){
                    selectedObject = self.addedSpaceObjects[path.row];
                }
                nextViewController.spaceObject = selectedObject;
            }
            
        }
    
    if ([sender isKindOfClass:[NSIndexPath class]])
    {
        if ([segue.destinationViewController isKindOfClass:[OWSpaceDataViewController class]])
        {
            
            OWSpaceDataViewController *targetViewController =segue.destinationViewController;
            NSIndexPath *path = sender;
            OWSpaceObject *selectedObject;
            
            if (path.section == 0) {
                selectedObject = self.planets[path.row];
            }
            else if (path.section == 1){
                selectedObject = self.addedSpaceObjects[path.row];
            }
            targetViewController.spaceObject = selectedObject;
        }
    }
    
    if ([segue.destinationViewController isKindOfClass:
         [OWAddSpaceObjectViewController class]]){
        OWAddSpaceObjectViewController
        *addSpaceObjectVC = segue.destinationViewController;
        addSpaceObjectVC.delegate =self;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}


#pragma mark - OWAddSpaceObjectViewController Delegate


-(void)didCancel
{
    //NSLog(@"didCancel");
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)addSpaceObject:(OWSpaceObject *)spaceObject
{
    
    
    [self.addedSpaceObjects addObject:spaceObject];
    
   // Will save to NSuserDefault here
    NSMutableArray *spaceObjectsAsPropertyLists = [[[NSUserDefaults
        standardUserDefaults] arrayForKey:ADD_SPACE_OBJECTS_KEY] mutableCopy];
    if(!spaceObjectsAsPropertyLists) spaceObjectsAsPropertyLists = [[NSMutableArray alloc]init];
    
    [spaceObjectsAsPropertyLists addObject:
     [self spaceObjectAsPropertyList:spaceObject]];
    [[NSUserDefaults standardUserDefaults]
     setObject:spaceObjectsAsPropertyLists forKey:ADD_SPACE_OBJECTS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
}

#pragma mark - Helper Methods

-(NSDictionary *) spaceObjectAsPropertyList:(OWSpaceObject *)spaceObject
{
    
    
    NSData *imageData = UIImagePNGRepresentation(spaceObject.spaceImage);
    
    NSDictionary *dictionary = @{PLANET_NAME : spaceObject.name, PLANET_GRAVITY:@(spaceObject.gravitationalForce) ,PLANET_DIAMETER : @(spaceObject.diameter), PLANET_YEAR_LENGTH : @(spaceObject.yearLength), PLANET_DAY_LENGTH : @(spaceObject.dayLength), PLANET_TEMPERATURE : @(spaceObject.temperature), PLANET_NUMBER_OF_MOONS : @(spaceObject.numberOfMoons) ,PLANET_NICKNAME : spaceObject.nickname ,PLANET_INTERESTING_FACT : spaceObject.interestFact ,PLANET_IMAGE : imageData};
    
    
    
    return dictionary;
    
}

-(OWSpaceObject *)spaceObjectForDictionary: (NSDictionary *)dictionary {
    
    NSData *dataForImage  = dictionary[PLANET_IMAGE];
    UIImage *spaceObjectImage = [UIImage imageWithData:dataForImage];
    OWSpaceObject *spaceObject = [[OWSpaceObject alloc] initWithData:
    dictionary andImage:spaceObjectImage];
    return spaceObject;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    if ([self.addedSpaceObjects count]){
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (section == 1){
        return [self.addedSpaceObjects count];
    }
    else {
        return [self.planets count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (indexPath.section == 1){
        //Use new Space object to customize our cell
        OWSpaceObject *planet =[self.addedSpaceObjects objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
    }
    else{

        OWSpaceObject *planet  = [self.planets objectAtIndex:indexPath.row];
        cell.textLabel.text  =planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image =planet.spaceImage;
    
    }
    cell.backgroundColor =  [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha: 1.0];
    
    
    return cell;
}





#pragma UITableView Delegate


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
   
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
    
}

//Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 1) { return YES;
    } else return NO;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
         [self.addedSpaceObjects removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newSavedSpaceObjectData = [[NSMutableArray alloc] init];
        for (OWSpaceObject *spaceObject in self.addedSpaceObjects) {
            [newSavedSpaceObjectData addObject:[self spaceObjectAsPropertyList:spaceObject]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newSavedSpaceObjectData forKey:ADD_SPACE_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
