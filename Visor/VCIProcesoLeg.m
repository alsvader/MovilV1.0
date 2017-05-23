//
//  VCIProcesoLeg.m
//  Visor
//
//  Created by chable on 2/4/17.
//  Copyright (c) 2017 ST. All rights reserved.
//

#import "VCIProcesoLeg.h"
#import "BDManager.h"

@interface VCIProcesoLeg ()
@property (nonatomic, strong) BDManager *dbManager;
@property (nonatomic, strong) NSArray *arrDatos;
@end

@implementation VCIProcesoLeg

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) obtenerDatos{
    
    NSString *query = [NSString stringWithFormat: @"%@ %@",@"Select d.eje,c.desc_corta dependencia, e. descripcion trimestre, a.descripcion tema, b.descripcion  subtema, desc_proc_legislativo, iniciativa, aprobada,publicada,en_vigor,observaciones  from tab_unidades_contenido uc, cat_tema a, cat_subtema b, cat_dependencias c,cat_eje d, cat_trimestre  e where uc.id_tema =a.id_tema and                       uc.id_subtema=b.id_subtema and uc.id_dependencia =c.id_dependencia and                       c.id_eje=d.id_eje and uc.id_trimestre=e.id_trimestre and uc.Id_unidades_contenido = ", [ _pSubTemaSel objectAtIndex:3 ] ];
    
    if (self.arrDatos != nil){self.arrDatos = nil;}
    self.arrDatos = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    if (self.arrDatos.count>0)
    {
        self.lbEje.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:0];
        self.lbDependencia.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:1];
        self.txtTema.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:3];
        self.txtSubtema.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:4];
        
         self.lbDescprogLeg.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:5];
         self.lbIniciativa.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:6];
         self.lbAprobada.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:7];
         self.txtPublicada.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:8];
         self.txtEnvigor.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:9];
         self.txtObservaciones.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:10];
    }
}

@end
