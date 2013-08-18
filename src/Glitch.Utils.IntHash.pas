unit Glitch.Utils.IntHash;

interface

type
  THashEntry = class(TObject)
  private
    FKey: Integer;
    FValue: TObject;
  public
    Next: THashEntry;
    function GetKey: Integer;
    function GetValue: TObject;
    procedure SetValue(avalue: TObject);
    property Key: Integer read GetKey;
    property Value: TObject read GetValue write SetValue;
    constructor Create(const akey: Integer; avalue: TObject);
  end;

  THashEntryTable = array of THashEntry;
  PHashEntryTable = ^THashEntryTable;

  THashTable = class(TObject)
  protected
    FTable: PHashEntryTable;
    FModCount: Integer;
    FCapacity: Integer;
    FThreshHold: Integer;
    FLoadFactor: real;
    FCount: Integer;
    function HashToIndex(const hashCode: Integer): Integer;
    procedure Rehash;
    procedure fSetValue(const Key: Integer; Value: TObject);
    procedure ClearTable(const deleteValues: boolean);
  public
    function ContainsKey(const Key: Integer): boolean;
    function ContainsValue(Value: TObject): boolean;
    function GetValue(const Key: Integer): TObject;
    function SetValue(const Key: Integer; Value: TObject): boolean;
    function Remove(const Key: Integer): TObject;
    function GetCount: Integer;
    property Values[const Key: Integer]: TObject read GetValue write fSetValue;
    property Count: Integer read GetCount;
    function ValueAtPos(i: Integer): TObject;
    constructor Create(initialcapacity: Integer = 10; loadfactor: real = 0.75);
    destructor Destroy; override;
    procedure Clear; virtual;
    procedure DeleteAll; virtual;
  end;

type
  TObjectArray = array of TObject;

  TIntegerHash = class(TObject)
  private
    fHashTable: THashTable;
    FObjs: TObjectArray;
  protected
    procedure fSetValue(const Key: Integer; Value: TObject); virtual;
  public
    function ContainsKey(const Key: Integer): boolean; virtual;
    function ContainsValue(const Value: TObject): boolean; virtual;
    function GetValue(const Key: Integer): TObject; virtual;
    function SetValue(const Key: Integer; Value: TObject): boolean; virtual;
    function Remove(const Key: Integer): TObject; virtual;
    function ValueAtPos(const i: Integer): TObject;
    function GetCount: Integer; virtual;
    property Values[const Key: Integer]: TObject read GetValue write fSetValue;
    property Count: Integer read GetCount;
    constructor Create(const initialcapacity: Integer = 10);
    destructor Destroy; override;
    procedure Clear; virtual;
    procedure DeleteAll; virtual;
  end;

implementation

(* tIntegerHash *)

procedure TIntegerHash.fSetValue(const Key: Integer; Value: TObject);
begin
  SetValue(Key, Value);
end;

function TIntegerHash.ContainsKey(const Key: Integer): boolean;
begin
  result := fHashTable.ContainsKey(Key);
end;

function TIntegerHash.ContainsValue(const Value: TObject): boolean;
begin
  result := fHashTable.ContainsValue(Value)
end;

function TIntegerHash.GetValue(const Key: Integer): TObject;
begin
  result := fHashTable.GetValue(Key);
end;

function TIntegerHash.SetValue(const Key: Integer; Value: TObject): boolean;
begin
  result := fHashTable.SetValue(Key, Value);
  if result then
  begin
    SetLength(FObjs, LengtH(FObjs) + 1);
    FObjs[High(FObjs)] := Value;
  end;
end;

function TIntegerHash.ValueAtPos(const i: Integer): TObject;
begin
  result := FObjs[i];
end;

function TIntegerHash.Remove(const Key: Integer): TObject;
var
  i, j: Integer;
  new: TObjectArray;
begin
  result := fHashTable.Remove(Key);
  if Assigned(result) then
  begin
    j := 0;
    SetLength(new, LengtH(FObjs) - 1);
    for i := 0 to LengtH(FObjs) - 1 do
      if FObjs[i] <> result then
      begin
        new[j] := FObjs[i];
        inc(j);
      end;
    FObjs := new;
  end;
end;

function TIntegerHash.GetCount: Integer;
begin
  result := fHashTable.GetCount;
end;

{$IFNDEF FPC}

constructor TIntegerHash.Create(const initialcapacity: Integer);
begin
  inherited Create;
  fHashTable := THashTable.Create(initialcapacity);

end;

{$ELSE FPC}

constructor TIntegerHash.Create;
begin
  inherited Create;
  fHashTable := THashTable.Create;
end;

constructor TIntegerHash.Create(const initialcapacity: Integer = 10);
begin
  inherited Create;
  fHashTable := THashTable.Create(initialcapacity, 0.75, nil, true);
end;
{$ENDIF FPC}

destructor TIntegerHash.Destroy;
begin
  fHashTable.Destroy;
  inherited Destroy;
end;

procedure TIntegerHash.Clear;
begin
  fHashTable.Clear;
end;

procedure TIntegerHash.DeleteAll;
begin
  fHashTable.DeleteAll;
end;

(* ******** pointer functions ********** *)

// delphi implementation, uses dynamic arrays

function getNewEntryTable(size: Integer): PHashEntryTable;
begin
  new(result);
  SetLength(result^, size);
end;

procedure freeEntryTable(table: PHashEntryTable; oldSize: Integer);
begin
  SetLength(table^, 0);
  dispose(table);
end;

function arrayGet(arr: PHashEntryTable; index: Integer): THashEntry;
begin
  result := arr^[index];
end;

procedure arrayPut(arr: PHashEntryTable; index: Integer; Value: THashEntry);
begin
  arr^[index] := Value;
end;

function THashEntry.GetKey: Integer;
begin
  result := FKey;
end;

function THashEntry.GetValue: TObject;
begin
  result := FValue;
end;

procedure THashEntry.SetValue(avalue: TObject);
begin
  FValue := avalue;
end;

constructor THashEntry.Create(const akey: Integer; avalue: TObject);
begin
  inherited Create;
  FKey := akey;
  FValue := avalue;
  Next := nil;
end;

(* **************** hashtable ************************ *)
function THashTable.HashToIndex(const hashCode: Integer): Integer;
begin
  result := abs(hashCode) mod FCapacity;
end;

procedure THashTable.Rehash;
var
  oldCapacity: Integer;
  oldTable: PHashEntryTable;
  newCapacity: Integer;
  newTable: PHashEntryTable;
  i: Integer;
  index: Integer;
  entry, oldentry: THashEntry;
begin

  oldCapacity := FCapacity;
  newCapacity := oldCapacity * 2 + 1;
  newTable := getNewEntryTable(newCapacity);

  inc(FModCount);
  oldTable := FTable;
  FTable := newTable;
  FCapacity := newCapacity;
  FThreshHold := round(newCapacity * FLoadFactor);

  try

    for i := 0 to oldCapacity - 1 do
    begin
      oldentry := arrayGet(oldTable, i);
      while oldentry <> nil do
      begin
        entry := oldentry;
        oldentry := oldentry.Next;

        index := HashToIndex(entry.Key);
        entry.Next := arrayGet(FTable, index);
        arrayPut(FTable, index, entry);

      end;
    end;
  finally

    freeEntryTable(oldTable, oldCapacity);
  end;

end;

procedure THashTable.fSetValue(const Key: Integer; Value: TObject);
begin
  SetValue(Key, Value);
end;

function THashTable.ContainsKey(const Key: Integer): boolean;
var
  idx: Integer;
  entry: THashEntry;
begin
  idx := HashToIndex(Key);
  result := false;
  entry := arrayGet(FTable, idx);
  while (entry <> nil) and not result do
  begin
    result := Key = entry.Key;
    entry := entry.Next;
  end;
end;

function THashTable.ContainsValue(Value: TObject): boolean;
var
  idx: Integer;
  entry: THashEntry;
begin
  result := false;
  for idx := 0 to FCapacity - 1 do
  begin
    entry := arrayGet(FTable, idx);
    while (entry <> nil) and not result do
    begin
      result := Value = entry.Value;
      entry := entry.Next;
    end;
    if result then
      break;
  end;
end;

function THashTable.ValueAtPos(i: Integer): TObject;
var
  entry: THashEntry;
begin
  result := nil;
  entry := arrayGet(FTable, i);
  if Assigned(entry) then
    result := entry.Value;
end;

function THashTable.GetValue(const Key: Integer): TObject;
var
  idx: Integer;
  entry: THashEntry;
begin
  idx := HashToIndex(Key);
  result := nil;
  entry := arrayGet(FTable, idx);
  while (entry <> nil) do
  begin
    if Key = entry.Key then
    begin
      result := entry.Value;
      break;
    end;
    entry := entry.Next;
  end;
end;

function THashTable.SetValue(const Key: Integer; Value: TObject): boolean;
var
  idx: Integer;
  entry: THashEntry;
begin

  // first try to find key in the table and replace the value
  idx := HashToIndex(Key);
  entry := arrayGet(FTable, idx);
  while entry <> nil do
  begin
    if Key = entry.Key then
    begin
      result := false;
      entry.Value := Value;
      exit;
    end;
    entry := entry.Next;
  end;

  // inserting new key-value pair
  inc(FModCount);
  if FCount > FThreshHold then
    Rehash;

  idx := HashToIndex(Key);
  entry := THashEntry.Create(Key, Value);
  entry.Next := arrayGet(FTable, idx);
  arrayPut(FTable, idx, entry);
  inc(FCount);
  result := true;

end;

function THashTable.Remove(const Key: Integer): TObject;
var
  idx: Integer;
  entry: THashEntry;
  preventry: THashEntry;
begin

  idx := HashToIndex(Key);
  entry := arrayGet(FTable, idx);
  result := nil;
  preventry := nil;
  while entry <> nil do
  begin
    if Key = entry.Key then
    begin
      inc(FModCount);
      result := entry.Value;
      if preventry = nil then
        arrayPut(FTable, idx, entry.Next)
      else
        preventry.Next := entry.Next;
      entry.free;
      dec(FCount);
      break;
    end;
    preventry := entry;
    entry := entry.Next;
  end;

end;

function THashTable.GetCount: Integer;
begin
  result := FCount;
end;

constructor THashTable.Create(initialcapacity: Integer = 10; loadfactor: real = 0.75);
begin
  inherited Create;
  FLoadFactor := loadfactor;
  FTable := getNewEntryTable(initialcapacity);
  FCapacity := initialcapacity;
  FThreshHold := round(FCapacity * FLoadFactor);
  FCount := 0;
  FModCount := 0;
end;

destructor THashTable.Destroy;
begin
  Clear;
  freeEntryTable(FTable, FCapacity);
  inherited;
end;

procedure THashTable.Clear;
begin
  ClearTable(false);
end;

procedure THashTable.DeleteAll;
begin
  ClearTable(true);
end;

procedure THashTable.ClearTable(const deleteValues: boolean);
var
  idx: Integer;
  entry: THashEntry;
  temp: THashEntry;
begin
  for idx := 0 to FCapacity - 1 do
  begin
    entry := arrayGet(FTable, idx);
    while entry <> nil do
    begin
      temp := entry;
      entry := entry.Next;
      if deleteValues then
        temp.Value.free;
      temp.free;
    end;
    arrayPut(FTable, idx, nil);
  end;
end;

end.
