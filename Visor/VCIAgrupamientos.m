//
//  VCIAgrupamientos.m
//  Visor
//
//  Created by chable on 1/24/17.
//  Copyright (c) 2017 ST. All rights reserved.
//

#import "VCIAgrupamientos.h"
#import "BDManager.h"


@interface VCIAgrupamientos ()

@property (nonatomic, strong) BDManager *dbManager;
@property (nonatomic, strong) NSArray *arrDatos;

@end

@implementation VCIAgrupamientos

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lbDescripcion.text=@"";
    self.lbMonto.text= @"";
    self.lbCantidad.text=@"";
    
    [self.lbDescripcion setHidden:true];
    [self.lbMonto setHidden:true];
    [self.lbCantidad setHidden:true];
    
    [self.etDescripcion setHidden:true];
    [self.etMonto setHidden:true];
    [self.etCantidad setHidden:true];
    
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
    
    NSString *sNum;
    double nTmp ;
    NSNumber *nNumf;
    NSString *query = [NSString stringWithFormat: @"%@ %@",@"Select d.eje,c.desc_corta dependencia, e. descripcion trimestre, a.descripcion tema, b.descripcion  subtema, uc.monto,uc.descripcion, uc.desc_monto, uc.cantidad from tab_unidades_contenido uc, cat_tema a, cat_subtema b, cat_dependencias c,cat_eje d, cat_trimestre  e where uc.id_tema =a.id_tema and                       uc.id_subtema=b.id_subtema and uc.id_dependencia =c.id_dependencia and                       c.id_eje=d.id_eje and uc.id_trimestre=e.id_trimestre and uc.Id_unidades_contenido = ", [ _pSubTemaSel objectAtIndex:3 ] ];
    
    if (self.arrDatos != nil){self.arrDatos = nil;}
    self.arrDatos = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    if (self.arrDatos.count>0)
    {
        
        self.lbEje.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:0];
        self.lbDependencia.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:1];
        self.lbTrimestre.text=[ _pSubTemaSel objectAtIndex:4 ];
        //self.lbTrimestre.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:2];
        self.lbTema.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:3];
        self.lbSubtema.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:4];
        
        
        if ([[[self.arrDatos objectAtIndex:0]objectAtIndex:6] length]>0)
        {
            self.lbDescripcion.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:6];
            [self.lbDescripcion setHidden:false];[self.etDescripcion setHidden:false];
        }

        sNum = [NSString stringWithFormat:@"%@ ",[[self.arrDatos objectAtIndex:0] objectAtIndex:5]];
        nNumf = @([sNum floatValue]);
        nTmp = [sNum floatValue];
        if (nTmp>0)
        {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];            ;
            [numberFormatter setNegativeFormat:@"(0.00)"];
            NSString *sMonto = [numberFormatter stringFromNumber:nNumf];
            self.lbMonto.text= [NSString stringWithFormat:@"%@ %@", sMonto, [[self.arrDatos objectAtIndex:0] objectAtIndex:7]];
            [self.lbMonto setHidden:false];[self.etMonto setHidden:false];
        }

        sNum = [NSString stringWithFormat:@"%@ ",[[self.arrDatos objectAtIndex:0]objectAtIndex:8]];
        nNumf = @([sNum floatValue]);
        nTmp = [sNum floatValue];
        if (nTmp>0)
        {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];            ;
            [numberFormatter setNegativeFormat:@"(0.00)"];
            NSString *sCantidad = [numberFormatter stringFromNumber:nNumf];
            self.lbCantidad.text= sCantidad;
            [self.lbCantidad setHidden:false];[self.etCantidad setHidden:false];
        }

    }
}

@end
