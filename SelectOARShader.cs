//
// SelectOARShader for oarconv by Fumi.Iseki 2015 (C) v1.1
//
// see also http://www.nsl.tuis.ac.jp/xoops/modules/xpwiki/?OAR%20Converter
//
//

using UnityEngine;
using UnityEditor;
using System.IO;
using System;


public sealed class SelectOARShader : AssetPostprocessor
{
	private const string NormalShader         = "Legacy Shaders/Diffuse";
	private const string TransparentShader    = "Legacy Shaders/Transparent/Diffuse";			// Alpha Blending
	private const string TransparentCutShader = "Legacy Shaders/Transparent/Cutout/Diffuse";	// Alpha Cutoff
	private const string SpecularShader       = "Standard";
	private const string TransSpecularShader  = "Legacy Shaders/Transparent/Specular";
	private const string BrightShader         = "Legacy Shaders/Self-Illumin/Diffuse";
	private const string GlowShader           = "Standard";
	private const string TreeShader           = "Legacy Shaders/Transparent/Cutout/Soft Edge Unlit";
	
	private const string MaterialFolder = "Materials";
	private const string PhantomFolder  = "Phantoms";
	
	private float transparent = 1.0f;
	private float cutoff = 0.0f;
	private float shininess = 0.0f;
	private float glow = 0.0f;
	private float bright = 0.0f;
	//private float light = 0.0f;
	private char  kind = 'O';
	
	
	void OnPreprocessModel()
	{
		string currentFolder = Path.GetDirectoryName (assetPath);
		if (!AssetDatabase.IsValidFolder (currentFolder + "/" + MaterialFolder)) {
			AssetDatabase.CreateFolder (currentFolder, MaterialFolder);
		}
		
		if (!currentFolder.Contains ("/" + PhantomFolder)) {
			ModelImporter modelImporter = assetImporter as ModelImporter;
			modelImporter.addCollider = true;
		}
	}
	
	
	Material OnAssignMaterialModel(Material material, Renderer renderer)
	{
		string textureName;
		if (material.mainTexture != null) {
			textureName = material.mainTexture.name;
		} 
		else {
			textureName = material.name;
		}
		//
		string currentFolder = Path.GetDirectoryName (assetPath);
		string materialPath = string.Format("{0}/{1}/{2}.mat", currentFolder, MaterialFolder, textureName);
		
		Material mt = AssetDatabase.LoadAssetAtPath<Material> (materialPath);
		if (mt != null) return null;
		
		//
		getParamsFromTextureName(textureName);
		
		if (kind=='T' || kind=='G') {	// Tree or Grass
			material.shader = Shader.Find(TreeShader);
		}
		//
		else if (transparent < 0.99f && shininess > 0.01f) {
			material.shader = Shader.Find (TransSpecularShader);
			if (material.HasProperty("_Shininess"))  material.SetFloat("_Shininess", shininess);
			if (material.HasProperty("_Metallic"))   material.SetFloat("_Metallic", shininess);
			if (material.HasProperty("_Glossiness")) material.SetFloat("_Glossiness", 0.5f + shininess/2.0f );
		}
		//
		else if (transparent < 0.99f) {
			if (cutoff>0.01f) {     	// Alpha Cutoff
				material.shader = Shader.Find(TransparentCutShader);
				if (material.HasProperty("_Cutoff")) material.SetFloat("_Cutoff", cutoff);
			} 
			else {                  	// Alpha Blending
				material.shader = Shader.Find(TransparentShader);
			}
		}
		//
		else if (shininess > 0.01f) {
			material.shader = Shader.Find(SpecularShader);
			if (material.HasProperty("_Shininess"))  material.SetFloat("_Shininess", shininess);
			if (material.HasProperty("_Metallic"))   material.SetFloat("_Metallic", shininess);
			if (material.HasProperty("_Glossiness")) material.SetFloat("_Glossiness", 0.5f + shininess/2.0f);
		}
		//
		else if (glow > 0.01f) {
			material.shader = Shader.Find(GlowShader);
			if (material.HasProperty("_EmissionColor")) {
				Color col = material.GetColor("_Color");
				float fac = col.maxColorComponent;
				if (fac>0.01f) {
					glow = glow*100.0f;
					if (glow>99.0f) glow = 99.0f;
					col = col*(glow/fac);
				}
				material.SetColor("_EmissionColor", col);
			}
		}
		//
		else if (bright > 0.01f) {
			material.shader = Shader.Find(BrightShader);
			Color col = material.GetColor("_Color");
			col.a = bright;
			material.SetColor("_Color", col);
		}
		//
		else {
			material.shader = Shader.Find(NormalShader);
		}
		
		AssetDatabase.CreateAsset(material, materialPath);
		//
		return null;
	}
	
	
	private void getParamsFromTextureName(string name)
	{
		if (name.Length >= 18) {	// 18: 12 + MTRL_QUALITY_NAME_LEN
			string sub = name.Substring (name.Length - 18, 12);
			string enc = sub.Replace('$', '/');
			byte[] dec = Convert.FromBase64String (enc);	// 9Byte = 12/4*3
			
			transparent = 1.0f - (float)dec[0]/255.0f;
			cutoff = (float)dec[1]/255.0f;
			shininess = (float)dec[2]/255.0f;
			glow = (float)dec[3]/255.0f;
			bright = (float)dec[4]/255.0f;
			//light = (float)dec[5]/255.0f;
			kind = (char)dec[8];
			// 6-7 are not used
		}
	}
}

