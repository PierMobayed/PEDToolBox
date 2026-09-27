using System.Windows;
using System.Windows.Controls;

namespace PedToolbox.App.Views;

public partial class LogView : UserControl
{
    public LogView()
    {
        InitializeComponent();
        Loaded += (_, _) => Refresh();
    }

    private void Refresh_OnClick(object sender, RoutedEventArgs e) => Refresh();

    private void Refresh()
    {
        PathText.Text = App.Host.Log.LogFilePath;
        LogBox.Text = string.Join(Environment.NewLine, App.Host.Log.Entries.Select(e => e.ToString()));
    }
}
