//
//  VCGBarras.m
//  Visor
//
//  Created by aaron on 2/23/17.
//  Copyright © 2017 ST. All rights reserved.
//

#import "VCGBarras.h"
#import "BDManager.h"
#import "BarChart.h"
#import "Constants.h"
#import "MultiLineGraphView.h"
//#import "PNChart.h"

#define header_height 65

@interface VCGBarras ()

@property (nonatomic, strong) BDManager *dbManager;
@property (nonatomic, strong) NSArray *arrDatos;
@end

@implementation VCGBarras

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
    [self obtenerDatos];
    [self drawChart];
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) obtenerDatos{
    // 0, Id_tipo_grafica, 1, id_trimestre, 2, id_dependencia,  3, desc_corta_dependencia,4 desc_dependencia, 5, id_eje, 6, eje, 7, titulo,8, tipo_grafica, 9, descripcion-trimestre
    NSString *query = [[NSString alloc] init];
    
    query = [NSString stringWithFormat:@" %@ %@ %@ %@ " , @"select  a.etiqueta_x, a.etiqueta_y,  a.descripcion_valor,  a.descripcion_corta_valor , b.valor_x,b.valor_y from TAB_GRAFICAS_COLUMNAS_XY a, tab_valores_xy b where a.id_graficas_columnas_xy = b.id_graficas_columnas_xy  and a.id_tipo_grafica = ", [_pTemaSel  objectAtIndex:0], @" and a.id_trimestre = ", [_pTemaSel  objectAtIndex:1]];
    
    if (self.arrDatos != nil){self.arrDatos = nil;}
    self.arrDatos = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    
    self.labelEje.text = [[[_pTemaSel  objectAtIndex:6] stringByAppendingString:@" - "] stringByAppendingString:[_pTemaSel  objectAtIndex:3]];
    self.labelDep.text = [_pTemaSel  objectAtIndex:7];
    self.labelTrimestre.text = [_pTemaSel  objectAtIndex:9];
    
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
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
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


-(void) drawChart {
    
    BarChart *barChartView = [[BarChart alloc] initWithFrame:CGRectMake(0, 10, WIDTH(self.view) - 10, HEIGHT(self.VWgrafica) - 10)];
    [barChartView setDataSource:self];
    [barChartView setDelegate:self];
    
    [barChartView setShowLegend:TRUE];
    [barChartView setLegendViewType:LegendTypeHorizontal];
    
    [barChartView setDrawGridY:TRUE];
    [barChartView setDrawGridX:TRUE];
    
    [barChartView setGridLineColor:[UIColor lightGrayColor]];
    [barChartView setGridLineWidth:0.3];
    
    [barChartView setTextFontSize:9];
    [barChartView setTextColor:[UIColor blackColor]];
    [barChartView setTextFont:[UIFont systemFontOfSize:barChartView.textFontSize]];
    
    [barChartView setShowCustomMarkerView:TRUE];
    [barChartView drawBarGraph];
    
    [self.VWgrafica addSubview:barChartView];
    
}


#pragma mark BarChartDataSource
- (NSMutableArray *)xDataForBarChart{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.arrDatos count]; i++) {
        [array addObject: [[self.arrDatos objectAtIndex:i]objectAtIndex:4] ];
    }
    return  array;
}

- (NSInteger)numberOfBarsToBePlotted{
    return 1;
}

- (UIColor *)colorForTheBarWithBarNumber:(NSInteger)barNumber{
    NSInteger aRedValue = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue = arc4random()%255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
    return randColor;
}

- (CGFloat)widthForTheBarWithBarNumber:(NSInteger)barNumber{
    return 35;
}

- (NSString *)nameForTheBarWithBarNumber:(NSInteger)barNumber{
    return [NSString stringWithFormat:@"%d",(int)barNumber];
}

- (NSMutableArray *)yDataForBarWithBarNumber:(NSInteger)barNumber{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.arrDatos count]; i++) {
        //[array addObject:[NSNumber numberWithLong:random() % 100]];
        [array addObject:[[self.arrDatos objectAtIndex:i]objectAtIndex:5]];
    }
    return array;
}

- (UIView *)customViewForBarChartTouchWithValue:(NSNumber *)value{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view.layer setCornerRadius:4.0F];
    [view.layer setBorderWidth:1.0F];
    [view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [view.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [view.layer setShadowRadius:2.0F];
    [view.layer setShadowOpacity:0.3F];
    
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:9]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:[NSString stringWithFormat:@"%.2f", value.floatValue]];
    [label setFrame:CGRectMake(-20, 0, 150, 30)];
    [view addSubview:label];
    
    [view setFrame:label.frame];
    return view;
}

#pragma mark BarChartDelegate
- (void)didTapOnBarChartWithValue:(NSString *)value{
    NSLog(@"Bar Chart: %@",value);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
