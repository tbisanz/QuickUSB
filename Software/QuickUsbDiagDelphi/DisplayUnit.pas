unit DisplayUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, QuickUsb;

type
  TDisplay = class(TForm)
    ModuleComboBox: TComboBox;
    Label1: TLabel;
    ReadCommandButton: TButton;
    StringDescriptorEdit: TEdit;
    WriteCommandButton: TButton;
    ReadDataButton: TButton;
    WriteDataButton: TButton;
    WriteRs232Button: TButton;
    ReadRs232Button: TButton;
    ReadSpiButton: TButton;
    WriteSpiButton: TButton;
    procedure ModuleComboBoxChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ReadCommandButtonClick(Sender: TObject);
    procedure WriteCommandButtonClick(Sender: TObject);
    procedure WriteDataButtonClick(Sender: TObject);
    procedure ReadDataButtonClick(Sender: TObject);
    procedure ReadSpiButtonClick(Sender: TObject);
    procedure WriteSpiButtonClick(Sender: TObject);
    procedure ReadRs232ButtonClick(Sender: TObject);
    procedure WriteRs232ButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Display: TDisplay;


implementation

{$R *.DFM}


procedure TDisplay.ModuleComboBoxChange(Sender: TObject);
var hDevice: THandle;
var result: Integer;
var devName, desc: string;
begin
   { Get the device name from the combo box }
   devName := ModuleComboBox.Items[ModuleComboBox.ItemIndex];

   { Open the QuickUSB module }
   result := QuickUsbOpen(@hDevice, PChar(devName));
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot open QuickUSB module ' + devName), PChar('ModuleComboBoxChange'), MB_OK);
   end;

   { Get the string descriptor }
   SetLength(desc, 256);
   result := QuickUsbGetStringDescriptor(hDevice, 2, PChar(desc), length(desc));
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot get string descriptor for ' + devName), PChar('ModuleComboBoxChange'), MB_OK);
   end;

   { Close the module }
   QuickUsbClose(hDevice);

   { Update the text box }
   StringDescriptorEdit.Text := desc;
end;



procedure TDisplay.FormShow(Sender: TObject);
var nameList: TStringList;
begin
   nameList := FindModules;
   if (nameList.Count <> 0) then begin
      ModuleComboBox.Items := namelist;
      ModuleComboBox.ItemIndex := 0;
      ModuleComboBoxChange(Sender);
   end;
end;



procedure TDisplay.ReadCommandButtonClick(Sender: TObject);
var hDevice: THandle;
var result: Integer;
var numRead: Word;
var devName: string;
var data: TByteArray;
begin
   { Get the device name from the combo box }
   devName := ModuleComboBox.Items[ModuleComboBox.ItemIndex];

   { Open the QuickUSB module }
   result := QuickUsbOpen(@hDevice, PChar(devName));
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot open QuickUSB module ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   { Get the string descriptor }
   numRead := 8;
   result := QuickUsbReadCommand(hDevice, 0, @data, @numRead);
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot read command from ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   { Close the module }
   QuickUsbClose(hDevice);
end;



procedure TDisplay.WriteCommandButtonClick(Sender: TObject);
var hDevice: THandle;
var result, index: Integer;
var numWritten: Word;
var devName: string;
var data: TByteArray;
begin
   { Get the device name from the combo box }
   devName := ModuleComboBox.Items[ModuleComboBox.ItemIndex];

   { Open the QuickUSB module }
   result := QuickUsbOpen(@hDevice, PChar(devName));
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot open QuickUSB module ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   { Get the string descriptor }
   for index := 0 to 31 do begin
      data[index] := index;
   end;

   numWritten := 8;
   result := QuickUsbWriteCommand(hDevice, 0, @data, numWritten);
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot write command to ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   { Close the module }
   QuickUsbClose(hDevice);
end;


procedure TDisplay.ReadDataButtonClick(Sender: TObject);
var hDevice: THandle;
var result: Integer;
var numRead: LongWord;
var devName: string;
var data: TByteArray;
begin
   { Get the device name from the combo box }
   devName := ModuleComboBox.Items[ModuleComboBox.ItemIndex];

   { Open the QuickUSB module }
   result := QuickUsbOpen(@hDevice, PChar(devName));
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot open QuickUSB module ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   numRead := 512;
   result := QuickUsbReadData(hDevice, @data, @numRead);
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot read data from ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   { Close the module }
   QuickUsbClose(hDevice);
end;



procedure TDisplay.WriteDataButtonClick(Sender: TObject);
var hDevice: THandle;
var result, index: Integer;
var numWritten: LongWord;
var devName: string;
var data: TByteArray;
begin
   { Get the device name from the combo box }
   devName := ModuleComboBox.Items[ModuleComboBox.ItemIndex];

   { Open the QuickUSB module }
   result := QuickUsbOpen(@hDevice, PChar(devName));
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot open QuickUSB module ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   { Get the string descriptor }
   for index := 0 to 511 do begin
      data[index] := index;
   end;

   numWritten := 512;
   result := QuickUsbWriteData(hDevice, @data, numWritten);
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot write data to ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   { Close the module }
   QuickUsbClose(hDevice);
end;



procedure TDisplay.ReadSpiButtonClick(Sender: TObject);
var hDevice: THandle;
var result: Integer;
var numRead: Word;
var devName: string;
var data: TByteArray;
begin
   { Get the device name from the combo box }
   devName := ModuleComboBox.Items[ModuleComboBox.ItemIndex];

   { Open the QuickUSB module }
   result := QuickUsbOpen(@hDevice, PChar(devName));
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot open QuickUSB module ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   numRead := 8;
   result := QuickUsbReadSpi(hDevice, 0, @data, @numRead);
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot read SPI data from ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   { Close the module }
   QuickUsbClose(hDevice);
end;



procedure TDisplay.WriteSpiButtonClick(Sender: TObject);
var hDevice: THandle;
var result, index: Integer;
var numWritten: Word;
var devName: string;
var data: TByteArray;
begin
   { Get the device name from the combo box }
   devName := ModuleComboBox.Items[ModuleComboBox.ItemIndex];

   { Open the QuickUSB module }
   result := QuickUsbOpen(@hDevice, PChar(devName));
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot open QuickUSB module ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   { Get the string descriptor }
   for index := 0 to 8 do begin
      data[index] := index;
   end;

   numWritten := 8;
   result := QuickUsbWriteSpi(hDevice, 0, @data, numWritten);
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot write SPI data to ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   { Close the module }
   QuickUsbClose(hDevice);
end;



procedure TDisplay.ReadRs232ButtonClick(Sender: TObject);
var hDevice: THandle;
var result: Integer;
var numRead: Word;
var devName: string;
var data: TByteArray;
begin
   { Get the device name from the combo box }
   devName := ModuleComboBox.Items[ModuleComboBox.ItemIndex];

   { Open the QuickUSB module }
   result := QuickUsbOpen(@hDevice, PChar(devName));
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot open QuickUSB module ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   numRead := 8;
   result := QuickUsbReadRs232(hDevice, 0, @data, @numRead);
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot read RS232 data from ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   { Close the module }
   QuickUsbClose(hDevice);
end;

procedure TDisplay.WriteRs232ButtonClick(Sender: TObject);
var hDevice: THandle;
var result, index: Integer;
var numWritten: Word;
var devName: string;
var data: TByteArray;
begin
   { Get the device name from the combo box }
   devName := ModuleComboBox.Items[ModuleComboBox.ItemIndex];

   { Open the QuickUSB module }
   result := QuickUsbOpen(@hDevice, PChar(devName));
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot open QuickUSB module ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   { Get the string descriptor }
   for index := 0 to 8 do begin
      data[index] := index;
   end;

   numWritten := 8;
   result := QuickUsbWriteRs232(hDevice, 0, PChar('Hello'), Length('Hello'));
   if (result = 0) then begin
      Application.MessageBox(PChar('Cannot write RS232 data to ' + devName), PChar('ReadCommandButtonClick'), MB_OK);
   end;

   { Close the module }
   QuickUsbClose(hDevice);
end;

end.
