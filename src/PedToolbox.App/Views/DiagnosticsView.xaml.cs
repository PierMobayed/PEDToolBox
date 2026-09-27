using System.Text;
using System.Windows;
using System.Windows.Controls;

namespace PedToolbox.App.Views;

public partial class DiagnosticsView : UserControl
{
    public DiagnosticsView()
    {
        InitializeComponent();
        Loaded += (_, _) => Refresh();
    }

    private void Refresh_OnClick(object sender, RoutedEventArgs e) => Refresh();

    private void Refresh()
    {
        var s = App.Host.SystemInfo.Capture();
        var sb = new StringBuilder();
        sb.AppendLine($"{s.ComputerName} \\ {s.UserName}");
        sb.AppendLine($"{s.OsName}  {s.OsVersion}  {s.Architecture}");
        sb.AppendLine($"CPU  {s.CpuName}  ({s.CpuCount} logical)");
        sb.AppendLine($"RAM  {s.AvailableRamGb} / {s.TotalRamGb} GB free");
        sb.AppendLine($"Boot {s.BootTime}  uptime {s.Uptime:g}");
        sb.AppendLine($"Admin {s.IsAdministrator}");
        InfoText.Text = sb.ToString();
        DisksGrid.ItemsSource = App.Host.SystemInfo.GetVolumes();
    }

    private void Msinfo_OnClick(object sender, RoutedEventArgs e)
        => App.Host.Runner.StartDetached("msinfo32.exe");

    private void Speed_OnClick(object sender, RoutedEventArgs e)
        => App.Host.Runner.StartDetached("https://fast.com");
}
