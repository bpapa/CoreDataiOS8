//
//  MasterViewController.m
//  CoreDataiOS8
//
//  Created by Brian Papa on 2/27/15.
//  Copyright (c) 2015 bpm apps LLC. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()
@property NSArray *employees;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {

    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.employees.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *object = self.employees[indexPath.row];
    cell.textLabel.text = [[object valueForKey:@"name"] description];
}

- (IBAction)doFetchRequest:(id)sender {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Employee"];
    NSError *fetchError;
    self.employees = [self.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    if (!self.employees) {
        NSLog(@"%@", fetchError);
    } else {
        [self.tableView reloadData];
    }
}

- (IBAction)doAsyncFetchRequest:(id)sender {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    NSAsynchronousFetchRequest *async = [[NSAsynchronousFetchRequest alloc] initWithFetchRequest:request completionBlock:^(NSAsynchronousFetchResult *result) {
        if (result.finalResult) {
            self.employees = result.finalResult;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", result.operationError);
        }
    }];
    [self.managedObjectContext performBlock: ^() {
        NSError *blockError = nil;
        NSAsynchronousFetchResult *asyncResult = (NSAsynchronousFetchResult*)[self.managedObjectContext executeRequest:async error:&blockError];
        if (!asyncResult) {
            NSLog(@"%@", blockError);
        }
    }];
}
@end
