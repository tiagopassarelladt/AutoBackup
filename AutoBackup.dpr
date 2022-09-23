program AutoBackup;

uses
  Forms,
  windows,
  messages,
  dialogs,
  ConfigurarBackup in 'ConfigurarBackup.pas' {FrmConfigurarBackup},
  uzipMain in 'uzipMain.pas' {frmZipMain},
  Restore in 'Restore.pas' {FrmRestore},
  UPrincipal in 'UPrincipal.pas' {FPrincipalBackup};

{$R *.res}
//{SR UAC.res}   <== TROCAR O S POR $

var
 Instancia: THandle;

begin
//  Hwnd := FindWindow (nil, 'Conectiva - Sistema de Backup Automático');

  Instancia:= CreateMutex(nil, false, 'InstanciaIniciada');
  if WaitForSingleObject(Instancia, 0) = wait_Timeout then
  begin
    Application.MessageBox('Atenção. Sistema de Backup Automático já está aberto, verifique no canto inferior direito da tela (do lado do relógio.)','Programa já está aberto',MB_ICONINFORMATION);
    Exit;
  end;

  Application.Initialize;
  Application.Title := 'Conectiva - Sistema de Backup Automático';
  Application.CreateForm(TFPrincipalBackup, FPrincipalBackup);
  Application.CreateForm(TfrmZipMain, frmZipMain);
  Application.Run;
end.
