
//
//  InputLineViewController.m
//  Rapid
//
//  Created by eWAY on 4/17/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "InputLineViewController.h"

@interface InputLineViewController ()

@end

@implementation InputLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Line";
    
    svContent.contentSize = CGSizeMake(svContent.frame.size.width, svContent.frame.size.height);
    
    //add button
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = addBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)done:(id)sender
{
    LineItem *lineObj = [[LineItem alloc] init];
    lineObj.SKU = tfSKU.text;
    lineObj.Description = tfDescription.text;
    @try {
        lineObj.Tax = [tfTax.text intValue];
        lineObj.Total  = [tfTotal.text intValue];
        lineObj.Quantity = [tfQuantity.text intValue];
        lineObj.UnitCost = [tfSUnitCost.text intValue];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        self.callback(lineObj);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

@end
