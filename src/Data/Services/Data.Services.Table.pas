unit Data.Services.Table;

interface
uses Data.Services.Table.Interfaces,
     FireDAC.Comp.Client, FireDAC.DApt;

type

TServiceTable = Class(TInterfacedObject, IServiceTable)
  private
    FQuery: TFDQuery;
  public
    Constructor Create(AConnection: TFDConnection);
    function NextCode(ATableName: String): Integer;
end;

implementation

{ TServiceTable }

constructor TServiceTable.Create(AConnection: TFDConnection);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := AConnection;
end;

function TServiceTable.NextCode(ATableName: String): Integer;
begin
  Result := 0;
  FQuery.Close;
  FQuery.SQL.Text := Concat('select coalesce(max(code),0) as LastCode from "',ATableName,'"');
  FQuery.Open;
  Result := (FQuery.FieldByName('LastCode').AsInteger + 1);
end;

end.
