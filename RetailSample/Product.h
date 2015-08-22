//
//  Product.h
//  RetailSample
//
//  Created by Vishal Gupta on 8/4/15.
//  Copyright (c) 2015 Vishal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProductCategory;

@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * productName;
@property (nonatomic) double price;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) ProductCategory *productCategory;

@end
