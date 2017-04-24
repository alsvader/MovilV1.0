//
//  VCGMenuTrimestre.m
//  Visor
//
//  Created by aaron on 2/21/17.
//  Copyright © 2017 ST. All rights reserved.
//

#import "VCGMenuTrimestre.h"
#import "BDManager.h"
#import "VCGTemas.h"

@interface VCGMenuTrimestre ()
    @property (nonatomic, strong) BDManager *dbManager;
    @property (nonatomic, strong) NSArray *arrTrimestre;
    @property (nonatomic,strong) NSMutableArray *arrTrimestreSecciones;

@end

@implementation VCGMenuTrimestre

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dbManager = [[BDManager alloc] initWithDatabaseFileName:@"bd_visor.sqlite"];
    [self loadTrimestres];
    if (_arrTrimestre.count>0)
    {
        [self seccionarTrimestres];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadTrimestres{
    NSString *query = [NSString stringWithFormat:@"Select id_trimestre, descripcion, anio, fecha_inicio from cat_trimestre  order by date (fecha_inicio), anio DESC " ];
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



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    NSInteger secciones = [[self arrTrimestreSecciones] count];
    
    return secciones;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
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
    
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.356 green: 0.380 blue:0.407 alpha:1 ];
    [cell setBackgroundColor:[UIColor colorWithRed:0.909 green: 0.909 blue:0.905 alpha:1 ]];
    
    
    NSArray *contenido =  [[self arrTrimestreSecciones]objectAtIndex:[indexPath section]];
    NSString *contFila = [ [contenido objectAtIndex:[indexPath row]] objectAtIndex:1];
    cell.textLabel.text =  contFila;
    cell.imageView.image =[UIImage imageNamed:@"Image-12.jpg"];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tView=[[UIView alloc]initWithFrame:CGRectMake(0,0,0,0)];
    
        tView.backgroundColor=[UIColor  colorWithRed:0.419 green: 0.752 blue:0.862 alpha:1];
        
    
    UILabel *tLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,0,180,40)];
    
    // tLabel.backgroundColor=[UIColor blueColor];
    
    tLabel.textColor = [UIColor colorWithRed:1 green: 1 blue:1 alpha:1];
    tLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    // tempLabel.font = [UIFont boldSystemFontOfSize:fontSizeForHeaders];
    
    tLabel.font = [UIFont boldSystemFontOfSize:14];
    
    NSArray *contenido =  [[self arrTrimestreSecciones]objectAtIndex: section];
    NSString *titulo = [ [contenido objectAtIndex:0]objectAtIndex:2];
    tLabel.text=titulo;
    
    [tView addSubview:tLabel];
    
    

    
    return tView;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
   
    
    
    
    NSArray *contenido =  [[self arrTrimestreSecciones]objectAtIndex: section];
    NSString *titulo = [ [contenido objectAtIndex:0]objectAtIndex:2];
    
   return  [NSString stringWithFormat:@"  Ejercicio del %@", titulo];
};

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VCGTemas *pViewController =[storyBoard instantiateViewControllerWithIdentifier:@"VCGTemas"];
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
