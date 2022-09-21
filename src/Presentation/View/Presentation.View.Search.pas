unit Presentation.View.Search;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TSearchType = (stCustomer, stOrder);

  TfrmViewSearch = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    lbTitle: TLabel;
    dsSearch: TDataSource;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure AddResult;
    Class var frmViewSearch: TfrmViewSearch;
    FCodeResult: Integer;
  public
    { Public declarations }
    Class function Search(ASearchType: TSearchType): Integer;
  end;


implementation
uses Data.Repository.DM;

{$R *.dfm}

{ TfrmViewSearch }

procedure TfrmViewSearch.AddResult;
begin
  FCodeResult := frmViewSearch.dsSearch.DataSet.FieldByName('Code').AsInteger;
  Close;
end;

procedure TfrmViewSearch.DBGrid1DblClick(Sender: TObject);
begin
  AddResult;
end;

procedure TfrmViewSearch.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    AddResult;
end;

procedure TfrmViewSearch.FormCreate(Sender: TObject);
begin
  FCodeResult := 0;
end;

class function TfrmViewSearch.Search(ASearchType: TSearchType): Integer;
begin
  frmViewSearch := TfrmViewSearch.Create(Application);
  try
    case ASearchType  of
      stCustomer:
      begin
        frmViewSearch.lbTitle.Caption := 'Informe o Cliente';
        frmViewSearch.dsSearch.DataSet := DM.QSearchCustomer;
        DM.QSearchCustomer.Close;
        DM.QSearchCustomer.Open;
      end;
      stOrder:
      begin
        frmViewSearch.lbTitle.Caption := 'Informe o Pedidos';
        frmViewSearch.dsSearch.DataSet := DM.QSearchOrder;
        DM.QSearchOrder.Close;
        DM.QSearchOrder.Open;
      end;
    end;
    frmViewSearch.ShowModal;
    Result := frmViewSearch.FCodeResult;
  finally
    frmViewSearch.free;
  end;
end;

end.
