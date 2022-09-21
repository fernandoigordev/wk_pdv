unit Domain.Observer.Product;

interface

uses Domain.Observer.Product.Interfaces,
     System.Generics.Collections;

type

TSubjectProductSearch = Class(TInterfacedObject, ISubjectProducSearch)
  private
    FListItem: TList<IObserverProductSearch>;
  public
    Constructor Create;
    Destructor Destroy;override;
    procedure Add(AProduct: IObserverProductSearch);
    procedure Notify(AProduct: RProductSearc);
end;

implementation

{ TSubjectItemSearch }

procedure TSubjectProductSearch.Add(AProduct: IObserverProductSearch);
begin
  FListItem.Add(AProduct);
end;

constructor TSubjectProductSearch.Create;
begin
  FListItem := TList<IObserverProductSearch>.Create;
end;

destructor TSubjectProductSearch.Destroy;
begin
  FListItem.Free;
  inherited;
end;

procedure TSubjectProductSearch.Notify(AProduct: RProductSearc);
var
  I: Integer;
begin
  for I := 0 to Pred(FListItem.Count) do
  begin
    FListItem[I].UpdateItem(AProduct);
  end;
end;

end.
