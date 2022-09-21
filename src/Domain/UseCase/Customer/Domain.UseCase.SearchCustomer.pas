unit Domain.UseCase.SearchCustomer;

interface
uses Domain.UseCase.SearchCustomer.Interfaces,
     Data.Repository.Customer.Interfaces,
     Domain.Abstraction.Customer;

type
TUseCaseSearchCustomer = Class(TInterfacedObject, IUseCaseSearchCustomer)
  private
    FRepositoryCustomer: IRepositoryCustomer;
  public
    Constructor Create(ARepositoryCustomer: IRepositoryCustomer);
    function Execute(ACode: Integer): TAbstractionCustomer;
End;

implementation

{ TUseCaseSearchCustomer }

constructor TUseCaseSearchCustomer.Create(
  ARepositoryCustomer: IRepositoryCustomer);
begin
  FRepositoryCustomer := ARepositoryCustomer;
end;

function TUseCaseSearchCustomer.Execute(ACode: Integer): TAbstractionCustomer;
var
  Customer: TAbstractionCustomer;
begin
  Customer := FRepositoryCustomer.Search(ACode);
  if Assigned(Customer) then
    Result := Customer;
end;

end.
