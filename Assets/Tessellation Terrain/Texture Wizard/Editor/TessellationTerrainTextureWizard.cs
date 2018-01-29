using UnityEngine;
using UnityEditor;
using System.IO;

public class TessellationTerrainTextureWizard : EditorWindow
{
    [MenuItem("Assets/Tessellation Terrain Texture Wizard")]
    static void CreateWindow()
    {
        var window = EditorWindow.GetWindow(typeof(TessellationTerrainTextureWizard));
        window.Show();
    }

    Texture2D diffuse;
    Texture2D bump;
    Texture2D smoothness;
    Texture2D metallic;

    void OnGUI()
    {
        TextureField("Diffuse Texture", ref diffuse);
        TextureField("Bump Map (grayscale)", ref bump);
        TextureField("Smoothness Map (grayscale)", ref smoothness);
        TextureField("Metallic Map (grayscale)", ref metallic);

        if(diffuse && GUILayout.Button("Create Tessellation Terrain Texture"))
        {
            CreateTexture();
        }
    }

    private void TextureField(string label, ref Texture2D tex)
    {
        tex = EditorGUILayout.ObjectField(new GUIContent(label), tex, typeof(Texture2D), false) as Texture2D;
    }

    /// <summary>
    /// Makes a texture asset readable (or not) in the editor.
    /// </summary>
    /// <param name="tex">The texture that needs its import settings changed.</param>
    /// <param name="readable">True to make the texture readable, false to make it not readable.</param>
    /// <returns>True if the texture was readable before calling this function, false otherwise.</returns>
    private bool MakeReadable(Texture2D tex, bool readable = true)
    {
        if(!tex) return false;

        var path = AssetDatabase.GetAssetPath(tex);
        var importer = AssetImporter.GetAtPath(path) as TextureImporter;

        if(importer.isReadable == readable)
        {
            return readable;
        }

        importer.isReadable = readable;
        AssetDatabase.ImportAsset(path);

        return !readable;
    }

    private void CreateTexture()
    {
        const string progressbarTitle = "Creating Tessellation Terrain Texture...";
        EditorUtility.DisplayProgressBar(progressbarTitle, "Creating result texture", 0);

        Texture2D result = new Texture2D(diffuse.width, diffuse.height, TextureFormat.RGBA32, true);

        EditorUtility.DisplayProgressBar(progressbarTitle, "Reading diffuse texture", 0.1f);

        bool wasReadable;
        wasReadable = MakeReadable(diffuse);
        var pixels = diffuse.GetPixels(0, 0, diffuse.width, diffuse.height);
        
        var pixels2D = new Color[result.width, result.height];
        for(int y = 0; y < result.height; ++y)
        {
            for(int x = 0; x < result.width; ++x)
            {
                var c = pixels[y * result.width + x];
                c.a = 0;
                pixels2D[x, y] = c;
            }
        }
        MakeReadable(diffuse, wasReadable);

        EditorUtility.DisplayProgressBar(progressbarTitle, "Mapping bump texture", 0.3f);

        wasReadable = MakeReadable(bump);
        ApplyToAlphaChannel(ref pixels2D, bump,
            0, 0,
            result.width / 2, result.height / 2);
        MakeReadable(bump, wasReadable);

        EditorUtility.DisplayProgressBar(progressbarTitle, "Mapping smoothness texture", 0.5f);

        wasReadable = MakeReadable(smoothness);
        ApplyToAlphaChannel(ref pixels2D, smoothness,
            result.width/2, 0,
            result.width / 2, result.height / 2);
        MakeReadable(smoothness, wasReadable);

        EditorUtility.DisplayProgressBar(progressbarTitle, "Mapping metallic texture", 0.7f);

        wasReadable = MakeReadable(metallic);
        ApplyToAlphaChannel(ref pixels2D, metallic,
            0, result.width / 2,
            result.width / 2, result.height / 2);
        MakeReadable(metallic, wasReadable);

        EditorUtility.DisplayProgressBar(progressbarTitle, "Saving result texture", 0.9f);

        for(int i = 0; i < pixels.Length; ++i)
        {
            pixels[i] = pixels2D[i % result.width, i / result.width];
        }

        result.SetPixels(pixels);
        result.Apply();

        SaveTexture(result);

        EditorUtility.ClearProgressBar();
    }

    private void ApplyToAlphaChannel(ref Color[,] pixels2D, Texture2D map, int xStart, int yStart, int width, int height)
    {
        if(!map) return;

        for(int y = 0; y < height; ++y)
        {
            for(int x = 0; x < width; ++x)
            {
                var x2 = ((float)x) / width;
                var y2 = ((float)y) / height;

                pixels2D[xStart + x, yStart + y].a = map.GetPixelBilinear(x2, y2).grayscale;
            }
        }
    }
    
    private void SaveTexture(Texture2D result)
    {
        var originalPath = AssetDatabase.GetAssetPath(diffuse);
        AssetDatabase.CreateAsset(result, Path.ChangeExtension(originalPath, ".TTT.asset"));
    }
}
