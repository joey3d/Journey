// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New AmplifyShader"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float2 appendResult14 = (float2(ase_worldPos.x , ase_worldPos.z));
			o.Normal = UnpackNormal( tex2D( _TextureSample0, appendResult14 ) );
			float temp_output_21_0 = sin( ( ( 2.0 * UNITY_PI ) * i.uv_texcoord.x ) );
			float2 uv_TexCoord31 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float2 panner32 = ( uv_TexCoord31 + 1.0 * _Time.y * float2( 0.1,0 ));
			o.Albedo = float3( ( temp_output_21_0 * panner32 ) ,  0.0 );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
1941;46;1858;798;2976.621;460.5718;1.3;True;True
Node;AmplifyShaderEditor.RangedFloatNode;18;-2486.683,-55.51209;Float;False;Constant;_Float0;Float 0;2;0;Create;2;2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;15;-2229.483,38.10763;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PiNode;17;-2202.885,-51.91205;Float;False;1;0;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;31;-2005.306,317.5577;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;13;-1389.352,-294.6926;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-1997.487,-19.4122;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;21;-1756.706,-19.80969;Float;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;32;-1677.854,323.2393;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,0;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;14;-1145.855,-272.2582;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1467.281,-493.7039;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-845.6998,242.9;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;3bf53a8ab66a760479ec9f4a0a1c926e;3bf53a8ab66a760479ec9f4a0a1c926e;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;11;-1216.688,-493.8924;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,0.05;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;4;-852.0442,-336.2831;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;None;e33524d2d780ab7439fd19a0f2d4a802;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-1410.051,237.4392;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT2;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;30;-1440.18,-20.36424;Float;True;3;0;FLOAT;0.0;False;1;FLOAT;1.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New AmplifyShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;18;0
WireConnection;19;0;17;0
WireConnection;19;1;15;1
WireConnection;21;0;19;0
WireConnection;32;0;31;0
WireConnection;14;0;13;1
WireConnection;14;1;13;3
WireConnection;2;1;14;0
WireConnection;11;0;12;0
WireConnection;4;1;14;0
WireConnection;33;0;21;0
WireConnection;33;1;32;0
WireConnection;30;0;21;0
WireConnection;0;0;33;0
WireConnection;0;1;2;0
ASEEND*/
//CHKSM=7CEDE63F54CC540A9674EC9A90B955EE53A93D55