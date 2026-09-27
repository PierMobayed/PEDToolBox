using System.Windows;
using System.Windows.Controls;
using PedToolbox.Core.Models;

namespace PedToolbox.App.Views;

public partial class PrivacyView : UserControl
{
    private bool _suppress;

    public PrivacyView()
    {
        InitializeComponent();
        Loaded += (_, _) => Reload();
    }

    private void Reload_OnClick(object sender, RoutedEventArgs e) => Reload();

    private void Reload()
    {
        _suppress = true;
        ToggleList.ItemsSource = App.Host.Privacy.Read();
        _suppress = false;
    }

    private void OnToggle(object sender, RoutedEventArgs e)
    {
        if (_suppress) return;
        if (sender is CheckBox { Tag: PrivacyToggle toggle } box)
        {
            var ok = App.Host.Privacy.Apply(toggle, box.IsChecked == true);
            if (!ok)
                MessageBox.Show("Could not write this setting. Try Restart as administrator.", "PED Toolbox");
        }
    }
}
