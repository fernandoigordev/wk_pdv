unit Presentation.View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.DBCGrids, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Datasnap.DBClient, Vcl.DBCtrls, Domain.UseCase.SearchItem.Interfaces,
  Domain.Observer.Product.Interfaces, Data.Repository.OrderItem.Interfaces,
  Domain.Abstraction.OrderItem, Domain.UseCase.SearchCustomer.Interfaces,
  Data.Repository.Customer.Interfaces, Domain.Abstraction.Customer,
  Domain.UseCase.SaveOrder.Interfaces, Data.Repository.Order.Interfaces,
  Domain.UseCase.ProductSearch.Interfaces, Data.Repository.Product.Interfaces,
  Data.Services.Table.Interfaces, Domain.UseCase.DeleteOrder.Interfaces,
  Domain.UseCase.SearchOrder.Interfaces;

type
  TfrmViewMain = class(TForm, IObserverProductSearch)
    pnlTop: TPanel;
    pnlRight: TPanel;
    pnlContent: TPanel;
    pnlContentTop: TPanel;
    imgSearchProduct: TImage;
    edSearchProduct: TEdit;
    pnlContentBottom: TPanel;
    pnlContentProduct: TPanel;
    pnlDeleteOrder: TPanel;
    ShapeDeleteOrder: TShape;
    btnDeleteOrder: TSpeedButton;
    pnlLoadOrder: TPanel;
    ShapeLoadOrder: TShape;
    btnLoadOrder: TSpeedButton;
    imgItem: TImage;
    pnlImageProduct: TPanel;
    Label3: TLabel;
    pnlQuantity: TPanel;
    ShapeQuantity: TShape;
    Label4: TLabel;
    pnlPrice: TPanel;
    ShapePrice: TShape;
    Label5: TLabel;
    pnlTotal: TPanel;
    ShapeTotal: TShape;
    ShapeBtnAdd: TShape;
    btnAdd: TSpeedButton;
    pnlBtnAdd: TPanel;
    pnlSearch: TPanel;
    ShapeSearch: TShape;
    pnlCustomer: TPanel;
    imgCustomer: TImage;
    lbCustomer: TLabel;
    pnlBottomProduct: TPanel;
    pnlSave: TPanel;
    ShapeSave: TShape;
    btnSave: TSpeedButton;
    pnlCancel: TPanel;
    ShapeCancel: TShape;
    btnCancel: TSpeedButton;
    pnlOrderTotal: TPanel;
    Label6: TLabel;
    GridItens: TDBGrid;
    cdsSearchItem: TClientDataSet;
    cdsSearchItemDescription: TStringField;
    cdsSearchItemPhotoPath: TStringField;
    cdsSearchItemPrice: TFloatField;
    cdsSearchItemQuantity: TIntegerField;
    cdsSearchItemCode: TIntegerField;
    cdsSearchItemTotal: TFloatField;
    dsSearchItem: TDataSource;
    edQuantityItem: TDBEdit;
    edPriceItem: TDBEdit;
    edTotalItem: TDBEdit;
    DBText1: TDBText;
    dsListItem: TDataSource;
    cdsListItem: TClientDataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    FloatField1: TFloatField;
    IntegerField2: TIntegerField;
    edTotalOrder: TDBText;
    cdsListItemTotal: TFloatField;
    cdsListItemTotalOrder: TAggregateField;
    procedure FormCreate(Sender: TObject);
    procedure cdsSearchItemCalcFields(DataSet: TDataSet);
    procedure imgSearchProductClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edSearchProductKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edQuantityItemKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPriceItemKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edTotalItemKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSaveClick(Sender: TObject);
    procedure GridItensKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDeleteOrderClick(Sender: TObject);
    procedure btnLoadOrderClick(Sender: TObject);
    procedure cdsListItemCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FCustomerCode: Integer;
    FCurrentCustomer: TAbstractionCustomer;

    FUseCaseProductSearch: IUseCaseProductSearch;
    FUseCaseSearchItem: IUseCaseSearchItem;
    FUseCaseSearchCustomer: IUseCaseSearchCustomer;
    FUseCaseSaveOrder: IUseCaseSaveOrder;
    FUseCaseDeleteOrder: IUseCaseDeleteOrder;
    FUseCaseSearchOrder: IUseCaseSearchOrder;
    FServiceTable: IServiceTable;

    FRepositoryProduct: IRepositoryProduct;
    FRepositoryOrderItem: IRepositoryOrderItem;
    FRepositoryCustomer: IRepositoryCustomer;
    FReposotoryOrder: IReposotoryOrder;

    procedure EnableButtonsOrder(AValue: Boolean);

    procedure LoadCustomer(ACustomer: TAbstractionCustomer);
    procedure LoadItens(AItem: TAbstractionOrderItem);

    procedure UpdateItem(AProduct: RProductSearc);

    procedure SearchItem;
    procedure AddItem;
    procedure AlterItem;

    procedure CancelOrder;
    procedure ClearOrder;
    procedure SaveOrder;
    procedure DeleteOrder;
    procedure LoadOrder;
  public
    { Public declarations }
  end;

var
  frmViewMain: TfrmViewMain;

implementation
uses Domain.UseCase.SearchItem,
     Data.Repository.OrderItem.Sql,
     Presentation.View.Search,
     Domain.UseCase.SearchCustomer,
     Data.Repository.Customer.Sql,
     Domain.UseCase.SaveOrder,
     Data.Repository.Order.Sql,
     Domain.Abstraction.Order,
     Domain.UseCase.ProductSearch,
     Data.Repository.DM,
     Data.Repository.Product.Sql,
     Data.Services.Table,
     Domain.UseCase.DeleteOrder,
     Domain.UseCase.SearchOrder;

{$R *.dfm}

procedure TfrmViewMain.AddItem;
begin
  if cdsSearchItem.RecordCount > 0 then
  begin
    cdsListItem.Append;
    cdsListItem.FieldByName('Code').AsInteger := cdsSearchItem.FieldByName('Code').AsInteger;
    cdsListItem.FieldByName('Description').AsString := cdsSearchItem.FieldByName('Description').AsString;
    cdsListItem.FieldByName('Price').AsFloat := cdsSearchItem.FieldByName('Price').AsFloat;
    cdsListItem.FieldByName('Quantity').AsInteger := cdsSearchItem.FieldByName('Quantity').AsInteger;
    cdsListItem.FieldByName('PhotoPath').AsString := cdsSearchItem.FieldByName('PhotoPath').AsString;
    cdsListItem.FieldByName('Total').AsFloat := cdsSearchItem.FieldByName('Total').AsFloat;
    cdsListItem.Post;

    cdsSearchItem.EmptyDataSet;
    edSearchProduct.Text := EmptyStr;
    edSearchProduct.SetFocus;
  end;
end;

procedure TfrmViewMain.btnAddClick(Sender: TObject);
begin
  if cdsListItem.State = dsEdit then
    AlterItem
  else
    AddItem;
end;

procedure TfrmViewMain.btnCancelClick(Sender: TObject);
begin
  CancelOrder;
end;

procedure TfrmViewMain.btnDeleteOrderClick(Sender: TObject);
begin
  DeleteOrder;
end;

procedure TfrmViewMain.btnLoadOrderClick(Sender: TObject);
begin
  LoadOrder;
end;

procedure TfrmViewMain.btnSaveClick(Sender: TObject);
begin
  SaveOrder;
end;

procedure TfrmViewMain.CancelOrder;
begin
  if cdsListItem.RecordCount > 0 then
  begin
    if MessageDlg('Deseja cancelar esse pedido?', TMsgDlgType.mtConfirmation, [mbYes, mbNo],0) = mrYes then
      ClearOrder;
  end;
end;

procedure TfrmViewMain.cdsListItemCalcFields(DataSet: TDataSet);
begin
  cdsListItem.FieldByName('Total').AsFloat :=
    (cdsListItem.FieldByName('Quantity').AsInteger *
     cdsListItem.FieldByName('Price').AsFloat);
end;

procedure TfrmViewMain.cdsSearchItemCalcFields(DataSet: TDataSet);
begin
  cdsSearchItem.FieldByName('Total').AsFloat :=
    (cdsSearchItem.FieldByName('Quantity').AsInteger *
    cdsSearchItem.FieldByName('Price').AsFloat);
end;

procedure TfrmViewMain.ClearOrder;
var
  Path: String;
begin
  Path := ExtractFileDir(Application.ExeName);

  lbCustomer.Caption := EmptyStr;
  FCustomerCode := 0;
  imgCustomer.Picture.LoadFromFile(Concat(Path, '\Assets\images\Customer\default.png'));

  cdsListItem.EmptyDataSet;
  imgItem.Picture.LoadFromFile(Concat(Path, '\Assets\images\Products\default.png'));
  if cdsSearchItem.Active then
    cdsSearchItem.EmptyDataSet;
  dsSearchItem.DataSet := cdsSearchItem;
  EnableButtonsOrder(True);
  btnSave.Enabled := True;
  edSearchProduct.Enabled := True;
  btnAdd.Enabled := True;
  GridItens.OnKeyUp := GridItensKeyUp;
end;

procedure TfrmViewMain.DeleteOrder;
var
  OrderCode: Integer;
begin
  OrderCode := TfrmViewSearch.Search(stOrder);
  if OrderCode <> 0 then
  begin
    if MessageDlg(Concat('Deseja excluir o pedido ', IntToStr(OrderCode), '?'), TMsgDlgType.mtConfirmation, [mbYes, mbNo],0) = mrYes then
    begin
      FUseCaseDeleteOrder.Execute(OrderCode);
      MessageDlg('Pedido Excluído com sucesso!', TMsgDlgType.mtConfirmation, [mbOK],0);
    end;
  end;
end;

procedure TfrmViewMain.edPriceItemKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (StrToFloatDef(edPriceItem.Text, 0) > 0) then
    edTotalItem.SetFocus;
end;

procedure TfrmViewMain.edQuantityItemKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (StrToIntDef(edQuantityItem.Text, 0) > 0) then
    edPriceItem.SetFocus;
end;

procedure TfrmViewMain.edSearchProductKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (StrToIntDef(edSearchProduct.Text,0) > 0) then
    imgSearchProduct.OnClick(imgSearchProduct);
end;

procedure TfrmViewMain.edTotalItemKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnAdd.Click;
end;

procedure TfrmViewMain.EnableButtonsOrder(AValue: Boolean);
begin
  btnDeleteOrder.Enabled := AValue;
  btnLoadOrder.Enabled := AValue;
end;

procedure TfrmViewMain.FormCreate(Sender: TObject);
begin
  cdsSearchItem.Close;
  FRepositoryProduct := TRepositoryProductSql.Create(DM.FDConnection1);
  FRepositoryCustomer := TRepositoryCustomerSql.Create(DM.FDConnection1);
  FRepositoryOrderItem := TRepositoryOrderItemSql.Create(DM.FDConnection1);
  FReposotoryOrder := TReposotoryOrderSql.Create(DM.FDConnection1);
  FServiceTable := TServiceTable.Create(DM.FDConnection1);

  FUseCaseProductSearch := TUseCaseProductSearch.Create(FRepositoryProduct);
  FUseCaseProductSearch.AddObserver(Self);
  FUseCaseSaveOrder := TUseCaseSaveOrder.Create(FReposotoryOrder, FRepositoryOrderItem, FServiceTable);
  FUseCaseSearchCustomer := TUseCaseSearchCustomer.Create(FRepositoryCustomer);
  FUseCaseSearchItem := TUseCaseSearchItem.Create(FRepositoryOrderItem);
  FUseCaseDeleteOrder := TUseCaseDeleteOrder.Create(FReposotoryOrder);
  FUseCaseSearchOrder := TUseCaseSearchOrder.Create(FReposotoryOrder, FRepositoryCustomer, FRepositoryOrderItem);

  FCustomerCode := 0;
end;


procedure TfrmViewMain.GridItensKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if cdsListItem.RecordCount > 0 then
  begin
    if Key = VK_DELETE then
    begin
      if MessageDlg('Deseja excluir esse item?', TMsgDlgType.mtConfirmation, [mbYes, mbNo],0) = mrYes then
        cdsListItem.Delete;
    end
    else if Key = VK_RETURN then
    begin
      if MessageDlg('Deseja editar esse item?', TMsgDlgType.mtConfirmation, [mbYes, mbNo],0) = mrYes then
      begin
        dsSearchItem.DataSet := cdsListItem;
        cdsListItem.Edit;
        edQuantityItem.SetFocus;
      end;
    end;
  end;
end;

procedure TfrmViewMain.imgSearchProductClick(Sender: TObject);
begin
  SearchItem;
end;

procedure TfrmViewMain.LoadCustomer(ACustomer: TAbstractionCustomer);
begin
  imgCustomer.Picture.LoadFromFile(ACustomer.PhotoPath);
  lbCustomer.Caption := ACustomer.Name;
  FCustomerCode := ACustomer.Code;
end;

procedure TfrmViewMain.LoadItens(AItem: TAbstractionOrderItem);
begin
  cdsListItem.Append;
  cdsListItem.FieldByName('Code').AsInteger := AItem.ProductCode;
  cdsListItem.FieldByName('Description').AsString := AItem.Description;
  cdsListItem.FieldByName('Price').AsFloat := AItem.Price;
  cdsListItem.FieldByName('Quantity').AsInteger := AItem.Quantity;
  cdsListItem.FieldByName('PhotoPath').AsString := AItem.PhotoPath;
  cdsListItem.FieldByName('Total').AsFloat := AItem.Total;
  cdsListItem.Post;
end;

procedure TfrmViewMain.LoadOrder;
var
  OrderCode: Integer;
  Order: TAbstractionOrder;
  Item: TAbstractionOrderItem;
begin
  OrderCode := TfrmViewSearch.Search(stOrder);
  if OrderCode <> 0 then
  begin
    if MessageDlg(Concat('Deseja carregar o pedido ', IntToStr(OrderCode), '?'), TMsgDlgType.mtConfirmation, [mbYes, mbNo],0) = mrYes then
    begin
      Order := FUseCaseSearchOrder.Execute(OrderCode);
      if Assigned(Order) then
      begin
        LoadCustomer(Order.Customer);
        for Item in Order.Items do
          LoadItens(Item);
      end;
      EnableButtonsOrder(False);
      btnSave.Enabled := False;
      edSearchProduct.Enabled := False;
      btnAdd.Enabled := False;
      GridItens.OnKeyUp := nil;
      MessageDlg('Pedido Carregado com sucesso!', TMsgDlgType.mtConfirmation, [mbOK],0);
    end;
  end;
end;

procedure TfrmViewMain.SaveOrder;
var
  Order: TAbstractionOrder;
  Index: Integer;
  TotalOrder: Double;
begin
  if cdsListItem.RecordCount > 0 then
  begin
    TotalOrder := 0;
    Order := TAbstractionOrder.Create;
    Order.CompletedDate := Now;
    Order.Customer := FCurrentCustomer;

    cdsListItem.First;
    while not cdsListItem.Eof do
    begin
      Index := Order.Items.Add(TAbstractionOrderItem.Create);
      Order.Items.Items[Index].ProductCode := cdsListItem.FieldByName('Code').AsInteger;
      Order.Items.Items[Index].Description := cdsListItem.FieldByName('Description').AsString;
      Order.Items.Items[Index].Quantity := cdsListItem.FieldByName('Quantity').AsInteger;
      Order.Items.Items[Index].Price := cdsListItem.FieldByName('Price').AsFloat;
      Order.Items.Items[Index].Total := cdsListItem.FieldByName('Total').AsFloat;
      TotalOrder := TotalOrder + cdsListItem.FieldByName('Total').AsFloat;
      cdsListItem.Next;
    end;
    Order.Total := TotalOrder;
    FUseCaseSaveOrder.Execute(Order);
    ClearOrder;
    MessageDlg('Pedido salvo com sucesso!', TMsgDlgType.mtConfirmation, [mbOK],0);
  end;
end;

procedure TfrmViewMain.SearchItem;
var
  CustomerCode: Integer;
begin
  if FCustomerCode = 0 then
  begin
    CustomerCode := TfrmViewSearch.Search(stCustomer);
    if CustomerCode <> 0 then
    begin
      FCurrentCustomer := FUseCaseSearchCustomer.Execute(CustomerCode);
      if Assigned(FCurrentCustomer) then
        LoadCustomer(FCurrentCustomer);
      EnableButtonsOrder(False);
    end
    else
    begin
      MessageDlg('Por favor informe um cliente válido!', TMsgDlgType.mtError, [mbOK],0);
      edSearchProduct.SetFocus;
      Exit;
    end;
  end;

  FUseCaseProductSearch.Execute(StrToInt(edSearchProduct.Text));
end;

procedure TfrmViewMain.AlterItem;
begin
  if cdsListItem.State = dsEdit then
    cdsListItem.Post;

  cdsSearchItem.EmptyDataSet;
  edSearchProduct.Text := EmptyStr;
  edSearchProduct.SetFocus;
  dsSearchItem.DataSet := cdsSearchItem;
end;

procedure TfrmViewMain.UpdateItem(AProduct: RProductSearc);
begin
  cdsSearchItem.Open;
  cdsSearchItem.EmptyDataSet;
  cdsSearchItem.Append;

  cdsSearchItem.FieldByName('Code').AsInteger := AProduct.Code;
  cdsSearchItem.FieldByName('Description').AsString := AProduct.Description;
  cdsSearchItem.FieldByName('Price').AsFloat := AProduct.Price;
  cdsSearchItem.FieldByName('Quantity').AsInteger := 1;
  cdsSearchItem.FieldByName('PhotoPath').AsString := AProduct.PhotoPath;
  cdsSearchItem.Post;

  imgItem.Picture.LoadFromFile(cdsSearchItem.FieldByName('PhotoPath').AsString);

  edQuantityItem.SetFocus;
end;

end.
