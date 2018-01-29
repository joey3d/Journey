// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

#ifndef TERRAIN_SPLATMAP_TESS_CGINC_INCLUDED
// Upgrade NOTE: excluded shader from DX11 and Xbox360; has structs without semantics (struct appdata members tangent)
#pragma exclude_renderers d3d11 xbox360
#define TERRAIN_SPLATMAP_TESS_CGINC_INCLUDED

struct Input
{
	float2 uv_Splat0 : TEXCOORD0;
	float2 uv_Splat1 : TEXCOORD1;
	float2 uv_Splat2 : TEXCOORD2;
	float2 uv_Splat3 : TEXCOORD3;
	float2 uv_Control : TEXCOORD4;	// Now prefixing '_Control' with 'uv' since tc causes problems
	UNITY_FOG_COORDS(5)
};

struct appdata
{
	float4 vertex : POSITION;
	float3 normal : NORMAL;

    //will throw warnings
	//float4 tangent : TANGENT; 
    //sooooo hacky
    float4 tangent : COLOR;

	float2 texcoord : TEXCOORD0;
	float2 texcoord1 : TEXCOORD1;
	float2 texcoord2 : TEXCOORD2;
    //float2 texcoord3 : TEXCOORD3;
};

sampler2D _Control;
float4 _Control_ST;
sampler2D _Splat0,_Splat1,_Splat2,_Splat3;

#ifdef _TERRAIN_NORMAL_MAP
	sampler2D _Normal0, _Normal1, _Normal2, _Normal3;
#endif

float4 _Splat0_ST, _Splat1_ST, _Splat2_ST, _Splat3_ST;

float _EdgeLength;
float _Parallax;

void SplatmapVert(inout appdata v, out Input data)
{
	UNITY_INITIALIZE_OUTPUT(Input, data);
    //nope, no more manual uv transforming.
    float4 pos = UnityObjectToClipPos (v.vertex);
	UNITY_TRANSFER_FOG(data, pos);
	
#ifdef _TERRAIN_NORMAL_MAP
	v.tangent.xyz = cross(v.normal, float3(0,0,1));
	v.tangent.w = -1;
#endif
}

float Fraction(float x)
{
    return x - floor(x);
}

float2 PartialTexture(float2 texcoord, float4 area)
{
    return float2(Fraction(texcoord.x), Fraction(texcoord.y)) * (area.zw - float2(0.004f, 0.004f)) + area.xy + float2(0.002f, 0.002f);
}

void TessDisplacement(inout appdata v)
{
    fixed4 splat_control = tex2Dlod(_Control, float4(v.texcoord.xy,0,0));
    fixed splatSum = dot(splat_control, fixed4(1,1,1,1));

    float4 bumpPart = float4(0, 0, 0.5f, 0.5f);

    float d;

    d  = splat_control.r * tex2Dlod(_Splat0, float4(PartialTexture(v.texcoord1.xy * _Splat0_ST.xy, bumpPart),0,0)).a;
    d += splat_control.g * tex2Dlod(_Splat1, float4(PartialTexture(v.texcoord1.xy * _Splat1_ST.xy, bumpPart),0,0)).a;
    d += splat_control.b * tex2Dlod(_Splat2, float4(PartialTexture(v.texcoord1.xy * _Splat2_ST.xy, bumpPart),0,0)).a;
    d += splat_control.a * tex2Dlod(_Splat3, float4(PartialTexture(v.texcoord1.xy * _Splat3_ST.xy, bumpPart),0,0)).a;

    /*
    d  = splat_control.r * tex2Dlod(_Splat0, float4(v.texcoord1.xy * _Splat0_ST.xy,0,0)).a;
    d += splat_control.g * tex2Dlod(_Splat1, float4(v.texcoord1.xy * _Splat1_ST.xy,0,0)).a;
    d += splat_control.b * tex2Dlod(_Splat2, float4(v.texcoord1.xy * _Splat2_ST.xy,0,0)).a;
    d += splat_control.a * tex2Dlod(_Splat3, float4(v.texcoord1.xy * _Splat3_ST.xy,0,0)).a;
    */

	float dist = distance(_WorldSpaceCameraPos, v.vertex.xyz);
    d -= (1 - splatSum) * dist * 0.005;
                
    d *= _Parallax;
    //d = (d - 0.5f) * _Parallax;
    v.vertex.xyz += v.normal * d;
}

float4 SplatmapTess(appdata v0, appdata v1, appdata v2)
{
    return UnityEdgeLengthBasedTessCull (v0.vertex, v1.vertex, v2.vertex, _EdgeLength, _Parallax * 1.5f);
}

#ifdef TERRAIN_STANDARD_SHADER
void SplatmapMix(Input IN, out half4 splat_control, out half weight, out fixed3 mixedDiffuse, inout fixed3 mixedNormal, out fixed2 smooth_metallic)
#else
void SplatmapMix(Input IN, out half4 splat_control, out half weight, out fixed4 mixedDiffuse, inout fixed3 mixedNormal)
#endif
{
	splat_control = tex2D(_Control, IN.uv_Control);
	weight = dot(splat_control, half4(1,1,1,1));

	#ifndef UNITY_PASS_DEFERRED
		// Normalize weights before lighting and restore weights in applyWeights function so that the overal
		// lighting result can be correctly weighted.
		// In G-Buffer pass we don't need to do it if Additive blending is enabled.
		// TODO: Normal blending in G-buffer pass...
		splat_control /= (weight + 1e-3f); // avoid NaNs in splat_control
	#endif

    //TODO: Maybe clip on first pass too... like old times
	#if !defined(SHADER_API_MOBILE) && defined(TERRAIN_SPLAT_ADDPASS)
		clip(weight - 0.0039 /*1/255*/);
	#endif

	mixedDiffuse = 0.0f;
	
	#ifdef TERRAIN_STANDARD_SHADER
        float4 mixed = 0.0f;
        mixed += splat_control.r * tex2D(_Splat0, IN.uv_Splat0); // * half4(1.0, 1.0, 1.0, defaultAlpha.r)
		mixed += splat_control.g * tex2D(_Splat1, IN.uv_Splat1);
		mixed += splat_control.b * tex2D(_Splat2, IN.uv_Splat2);
		mixed += splat_control.a * tex2D(_Splat3, IN.uv_Splat3);

        mixedDiffuse = mixed.rgb;

        smooth_metallic = fixed2(0,0);
        float4 smoothArea = float4(0.5f, 0, 0.5f, 0.5f);
        smooth_metallic.x += splat_control.r * tex2Dlod(_Splat0, float4(PartialTexture(IN.uv_Splat0, smoothArea), 0, 0)).a;
		smooth_metallic.x += splat_control.g * tex2Dlod(_Splat1, float4(PartialTexture(IN.uv_Splat1, smoothArea), 0, 0)).a;
		smooth_metallic.x += splat_control.b * tex2Dlod(_Splat2, float4(PartialTexture(IN.uv_Splat2, smoothArea), 0, 0)).a;
		smooth_metallic.x += splat_control.a * tex2Dlod(_Splat3, float4(PartialTexture(IN.uv_Splat3, smoothArea), 0, 0)).a;

        float4 metallicArea = float4(0, 0.5f, 0.5f, 0.5f);
        smooth_metallic.y += splat_control.r * tex2Dlod(_Splat0, float4(PartialTexture(IN.uv_Splat0, metallicArea), 0, 0)).a;
		smooth_metallic.y += splat_control.g * tex2Dlod(_Splat1, float4(PartialTexture(IN.uv_Splat1, metallicArea), 0, 0)).a;
		smooth_metallic.y += splat_control.b * tex2Dlod(_Splat2, float4(PartialTexture(IN.uv_Splat2, metallicArea), 0, 0)).a;
		smooth_metallic.y += splat_control.a * tex2Dlod(_Splat3, float4(PartialTexture(IN.uv_Splat3, metallicArea), 0, 0)).a;
	#else
		mixedDiffuse += splat_control.r * tex2D(_Splat0, IN.uv_Splat0);
		mixedDiffuse += splat_control.g * tex2D(_Splat1, IN.uv_Splat1);
		mixedDiffuse += splat_control.b * tex2D(_Splat2, IN.uv_Splat2);
		mixedDiffuse += splat_control.a * tex2D(_Splat3, IN.uv_Splat3);
	#endif

	#ifdef _TERRAIN_NORMAL_MAP
		fixed4 nrm = 0.0f;
		nrm += splat_control.r * tex2D(_Normal0, IN.uv_Splat0);
		nrm += splat_control.g * tex2D(_Normal1, IN.uv_Splat1);
		nrm += splat_control.b * tex2D(_Normal2, IN.uv_Splat2);
		nrm += splat_control.a * tex2D(_Normal3, IN.uv_Splat3);
		mixedNormal = UnpackNormal(nrm);
		//I have yet to find out why this is needed
		mixedNormal.y = -mixedNormal.y;
	#endif
}

void SplatmapApplyWeight(inout fixed4 color, fixed weight)
{
	color.rgb *= weight;
	color.a = 1.0f;
}

void SplatmapApplyFog(inout fixed4 color, Input IN)
{
	#ifdef TERRAIN_SPLAT_ADDPASS
		UNITY_APPLY_FOG_COLOR(IN.fogCoord, color, fixed4(0,0,0,0));
	#else
		UNITY_APPLY_FOG(IN.fogCoord, color);
	#endif
}

#endif
