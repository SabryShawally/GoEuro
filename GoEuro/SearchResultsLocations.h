
//
//  SearchResultsLocations.h
//  GoEuro
//
//  Created by Zak on 6/11/16.
//  Copyright © 2016 Zak. All rights reserved.
//

@import UIKit;
#import "CountryLocationModel.h"

@protocol SelectedResultsDelegate <NSObject>
@optional

-(void)DidSelectLocation:(CountryLocationModel*)SelectedLocation andType:(NSString*)Type;

@end


@interface SearchResultsLocations : UITableViewController
@property (nonatomic,weak) id <SelectedResultsDelegate> delegate;
@property(nonatomic,strong)NSString *Type;


@end
