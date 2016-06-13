//
//  CalendarViewController.h
//  GoEuro
//
//  Created by Zak on 6/12/16.
//  Copyright © 2016 Zak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>

@protocol GoEuroCalendarDelegate <NSObject>

@optional
-(void)DidGetSelectedDateStr:(NSString*)SelectedDateStr;
@end


@interface CalendarViewController : UIViewController<JTCalendarDelegate>
{
    NSDate *_dateSelected;
    NSDate *_todayDate;
    NSDate *_minDate;
    NSDate *_maxDate;
}
@property (nonatomic,strong) id<GoEuroCalendarDelegate> delegate;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;

@end
