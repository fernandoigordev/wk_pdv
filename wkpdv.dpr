program wkpdv;

uses
  Vcl.Forms,
  Presentation.View.Main in 'src\Presentation\View\Presentation.View.Main.pas' {frmViewMain},
  Domain.UseCase.SearchItem.Interfaces in 'src\Domain\UseCase\OrderItem\Domain.UseCase.SearchItem.Interfaces.pas',
  Domain.Observer.Product in 'src\Domain\Observer\Product\Domain.Observer.Product.pas',
  Domain.Observer.Product.Interfaces in 'src\Domain\Observer\Product\Domain.Observer.Product.Interfaces.pas',
  Domain.UseCase.SearchItem in 'src\Domain\UseCase\OrderItem\Domain.UseCase.SearchItem.pas',
  Data.Repository.OrderItem.Interfaces in 'src\Data\Repository\OrderItem\Data.Repository.OrderItem.Interfaces.pas',
  Domain.Abstraction.OrderItem in 'src\Domain\Abstraction\Domain.Abstraction.OrderItem.pas',
  Data.Repository.OrderItem.Sql in 'src\Data\Repository\OrderItem\Data.Repository.OrderItem.Sql.pas',
  Presentation.View.Search in 'src\Presentation\View\Presentation.View.Search.pas' {frmViewSearch},
  Domain.Abstraction.Customer in 'src\Domain\Abstraction\Domain.Abstraction.Customer.pas',
  Domain.UseCase.SearchCustomer.Interfaces in 'src\Domain\UseCase\Customer\Domain.UseCase.SearchCustomer.Interfaces.pas',
  Domain.UseCase.SearchCustomer in 'src\Domain\UseCase\Customer\Domain.UseCase.SearchCustomer.pas',
  Data.Repository.Customer.Interfaces in 'src\Data\Repository\Customer\Data.Repository.Customer.Interfaces.pas',
  Data.Repository.Customer.Sql in 'src\Data\Repository\Customer\Data.Repository.Customer.Sql.pas',
  Domain.Abstraction.Order in 'src\Domain\Abstraction\Domain.Abstraction.Order.pas',
  Domain.UseCase.SaveOrder.Interfaces in 'src\Domain\UseCase\Order\Domain.UseCase.SaveOrder.Interfaces.pas',
  Domain.UseCase.SaveOrder in 'src\Domain\UseCase\Order\Domain.UseCase.SaveOrder.pas',
  Data.Repository.Order.Interfaces in 'src\Data\Repository\Order\Data.Repository.Order.Interfaces.pas',
  Data.Repository.Order.Sql in 'src\Data\Repository\Order\Data.Repository.Order.Sql.pas',
  Data.Repository.DM in 'src\Data\Repository\Data.Repository.DM.pas' {DM: TDataModule},
  Domain.UseCase.ProductSearch.Interfaces in 'src\Domain\UseCase\Product\Domain.UseCase.ProductSearch.Interfaces.pas',
  Domain.UseCase.ProductSearch in 'src\Domain\UseCase\Product\Domain.UseCase.ProductSearch.pas',
  Data.Repository.Product.Interfaces in 'src\Data\Repository\Product\Data.Repository.Product.Interfaces.pas',
  Domain.Abstraction.Product in 'src\Domain\Abstraction\Domain.Abstraction.Product.pas',
  Data.Repository.Product.Sql in 'src\Data\Repository\Product\Data.Repository.Product.Sql.pas',
  Data.Services.Table in 'src\Data\Services\Data.Services.Table.pas',
  Data.Services.Table.Interfaces in 'src\Data\Services\Data.Services.Table.Interfaces.pas',
  Domain.UseCase.DeleteOrder.Interfaces in 'src\Domain\UseCase\Order\Domain.UseCase.DeleteOrder.Interfaces.pas',
  Domain.UseCase.DeleteOrder in 'src\Domain\UseCase\Order\Domain.UseCase.DeleteOrder.pas',
  Domain.UseCase.SearchOrder.Interfaces in 'src\Domain\UseCase\Order\Domain.UseCase.SearchOrder.Interfaces.pas',
  Domain.UseCase.SearchOrder in 'src\Domain\UseCase\Order\Domain.UseCase.SearchOrder.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmViewMain, frmViewMain);
  Application.Run;
end.
