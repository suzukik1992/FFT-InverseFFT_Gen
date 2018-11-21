{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 0,
			"revision" : 0,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ -125.0, -853.0, 792.0, 719.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-7",
					"maxclass" : "live.dial",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 26.0, 14.0, 38.0, 37.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_shortname" : "number",
							"parameter_type" : 0,
							"parameter_unitstyle" : 3,
							"parameter_mmin" : 60.0,
							"parameter_longname" : "live.dial",
							"parameter_initial_enable" : 1,
							"parameter_mmax" : 10000.0,
							"parameter_initial" : [ 60.0 ]
						}

					}
,
					"showname" : 0,
					"varname" : "live.dial"
				}

			}
, 			{
				"box" : 				{
					"bufsize" : 253,
					"calccount" : 4,
					"id" : "obj-16",
					"maxclass" : "scope~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 125.0, 112.5, 642.0, 177.0 ]
				}

			}
, 			{
				"box" : 				{
					"color" : [ 0.862745, 0.741176, 0.137255, 1.0 ],
					"fontsize" : 14.0,
					"id" : "obj-5",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 0,
							"revision" : 0,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "dsp.gen",
						"rect" : [ 392.0, -1107.0, 919.0, 1017.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"code" : "Buffer buf_256samp(\"butterfly_256samp\");\r\nBuffer buf_512samp(\"butterfly_512samp\");\r\nBuffer buf_1024samp(\"butterfly_1024samp\");\r\n\r\nParam bufSize(512);\r\n\r\n// circular buffer\r\nDelay delayBuf(bufSize);\r\n\r\nData REX(bufSize, 1);\r\nData IMX(bufSize, 1);\r\nData XX(bufSize, 1);\r\n\r\nData REXinv(bufSize, 1);\r\nData IMXinv(bufSize, 1);\r\n\r\n// master clock\r\nmCount, mTrg, mNum = counter(1, 0, bufSize);\r\ndelayBuf.write(in1);\r\n\r\nif(mCount == 0){\t\r\n\t\r\n\t// bit-rev sort\r\n\tfor(i=0; i<bufSize; i+=1){\r\n\t\tpoke(REX, delayBuf.read((bufSize-1)-peek(buf_512samp, i, 0)), i , 0);\r\n\t\tpoke(IMX, 0, i, 0);\r\n\t}\r\n\r\n\t// FFT\r\n\tfor(size=2; size<=bufSize; size*=2){\r\n\t\thalfsize = size / 2;\r\n\t\ttablestep = bufSize / size;\r\n\t\tfor(i=0; i<bufSize; i+=size){\r\n\t\t\tk = 0;\r\n\t\t\tfor(j=i; j<i+halfsize; j+=1){\t\t\r\n\t\t\t\tl = j + halfsize;\r\n\t\t\t\ttpre =  peek(REX, l, 0)*peek(buf_512samp, k, 1) + peek(IMX, l, 0)*peek(buf_512samp, k, 2);\r\n\t\t\t\ttpim =  -peek(REX, l, 0)*peek(buf_512samp, k, 2) + peek(IMX, l, 0)*peek(buf_512samp, k, 1);\r\n\t\t\t\tk = k + tablestep;\r\n\t\t\t\t\r\n\t\t\t\tpoke(REX, (peek(REX, j, 0)-tpre), l, 0);\r\n\t\t\t\tpoke(IMX, (peek(IMX, j, 0)-tpim), l, 0);\r\n\t\t\t\t\r\n\t\t\t\tpoke(REX, (peek(REX, j, 0)+tpre), j, 0);\r\n\t\t\t\tpoke(IMX, (peek(IMX, j, 0)+tpim), j, 0);\r\n\t\t\t}\t\r\n\t\t}\r\n\t}\r\n\t\r\n\t// normalize and bit Rev for IFFT\r\n\tfor(i=0; i<bufSize; i+=1){\r\n\t\tpoke(REXinv, peek(REX, peek(buf_512samp, i, 0), 0)/bufSize, i, 0);\r\n\t\tpoke(IMXinv, peek(IMX, peek(buf_512samp, i, 0), 0)/bufSize, i, 0);\r\n\t}\r\n\t\r\n\t// IFFT\r\n\tfor(size=2; size<=bufSize; size*=2){\r\n\t\thalfsize = size / 2;\r\n\t\ttablestep = bufSize / size;\r\n\t\tfor(i=0; i<bufSize; i+=size){\r\n\t\t\tk = 0;\r\n\t\t\tfor(j=i; j<i+halfsize; j+=1){\t\t\r\n\t\t\t\tl = j + halfsize;\r\n\t\t\t\ttpre =  peek(REXinv, l, 0)*peek(buf_512samp, k, 1) - peek(IMXinv, l, 0)*peek(buf_512samp, k, 2);\r\n\t\t\t\ttpim =  peek(REXinv, l, 0)*peek(buf_512samp, k, 2) + peek(IMXinv, l, 0)*peek(buf_512samp, k, 1);\r\n\t\t\t\tk = k + tablestep;\r\n\t\t\t\t\r\n\t\t\t\tpoke(REXinv, (peek(REXinv, j, 0)-tpre), l, 0);\r\n\t\t\t\tpoke(IMXinv, (peek(IMXinv, j, 0)-tpim), l, 0);\r\n\t\t\t\t\r\n\t\t\t\tpoke(REXinv, (peek(REXinv, j, 0)+tpre), j, 0);\r\n\t\t\t\tpoke(IMXinv, (peek(IMXinv, j, 0)+tpim), j, 0);\r\n\t\t\t}\t\r\n\t\t}\r\n\t}\r\n}\t\r\n\r\nout1 = peek(REXinv, mCount, 0);\r\n",
									"fontface" : 0,
									"fontname" : "Menlo",
									"fontsize" : 12.0,
									"id" : "obj-5",
									"maxclass" : "codebox",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 16.0, 39.0, 885.0, 932.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 16.0, 6.0, 28.0, 22.0 ],
									"text" : "in 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 16.0, 981.0, 35.0, 22.0 ],
									"text" : "out 1"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"source" : [ "obj-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-4", 0 ],
									"source" : [ "obj-5", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 26.0, 265.5, 42.0, 24.0 ],
					"text" : "gen~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-36",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 26.0, 555.0, 58.0, 22.0 ],
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-23",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 26.0, 671.0, 179.0, 22.0 ],
					"text" : "buffer~ butterfly_1024samp -1 3"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-22",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 26.0, 641.0, 172.0, 22.0 ],
					"text" : "buffer~ butterfly_512samp -1 3"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-10",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 26.0, 612.0, 172.0, 22.0 ],
					"text" : "buffer~ butterfly_256samp -1 3"
				}

			}
, 			{
				"box" : 				{
					"color" : [ 0.862745, 0.741176, 0.137255, 1.0 ],
					"id" : "obj-3",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 26.0, 583.0, 120.0, 22.0 ],
					"saved_object_attributes" : 					{
						"filename" : "js_butterflyIndex.js",
						"parameter_enable" : 0
					}
,
					"text" : "js js_butterflyIndex.js"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 26.0, 333.5, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4,
							"parameter_mmin" : -70.0,
							"parameter_longname" : "live.gain~",
							"parameter_mmax" : 6.0,
							"parameter_initial" : [ 0.0 ]
						}

					}
,
					"showname" : 0,
					"varname" : "live.gain~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-11",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 26.0, 492.5, 45.0, 45.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 26.0, 62.0, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"bufsize" : 253,
					"calccount" : 4,
					"id" : "obj-4",
					"maxclass" : "scope~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 125.0, 333.5, 642.0, 177.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-16", 0 ],
					"midpoints" : [ 35.5, 97.75, 134.5, 97.75 ],
					"order" : 0,
					"source" : [ "obj-1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-5", 0 ],
					"order" : 1,
					"source" : [ "obj-1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-11", 1 ],
					"midpoints" : [ 35.5, 480.5, 61.5, 480.5 ],
					"order" : 0,
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-11", 0 ],
					"order" : 1,
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-36", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-12", 0 ],
					"order" : 1,
					"source" : [ "obj-5", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-4", 0 ],
					"midpoints" : [ 35.5, 311.0, 134.5, 311.0 ],
					"order" : 0,
					"source" : [ "obj-5", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 0 ],
					"source" : [ "obj-7", 0 ]
				}

			}
 ],
		"parameters" : 		{
			"obj-12" : [ "live.gain~", "live.gain~", 0 ],
			"obj-7" : [ "live.dial", "number", 0 ],
			"parameterbanks" : 			{

			}

		}
,
		"dependency_cache" : [ 			{
				"name" : "js_butterflyIndex.js",
				"bootpath" : "~/Documents/Max 7/Library/js",
				"patcherrelativepath" : "../../../Documents/Max 7/Library/js",
				"type" : "TEXT",
				"implicit" : 1
			}
 ],
		"autosave" : 0
	}

}
