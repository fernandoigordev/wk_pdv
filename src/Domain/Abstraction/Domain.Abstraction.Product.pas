unit Domain.Abstraction.Product;

interface

type

TAbstractionProduct = Class
  private
    FPhotoPath: String;
    FCode: Integer;
    FPrice: Double;
    FDescription: String;
  public
    property Code: Integer read FCode write FCode;
    property Description: String read FDescription write FDescription;
    property PhotoPath: String read FPhotoPath write FPhotoPath;
    property Price: Double read FPrice write FPrice;
End;

implementation

end.
