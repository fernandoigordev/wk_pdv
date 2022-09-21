unit Data.Repository.Product.Sql;

interface
uses Data.Repository.Product.Interfaces,
     Domain.Abstraction.Product,
     FireDAC.Comp.Client, FireDAC.DApt;

type
TRepositoryProductSql = Class(TInterfacedObject, IRepositoryProduct)
  private
    FQuery: TFDQuery;
  public
    Constructor Create(AConnection: TFDConnection);
    function Search(AProductCode: Integer): TAbstractionProduct;
end;

implementation

uses
  System.SysUtils, Vcl.Forms;

{ TRepositoryProductSql }

constructor TRepositoryProductSql.Create(AConnection: TFDConnection);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := AConnection;
end;

function TRepositoryProductSql.Search(
  AProductCode: Integer): TAbstractionProduct;
var
  Sql: String;
  Product: TAbstractionProduct;
  PathPhoto: String;
begin
  Sql := Concat('select * from product where code = ', IntToStr(AProductCode));
  FQuery.Close;
  FQuery.SQL.Text := Sql;
  FQuery.Open;

  if FQuery.RecordCount > 0 then
  begin
    Product := TAbstractionProduct.Create;
    Product.Code := FQuery.FieldByName('code').AsInteger;
    Product.Description := FQuery.FieldByName('Description').AsString;
    Product.Price := FQuery.FieldByName('Price').AsFloat;
    PathPhoto := Concat(ExtractFileDir(Application.ExeName), '\Assets\images\products\', FQuery.FieldByName('code').AsString, '.jpg');
    if FileExists(PathPhoto) then
      Product.PhotoPath := PathPhoto
    else
      Product.PhotoPath := Concat(ExtractFileDir(Application.ExeName), '\Assets\images\products\default.png');

    Result := Product;
  end
  else
  begin
    raise Exception.Create('Produto não encontrado');
  end;
end;

end.
