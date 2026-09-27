using System.Windows;
using System.Windows.Controls;
using PedToolbox.Core.Models;

namespace PedToolbox.App.Views;

public partial class OptimizeView : UserControl
{
    private List<WindowsServiceItem> _items = [];

    public OptimizeView()
    {
        InitializeComponent();
        Loaded += (_, _) =>
        {
            ProfileBox.ItemsSource = App.Host.Services.AvailableProfiles();
            if (ProfileBox.Items.Contains("safe")) ProfileBox.SelectedItem = "safe";
            else if (ProfileBox.Items.Count > 0) ProfileBox.SelectedIndex = 0;
        };
    }

    private void ProfileBox_OnSelectionChanged(object sender, SelectionChangedEventArgs e) => Load();
    private void Load_OnClick(object sender, RoutedEventArgs e) => Load();

    private void Load()
    {
        if (ProfileBox.SelectedItem is not string name) return;
        _items = App.Host.Services.LoadProfile(name).ToList();
        Grid.ItemsSource = _items;
        StatusText.Text = $"{_items.Count} services in '{name}'. Existing: {_items.Count(i => i.Exists)}.";
    }

    private void Apply_OnClick(object sender, RoutedEventArgs e)
    {
        if (_items.Count == 0) return;
        var name = ProfileBox.SelectedItem as string ?? "";
        if (name.Equals("tweaked", StringComparison.OrdinalIgnoreCase))
        {
            if (MessageBox.Show(
                    "Tweaked disables many services and can break cameras, Xbox, location, and updates. Continue?",
                    "PED Toolbox", MessageBoxButton.YesNo, MessageBoxImage.Warning) != MessageBoxResult.Yes)
                return;
        }
        else if (MessageBox.Show($"Apply profile '{name}' to matching services?", "PED Toolbox",
                     MessageBoxButton.YesNo) != MessageBoxResult.Yes)
            return;

        var n = App.Host.Services.Apply(_items, useProfileValue: true);
        StatusText.Text = $"Applied {n} changes.";
        Load();
    }

    private void Defaults_OnClick(object sender, RoutedEventArgs e)
    {
        if (_items.Count == 0) return;
        if (MessageBox.Show("Reset listed services to DefaultStartupType from the JSON?", "PED Toolbox",
                MessageBoxButton.YesNo) != MessageBoxResult.Yes) return;
        var n = App.Host.Services.Apply(_items, useProfileValue: false);
        StatusText.Text = $"Restored {n} services toward profile defaults.";
        Load();
    }
}
