// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/TerrainEngine/Splatmap/Standard Tessellation-AddPass" {
	Properties
	{
		// set by terrain engine
		[HideInInspector] _Control ("Control (RGBA)", 2D) = "red" {}
		[HideInInspector] _Splat3 ("Layer 3 (A)", 2D) = "white" {}
		[HideInInspector] _Splat2 ("Layer 2 (B)", 2D) = "white" {}
		[HideInInspector] _Splat1 ("Layer 1 (G)", 2D) = "white" {}
		[HideInInspector] _Splat0 ("Layer 0 (R)", 2D) = "white" {}
		[HideInInspector] _Normal3 ("Normal 3 (A)", 2D) = "bump" {}
		[HideInInspector] _Normal2 ("Normal 2 (B)", 2D) = "bump" {}
		[HideInInspector] _Normal1 ("Normal 1 (G)", 2D) = "bump" {}
		[HideInInspector] _Normal0 ("Normal 0 (R)", 2D) = "bump" {}

		_Parallax ("Height", Range (0.0, 1.0)) = 0.5
        _EdgeLength ("Edge length", Range(3,50)) = 10
	}

	SubShader
	{
		Tags
		{
			"SplatCount" = "4"
			"Queue" = "Geometry-99"
			"IgnoreProjector"="True"
			"RenderType" = "Opaque"
		}

		
	// ------------------------------------------------------------
	// Surface shader code generated out of a CGPROGRAM block:
	

	// ---- forward rendering base pass:
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
		Blend One One ZWrite Off

CGPROGRAM
// compile directives
#pragma vertex tessvert_surf
#pragma fragment frag_surf
#pragma hull hs_surf
#pragma domain ds_surf
#pragma multi_compile_fog
#pragma target 3.0
#pragma exclude_renderers gles
#pragma multi_compile __ _TERRAIN_NORMAL_MAP
#pragma multi_compile_fwdbase nodirlightmap
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// -------- variant for: <when no other keywords are defined>
#if !defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(FOG_LINEAR) && !defined(_TERRAIN_NORMAL_MAP)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: no
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: no
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
// no lightmaps:
#ifdef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  half3 worldNormal : TEXCOORD3;
  float3 worldPos : TEXCOORD4;
  #if UNITY_SHOULD_SAMPLE_SH
  half3 sh : TEXCOORD5; // SH
  #endif
  SHADOW_COORDS(6)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD7;
  #endif
};
#endif
// with lightmaps:
#ifndef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  half3 worldNormal : TEXCOORD3;
  float3 worldPos : TEXCOORD4;
  float4 lmap : TEXCOORD5;
  SHADOW_COORDS(6)
};
#endif

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  #if !defined(LIGHTMAP_OFF) && defined(DIRLIGHTMAP_COMBINED)
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  #endif
  #if !defined(LIGHTMAP_OFF) && defined(DIRLIGHTMAP_COMBINED)
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  #endif
  o.worldPos = worldPos;
  o.worldNormal = worldNormal;
  #ifndef DYNAMICLIGHTMAP_OFF
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
  #endif
  #ifndef LIGHTMAP_OFF
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #endif

  // SH/ambient and vertex lights
  #ifdef LIGHTMAP_OFF
    #if UNITY_SHOULD_SAMPLE_SH
      o.sh = 0;
      // Approximated illumination from non-important point lights
      #ifdef VERTEXLIGHT_ON
        o.sh += Shade4PointLights (
          unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
          unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
          unity_4LightAtten0, worldPos, worldNormal);
      #endif
      o.sh = ShadeSHPerVertex (worldNormal, o.sh);
    #endif
  #endif // LIGHTMAP_OFF

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);
  o.Normal = IN.worldNormal;
  normalWorldVertex = IN.worldNormal;

  // call surface function
  surf (surfIN, o);

  // compute lighting & shadowing factor
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  // Call GI (lightmaps/SH/reflections) lighting function
  UnityGIInput giInput;
  UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
  giInput.light = gi.light;
  giInput.worldPos = worldPos;
  giInput.worldViewDir = worldViewDir;
  giInput.atten = atten;
  #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
    giInput.lightmapUV = IN.lmap;
  #else
    giInput.lightmapUV = 0.0;
  #endif
  #if UNITY_SHOULD_SAMPLE_SH
    giInput.ambient = IN.sh;
  #else
    giInput.ambient.rgb = 0.0;
  #endif
  giInput.probeHDR[0] = unity_SpecCube0_HDR;
  giInput.probeHDR[1] = unity_SpecCube1_HDR;
  #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMin[0] = unity_SpecCube0_BoxMin; // .w holds lerp value for blending
  #endif
  #if UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMax[0] = unity_SpecCube0_BoxMax;
    giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
    giInput.boxMax[1] = unity_SpecCube1_BoxMax;
    giInput.boxMin[1] = unity_SpecCube1_BoxMin;
    giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
  #endif
  LightingStandard_GI(o, giInput, gi);

  // realtime lighting: call lighting function
  c += LightingStandard (o, worldViewDir, gi);
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: FOG_LINEAR 
#if defined(FOG_LINEAR) && !defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(_TERRAIN_NORMAL_MAP)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: no
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: no
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
// no lightmaps:
#ifdef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  half3 worldNormal : TEXCOORD3;
  float3 worldPos : TEXCOORD4;
  #if UNITY_SHOULD_SAMPLE_SH
  half3 sh : TEXCOORD5; // SH
  #endif
  SHADOW_COORDS(6)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD7;
  #endif
};
#endif
// with lightmaps:
#ifndef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  half3 worldNormal : TEXCOORD3;
  float3 worldPos : TEXCOORD4;
  float4 lmap : TEXCOORD5;
  SHADOW_COORDS(6)
};
#endif

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  #if !defined(LIGHTMAP_OFF) && defined(DIRLIGHTMAP_COMBINED)
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  #endif
  #if !defined(LIGHTMAP_OFF) && defined(DIRLIGHTMAP_COMBINED)
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  #endif
  o.worldPos = worldPos;
  o.worldNormal = worldNormal;
  #ifndef DYNAMICLIGHTMAP_OFF
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
  #endif
  #ifndef LIGHTMAP_OFF
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #endif

  // SH/ambient and vertex lights
  #ifdef LIGHTMAP_OFF
    #if UNITY_SHOULD_SAMPLE_SH
      o.sh = 0;
      // Approximated illumination from non-important point lights
      #ifdef VERTEXLIGHT_ON
        o.sh += Shade4PointLights (
          unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
          unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
          unity_4LightAtten0, worldPos, worldNormal);
      #endif
      o.sh = ShadeSHPerVertex (worldNormal, o.sh);
    #endif
  #endif // LIGHTMAP_OFF

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);
  o.Normal = IN.worldNormal;
  normalWorldVertex = IN.worldNormal;

  // call surface function
  surf (surfIN, o);

  // compute lighting & shadowing factor
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  // Call GI (lightmaps/SH/reflections) lighting function
  UnityGIInput giInput;
  UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
  giInput.light = gi.light;
  giInput.worldPos = worldPos;
  giInput.worldViewDir = worldViewDir;
  giInput.atten = atten;
  #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
    giInput.lightmapUV = IN.lmap;
  #else
    giInput.lightmapUV = 0.0;
  #endif
  #if UNITY_SHOULD_SAMPLE_SH
    giInput.ambient = IN.sh;
  #else
    giInput.ambient.rgb = 0.0;
  #endif
  giInput.probeHDR[0] = unity_SpecCube0_HDR;
  giInput.probeHDR[1] = unity_SpecCube1_HDR;
  #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMin[0] = unity_SpecCube0_BoxMin; // .w holds lerp value for blending
  #endif
  #if UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMax[0] = unity_SpecCube0_BoxMax;
    giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
    giInput.boxMax[1] = unity_SpecCube1_BoxMax;
    giInput.boxMin[1] = unity_SpecCube1_BoxMin;
    giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
  #endif
  LightingStandard_GI(o, giInput, gi);

  // realtime lighting: call lighting function
  c += LightingStandard (o, worldViewDir, gi);
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: FOG_EXP 
#if defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(FOG_LINEAR) && !defined(_TERRAIN_NORMAL_MAP)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: no
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: no
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
// no lightmaps:
#ifdef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  half3 worldNormal : TEXCOORD3;
  float3 worldPos : TEXCOORD4;
  #if UNITY_SHOULD_SAMPLE_SH
  half3 sh : TEXCOORD5; // SH
  #endif
  SHADOW_COORDS(6)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD7;
  #endif
};
#endif
// with lightmaps:
#ifndef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  half3 worldNormal : TEXCOORD3;
  float3 worldPos : TEXCOORD4;
  float4 lmap : TEXCOORD5;
  SHADOW_COORDS(6)
};
#endif

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  #if !defined(LIGHTMAP_OFF) && defined(DIRLIGHTMAP_COMBINED)
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  #endif
  #if !defined(LIGHTMAP_OFF) && defined(DIRLIGHTMAP_COMBINED)
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  #endif
  o.worldPos = worldPos;
  o.worldNormal = worldNormal;
  #ifndef DYNAMICLIGHTMAP_OFF
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
  #endif
  #ifndef LIGHTMAP_OFF
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #endif

  // SH/ambient and vertex lights
  #ifdef LIGHTMAP_OFF
    #if UNITY_SHOULD_SAMPLE_SH
      o.sh = 0;
      // Approximated illumination from non-important point lights
      #ifdef VERTEXLIGHT_ON
        o.sh += Shade4PointLights (
          unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
          unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
          unity_4LightAtten0, worldPos, worldNormal);
      #endif
      o.sh = ShadeSHPerVertex (worldNormal, o.sh);
    #endif
  #endif // LIGHTMAP_OFF

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);
  o.Normal = IN.worldNormal;
  normalWorldVertex = IN.worldNormal;

  // call surface function
  surf (surfIN, o);

  // compute lighting & shadowing factor
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  // Call GI (lightmaps/SH/reflections) lighting function
  UnityGIInput giInput;
  UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
  giInput.light = gi.light;
  giInput.worldPos = worldPos;
  giInput.worldViewDir = worldViewDir;
  giInput.atten = atten;
  #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
    giInput.lightmapUV = IN.lmap;
  #else
    giInput.lightmapUV = 0.0;
  #endif
  #if UNITY_SHOULD_SAMPLE_SH
    giInput.ambient = IN.sh;
  #else
    giInput.ambient.rgb = 0.0;
  #endif
  giInput.probeHDR[0] = unity_SpecCube0_HDR;
  giInput.probeHDR[1] = unity_SpecCube1_HDR;
  #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMin[0] = unity_SpecCube0_BoxMin; // .w holds lerp value for blending
  #endif
  #if UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMax[0] = unity_SpecCube0_BoxMax;
    giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
    giInput.boxMax[1] = unity_SpecCube1_BoxMax;
    giInput.boxMin[1] = unity_SpecCube1_BoxMin;
    giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
  #endif
  LightingStandard_GI(o, giInput, gi);

  // realtime lighting: call lighting function
  c += LightingStandard (o, worldViewDir, gi);
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: FOG_EXP2 
#if defined(FOG_EXP2) && !defined(FOG_EXP) && !defined(FOG_LINEAR) && !defined(_TERRAIN_NORMAL_MAP)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: no
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: no
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
// no lightmaps:
#ifdef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  half3 worldNormal : TEXCOORD3;
  float3 worldPos : TEXCOORD4;
  #if UNITY_SHOULD_SAMPLE_SH
  half3 sh : TEXCOORD5; // SH
  #endif
  SHADOW_COORDS(6)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD7;
  #endif
};
#endif
// with lightmaps:
#ifndef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  half3 worldNormal : TEXCOORD3;
  float3 worldPos : TEXCOORD4;
  float4 lmap : TEXCOORD5;
  SHADOW_COORDS(6)
};
#endif

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  #if !defined(LIGHTMAP_OFF) && defined(DIRLIGHTMAP_COMBINED)
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  #endif
  #if !defined(LIGHTMAP_OFF) && defined(DIRLIGHTMAP_COMBINED)
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  #endif
  o.worldPos = worldPos;
  o.worldNormal = worldNormal;
  #ifndef DYNAMICLIGHTMAP_OFF
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
  #endif
  #ifndef LIGHTMAP_OFF
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #endif

  // SH/ambient and vertex lights
  #ifdef LIGHTMAP_OFF
    #if UNITY_SHOULD_SAMPLE_SH
      o.sh = 0;
      // Approximated illumination from non-important point lights
      #ifdef VERTEXLIGHT_ON
        o.sh += Shade4PointLights (
          unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
          unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
          unity_4LightAtten0, worldPos, worldNormal);
      #endif
      o.sh = ShadeSHPerVertex (worldNormal, o.sh);
    #endif
  #endif // LIGHTMAP_OFF

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);
  o.Normal = IN.worldNormal;
  normalWorldVertex = IN.worldNormal;

  // call surface function
  surf (surfIN, o);

  // compute lighting & shadowing factor
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  // Call GI (lightmaps/SH/reflections) lighting function
  UnityGIInput giInput;
  UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
  giInput.light = gi.light;
  giInput.worldPos = worldPos;
  giInput.worldViewDir = worldViewDir;
  giInput.atten = atten;
  #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
    giInput.lightmapUV = IN.lmap;
  #else
    giInput.lightmapUV = 0.0;
  #endif
  #if UNITY_SHOULD_SAMPLE_SH
    giInput.ambient = IN.sh;
  #else
    giInput.ambient.rgb = 0.0;
  #endif
  giInput.probeHDR[0] = unity_SpecCube0_HDR;
  giInput.probeHDR[1] = unity_SpecCube1_HDR;
  #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMin[0] = unity_SpecCube0_BoxMin; // .w holds lerp value for blending
  #endif
  #if UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMax[0] = unity_SpecCube0_BoxMax;
    giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
    giInput.boxMax[1] = unity_SpecCube1_BoxMax;
    giInput.boxMin[1] = unity_SpecCube1_BoxMin;
    giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
  #endif
  LightingStandard_GI(o, giInput, gi);

  // realtime lighting: call lighting function
  c += LightingStandard (o, worldViewDir, gi);
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: _TERRAIN_NORMAL_MAP 
#if defined(_TERRAIN_NORMAL_MAP) && !defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(FOG_LINEAR)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: YES
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
// no lightmaps:
#ifdef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float4 tSpace0 : TEXCOORD3;
  float4 tSpace1 : TEXCOORD4;
  float4 tSpace2 : TEXCOORD5;
  #if UNITY_SHOULD_SAMPLE_SH
  half3 sh : TEXCOORD6; // SH
  #endif
  SHADOW_COORDS(7)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD8;
  #endif
};
#endif
// with lightmaps:
#ifndef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float4 tSpace0 : TEXCOORD3;
  float4 tSpace1 : TEXCOORD4;
  float4 tSpace2 : TEXCOORD5;
  float4 lmap : TEXCOORD6;
  SHADOW_COORDS(7)
};
#endif

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  #ifndef DYNAMICLIGHTMAP_OFF
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
  #endif
  #ifndef LIGHTMAP_OFF
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #endif

  // SH/ambient and vertex lights
  #ifdef LIGHTMAP_OFF
    #if UNITY_SHOULD_SAMPLE_SH
      o.sh = 0;
      // Approximated illumination from non-important point lights
      #ifdef VERTEXLIGHT_ON
        o.sh += Shade4PointLights (
          unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
          unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
          unity_4LightAtten0, worldPos, worldNormal);
      #endif
      o.sh = ShadeSHPerVertex (worldNormal, o.sh);
    #endif
  #endif // LIGHTMAP_OFF

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);

  // compute lighting & shadowing factor
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  // Call GI (lightmaps/SH/reflections) lighting function
  UnityGIInput giInput;
  UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
  giInput.light = gi.light;
  giInput.worldPos = worldPos;
  giInput.worldViewDir = worldViewDir;
  giInput.atten = atten;
  #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
    giInput.lightmapUV = IN.lmap;
  #else
    giInput.lightmapUV = 0.0;
  #endif
  #if UNITY_SHOULD_SAMPLE_SH
    giInput.ambient = IN.sh;
  #else
    giInput.ambient.rgb = 0.0;
  #endif
  giInput.probeHDR[0] = unity_SpecCube0_HDR;
  giInput.probeHDR[1] = unity_SpecCube1_HDR;
  #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMin[0] = unity_SpecCube0_BoxMin; // .w holds lerp value for blending
  #endif
  #if UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMax[0] = unity_SpecCube0_BoxMax;
    giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
    giInput.boxMax[1] = unity_SpecCube1_BoxMax;
    giInput.boxMin[1] = unity_SpecCube1_BoxMin;
    giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
  #endif
  LightingStandard_GI(o, giInput, gi);

  // realtime lighting: call lighting function
  c += LightingStandard (o, worldViewDir, gi);
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: _TERRAIN_NORMAL_MAP FOG_LINEAR 
#if defined(_TERRAIN_NORMAL_MAP) && defined(FOG_LINEAR) && !defined(FOG_EXP) && !defined(FOG_EXP2)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: YES
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
// no lightmaps:
#ifdef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float4 tSpace0 : TEXCOORD3;
  float4 tSpace1 : TEXCOORD4;
  float4 tSpace2 : TEXCOORD5;
  #if UNITY_SHOULD_SAMPLE_SH
  half3 sh : TEXCOORD6; // SH
  #endif
  SHADOW_COORDS(7)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD8;
  #endif
};
#endif
// with lightmaps:
#ifndef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float4 tSpace0 : TEXCOORD3;
  float4 tSpace1 : TEXCOORD4;
  float4 tSpace2 : TEXCOORD5;
  float4 lmap : TEXCOORD6;
  SHADOW_COORDS(7)
};
#endif

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  #ifndef DYNAMICLIGHTMAP_OFF
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
  #endif
  #ifndef LIGHTMAP_OFF
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #endif

  // SH/ambient and vertex lights
  #ifdef LIGHTMAP_OFF
    #if UNITY_SHOULD_SAMPLE_SH
      o.sh = 0;
      // Approximated illumination from non-important point lights
      #ifdef VERTEXLIGHT_ON
        o.sh += Shade4PointLights (
          unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
          unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
          unity_4LightAtten0, worldPos, worldNormal);
      #endif
      o.sh = ShadeSHPerVertex (worldNormal, o.sh);
    #endif
  #endif // LIGHTMAP_OFF

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);

  // compute lighting & shadowing factor
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  // Call GI (lightmaps/SH/reflections) lighting function
  UnityGIInput giInput;
  UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
  giInput.light = gi.light;
  giInput.worldPos = worldPos;
  giInput.worldViewDir = worldViewDir;
  giInput.atten = atten;
  #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
    giInput.lightmapUV = IN.lmap;
  #else
    giInput.lightmapUV = 0.0;
  #endif
  #if UNITY_SHOULD_SAMPLE_SH
    giInput.ambient = IN.sh;
  #else
    giInput.ambient.rgb = 0.0;
  #endif
  giInput.probeHDR[0] = unity_SpecCube0_HDR;
  giInput.probeHDR[1] = unity_SpecCube1_HDR;
  #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMin[0] = unity_SpecCube0_BoxMin; // .w holds lerp value for blending
  #endif
  #if UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMax[0] = unity_SpecCube0_BoxMax;
    giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
    giInput.boxMax[1] = unity_SpecCube1_BoxMax;
    giInput.boxMin[1] = unity_SpecCube1_BoxMin;
    giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
  #endif
  LightingStandard_GI(o, giInput, gi);

  // realtime lighting: call lighting function
  c += LightingStandard (o, worldViewDir, gi);
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: _TERRAIN_NORMAL_MAP FOG_EXP 
#if defined(_TERRAIN_NORMAL_MAP) && defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(FOG_LINEAR)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: YES
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
// no lightmaps:
#ifdef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float4 tSpace0 : TEXCOORD3;
  float4 tSpace1 : TEXCOORD4;
  float4 tSpace2 : TEXCOORD5;
  #if UNITY_SHOULD_SAMPLE_SH
  half3 sh : TEXCOORD6; // SH
  #endif
  SHADOW_COORDS(7)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD8;
  #endif
};
#endif
// with lightmaps:
#ifndef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float4 tSpace0 : TEXCOORD3;
  float4 tSpace1 : TEXCOORD4;
  float4 tSpace2 : TEXCOORD5;
  float4 lmap : TEXCOORD6;
  SHADOW_COORDS(7)
};
#endif

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  #ifndef DYNAMICLIGHTMAP_OFF
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
  #endif
  #ifndef LIGHTMAP_OFF
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #endif

  // SH/ambient and vertex lights
  #ifdef LIGHTMAP_OFF
    #if UNITY_SHOULD_SAMPLE_SH
      o.sh = 0;
      // Approximated illumination from non-important point lights
      #ifdef VERTEXLIGHT_ON
        o.sh += Shade4PointLights (
          unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
          unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
          unity_4LightAtten0, worldPos, worldNormal);
      #endif
      o.sh = ShadeSHPerVertex (worldNormal, o.sh);
    #endif
  #endif // LIGHTMAP_OFF

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);

  // compute lighting & shadowing factor
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  // Call GI (lightmaps/SH/reflections) lighting function
  UnityGIInput giInput;
  UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
  giInput.light = gi.light;
  giInput.worldPos = worldPos;
  giInput.worldViewDir = worldViewDir;
  giInput.atten = atten;
  #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
    giInput.lightmapUV = IN.lmap;
  #else
    giInput.lightmapUV = 0.0;
  #endif
  #if UNITY_SHOULD_SAMPLE_SH
    giInput.ambient = IN.sh;
  #else
    giInput.ambient.rgb = 0.0;
  #endif
  giInput.probeHDR[0] = unity_SpecCube0_HDR;
  giInput.probeHDR[1] = unity_SpecCube1_HDR;
  #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMin[0] = unity_SpecCube0_BoxMin; // .w holds lerp value for blending
  #endif
  #if UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMax[0] = unity_SpecCube0_BoxMax;
    giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
    giInput.boxMax[1] = unity_SpecCube1_BoxMax;
    giInput.boxMin[1] = unity_SpecCube1_BoxMin;
    giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
  #endif
  LightingStandard_GI(o, giInput, gi);

  // realtime lighting: call lighting function
  c += LightingStandard (o, worldViewDir, gi);
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: _TERRAIN_NORMAL_MAP FOG_EXP2 
#if defined(_TERRAIN_NORMAL_MAP) && defined(FOG_EXP2) && !defined(FOG_EXP) && !defined(FOG_LINEAR)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: YES
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
// no lightmaps:
#ifdef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float4 tSpace0 : TEXCOORD3;
  float4 tSpace1 : TEXCOORD4;
  float4 tSpace2 : TEXCOORD5;
  #if UNITY_SHOULD_SAMPLE_SH
  half3 sh : TEXCOORD6; // SH
  #endif
  SHADOW_COORDS(7)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD8;
  #endif
};
#endif
// with lightmaps:
#ifndef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float4 tSpace0 : TEXCOORD3;
  float4 tSpace1 : TEXCOORD4;
  float4 tSpace2 : TEXCOORD5;
  float4 lmap : TEXCOORD6;
  SHADOW_COORDS(7)
};
#endif

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  #ifndef DYNAMICLIGHTMAP_OFF
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
  #endif
  #ifndef LIGHTMAP_OFF
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #endif

  // SH/ambient and vertex lights
  #ifdef LIGHTMAP_OFF
    #if UNITY_SHOULD_SAMPLE_SH
      o.sh = 0;
      // Approximated illumination from non-important point lights
      #ifdef VERTEXLIGHT_ON
        o.sh += Shade4PointLights (
          unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
          unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
          unity_4LightAtten0, worldPos, worldNormal);
      #endif
      o.sh = ShadeSHPerVertex (worldNormal, o.sh);
    #endif
  #endif // LIGHTMAP_OFF

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);

  // compute lighting & shadowing factor
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  // Call GI (lightmaps/SH/reflections) lighting function
  UnityGIInput giInput;
  UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
  giInput.light = gi.light;
  giInput.worldPos = worldPos;
  giInput.worldViewDir = worldViewDir;
  giInput.atten = atten;
  #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
    giInput.lightmapUV = IN.lmap;
  #else
    giInput.lightmapUV = 0.0;
  #endif
  #if UNITY_SHOULD_SAMPLE_SH
    giInput.ambient = IN.sh;
  #else
    giInput.ambient.rgb = 0.0;
  #endif
  giInput.probeHDR[0] = unity_SpecCube0_HDR;
  giInput.probeHDR[1] = unity_SpecCube1_HDR;
  #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMin[0] = unity_SpecCube0_BoxMin; // .w holds lerp value for blending
  #endif
  #if UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMax[0] = unity_SpecCube0_BoxMax;
    giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
    giInput.boxMax[1] = unity_SpecCube1_BoxMax;
    giInput.boxMin[1] = unity_SpecCube1_BoxMin;
    giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
  #endif
  LightingStandard_GI(o, giInput, gi);

  // realtime lighting: call lighting function
  c += LightingStandard (o, worldViewDir, gi);
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif


ENDCG

}

	// ---- forward rendering additive lights pass:
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One
		Blend One One ZWrite Off

CGPROGRAM
// compile directives
#pragma vertex tessvert_surf
#pragma fragment frag_surf
#pragma hull hs_surf
#pragma domain ds_surf
#pragma multi_compile_fog
#pragma target 3.0
#pragma exclude_renderers gles
#pragma multi_compile __ _TERRAIN_NORMAL_MAP
#pragma multi_compile_fwdadd_fullshadows nodirlightmap
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// -------- variant for: <when no other keywords are defined>
#if !defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(FOG_LINEAR) && !defined(_TERRAIN_NORMAL_MAP)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: no
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: no
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDADD
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  half3 worldNormal : TEXCOORD3;
  float3 worldPos : TEXCOORD4;
  SHADOW_COORDS(5)
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  o.worldPos = worldPos;
  o.worldNormal = worldNormal;

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);
  o.Normal = IN.worldNormal;
  normalWorldVertex = IN.worldNormal;

  // call surface function
  surf (surfIN, o);
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  gi.light.color *= atten;
  c += LightingStandard (o, worldViewDir, gi);
  c.a = 0.0;
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: FOG_LINEAR 
#if defined(FOG_LINEAR) && !defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(_TERRAIN_NORMAL_MAP)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: no
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: no
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDADD
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  half3 worldNormal : TEXCOORD3;
  float3 worldPos : TEXCOORD4;
  SHADOW_COORDS(5)
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  o.worldPos = worldPos;
  o.worldNormal = worldNormal;

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);
  o.Normal = IN.worldNormal;
  normalWorldVertex = IN.worldNormal;

  // call surface function
  surf (surfIN, o);
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  gi.light.color *= atten;
  c += LightingStandard (o, worldViewDir, gi);
  c.a = 0.0;
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: FOG_EXP 
#if defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(FOG_LINEAR) && !defined(_TERRAIN_NORMAL_MAP)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: no
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: no
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDADD
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  half3 worldNormal : TEXCOORD3;
  float3 worldPos : TEXCOORD4;
  SHADOW_COORDS(5)
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  o.worldPos = worldPos;
  o.worldNormal = worldNormal;

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);
  o.Normal = IN.worldNormal;
  normalWorldVertex = IN.worldNormal;

  // call surface function
  surf (surfIN, o);
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  gi.light.color *= atten;
  c += LightingStandard (o, worldViewDir, gi);
  c.a = 0.0;
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: FOG_EXP2 
#if defined(FOG_EXP2) && !defined(FOG_EXP) && !defined(FOG_LINEAR) && !defined(_TERRAIN_NORMAL_MAP)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: no
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: no
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDADD
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  half3 worldNormal : TEXCOORD3;
  float3 worldPos : TEXCOORD4;
  SHADOW_COORDS(5)
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  o.worldPos = worldPos;
  o.worldNormal = worldNormal;

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);
  o.Normal = IN.worldNormal;
  normalWorldVertex = IN.worldNormal;

  // call surface function
  surf (surfIN, o);
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  gi.light.color *= atten;
  c += LightingStandard (o, worldViewDir, gi);
  c.a = 0.0;
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: _TERRAIN_NORMAL_MAP 
#if defined(_TERRAIN_NORMAL_MAP) && !defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(FOG_LINEAR)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: YES
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDADD
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  fixed3 tSpace0 : TEXCOORD3;
  fixed3 tSpace1 : TEXCOORD4;
  fixed3 tSpace2 : TEXCOORD5;
  float3 worldPos : TEXCOORD6;
  SHADOW_COORDS(7)
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = fixed3(worldTangent.x, worldBinormal.x, worldNormal.x);
  o.tSpace1 = fixed3(worldTangent.y, worldBinormal.y, worldNormal.y);
  o.tSpace2 = fixed3(worldTangent.z, worldBinormal.z, worldNormal.z);
  o.worldPos = worldPos;

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  gi.light.color *= atten;
  c += LightingStandard (o, worldViewDir, gi);
  c.a = 0.0;
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: _TERRAIN_NORMAL_MAP FOG_LINEAR 
#if defined(_TERRAIN_NORMAL_MAP) && defined(FOG_LINEAR) && !defined(FOG_EXP) && !defined(FOG_EXP2)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: YES
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDADD
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  fixed3 tSpace0 : TEXCOORD3;
  fixed3 tSpace1 : TEXCOORD4;
  fixed3 tSpace2 : TEXCOORD5;
  float3 worldPos : TEXCOORD6;
  SHADOW_COORDS(7)
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = fixed3(worldTangent.x, worldBinormal.x, worldNormal.x);
  o.tSpace1 = fixed3(worldTangent.y, worldBinormal.y, worldNormal.y);
  o.tSpace2 = fixed3(worldTangent.z, worldBinormal.z, worldNormal.z);
  o.worldPos = worldPos;

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  gi.light.color *= atten;
  c += LightingStandard (o, worldViewDir, gi);
  c.a = 0.0;
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: _TERRAIN_NORMAL_MAP FOG_EXP 
#if defined(_TERRAIN_NORMAL_MAP) && defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(FOG_LINEAR)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: YES
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDADD
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  fixed3 tSpace0 : TEXCOORD3;
  fixed3 tSpace1 : TEXCOORD4;
  fixed3 tSpace2 : TEXCOORD5;
  float3 worldPos : TEXCOORD6;
  SHADOW_COORDS(7)
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = fixed3(worldTangent.x, worldBinormal.x, worldNormal.x);
  o.tSpace1 = fixed3(worldTangent.y, worldBinormal.y, worldNormal.y);
  o.tSpace2 = fixed3(worldTangent.z, worldBinormal.z, worldNormal.z);
  o.worldPos = worldPos;

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  gi.light.color *= atten;
  c += LightingStandard (o, worldViewDir, gi);
  c.a = 0.0;
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: _TERRAIN_NORMAL_MAP FOG_EXP2 
#if defined(_TERRAIN_NORMAL_MAP) && defined(FOG_EXP2) && !defined(FOG_EXP) && !defined(FOG_LINEAR)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: YES
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_FORWARDADD
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  fixed3 tSpace0 : TEXCOORD3;
  fixed3 tSpace1 : TEXCOORD4;
  fixed3 tSpace2 : TEXCOORD5;
  float3 worldPos : TEXCOORD6;
  SHADOW_COORDS(7)
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos (v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = fixed3(worldTangent.x, worldBinormal.x, worldNormal.x);
  o.tSpace1 = fixed3(worldTangent.y, worldBinormal.y, worldNormal.y);
  o.tSpace2 = fixed3(worldTangent.z, worldBinormal.z, worldNormal.z);
  o.worldPos = worldPos;

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
      gi.light.ndotl = LambertTerm (o.Normal, gi.light.dir);
  #endif
  gi.light.color *= atten;
  c += LightingStandard (o, worldViewDir, gi);
  c.a = 0.0;
  myfinal (surfIN, o, c);
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif


ENDCG

}

	// ---- meta information extraction pass:
	Pass {
		Name "Meta"
		Tags { "LightMode" = "Meta" }
		Cull Off

CGPROGRAM
// compile directives
#pragma vertex tessvert_surf
#pragma fragment frag_surf
#pragma hull hs_surf
#pragma domain ds_surf
#pragma multi_compile_fog
#pragma target 3.0
#pragma exclude_renderers gles
#pragma multi_compile __ _TERRAIN_NORMAL_MAP
#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2 nodirlightmap
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// -------- variant for: <when no other keywords are defined>
#if !defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(FOG_LINEAR) && !defined(_TERRAIN_NORMAL_MAP)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: no
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: no
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_META
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION

#include "UnityMetaPass.cginc"

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float3 worldPos : TEXCOORD3;
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  o.worldPos = worldPos;
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UnityMetaInput metaIN;
  UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
  metaIN.Albedo = o.Albedo;
  metaIN.Emission = o.Emission;
  return UnityMetaFragment(metaIN);
}


#endif

// -------- variant for: FOG_LINEAR 
#if defined(FOG_LINEAR) && !defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(_TERRAIN_NORMAL_MAP)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: no
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: no
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_META
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION

#include "UnityMetaPass.cginc"

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float3 worldPos : TEXCOORD3;
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  o.worldPos = worldPos;
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UnityMetaInput metaIN;
  UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
  metaIN.Albedo = o.Albedo;
  metaIN.Emission = o.Emission;
  return UnityMetaFragment(metaIN);
}


#endif

// -------- variant for: FOG_EXP 
#if defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(FOG_LINEAR) && !defined(_TERRAIN_NORMAL_MAP)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: no
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: no
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_META
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION

#include "UnityMetaPass.cginc"

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float3 worldPos : TEXCOORD3;
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  o.worldPos = worldPos;
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UnityMetaInput metaIN;
  UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
  metaIN.Albedo = o.Albedo;
  metaIN.Emission = o.Emission;
  return UnityMetaFragment(metaIN);
}


#endif

// -------- variant for: FOG_EXP2 
#if defined(FOG_EXP2) && !defined(FOG_EXP) && !defined(FOG_LINEAR) && !defined(_TERRAIN_NORMAL_MAP)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: no
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: no
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_META
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION

#include "UnityMetaPass.cginc"

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float3 worldPos : TEXCOORD3;
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  o.worldPos = worldPos;
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UnityMetaInput metaIN;
  UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
  metaIN.Albedo = o.Albedo;
  metaIN.Emission = o.Emission;
  return UnityMetaFragment(metaIN);
}


#endif

// -------- variant for: _TERRAIN_NORMAL_MAP 
#if defined(_TERRAIN_NORMAL_MAP) && !defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(FOG_LINEAR)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: YES
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_META
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION

#include "UnityMetaPass.cginc"

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float4 tSpace0 : TEXCOORD3;
  float4 tSpace1 : TEXCOORD4;
  float4 tSpace2 : TEXCOORD5;
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UnityMetaInput metaIN;
  UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
  metaIN.Albedo = o.Albedo;
  metaIN.Emission = o.Emission;
  return UnityMetaFragment(metaIN);
}


#endif

// -------- variant for: _TERRAIN_NORMAL_MAP FOG_LINEAR 
#if defined(_TERRAIN_NORMAL_MAP) && defined(FOG_LINEAR) && !defined(FOG_EXP) && !defined(FOG_EXP2)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: YES
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_META
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION

#include "UnityMetaPass.cginc"

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float4 tSpace0 : TEXCOORD3;
  float4 tSpace1 : TEXCOORD4;
  float4 tSpace2 : TEXCOORD5;
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UnityMetaInput metaIN;
  UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
  metaIN.Albedo = o.Albedo;
  metaIN.Emission = o.Emission;
  return UnityMetaFragment(metaIN);
}


#endif

// -------- variant for: _TERRAIN_NORMAL_MAP FOG_EXP 
#if defined(_TERRAIN_NORMAL_MAP) && defined(FOG_EXP) && !defined(FOG_EXP2) && !defined(FOG_LINEAR)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: YES
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_META
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION

#include "UnityMetaPass.cginc"

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float4 tSpace0 : TEXCOORD3;
  float4 tSpace1 : TEXCOORD4;
  float4 tSpace2 : TEXCOORD5;
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UnityMetaInput metaIN;
  UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
  metaIN.Albedo = o.Albedo;
  metaIN.Emission = o.Emission;
  return UnityMetaFragment(metaIN);
}


#endif

// -------- variant for: _TERRAIN_NORMAL_MAP FOG_EXP2 
#if defined(_TERRAIN_NORMAL_MAP) && defined(FOG_EXP2) && !defined(FOG_EXP) && !defined(FOG_LINEAR)
// Surface shader code generated based on:
// vertex modifier: 'TessDisplacement'
// writes to per-pixel normal: YES
// writes to emission: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 5 texcoords actually used
//   float2 _Splat0
//   float2 _Splat1
//   float2 _Splat2
//   float2 _Splat3
//   float2 _Control
#define UNITY_PASS_META
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 27 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

		// As we can't blend normals in g-buffer, this shader will not work in standard deferred path. 
		// So we use exclude_path:deferred to force it to only use the forward path.
		//#pragma surface surf Standard decal:add vertex:SplatmapVert finalcolor:myfinal exclude_path:prepass fullforwardshadows tessellate:SplatmapTess vertex:TessDisplacement nodirlightmap
		//#pragma multi_compile_fog
		//#pragma target 3.0
		// needs more than 8 texcoords
		//#pragma exclude_renderers gles
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"

		//#pragma multi_compile __ _TERRAIN_NORMAL_MAP

		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#include "TerrainSplatmapTess.cginc"

		half _Metallic0;
		half _Metallic1;
		half _Metallic2;
		half _Metallic3;
		
		half _Smoothness0;
		half _Smoothness1;
		half _Smoothness2;
		half _Smoothness3;

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			half4 splat_control;
			half weight;
			fixed3 mixedDiffuse;
			fixed2 smooth_metallic;
			SplatmapMix(IN, splat_control, weight, mixedDiffuse, o.Normal, smooth_metallic);

			o.Albedo = mixedDiffuse;
			o.Alpha = weight;
			o.Smoothness = smooth_metallic.x;
			o.Metallic = smooth_metallic.y;
		}

		void myfinal(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
			SplatmapApplyWeight(color, o.Alpha);
			SplatmapApplyFog(color, IN);
		}

		

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_appdata {
  float4 vertex : INTERNALTESSPOS;
  float3 normal : NORMAL;
  float4 tangent : COLOR;
  float2 texcoord : TEXCOORD0;
  float2 texcoord1 : TEXCOORD1;
  float2 texcoord2 : TEXCOORD2;
};
InternalTessInterp_appdata tessvert_surf (appdata v) {
  InternalTessInterp_appdata o;
  o.vertex = v.vertex;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.texcoord = v.texcoord;
  o.texcoord1 = v.texcoord1;
  o.texcoord2 = v.texcoord2;
  return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf (InputPatch<InternalTessInterp_appdata,3> v) {
  UnityTessellationFactors o;
  float4 tf;
  appdata vi[3];
  vi[0].vertex = v[0].vertex;
  vi[0].normal = v[0].normal;
  vi[0].tangent = v[0].tangent;
  vi[0].texcoord = v[0].texcoord;
  vi[0].texcoord1 = v[0].texcoord1;
  vi[0].texcoord2 = v[0].texcoord2;
  vi[1].vertex = v[1].vertex;
  vi[1].normal = v[1].normal;
  vi[1].tangent = v[1].tangent;
  vi[1].texcoord = v[1].texcoord;
  vi[1].texcoord1 = v[1].texcoord1;
  vi[1].texcoord2 = v[1].texcoord2;
  vi[2].vertex = v[2].vertex;
  vi[2].normal = v[2].normal;
  vi[2].tangent = v[2].tangent;
  vi[2].texcoord = v[2].texcoord;
  vi[2].texcoord1 = v[2].texcoord1;
  vi[2].texcoord2 = v[2].texcoord2;
  tf = SplatmapTess(vi[0], vi[1], vi[2]);
  o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
  return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs_surf (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
  return v[id];
}

#endif // UNITY_CAN_COMPILE_TESSELLATION

#include "UnityMetaPass.cginc"

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _Splat0 _Splat1
  float4 pack1 : TEXCOORD1; // _Splat2 _Splat3
  float2 pack2 : TEXCOORD2; // _Control
  float4 tSpace0 : TEXCOORD3;
  float4 tSpace1 : TEXCOORD4;
  float4 tSpace2 : TEXCOORD5;
};

// vertex shader
v2f_surf vert_surf (appdata v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Control);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  return o;
}

#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation domain shader
[UNITY_domain("tri")]
v2f_surf ds_surf (UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
  appdata v;
  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
  v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
  v.texcoord = vi[0].texcoord*bary.x + vi[1].texcoord*bary.y + vi[2].texcoord*bary.z;
  v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
  v.texcoord2 = vi[0].texcoord2*bary.x + vi[1].texcoord2*bary.y + vi[2].texcoord2*bary.z;
  TessDisplacement (v);
  v2f_surf o = vert_surf (v);
  return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION


// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_Splat0.x = 1.0;
  surfIN.uv_Splat1.x = 1.0;
  surfIN.uv_Splat2.x = 1.0;
  surfIN.uv_Splat3.x = 1.0;
  surfIN.uv_Control.x = 1.0;
  surfIN.fogCoord.x = 1.0;
  surfIN.uv_Splat0 = IN.pack0.xy;
  surfIN.uv_Splat1 = IN.pack0.zw;
  surfIN.uv_Splat2 = IN.pack1.xy;
  surfIN.uv_Splat3 = IN.pack1.zw;
  surfIN.uv_Control = IN.pack2.xy;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutputStandard o = (SurfaceOutputStandard)0;
  #else
  SurfaceOutputStandard o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Alpha = 0.0;
  o.Occlusion = 1.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UnityMetaInput metaIN;
  UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
  metaIN.Albedo = o.Albedo;
  metaIN.Emission = o.Emission;
  return UnityMetaFragment(metaIN);
}


#endif


ENDCG

}

	// ---- end of surface shader generated code

#LINE 76

	}

	Fallback "Hidden/TerrainEngine/Splatmap/Diffuse-AddPass"
}
