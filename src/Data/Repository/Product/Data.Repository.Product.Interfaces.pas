unit Data.Repository.Product.Interfaces;

interface
uses Domain.Abstraction.Product;

type

IRepositoryProduct = interface
  ['{BC184B78-3170-4301-ADB9-BC945E5D1135}']
  function Search(AProductCode: Integer): TAbstractionProduct;
end;


implementation

end.
