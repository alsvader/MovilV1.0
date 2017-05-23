//
//  ViewController.h
//  Visor
//
//  Created by chable on 11/15/16.
//  Copyright (c) 2016 ST. All rights reserved.
//


#import <UIKit/UIKit.h>
//#import <UIKit/UITableView.h>

@interface VCITemas : UIViewController

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bAlfabetico;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bDependencia;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bEje;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

//@property (weak, nonatomic) IBOutlet UIBarButtonItem *bAlfabetico;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *bDependencia;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *bEje;
//Parametros
@property (strong, nonatomic) id pTrimestreSel;

@end


