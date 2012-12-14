//
//  ViewControllerTV.m
//  inDaHouse.testing
//
//  Created by Jeff Hurray on 11/26/12.
//  Copyright (c) 2012 Newton South High School. All rights reserved.
//

#import "ViewControllerTV.h"

@interface ViewControllerTV ()

@end

@implementation ViewControllerTV
@synthesize tab;
@synthesize table;
@synthesize cellView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self.table reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //overarching
    [[Places sharedInstance] placesMA];

    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.navigationController.navigationBar.topItem.title = @"PLACES";
    
    //mess with stuff
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    tab = nil;
    table = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    // Return the number of rows in the section.
    return [[Places sharedInstance] placesMA].count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(!cellView){
    ViewControllerTC *temp = [[ViewControllerTC alloc]init];
        self.cellView = temp;
    }
    
    ALPlace *temp =  [[[Places sharedInstance] placesMA] objectAtIndex:indexPath.row];
    self.cellView.titleHeader = temp.name;
    
    self.cellView.category = temp.category;
    self.cellView.latitude = temp.location.coordinate.latitude;
    self.cellView.longitude = temp.location.coordinate.longitude;
    [self.cellView makeChanges];
    
    [self.navigationController pushViewController:self.cellView animated:YES];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        ALPlace *temp = [[[Places sharedInstance] placesMA] objectAtIndex:indexPath.row];
        NSLog(@"index row is loading. index row is %i\n\n",indexPath.row);
        cell.textLabel.text = temp.name;
        cell.detailTextLabel.text = temp.category;
        
    }
    return cell;
    
}





@end
