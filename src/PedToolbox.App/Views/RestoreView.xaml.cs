using System.Windows;
using System.Windows.Controls;
using PedToolbox.Core.Services;

namespace PedToolbox.App.Views;

public partial class RestoreView : UserControl
{
    public RestoreView()
    {
        InitializeComponent();
        Loaded += (_, _) => Refresh();
    }

    private void Refresh_OnClick(object sender, RoutedEventArgs e) => Refresh();

    private void Refresh()
    {
        PointsGrid.ItemsSource = App.Host.Restore.List();
        StatusText.Text = AdminService.IsAdministrator()
            ? "Administrator: create is enabled."
            : "Standard user: list may work; create needs elevation.";
    }

    private void Create_OnClick(object sender, RoutedEventArgs e)
    {
        var ok = App.Host.Restore.Create(string.IsNullOrWhiteSpace(DescriptionBox.Text)
            ? "PED Toolbox checkpoint"
            : DescriptionBox.Text.Trim());
        StatusText.Text = ok ? "Restore point created." : "Create failed. See Activity log.";
        Refresh();
    }

    private void OpenUi_OnClick(object sender, RoutedEventArgs e)
        => App.Host.Runner.StartDetached("SystemPropertiesProtection.exe");
}
