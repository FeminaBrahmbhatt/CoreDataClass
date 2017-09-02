//
//  ViewController.m
//  CoreData
//
//  Created by Femina Rajesh Brahmbhatt on 09/07/17.
//  Copyright © 2017 Femina Rajesh Brahmbhatt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize txt_address,txt_username,txt_contactno,btn_insert,tbl_records;
#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
     [self fetchusers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods
-(void)insertuser{
    //to insert the records
    NSManagedObjectContext *main = [[Datamanager sharedInstance] mainManagedObjectContext];
    [userdataclass insertInMOC:main usernamename:txt_username.text contactno:txt_contactno.text.integerValue];
    [[Datamanager sharedInstance]saveMainManagedObjectContext];
}
-(void)fetchusers{
    NSManagedObjectContext *main = [[Datamanager sharedInstance] mainManagedObjectContext];
    users = [[NSMutableArray alloc]init];
    users = [[userdataclass allInMOC:main] mutableCopy];
}

-(void)cleartextfeilds{
    txt_username.text = @"";
    txt_contactno.text = @"";
}

#pragma mark - IBActions
- (IBAction)insert_user:(id)sender {
    
    if ([txt_username.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!=0) {
        [self insertuser];
        [self cleartextfeilds];
        [self fetchusers];
        [tbl_records reloadData];
    }
    else{
        NSLog(@"please enter data");
    }
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return users.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellidentifier = @"Cellidentifier";
    UITableViewCell *cell = [tbl_records dequeueReusableCellWithIdentifier:cellidentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Username: %@   Contactno: %@",[[users objectAtIndex:indexPath.row] valueForKey:@"username"],[[users objectAtIndex:indexPath.row] valueForKey:@"contactno"]];
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"Contactno: %@",[[users objectAtIndex:indexPath.row] valueForKey:@"contactno"]];
    return cell;
}

#pragma mark - UITableviewDelegate

@end
