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
#import "VCGMenuTrimestre.h"

#import "ObjetoTabUniContenido.h"
#import "ObjetoSubtema.h"
#import "ObjetoTema.h"
#import "ObjetoDependencias.h"
#import "ObjetoTrimestre.h"

@interface VCMenu ()
   @property (nonatomic, strong) BDManager *dbManager;
   @property (nonatomic, strong) NSArray *arrDatos;
   @property (nonatomic, strong) NSArray *arrSubtemas;
   @property (nonatomic, strong) NSArray *arrDependencias;
   @property (nonatomic, strong) NSArray *arrTemas;
    @property (nonatomic, strong) NSArray *arrTrimestre;


@end

int contador;
@implementation VCMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    sUrl = @"http://10.19.13.150:96/Service1.svc/";

    
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
    VCGMenuTrimestre *pVCITrimestre =[storyBoard instantiateViewControllerWithIdentifier:@"VCGMenuTrimestre"];
    [self.navigationController pushViewController:pVCITrimestre animated:YES];
 
}

- (IBAction)btnActualizarBD:(id)sender{
    [ self sincronizarDatos];
}

- (void) actualizarDependencias {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",sUrl,@"dependencias"]];
    NSMutableArray *arrayDependencias = [[NSMutableArray alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)     {
                               if (data.length > 0 && connectionError == nil)
                               {
                                   
                                   NSError *error;
                                  
                                   NSArray *arrayFromServer = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                   if(error){
                                       NSLog(@"error al obtener datos Json - %@", [error localizedDescription]);
                                   }
                                   else {
                                       
                                       //    arraySubtemas = [[NSMutableArray alloc] init];
                                       self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
                                       contador=0;
                                       
                                     //  NSString *query = [NSString stringWithFormat: @" Delete from cat_dependencias "];
                                      // if (self.arrDependencias != nil){self.arrDependencias = nil;}
                                    //   self.arrDependencias = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
                                       //**********
                                       
                                       for(NSDictionary *acActual in arrayFromServer)
                                       {
                                           ObjetoDependencias *objDependencias = [[ObjetoDependencias alloc] initWithJSONData:acActual];
                                           [arrayDependencias addObject:objDependencias];
                                           NSString *query =[NSString stringWithFormat:@"insert into cat_dependencias (id_dependencia, desc_dependencia, desc_corta, id_eje)  values ( '%@','%@','%@','%@')",objDependencias.Id_dependencia,objDependencias.Desc_dependencia,objDependencias.Desc_corta,objDependencias.Id_eje];
                                           [self.dbManager executeQuery:query];
                                           contador++;
                                       }
                                       }
                               }
                               else {
                                   
                                   NSLog(@"En el origen, no hay registros para actualizar");  }
                           }];
}

- (void) actualizarTrimestres {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",sUrl,@"trimestres"]];
    NSMutableArray *arrayTrimestres = [[NSMutableArray alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)     {
                               if (data.length > 0 && connectionError == nil)
                               {
                                   
                                   NSError *error;
                                   
                                   NSArray *arrayFromServer = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                   if(error){
                                       NSLog(@"error al obtener datos Json - %@", [error localizedDescription]);
                                   }
                                   else {
                                       
                                       //    arraySubtemas = [[NSMutableArray alloc] init];
                                       self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
                                       contador=0;
                                       
                                      // NSString *query = [NSString stringWithFormat: @" Delete from cat_trimestre "];
                                      // if (self.arrTrimestre != nil){self.arrTrimestre = nil;}
                                    //   self.arrTrimestre = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
                                       //**********
                                       
                                       for(NSDictionary *acActual in arrayFromServer)
                                       {
                                           ObjetoTrimestre *objTrimestre = [[ObjetoTrimestre alloc] initWithJSONData:acActual];
                                           [arrayTrimestres addObject:objTrimestre];
                                           NSString *query =[NSString stringWithFormat:@"insert into cat_trimestre (id_trimestre, descripcion, anio, fecha_inicio,fecha_termino)  values ( '%@','%@','%@','%@','%@')",objTrimestre.Id_trimestre,objTrimestre.Descripcion,objTrimestre.anio,objTrimestre.fecha_inicio, objTrimestre.fecha_termino];
                                           [self.dbManager executeQuery:query];
                                           contador++;
                                       }
                                   }
                               }
                               else {
                                   
                                   NSLog(@"En el origen, no hay registros para actualizar");  }
                           }];
}

- (void) actualizarSubtemas {

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",sUrl,@"subtemas"]];
    NSMutableArray *arraySubtemas = [[NSMutableArray alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)     {
                               if (data.length > 0 && connectionError == nil)
                               {
                                   
                                   NSError *error;
                                   // arraySubtemas = [[NSMutableArray alloc] init];
                                   NSArray *arrayFromServer = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                   if(error){
                                       NSLog(@"error al obtener datos Json - %@", [error localizedDescription]);
                                   }
                                   else {
                                       
                                       //    arraySubtemas = [[NSMutableArray alloc] init];
                                       self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
                                       contador=0;
                                       
                                     //  NSString *query = [NSString stringWithFormat: @" Delete from cat_subtema "];
                                     //  if (self.arrSubtemas != nil){self.arrSubtemas = nil;}
                                    //   self.arrSubtemas = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
                                       //**********
                                       
                                       
                                       for(NSDictionary *acActual in arrayFromServer)
                                       {
                                           ObjetoSubtema *objSubtema = [[ObjetoSubtema alloc] initWithJSONData:acActual];
                                           [arraySubtemas addObject:objSubtema];
                                           NSString *query =[NSString stringWithFormat:@"insert into cat_subtema (Id_subtema, id_tema, Descripcion, Descripcion_corta)  values ( '%@','%@','%@','%@')",objSubtema.Id_subtema,objSubtema.Id_Tema,objSubtema.Descripcion,objSubtema.Descripcion_corta];
                                           [self.dbManager executeQuery:query];
                                           contador++;
                                       }
                                       //                                       if (arrayFromServer.count==contador ) {
                                       //                                           NSString *msg =[NSString stringWithFormat:@" %@%d%@", @"La información ha sido actualizada correctamente (", contador, @") "];
                                       //                                           UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Visor"
                                       //                                                                                            message:msg
                                       //                                                                                           delegate:self
                                       //                                                                                  cancelButtonTitle:@"Aceptar"
                                       //                                                                                  otherButtonTitles: nil];
                                       //                                           [alert show];
                                       //                                       }
                                       //                                       else
                                       //                                       {
                                       //                                           NSString *msg =[NSString stringWithFormat:@" %@%d%@", @"Ocurrieron inconsistencias durante la actualización, repórtelo con el área técnica (", contador, @") "];
                                       //                                           UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Visor: Error"
                                       //                                                                                            message:msg
                                       //                                                                                           delegate:self
                                       //                                                                                  cancelButtonTitle:@"Aceptar"
                                       //                                                                                  otherButtonTitles: nil];
                                       //                                           [alert show];
                                       //                                       }
                                   }
                               }
                               else {
                                   
                                   NSLog(@"En el origen, no hay registros para actualizar");      }
                           }];
    
    
}

- (void) actualizarTemas {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",sUrl,@"temas"]];
    NSMutableArray *arrayTemas = [[NSMutableArray alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)     {
                               if (data.length > 0 && connectionError == nil)
                               {
                                   
                                   NSError *error;
                                   NSArray *arrayFromServer = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                   if(error){
                                       NSLog(@"error al obtener datos Json - %@", [error localizedDescription]);
                                   }
                                   else {
                                       self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
                                       contador=0;
                                    //   NSString *query = [NSString stringWithFormat: @" Delete from cat_tema "];
                                    //   if (self.arrTemas != nil){self.arrTemas = nil;}
                                    //   self.arrTemas = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
                                       for(NSDictionary *acActual in arrayFromServer)
                                       {
                                           ObjetoTema *objTema = [[ObjetoTema alloc] initWithJSONData:acActual];
                                           [arrayTemas addObject:objTema];
                                           NSString *query =[NSString stringWithFormat:@"insert into cat_tema (id_tema,id_unidad,id_dependencia, Descripcion, Descripcion_corta)  values ( '%@','%@','%@','%@','%@')",objTema.Id_Tema, objTema.Id_Unidad, objTema.Id_Dependencia, objTema.Descripcion, objTema.Descripcion_corta];
                                           [self.dbManager executeQuery:query];
                                           contador++;
                                       }
                                   }
                               }
                               else {
                                   
                                   NSLog(@"En el origen, no hay registros para actualizar");      }
                           }];
}



-(void) sincronizarDatos{
    contador=1;
    //  NSString *ultima_actualizacion = @"01/01/2015";
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = CGPointMake(160, 240);
    activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    //NSURL *url = [NSURL URLWithString:@"http://10.19.13.150:96/Service1.svc/unidades"];
    // NSString *lUrl =[NSString stringWithFormat:@"%@%@",sUrl,@"unidades"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",sUrl,@"unidades"]];
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
                                       
                                       //Elimina los registros existentes **************
                                       NSString *query = [NSString stringWithFormat: @" Delete from tab_unidades_contenido "];
                                       if (self.arrDatos != nil){self.arrDatos = nil;}
                                       self.arrDatos = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
                                       
                                       query = [NSString stringWithFormat: @" Delete from cat_trimestre "];
                                       if (self.arrDatos != nil){self.arrDatos = nil;}
                                       self.arrDatos = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
                                       
                                       
                                       query = [NSString stringWithFormat: @" Delete from cat_subtema "];
                                       if (self.arrDatos != nil){self.arrDatos = nil;}
                                       self.arrDatos = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
                                       
                                       query = [NSString stringWithFormat: @" Delete from cat_tema "];
                                       if (self.arrDatos != nil){self.arrDatos = nil;}
                                       self.arrDatos = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
                                       
                                       query = [NSString stringWithFormat: @" Delete from cat_dependencias "];
                                       if (self.arrDatos != nil){self.arrDatos = nil;}
                                       self.arrDatos = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];

                                       
                                       //**********
                                       
                                       [self actualizarTrimestres];
                                       [self actualizarDependencias];
                                       [self actualizarSubtemas];
                                       [self actualizarTemas];
                                       for(NSDictionary *acActual in arrayFromServer)
                                       {
                                           ObjetoTabUniContenido *objTabUniContenido = [[ObjetoTabUniContenido alloc] initWithJSONData:acActual];
                                           [arrayTabUnidadCotenido addObject:objTabUniContenido];
                                           NSString *query =[NSString stringWithFormat:@"insert into tab_unidades_contenido (Id_unidades_contenido,Id_dependencia,Id_tema,Id_subtema,Id_trimestre,Monto,Beneficio,Avance,Beneficiario,Iniciativa,Aprobada,Publicada,En_vigor,Observaciones,Motivo,Fecha_inicio,Fecha_termino,Lugar,Descripcion,Cantidad,Desc_beneficiario,Desc_monto,Desc_proc_legislativo,Desc_beneficio,Desc_estatus,Desc_fuente_financiamiento,Desc_avance,Desc_Tipo_Ingreso)  values ( '%@', '%@','%@','%@','%@', '%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",objTabUniContenido.Id_unidades_contenido,objTabUniContenido.Id_dependencia,objTabUniContenido.Id_tema,objTabUniContenido.Id_subtema,objTabUniContenido.Id_trimestre,objTabUniContenido.Monto,objTabUniContenido.Beneficio,objTabUniContenido.Avance,objTabUniContenido.Beneficiario,objTabUniContenido.Iniciativa,objTabUniContenido.Aprobada,objTabUniContenido.Publicada,objTabUniContenido.En_vigor,objTabUniContenido.Observaciones,objTabUniContenido.Motivo,objTabUniContenido.Fecha_inicio,objTabUniContenido.Fecha_termino,objTabUniContenido.Lugar,objTabUniContenido.Descripcion,objTabUniContenido.Cantidad,objTabUniContenido.Desc_beneficiario,objTabUniContenido.Desc_monto,objTabUniContenido.Desc_proc_legislativo,objTabUniContenido.Desc_beneficio,objTabUniContenido.Estatus,objTabUniContenido.Desc_fuente_financiamiento,objTabUniContenido.Desc_avance,objTabUniContenido.Desc_Tipo_Ingreso];
                                           [self.dbManager executeQuery:query];
                                           contador++;
                                           
                                       }
                                       [activityIndicator stopAnimating];
                                       if (arrayFromServer.count==contador ) {
                                           NSString *msg =[NSString stringWithFormat:@" %@%d%@", @"La información ha sido actualizada correctamente (", contador, @") "];
                                           UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Visor"
                                                                                            message:msg
                                                                                           delegate:self
                                                                                  cancelButtonTitle:@"Aceptar"
                                                                                  otherButtonTitles: nil];
                                           [alert show];
                                           
                                       }
                                       else
                                       {
                                           NSString *msg =[NSString stringWithFormat:@" %@%d%@", @"Ocurrieron inconsistencias durante la actualización, repórtelo con el área técnica (", contador, @") "];
                                           UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Visor: Error"
                                                                                            message:msg
                                                                                           delegate:self
                                                                                  cancelButtonTitle:@"Aceptar"
                                                                                  otherButtonTitles: nil];
                                           [alert show];
                                       }
                                   }
                               }
                               else {
                                   [activityIndicator stopAnimating];
                                   NSLog(@"En el origen, no hay registros para actualizar");      }
                           }];
    
}


@end
