unit Data.Repository.OrderItem.Sql;

interface
uses System.Generics.Collections, Data.Repository.OrderItem.Interfaces,
     Domain.Abstraction.OrderItem, FireDAC.Comp.Client, FireDAC.DApt;

type
TRepositoryOrderItemSql = Class(TInterfacedObject, IRepositoryOrderItem)
  private
    FQuery: TFDQuery;
  public
    Constructor Create(AConnection: TFDConnection);
    function Search(AOrderCode: Integer): TList<TAbstractionOrderItem>;
    procedure Save(AItem: TAbstractionOrderItem);
End;


implementation

uses
  System.SysUtils, Vcl.Forms, FireDAC.Stan.Param;

{ TRepositoryOrderItem }

constructor TRepositoryOrderItemSql.Create(AConnection: TFDConnection);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := AConnection;
end;

procedure TRepositoryOrderItemSql.Save(AItem: TAbstractionOrderItem);
begin
  FQuery.Close;
  FQuery.SQL.Text := Concat('insert into order_item (product_code, quantity, unit_value, total, order_code) ',
                            'values(:product_code, :quantity, :unit_value, :total, :order_code)');

  FQuery.ParamByName('product_code').AsInteger := AItem.ProductCode;
  FQuery.ParamByName('quantity').AsInteger := AItem.Quantity;
  FQuery.ParamByName('unit_value').AsFloat := AItem.Price;
  FQuery.ParamByName('total').AsFloat := AItem.Total;
  FQuery.ParamByName('order_code').AsInteger := AItem.OrderCode;
  FQuery.ExecSQL;
end;

function TRepositoryOrderItemSql.Search(AOrderCode: Integer): TList<TAbstractionOrderItem>;
var
  ListItem: TList<TAbstractionOrderItem>;
  Index: Integer;
  PathPhoto: String;
begin
  FQuery.Close;
  FQuery.SQL.Text := Concat('select i.*, p.description  from order_item i ',
                            'left join product p on p.code = i.product_code ',
                            'where order_code = ', IntToStr(AOrderCode));
  FQuery.Open;

  if FQuery.RecordCount > 0 then
  begin
    ListItem := TList<TAbstractionOrderItem>.Create;
    FQuery.First;
    while not FQuery.Eof do
    begin
      Index := ListItem.Add(TAbstractionOrderItem.Create);
      ListItem[Index].ProductCode := FQuery.FieldByName('product_code').AsInteger;
      ListItem[Index].Description := FQuery.FieldByName('Description').AsString;
      ListItem[Index].Quantity := FQuery.FieldByName('quantity').AsInteger;
      ListItem[Index].Price := FQuery.FieldByName('unit_value').AsFloat;
      ListItem[Index].Total := FQuery.FieldByName('total').AsFloat;
      ListItem[Index].OrderCode := FQuery.FieldByName('order_code').AsInteger;
      PathPhoto := Concat(ExtractFileDir(Application.ExeName), '\Assets\images\products\', FQuery.FieldByName('product_code').AsString,'.jpg');

      if FileExists(PathPhoto) then
        ListItem[Index].PhotoPath := PathPhoto
      else
        ListItem[Index].PhotoPath := Concat(ExtractFileDir(Application.ExeName), '\Assets\images\products\default.png');

      FQuery.Next;;
    end;
    Result := ListItem;
  end;
end;

end.
