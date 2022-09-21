unit Domain.UseCase.SaveOrder;

interface
uses Domain.Abstraction.Order,
     Domain.Abstraction.OrderItem,
     Domain.UseCase.SaveOrder.Interfaces,
     Data.Repository.Order.Interfaces,
     Data.Repository.OrderItem.Interfaces,
     Data.Services.Table.Interfaces;

type
TUseCaseSaveOrder = class(TInterfacedObject, IUseCaseSaveOrder)
  private
    FReposotory: IReposotoryOrder;
    FRepositoryOrderItem: IRepositoryOrderItem;
    FServiceTable: IServiceTable;
  public
    Constructor Create(ARepository: IReposotoryOrder;
                       ARepositoryOrderItem: IRepositoryOrderItem;
                       AServiceTable: IServiceTable);
    procedure Execute(AOrder: TAbstractionOrder);
end;

implementation

{ TUseCaseSaveOrder }

constructor TUseCaseSaveOrder.Create(ARepository: IReposotoryOrder;
                                     ARepositoryOrderItem: IRepositoryOrderItem;
                                     AServiceTable: IServiceTable);
begin
  FReposotory := ARepository;
  FRepositoryOrderItem := ARepositoryOrderItem;
  FServiceTable := AServiceTable;
end;

procedure TUseCaseSaveOrder.Execute(AOrder: TAbstractionOrder);
var
  Item: TAbstractionOrderItem;
begin
  AOrder.Code := FServiceTable.NextCode('order');
  FReposotory.Save(AOrder);

  if AOrder.Items.Count > 0 then
  begin
    for Item in AOrder.Items do
    begin
      Item.OrderCode := AOrder.Code;
      FRepositoryOrderItem.Save(Item);
    end;
  end;

end;

end.
