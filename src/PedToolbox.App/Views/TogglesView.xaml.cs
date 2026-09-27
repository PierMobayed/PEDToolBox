using System.Windows;
using System.Windows.Controls;

namespace PedToolbox.App.Views;

public partial class TogglesView : UserControl
{
    public TogglesView() => InitializeComponent();

    private void HibOn_OnClick(object sender, RoutedEventArgs e)
        => StatusText.Text = $"Hibernate on, exit {App.Host.Toggles.SetHibernate(true).ExitCode}";

    private void HibOff_OnClick(object sender, RoutedEventArgs e)
        => StatusText.Text = $"Hibernate off, exit {App.Host.Toggles.SetHibernate(false).ExitCode}";

    private void Power_OnClick(object sender, RoutedEventArgs e)
        => StatusText.Text = $"Power plan, exit {App.Host.Toggles.EnableUltimatePerformance().ExitCode}";

    private void IdxOn_OnClick(object sender, RoutedEventArgs e)
        => StatusText.Text = $"Indexing on, exit {App.Host.Toggles.SetIndexing(true).ExitCode}";

    private void IdxOff_OnClick(object sender, RoutedEventArgs e)
        => StatusText.Text = $"Indexing off, exit {App.Host.Toggles.SetIndexing(false).ExitCode}";
}
