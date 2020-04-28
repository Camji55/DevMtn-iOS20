//
//  CJIEntriesTableViewController.m
//  Journal - Objective C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIEntriesTableViewController.h"
#import "CJIJournalController.h"
#import "CJIJournal.h"
#import "CJIEntry.h"
#import "CJIEntryTableViewCell.h"
#import "CJIAddEntryViewController.h"
#import "CJIViewEntryViewController.h"

@interface CJIEntriesTableViewController ()

@end

@implementation CJIEntriesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [self.journal name];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.journal entries] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CJIEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntryCell" forIndexPath:indexPath];
    CJIEntry* myEntry = [[self.journal entries] objectAtIndex:indexPath.row];
    
    UIView* view = [[[cell contentView] subviews] firstObject];
    
    cell.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    view.layer.cornerRadius = 4;
    view.layer.shadowColor = [[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] CGColor];
    view.layer.shadowOffset = CGSizeMake(0, 1);
    view.layer.shadowOpacity = 0.1;
    view.layer.shadowRadius = 5.0;
    cell.contentView.layer.masksToBounds = true;
    
    cell.titleLabel.text = myEntry.title;
    cell.timeStampLabel.text = myEntry.getDateString;
    cell.bodyTextLabel.text = myEntry.bodyText;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        CJIEntry* myEntry = [[self.journal entries] objectAtIndex:indexPath.row];
        [[CJIJournalController sharedController] deleteEntry:myEntry from:self.journal];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)unwindToEntryList:(UIStoryboardSegue *)sender
{
    CJIAddEntryViewController* sourceVC = [sender sourceViewController];
    NSString* entryTitle = [sourceVC entryTitle];
    NSString* entryBody = [sourceVC entryBody];
    [[CJIJournalController sharedController]addEntryWithTitle:entryTitle timeStamp:[NSDate date] bodyText:entryBody toJournal:self.journal];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ToViewEntry"]){
        NSIndexPath* indexPath = self.tableView.indexPathForSelectedRow;
        CJIEntry* entry = [[self.journal entries] objectAtIndex:indexPath.row];
        CJIViewEntryViewController* destinationVC = segue.destinationViewController;
        destinationVC.entry = entry;
    }
}

@end
