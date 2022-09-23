unit ConfigurarBackup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CheckLst, Mask, inifiles, filectrl;

type
  TFrmConfigurarBackup = class(TForm)
    GroupBox1: TGroupBox;
    clbSemana: TCheckListBox;
    sbOk: TSpeedButton;
    sbCancelar: TSpeedButton;
    clbHorarios: TCheckListBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    sbBuscaBase: TSpeedButton;
    eBase1: TEdit;
    Label3: TLabel;
    sbBuscaBase2: TSpeedButton;
    eBase2: TEdit;
    Label4: TLabel;
    sbBuscaBase3: TSpeedButton;
    eBase3: TEdit;
    Label5: TLabel;
    sbBuscaBase4: TSpeedButton;
    eBase4: TEdit;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    eDirBackup1: TEdit;
    Label6: TLabel;
    eDirBackup2: TEdit;
    Label7: TLabel;
    eDirBackup3: TEdit;
    Label8: TLabel;
    eDirBackup4: TEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    BitBtn4: TBitBtn;
    procedure sbBuscaBaseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
    procedure sbOkClick(Sender: TObject);
    procedure sbBuscaBase2Click(Sender: TObject);
    procedure sbBuscaBase3Click(Sender: TObject);
    procedure sbBuscaBase4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private

  public

  end;

var
  FrmConfigurarBackup: TFrmConfigurarBackup;

const
  Dia: array[1..7] of string = ('Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado');

implementation

uses UPrincipal;

{$R *.dfm}

procedure TFrmConfigurarBackup.sbBuscaBase2Click(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    begin
//      Filter := 'FireBird/InterBase Database(*.gdb)|*.gdb';
//      filter :=filter+'FireBird/InterBase Database(*.fdb)|*.fdb';
      if Execute then eBase2.Text := FileName;
    end;

end;

procedure TFrmConfigurarBackup.sbBuscaBase3Click(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    begin
//      Filter := 'FireBird/InterBase Database(*.gdb)|*.gdb';
//      filter :=filter+'FireBird/InterBase Database(*.fdb)|*.fdb';
      if Execute then eBase3.Text := FileName;
    end;

end;

procedure TFrmConfigurarBackup.sbBuscaBase4Click(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    begin
//      Filter := 'FireBird/InterBase Database(*.gdb)|*.gdb';
//      filter :=filter+'FireBird/InterBase Database(*.fdb)|*.fdb';
      if Execute then eBase4.Text := FileName;
    end;

end;

procedure TFrmConfigurarBackup.sbBuscaBaseClick(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    begin
      //Filter := 'FireBird/InterBase Database(*.gdb)|*.gdb';
      //filter :=filter+'FireBird/InterBase Database(*.fdb)|*.fdb';
      if Execute then eBase1.Text := FileName;
    end;
end;

procedure TFrmConfigurarBackup.BitBtn4Click(Sender: TObject);
begin
  if FPrincipalBackup.criaratalho(application.exename, '', extractfilepath(application.exename), 'Conectiva - Sistema de Backup Automático', '') then
  showmessage('Atalho criado com sucesso na inicialização do windows!')
  else
  showmessage('Erro ao criar o atalho.');

end;

procedure TFrmConfigurarBackup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmConfigurarBackup:=nil;
  action:=cafree;
end;

procedure TFrmConfigurarBackup.FormCreate(Sender: TObject);
var
  reg: Tinifile;
  i: integer;

begin
  reg := TInifile.Create(nomearquivocfg);
  try
    begin
      eBase1.Text := reg.ReadString('Agendamento','Base1','C:\CONECTIVASOFT\DADOS\X.FDB');
      eBase2.Text := reg.ReadString('Agendamento','Base2','');
      eBase3.Text := reg.ReadString('Agendamento','Base3','');
      eBase4.Text := reg.ReadString('Agendamento','Base4','');

      eDirBackup1.Text := reg.ReadString('Agendamento','BackupDir1','C:\CONECTIVASOFT\BACKUP_T');
      eDirBackup2.Text := reg.ReadString('Agendamento','BackupDir2','');
      eDirBackup3.Text := reg.ReadString('Agendamento','BackupDir3','');
      eDirBackup4.Text := reg.ReadString('Agendamento','BackupDir4','');
      for i := Low(Dia) to High(Dia) do
      begin
        try
          clbSemana.Checked[i-1] := reg.ReadBool('Agendamento',Dia[i],FALSE);
        except
          on E:Exception do
          Application.MessageBox(Pchar('Erro1.'+#13+
                                       'Contate o administrador do sistema.'+#13+
                                       'Erro:'+#13+e.Message),
                                       'Erro', MB_ICONERROR + MB_OK);
        end;
      end;

      begin
        try
          for i := 0 to (clbHorarios.Items.Count - 1) do
          begin
            try
              clbHorarios.Checked[i] := reg.ReadBool('Agendamento',FormatFloat('00', i) + ':00',FALSE);
            except
              on E:Exception do
              Application.MessageBox(Pchar('Erro2.'+#13+
                                           'Contate o administrador do sistema.'+#13+
                                           'Erro:'+#13+e.Message),
                                           'Erro', MB_ICONERROR + MB_OK);
            end;
          end;
        except
          on E:Exception do
          Application.MessageBox(Pchar('Erro3.'+#13+
                                       'Contate o administrador do sistema.'+#13+
                                       'Erro:'+#13+e.Message),
                                       'Erro', MB_ICONERROR + MB_OK);
        end;
      end;
    end;
  finally
    reg.Free;
  end;
end;

procedure TFrmConfigurarBackup.sbCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmConfigurarBackup.sbOkClick(Sender: TObject);
var
  reg: TInifile;
  i: integer;
begin
  reg := TInifile.Create(nomearquivocfg);
  try
    begin
      reg.WriteString('Agendamento','Base1', eBase1.Text);
      reg.WriteString('Agendamento','Base2', eBase2.Text);
      reg.WriteString('Agendamento','Base3', eBase3.Text);
      reg.WriteString('Agendamento','Base4', eBase4.Text);

      reg.WriteString('Agendamento','BackupDir1', eDirBackup1.Text);
      reg.WriteString('Agendamento','BackupDir2', eDirBackup2.Text);
      reg.WriteString('Agendamento','BackupDir3', eDirBackup3.Text);
      reg.WriteString('Agendamento','BackupDir4', eDirBackup4.Text);

      for i := Low(Dia) to High(Dia) do
        reg.WriteBool('Agendamento',Dia[i], clbSemana.Checked[i-1]);
      begin
        for i := 0 to (clbHorarios.Items.Count - 1) do
          begin
            try
              reg.WriteBool('Agendamento',FormatFloat('00', i) + ':00', clbHorarios.Checked[i]);
            except
              on E:Exception do
              Application.MessageBox(Pchar('Erro1.'+#13+
                                           'Contate o administrador do sistema.'+#13+
                                           'Erro:'+#13+e.Message),
                                           'Erro', MB_ICONERROR + MB_OK);
            end;
          end;
      end;
    end;
  finally
    reg.Free;
  end;
  FPrincipalBackup.carregacfg;
  Close;
end;

procedure TFrmConfigurarBackup.SpeedButton1Click(Sender: TObject);
var
   chosenDirectory : string;
 begin
  // Ask the user to select a required directory, starting with C:
   if SelectDirectory('Selecione o diretório para gravar o backup', 'C:\', chosenDirectory)
   then edirbackup1.text:=chosenDirectory
   else ShowMessage('Seleção de diretório foi cancelada');

end;

procedure TFrmConfigurarBackup.SpeedButton2Click(Sender: TObject);
var
   chosenDirectory : string;
 begin
  // Ask the user to select a required directory, starting with C:
   if SelectDirectory('Selecione o diretório para gravar o backup', 'C:\', chosenDirectory)
   then edirbackup2.text:=chosenDirectory
   else ShowMessage('Seleção de diretório foi cancelada');

end;

procedure TFrmConfigurarBackup.SpeedButton3Click(Sender: TObject);
var
   chosenDirectory : string;
 begin
  // Ask the user to select a required directory, starting with C:
   if SelectDirectory('Selecione o diretório para gravar o backup', 'C:\', chosenDirectory)
   then edirbackup3.text:=chosenDirectory
   else ShowMessage('Seleção de diretório foi cancelada');

end;

procedure TFrmConfigurarBackup.SpeedButton4Click(Sender: TObject);
var
   chosenDirectory : string;
 begin
  // Ask the user to select a required directory, starting with C:
   if SelectDirectory('Selecione o diretório para gravar o backup', 'C:\', chosenDirectory)
   then edirbackup4.text:=chosenDirectory
   else ShowMessage('Seleção de diretório foi cancelada');

end;

end.

