unit Data.Repository.Order.Sql;

interface
uses Data.Repository.Order.Interfaces,
     Domain.Abstraction.Order,
     FireDAC.Comp.Client, FireDAC.DApt;

type
TReposotoryOrderSql = Class(TInterfacedObject, IReposotoryOrder)
  private
    FQuery: TFDQuery;
  public
    Constructor Create(AConnection: TFDConnection);
    procedure Save(Order: TAbstractionOrder);
    procedure Delete(AOrderCode: Integer);
    function Search(AOrderCode: Integer): TAbstractionOrder;
End;

implementation

uses
  Vcl.Dialogs, System.SysUtils;

{ TReposotoryOrderSql }

constructor TReposotoryOrderSql.Create(AConnection: TFDConnection);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := AConnection;
end;

procedure TReposotoryOrderSql.Delete(AOrderCode: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Text := Concat('delete from "order" where code = ', IntToStr(AOrderCode));
  FQuery.ExecSQL;
end;

procedure TReposotoryOrderSql.Save(Order: TAbstractionOrder);
begin
  FQuery.Close;
  FQuery.SQL.Text := Concat('insert into "order" (code,completed_date, total, customer_Id) ',
                            'values(:code,:completed_date, :total, :customer_Id)');
  FQuery.ParamByName('code').AsInteger := Order.Code;
  FQuery.ParamByName('completed_date').AsDate := Order.CompletedDate;
  FQuery.ParamByName('total').AsFloat := Order.Total;
  FQuery.ParamByName('customer_Id').AsInteger := Order.Customer.Code;
  FQuery.ExecSQL;
end;

function TReposotoryOrderSql.Search(AOrderCode: Integer): TAbstractionOrder;
var
  Order: TAbstractionOrder;
  FormatSettings: TFormatSettings;
begin
  FQuery.Close;
  FQuery.SQL.Text := Concat('select * from "order" where code = ', IntToStr(AOrderCode));
  FQuery.Open;

  if FQuery.RecordCount > 0 then
  begin
    FormatSettings.DateSeparator := '-';
    FormatSettings.ShortDateFormat := 'yyyy-mm-dd';
    FormatSettings.TimeSeparator := ':';
    Order := TAbstractionOrder.Create;
    Order.Code := FQuery.FieldByName('code').AsInteger;
    Order.CompletedDate := StrToDate(FQuery.FieldByName('completed_date').AsString, FormatSettings);
    Order.Total := FQuery.FieldByName('total').AsFloat;
    Order.Customer.Code := FQuery.FieldByName('customer_Id').AsInteger;
    Result := Order;
  end;
end;

end.
