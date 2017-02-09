//
//  VCGDif.m
//  Visor
//
//  Created by chable on 1/31/17.
//  Copyright (c) 2017 ST. All rights reserved.
//

#import "VCGDIF.h"
#import "BDManager.h"
#import "PNChart.h"

@interface VCGDIF ()
@property (nonatomic, strong) BDManager *dbManager;
@property (nonatomic, strong) NSArray *arrDatos;

@end

@implementation VCGDIF


- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
    [self obtenerDatos];
    
    //NSLog(@"Num Registros %lu" , self.arrDatos.count);
    NSLog(@"%@  %@" ,  [[self.arrDatos objectAtIndex:0]objectAtIndex:0],     [[self.arrDatos objectAtIndex:0]objectAtIndex:1]);
    
    
    //For Pie Chart
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNRed description:@"otro"],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNBlue description:@"WWDC"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNGreen description:@"GOOL I/O"],
                       ];
    
    NSArray *colors = @[PNRed, PNBlue, PNGreen];

    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < [self.arrDatos count]; i++)
    {
        int value = [[[self.arrDatos objectAtIndex:i]objectAtIndex:1] intValue];
        PNPieChartDataItem *eColumnDataModel = [PNPieChartDataItem dataItemWithValue:value color:[colors objectAtIndex:i] description:[[self.arrDatos objectAtIndex:i]objectAtIndex:0]];
        
        [temp addObject:eColumnDataModel];
    }

    //(40.0, 155.0, 240.0, 240.0)
    
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 155.0, 240.0, 240.0) items:temp];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
    [pieChart strokeChart];
    
    [self.view addSubview:pieChart];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) obtenerDatos{
    
    NSString *query = @"select  etiqueta, valor from grafica_xy";
    if (self.arrDatos != nil){self.arrDatos = nil;}
    self.arrDatos = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
}


@end
