Return-Path: <linux-hyperv+bounces-2493-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 881049162FD
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jun 2024 11:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077831F22B54
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jun 2024 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3823149C61;
	Tue, 25 Jun 2024 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ESteSO35"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2124.outbound.protection.outlook.com [40.107.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD4313C90B;
	Tue, 25 Jun 2024 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308486; cv=fail; b=Zw2DVxWgmxvY/EU0ZNBajyTe2Uks8oc/wD2n8A5FRP7tCDEsi5wJV40LqMaxQM+yG/xk7rLSddQqlGwodXC5OUyrNxb6Uj6hsKCbOWkzN41/nsIwipH+lYDQTHhne2frCHuat5SaQtjlUVxtWMl1s+NdrJzJuigzXFpjz2Hj+sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308486; c=relaxed/simple;
	bh=uaVlcPv0nTVoZd5XaPjPyL3V13Er39KzSSB5euuEMfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sv3W0gAb+nLcQlCfg+NdQR0jTHicyH3Bkrx1YL73Dl4+dFiCoq+a7WDXN6Kmlhxvy8Wj0Gxm//ct1W88OKLipCXd97hHVXy1PWZKQdmoqcJqgCbpni/ANCPSJSffgfruGRr46OqWYKkrYOnHn/bqnszEWvxrdVyAiAI/WoSYBb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ESteSO35; arc=fail smtp.client-ip=40.107.21.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H20JXWpGeKTuvuya2HPVyZNszKFdodFwVhSEXEMHtQOtQdifcQnvk04AdsAvYRIj04z8zYXlKdCIZOOuGJzld5e6+/GH4bLzrBGG+7AxuCucpUQPJl8pEZ45Rh7fbcjDMGJuphZbchtHQB49nW3nPiz7BvkkgPwArlMktcQyYgOqNk3t9MkIE0PFbzqN0fyGSjGv2/dY9h4RLaJBYgURTqYTCVoVtWdxMZBCa1/r7bSfC34ry/JEhgT8VOvGUasDi61M8t+mVKLYlyhOJjwLyeFiIvUGi5jOH0UIEZNZ9igLpwx2YR7jnp7B+xEyXk+EL3BVIzjzOXAm6YLIEXHbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaVlcPv0nTVoZd5XaPjPyL3V13Er39KzSSB5euuEMfE=;
 b=g00KI/ewQsoC+4+SeHzD8yTdK/4djGJSFx+YBCliaRAGtROJd1Cmu5yyXT2eboQmm06toZ/m+32sp9UBojlC8nDXi7ipMzouX9W/dXvLZxfXLxU3QRkj1pMhwsHixBgq0foBLqLqibd+oFCF6mFSpGjGoR35X/YziEMRib4rKpjPV+e2BGPQ2vaocYWFC4mWR6IoYGNl4UtxZjpR3Crsg7IzhEOFtb89Qjvx2o+S2piO1nw9ukAUOOoEMeqOhDGPuKg25cteMKy1lzQRQluhFuJfv3ZcsPQSLavBwu4Bomndjf9nJsdOMrUqE05Ty7lOcRDmMWvAvrEeACQwWIdapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaVlcPv0nTVoZd5XaPjPyL3V13Er39KzSSB5euuEMfE=;
 b=ESteSO35vVMDDjW+MDWL2uDnlATyEGrT2CJAG12SaHST2bariVAByNj2iClh3Zl5vduQR/KQ0HNWZ0wQ8Vn6erZwx4Cwl3udHxzsIZt6aSK5GnzhdQLQdrD/E+qq3cJJwJhxVzw3RZjhDhLSGikksNFgIeQhD8eVVvSck4k+Df8=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by GV1PR83MB0803.EURPRD83.prod.outlook.com (2603:10a6:150:206::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.8; Tue, 25 Jun
 2024 09:41:21 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7741.001; Tue, 25 Jun 2024
 09:41:21 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Ma Ke <make24@iscas.ac.cn>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>, "schakrabarti@linux.microsoft.com"
	<schakrabarti@linux.microsoft.com>, "erick.archer@outlook.com"
	<erick.archer@outlook.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net: mana: Fix possible double free in error handling
 path
Thread-Topic: [PATCH v2] net: mana: Fix possible double free in error handling
 path
Thread-Index: AQHaxuPWNX6rSNu0PUuc4QdHOZtO9g==
Date: Tue, 25 Jun 2024 09:41:21 +0000
Message-ID:
 <PAXPR83MB0559828A8A2511451BE7C7DBB4D52@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <20240625083816.2623936-1-make24@iscas.ac.cn>
In-Reply-To: <20240625083816.2623936-1-make24@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=eaa0f138-2867-42cc-8e41-21706f380e60;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-25T09:39:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|GV1PR83MB0803:EE_
x-ms-office365-filtering-correlation-id: 5a05262c-bf4e-4823-6c0a-08dc94faf883
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|1800799021|7416011|366013|921017|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?bjZJdHpkQ29YdEhIRmwwcG5DZzJZcXhXdFZMaWNOeXRQdDdMTzJ0eUdFNCtY?=
 =?utf-8?B?UW81eVpkNG82QklaZ1UveGplTnpNTlVzb2hVa2JKdGczdkQ0M01oNnhlYktz?=
 =?utf-8?B?SjZQYVZEZDRXZiswS0s4bDB5b3VXWGRJNnROSm91TUFnYzMzKzFXSW5uSGtO?=
 =?utf-8?B?UnlZckVySkhkSGRFUHpPNUxqamV0NklNdXd2bHlhU1lkWXdzN1ErSE5VMEVt?=
 =?utf-8?B?eEx4U2t6NnJUSDdkN04wUVZqWm9BeVhuNDZIUEw3UzZWS3BLcUw3UjlOOWFi?=
 =?utf-8?B?NVR4d1NPYVBJMHM2K3JlMnkwN2xUc0lrZGNEc1lLN2Q5d1pZcmNVUDNtM29v?=
 =?utf-8?B?UkhPZWJxN3BEaUJHRUtaOGFMZitCTUJZTytROXlJVVhKS3JlWHVsZWt2YnZS?=
 =?utf-8?B?VWQ1clpTOFVheFlnRlNqem4rNDBTd3h6Mk1hRVdleFJybzBGL1d6Ylg4YTZS?=
 =?utf-8?B?eVFxS2pQdmN4N0dCa0RyMExLeDNCeGltU1JVR2lWNm5SZ1NMYmhtZHJUZGc5?=
 =?utf-8?B?bGxyaEt1MU83SjNHendZaGl0Y29JcjkyRGdmSFlWSml2M25zakNES25HZzN3?=
 =?utf-8?B?a3VuUDNndTRhaVgwYjF5YUxrK3ZMSVdLeVQvWEF1TnVLMUJ1V3FiaDhmQXZU?=
 =?utf-8?B?ZkFSR1VDeWRvemw5dnhMUk4yVlN4VWFaeGZ4cXZFSFdLd280NS90Z1FrOVJT?=
 =?utf-8?B?VGRSU0NRc01TaUVDcmQrOWZ2ZW4xZmNxNzFOb3cxamlxMGtITThFd3ZvM3hM?=
 =?utf-8?B?YkRtcFBMcHVUbi8xMTZ2RTBNWlVDVyt0eitiUEtpRERKOWF0MmIwYXNwV1NL?=
 =?utf-8?B?d1lSVXhCUzkvQjZPQTI3Wmk1elJwdC8raHpCSEtXRVMwY0RveHFTS1EyZlpE?=
 =?utf-8?B?bW1ZUVpnellZbkNOdVFJRmw2SWdxa0ZRQjd3eG41RnZHT2VkZFh4cUtVakYz?=
 =?utf-8?B?a0lTdG1nOXBJcXZZNDdva1JmQ1RQRDZIM2JTSUVCcWsraXpTWjVlR0tLUnhm?=
 =?utf-8?B?eEJVMFlvM3ZoMWh6YUhlZHh5dUV3cUpUY2hWWXh4Q3B2TEZVdnpEU2Fwcm5W?=
 =?utf-8?B?a21XYWk1aFloSmJ2WXFRZk9IVnNvRkVLOE9zMlhvUTkxdmlEMUNWRVNIeVlF?=
 =?utf-8?B?dnY3aWhpUVR6d205V1pLaDlVWjdJRVVCU1FKRk9BS3ZhQzBuRmdwM21GQUR6?=
 =?utf-8?B?djNWOVNKbHV3d0ZhQTRXL1Rqd0wwVmFZNWxFVGxOMXpBQkhMMTVzTEE2K2pG?=
 =?utf-8?B?U05ZVTJUMXFzcXFoc1EvYlRkQ2RqWlR0cE5WOEQvdlNXZm43UVJETzA3bllK?=
 =?utf-8?B?TFRYcmFCMks2OVRtQ1cyNVRTWTY3R2pSbTRPaExqL0QwNTJqT0tvQm9lWW9l?=
 =?utf-8?B?TGY0eWVuWTFXUld0YnprWmVBMUVyZi9xaEhiMkRXTkZTMHZMOGNGcDVwckJQ?=
 =?utf-8?B?NXFhTXpWT2kyVUNNVHBCdmNIcEZzM0hyVlV2SS9RNnhoTlRlM2cxMHh5S3hF?=
 =?utf-8?B?T1FEYm00cERQaE92SitmaGlTazhaNjAxR1JoNGlmckUwQUtkYTZldEtjZFMr?=
 =?utf-8?B?aHpmNFRhVStLTFkyaWo0bEg0ZS9laGg5OWx1SXJ3c29aVzdQaUlKdUhjVmFJ?=
 =?utf-8?B?NWNoajB1YkEzWTJoT09OVUYyWitWalpoa1BZU0MrajRkNXF4c0txYzUvdnNT?=
 =?utf-8?B?U05JQ3kyZXBncFdWNTNQdW9CYWU3UmoyQlhHcktWNXorcEg4NzJhcFpvSmho?=
 =?utf-8?B?aGltYUtSS21tSllsZjUvamJuUU5OTlR6QUpUa09XbisyTFVpMDcyb3l4OVQ1?=
 =?utf-8?B?SXdvNFRnOWZUOFM4WDVtSGRPcmhjbitDWEtJMmlMallJeFlMbEhiT1NHZ2Rn?=
 =?utf-8?B?UWV5a0VlVUYvckRCRUVBL0wwRE1HSS83b1BlR3huVEhyeE1GNjF1SHpReUJv?=
 =?utf-8?Q?O3p4gQOpkw8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(7416011)(366013)(921017)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGxYVCtONm9tVDNuaFE1a2FnYUNHT0hxbjJ6ckRQY2J1TkFoNmhoemxxOGNa?=
 =?utf-8?B?S1U5L0EzTm8waVlwVEtvbXZxRWZ0LzhzeThiWWEvV3E5SVZjRXBCa0FzK2NR?=
 =?utf-8?B?R2htZlRwaUhIV2ZUNEQ5OHFpTE5uNnlEVmxvVWQydEM4SVplMmp1OFUybDli?=
 =?utf-8?B?a0ZPUFVBZ0Q3WW5YQUZ0TnkwdGxnQWlEbURlakFrY0pmTkpSUENsa05GMFAz?=
 =?utf-8?B?S05qK1RCUE1STDFzQkdOUS9rZ3hwRGw4RjNNYU9ZcXJqcUJ3Q0JJQlpSTW1N?=
 =?utf-8?B?RjM3RGZDUVQxUUM4ZGREZjVVRTVJVVBiSzBRTysxb3V1Vm1IVkUvaTZiUXVN?=
 =?utf-8?B?VjM2NDlYd0I0UlR2UmZaYVROWnlDQWkwZFdQNFc0Ull3T0x5QlM3eEJnVUN1?=
 =?utf-8?B?SG1rejhTYkwvbUJJZGlHSjVwWjBuYXFaOHg5ekl5YnJkS2RWaGdvN3NyeUdv?=
 =?utf-8?B?RTdZcVMrK0FUU3VLTS9rUFdzeGhmN2FSWElnS1NxbGl1ZFlPTFRMRncrdnVC?=
 =?utf-8?B?cm15OXluVTJ4TERLWUVWZWlqcFdoQkprQVZCYVI3YkR4ZG0yZmxWeUcwcVJH?=
 =?utf-8?B?Mzdwc2tWd1I0eVczNFEzKzNjdG43Slo5Vnk0VnNoZ1RlaVF1UmJBVzhFZnRp?=
 =?utf-8?B?RW80QmdmT3orRURCTWRmRE9hUVdHLzZuZ1plSkR5SlNkclVKSTR1RHNFTERR?=
 =?utf-8?B?NHFST0tLaVBSQ21BZ1hDclBoVlZBVlFFSzBFKzJSclZyRHNDOTNnRkEzSmZl?=
 =?utf-8?B?ZkJmUmZ3NkJZNkZIZjJFckZjTEYyd3dDMHhYcDFZRjNYVDR4MDVrcHhyejUr?=
 =?utf-8?B?cU01OFhkOWZEaXNTQXVpcUkvbnMxVGpGLzlQSEEyUG1ZSmxzYnkzSzVCcytz?=
 =?utf-8?B?SzBtUk9GSzZGUExJcXpNOWZNUGZzTGtkcXF5VUlVemQ1cldDdEh3VVF3Q1Vv?=
 =?utf-8?B?QTZBSzhmKytjenJISWFDUVpwMVhoVExjS05PL09ESDl1ZHJudU5KbGRRRXB5?=
 =?utf-8?B?cnZkS2IyUnRTVVJkS1JZR0JQd0NUKzlGZllIdFJoL3loSnBza09KVU91ZC9Q?=
 =?utf-8?B?dVJWaGpHUGVLcVB6YlE3V3dEQkxpa21VS1RZTFBraHFaMm9INUViYTJWeHo1?=
 =?utf-8?B?eVJ2R3pBNGNJbG1nQSsybi8zWS9sL1pRRkJKY3BGOHZiN1dIWmljL0NqMk1L?=
 =?utf-8?B?T1ZoRkNzVjE0SHZBTWdSZGN6eDJ6SVRDMmsvWWwwZjZyTnVEV1VFSTNuUk1n?=
 =?utf-8?B?TzB1ay92L0RESFlRbktDSEtTL0tBeUFmVlFwSDdRSHVraklPUVFOYW12bWx6?=
 =?utf-8?B?RzFkeG1KRkRyWVFORmNWTTdNL2xJY2MvVExNclYzZFRUQWw4ekphZE9XbmJk?=
 =?utf-8?B?cUIxVXNUbWxRZTV6bWY3Und1ajJMVUMvOG4rNEtTbFc3QjZsYmFsVHdXMUVI?=
 =?utf-8?B?UmMyTExpL1BUL0hzaW1FeUFKZWNtTkJ3SEp6MW0xUVRLaS9ZZTZVcWk3UjQ1?=
 =?utf-8?B?a3dzR0grOFM2NUM1dmJZbVFRT3NTR0Q3QVkvb0NNOEE2K3NQMFBNYUpXd0VO?=
 =?utf-8?B?T1NOcFZ3NXFvYWFoUlJKK0VHQWJ1MjNnYlB4ZlNwSnRTU2wyRzYvQVVzYlc3?=
 =?utf-8?B?WUk2S0xOS2dNUDd3YkI5Q1lnbTBXR1k3ZDkxUmhSalJ5WVlmYVVRY1Z6RjNN?=
 =?utf-8?B?ZU5sUDY5ZXhpdEQraExnOHZYbHY0R25nV1Z5YkZwcmdTMnVvamgrRkRCSkhM?=
 =?utf-8?B?OHU2NEhvdXdYQmlnZlRoeWdudk9WbGVscnhzQUN1aUhJUXBFU2tPTmVyaHBu?=
 =?utf-8?B?RmVHWnZ6Z3lmY2hJQUxtOUo1bG9TVG1ZVE45T0VYOCswTVYySVlFUFh1WElU?=
 =?utf-8?B?YkJ0cnVPVll1am9qVlZLTEtyZTBPSllEdnIwYWtHdTcvVWN6a1h4NWp3Q3Mv?=
 =?utf-8?B?eCs2ZzhpN1BsY1BoR2RxdGZ3Vm42T3JlblpqTkRIWGlHR2JPUlVjZVdqNTFP?=
 =?utf-8?B?aDRPSW5XcjdVeThsZmFNL1E5NVlvVE5UN3JJVHR2NU5qMXRDeHFVdXJLc3dS?=
 =?utf-8?Q?SoBXBu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a05262c-bf4e-4823-6c0a-08dc94faf883
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 09:41:21.1838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDFEk4ur5AFYRLy/2vePgMsGJTQtYcBrLg+0mMCukT1biZBwuhjPkaX3j0zw/8U9ugXgpFyFbwvnjk5Ge9dahQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0803

DQo+IFdoZW4gYXV4aWxpYXJ5X2RldmljZV9hZGQoKSByZXR1cm5zIGVycm9yIGFuZCB0aGVuIGNh
bGxzDQo+IGF1eGlsaWFyeV9kZXZpY2VfdW5pbml0KCksIGNhbGxiYWNrIGZ1bmN0aW9uIGFkZXZf
cmVsZWFzZSBjYWxscyBrZnJlZShtYWRldikuDQo+IFdlIHNob3VsZG4ndCBjYWxsIGtmcmVlKG1h
ZGV2KSBhZ2FpbiBpbiB0aGUgZXJyb3IgaGFuZGxpbmcgcGF0aC4gU2V0ICdtYWRldicNCj4gdG8g
TlVMTC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hIEtlIDxtYWtlMjRAaXNjYXMuYWMuY24+DQo+
IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIHN0cmVhbWxpbmVkIHRoZSBwYXRjaCBhY2NvcmRp
bmcgc3VnZ2VzdGlvbnM7DQo+IC0gcmV2aXNlZCB0aGUgZGVzY3JpcHRpb24uDQoNClRoZSBjaGFu
Z2UgaXMgb2ssIGJ1dCB0aGUgY29tbWl0IG1lc3NhZ2UgaXMgbWlzc2luZyBhICJGaXhlcyIgdGFn
L2xpbmUuDQotIEtvbnN0YW50aW4NCg==

