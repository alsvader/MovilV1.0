//
//  VCISubtemas.m
//  Visor
//
//  Created by chable on 11/30/16.
//  Copyright (c) 2016 ST. All rights reserved.
//

#import "VCISubtemas.h"
#import "BDManager.h"
#import "VCIObras.h"
#import "VCIProyectos.h"
#import "VCIAgrupamientos.h"
#import "VCIReuniones.h"
#import "VCIIngresos.h"
#import "VCIProgramasyAcciones.h"
#import "VCIProcesoLeg.h"

@interface VCISubtemas ()

   @property (nonatomic, strong) BDManager *dbManager;
   @property (nonatomic, strong) NSArray *arrSubtemas;


@end

NSString *idUnidadContSel;

@implementation VCISubtemas

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//a.descripcion 0,b.desc_corta 1,a.id_tema 2 ,a.id_unidad 3,", [_pTrimestreSel objectAtIndex:0] 4 ,@", b.id_eje 5,c.eje 6
    
    //Recibir parametros
   self.lbTrimestre.text =[_pTemaSel objectAtIndex:5];
   self.lbTema.text = [_pTemaSel objectAtIndex:0];
    self.lbEje.text = [_pTemaSel objectAtIndex:7];
   self.lbDependencia.text = [_pTemaSel objectAtIndex:1]  ;
    
    //
    
    self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
    [self loadSubtemas];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) loadSubtemas{
    // Extraer bustemas del tema y trismetre seleccionado
    
    NSString *query =[[NSString alloc]init];
    if ([[_pTemaSel  objectAtIndex:1]  isEqual:@"CGAJ"])
    {
       query = [NSString stringWithFormat:@"%@ %@ %@ %@ ", @"Select a.id_tema, a.id_subtema, a.descripcion, b.id_unidades_contenido, '", [_pTemaSel objectAtIndex:5] ,  @"' from cat_subtema a,  tab_unidades_contenido b where a.id_subtema=b.id_subtema and a.id_tema = ", [_pTemaSel  objectAtIndex:2] ,   @"order by   a.descripcion" ];
    }
    else
    {  query = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", @"Select a.id_tema, a.id_subtema, a.descripcion, b.id_unidades_contenido, '", [_pTemaSel objectAtIndex:5] ,  @"' from cat_subtema a,  tab_unidades_contenido b where a.id_subtema=b.id_subtema and a.id_tema = ", [_pTemaSel  objectAtIndex:2] ,  @" and id_trimestre = ", [_pTemaSel  objectAtIndex:4], @"order by   a.descripcion" ];  }
    
//    pIdTema
    if (self.arrSubtemas != nil){self.arrSubtemas = nil;}
    self.arrSubtemas = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tblSubtemas {
    
    tblSubtemas.separatorColor = [UIColor colorWithRed:0.244 green: .244 blue:0.244 alpha:0.7 ];
    tblSubtemas.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tblSubtemas numberOfRowsInSection:(NSInteger)section {
    self.lbNumSubtemas.text = [NSString stringWithFormat:@"%d %@", self.arrSubtemas.count,@" Registros encontrados"];
    return self.arrSubtemas.count;
    
}

//- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return  500;
//};

- (UITableViewCell *)tableView:(UITableView *)tblSubtemas cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell =  [tblSubtemas dequeueReusableCellWithIdentifier:@"Cell"] ;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont boldSystemFontOfSize:11];
    cell.detailTextLabel.font=[UIFont boldSystemFontOfSize:12];
    NSString *desc_subtema =[[self.arrSubtemas objectAtIndex:indexPath.row] objectAtIndex:2];
    
    cell.textLabel.text =  [NSString stringWithFormat:@"%@", desc_subtema];
    
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.223 green: 0.211 blue:0.286 alpha:1 ];
    [cell setBackgroundColor:[UIColor colorWithRed:0.909 green: 0.909 blue:0.905 alpha:1 ]];
    
    return cell;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    idUnidadContSel = [[self.arrSubtemas objectAtIndex:indexPath.row] objectAtIndex:3];
//   // [self loadDatos];
////    self.lbDescValor.text=[[self.arrDatos objectAtIndex:0]objectAtIndex:8];
////    self.lbMonto.text= [NSString stringWithFormat:@"%@ %@",[[self.arrDatos objectAtIndex:0] objectAtIndex:5], [[self.arrDatos objectAtIndex:0] objectAtIndex:11]];
////    self.lbAvfisicoValor.text=[NSString stringWithFormat:@"%@ %@", [[self.arrDatos objectAtIndex:0] objectAtIndex:6], @"%" ];
////    self.lbBeneficiarioValor.text= [NSString stringWithFormat:@"%@ %@",[[self.arrDatos objectAtIndex:0] objectAtIndex:7], [[self.arrDatos objectAtIndex:0] objectAtIndex:10]]; ;
////    self.lbCantidadValor.text=[[self.arrDatos objectAtIndex:0] objectAtIndex:9];
////    self.lbFfinanValor.text=[[self.arrDatos objectAtIndex:0] objectAtIndex:12];
//    
//}



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int id_unidad =[[_pTemaSel  objectAtIndex:3] intValue];
    //int id_unidad = [sid_unidad intValue];
    switch (id_unidad)
    {
        case 1: {
         UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
         VCIObras *pViewController =[storyBoard instantiateViewControllerWithIdentifier:@"VCIObras"];
         [self.navigationController pushViewController:pViewController animated:YES];
         
         NSString *subTemaSel = self.arrSubtemas[indexPath.row];
        [pViewController setPSubTemaSel:subTemaSel];
        
            break;
       }
       case 2: {
           UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
           VCIProyectos *pViewController =[storyBoard instantiateViewControllerWithIdentifier:@"VCIProyectos"];
           [self.navigationController pushViewController:pViewController animated:YES];
           
           NSString *subTemaSel = self.arrSubtemas[indexPath.row];
          [pViewController setPSubTemaSel:subTemaSel];
           
           break;
        }
        case 3: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            VCIAgrupamientos *pViewController =[storyBoard instantiateViewControllerWithIdentifier:@"VCIAgrupamientos"];
            [self.navigationController pushViewController:pViewController animated:YES];
            
            NSString *subTemaSel = self.arrSubtemas[indexPath.row];
            [pViewController setPSubTemaSel:subTemaSel];
        
            break;
        }
        case 4: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            VCIReuniones *pViewController =[storyBoard instantiateViewControllerWithIdentifier:@"VCIReuniones"];
            [self.navigationController pushViewController:pViewController animated:YES];
            
            NSString *subTemaSel = self.arrSubtemas[indexPath.row];
            [pViewController setPSubTemaSel:subTemaSel];
            break;
        }
        
        case 5: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            VCIIngresos *pViewController =[storyBoard instantiateViewControllerWithIdentifier:@"VCIIngresos"];
            [self.navigationController pushViewController:pViewController animated:YES];
            
            NSString *subTemaSel = self.arrSubtemas[indexPath.row];
            [pViewController setPSubTemaSel:subTemaSel];
        
           break;
        }
        case 6: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            VCIProcesoLeg *pViewController =[storyBoard instantiateViewControllerWithIdentifier:@"VCIProcesoLeg"];
            [self.navigationController pushViewController:pViewController animated:YES];
            
            NSString *subTemaSel = self.arrSubtemas[indexPath.row];
            [pViewController setPSubTemaSel:subTemaSel];
            
            break;
        }
            
        case 7: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            VCIProgramasyAcciones *pViewController =[storyBoard instantiateViewControllerWithIdentifier:@"VCIProgramasyAcciones"];
            [self.navigationController pushViewController:pViewController animated:YES];
            
            NSString *subTemaSel = self.arrSubtemas[indexPath.row];
            [pViewController setPSubTemaSel:subTemaSel];
            
            break;
        }
            
     default:
        {
            NSLog(@"Tema seleccionado no está relaciondo a una Unidad de contenido");
             break;
        }
    }
    
    
    // NSString *temaSel = self.arrDependencias[indexPath.row];
    // [pViewController setPTemaSel:temaSel];
}

@end
