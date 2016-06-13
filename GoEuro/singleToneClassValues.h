//
//  singleToneClassValues.h
//  P_Necessary
//
//  Created by zee on 8/31/14.
//  Copyright (c) 2014 ibtikar. All rights reserved.
//

///singleton Class

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Constants.h"





@interface singleToneClassValues : NSObject

@property (nonatomic, strong) AppDelegate *appDel;
@property (nonatomic,strong)  NSUserDefaults *def_user;
@property(nonatomic,strong)CLLocation *CurrentLocation;






//changing fonts for uilable || txtview || btn ||placeholder&textfield
+(void)ChangeFont:(UILabel*)labelName size:(float)fontSize;
+(void)ChangeTxtFont:(UITextView*)TXTName size:(float)fontSize;
+(void)ChangeBtnFont:(UIButton*)BtnName size:(float)fontSize;
+(void)ChangePlaceHolderFont:(UITextField*)txt_PlaceHolder size:(float)fontSize;


//GetUserLocation
+(CLLocation*) getCurrentLocation;
+(void)setgetCurrentLocation:(CLLocation*)UserCurrentlocation;

//load story board
+(UIStoryboard*)LoadStoryBoard;

//CONFIGURE nvaigation
+ (void)updateNavigationBar;

//Configure iboutlets
+(UIView*)MaskviewWithRoundedCorners:(UIView*)view withMaskValue:(float)maskVlaue andBorderValue:(float)borderVlaue andColor:(UIColor*)borderColor;
//ConvertDates
+(NSString*)GetSelectedDateStrFromDate:(NSDate*)CurrentDate;

//sort LocationsToNearsestOne
+(NSMutableArray*)SortLocationsToNearestOne:(NSMutableArray*)ArrOfFetchedLocations;


@end
