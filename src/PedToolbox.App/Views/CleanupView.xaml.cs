using System.Windows;
using System.Windows.Controls;
using PedToolbox.Core.Models;

namespace PedToolbox.App.Views;

public partial class CleanupView : UserControl
{
    public CleanupView()
    {
        InitializeComponent();
        Loaded += (_, _) => Refresh();
    }

    private void Refresh_OnClick(object sender, RoutedEventArgs e) => Refresh();
    private void Refresh() => StartupGrid.ItemsSource = App.Host.Cleanup.GetStartupApps();

    private void RemoveStartup_OnClick(object sender, RoutedEventArgs e)
    {
        if (StartupGrid.SelectedItem is not StartupApp app) return;
        if (MessageBox.Show($"Remove {app.Name} from {app.Hive} Run?", "PED Toolbox", MessageBoxButton.YesNo) != MessageBoxResult.Yes)
            return;
        App.Host.Cleanup.RemoveStartupApp(app);
        Refresh();
    }

    private void Temp_OnClick(object sender, RoutedEventArgs e)
    {
        var report = App.Host.Cleanup.CleanUserTemp();
        StatusText.Text = $"{report.Label}: deleted {report.FilesDeleted}, skipped {report.FilesSkipped}, freed {report.BytesFreed / 1024 / 1024} MB";
    }

    private void Bin_OnClick(object sender, RoutedEventArgs e)
    {
        if (MessageBox.Show("Empty the Recycle Bin?", "PED Toolbox", MessageBoxButton.YesNo) != MessageBoxResult.Yes)
            return;
        var report = App.Host.Cleanup.EmptyRecycleBin();
        StatusText.Text = report.Succeeded ? "Recycle Bin emptied." : "Recycle Bin failed.";
    }

    private async void Disk_OnClick(object sender, RoutedEventArgs e)
        => await App.Host.Cleanup.RunDiskCleanupAsync();
}
