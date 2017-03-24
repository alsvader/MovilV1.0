//
//  VCIMenuTrimestre.m
//  Visor
//
//  Created by chable on 1/10/17.
//  Copyright (c) 2017 ST. All rights reserved.
//

#import "VCIMenuTrimestre.h"
#import "BDManager.h"
#import "VCITemas.h"

@interface VCIMenuTrimestre ()
 @property (nonatomic, strong) BDManager *dbManager;
 @property (nonatomic, strong) NSArray *arrTrimestre;
 @property (nonatomic,strong) NSMutableArray *arrTrimestreSecciones;

@end



@implementation VCIMenuTrimestre


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
    [self loadTrimestres];
    if (_arrTrimestre.count>0)
    {
     [self seccionarTrimestres];
        
    }
}

-(void) loadTrimestres{
    NSString *query = [NSString stringWithFormat:@"select id_trimestre,descripcion,anio from                        (Select id_trimestre, descripcion, anio, fecha_inicio from cat_trimestre union                         select  id_dependencia, desc_dependencia, 2020, date ('2020-01-01') fecha from cat_dependencias                         where id_dependencia =2) order by date (fecha_inicio), anio DESC " ];
   if (self.arrTrimestre != nil){self.arrTrimestre = nil;}
    self.arrTrimestre = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
}

-(void) seccionarTrimestres {
    NSString *tAnio=nil, *tAnioAnt=nil;
    NSMutableArray *arrTrimTemp = [[NSMutableArray alloc] init ] ;
    self.arrTrimestreSecciones = [[NSMutableArray alloc] init];
    for (id i in self.arrTrimestre  )
    {
        if (tAnioAnt == nil){
            tAnioAnt =[i objectAtIndex:2 ];
        }
        tAnio =[i objectAtIndex:2 ];
        if (![tAnioAnt isEqualToString:tAnio])
        {
           [self.arrTrimestreSecciones  addObject:arrTrimTemp];
            arrTrimTemp =Nil;
            arrTrimTemp = [[NSMutableArray alloc] init ] ;
            tAnioAnt=[i objectAtIndex:2];
            [arrTrimTemp addObject:i];
        }
        else
        {
           tAnioAnt=[i objectAtIndex:2];
           [arrTrimTemp addObject:i];
         }
    }
    if ([arrTrimTemp count] >0)
    {
         [self.arrTrimestreSecciones addObject:arrTrimTemp];
         arrTrimTemp =Nil;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    tableView.separatorColor = [UIColor colorWithRed:0.243 green: .635 blue:0.690 alpha:0.5 ];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    
#warning Potentially incomplete method implementation.
    // Return the number of sections.
   
    NSInteger secciones = [[self arrTrimestreSecciones] count];
    
    
    
    return secciones;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSArray *filasSeccion =[[self arrTrimestreSecciones]objectAtIndex:section];
    NSInteger filas = [filasSeccion count];
    
    return filas;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"Cell"] ;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont boldSystemFontOfSize:11];
    cell.detailTextLabel.font=[UIFont boldSystemFontOfSize:12];
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.333 green: 0.380 blue:0.419 alpha:1 ];
    [cell setBackgroundColor:[UIColor colorWithRed:0.243 green: 0.632 blue:0.690 alpha:0.1 ]];
    

    
    NSArray *contenido =  [[self arrTrimestreSecciones]objectAtIndex:[indexPath section]];
    NSString *contFila = [ [contenido objectAtIndex:[indexPath row]] objectAtIndex:1];
    cell.textLabel.text =  contFila;

    return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *contenido =  [[self arrTrimestreSecciones]objectAtIndex: section];
    NSString *titulo = [ [contenido objectAtIndex:0]objectAtIndex:2];
    
    
    if ([titulo  isEqual:@"2020"])
    {
       return  [NSString stringWithFormat:@"  ASUNTOS JURÍDICOS "];
    }
    else {
       return  [NSString stringWithFormat:@"  Ejercicio del %@", titulo];}
};

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VCITemas *pViewController =[storyBoard instantiateViewControllerWithIdentifier:@"VCITemas"];
    [self.navigationController pushViewController:pViewController animated:YES];
 
    // Enviar la celda seleccioda.
    NSArray *contenido =  [[self arrTrimestreSecciones]objectAtIndex:[indexPath section]];
    NSString *trimestreSel =  [contenido objectAtIndex:[indexPath row]] ;
    [pViewController setPTrimestreSel:trimestreSel];

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
