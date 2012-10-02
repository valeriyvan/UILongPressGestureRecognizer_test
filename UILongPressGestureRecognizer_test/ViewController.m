//
//  ViewController.m
//  UILongPressGestureRecognizer_test
//
//  Created by Valeriy Van on 02.10.12.
//  Copyright (c) 2012 w7software.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 54;
}

-(void)detectTouchImage:(UIGestureRecognizer *)gestureRecognizer;
{
    NSMutableString *ttl = [NSMutableString stringWithString:@"GestureRecognizer"];
    if(UIGestureRecognizerStateBegan == gestureRecognizer.state) {
        // Called on start of gesture, do work here
        [ttl appendString:@" began"];
    } else if(UIGestureRecognizerStateChanged == gestureRecognizer.state) {
        // Do repeated work here (repeats continuously) while finger is down
        [ttl appendString:@" changed"];
    } else if(UIGestureRecognizerStateEnded == gestureRecognizer.state) {
        // Do end work here when finger is lifted
        [ttl appendString:@" ended"];
    } else if(UIGestureRecognizerStateCancelled == gestureRecognizer.state) {
        // Do end work here when finger is lifted
        [ttl appendString:@" cancelled"];
    } else if(UIGestureRecognizerStateFailed == gestureRecognizer.state) {
        // Do end work here when finger is lifted
        [ttl appendString:@" failed"];
    } else
    // UIGestureRecognizerStateRecognized is the same as UIGestureRecognizerStateEnded
    //if(UIGestureRecognizerStateRecognized == gestureRecognizer.state) {
    //    // Do end work here when finger is lifted
    //    [ttl appendString:@" recognized"];
    //} else
    if(UIGestureRecognizerStatePossible == gestureRecognizer.state) {
        // Do end work here when finger is lifted
        [ttl appendString:@" possible"];
    }

    UIImageView *myImageView = (UIImageView*)gestureRecognizer.view;
    
    // testing myImageView.image==nil you can check when myImageView has no image in it
    NSString *msg = myImageView.image==nil? @"no image": nil;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ttl message:msg delegate:nil cancelButtonTitle:@"Ok, I'm happy now" otherButtonTitles:nil, nil ];
    [alert show];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(320/2-20, 0, 40, 40)];
        imageView.tag = 777;
        imageView.userInteractionEnabled = YES;
        
        // UILongPressGestureRecognizer
        // I really have no ideai why it fires three times
        // Try UITapGestureRecognizer with snippet below. It fires once.
        // Oh, I got it. UILongPressGestureRecognizer is is a continuous event recognizer.
        // See detectTouchImage how it could be handled.
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(detectTouchImage:)];
        [recognizer setMinimumPressDuration:1.0];
        [imageView setUserInteractionEnabled:YES];
        [imageView addGestureRecognizer:recognizer];

        ////UITapGestureRecognizer
        //UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detectTouchImage:)];
        //[imageView setUserInteractionEnabled:YES];
        //[imageView addGestureRecognizer:recognizer];

        [cell addSubview:imageView];
    }
    
    // Configure the cell...
    
    // Set image into imageView
    NSString *imageFileName = [NSString stringWithFormat:@"%d.png", [indexPath row]+1];
    UIImageView *myImageView = (UIImageView*)[cell viewWithTag:777];
    myImageView.image = [UIImage imageNamed:imageFileName];
    
    // Set text and detailText
    NSMutableString *text =  [NSMutableString stringWithFormat:@"%d", [indexPath row]+1];
    if (myImageView.image==nil)
        [text appendString:@" file not found in bundle"];
    cell.textLabel.text = [text copy];
    cell.detailTextLabel.text = [imageFileName copy];

    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
