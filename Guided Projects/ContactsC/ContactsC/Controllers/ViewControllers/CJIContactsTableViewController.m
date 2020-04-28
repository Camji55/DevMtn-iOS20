//
//  CJIContactsTableViewController.m
//  ContactsC
//
//  Created by Cameron Ingham on 7/25/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIContactsTableViewController.h"
#import "CJIPersonController.h"
#import "CJIPerson.h"

@interface CJIContactsTableViewController ()

@end

@implementation CJIContactsTableViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[CJIPersonController sharedController] people] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];
    CJIPerson *person = [[[CJIPersonController sharedController] people] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [person name];
    cell.detailTextLabel.text = [person phoneNumber];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CJIPerson *person = [[[CJIPersonController sharedController] people] objectAtIndex:indexPath.row];
        [[CJIPersonController sharedController] deletePerson:person];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (IBAction)addPerson:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add a Contact" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Name...";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Phone number...";
        textField.keyboardType = UIKeyboardTypePhonePad;
    }];
    
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *name = [[[[[alert textFields] firstObject] text] stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet] capitalizedString];
            NSString *phoneNumber = [[[[alert textFields] objectAtIndex:1] text] stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
        
            CJIPerson *newPerson = [[CJIPerson alloc] initWithName:name phoneNumber:phoneNumber];
            [[CJIPersonController sharedController] addPerson:newPerson];
            [newPerson release];
            [self.tableView reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:addAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:true completion:nil];
    
}


@end
