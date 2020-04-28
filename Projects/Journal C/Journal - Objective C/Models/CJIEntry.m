//
//  Entry.m
//  Journal - Objective C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIEntry.h"

@implementation CJIEntry

- (instancetype)initWithTitle:(NSString *)title timeStamp:(NSDate *)timeStamp bodyText:(NSString *)bodyText
{
    self = [super init];
    if(self){
        _title = title;
        _timeStamp = timeStamp;
        _bodyText = bodyText;
    }
    return self;
}

- (NSString *)getDateString
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm a 'on' MMMM dd, yyyy";
    return [dateFormatter stringFromDate:self.timeStamp];
}

- (BOOL)isEqual:(id)object
{
    if(![object isKindOfClass:[CJIEntry class]]) { return NO; }
    
    CJIEntry *entry = object;
    
    if(![entry.title isEqualToString:self.title] && entry.title != self.title) { return NO; }
    if(![entry.bodyText isEqualToString:self.bodyText] && entry.bodyText != self.bodyText) { return NO; }
    
    return YES;
}

@end
