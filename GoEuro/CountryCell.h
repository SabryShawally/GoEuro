//
//  CountryCell.h
//  GoEuro
//
//  Created by Zak on 6/11/16.
//  Copyright © 2016 Zak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbl_Country;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Capital;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Coordinates;

- (id)init:(NSString*)NibName;

@end
