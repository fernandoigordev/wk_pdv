unit Data.Repository.OrderItem.Interfaces;

interface
uses Domain.Abstraction.OrderItem, System.Generics.Collections;

type
IRepositoryOrderItem = interface
  ['{15121BE9-FAEA-4862-BB54-42A7DD82B14F}']
  function Search(AOrderCode: Integer): TList<TAbstractionOrderItem>;
  procedure Save(AItem: TAbstractionOrderItem);
end;


implementation

end.
