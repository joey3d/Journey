Terrain Tessellation Shaders © Sascha Graeff

The provided shaders allow you too create terrains that use DX11 Tessellation.

INSTRUCTIONS
- Create a new material
- Choose shader: UNITY 5: Nature/Terrain/Standard Tessellation
- Set the material as the terrain's material on its settings page

- Use the "Tessellation Terrain Texture Wizard" to create a special texture used for the new Unity 5 shader.
  See "NEW IN UNITY 5.txt" for more informations.
- Use your terrain brush as usual. Set "Height" and "Edge Length" in the material settings.


UNITY 4 USERS...
- Since Unity 5 is automatically upgrading and messing up the older versions of these shaders,
  they're not part of v2 of this package. If you just bought this package and use Unity 4 (which you shouldn't!),
  please contact me via Asset Store about it.


ABOUT TERRAINS AND TESSELLATION...
Unity already performs terrain tessellation, merging polygons that are far enough in the distance.
If areas on a terrain are not using the full resolution, Unity also creates bigger polygons.
This leads to greater edge lengths on, for example, flat areas.
You can notice the effects of this by comparing a the tessellation result on a flat area with a non-flat area.
Long story shot: Ensure your terrains to not have completely flat areas to achieve the best results with this package.


FALLBACKS FOR NON-DX11 USERS
- The shader will fallback to Unity's default "Bumped Specular" terrain shader if DX11 is not available.


USING MORE THAN 4 TEXTURES
Only the textures within the same pass (means textures 1-4, 5-8, and so on) can be blended into each other.
Between textures of different passes (e.g. texture 2 and texture 7), there will be hard edges since there are two geometries
crashing into each other. If you want to know more about this, please read "The AddPass Problem.txt".


KNOWN ISSUES
- Directional Lightmaps are not supported


FUTURE PLANS
- Trying to add different Height/Edge Length settings per texture. Right now, you have to adjust your Heightmaps to fit.


UPDATE CHANGELOGS
- v2
  Rewrote shaders to work with Unity 5
- v1.1 
  Tinkered a lot with AddPass problems (whenever you use more than 4 textures)
  See "USING MORE THAN 4 TEXTURES"
  