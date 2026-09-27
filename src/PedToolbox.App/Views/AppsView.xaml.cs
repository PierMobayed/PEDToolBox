using System.Windows;
using System.Windows.Controls;
using PedToolbox.Core.Models;

namespace PedToolbox.App.Views;

public partial class AppsView : UserControl
{
    private List<InstalledApp> _installed = [];

    public AppsView()
    {
        InitializeComponent();
        Loaded += (_, _) =>
        {
            RefreshInstalled();
            StatusText.Text = App.Host.Winget.IsAvailable()
                ? "winget is available."
                : "winget was not found on PATH. Install App Installer from Microsoft Store.";
        };
    }

    private async void Search_OnClick(object sender, RoutedEventArgs e)
    {
        StatusText.Text = "Searching…";
        var list = await App.Host.Winget.SearchAsync(QueryBox.Text);
        SearchGrid.ItemsSource = list;
        StatusText.Text = $"{list.Count} packages.";
    }

    private async void Install_OnClick(object sender, RoutedEventArgs e)
    {
        if (SearchGrid.SelectedItem is not WingetPackage pkg)
        {
            MessageBox.Show("Select a package in the search grid.");
            return;
        }
        if (MessageBox.Show($"Install {pkg.Id}?", "PED Toolbox", MessageBoxButton.YesNo) != MessageBoxResult.Yes)
            return;
        StatusText.Text = $"Installing {pkg.Id}…";
        var result = await App.Host.Winget.InstallAsync(pkg.Id);
        StatusText.Text = result.Succeeded ? "Install finished." : $"Install exit {result.ExitCode}. See log.";
        RefreshInstalled();
    }

    private async void Upgrade_OnClick(object sender, RoutedEventArgs e)
    {
        if (MessageBox.Show("Upgrade all winget packages?", "PED Toolbox", MessageBoxButton.YesNo) != MessageBoxResult.Yes)
            return;
        StatusText.Text = "Upgrading…";
        var result = await App.Host.Winget.UpgradeAllAsync();
        StatusText.Text = result.Succeeded ? "Upgrade finished." : $"Upgrade exit {result.ExitCode}.";
    }

    private void RefreshInstalled_OnClick(object sender, RoutedEventArgs e) => RefreshInstalled();

    private void RefreshInstalled()
    {
        _installed = App.Host.Apps.ListInstalled().ToList();
        ApplyFilter();
    }

    private void FilterBox_OnTextChanged(object sender, TextChangedEventArgs e) => ApplyFilter();

    private void ApplyFilter()
    {
        var q = FilterBox.Text?.Trim() ?? "";
        InstalledGrid.ItemsSource = string.IsNullOrEmpty(q)
            ? _installed
            : _installed.Where(a => a.DisplayName.Contains(q, StringComparison.OrdinalIgnoreCase)
                                    || a.Publisher.Contains(q, StringComparison.OrdinalIgnoreCase)).ToList();
    }

    private void Uninstall_OnClick(object sender, RoutedEventArgs e)
    {
        if (InstalledGrid.SelectedItem is not InstalledApp app)
        {
            MessageBox.Show("Select a program.");
            return;
        }
        if (MessageBox.Show($"Uninstall {app.DisplayName}?", "PED Toolbox", MessageBoxButton.YesNo, MessageBoxImage.Warning) != MessageBoxResult.Yes)
            return;
        var result = App.Host.Apps.Uninstall(app);
        StatusText.Text = result.Succeeded ? "Uninstall started/finished." : $"Uninstall exit {result.ExitCode}.";
        RefreshInstalled();
    }

    private void SearchGrid_OnMouseDoubleClick(object sender, System.Windows.Input.MouseButtonEventArgs e)
        => Install_OnClick(sender, e);
}
