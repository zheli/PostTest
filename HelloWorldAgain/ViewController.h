//
//  ViewController.h
//  HelloWorldAgain
//
//  Created by Li Zhe on 10/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate> {
    NSString *userName;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, copy) NSString *userName;

- (IBAction)changeGreeting:(id)sender;

@end
