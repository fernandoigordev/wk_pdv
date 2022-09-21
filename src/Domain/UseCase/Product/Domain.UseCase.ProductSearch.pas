unit Domain.UseCase.ProductSearch;

interface
uses Domain.UseCase.ProductSearch.Interfaces,
     Domain.Observer.Product,
     Domain.Observer.product.Interfaces,
     Data.Repository.Product.Interfaces,
     Domain.Abstraction.Product;
type

TUseCaseProductSearch = Class(TInterfacedObject, IUseCaseProductSearch)
  private
    FRepositoryProduct: IRepositoryProduct;
    FSubjectProducSearch: ISubjectProducSearch;
  public
    Constructor Create(ARepositoryProduct: IRepositoryProduct);
    procedure Execute(ACode: Integer);
    function AddObserver(AObserverProduct: IObserverProductSearch): IUseCaseProductSearch;
End;

implementation

{ TUseCaseProductSearch }

function TUseCaseProductSearch.AddObserver(
  AObserverProduct: IObserverProductSearch): IUseCaseProductSearch;
begin
  FSubjectProducSearch.Add(AObserverProduct);
end;

constructor TUseCaseProductSearch.Create(
  ARepositoryProduct: IRepositoryProduct);
begin
  FRepositoryProduct := ARepositoryProduct;
  FSubjectProducSearch := TSubjectProductSearch.Create;
end;

procedure TUseCaseProductSearch.Execute(ACode: Integer);
var
  Product: TAbstractionProduct;
  ProductNotify: RProductSearc;
begin
  Product := FRepositoryProduct.Search(ACode);
  if Assigned(Product) then
  begin
    ProductNotify.Code := Product.Code;
    ProductNotify.Description := Product.Description;
    ProductNotify.PhotoPath := Product.PhotoPath;
    ProductNotify.Price := Product.Price;

    FSubjectProducSearch.Notify(ProductNotify);
  end;
end;

end.
