unit Domain.UseCase.SearchOrder.Interfaces;

interface
uses Domain.Abstraction.Order,
     Domain.Abstraction.Customer,
     Domain.Abstraction.OrderItem;

type
IUseCaseSearchOrder = interface
  ['{E1096F9F-4B31-4B8A-90D6-3B2730E3612F}']
  function Execute(ACode: Integer): TAbstractionOrder;
end;

implementation

end.
