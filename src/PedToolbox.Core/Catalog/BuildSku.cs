namespace PedToolbox.Core.Catalog;

public static class BuildSku
{
    /// <summary>
    /// True when compiled with -p:StoreSku=true (STORE_SKU constant).
    /// Store builds hide pages with FeatureItem.StoreSafe=false and block service Apply.
    /// </summary>
    public static bool IsStoreSku =>
#if STORE_SKU
        true;
#else
        false;
#endif

    public static string Label => IsStoreSku ? "Store" : "Full";
}
