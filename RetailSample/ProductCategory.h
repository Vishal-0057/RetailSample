//
//  ProductCategory.h
//  RetailSample
//
//  Created by Vishal Gupta on 8/4/15.
//  Copyright (c) 2015 Vishal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

@interface ProductCategory : NSManagedObject

@property (nonatomic) int16_t categoryId;
@property (nonatomic, retain) NSString * categoryName;
@property (nonatomic, retain) NSSet *products;
@end

@interface ProductCategory (CoreDataGeneratedAccessors)

- (void)addProductsObject:(Product *)value;
- (void)removeProductsObject:(Product *)value;
- (void)addProducts:(NSSet *)values;
- (void)removeProducts:(NSSet *)values;

@end
