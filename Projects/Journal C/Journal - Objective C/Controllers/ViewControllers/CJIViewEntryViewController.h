//
//  CJIViewEntryViewController.h
//  Journal - Objective C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJIEntry.h"

@interface CJIViewEntryViewController : UIViewController

@property (nonatomic) CJIEntry* entry;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyTextLabel;

- (IBAction)cancel:(id)sender;

@end
