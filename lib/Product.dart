import 'DbHelper.dart';

class Product {
  String ProductId;
  String ProductMershantIdF;
  String ProductName;
  int ProductPrice;
  String ProductCategory;
  String ProductDescription;
  String ProductImage;

  Product({
    this.ProductMershantIdF,
    this.ProductId,
    this.ProductName,
    this.ProductPrice,
    this.ProductCategory,
    this.ProductDescription,
    this.ProductImage,
  });

  factory Product.fromJson(Map<String, dynamic>json)=>
      Product(
          ProductId: json[DbHelper.columnProductId],
          ProductMershantIdF: json[DbHelper.columnProductMershantIdF],
          ProductName: json[DbHelper.columnProductName],
          ProductPrice: json[DbHelper.columnProductPrice],
          ProductCategory: json[DbHelper.columnProductCategory],
          ProductDescription: json[DbHelper.columnProductDescription],
          ProductImage: json[DbHelper.columnProductImage]);

  Map<String, dynamic> toMap() {
    return {
      DbHelper.columnProductId:ProductId,
      DbHelper.columnProductMershantIdF: ProductMershantIdF,
      DbHelper.columnProductPrice: ProductPrice,
      DbHelper.columnProductCategory: ProductCategory,
      DbHelper.columnProductName: ProductName,
      DbHelper.columnProductDescription: ProductDescription,
      DbHelper.columnProductImage: ProductImage,
    };
  }
}