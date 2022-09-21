unit Domain.UseCase.ProductSearch.Interfaces;

interface
uses Domain.Observer.Product.Interfaces;

type
IUseCaseProductSearch = interface
['{B538C8CF-7008-4281-B19E-0FA1E99589A3}']
  procedure Execute(ACode: Integer);
  function AddObserver(AObserverProduct: IObserverProductSearch): IUseCaseProductSearch;
end;

implementation

end.
