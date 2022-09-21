unit Domain.UseCase.SaveOrder.Interfaces;

interface
uses Domain.Abstraction.Order;

type
IUseCaseSaveOrder = interface
  ['{D3A5DBF7-4056-49B4-9C09-5DFECD5C6253}']
  procedure Execute(AOrder: TAbstractionOrder);
end;


implementation

end.
