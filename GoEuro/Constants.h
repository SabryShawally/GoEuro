//
//  Constants.h
//  P_Necessary
//
//  Created by ahmed zahran on 10/20/14.
//  Copyright (c) 2014 Ibtikar Tech. All rights reserved.
//


#define Domain @"http://api.goeuro.com/api/v2"
#define URL_GetCurrentLocationCities Domain@"/position/suggest/de/%@"



#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define IS_IPHONE_6PLUS (IS_IPHONE && [[UIScreen mainScreen] nativeScale] == 3.0f)
#define IS_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_RETINA ([[UIScreen mainScreen] scale] == 2.0)
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


#define SHOW_STANDARD_ALERT(title, messageText, okButton, cancelButton) UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:messageText delegate:self cancelButtonTitle:cancelButton otherButtonTitles:okButton,nil];[alertView show];



#define CL_Main_blue [UIColor colorWithRed:48.0/255.0f green:133.0/255.0f blue:181.0/255.0f alpha:1]
#define CL_SliderNormal [UIColor colorWithRed:217.0/255.0f green:217.0/255.0f blue:217.0/255.0f alpha:1]
#define CL_SliderSelected [UIColor colorWithRed:133.0/255.0f green:133.0/255.0f blue:133.0/255.0f alpha:1]
#define CL_Separtor [UIColor colorWithRed:241.0/255.0f green:239.0/255.0f blue:239.0/255.0f alpha:1]
#define CL_Item_Title_Setting [UIColor colorWithRed:165.0/255.0f green:178.0/255.0f blue:184.0/255.0f alpha:1]
#define CL_Main_blue_light [UIColor colorWithRed:30.0/255.0f green:145.0/255.0f blue:243.0/255.0f alpha:.55]








#define FONT_NAME_REGULAR @"AJannatLT"



