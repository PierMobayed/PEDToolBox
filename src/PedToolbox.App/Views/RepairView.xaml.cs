using System.Windows;
using System.Windows.Controls;

namespace PedToolbox.App.Views;

public partial class RepairView : UserControl
{
    public RepairView() => InitializeComponent();

    private void Update_OnClick(object sender, RoutedEventArgs e) => App.Host.Toggles.OpenWindowsUpdate();
    private void Security_OnClick(object sender, RoutedEventArgs e) => App.Host.Toggles.OpenWindowsSecurity();

    private void Sfc_OnClick(object sender, RoutedEventArgs e)
    {
        if (MessageBox.Show("Run sfc /scannow? This can take 10–30 minutes.", "PED Toolbox",
                MessageBoxButton.YesNo, MessageBoxImage.Question) != MessageBoxResult.Yes) return;
        App.Host.Toggles.StartSfc();
    }

    private void Dism_OnClick(object sender, RoutedEventArgs e)
    {
        if (MessageBox.Show("Run DISM RestoreHealth? This can take a long time and needs internet for component store repair.",
                "PED Toolbox", MessageBoxButton.YesNo, MessageBoxImage.Question) != MessageBoxResult.Yes) return;
        App.Host.Toggles.StartDismHealth();
    }
}
