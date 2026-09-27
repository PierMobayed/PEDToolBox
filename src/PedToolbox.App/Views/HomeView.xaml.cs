using System.Diagnostics;
using System.Windows;
using System.Windows.Controls;

namespace PedToolbox.App.Views;

public partial class HomeView : UserControl
{
    public HomeView()
    {
        InitializeComponent();
        Loaded += (_, _) => Refresh();
    }

    private void Refresh_OnClick(object sender, RoutedEventArgs e) => Refresh();

    private void Refresh()
    {
        var snap = App.Host.SystemInfo.Capture();
        MachineText.Text = $"{snap.ComputerName}  ·  {snap.UserName}";
        OsText.Text = $"{snap.OsName} ({snap.Architecture})  ·  CPU {snap.CpuName}  ·  up {Format(snap.Uptime)}";
        RamText.Text = $"{snap.AvailableRamGb} GB free of {snap.TotalRamGb} GB";
        DiskText.Text = $"{snap.SystemDrive} {snap.SystemDriveFreeGb} GB free of {snap.SystemDriveTotalGb} GB";
    }

    private static string Format(TimeSpan t) => $"{(int)t.TotalHours}h {t.Minutes}m";

    private void OpenLog_OnClick(object sender, RoutedEventArgs e)
    {
        var dir = System.IO.Path.GetDirectoryName(App.Host.Log.LogFilePath);
        if (dir != null) Process.Start(new ProcessStartInfo { FileName = dir, UseShellExecute = true });
    }
}
