//
//  VCGTemas.m
//  Visor
//
//  Created by aaron on 2/21/17.
//  Copyright © 2017 ST. All rights reserved.
//

#import "VCGTemas.h"
#import "BDManager.h"
#import "VCGPastel.h"
#import "VCGBarras.h"

@interface VCGTemas ()
    @property (nonatomic, strong) NSArray *arrDatos;
    @property (nonatomic, strong) BDManager *dbManager;

@end

@implementation VCGTemas

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
    [self cargarTemas];
}

-(void) cargarTemas{
    NSString *query = [[NSString alloc] init];

    query = [NSString stringWithFormat: @"%@  %@ ", @"select a.Id_tipo_grafica, d.id_trimestre, a.id_dependencia,  b.desc_corta,b.desc_dependencia, c.id_eje, c.eje, a.titulo,a.tipo from cat_tipo_grafica a, cat_dependencias b, cat_eje c, TAB_GRAFICAS_COLUMNAS_XY d where a.id_tipo_grafica = d.id_tipo_grafica and a.id_dependencia  =b.id_dependencia and b.id_eje=c.id_eje ",  @" order by b.id_eje" ]
   // b.id_eje=c.id_eje and a.id_trimestre =", [_pTrimestreSel objectAtIndex:0] , @" order by b.id_eje" ]
    ;
    if (self.arrDatos != nil){self.arrDatos = nil;}
    self.arrDatos = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDatos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"Cell"] ;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont boldSystemFontOfSize:11];
    cell.detailTextLabel.font=[UIFont boldSystemFontOfSize:12];
    NSString *desc_tema =[[self.arrDatos objectAtIndex:indexPath.row] objectAtIndex:7];
    NSString *desc_depen_corta =[[self.arrDatos objectAtIndex:indexPath.row] objectAtIndex:3];
    
    cell.textLabel.text =  [NSString stringWithFormat:@"%@", desc_tema];
    cell.detailTextLabel.text =[NSString stringWithFormat:@"%@", desc_depen_corta];
    
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.244 green: .244 blue:0.244 alpha:0.6 ];
    [cell setBackgroundColor:[UIColor colorWithRed:0.244 green: .244 blue:0.244 alpha:0.1 ]];
    
    //Imagen asociada al eje
    NSString *imgEje =[[self.arrDatos objectAtIndex:indexPath.row] objectAtIndex:5];
    imgEje=[NSString stringWithFormat:@"e%@%@", imgEje, @".png"];
    cell.imageView.image =[UIImage imageNamed:imgEje];
    
    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int id_TipoGrafica =[[[self.arrDatos objectAtIndex:indexPath.row] objectAtIndex:8] intValue];
    //int id_unidad = [sid_unidad intValue];
    switch (id_TipoGrafica)
    {
        case 1: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            VCGBarras *pViewController =[storyBoard instantiateViewControllerWithIdentifier:@"VCGBarras"];
            [self.navigationController pushViewController:pViewController animated:YES];
            
            NSString *temaSel = self.arrDatos[indexPath.row];
            [pViewController setPTemaSel:temaSel];
            
            break;
        }

        case 2: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            VCGPastel *pViewController =[storyBoard instantiateViewControllerWithIdentifier:@"VCGPastel"];
            [self.navigationController pushViewController:pViewController animated:YES];
            
            NSString *temaSel = self.arrDatos[indexPath.row];
            [pViewController setPTemaSel:temaSel];
            
            break;
        }

            
        default:
        {
            NSLog(@"Tema seleccionado no está relaciondo a una Unidad de contenido");
            break;
        }
    }
   }


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
