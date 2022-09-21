unit Domain.Abstraction.Customer;

interface

type

TAbstractionCustomer = Class
  private
    FCode: Integer;
    FName: String;
    FCity: String;
    FUf: String;
    FPhotoPath: String;
  public
    property Code: Integer read FCode write FCode;
    property Name: String read FName write FName;
    property City: String read FCity write FCity;
    property Uf: String read FUf write FUf;
    property PhotoPath: String read FPhotoPath write FPhotoPath;
End;

implementation

end.
