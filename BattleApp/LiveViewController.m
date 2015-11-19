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
    [self setupCloseButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupCloseButton {
    UIBarButtonItem *closeButton = [UIBarButtonItem alloc];
    closeButton = [closeButton init];
    [closeButton setTitle:@"Close"];
    [closeButton setStyle:UIBarButtonItemStylePlain];
    [closeButton setTarget:self];
    [closeButton setAction:@selector(closeViewController:)];
//    closeButton = [closeButton initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeViewController:)];
    [[self navigationItem] setLeftBarButtonItem:closeButton];
}

- (IBAction)closeViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
