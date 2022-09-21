unit Domain.Abstraction.OrderItem;

interface

type

TAbstractionOrderItem = Class
  private
    FPrice: Double;
    FProductCode: Integer;
    FTotal: Double;
    FQuantity: Integer;
    FDescription: String;
    FPhotoPath: String;
    FOrderCode: Integer;
  public
    property ProductCode: Integer read FProductCode write FProductCode;
    property Description: String read FDescription write FDescription;
    property Quantity: Integer read FQuantity write FQuantity;
    property Price: Double read FPrice write FPrice;
    property Total: Double read FTotal write FTotal;
    property OrderCode: Integer read FOrderCode write FOrderCode;
    property PhotoPath: String read FPhotoPath write FPhotoPath;
end;

implementation

end.
