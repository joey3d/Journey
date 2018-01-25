// Upgrade NOTE: upgraded instancing buffer 'NewAmplifyShader' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New AmplifyShader"
{
	Properties
	{
		_N1("N1", 2D) = "bump" {}
		_N2("N2", 2D) = "bump" {}
		_Roughness("Roughness", Float) = 0
		_Color("Color", Color) = (0.299362,0.3401234,0.3602941,0)
		_E3("E3", 2D) = "white" {}
		_E1("E1", 2D) = "white" {}
		_E_Intensity("E_Intensity", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _N2;
		uniform sampler2D _N1;
		uniform sampler2D _E3;
		uniform sampler2D _E1;

		UNITY_INSTANCING_BUFFER_START(NewAmplifyShader)
			UNITY_DEFINE_INSTANCED_PROP(float4, _Color)
#define _Color_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float, _E_Intensity)
#define _E_Intensity_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float, _Roughness)
#define _Roughness_arr NewAmplifyShader
		UNITY_INSTANCING_BUFFER_END(NewAmplifyShader)

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord2 = i.uv_texcoord * float2( 28,28 ) + float2( 0,0 );
			float2 panner1 = ( uv_TexCoord2 + 1.0 * _Time.y * float2( 0.1,-0.05 ));
			float2 panner4 = ( uv_TexCoord2 + 1.0 * _Time.y * float2( -0.125,0.05 ));
			o.Normal = BlendNormals( UnpackNormal( tex2D( _N2, panner1 ) ) , UnpackNormal( tex2D( _N1, panner4 ) ) );
			float4 _Color_Instance = UNITY_ACCESS_INSTANCED_PROP(_Color_arr, _Color);
			o.Albedo = _Color_Instance.rgb;
			float2 uv_TexCoord29 = i.uv_texcoord * float2( 20,30 ) + float2( 0,0 );
			float2 panner23 = ( uv_TexCoord29 + 1.0 * _Time.y * float2( -0.02,-0.02 ));
			float2 uv_TexCoord27 = i.uv_texcoord * float2( 15,22 ) + float2( 0,0 );
			float2 panner15 = ( uv_TexCoord27 + 1.0 * _Time.y * float2( -0.08,-0.001 ));
			float lerpResult33 = lerp( tex2D( _E1, panner15 ).r , 0.0 , 0.0);
			float _E_Intensity_Instance = UNITY_ACCESS_INSTANCED_PROP(_E_Intensity_arr, _E_Intensity);
			float3 temp_cast_1 = (( ( tex2D( _E3, panner23 ).b * lerpResult33 ) * _E_Intensity_Instance )).xxx;
			o.Emission = temp_cast_1;
			float _Roughness_Instance = UNITY_ACCESS_INSTANCED_PROP(_Roughness_arr, _Roughness);
			o.Smoothness = _Roughness_Instance;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
10;29;1423;824;3084.164;252.5957;2.174846;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-2251.046,804.532;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;15,22;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-2247.405,308.7319;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;20,30;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;15;-1936.161,804.5922;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.08,-0.001;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;23;-1947.143,308.9406;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.02,-0.02;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1575.851,-329.3265;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;28,28;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;14;-1690.039,775.319;Float;True;Property;_E1;E1;5;0;Create;None;f94095be3fec1a8488a55c1d8e99b11c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;1;-1269.429,-458.826;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,-0.05;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;22;-1678.888,278.9258;Float;True;Property;_E3;E3;4;0;Create;None;f94095be3fec1a8488a55c1d8e99b11c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;33;-1194.519,754.1805;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;4;-1276.826,-215.0065;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.125,0.05;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;10;-1079.657,-486.7342;Float;True;Property;_N2;N2;1;0;Create;None;9117f2291a12f4746a9fc0416257df40;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-1085.545,-243.3847;Float;True;Property;_N1;N1;0;0;Create;None;9117f2291a12f4746a9fc0416257df40;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-982.3234,594.5464;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-796.6762,358.5376;Float;False;InstancedProperty;_E_Intensity;E_Intensity;6;0;Create;0;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-592.1444,229.3053;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-223.6993,143.02;Float;False;InstancedProperty;_Roughness;Roughness;2;0;Create;0;0.98;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-454.964,-450.3656;Float;False;InstancedProperty;_Color;Color;3;0;Create;0.299362,0.3401234,0.3602941,0;0.1105095,0.1743099,0.2058815,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;7;-743.6674,-322.1234;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-19.62496,-15.69997;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New AmplifyShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;27;0
WireConnection;23;0;29;0
WireConnection;14;1;15;0
WireConnection;1;0;2;0
WireConnection;22;1;23;0
WireConnection;33;0;14;1
WireConnection;4;0;2;0
WireConnection;10;1;1;0
WireConnection;11;1;4;0
WireConnection;32;0;22;3
WireConnection;32;1;33;0
WireConnection;25;0;32;0
WireConnection;25;1;26;0
WireConnection;7;0;10;0
WireConnection;7;1;11;0
WireConnection;0;0;13;0
WireConnection;0;1;7;0
WireConnection;0;2;25;0
WireConnection;0;4;8;0
ASEEND*/
//CHKSM=A1A2BC219E58EE3CD7CB408D71C0299DD46517D1