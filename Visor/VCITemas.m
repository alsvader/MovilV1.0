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
    @property (nonatomic, strong) NSArray *arrDependenciasFiltrado;

@end

@implementation VCITemas
int orden;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
    orden =1;
    [ self cargarTemas: (orden)];
    _bAlfabetico.tintColor = [UIColor blueColor];
    _bDependencia.tintColor = [UIColor grayColor];
    _bEje.tintColor = [UIColor grayColor];
    
}

- (IBAction)bAlfabetico:(id)sender {
    if (orden!=1) {
        orden =1;
        [ self cargarTemas: (orden)];
        [self.tableView reloadData];
        
        _bAlfabetico.tintColor = [UIColor blueColor];
        _bDependencia.tintColor = [UIColor grayColor];
        _bEje.tintColor = [UIColor grayColor];
    }
}

- (IBAction)bDependencia:(id)sender {
    if (orden!=2) {
        orden=2;
        [self cargarTemas: (orden)];
        [self.tableView reloadData];
        _bAlfabetico.tintColor = [UIColor grayColor];
        _bDependencia.tintColor = [UIColor blueColor];
        _bEje.tintColor = [UIColor grayColor];
    }
}

- (IBAction)bEje:(id)sender {
    if (orden!=3) {
        orden=3;
        [ self cargarTemas: (orden)];
        [self.tableView reloadData];
        _bAlfabetico.tintColor = [UIColor grayColor];
        _bDependencia.tintColor = [UIColor grayColor];
        _bEje.tintColor = [UIColor blueColor];
    }
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

-(void) cargarTemas:(int)orden {
    NSString *query = [[NSString alloc] init];
    NSString *sOrden = [[NSString alloc] init];
    
    switch (orden)
    {
        case 1: {
            
            sOrden = @" order by  a.descripcion";
            break;
        }
        case 2: {
            
            sOrden = @" order by  b.desc_corta";
            break;
        }
        case 3: {
            
            sOrden = @" order by  b.id_eje";
            break;
        }
            
    };
    
    if ([[_pTrimestreSel objectAtIndex:2] isEqual:@"2020"]) {
        //Obtener Temas de la dependencia Asuntos juridicos.
        query = [NSString stringWithFormat: @"%@ %@ %@ %@ %@ %@ %@", @"Select distinct a.descripcion,b.desc_corta,a.id_tema,a.id_unidad,", [_pTrimestreSel objectAtIndex:0] , @",'", [_pTrimestreSel objectAtIndex:1],@"', b.id_eje,c.eje from tab_unidades_contenido uc, cat_tema a, cat_dependencias b, cat_eje c where uc.id_tema=a.id_tema and a.id_dependencia= b.id_dependencia and b.id_eje=c.id_eje and uc.id_dependencia=", [_pTrimestreSel objectAtIndex:0] , sOrden ];
    }
    else {
        // Obtener temas dependencias diferentes a Asuntos juridicos
        query = [NSString stringWithFormat: @"%@ %@ %@ %@ %@ %@ %@", @"Select distinct a.descripcion,b.desc_corta,a.id_tema,a.id_unidad,", [_pTrimestreSel objectAtIndex:0] , @",'", [_pTrimestreSel objectAtIndex:1],@"', b.id_eje,c.eje from tab_unidades_contenido uc, cat_tema a, cat_dependencias b, cat_eje c where uc.id_tema=a.id_tema and a.id_dependencia= b.id_dependencia and b.id_eje=c.id_eje and uc.id_dependencia <>2 and id_trimestre=", [_pTrimestreSel objectAtIndex:0] ,  sOrden ];
    };
    
    if (self.arrDependencias != nil){self.arrDependencias = nil;}
    self.arrDependencias = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tblTemas {
    
    tblTemas.separatorColor = [UIColor colorWithRed:0.223  green: 0.250 blue:0.286 alpha:1 ];
    tblTemas.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.arrDependenciasFiltrado.count;
    } else {
        return self.arrDependencias.count;
    }
    //return self.arrDependencias.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *desc_tema = [[NSString alloc]init  ];
    NSString *desc_depen_corta = [[NSString alloc]init  ];
    
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"Cell"] ;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont boldSystemFontOfSize:11];
    cell.detailTextLabel.font=[UIFont boldSystemFontOfSize:12];
    //  NSNumber *n =[self.arrDependenciasFiltrado objectAtIndex:indexPath.row];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        desc_tema =[[self.arrDependenciasFiltrado objectAtIndex:indexPath.row] objectAtIndex:0];
        desc_depen_corta =[[self.arrDependenciasFiltrado objectAtIndex:indexPath.row] objectAtIndex:1];
    } else {
        // cell.textLabel.text = self.nombres[indexPath.row];
        desc_tema =[[self.arrDependencias objectAtIndex:indexPath.row] objectAtIndex:0];
        desc_depen_corta =[[self.arrDependencias objectAtIndex:indexPath.row] objectAtIndex:1];
        
    }
    
    
    cell.textLabel.text =  [NSString stringWithFormat:@"%@", desc_tema];
    cell.detailTextLabel.text =[NSString stringWithFormat:@"%@", desc_depen_corta];
    
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.576 green: 0.592 blue:0.611 alpha:1 ];
    [cell setBackgroundColor:[UIColor colorWithRed:0.952 green: 0.952 blue:0.952 alpha:1 ]];
    
    
    
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

- (void)searchFilter:(NSString*)searchText
{
    //   NSPredicate *predicateSearch = [NSPredicate predicateWithFormat:@"SELF[1] contains[cd] %@",searchText];
    NSPredicate *predicateSearch = [NSPredicate predicateWithFormat:@"(SELF[0] contains[cd] %@) OR (SELF[1] contains[cd] %@) ",searchText,searchText];
    self.arrDependenciasFiltrado = [NSMutableArray arrayWithArray:[self.arrDependencias filteredArrayUsingPredicate:predicateSearch]];
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self searchFilter:searchString];
    return YES;
}

@end
