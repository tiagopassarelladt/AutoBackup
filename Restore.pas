unit Restore;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FileCtrl, ComCtrls, IBServices;

type
  TFrmRestore = class(TForm)
    GroupBox1: TGroupBox;
    editpathorigem: TEdit;
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    RichEdit1: TRichEdit;
    IBRestoreService1: TIBRestoreService;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRestore: TFrmRestore;
  omodo: string; {ZIP, NORMAL}

implementation
 uses uprincipal;
{$R *.dfm}

procedure TFrmRestore.BitBtn1Click(Sender: TObject);
var n: string;
begin
  if opendialog1.execute then
  begin
    editpathorigem.Text:=opendialog1.filename;
    N:= inttostr(length(editpathorigem.Text));
    //showmessage(n);
    omodo:=uppercase(copy(editpathorigem.Text,strtoint(n)-2,3));
    edit1.text:=ExtractFilePath( OpenDialog1.FileName );
  end;
end;

procedure TFrmRestore.BitBtn2Click(Sender: TObject);
var
 Dir: string;
begin
  if edit1.Text <> '' then
  dir:=edit1.text;

  Dir := 'C:\';
  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],1000) then
 edit1.text := Dir;
end;

procedure TFrmRestore.BitBtn3Click(Sender: TObject);
begin
  if omodo = 'ZIP' then
  begin
    FPrincipalBackup.restauraarquivozip(editpathorigem.Text,edit1.text);
    showmessage('O arquivo foi descompactado em: '+edit1.text+' - Agora preciso que você localize-o e peça para Restaurar novamente');
  end;
  if omodo <> 'ZIP' then
  begin
    DeleteFile(EDIT1.TEXT+'RESTAURADO.FDB');
    with IBRestoreService1 do
    begin
      ServerName := '127.0.0.1';
      LoginPrompt := False;
      Params.Add('user_name=sysdba');
      Params.Add('password=masterkey');
      Active := True;
      try
        Verbose := True;
        Options := [Replace, UseAllSpace];
        PageBuffers := 3000;
        PageSize := 4096;
        DatabaseName.Add(EDIT1.TEXT+'RESTAURADO.FDB');

        BackupFile.Add(EDITPATHORIGEM.TEXT);
        ServiceStart;
        Application.ProcessMessages;
        While not Eof do
        BEGIN
          Application.ProcessMessages;
          RICHEDIT1.Lines.Add(GetNextLine);
          richedit1.SetFocus;
        END;
        ShowMessage('Backup Restaurado com Sucesso!');
        close;
      finally
      Active := False;
     end;
     end;

  end;

end;

end.
