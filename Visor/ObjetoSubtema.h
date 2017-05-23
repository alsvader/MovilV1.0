//
//  ObjetoSubtema.h
//  Visor
//
//  Created by aaron on 3/24/17.
//  Copyright © 2017 ST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjetoSubtema : NSObject


-(id)initWithJSONData:(NSDictionary*)Subtema;
@property (strong) NSString *Id_subtema;
@property (strong) NSString *Id_Tema;
@property (strong) NSString *Descripcion;
@property (strong) NSString *Descripcion_corta;


@end
