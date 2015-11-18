//
//  LiveViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 18..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "LiveViewController.h"

@implementation LiveViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                   action:@selector(closeViewController:)];
    [[self navigationItem] setLeftBarButtonItem:closeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)closeViewController:(id)sender {
    NSLog(@"dismiss");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
