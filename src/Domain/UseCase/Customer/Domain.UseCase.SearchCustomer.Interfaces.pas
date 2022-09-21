unit Domain.UseCase.SearchCustomer.Interfaces;

interface
uses Domain.Abstraction.Customer;

type
IUseCaseSearchCustomer = interface
  ['{D89228E1-39CA-480E-A113-26CB4C2E87CE}']
  function Execute(ACode: Integer): TAbstractionCustomer;
end;

implementation

end.
