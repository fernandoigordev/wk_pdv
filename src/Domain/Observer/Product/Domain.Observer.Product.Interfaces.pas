unit Domain.Observer.Product.Interfaces;

interface

type

RProductSearc = Record
  Code: Integer;
  Description: String;
  PhotoPath: String;
  Price: Double;
End;

IObserverProductSearch = interface;

ISubjectProducSearch = interface
  procedure Add(AProduct: IObserverProductSearch);
  procedure Notify(AItem: RProductSearc);
end;

IObserverProductSearch = interface
  procedure UpdateItem(AProduct: RProductSearc);
end;

implementation

end.
