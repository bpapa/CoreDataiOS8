//
//  MasterViewController.h
//  CoreDataiOS8
//
//  Created by Brian Papa on 2/27/15.
//  Copyright (c) 2015 bpm apps LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)doFetchRequest:(id)sender;
- (IBAction)doAsyncFetchRequest:(id)sender;
- (IBAction)doReset:(id)sender;
- (IBAction)doBatchUpdateInMemory:(id)sender;
- (IBAction)doBatchUpdateRequest:(id)sender;

@end

