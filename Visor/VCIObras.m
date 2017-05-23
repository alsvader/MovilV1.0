//
//  VCIObras.m
//  Visor
//
//  Created by chable on 1/17/17.
//  Copyright (c) 2017 ST. All rights reserved.
//

#import "VCIObras.h"
#import "BDManager.h"

@interface VCIObras ()

@property (nonatomic, strong) BDManager *dbManager;
@property (nonatomic, strong) NSArray *arrDatos;

@end

@implementation VCIObras

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lbDescValor.text=@"";
    self.lbMonto.text= @"";
    self.lbAvfisicoValor.text=@"";
    self.lbBeneficiarioValor.text= @"";
    
    self.lbCantidadValor.text=@"";
    self.lbFfinanValor.text=@"";
    self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
    [self obtenerDatos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void) obtenerDatos{
// d.eje 0,c.desc_corta dependencia 1, e. descripcion trimestre 2,  a.descripcion tema 3, b.descripcion  subtema 4, uc.monto 5,uc.avance 6,uc.beneficiario 7,uc.descripcion 8,uc.cantidad 9,uc.desc_beneficiario 10, uc.desc_monto 11,uc.desc_fuente_financiamiento 12
    
    NSString *query = [NSString stringWithFormat: @"%@ %@",@"Select d.eje,c.desc_corta dependencia, e. descripcion trimestre, a.descripcion tema, b.descripcion  subtema, uc.monto,uc.avance,uc.beneficiario,uc.descripcion,uc.cantidad,uc.desc_beneficiario, uc.desc_monto,uc.desc_fuente_financiamiento from tab_unidades_contenido uc, cat_tema a, cat_subtema b, cat_dependencias c,cat_eje d, cat_trimestre  e where uc.id_tema =a.id_tema and                       uc.id_subtema=b.id_subtema and uc.id_dependencia =c.id_dependencia and                       c.id_eje=d.id_eje and uc.id_trimestre=e.id_trimestre and uc.Id_unidades_contenido = ", [ _pSubTemaSel objectAtIndex:3 ] ];
  
    NSString *sTem = [[NSString alloc]init];
    if (self.arrDatos != nil){self.arrDatos = nil;}
    self.arrDatos = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    if (self.arrDatos.count>0)
    {
        
        self.lbEje.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:0];
        self.lbDependencia.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:1];
        self.lbTrimestre.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:2];
        self.lbTema.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:3];
        self.lbSubtema.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:4];

        
        self.lbDescValor.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:8];
        sTem = [NSString stringWithFormat:@"%@ ",[[self.arrDatos objectAtIndex:0] objectAtIndex:5]];
        NSNumber *nTem = @([sTem floatValue]);
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setNegativeFormat:@"(0.00)"];
        NSString *sMonto = [numberFormatter stringFromNumber:nTem];
        self.lbMonto.text= [NSString stringWithFormat:@"%@ %@", sMonto, [[self.arrDatos objectAtIndex:0] objectAtIndex:11]];
        self.lbAvfisicoValor.text=[NSString stringWithFormat:@"%@ %@", [[self.arrDatos objectAtIndex:0] objectAtIndex:6], @"%" ];
        self.lbBeneficiarioValor.text= [NSString stringWithFormat:@"%@ %@",[[self.arrDatos objectAtIndex:0] objectAtIndex:7], [[self.arrDatos objectAtIndex:0] objectAtIndex:10]]; ;
        self.lbCantidadValor.text=[[self.arrDatos objectAtIndex:0] objectAtIndex:9];
        self.lbFfinanValor.text=[[self.arrDatos objectAtIndex:0] objectAtIndex:12];
    
    }
}




@end
