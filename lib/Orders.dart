import 'DbHelper.dart';

class Orders{
  String OrderId;
  String ProductId;
  String UserId;
  String MershantIdF;
  int AddressId;
  int OrderIsAccepted;
  int ProductPrice;
  String ProductName;
  String AddressDetails;
  String ProductCategory;
  String NameClient;
  String ProductImage;

  Orders({
    this.UserId,
    this.OrderId,
    this.ProductId,
    this.ProductName,
    this.ProductPrice,
    this.ProductCategory,
    this.AddressDetails,
    this.OrderIsAccepted,
    this.ProductImage,
    this.NameClient,
    this.AddressId,
    this.MershantIdF,
  });

  factory Orders.fromJson(Map<String, dynamic>json)=>
      Orders(
        MershantIdF:json[DbHelper.columnOrderMershantIdF],
        UserId: json[DbHelper.columnOrderUserIdF],
        ProductId: json[DbHelper.columnOrderProductIdF],
        ProductName: json[DbHelper.columnOrderProductName],
        OrderIsAccepted: json[DbHelper.columnOrderIsAccepted],
        ProductPrice: json[DbHelper.columnOrderProductPrice],
        AddressDetails: json[DbHelper.columnOrderAddressDetails],
        AddressId: json[DbHelper.columnOrderAddressIdF],
        ProductCategory: json[DbHelper.columnOrderProductCategory],
        OrderId: json[DbHelper.columnOrderId],
        NameClient: json[DbHelper.columnOrderUserName],
        ProductImage: json[DbHelper.columnOrderProductImage],
      );

  Map<String, dynamic> toMap() {
    return {
      DbHelper.columnOrderMershantIdF:MershantIdF,
      DbHelper.columnOrderUserIdF: UserId,
      DbHelper.columnOrderProductIdF: ProductId,
      DbHelper.columnOrderAddressIdF: AddressId,
      DbHelper.columnOrderIsAccepted: OrderIsAccepted,
      DbHelper.columnOrderProductName: ProductName,
      DbHelper.columnOrderProductPrice: ProductPrice,
      DbHelper.columnOrderAddressDetails: AddressDetails,
      DbHelper.columnOrderProductCategory: ProductCategory,
      DbHelper.columnOrderId: OrderId,
      DbHelper.columnOrderUserName: NameClient,
      DbHelper.columnOrderProductImage: ProductImage,
    };
  }
}
