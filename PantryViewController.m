//
//  PantryViewController.m
//  Pantry
//
//  Created by Dylan Moore on 8/5/14.
//  Copyright (c) 2014 LetsAt. All rights reserved.
//

#import "PantryViewController.h"
#import "UIColor+PantryColors.h"

@interface PantryViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UITableView *groceryTableView;

@end

NSArray *groceries;

@implementation PantryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"fakeGroceryList" ofType:@"plist"];
    groceries = [NSArray arrayWithContentsOfFile:plistPath];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"perish" ascending:YES];
    groceries = [groceries sortedArrayUsingDescriptors:@[sortDescriptor]];
	// Do any additional setup after loading the view, typically from a nib.
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return groceries.count+1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groceryItemCell"];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"groceryItemCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UILabel *likelyToPerishIndicator = (UILabel*)[cell viewWithTag:2];
    UILabel *groceryName = (UILabel*)[cell viewWithTag:1];
    UIImageView *plusView = (UIImageView*)[cell viewWithTag:3];

    
    if(indexPath.row<groceries.count){
    NSDictionary *groceryItem = groceries[indexPath.row];
    
    
    NSNumber *perishDays = groceryItem[@"perish"];
    
    likelyToPerishIndicator.layer.cornerRadius = likelyToPerishIndicator.bounds.size.height/2;
    
    [likelyToPerishIndicator setClipsToBounds:YES];
                                                  
                                                  
    if(perishDays.intValue <= 3){
        [likelyToPerishIndicator setBackgroundColor:[UIColor pantryRed]];
        [likelyToPerishIndicator setAlpha:1];
    }else if(perishDays.intValue <=5){
        [likelyToPerishIndicator setBackgroundColor:[UIColor pantryYellow]];
        [likelyToPerishIndicator setAlpha:1];
    }else{
        [likelyToPerishIndicator setAlpha:0];
    }
        
        [plusView setAlpha:0];
    
    NSString *name = [groceryItem[@"name"] capitalizedString];
        
    [groceryName setText:name];
        
    }else{
        [groceryName setText:nil];
        [likelyToPerishIndicator setAlpha:0];
        [plusView setAlpha:1];
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
