unit Domain.Abstraction.Order;

interface
uses Domain.Abstraction.Customer, Domain.Abstraction.OrderItem,
     System.Generics.Collections;

type
TAbstractionOrder = Class
  private
    FCode: Integer;
    FCompletedDate: TDate;
    FTotal: Double;
    FCustomer: TAbstractionCustomer;
    FItems: TList<TAbstractionOrderItem>;
  public
    property Code: Integer read FCode write FCode;
    property CompletedDate: TDate read FCompletedDate write FCompletedDate;
    property Total: Double read FTotal write FTotal;
    property Customer: TAbstractionCustomer read FCustomer write FCustomer;
    property Items: TList<TAbstractionOrderItem> read FItems write FItems;

    Constructor Create;
    Destructor Destroy;override;
End;

implementation

{ TAbstractionOrder }

constructor TAbstractionOrder.Create;
begin
  FItems := TList<TAbstractionOrderItem>.Create;
  FCustomer := TAbstractionCustomer.Create;
end;

destructor TAbstractionOrder.Destroy;
begin
  FItems.Free;
  FCustomer.Free;
  inherited;
end;

end.
