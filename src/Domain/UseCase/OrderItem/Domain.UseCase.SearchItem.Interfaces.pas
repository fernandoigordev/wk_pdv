unit Domain.UseCase.SearchItem.Interfaces;

interface
uses Domain.Abstraction.OrderItem, System.Generics.Collections;

type
IUseCaseSearchItem = Interface
  ['{01CF9E14-A455-427F-946E-F2EE5A9E8688}']
  function Execute(ACode: Integer): TList<TAbstractionOrderItem>;
End;

implementation

end.
