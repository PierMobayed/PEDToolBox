using System.Windows;
using System.Windows.Controls;
using PedToolbox.App.Views;
using PedToolbox.Core.Catalog;
using PedToolbox.Core.Services;

namespace PedToolbox.App;

public partial class MainWindow : Window
{
    public MainWindow()
    {
        InitializeComponent();
        NavList.ItemsSource = FeatureCatalog.All;
        RefreshAdmin();
        NavList.SelectedIndex = 0;
    }

    private void RefreshAdmin()
    {
        var admin = AdminService.IsAdministrator();
        AdminLabel.Text = admin ? "Running as administrator" : "Standard user";
        AdminLabel.Foreground = admin
            ? (System.Windows.Media.Brush)FindResource("AccentBrush")
            : (System.Windows.Media.Brush)FindResource("WarnBrush");
        ElevateButton.Visibility = admin ? Visibility.Collapsed : Visibility.Visible;
    }

    private void ElevateButton_OnClick(object sender, RoutedEventArgs e)
    {
        if (AdminService.RelaunchElevated())
            Application.Current.Shutdown();
        else
            MessageBox.Show("Elevation was cancelled.", "PED Toolbox");
    }

    private void NavList_OnSelectionChanged(object sender, SelectionChangedEventArgs e)
    {
        if (NavList.SelectedItem is not FeatureItem item) return;
        HeaderTitle.Text = item.Title;
        PageHost.Content = CreatePage(item.Id);
    }

    private object CreatePage(string id) => id switch
    {
        "home" => new HomeView(),
        "restore" => new RestoreView(),
        "diagnostics" => new DiagnosticsView(),
        "repair" => new RepairView(),
        "privacy" => new PrivacyView(),
        "apps" => new AppsView(),
        "cleanup" => new CleanupView(),
        "optimize" => new OptimizeView(),
        "toggles" => new TogglesView(),
        "log" => new LogView(),
        "about" => new AboutView(),
        _ => new TextBlock { Text = "Unknown page", Foreground = (System.Windows.Media.Brush)FindResource("MutedBrush") }
    };
}
