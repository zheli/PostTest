//
//  ViewController.m
//  HelloWorldAgain
//
//  Created by Li Zhe on 10/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ASIFormDataRequest.h"

@implementation ViewController
@synthesize userName=_userName;
@synthesize textField = _textField;
@synthesize label = _label;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)changeGreeting:(id)sender {
    self.label.text = @"Loging...";
    self.userName = self.textField.text;
    
    self.label.text = @"Posting...@";
    
    NSURL *loginUrl = [NSURL URLWithString:@"http://api.mart.fm/account/login.json?email=mm@mart.fm&password=martmart"];
    ASIHTTPRequest *loginRequest = [ASIHTTPRequest requestWithURL:loginUrl];
    [loginRequest startSynchronous];
    int statusCode = [loginRequest responseStatusCode];
    NSString *loginResult = [loginRequest responseString];
    NSLog(@"Status: [%d], Result: %@", statusCode, loginResult);
    
    NSString *nameString = self.userName;
    if ([nameString length] == 0) {
        nameString = @"World";
    }
    
    NSURL *url = [NSURL URLWithString: @"http://api.mart.fm/item/create.json"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue: @"Test"      forKey: @"title"];
    [request setPostValue: @"12"        forKey: @"price"];
    [request setPostValue: @"51.2735"   forKey: @"lat"];
    [request setPostValue: @"103.1645"  forKey: @"lon"];
    [request setPostValue: @"1"         forKey: @"currency"];
    [request setPostValue: @"http://i.mart.fm/l/1306731337.jpg,http://i.mart.fm/l/1306731339.jpg"
                                        forKey: @"currency"];
    [request setPostValue: @"http://i.mart.fm/s/1306731337.jpg,http://i.mart.fm/s/1306731339.jpg"
                                        forKey: @"minurl"];
    NSLog(@"POST data to API...");
    [request startSynchronous];
    NSError *error = [request error];
    NSString *result = @"Post failed!";
    NSLog(@"%@", error);
    if (!error) {
        NSString *response = [request responseString];
        NSLog(@"%@", response);
        result = @"Post succeed!";
    }
    self.label.text = result;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.textField) {
        [theTextField resignFirstResponder];
    }
    NSString *message = @"Finished typeing.";
    self.label.text = message;
    
    return YES;
}

@end
