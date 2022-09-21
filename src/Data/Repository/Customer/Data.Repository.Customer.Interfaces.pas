unit Data.Repository.Customer.Interfaces;

interface
uses Domain.Abstraction.Customer;

type
IRepositoryCustomer = interface
  ['{3A1AC166-F657-46FB-A292-C4838CD5E6EE}']
  function Search(ACode: Integer): TAbstractionCustomer;
end;

implementation

end.
