//
//  MyAnnotation.m
//  WorldPhotos
//
//  Created by 이선동 on 11. 5. 1..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
@synthesize coordinate;
@synthesize title, subtitle;
//@synthesize seqindex, 
@synthesize tag;

- (void)dealloc {
//    [seqindex release];
//    [title release];
//    [subtitle release];
    
    [super dealloc];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)c {
    coordinate = c;
    return self;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)c withTag:(NSUInteger)t withTitle:(NSString *)tl withSubtitle:	(NSString *)s	
{
	if(self = [super init])
	{
		coordinate = c;
		tag = t;
		title = tl;
		subtitle = s;
	}
	return self;
}

@end
