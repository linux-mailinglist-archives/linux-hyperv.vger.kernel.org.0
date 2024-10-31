Return-Path: <linux-hyperv+bounces-3223-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD419B7F5C
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Oct 2024 16:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22146282DE7
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Oct 2024 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3A01A76D1;
	Thu, 31 Oct 2024 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F+V9AGjq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022139.outbound.protection.outlook.com [40.107.200.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8013AD26;
	Thu, 31 Oct 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390073; cv=fail; b=bmWW9gksBvoKmb/lCov3b7W+PDa6faY1RKG666oKICReucRKZ6FEbS+mVF0xqA5Ih0OiNrWjy2ilmqsCEQ0ULLXb3ADsB9aS1wQqSp2AzZnFs/IxOEjfhM4jBuFi+rsAnendkuY+TDOI3+IhTNVYb0PUMr0DxbALj8w4uWQDh6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390073; c=relaxed/simple;
	bh=e1xRrWpu2TmKys8sCQOgCVUNdMw+Wh+oti/pOq4tsAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oUwWyeA277OjLUVVSapcxzSXCwqWzqOCYzcRLWeqCxp0PHH/zCAFMLJu1c87OrD+87jLBvJavxgKEKxjy8ldblMNECD+TLpGGSyby7iAnbHi7yYl2CuLl5RHeDBQOSOkdkv/cq6qf3JqFD2OvISr4x7xgpgBRRMEK8uOe2EOy0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=F+V9AGjq; arc=fail smtp.client-ip=40.107.200.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mN6e4Cj3NiAlvfwiDAXDbKtgZwoirte5ST1ntdQvrhp/zbp47vucK1afc2DBe9EnxoYuOIOJA7NvPmZiQhmRTY1WdxAUUORZPE3DgPKy86TuzyIhMlUstjX+WR9cVuN3s2TOOyZtvpLDDInLeIz+u4CQKS8VozrgjP0W33AvhSkqbBZUgpOQp7KV2k2S8gtRXrqDvIRDuBRh9wGfyZ3YFGfzjgvWKAwJ9AoqDkoRWGtGSksN4x9V/07mNnp4bcAgQvwsADiLS2ZbtDdPxOhGtxoBA+sIAFCHq376s+ozO/qVyFbYvK0KX94nPZeOATSJiRmDp/oEinRrjRmg68YFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1xRrWpu2TmKys8sCQOgCVUNdMw+Wh+oti/pOq4tsAc=;
 b=XoJmQg78w0Kd+1SUEPTgey4WPYifQeR/ngLy6meDDrRA4acIWs0mQWB9ZHuyoZDAhjPMJLa+Jz+S3fMPhI9W2VBmXaLfI81j/ryXjMn9nRdp866AeZbo6ub/qTmhAkSVP8CYW5FVtTpWLjiLf7mtLfP3i2qfGXhLebYsXLcnDe9XHiZ5BOnXC1C2Iqkcoxhnp7NVCi41ajA2ZGQPeLT7kzJxwRH0so9SSrW6muciTiieXK8U/y3HouBVkauHd2kP2w39gAC13YeBwX2MUNrhzlNJTkBWr0hAZOF/tdDR0rv/VBosAhXGsAzlEqIw3z7N3c/VPdY7z09mEzuQIY888w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1xRrWpu2TmKys8sCQOgCVUNdMw+Wh+oti/pOq4tsAc=;
 b=F+V9AGjqMb5ZwIF04JShhOVYgkRM8CH1QHACdXwAeTPvj809L05D9O0kQbCOjnrfJpo02kybymh90nC+2iCrfHes41MfFwdTxp1ldJU1m9Ax4//UyVJVHC37CSBWUhkn/CeRW0cdwAfR1HkeoOBSKuQRn+x+d1XMzDTGrjWEedI=
Received: from SA0PR21MB1867.namprd21.prod.outlook.com (2603:10b6:806:ef::13)
 by SA6PR21MB4391.namprd21.prod.outlook.com (2603:10b6:806:425::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.7; Thu, 31 Oct
 2024 15:54:27 +0000
Received: from SA0PR21MB1867.namprd21.prod.outlook.com
 ([fe80::89d7:b5f0:88f0:ce8d]) by SA0PR21MB1867.namprd21.prod.outlook.com
 ([fe80::89d7:b5f0:88f0:ce8d%3]) with mapi id 15.20.8137.008; Thu, 31 Oct 2024
 15:54:27 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Praveen Kumar
	<kumarpraveen@linux.microsoft.com>, Naman Jain <namjain@linux.microsoft.com>
CC: Michael Kelley <mhklinux@outlook.com>, "Von Dentz, Luiz"
	<luiz.von.dentz@intel.com>
Subject: RE: [PATCH v3 1/2] jiffies: Define secs_to_jiffies()
Thread-Topic: [PATCH v3 1/2] jiffies: Define secs_to_jiffies()
Thread-Index: AQHbKvPZQr18YQXB106MlgZPikXLubKhAkLQ
Date: Thu, 31 Oct 2024 15:54:27 +0000
Message-ID:
 <SA0PR21MB1867075CEEBDFB9D909AFFF2CA552@SA0PR21MB1867.namprd21.prod.outlook.com>
References:
 <20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com>
 <20241030-open-coded-timeouts-v3-1-9ba123facf88@linux.microsoft.com>
In-Reply-To:
 <20241030-open-coded-timeouts-v3-1-9ba123facf88@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2dd06208-ee2e-409e-a010-fcf10ec636f6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-31T15:46:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR21MB1867:EE_|SA6PR21MB4391:EE_
x-ms-office365-filtering-correlation-id: a05099c6-7c94-4302-cf00-08dcf9c44c92
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mm13c21PL2lpUnVSSEpsV0ZXMzJXa1ZrNTJBWm5tVjNIa3lQN1pka2Fla1oy?=
 =?utf-8?B?V0lPY2NVaVVRcXZLQU5iMVhhNjNka0pQMWY3Z2RSVW4zRE81dXl6UlFVL3o2?=
 =?utf-8?B?RDhxcWp1bUhJNmI5T2RjSkl5cnRsNkkyZVBmVlpUdnJrWVd5VVYwS0QrYTZ0?=
 =?utf-8?B?eXdlUktQSE5UV0hhMlhwMFlSV2FXSi9Tb2R3Kzh4THdRdnZ6SHZxbUpwaGRz?=
 =?utf-8?B?ckE5RVc3ZWRlWFc1L3lpcmtCeHA5aFYra0hlRDViWTFmN0FDYzlaTHRvUG81?=
 =?utf-8?B?cnI1MUkrZzZWeXJaTlJMSmI3cmRCd0Qxb2xHT2R3MFptaHFtQUNGa1NaZVUy?=
 =?utf-8?B?RlpPMzk3bTNXMm44Z2RVT25qSm1FczY3S2dYd3JUY3J0TkVZais1dis4UU9D?=
 =?utf-8?B?TU92Z2hETlQ5OVQyZWc1cTV0aVByTlNMT1VJUndxN2lscXJWNDluMmU0M3dK?=
 =?utf-8?B?NUdYL2JyWi8wU21xNm1zMW02dUxuVUppVWJIT2RnWDJKcUtuLzc5UmxLRGFz?=
 =?utf-8?B?emlyNUFMakI4RHNhSXJRY1duSzFqNkp4bXpOVldyTWdqbFJveS9DZml3SjE5?=
 =?utf-8?B?N0k5a2REN0tTV3p5OEljYlIwb3hRYUxyRk5wRy8zM25NVzJuYVRFenVvbkgy?=
 =?utf-8?B?KzFLOGdzdi9TQjlaM0tySG5ON2dkQVB5ODEzd0w1b05pUmtQQzBZcG1Yb0Rm?=
 =?utf-8?B?VEU0L3pENDg5MWtyN3BhWThxeVVFS1JoM3BlLzY5VnVQcFJZQXMvM3Ztc24y?=
 =?utf-8?B?WUpCNitWZUJVQTRFOVNmTTlxU2t0V0NLUlZYYlJjNHFTN25nbGlDRnBCR3Nh?=
 =?utf-8?B?VHd5Z2t6UDR6MlRrV2ZCOFc0d0hoL1JnbnhKQTNYdEhKMlVvSS9SMitoOEZ1?=
 =?utf-8?B?eW50ejNXVjNMN1c3ZGhyNnBxN3VyUmZGelpWV2gzRTRHNG10WXhvZldVSHBN?=
 =?utf-8?B?aXFOZUE2UFJxZXdpYitJRWlKMWsrQlRSUzZYN0hpUmRMYS9JRjRWbFFPeTFT?=
 =?utf-8?B?aG83M2pqZUttRUswUEZSK25zT3BtVEV4WnNmVnFXU21BSjBsR0lqTVZpUHdO?=
 =?utf-8?B?UFF5SGlOY1ZZR2ZORW4vaWoxWWJzRlA1UExxR2J2L2pmL0RSYVZJZnFVakFU?=
 =?utf-8?B?WWVHeTNhOGdPWFpzL2Fhd0IxTmVlN3dVbnlsN3F3ODhlT1hCSEtQbVo5dDV0?=
 =?utf-8?B?RFhGUEE1dm51bnZWSHFWZnpmL0poY1VxWFlUSmRtNjBTb2cvVFg2eXpRZlF6?=
 =?utf-8?B?dDc1RVNybFM1a1ZHQUNTKy9xejBObUswRjFTVkxUbGcwZjhndWFaS1ExVms5?=
 =?utf-8?B?WUx6TXZKb0o1V3RRNnBaM2sxUGNmaisxM0RmR2pCb2ZNOEFrT2NZNWJsQ3ZX?=
 =?utf-8?B?bnFQdkRGZHBaMDFVVkYxRlF6T0FKRDRpbEdyV2tleXo5UTlrV2pwdjVwcVZw?=
 =?utf-8?B?Y3FUUWc1RTRXcXphQ0xMTkN3OWpHclFTNFl2QUNackNjRnc0TzE4Zm9JMnY3?=
 =?utf-8?B?TEttd21rSjd6WVZUMWIraldEZk90YWJiK1VQWnkrNVVVZjhyV1dteXAwdXVr?=
 =?utf-8?B?M3VVYXV3T1ZNcUE5SUVwS1dKR3dlVDgzZUg2aitpdnE0eEtCNTlNdVEzcEVP?=
 =?utf-8?B?Uk12MXpML0RXeDJKb0VRYTluT2M5akFobmpHMnF0Wm5qRjcrQ2YvdWFtYXJ3?=
 =?utf-8?B?WUdaNTE0Qm41akRqTXVtcys5QThUQnM4bVk2ZHFPaktmZG5yN1BXY2xaZzhF?=
 =?utf-8?B?ZWtWVjdmblFjNUloMVc3aGNINXNLT2xZcnRTNDJ4ekt3REp1bkFGSVRzcC9D?=
 =?utf-8?B?UGdYSnd4L3pOYVE1ZDBiV2tRVVBKVlVodGdFc095TC9mVkhSajBuQ3RGTEdT?=
 =?utf-8?Q?ojf5j9oHtVuaF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR21MB1867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDJqdzdtK0Rhd1BUWEJxUlFUckhSNXdiK1dQekpMZHh0WkY2aGpFcm56ZDhY?=
 =?utf-8?B?Z1BoUmZaQVp6KzY5Y3RBNWxGODlNcXRBYzRPcTV3V0R2dG1OVEtIcHljQ2I1?=
 =?utf-8?B?QXIzSWdJNXBwZ3RsSTB1TFJKRjdiaU5hTk02T3prZUZ0ZklRK1hFdW4wdDRL?=
 =?utf-8?B?QzNYU21mNlpEQ2FqejU4T1FSMExoMW9jUWs1ay9ld3dxVFlSNTZIUDdJczN0?=
 =?utf-8?B?c05Ec3hLNjZ0ODh1MFhENjJ6YnRPamZNeUlvVlVKeThEUm5Ha0dLOWtFTkM0?=
 =?utf-8?B?eERiR0tncGFYK1dQekdxMkpTeEhOdnNaTmd6VkhzVzViVE5Md0tnRVZCRWlm?=
 =?utf-8?B?YktYYXRjZkVDVzRwTUZRNVVXRTI0R2dUVXIrK2V0RzUreVN4Qk9OdllYZy8r?=
 =?utf-8?B?My9UM3BySFFEeDJMcURCaWVYRFlzdVlocmdaSW5tYVovMml0SStiQmljM0VQ?=
 =?utf-8?B?ZkJwT0kzc1ZkWlcvY2xjcCtIKzFrN3NOSUYxRGFlTjYyaGc3bzI0b2hNY3Fk?=
 =?utf-8?B?SlZObUlnaThYK04rbHhMVmk0R0ZmTE8yYlVXQzZVa1U2WlcyN0hocEliQ0tl?=
 =?utf-8?B?U21kRjRvWUpVWjJBR0tUYzc2UTFOcEtXZGR0TzZpSG5tSGR4L0I5OEZMaFpn?=
 =?utf-8?B?RjBjNHpVWmtyYXN1UUloSVRMNUw3SGUwM3VxSDQ5T3F4MVd3T0Qyc0hzTjlB?=
 =?utf-8?B?Q2JPbmxVUTRMdExabUhac2d5QTFXZ1dYa3RKbkU3dlV6Z3diNWNLTHBGNE41?=
 =?utf-8?B?bjM1MDlrYzlScHFpTG0xQlJuYi9PVlZEcTdSUDFhNVdNZTRNZTc1VXVJVmtN?=
 =?utf-8?B?RjRJMElIVGRKYVVpQTdHMHZCOHVzRWlJYWF0TXpHblZuQy9IVEZHTEVoTmFq?=
 =?utf-8?B?YmVoUDBvdHJZV3ovbDkveWJNMkRSY2JnSWJxQjBQa2JTcFhMS05LYjgzVVJu?=
 =?utf-8?B?bkMvMVI2blNsdkZKMStSeVNtL1VTSXAvaVhOaUZNY1Z6QzlQKzNxamw4ZGxZ?=
 =?utf-8?B?bWZXODhzNHErUCtQRFhtc1dMWlFYQ1E2VGsvUXVKK3VNeUk1blVNeERGem5F?=
 =?utf-8?B?SEthVnRkVEh0eDVOOUxUc2JDNUpUaFdHSStDTHhPWjNXSWgxQnpoczJSL1ow?=
 =?utf-8?B?L0RCVmEwNkwyRUNUTjlpdkJzaWw2Q0IybmFhSGpyNHgvRnllemRPamNHaWFR?=
 =?utf-8?B?QlZTUkFkTlVtVUdVSC9uWlp0aFIxZ0tYTzYvZzAvd29TUHE3VDJsOEhMMWds?=
 =?utf-8?B?RE91UXplOG5TdE5YRUpqbUZ5VDBldFZLVzAwalRzdHgyRnFncGdFYk9IRlR2?=
 =?utf-8?B?aHg4VDl6cWpseXRITS9yQ2svbW9lcHlialZndHU5ZEM3YjJOQTBnM0N0ZzZK?=
 =?utf-8?B?bDlNNjhPS0V3aGVVRHVaRHZLOWt5UzFlaU93VmNiVDNDVTBKWkJPSERiWU1j?=
 =?utf-8?B?cEVFZzRKY1pMZUh6RTQ2S01FT0VzWDkzNUw4SDNiK2twWEpoaFNPT0x1N2pQ?=
 =?utf-8?B?ZTVPV3l1NG82Q01yL0JNL0piYjlTTHRwVEJ2bUJVWVhXeDhneHBLUFNrcnhw?=
 =?utf-8?B?ZU4vNDI5bzFzNFJvRitCOWZoOTVjUEUvR2U5UnRTQzl4QlJGVytkWG5pSENl?=
 =?utf-8?B?a2Q5dS95MGltSTY0S0h2ZkNDY3ZhemhtNVVtL1E4R2E5eW94ZnNoUXFla0hq?=
 =?utf-8?B?VFVBRWlnSXRqZU1SdHVKZDM4YkI0eENndFNKcFZ5aFJ4U1F4L3BOL2hxdnN1?=
 =?utf-8?B?T0dtV1BvM280dGxzZjIwR21uaGNLM0hDc1hKQVp1SzkzdlAyTTRjazhqbHdF?=
 =?utf-8?B?SUxoZGk5NC9iV01xeWpseERkaXF0WnlSZEVzaElBMzhKVk1OTW5Qa1JXeXlr?=
 =?utf-8?B?NUozUW1FVUdCbXMySlA4clhMcXJuREZTNjhGbFo2L0ErSXN1NDBOa0RkZndv?=
 =?utf-8?B?MStGTDlJYjliWFZVd0hQT0JaK01oZytGOGlNS0xmdGxVVmZMMk10TEU2TlJ5?=
 =?utf-8?B?SHpyWHBQanp5QXdmSG9saVJnaHFoS2pndmxrenNXMHVwbXZ3QkFOVTU5Q0Z1?=
 =?utf-8?B?V2hjbXZmclZKR25DdFVnYTFRTCtGSldkRWhhN3RpcGlSelRabEVNcDNiYWVn?=
 =?utf-8?Q?PhfPVG9Ca8JKKVMa6DgOaCw60?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA0PR21MB1867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05099c6-7c94-4302-cf00-08dcf9c44c92
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 15:54:27.3003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1ghnBtMso1TgKozHi9nyd7GYeF9gVg2j7aihmaFimW0Ipajqdttiff6mzsozPw2TuwlPtr+G6891ymm9CjmbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4391

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRWFzd2FyIEhhcmloYXJh
biA8ZWFoYXJpaGFAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3Rv
YmVyIDMwLCAyMDI0IDE6NDggUE0NCj4gVG86IEtZIFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQu
Y29tPjsgSGFpeWFuZyBaaGFuZw0KPiA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47IFdlaSBMaXUg
PHdlaS5saXVAa2VybmVsLm9yZz47IERleHVhbiBDdWkNCj4gPGRlY3VpQG1pY3Jvc29mdC5jb20+
OyBsaW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnOyBBbm5hLU1hcmlhIEJlaG5zZW4NCj4gPGFu
bmEtbWFyaWFAbGludXRyb25peC5kZT47IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4
LmRlPjsgR2VlcnQNCj4gVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz47IE1hcmNl
bCBIb2x0bWFubg0KPiA8bWFyY2VsQGhvbHRtYW5uLm9yZz47IEpvaGFuIEhlZGJlcmcgPGpvaGFu
LmhlZGJlcmdAZ21haWwuY29tPjsgTHVpeg0KPiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50
ekBnbWFpbC5jb20+OyBsaW51eC0NCj4gYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgUHJhdmVlbiBLdW1hcg0KPiA8a3VtYXJwcmF2ZWVuQGxp
bnV4Lm1pY3Jvc29mdC5jb20+OyBOYW1hbiBKYWluDQo+IDxuYW1qYWluQGxpbnV4Lm1pY3Jvc29m
dC5jb20+DQo+IENjOiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+OyBFYXN3
YXIgSGFyaWhhcmFuDQo+IDxlYWhhcmloYUBsaW51eC5taWNyb3NvZnQuY29tPjsgVm9uIERlbnR6
LCBMdWl6DQo+IDxsdWl6LnZvbi5kZW50ekBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2
MyAxLzJdIGppZmZpZXM6IERlZmluZSBzZWNzX3RvX2ppZmZpZXMoKQ0KPiANCj4gc2Vjc190b19q
aWZmaWVzKCkgaXMgZGVmaW5lZCBpbiBoY2lfZXZlbnQuYyBhbmQgY2Fubm90IGJlIHJldXNlZCBi
eQ0KPiBvdGhlciBjYWxsIHNpdGVzLiBIb2lzdCBpdCBpbnRvIHRoZSBjb3JlIGNvZGUgdG8gYWxs
b3cgY29udmVyc2lvbiBvZiB0aGUNCj4gfjExNTAgdXNhZ2VzIG9mIG1zZWNzX3RvX2ppZmZpZXMo
KSB0aGF0IGVpdGhlcjoNCj4gLSB1c2UgYSBtdWx0aXBsaWVyIHZhbHVlIG9mIDEwMDAgb3IgZXF1
aXZhbGVudGx5IE1TRUNfUEVSX1NFQywgb3INCj4gLSBoYXZlIHRpbWVvdXRzIHRoYXQgYXJlIGRl
bm9taW5hdGVkIGluIHNlY29uZHMgKGkuZS4gZW5kIGluIDAwMCkNCj4gDQo+IFRoaXMgd2lsbCBh
bHNvIGFsbG93IGNvbnZlcnNpb24gb2YgeWV0IG1vcmUgc2l0ZXMgdGhhdCB1c2UgKHNlYyAqIEha
KQ0KPiBkaXJlY3RseSwgYW5kIGltcHJvdmUgdGhlaXIgcmVhZGFiaWxpdHkuDQo+IA0KPiBUTzog
Sy4gWS4gU3Jpbml2YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+DQo+IFRPOiBIYWl5YW5nIFpoYW5n
IDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPg0KPiBUTzogV2VpIExpdSA8d2VpLmxpdUBrZXJuZWwu
b3JnPg0KPiBUTzogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4gVE86IGxpbnV4
LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmcNCj4gVE86IEFubmEtTWFyaWEgQmVobnNlbiA8YW5uYS1t
YXJpYUBsaW51dHJvbml4LmRlPg0KPiBUTzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+DQo+IFRPOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0K
PiBUTzogTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1hbm4ub3JnPg0KPiBUTzogSm9oYW4g
SGVkYmVyZyA8am9oYW4uaGVkYmVyZ0BnbWFpbC5jb20+DQo+IFRPOiBMdWl6IEF1Z3VzdG8gdm9u
IERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gVE86IGxpbnV4LWJsdWV0b290aEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gVE86IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3VnZ2Vz
dGVkLWJ5OiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+DQo+IFJldmlld2Vk
LWJ5OiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50ekBpbnRlbC5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IEVhc3dhciBIYXJpaGFyYW4gPGVhaGFyaWhhQGxpbnV4Lm1pY3Jvc29m
dC5jb20+DQo+IC0tLQ0KPiAgaW5jbHVkZS9saW51eC9qaWZmaWVzLmggICB8IDEyICsrKysrKysr
KysrKw0KPiAgbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYyB8ICAyIC0tDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9qaWZmaWVzLmggYi9pbmNsdWRlL2xpbnV4L2ppZmZpZXMuaA0KPiBp
bmRleA0KPiAxMjIwZjBmYmU1YmY5ZmI2YzU1OWI0ZWZkNjAzZGIzZTk3ZGI5YjY1Li5lMTdjMjIw
ZWQ1NmU1ODdmZDU1ZmI5Y2Y0YTEzM2E1DQo+IDM1ODhhZjk0MCAxMDA2NDQNCj4gLS0tIGEvaW5j
bHVkZS9saW51eC9qaWZmaWVzLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9qaWZmaWVzLmgNCj4g
QEAgLTUyNiw2ICs1MjYsMTggQEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB1bnNpZ25lZCBsb25n
DQo+IG1zZWNzX3RvX2ppZmZpZXMoY29uc3QgdW5zaWduZWQgaW50IG0pDQo+ICAJfQ0KPiAgfQ0K
PiANCj4gKy8qKg0KPiArICogc2Vjc190b19qaWZmaWVzOiAtIGNvbnZlcnQgc2Vjb25kcyB0byBq
aWZmaWVzDQo+ICsgKiBAX3NlY3M6IHRpbWUgaW4gc2Vjb25kcw0KPiArICoNCj4gKyAqIENvbnZl
cnNpb24gaXMgZG9uZSBieSBzaW1wbGUgbXVsdGlwbGljYXRpb24gd2l0aCBIWg0KPiArICogc2Vj
c190b19qaWZmaWVzKCkgaXMgZGVmaW5lZCBhcyBhIG1hY3JvIHJhdGhlciB0aGFuIGEgc3RhdGlj
IGlubGluZQ0KPiArICogZnVuY3Rpb24gZHVlIHRvIGl0cyBwb3RlbnRpYWwgYXBwbGljYXRpb24g
aW4gc3RydWN0IGluaXRpYWxpemVycy4NCj4gKyAqDQo+ICsgKiBSZXR1cm46IGppZmZpZXMgdmFs
dWUNCj4gKyAqLw0KPiArI2RlZmluZSBzZWNzX3RvX2ppZmZpZXMoX3NlY3MpICgoX3NlY3MpICog
SFopDQo+ICsNCj4gIGV4dGVybiB1bnNpZ25lZCBsb25nIF9fdXNlY3NfdG9famlmZmllcyhjb25z
dCB1bnNpZ25lZCBpbnQgdSk7DQo+ICAjaWYgIShVU0VDX1BFUl9TRUMgJSBIWikNCj4gIHN0YXRp
YyBpbmxpbmUgdW5zaWduZWQgbG9uZyBfdXNlY3NfdG9famlmZmllcyhjb25zdCB1bnNpZ25lZCBp
bnQgdSkNCj4gZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMgYi9uZXQvYmx1
ZXRvb3RoL2hjaV9ldmVudC5jDQo+IGluZGV4DQo+IDBiYmFkOTBkZGQ2Zjg3ZTg3YzAzODU5YmFl
NDhhNzkwMWQzOWI2MzQuLjdiMzVjNThiYmJlYjc5ZjJiNTBhMDIyMTI3NzFmYjINCj4gODNiYTU2
NDNkIDEwMDY0NA0KPiAtLS0gYS9uZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jDQo+ICsrKyBiL25l
dC9ibHVldG9vdGgvaGNpX2V2ZW50LmMNCj4gQEAgLTQyLDggKzQyLDYgQEANCj4gICNkZWZpbmUg
WkVST19LRVkgIlx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwIiBcDQo+ICAJCSAiXHgw
MFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDAiDQo+IA0KPiAtI2RlZmluZSBzZWNzX3RvX2pp
ZmZpZXMoX3NlY3MpIG1zZWNzX3RvX2ppZmZpZXMoKF9zZWNzKSAqIDEwMDApDQo+IC0NCj4gIC8q
IEhhbmRsZSBIQ0kgRXZlbnQgcGFja2V0cyAqLw0KPiANCj4gIHN0YXRpYyB2b2lkICpoY2lfZXZf
c2tiX3B1bGwoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHN0cnVjdCBza19idWZmICpza2IsDQo+IA0K
PiAtLQ0KPiAyLjM0LjENCg0KQWxsIGxvb2tzIGdvb2QuDQpCdXQgY2FuIHlvdSBjb25zaWRlciBu
YW1pbmcgdGhlIG1hY3JvIGFzIHMyamlmZnkoKT8gSnVzdA0KdG8gYmUgc2hvcnRlciwgc28gYWZ0
ZXIgYWRvcHRpbmcgdGhpcyBtYWNybyB3ZSBkb24ndCBoYXZlDQp0byBzcGxpdCBzb21lIGxpbmVz
IGZvciBvdmVyIDgwIGNoYXJhY3RlcnM6KQ0KDQpUaGFua3MsDQotIEhhaXlhbmcNCg0KDQo=

