// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New AmplifyShader"
{
	Properties
	{
		_D("D", 2D) = "white" {}
		_M("M", 2D) = "white" {}
		_N("N", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _N;
		uniform float4 _N_ST;
		uniform sampler2D _D;
		uniform float4 _D_ST;
		uniform sampler2D _M;
		uniform float4 _M_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_N = i.uv_texcoord * _N_ST.xy + _N_ST.zw;
			o.Normal = UnpackNormal( tex2D( _N, uv_N ) );
			float2 uv_D = i.uv_texcoord * _D_ST.xy + _D_ST.zw;
			o.Albedo = tex2D( _D, uv_D ).rgb;
			float2 uv_M = i.uv_texcoord * _M_ST.xy + _M_ST.zw;
			float4 tex2DNode2 = tex2D( _M, uv_M );
			o.Metallic = tex2DNode2.r;
			o.Smoothness = tex2DNode2.g;
			o.Occlusion = tex2DNode2.b;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
-1749;144;1426;824;1271.757;467.3819;1.3;True;True
Node;AmplifyShaderEditor.SamplerNode;2;-561.3,228.5001;Float;True;Property;_M;M;1;0;Create;None;ff379ec73fd5f274382bf5d62cc6a1d6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-571.9999,-185.3001;Float;True;Property;_D;D;0;0;Create;None;98cd2142c6aeebd4dbabc4ea25711db8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-552.857,20.11825;Float;True;Property;_N;N;2;0;Create;None;44c92b7da7706724a996c787e0e96e88;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New AmplifyShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;0;0;1;0
WireConnection;0;1;4;0
WireConnection;0;3;2;1
WireConnection;0;4;2;2
WireConnection;0;5;2;3
ASEEND*/
//CHKSM=88B55BCE777946DF4DA0F287C6132195AB4486E1