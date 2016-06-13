//
//  singleToneClassValues.m
//  Hi-10
//
//  Created by zee on 8/31/14.
//  Copyright (c) 2014 ibtikar. All rights reserved.
//

#import "singleToneClassValues.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "CountryLocationModel.h"

@implementation singleToneClassValues
@synthesize appDel;

static singleToneClassValues *sharedObject;

+ (singleToneClassValues *)sharedInstance {
    if (sharedObject == nil) {
        sharedObject = [[super allocWithZone:NULL] init];
        sharedObject.def_user = [NSUserDefaults standardUserDefaults];
    }
    return sharedObject;
}

+ (UIStoryboard *)LoadStoryBoard {
    UIStoryboard *AppStoryBoard;
    AppStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return AppStoryBoard;
}

+ (void)updateNavigationBar {
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : CL_Main_blue,
                                                           NSFontAttributeName : [UIFont fontWithName:FONT_NAME_REGULAR size:16],
                                                           NSShadowAttributeName : [NSShadow new]
                                                           }];
    [UINavigationBar appearance].tintColor = CL_Main_blue;
    [UINavigationBar appearance].translucent = NO;
    [UINavigationBar appearance].barTintColor=[UIColor whiteColor];

    [UINavigationBar appearance].layer.shadowColor =
    [UIColor lightGrayColor].CGColor;
    
    [[UIBarButtonItem appearance]
     setTitleTextAttributes:[NSDictionary
                             dictionaryWithObjectsAndKeys:
                             [UIFont fontWithName:FONT_NAME_REGULAR
                                             size:14.0f],
                             NSFontAttributeName, nil]
     forState:UIControlStateNormal];
}


#pragma Adjust Iboutlets
+(UIView*)MaskviewWithRoundedCorners:(UIView*)view withMaskValue:(float)maskVlaue andBorderValue:(float)borderVlaue andColor:(UIColor*)borderColor
{
    view.layer.cornerRadius=maskVlaue;
    view.layer.masksToBounds=YES;
    view.layer.borderColor=borderColor.CGColor;
    view.layer.borderWidth=borderVlaue;
    return view;
}

#pragma mark -CHANGEFONTS

+ (void)ChangeFont:(UILabel *)labelName size:(float)fontSize {
    
    labelName.font = [UIFont fontWithName:FONT_NAME_REGULAR size:fontSize];
}

+ (void)ChangeTxtFont:(UITextView *)TXTName size:(float)fontSize {
    
    TXTName.font = [UIFont fontWithName:FONT_NAME_REGULAR size:fontSize];
}

+ (void)ChangeBtnFont:(UIButton *)BtnName size:(float)fontSize {
    
    BtnName.titleLabel.font =
    [UIFont fontWithName:FONT_NAME_REGULAR size:fontSize];
}

+ (void)ChangePlaceHolderFont:(UITextField *)txt_PlaceHolder
                         size:(float)fontSize {
    [txt_PlaceHolder
     setValue:[UIFont fontWithName:FONT_NAME_REGULAR size:fontSize]
     forKeyPath:@"_placeholderLabel.font"];
    txt_PlaceHolder.font = [UIFont fontWithName:FONT_NAME_REGULAR size:fontSize];
}
+ (UILabel *)changelableHight:(UILabel *)lbl_text height:(int)num {
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:lbl_text.text];
    NSMutableParagraphStyle *paragraphStyle =
    [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:num];
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [lbl_text.text length])];
    lbl_text.attributedText = attributedString;
    return lbl_text;
}

#pragma mark getDateStr

+(NSString*)GetSelectedDateStrFromDate:(NSDate*)CurrentDate
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@" EEEE dd MMM"];
    NSString* localDateString = [formatter stringFromDate:CurrentDate];
    return localDateString;
}
#pragma mark GetUserlocation
+(CLLocation*) getCurrentLocation
{
    singleToneClassValues *shared = [singleToneClassValues sharedInstance];
    return shared.CurrentLocation;
}
+(void)setgetCurrentLocation:(CLLocation*)UserCurrentlocation
{
    singleToneClassValues *shared = [singleToneClassValues sharedInstance];
    shared.CurrentLocation=UserCurrentlocation;
}

#pragma SortLocations
+(NSArray*)SortLocationsToNearestOne:(NSMutableArray*)ArrOfFetchedLocations
{
    NSArray *orderedArrOfFetchedLocations = [ArrOfFetchedLocations sortedArrayUsingComparator:^(id a,id b) {
        CountryLocationModel *CityA = (CountryLocationModel *)a;
        CountryLocationModel *CityB = (CountryLocationModel *)b;
        CLLocationDistance distanceA = [CityA.CityLocation distanceFromLocation:[singleToneClassValues getCurrentLocation]];
        CLLocationDistance distanceB = [CityB.CityLocation distanceFromLocation:[singleToneClassValues getCurrentLocation]];
        if (distanceA < distanceB) {
            return NSOrderedDescending;
        } else if (distanceA > distanceB) {
            return NSOrderedAscending;
        } else {
            return NSOrderedSame;
        }
    }];
    return orderedArrOfFetchedLocations;
}


@end
