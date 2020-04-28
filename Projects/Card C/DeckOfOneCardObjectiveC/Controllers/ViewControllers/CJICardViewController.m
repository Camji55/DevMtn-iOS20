//
//  CJICardViewController.m
//  DeckOfOneCardObjectiveC
//
//  Created by Cameron Ingham on 7/24/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJICardViewController.h"
#import "CJICardController.h"
#import "CJICard.h"

@interface CJICardViewController ()

@property (weak, nonatomic) IBOutlet UILabel *drawCardLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UIButton *drawCardButton;

- (IBAction)newCard:(id)sender;

@end

@implementation CJICardViewController

- (IBAction)newCard:(id)sender {
    self.drawCardLabel.text = @"Loading...";
    [[self drawCardButton]setEnabled:false];
    [CJICardController fetchNewCardWithCompletion:^(CJICard *card) {
        [CJICardController cardImageFromCard:card completion:^(UIImage *cardImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cardImageView.image = cardImage;
                [[self drawCardButton]setEnabled:true];
            });
        }];
    }];
}

@end
