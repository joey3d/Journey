// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New AmplifyShader"
{
	Properties
	{
		_N1("N1", 2D) = "bump" {}
		_N2("N2", 2D) = "bump" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_D2("D2", 2D) = "white" {}
		_D1("D1", 2D) = "white" {}
		_N3("N3", 2D) = "bump" {}
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
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _N1;
		uniform sampler2D _N3;
		uniform sampler2D _N2;
		uniform sampler2D _D1;
		uniform sampler2D _TextureSample0;
		uniform sampler2D _D2;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord20 = i.uv_texcoord * float2( 150,150 ) + float2( 0,0 );
			float3 tex2DNode8 = UnpackNormal( tex2D( _N1, uv_TexCoord20 ) );
			float3 lerpResult25 = lerp( tex2DNode8 , UnpackNormal( tex2D( _N3, uv_TexCoord20 ) ) , i.vertexColor.b);
			float3 lerpResult26 = lerp( lerpResult25 , UnpackNormal( tex2D( _N2, uv_TexCoord20 ) ) , i.vertexColor.g);
			float3 lerpResult27 = lerp( lerpResult26 , tex2DNode8 , i.vertexColor.r);
			o.Normal = lerpResult27;
			float4 tex2DNode19 = tex2D( _D1, uv_TexCoord20 );
			float4 lerpResult1 = lerp( tex2DNode19 , tex2D( _TextureSample0, uv_TexCoord20 ) , i.vertexColor.b);
			float4 lerpResult2 = lerp( lerpResult1 , tex2D( _D2, uv_TexCoord20 ) , i.vertexColor.g);
			float4 lerpResult3 = lerp( lerpResult2 , tex2DNode19 , i.vertexColor.r);
			o.Albedo = lerpResult3.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
7;29;1423;824;2944.396;1347.081;2.803745;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-1635.358,-346.2924;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;150,150;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;19;-1142.271,-791.884;Float;True;Property;_D1;D1;4;0;Create;None;e33524d2d780ab7439fd19a0f2d4a802;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;4;-1017.746,-527.9663;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;22;-1153.443,-1217.946;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;None;918cb80a5a04fe44889095439a500772;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;28;-1029.517,475.7606;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;24;-1151.07,-229.2419;Float;True;Property;_N3;N3;5;0;Create;None;c283215b24b29254f8611248ab36bf16;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-1141.615,240.9405;Float;True;Property;_N1;N1;0;0;Create;7ddcba51d9fc0894d98b4ba77fbdfbd7;bbcad65c6aa096a4cb0b2d50604a7f70;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;-1143.776,-0.7228088;Float;True;Property;_N2;N2;1;0;Create;7ddcba51d9fc0894d98b4ba77fbdfbd7;e84b9da1a73b78e4099e826a915b0fa5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;21;-1145.462,-1002.522;Float;True;Property;_D2;D2;3;0;Create;None;391b3d18e558cf642916be610c8a5441;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;25;-766.9644,-78.51677;Float;False;3;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1;-767.2444,-1052.166;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;26;-596.791,50.3286;Float;False;3;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0,0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;2;-592.1451,-938.3668;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;27;-409.6,186.4671;Float;False;3;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0,0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;3;-419.9452,-820.0669;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New AmplifyShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;1;20;0
WireConnection;22;1;20;0
WireConnection;24;1;20;0
WireConnection;8;1;20;0
WireConnection;23;1;20;0
WireConnection;21;1;20;0
WireConnection;25;0;8;0
WireConnection;25;1;24;0
WireConnection;25;2;28;3
WireConnection;1;0;19;0
WireConnection;1;1;22;0
WireConnection;1;2;4;3
WireConnection;26;0;25;0
WireConnection;26;1;23;0
WireConnection;26;2;28;2
WireConnection;2;0;1;0
WireConnection;2;1;21;0
WireConnection;2;2;4;2
WireConnection;27;0;26;0
WireConnection;27;1;8;0
WireConnection;27;2;28;1
WireConnection;3;0;2;0
WireConnection;3;1;19;0
WireConnection;3;2;4;1
WireConnection;0;0;3;0
WireConnection;0;1;27;0
ASEEND*/
//CHKSM=809F6AB179349EF58012B7D13F1CC69213551390