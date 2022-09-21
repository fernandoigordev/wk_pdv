unit Domain.UseCase.SearchOrder;

interface
uses Domain.UseCase.SearchOrder.Interfaces,
     Domain.Abstraction.Order,
     Domain.Abstraction.Customer,
     Domain.Abstraction.OrderItem,
     Data.Repository.Order.Interfaces,
     Data.Repository.Customer.Interfaces,
     Data.Repository.OrderItem.Interfaces;

type
TUseCaseSearchOrder = Class(TInterfacedObject, IUseCaseSearchOrder)
  private
    FReposotoryOrder: IReposotoryOrder;
    FRepositoryCustomer: IRepositoryCustomer;
    FRepositoryOrderItem: IRepositoryOrderItem;
  public
    Constructor Create(AReposotoryOrder: IReposotoryOrder;
                       ARepositoryCustomer: IRepositoryCustomer;
                       ARepositoryOrderItem: IRepositoryOrderItem);
    function Execute(ACode: Integer): TAbstractionOrder;
End;

implementation

{ TUseCaseSearchOrder }

constructor TUseCaseSearchOrder.Create(AReposotoryOrder: IReposotoryOrder;
  ARepositoryCustomer: IRepositoryCustomer;
  ARepositoryOrderItem: IRepositoryOrderItem);
begin
  FReposotoryOrder := AReposotoryOrder;
  FRepositoryCustomer := ARepositoryCustomer;
  FRepositoryOrderItem := ARepositoryOrderItem;
end;

function TUseCaseSearchOrder.Execute(ACode: Integer): TAbstractionOrder;
var
  Order: TAbstractionOrder;
begin
  Order := FReposotoryOrder.Search(ACode);
  if Assigned(Order) then
  begin
    Order.Customer := FRepositoryCustomer.Search(Order.Customer.Code);
    Order.Items := FRepositoryOrderItem.Search(ACode);
  end;
  Result := Order;
end;

end.
