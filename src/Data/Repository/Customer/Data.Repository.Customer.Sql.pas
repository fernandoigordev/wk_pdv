unit Data.Repository.Customer.Sql;

interface
uses Data.Repository.Customer.Interfaces,
     Domain.Abstraction.Customer,FireDAC.Comp.Client,
     FireDAC.DApt;

type
TRepositoryCustomerSql = Class(TInterfacedObject, IRepositoryCustomer)
  private
    FQuery: TFDQuery;
  public
    Constructor Create(AConnection: TFDConnection);
    function Search(ACode: Integer): TAbstractionCustomer;
End;

implementation

uses
  System.SysUtils, Vcl.Forms;

{ TRepositoryCustomerSql }

constructor TRepositoryCustomerSql.Create(AConnection: TFDConnection);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := AConnection;
end;

function TRepositoryCustomerSql.Search(ACode: Integer): TAbstractionCustomer;
var
  Customer: TAbstractionCustomer;
  sql: String;
  PathPhoto: String;
begin
  sql := Concat('select * from customer where code = ', IntToStr(ACode));
  FQuery.Close;
  FQuery.Open(sql);
  if FQuery.RecordCount > 0 then
  begin
    Customer := TAbstractionCustomer.Create;
    Customer.Code := FQuery.FieldByName('code').AsInteger;
    Customer.Name := FQuery.FieldByName('name').AsString;
    Customer.City := FQuery.FieldByName('city').AsString;
    Customer.Uf := FQuery.FieldByName('uf').AsString;
    PathPhoto := Concat(ExtractFileDir(Application.ExeName), '\Assets\images\Customer\', FQuery.FieldByName('code').AsString,'.jpg');
    if FileExists(PathPhoto) then
      Customer.PhotoPath := PathPhoto
    else
      Customer.PhotoPath := Concat(ExtractFileDir(Application.ExeName), '\Assets\images\Customer\default.png');
  end;
  Result := Customer;
end;

end.
