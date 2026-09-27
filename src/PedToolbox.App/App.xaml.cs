using System.Windows;
using System.Windows.Threading;
using PedToolbox.Core;

namespace PedToolbox.App;

public partial class App : Application
{
    public static ToolboxHost Host { get; } = new();

    protected override void OnStartup(StartupEventArgs e)
    {
        DispatcherUnhandledException += OnDispatcherUnhandledException;
        AppDomain.CurrentDomain.UnhandledException += (_, args) =>
        {
            Host.Log.Error("App", "Unhandled", args.ExceptionObject.ToString());
        };
        base.OnStartup(e);
    }

    private void OnDispatcherUnhandledException(object sender, DispatcherUnhandledExceptionEventArgs e)
    {
        Host.Log.Error("App", e.Exception.Message, e.Exception.ToString());
        MessageBox.Show(e.Exception.Message, "PED Toolbox", MessageBoxButton.OK, MessageBoxImage.Error);
        e.Handled = true;
    }
}
