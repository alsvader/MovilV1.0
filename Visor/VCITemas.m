//
//  ViewController.m
//  Visor
//
//  Created by chable on 11/15/16.
//  Copyright (c) 2016 ST. All rights reserved.
//

#import "VCITemas.h"
#import "BDManager.h"
#import "VCISubtemas.h"

@interface VCITemas ()

    @property (nonatomic, strong) BDManager *dbManager;
    @property (nonatomic, strong) NSArray *arrDependencias;

@end

@implementation VCITemas

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
     [self cargarTemas];
    // Recibir parametros.
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
////        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
////        NSString *tema = self.arrDependencias[indexPath.row];
////        
////       
//        VCIObras *controller = (VCIObras *)[[segue destinationViewController] topViewController];
////        [controller setTema:tema];
////        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
////        controller.navigationItem.leftItemsSupplementBackButton = YES;
////        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) cargarTemas{
    NSString *query = [[NSString alloc] init];
    if ([[_pTrimestreSel objectAtIndex:2] isEqual:@"2020"]) {
        //Obtener Temas de la dependencia Asuntos juridicos.
          query = [NSString stringWithFormat: @"%@ %@ %@ %@ %@ %@ %@", @"Select distinct a.descripcion,b.desc_corta,a.id_tema,a.id_unidad,", [_pTrimestreSel objectAtIndex:0] , @",'", [_pTrimestreSel objectAtIndex:1],@"', b.id_eje,c.eje from tab_unidades_contenido uc, cat_tema a, cat_dependencias b, cat_eje c where uc.id_tema=a.id_tema and a.id_dependencia= b.id_dependencia and b.id_eje=c.id_eje and uc.id_dependencia=", [_pTrimestreSel objectAtIndex:0] , @" order by  a.descripcion" ];
    }
    else {
       // Obtener temas dependencias diferentes a Asuntos juridicos
        query = [NSString stringWithFormat: @"%@ %@ %@ %@ %@ %@ %@", @"Select distinct a.descripcion,b.desc_corta,a.id_tema,a.id_unidad,", [_pTrimestreSel objectAtIndex:0] , @",'", [_pTrimestreSel objectAtIndex:1],@"', b.id_eje,c.eje from tab_unidades_contenido uc, cat_tema a, cat_dependencias b, cat_eje c where uc.id_tema=a.id_tema and a.id_dependencia= b.id_dependencia and b.id_eje=c.id_eje and uc.id_dependencia <>2 and id_trimestre=", [_pTrimestreSel objectAtIndex:0] ,  @" order by  a.descripcion" ];
      };
    
    if (self.arrDependencias != nil){self.arrDependencias = nil;}
    self.arrDependencias = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
  }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tblTemas {
    
    tblTemas.separatorColor = [UIColor colorWithRed:0.243 green: .635 blue:0.690 alpha:0.5 ];
    tblTemas.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tblTemas numberOfRowsInSection:(NSInteger)section {
    return self.arrDependencias.count;
}

- (UITableViewCell *)tableView:(UITableView *)tblTemas cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell =  [tblTemas dequeueReusableCellWithIdentifier:@"Cell"] ;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.098  green: 0.133 blue:0.149 alpha:1 ];
    [cell setBackgroundColor:[UIColor colorWithRed:0.956 green: 0.956 blue:0.956 alpha:1 ]];

 
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont boldSystemFontOfSize:13];
    cell.detailTextLabel.font=[UIFont boldSystemFontOfSize:11];
    
    NSString *desc_tema =[[self.arrDependencias objectAtIndex:indexPath.row] objectAtIndex:0];
    NSString *desc_depen_corta =[[self.arrDependencias objectAtIndex:indexPath.row] objectAtIndex:1];
   
    cell.textLabel.text =  [NSString stringWithFormat:@"%@", desc_tema];
    cell.detailTextLabel.text =[NSString stringWithFormat:@"%@", desc_depen_corta];
    
         cell.detailTextLabel.textColor = [UIColor colorWithRed:0.098  green: 0.133 blue:0.149 alpha:0.5];
   
    //Imagen asociada al eje
    NSString *imgEje =[[self.arrDependencias objectAtIndex:indexPath.row] objectAtIndex:6];
    imgEje=[NSString stringWithFormat:@"e%@%@", imgEje, @".png"];
    cell.imageView.image =[UIImage imageNamed:imgEje];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VCISubtemas *pViewController =[storyBoard instantiateViewControllerWithIdentifier:@"VCISubtemas"];
    [self.navigationController pushViewController:pViewController animated:YES];
    
    NSString *temaSel = self.arrDependencias[indexPath.row];
    [pViewController setPTemaSel:temaSel];
}

@end
