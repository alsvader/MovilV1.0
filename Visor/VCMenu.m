//
//  VCMenu.m
//  Visor
//
//  Created by chable on 11/29/16.
//  Copyright (c) 2016 ST. All rights reserved.
//

#import "VCMenu.h"
#import "VCITrimestre.h"
#import "BDManager.h"
#import "VCGDIF.h"
#import "ObjetoTabUniContenido.h"


@interface VCMenu ()
   @property (nonatomic, strong) NSArray *arrDependencias;
   @property (nonatomic, strong) BDManager *dbManager;

@end

int contador;
@implementation VCMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)btnITrimestre:(id)sender{
   UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   VCITrimestre *pVCITrimestre =[storyBoard instantiateViewControllerWithIdentifier:@"VCIMenuTrimestre"];
   [self.navigationController pushViewController:pVCITrimestre animated:YES];

}

- (IBAction)btnGraficas:(id)sender{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VCGDIF *pVCITrimestre =[storyBoard instantiateViewControllerWithIdentifier:@"VCGDIF"];
    [self.navigationController pushViewController:pVCITrimestre animated:YES];
    
}

- (IBAction)btnActualizarBD:(id)sender{
    [ self sincronizarDatos];
}


-(void) sincronizarDatos{
   
    contador=1;
    NSString *ultima_actualizacion = @"01/01/2015";
    NSURL *url = [NSURL URLWithString:@"http://10.19.13.150:96/Service1.svc/unidades"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)     {
                               if (data.length > 0 && connectionError == nil)
                               {
                                  
                                   NSError *error;
                                   arrayTabUnidadCotenido = [[NSMutableArray alloc] init];
                                   NSArray *arrayFromServer = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                   if(error){
                                       NSLog(@"error al obtener datos Json - %@", [error localizedDescription]);
                                   }
                                   else {
                                       
                                       arrayTabUnidadCotenido = [[NSMutableArray alloc] init];
                                       self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
                                       contador=0;
                                       for(NSDictionary *acActual in arrayFromServer)
                                       {
                                           ObjetoTabUniContenido *objTabUniContenido = [[ObjetoTabUniContenido alloc] initWithJSONData:acActual];
                                           [arrayTabUnidadCotenido addObject:objTabUniContenido];
                                           NSString *query =[NSString stringWithFormat:@"insert into tab_unidades_contenido (Id_unidades_contenido,Id_dependencia,Id_tema,Id_subtema,Id_trimestre,Monto,Beneficio,Avance,Beneficiario,Iniciativa,Aprobada,Publicada,En_vigor,Observaciones,Motivo,Fecha_inicio,Fecha_termino,Lugar,Descripcion,Cantidad,Desc_beneficiario,Desc_monto,Desc_proc_legislativo,Desc_beneficio,Desc_estatus,Desc_fuente_financiamiento,Desc_avance,Desc_Tipo_Ingreso)  values ( '%@', '%@','%@','%@','%@', '%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",objTabUniContenido.Id_unidades_contenido,objTabUniContenido.Id_dependencia,objTabUniContenido.Id_tema,objTabUniContenido.Id_subtema,objTabUniContenido.Id_trimestre,objTabUniContenido.Monto,objTabUniContenido.Beneficio,objTabUniContenido.Avance,objTabUniContenido.Beneficiario,objTabUniContenido.Iniciativa,objTabUniContenido.Aprobada,objTabUniContenido.Publicada,objTabUniContenido.En_vigor,objTabUniContenido.Observaciones,objTabUniContenido.Motivo,objTabUniContenido.Fecha_inicio,objTabUniContenido.Fecha_termino,objTabUniContenido.Lugar,objTabUniContenido.Descripcion,objTabUniContenido.Cantidad,objTabUniContenido.Desc_beneficiario,objTabUniContenido.Desc_monto,objTabUniContenido.Desc_proc_legislativo,objTabUniContenido.Desc_beneficio,objTabUniContenido.Estatus,objTabUniContenido.Desc_fuente_financiamiento,objTabUniContenido.Desc_avance,objTabUniContenido.Desc_Tipo_Ingreso];
                                           [self.dbManager executeQuery:query];
                                           // NSLog(@"Insercion realizada correctamente %d " , contador);
                                           contador++;
                                           if (self.dbManager.affectedRows !=0)
                                            
                                           {
                                               NSLog(@"Insercion realizada correctamente");
                                           }
                                           else
                                           {
                                              // NSLog(@"Insercion incorrecta");
                                           }
                                           
                                       }
                                     //  if ([arrayTabUnidadCotenido count]>0 ) {
                                           // [ UITableView  tableView reloadData ];
                                           
                                      // }
                                   }
                               }
                               else { NSLog(@"Lista de acuerdos actualizados");      }
                           }];
}

@end
