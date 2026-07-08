Return-Path: <linux-hyperv+bounces-11874-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GRpsAdRdTmp+LQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11874-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 16:25:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F082F7274EF
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 16:25:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=AIvluifw;
	dmarc=pass (policy=reject) header.from=microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11874-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11874-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFA2F301274D
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 14:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776A344CAEA;
	Wed,  8 Jul 2026 14:15:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020081.outbound.protection.outlook.com [52.101.201.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BC044BC92;
	Wed,  8 Jul 2026 14:15:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520153; cv=fail; b=VVbZui5Lgqb0inqFacnOx554qFifa2yAq0ID6jc9a9K1FmmYuf0mfPWRtX/YvNwnlOFKROcbH2suFrP8tVT0n6sfvjGlH5WOkRzVh62Rac8AT4JmsQkgqWOBAPc0i3uuh/8+sIBdOB/aUWArOegxNyE6DLZPnB0oN00dBWujBvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520153; c=relaxed/simple;
	bh=nZjsoPtFOMr1KAciIS2bQw3f/MsXpIjpkyGzDd90HEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vC4c3vXIi9L75vabXunfujmP0Suk3X2LBFScCmGjU/SRUkMSo3yfGGmGsZlSMBsD2QxGFogZ1YloTBactjPuFd+L4UqH3ewFcAxJ2IYl5QGZnkDP0I3V9Z+RiNEKTiGCkFMkVQWTOuLOc3anz3xpJ10okjNJMxBs6dFTdebMumA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=AIvluifw; arc=fail smtp.client-ip=52.101.201.81
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pgns+aRsIRgA2d10vM2NXOhsH2hD2fPun2O8pu6D/kUGXVhkEYvDqRdCwoO/CB4feRj5RSDbi1xdl3Dphw3WLAgE51V0um1J52Gb2qnz1JM/NHp4PCHGUNsqnJmUQUNEZyiDs4SkjKBc6JAvwF98tzrVymoYXyVHPQbJB9avqZD5sI8O0zHH/N/flDv7Sufp9qSKDIiLY1ve68q2XeBAGTGIqJ+q8P9Z+wE4Ns5FRM/0nBCRYdUMTXS9rtNV5MQqd3wWJStiMasxDW1qCC4oc2o+1NRNUUfZip5wQ30Rqj6GBTwE/mG2wtbeN5MY0qiNyGw+N79aFNwxrYRfItoRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZjsoPtFOMr1KAciIS2bQw3f/MsXpIjpkyGzDd90HEI=;
 b=XiWRTPOmgBOGmT+Yq5rshUdSmgToNc9jr2FiuuASZvnXK5nchDxlGpKTF+FEwUD6W7ZX8B5zLbRbh4vSo76cm8e3SmRf3+3ktwRsfLuLu9I8dWHb/Kad065yw8pesYog5AKO61Hjc7oN27k3QtujCRnEHXGdxQrhBuBVgsX/wTKfJ5oChAOVhmxU3hB5Qmv8RgSr7C2rTrbjoHGaz23sQOZAvbK3AyIUfWZbgdvdPX2sefHXLaDOYm44E8rt1Ijypzue2KvvGFiZe2eUiiw75t7Bnde4MyYYHCZniAR0RIQxv7yW2X+aDiZyvjkAI0APodPvjP5MMIGxcs0fUVct3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZjsoPtFOMr1KAciIS2bQw3f/MsXpIjpkyGzDd90HEI=;
 b=AIvluifwZZ5KoEkf9vQ2hEwNupmd16iY7vH5PWutvT447o0Fn41CZjPSA7y6npp6KqFWaKJJI9tLDoPgSjtU8UbRHOkocziMns4Cq2EjfF2vUy59gfO8vrl/AwOSUxfe9XyNkyTigTGcTD23JgG2ZoHYwnw7UpDvNW/qFlY9V3c=
Received: from DS4PR21MB6914.namprd21.prod.outlook.com (2603:10b6:8:2e5::9) by
 DS2PR21MB5015.namprd21.prod.outlook.com (2603:10b6:8:2bd::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.3; Wed, 8 Jul 2026 14:15:48 +0000
Received: from DS4PR21MB6914.namprd21.prod.outlook.com
 ([fe80::ef10:ddaf:4d07:7646]) by DS4PR21MB6914.namprd21.prod.outlook.com
 ([fe80::ef10:ddaf:4d07:7646%7]) with mapi id 15.21.0181.003; Wed, 8 Jul 2026
 14:15:48 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, "dipayanroy@linux.microsoft.com"
	<dipayanroy@linux.microsoft.com>, "kees@kernel.org" <kees@kernel.org>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net v3 1/2] net: mana: Validate the packet
 length reported by the NIC
Thread-Topic: [EXTERNAL] Re: [PATCH net v3 1/2] net: mana: Validate the packet
 length reported by the NIC
Thread-Index: AQHdDsiJ3o5YgdJg8Ea8lZ2jggczQrZjqWcQ
Date: Wed, 8 Jul 2026 14:15:48 +0000
Message-ID:
 <DS4PR21MB6914481C0041A113F5791238BFFF2@DS4PR21MB6914.namprd21.prod.outlook.com>
References: <20260702041237.617719-1-decui@microsoft.com>
 <20260702041237.617719-2-decui@microsoft.com>
 <d359508d-76a8-4df8-87ef-2767fe7fb40d@redhat.com>
In-Reply-To: <d359508d-76a8-4df8-87ef-2767fe7fb40d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6199153c-35cd-4afe-a29e-340fea918cfa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-07-08T14:10:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR21MB6914:EE_|DS2PR21MB5015:EE_
x-ms-office365-filtering-correlation-id: d82a4d61-9a9b-4607-6034-08dedcfb6875
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|38070700021|921020|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 sCLgGCPGQmuvG0d0IzKps0Um4800TfpRTsvZAVXEWC9tGWzL8wfjb6q1nQqNUm0y7fJOm4dExp1aGGmTl7BWG1rRPqiuHDegP2V7R3DS3PbrfQzoJFsp4bULRQrN5QivZ1cOoIydOQWuKzJRA1W29NwzHc/CaY2/Y1n0oU/i/3z3lJbFi0EFefW/cLqp32CteE8GpdNjHgoTMalkIkWXme9vbEnSeGTYUhdqpFptE586UBK2dIwL4JYh27c6+E1z3Et7GPz5DYaKXxFDmrAArelOMl+NzxkkTzO4xtt7MkViO1CxkS3+qS1LMZoZ9uDNKeAoZbhRdBo8Wa8osssEPvwYRLii7uZQxuKJD1RLmTgrmxjIuP8mbZZvqszamZ/A/3loaEbjm97b6uh8PPQi3ZfsmmLdPd0/cCYh2tL5e3oLiraHQhd6eEQrq2IUbclHhuxAbT/N6Ko/6eum3dcPHmoOH3pGPtlkYqC3IGpWLI1/c84ybmhu/m12izvQPKzgeYPY69BkOh58TIhSKJRJx0H37lFlk2H3DrYWPan/psvuCkdKpEmC+pwrlnWX+cYtUGUagugFADdLNbkdFLVDzB429/DjlGZ1k5Mv6ZVDzmkuWEWEljUhpNT/25QSauuApdsPgujMVwDXnn5v6qnIiDOYseQObZoifTarsMCoa+8sI8yyNyX9JpvL7Kxw/WekgwruDDGQSljcNwav8sjXWo7CoSi8T0IqjZyRumopxdQ/q3ZKG6/L5/0PhkoBCJ7L
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR21MB6914.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(38070700021)(921020)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDdqT0FvKytiWGpwYWNPYStrUXpadVI3Y3pTQ0xpSS9HcTZtZTJnaVZURmVk?=
 =?utf-8?B?VlFoVUI4bXVlMGdMVmFtR1N2dGRCb2ZCUit5a0s5Z3U3VkJUOFFKZFlxNk5D?=
 =?utf-8?B?MGlscTVMNmMzREFDYXdweEkrZXR2LytoRFZQbTBjRVhpb0hTUDA1blVaWHYr?=
 =?utf-8?B?cHNVbUNzNHJoVmJHVlAvYUMrTmo4bENENTErSmhtS1Fsbi9oYlJqMmtUU2NH?=
 =?utf-8?B?OSt4NFp2Sm9hSTJGRllFZXl0Q1B0c01rV29Pa1pUTTdpbm5NVU4vZlJEZVJm?=
 =?utf-8?B?STluazZKQ0VEbWhQS2ZpZFVQSWRBcEN0M2tHK2ZsakRlZFJzQ2FLYTQ1bjlJ?=
 =?utf-8?B?TUVqVVRBbmpMT0VqSnRRRVZWOWNSbXJOb3N1azFSYmtDSnhWVlVSRGFMMDhQ?=
 =?utf-8?B?ZEhFb2tVTng0UUQrWUlFZDNxdUNxZTNzb3JOd1RBTEt3dEdHTnJjUDFWaU5W?=
 =?utf-8?B?cDFPQ2JGRnJ6Mmh1WXk1ZWFsRFJQcFVzTjVLNHhwVGlIWDJhYTUybEpJRldz?=
 =?utf-8?B?eGV5Y1FZa3JaK2JNTDhBSjNJWGZnSlJRQ3pxOXExUlZtOWlnN0daUXg0eEF5?=
 =?utf-8?B?TlhRakp1a2tkb2l5aWpYNFZWRUtjY0dVblFrYlE2T2l3dDlraDgrVjZteE5B?=
 =?utf-8?B?WENJUmZ6cWFhdGMycnVyMzU0R2dWMHVETDFxTThkdHNTTVBvS3crejNHK2Vo?=
 =?utf-8?B?Wm5Caml6NjRQSHdhWGNMV2c5MzhaUmdMWjNlaG1SYUppbVh1NFJ6dm5SbWRI?=
 =?utf-8?B?S0tMMWl2REtTNjM0Mm84c1VnamtqVUhoTlJIbENJU2JsU01jWEViMFRudVMr?=
 =?utf-8?B?ZTVjaHpzM3N6Nms1clgwQ2hGVlJMbHBEKyt5Mm5mTXZ0ZDRwN052aHZRK25Q?=
 =?utf-8?B?ajU3U1FuYklab29CdmQweUpoRHVUZnpQMXhVUlphNm43VWpQcm9DenN0YWxY?=
 =?utf-8?B?K1VFUXM3Vm5RTDVKSU5vWHNWZEs2dWNLTUM1dExudFRUVi9YbEJBQkUzcDJU?=
 =?utf-8?B?ZDZUY1JVN0toVS81ZE1nVWozd0xBYzN0WStLUG1QM1Nnd05sV2t4VmtZUit2?=
 =?utf-8?B?UThDcnRBR040QlZDUjVKL2Y1eGtDMHVBMXVWOWpDUkFxY0M0VzBvZkNGMHNC?=
 =?utf-8?B?NkpBMXRCQkN0RUNNbFdia3Qyc0xiSUJmSmxrNjdPODduY0FpbmZZM1dKU3hv?=
 =?utf-8?B?Zlg1MmdLZE1tNDEraUhWS1VVSkhWcE82SDd0OFZmUlJxa1JYUFFYRmdzRG9p?=
 =?utf-8?B?SUVJTDB6KzFneFZuTndYL1dLbDF6MjFDdWJ4czVqZ0xCcUZDeklteUFONTFx?=
 =?utf-8?B?U25MK0V5eEJFRWZkbGh5cG8vNWdUUldyeGV4QnE2TVd5ekpzajd6eDZQdkdp?=
 =?utf-8?B?NGJ4Q3NYekFtWnkxaDh0eiswZFB2NUltZkpXd013SGRteXAwQUVHQlhrSUk5?=
 =?utf-8?B?NGhvZk11QmphS1QvYnpPcGRNSGNXMUhrMm4wV29NNEJRa1A3eUhSaENiODZi?=
 =?utf-8?B?NGwrWEdyOEN3YzIyWnFGVHA2bnE5cDcrb1F0bGhrNExoSjVhTDFVbGVNRjVt?=
 =?utf-8?B?QVFnL3RrQ1dUOU5XanJsNUpiQklybC8yZjl2Vkhtbmp6TW4yYTdVT1BxazhJ?=
 =?utf-8?B?NUIzOTJTbDBMY2hXTFNTbmswUWt4d2lmc0dQVWpvbHUzc1F4MDUxbFE5Y20z?=
 =?utf-8?B?d2FIVGRSdzI0REtIY1VFd3ZValBUakxQVUZ2QXRvR2J6aUlQT3lBVjVud0pk?=
 =?utf-8?B?eXRxTjFZaUxobzZNa3MrdVlrNTdHWDkvRFBYLzJkSmNaQjh2WUxVSEp5cmNP?=
 =?utf-8?B?NzREMjB2T2hpRzBQaTJua3Fja1d1Wm94TzFXUjFnazBUM3FEU09hbmRnc1Fu?=
 =?utf-8?B?Nlc2ZldhNE9MKys3R1FCYWRrVFlVcEdvdndCNktodFd6UXM5ZUhYdUx0ZUhu?=
 =?utf-8?B?SW50Wk1HemQvRjlQZEwxZDIxYlZhKytMbjhQWjk1NW1LbCtDQmV2UURoVmZS?=
 =?utf-8?B?L1pYRUIzUFAxWGh6eElkYVFkQ1JweVptdkcwZG9qOGZBaDFqMkEzbzJVUExr?=
 =?utf-8?B?SDQ1em1aS21kem9KVHRwb3I5bzZkOXFVOC91end5VEcwbW5wcW43aERNbURt?=
 =?utf-8?B?ZUNqd21oV0JDSFBXSld2VnRzYzVNN0owc0g3MGpGVGlXWjc4L3hQVE5tWlY2?=
 =?utf-8?B?NWV5WitkYVBlaDdhbm1UbHpiODlaKzRiaGlialhQQUxKWjBRMHdQcksyZlZt?=
 =?utf-8?B?a3VVVXlqY3pTUjRIYTVIbDUwQ1lvbnh3ZktpZ2ZYcWI5ajF3SzFLQTh1SHFX?=
 =?utf-8?B?VkczRFpiQ0RONlRnc3pqYXZBVWVqYTRld21QRmlSYkVtTHBzVWtMQT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS4PR21MB6914.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82a4d61-9a9b-4607-6034-08dedcfb6875
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 14:15:48.0380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdW3cU2YTEgG/xmthwS1S4CCNeFqMs2lTFkMCDeH1rnWXlY7pjSg8Y1VWAjgq6LSszdP/PGrmIf6CuJo31ZqQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5015
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:kees@kernel.org,m:jacob.e.keller@intel.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11874-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F082F7274EF

PiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgSnVseSA4LCAyMDI2IDM6NTcgQU0NCj4gLi4uDQo+IE9uIDcvMi8yNiA2OjEyIEFNLCBEZXh1
YW4gQ3VpIHdyb3RlOg0KPiA+IFZhbGlkYXRlIHRoZSBwYWNrZXQgbGVuZ3RoIHJlcG9ydGVkIGlu
IHRoZSBSWCBDUUUgYmVmb3JlIHBhc3NpbmcgaXQNCj4gPiB0byBza2IgcHJvY2Vzc2luZy4gVGhl
IENRRSBpcyBzdXBwbGllZCBieSB0aGUgTklDIGRldmljZSBhbmQgc2hvdWxkDQo+ID4gbm90IGJl
IGJsaW5kbHkgdHJ1c3RlZC4NCj4gPg0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
IA0KPiBUaGlzIG5lZWQgYSBGaXhlczogdGFnLCB0byBoZWxwIHN0YWJsZSB0ZWFtIGJhY2twb3J0
Lg0KDQpQbGVhc2UgdXNlOg0KRml4ZXM6IGNhOWM1NGQyZDZhNSAoIm5ldDogbWFuYTogQWRkIGEg
ZHJpdmVyIGZvciBNaWNyb3NvZnQgQXp1cmUgTmV0d29yayBBZGFwdGVyIChNQU5BKSIpDQoNCklu
IHRoaXMgZmlyc3QgY29tbWl0IG9mIHRoZSBkcml2ZXIsIG1hbmFfcHJvY2Vzc19yeF9jcWUoKSBv
bmx5IGNoZWNrcyBpZiBwa3RsZW4NCmlzIG5vdCB6ZXJvLCBhbmQgbGF0ZXIgbWFuYV9wcm9jZXNz
X3J4X2NxZSgpIC0+IG1hbmFfcnhfc2tiKCkgdXNlcyB0aGUNCidwa3RfbGVuJyBibGluZGx5Lg0K
DQo+IE5vIG5lZWQgdG8gcmVwb3N0OiBqdXN0IHJlcGx5IGhlcmUsIGFuZCBJJ2xsIGFkZCBpdCB3
aGlsZSBhcHBseWluZyB0aGUNCj4gcGF0Y2guDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBQYW9sbw0K
DQpUaGFuayB5b3UsIFBhb2xvIQ0KDQpUaGFua3MsDQotLSBEZXh1YW4NCg0K

