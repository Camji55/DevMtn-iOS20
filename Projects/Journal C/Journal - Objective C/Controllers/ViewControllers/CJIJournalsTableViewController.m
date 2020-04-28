//
//  CJIJournalsTableViewController.m
//  Journal - Objective C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIJournalsTableViewController.h"
#import "CJIJournalController.h"
#import "CJIJournalTableViewCell.h"
#import "CJIEntriesTableViewController.h"

@interface CJIJournalsTableViewController ()

- (IBAction)addJournal:(id)sender;

@end

@implementation CJIJournalsTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[CJIJournalController sharedController] journals] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CJIJournalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JournalCell" forIndexPath:indexPath];
    CJIJournal *journal = [[[CJIJournalController sharedController] journals] objectAtIndex:indexPath.row];
    
    UIView* view = [[[cell contentView] subviews] firstObject];
    
    cell.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    view.layer.cornerRadius = 4;
    view.layer.shadowColor = [[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] CGColor];
    view.layer.shadowOffset = CGSizeMake(0, 1);
    view.layer.shadowOpacity = 0.1;
    view.layer.shadowRadius = 5.0;
    cell.contentView.layer.masksToBounds = true;
    
    cell.titleLabel.text = journal.name;
    
    NSString* ending = @"";
    
    if(journal.entries.count == 1)
    {
        ending = @"Entry";
    }
    else
    {
        ending = @"Entries";
    }
    
    cell.entryLabel.text = [NSString stringWithFormat:@"%lu %@", journal.entries.count, ending];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CJIJournal *journal = [[[CJIJournalController sharedController] journals] objectAtIndex:indexPath.row];
        [[CJIJournalController sharedController] deleteJournal:journal];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ToEntriesVC"]){
        NSIndexPath* indexPath = self.tableView.indexPathForSelectedRow;
        CJIJournal* journal = [[[CJIJournalController sharedController] journals] objectAtIndex:indexPath.row];
        CJIEntriesTableViewController* destinationVC = segue.destinationViewController;
        destinationVC.journal = journal;
    }
}

- (IBAction)addJournal:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Journal Name" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Create" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = [[alert textFields] firstObject];
        if(![textField.text isEqualToString:@""])
        {
            [CJIJournalController.sharedController createJournalWithName:textField.text];
            [self.tableView reloadData];
        }
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter journal name...";
    }];
    
    [alert addAction:action];
    [alert addAction:noAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
