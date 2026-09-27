using System.Windows;
using System.Windows.Controls;
using PedToolbox.Core.Catalog;

namespace PedToolbox.App.Views;

public partial class AboutView : UserControl
{
    public AboutView()
    {
        InitializeComponent();
        TitleText.Text = $"{FeatureCatalog.AppName} {FeatureCatalog.Version}";
        MetaText.Text = $"{FeatureCatalog.Publisher}  ·  {FeatureCatalog.SupportEmail}";
    }

    private void Web_OnClick(object sender, RoutedEventArgs e) => App.Host.Runner.StartDetached(FeatureCatalog.Website);
    private void Git_OnClick(object sender, RoutedEventArgs e) => App.Host.Runner.StartDetached(FeatureCatalog.GitHub);
    private void Mail_OnClick(object sender, RoutedEventArgs e) => App.Host.Runner.StartDetached($"mailto:{FeatureCatalog.SupportEmail}");
}
