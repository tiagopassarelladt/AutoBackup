unit uzipMain;
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, FileCtrl, ZipForge;

type
  TfrmZipMain = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    eSrcDir: TEdit;
    Button3: TButton;
    Label2: TLabel;
    eDstDir: TEdit;
    Button4: TButton;
    btnSpanning: TButton;
    eUnpackDir: TEdit;
    Label3: TLabel;
    btnUnpack: TButton;
    eArcName: TEdit;
    Label4: TLabel;
    Button5: TButton;
    Button6: TButton;
    ProgressBar1: TProgressBar;
    Archiver: TZipForge;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure btnSpanningClick(Sender: TObject);
    procedure btnUnpackClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);

    {$IFNDEF VER120}        // Delphi 4
      {$IFNDEF VER125}      // BCB 4
        {$IFNDEF VER130}    // Delphi 5
          {$IFNDEF VER135}  // BCB 5
            {$DEFINE UNICODE}
          {$ENDIF}
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}


    {$IFDEF UNICODE}
    procedure ArchiverFileProgress(Sender: TObject; FileName: WideString;
      Progress: Double; Operation: TZFProcessOperation;
      ProgressPhase: TZFProgressPhase; var Cancel: Boolean);
    {$ELSE}
    procedure ArchiverFileProgress(Sender: TObject; FileName: String;
      Progress: Double; Operation: TZFProcessOperation;
      ProgressPhase: TZFProgressPhase; var Cancel: Boolean);
    {$ENDIF}
  

 
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmZipMain: TfrmZipMain;

implementation

{$R *.dfm}

procedure TfrmZipMain.Button3Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    eSrcDir.Text := OpenDialog1.FileName;
end;

procedure TfrmZipMain.Button4Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    eDstDir.Text := SaveDialog1.FileName;
end;

procedure TfrmZipMain.Button5Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    eArcName.Text := OpenDialog1.FileName;
end;

procedure TfrmZipMain.Button6Click(Sender: TObject);
var Dir: String;
begin
  Dir := '';
  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],0) then
    eUnpackDir.Text := dir;
end;

procedure TfrmZipMain.btnSpanningClick(Sender: TObject);
begin
  with Archiver do begin
    BaseDir := ExtractFileDir(eSrcDir.Text);
{    case cbVolumeSize.ItemIndex of
       0:  SpanningOptions.VolumeSize := vsAutoDetect;
       1:  SpanningOptions.VolumeSize := vs1_44MB;
       2:  SpanningOptions.VolumeSize := vs100MB;
       3:  SpanningOptions.VolumeSize := vs200MB;
       4:  SpanningOptions.VolumeSize := vs250MB;
       5:  SpanningOptions.VolumeSize := vs600MB;
       6:  SpanningOptions.VolumeSize := vs650MB;
       7:  SpanningOptions.VolumeSize := vs700MB;
       else
         begin
           SpanningOptions.VolumeSize := vsCustom;
           SpanningOptions.CustomVolumeSize := StrToInt(cbVolumeSize.Text);
         end;
    end;
    if (Sender as TButton).Tag = 1 then
      SpanningMode := smSpanning
    else
      SpanningMode := smSplitting;}
    FileName := eDstDir.Text;
    OpenArchive(fmCreate);
    AddFiles(eSrcDir.Text);
    CloseArchive;
//    ShowMessage('Archive Creating completed');
    ProgressBar1.Position := 0;
    close;
  end;
end;

procedure TfrmZipMain.btnUnpackClick(Sender: TObject);
begin
  with Archiver do begin
    FileName := eArcName.Text;
    OpenArchive(fmOpenRead + fmShareDenyWrite);
    BaseDir := eUnpackDir.Text;
    ExtractFiles('*.*');
    CloseArchive;
//    ShowMessage('Files extracted successfully');
    ProgressBar1.Position := 0;
    close;
  end;
end;

procedure TfrmZipMain.ArchiverFileProgress;
begin
  ProgressBar1.Position := trunc(Progress);
end;

procedure TfrmZipMain.FormCreate(Sender: TObject);
begin
//  cbVolumeSize.ItemIndex := 0;
end;

end.
