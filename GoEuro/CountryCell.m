//
//  CountryCell.m
//  GoEuro
//
//  Created by Zak on 6/11/16.
//  Copyright © 2016 Zak. All rights reserved.
//


#import "CountryCell.h"
#import "singleToneClassValues.h"



@implementation CountryCell
- (id)init:(NSString*)NibName
{
    self = [super init];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]
                        loadNibNamed:NibName
                        owner:self
                        options:nil];
        self = [nib objectAtIndex:0];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [singleToneClassValues ChangeFont:_lbl_Capital size:14];
    [singleToneClassValues ChangeFont:_lbl_Country size:14];
    [singleToneClassValues ChangeFont:_lbl_Coordinates size:14];

}


@end
