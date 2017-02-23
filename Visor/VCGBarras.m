//
//  VCGBarras.m
//  Visor
//
//  Created by aaron on 2/23/17.
//  Copyright © 2017 ST. All rights reserved.
//

#import "VCGBarras.h"
#import "BDManager.h"
#import "PNChart.h"

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) obtenerDatos{
    // 0, Id_tipo_grafica, 1, id_trimestre, 2, id_dependencia,  3, desc_corta_dependencia,4 desc_dependencia, 5, id_eje, 6, eje, 7, titulo,8, tipo_grafica
    NSString *query = [[NSString alloc] init];
    
    query = [NSString stringWithFormat:@" %@ %@ %@ %@ " , @"select  a.etiqueta_x, a.etiqueta_y,  a.descripcion_valor,  a.descripcion_corta_valor , b.valor_x,b.valor_y from TAB_GRAFICAS_COLUMNAS_XY a, tab_valores_xy b where a.id_graficas_columnas_xy = b.id_graficas_columnas_xy  and a.id_tipo_grafica = ", [_pTemaSel  objectAtIndex:0], @" and a.id_trimestre = ", [_pTemaSel  objectAtIndex:1]];
    
    if (self.arrDatos != nil){self.arrDatos = nil;}
    self.arrDatos = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
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
