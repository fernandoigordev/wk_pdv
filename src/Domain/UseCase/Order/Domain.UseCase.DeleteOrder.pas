unit Domain.UseCase.DeleteOrder;

interface
uses Domain.UseCase.DeleteOrder.Interfaces,
     Data.Repository.Order.Interfaces;

type
TUseCaseDeleteOrder = Class(TInterfacedObject, IUseCaseDeleteOrder)
  private
    FReposotoryOrder: IReposotoryOrder;
  public
    Constructor Create(AReposotoryOrder: IReposotoryOrder);
    procedure Execute(ACode: Integer);

End;

implementation

{ TUseCaseDeleteOrder }

constructor TUseCaseDeleteOrder.Create(AReposotoryOrder: IReposotoryOrder);
begin
  FReposotoryOrder := AReposotoryOrder;
end;

procedure TUseCaseDeleteOrder.Execute(ACode: Integer);
begin
  FReposotoryOrder.Delete(ACode);
end;

end.
