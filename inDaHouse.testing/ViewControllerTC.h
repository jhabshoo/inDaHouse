//
//  ViewControllerTC.h
//  inDaHouse.testing
//
//  Created by Jeff Hurray on 12/7/12.
//  Copyright (c) 2012 Newton South High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewControllerTC : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) UITextView *textBox;
@property (strong, nonatomic) NSString *titleHeader;

@property (strong, nonatomic) UITextView *textBox2;
@property (strong, nonatomic) NSString *category;
@property double latitude;
@property double longitude;

-(void)makeChanges;

@end
