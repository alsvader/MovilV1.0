//
//  VCGDif.m
//  Visor
//
//  Created by chable on 1/31/17.
//  Copyright (c) 2017 ST. All rights reserved.
//

#import "VCGPastel.h"
#import "BDManager.h"
#import "PNChart.h"

@interface VCGPastel ()
@property (nonatomic, strong) BDManager *dbManager;
@property (nonatomic, strong) NSArray *arrDatos;

@end

@implementation VCGPastel


- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
    [self obtenerDatos];
    
    //NSLog(@"Num Registros %lu" , self.arrDatos.count);
    NSLog(@"%@  %@" ,  [[self.arrDatos objectAtIndex:0]objectAtIndex:4],     [[self.arrDatos objectAtIndex:0]objectAtIndex:5]);
    
    
    //For Pie Chart
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNRed description:@"otro"],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNBlue description:@"WWDC"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNGreen description:@"GOOL I/O"],
                       ];
    
    NSArray *colors = @[PNRed, PNBlue, PNGreen,PNYellow,PNDarkBlue, PNFreshGreen,PNLightBlue, PNPinkDark,PNLightYellow, PNMauve,PNCloudWhite, PNHealYellow, PNCleanGrey,PNLightGreen,PNDarkYellow,PNiOSGreenColor];


    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < [self.arrDatos count]; i++)
    {
        int value = [[[self.arrDatos objectAtIndex:i]objectAtIndex:5] intValue];
        PNPieChartDataItem *eColumnDataModel = [PNPieChartDataItem dataItemWithValue:value color:[colors objectAtIndex:i] description:[[self.arrDatos objectAtIndex:i]objectAtIndex:4]];
        
        [temp addObject:eColumnDataModel];
    }

    //(40.0, 155.0, 240.0, 240.0)
    
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(20.0, 100, 240.0, 240.0) items:temp];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
    [pieChart strokeChart];
    
    [self.scrollView addSubview:pieChart];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) obtenerDatos{
// 0, Id_tipo_grafica, 1, id_trimestre, 2, id_dependencia,  3, desc_corta_dependencia,4 desc_dependencia, 5, id_eje, 6, eje, 7, titulo,8, tipo_grafica
    
   // NSString *query = @"select  etiqueta, valor from grafica_xy";
   
    NSString *query = [[NSString alloc] init];
    
   query = [NSString stringWithFormat:@" %@ %@ %@ %@ " , @"select  a.etiqueta_x, a.etiqueta_y,  a.descripcion_valor,  a.descripcion_corta_valor , b.valor_x,b.valor_y from TAB_GRAFICAS_COLUMNAS_XY a, tab_valores_xy b where a.id_graficas_columnas_xy = b.id_graficas_columnas_xy  and a.id_tipo_grafica = ", [_pTemaSel  objectAtIndex:0], @" and a.id_trimestre = ", [_pTemaSel  objectAtIndex:1]];
    
    if (self.arrDatos != nil){self.arrDatos = nil;}
    self.arrDatos = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    self.labelEje.text = [[[_pTemaSel  objectAtIndex:6] stringByAppendingString:@" - "] stringByAppendingString:[_pTemaSel  objectAtIndex:3]];
    self.labelTrimestre.text = [_pTemaSel  objectAtIndex:9];
    self.labelGraf.text = [_pTemaSel  objectAtIndex:7];
    
    self.etiquetaX.text = [[self.arrDatos objectAtIndex:0]objectAtIndex:0];
    self.etiquetaY.text = [[self.arrDatos objectAtIndex:0]objectAtIndex:1];
    
    
    NSString *texto = [[NSString alloc] init];
    NSString *descr = [[NSString alloc] init];
    NSString *sTem = [[NSString alloc]init];
    
    for (int i = 0; i < [self.arrDatos count]; i++) {
        texto = [NSString stringWithFormat: @"%@ %@ %@", texto, [[self.arrDatos objectAtIndex:i]objectAtIndex:4], @"\n"];
        
        sTem = [NSString stringWithFormat:@"%@ ",[[self.arrDatos objectAtIndex:i] objectAtIndex:5]];
        NSNumber *nTem = @([sTem floatValue]);
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setNegativeFormat:@"(0.00)"];
        NSString *sMonto = [numberFormatter stringFromNumber:nTem];
        
        descr = [NSString stringWithFormat: @"%@ %@ %@", descr, sMonto, @"\n"];
        
    }
    
    self.labelValX.text = texto;
    self.labelValY.text = descr;
    
    self.labelValX.lineBreakMode = NSLineBreakByWordWrapping;
    self.labelValX.numberOfLines = 0;
    
    self.labelValY.lineBreakMode = NSLineBreakByWordWrapping;
    self.labelValY.numberOfLines = 0;
    
}


@end
