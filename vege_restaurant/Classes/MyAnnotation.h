//
//  MyAnnotation.h
//  WorldPhotos
//
//  Created by 이선동 on 11. 5. 1..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
//    NSNumber *seqindex;
    NSUInteger tag;    
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
//@property (nonatomic, retain) NSString *title;
//@property (nonatomic, retain) NSString *subtitle;

@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *title;


//@property (nonatomic, retain) NSNumber *seqindex;
@property(nonatomic) NSUInteger tag;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (id)initWithCoordinate:(CLLocationCoordinate2D)c withTag:(NSUInteger)t withTitle:(NSString *)tl withSubtitle:	(NSString *)s;

@end
