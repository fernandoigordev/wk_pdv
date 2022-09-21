unit Data.Repository.Order.Interfaces;

interface
uses Domain.Abstraction.Order;

type
IReposotoryOrder = interface
  ['{41A655D5-60EC-4826-8095-C5958A0EE0DB}']
  procedure Save(Order: TAbstractionOrder);
  function Search(AOrderCode: Integer): TAbstractionOrder;
  procedure Delete(AOrderCode: Integer);
end;

implementation

end.
