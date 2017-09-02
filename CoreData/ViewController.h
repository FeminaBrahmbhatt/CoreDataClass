//
//  ViewController.h
//  CoreData
//
//  Created by Femina Rajesh Brahmbhatt on 09/07/17.
//  Copyright © 2017 Femina Rajesh Brahmbhatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userdataclass.h"
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *users;
}
@property (weak, nonatomic) IBOutlet UITextField *txt_username;
@property (weak, nonatomic) IBOutlet UITextField *txt_address;
@property (weak, nonatomic) IBOutlet UITextField *txt_contactno;
@property (weak, nonatomic) IBOutlet UIButton *btn_insert;
@property (weak, nonatomic) IBOutlet UITableView *tbl_records;

- (IBAction)insert_user:(id)sender;

@end

