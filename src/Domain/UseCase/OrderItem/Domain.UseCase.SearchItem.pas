unit Domain.UseCase.SearchItem;

interface
uses Domain.UseCase.SearchItem.Interfaces,
     Data.Repository.OrderItem.Interfaces,
     Domain.Abstraction.OrderItem,
     System.Generics.Collections;

type
TUseCaseSearchItem = Class(TInterfacedObject, IUseCaseSearchItem)
  private
   FRepository: IRepositoryOrderItem;
  public
    Constructor Create(ARepository: IRepositoryOrderItem);
    function Execute(ACode: Integer): TList<TAbstractionOrderItem>;
End;

implementation

{ TUseCaseSearchItem }

constructor TUseCaseSearchItem.Create(ARepository: IRepositoryOrderItem);
begin
  FRepository := ARepository;
end;

function TUseCaseSearchItem.Execute(ACode: Integer): TList<TAbstractionOrderItem>;
var
  LisItem: TList<TAbstractionOrderItem>;
begin
  Result := nil;
  LisItem := FRepository.Search(ACode);
  if Assigned(LisItem) then
    Result := LisItem;
end;

end.
