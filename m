Return-Path: <linux-hyperv+bounces-3428-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B919E888A
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 00:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5921280F3B
	for <lists+linux-hyperv@lfdr.de>; Sun,  8 Dec 2024 23:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09962189F42;
	Sun,  8 Dec 2024 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NjZlelzH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010015.outbound.protection.outlook.com [52.103.11.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152C13E47B;
	Sun,  8 Dec 2024 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733699540; cv=fail; b=ggFedAp+78y7YMWrEwViHuctarCKMe84pW2lmd3hrVN3XpfHRP0Lvqq6MXXrc/V4bz8Nx7i61gwWlvFEZaOfYhrrMK8Fei8yX8Luz2gaBBHxh3VULWrpSGCPLKEZNJFr02d7q0UgAeqwLayd1GoyqE15E1VNEoa8fvKkAshUHIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733699540; c=relaxed/simple;
	bh=utI0h8T0PKCH5YGUFBFrQyhpXbasBC12CrDhr+7aH3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gy1GwovtlXTHXvsqyebqHXLFE8VKDGvua7dZf4AeVqSJr9Up1IOMD/Far6x/fWHr+pM+X6FhulSBCH5Upxsczg1Xn3F+GcZw8bY98agAfUCcm2InnY11AJvQBwxvoCin8yzRIavXWefHlAUHunUiH5199fXOAJWTf30bMUK29sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NjZlelzH; arc=fail smtp.client-ip=52.103.11.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Av+YCDVOIh+0tV2dLAIBaUlH8lsPHzp6mYNQQIm/hzmGTYVxUEsekJrbA352CAdcxJJN3WklXwr6X//GzV+jlLiwSHogst6GIKtrhNIcd+1n6lBrlO9MCM7qI50sZ5bp2zr5k0VgvNPO8ey0/3wztyqxm7XABnOr75w1gDWb44owgeVFqTHDF4ITFTGhOhiqHuk+vqBqhMbFoeAm+OapNNIDk9K0/3L/uJWs4+JxN7y7JUEFWgIXhE48VH3XAJSQT4R6KknlNLuaeqnaT2cUxtZ9nwqQ7M60OKEeJSF0MO0wj88K753MNuquZ2PV5GoqTb1eQb3ohBP/6DqNgMkpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utI0h8T0PKCH5YGUFBFrQyhpXbasBC12CrDhr+7aH3Y=;
 b=ItXzZVMzbbRhqVjnNPylGBiaU/a7sGXFjGAB8NkyMijfmLjJJotD2tlPXDmOyMJA68FIfdAYSUKF0P4V1W0/R3DfgjhtZtiuIqoeffXrUIZAZHyCtd0ijgAyn9LzncJDJdoXQzsqtqHhlI4xgzFh76GeqXXfzj+U2Om5xh803NAggcbLx1beb8179keK0HFC75IS6c8R/Wfg2ja+13k9RDpcWRIjqFhXX6c+QtOEdJZbwWTtDfbAIT3aQRdhLHGpdYkNn4t+IoQew7Z1aZ2hK7/dfXb/ABWzpEi6IID0UjK1PP99BLieLil9aDBtO2gsRQeKuo2J5NsjZVPz9UFjKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utI0h8T0PKCH5YGUFBFrQyhpXbasBC12CrDhr+7aH3Y=;
 b=NjZlelzHzqfrlwEf2r6xbNWoANzYW0ofIfqXBDWGIYP+OpeU6UfSvF7L8hULJIalacQ8u/w7GoVwskttUE0tAlgvs+amdhaAh/Kr9nifoCQwwAsGsDGUudsDIWs6gGX817I+pTDo8TAeuorUvNNwKpc8BoELJUiTSobf+001BMebCQwef0HJacCqw1726tr5AdNpCuxopY8L2J1SdkZhZjBwVNlZo6nEqk/b9Tdd1UWrdCilnoFwoM47B0hpuNXU3IDIUY9/ds2ATYHq6Cq60RKxz3gs8pkeI5GftiapBu6bplcSb6OAh1toca5eblJIkvstQmH7cOxP3YGMMl5u+g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB7038.namprd02.prod.outlook.com (2603:10b6:208:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sun, 8 Dec
 2024 23:12:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8207.020; Sun, 8 Dec 2024
 23:12:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] Drivers: hv: util: Don't force error code to
 ENODEV in util_probe()
Thread-Topic: [PATCH v2 1/2] Drivers: hv: util: Don't force error code to
 ENODEV in util_probe()
Thread-Index: AQHbMGKhT+aDSVHoNEWMSquV4hpMcbLczRKAgABdLJA=
Date: Sun, 8 Dec 2024 23:12:15 +0000
Message-ID:
 <SN6PR02MB4157ED3DA55558829D6152D5D4332@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241106154247.2271-1-mhklinux@outlook.com>
 <20241106154247.2271-2-mhklinux@outlook.com>
 <20241208173049.GA14100@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20241208173049.GA14100@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB7038:EE_
x-ms-office365-filtering-correlation-id: 5da46efc-6159-4ae7-5313-08dd17ddc18c
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|15080799006|8060799006|461199028|19110799003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1RZeGhlQWRweWFwRlZVLzNwQlFaZTRjakU4ckZCVHZwM3BXVUNmS0dyalRz?=
 =?utf-8?B?ZmxWL1ZzWTdKRlZlOXBTRlY2bE44Y2dYR3h6eEpaOG9jeVZEYVJvaG9JcjRz?=
 =?utf-8?B?aU9ZZHJtSUs1WkFaNFdBRmw1WENJTVFwMlNiY2dPUUZ4ZUtDRkFLQnZpb3VE?=
 =?utf-8?B?czFGdkNzdnVjRDJhcFRXeWY2M0NoMXc3cFJRWEpsUERkV2pRd0t0SzRaeDdB?=
 =?utf-8?B?ZHdRNFg4YWlBSGk4QUFvdndxQUo4RWduMGxla3p4WGxKU0ZkZTZUL1R4VnNx?=
 =?utf-8?B?NEpSVjMvL3ZwVks2eTROTnNUb05rTWVva3lQS0Rtc1ljR2pMbEVmazYwVnFi?=
 =?utf-8?B?ZGMwSFJsdlJYYW0yZEJhVVlJODRqVHh4K1l1Q1hlOUdJQ1BpdUpyU3FzMDh2?=
 =?utf-8?B?MVEyd3dvSWxnQWNXZGhBWU5WdXZVbW5LZjQ4ci9mSnNEZndMbHZGVG5obStH?=
 =?utf-8?B?cGtBV1dUekRGZXdBVjFJYTRoSFlkMktibmR5bjRua1p3cmRpRFlWdFU3VklO?=
 =?utf-8?B?OEUvS2t3Q1lDMjcydDliSWtXWmNSNzZqZ0llK09mWThmNU5tWFVQYnY2ZElI?=
 =?utf-8?B?aW5CS2kyWFU1bTczMWl1bzU0K29PY3NtUnkxWXlVRmZsUWtTb21TOS9wRWhS?=
 =?utf-8?B?TWczZndGQWduU0tlY1ZKalZWaTVGMFVRdG9WcytYbklwdlFpOXdtSm5pK20y?=
 =?utf-8?B?VVl1cGRCVEpIall4a1VvUVRQVTlBRlU0dzlNOHVndG4vWStLL1RXWFNOUlI3?=
 =?utf-8?B?R2xkcFNFWlMvbVRqNlZvTUt6NXNkbEVXaXgxLzlDTkhrT1dPd1M5UHNUdTl2?=
 =?utf-8?B?amhUT1pSZUV5b0NnWldrdjNuenUvcUFGaFkrekNiMlFOdEFyeGVzMkZBb1hF?=
 =?utf-8?B?NUFQK0pEWkZ5VUlxU0xkVVdmbEVuVVVIT1pCS2l1YklFMG9SMmVnNlJScTZK?=
 =?utf-8?B?QmZDbEFRR2Ixd3JOYnduTEpyYnBac0duVU1tb3VMTGNYYzdFQlh0LzRlVGxL?=
 =?utf-8?B?cmNVUkJacnNjaTBhZW1OVk9HYWoyM1hhOGl0ZGR6d3ArV2NQTzFvalZtMjJs?=
 =?utf-8?B?RzNuRFBPMzJhaDIwNjNmZ1NpMVl3S24rVkpCSWROMzU1M1VuRXBhc01TR1dt?=
 =?utf-8?B?MXo0NjBlTlprK0F2VDRMSXJiaWEwVXFGVGE2NEkyeXNUVWxlNmJ1RjR5Y0ps?=
 =?utf-8?B?L0lOb0M2RzA4TWZpTFh0a29YRUFMRGRSekNiNEtvUkdQN1FBam1lYS9uMXpQ?=
 =?utf-8?B?d040bWEwS1R4clFLdUszVFA4b2hMTU84eTRNSmt6Qmx2VUU5ZzR0eW1EeWNX?=
 =?utf-8?B?SWFCeUpZb2l1SFYzaWxndnZmL0c3Q3ZSWTh0QzMxcXZlQklCMmMrWVpBY0Zx?=
 =?utf-8?B?WlcrMkpvWFJwaUE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTcyaWhnMWdoMzZEZGhmR1VQYUhnSU1XaStJZzlYT1VQSUd1RnJ3QVlOZE1t?=
 =?utf-8?B?U2RDc0xKYTcvelg4RUI4d3RJaW1HMDNCNUJiNDA2S1JqOWczSzZMd2xqTG81?=
 =?utf-8?B?RGlJaGx6MnpXeDNBYzhEam5yenJFanF4YUk4M1c2eWkybnloeE5GenZ0YlRJ?=
 =?utf-8?B?aGhqVDV1TWxKblB3b3IrS01VY0sxcVVZQVF6MStZNlpoMjVXSmRpc2ppekdN?=
 =?utf-8?B?MHg2Q3RaVlJYNG5ocThqa1l1ejhFUUtaQ2VRdTNHNWxCZ3F4eVd1SGZtemtJ?=
 =?utf-8?B?b09iWjFxN2NXbEFZS3FxbzN3bkk5dGV5aHp5cmNydGMwSlVvSDNxUElycGt4?=
 =?utf-8?B?U1FSSTJ2TEtGM1pScGJyd3BubFE5NkVWYVdoaXhFR1FEcTZseG1OWFI3clli?=
 =?utf-8?B?c1p0N1lobGxrd2hUTU5QeXpYejVHSUpsSDRkaUZUSDdwZEgrZlRpVVdEQmEr?=
 =?utf-8?B?WjVwVnlLeXVRcG5lZlc1UXVEbjkwa0JhQUMyU1BmWHI2ZEVDTWVnTkh3WDRG?=
 =?utf-8?B?cCtIY0pvZjNYTE9LNmE0Yk9IK0FXUVBFUGpzOXhIblVlc2Erb0JGN29vWlRS?=
 =?utf-8?B?VDM4R2RjVnVneGtNcTZ4OHBrbjNiMC9uM0hkUWh6V28yYlRldGNIakd2MVFI?=
 =?utf-8?B?TTF6ZEdaQlFMNk1DUG4zaXV2amp5bFpUSTFYeUVZYVVZci84YWJHTjhJYkVB?=
 =?utf-8?B?K2thekU3dnY3b2ZkeXVZMXEzNEFxbkhYRWhkT21WaVJ3NXNGcHN3MVE1T3BU?=
 =?utf-8?B?U1ovaUFlaWFiNWJ4bXVSN2U1bFo1Slh0OU5YL3ZPQnU4bjFTMkgxb1pYRStm?=
 =?utf-8?B?dUQ4d25na0h1UzNBNXNBOENoVTJsQVNYalF2eENCMjZmNzZBMkpnZWdYT0xJ?=
 =?utf-8?B?bnFnMUNFd3Q5UkxiL3dYZGdxYllLY2F2N0pkRCtsNzJLRmtxV0dBQysxQ2VZ?=
 =?utf-8?B?dDJhazFYNEM4VnpsM1J0a041Mi9pblNTLzFialo5T0FSb0tKMFhOTXA4UnJF?=
 =?utf-8?B?UzZVd1dOYWFrSksxMjllUjY5NTA3VWxpSldUTGFXVVd6QVdBVFlnemNScGVp?=
 =?utf-8?B?ckdtcmVQRTdBMlhUcStRbm1DWnQwak9WaUtJMDZLWjR3dW84WHk2azZhRzJv?=
 =?utf-8?B?NzFlZkZxR1NidnpyRkJtQ0lEbG85RUF1MkRvMjA4NWNlUEV0RlBPMTVpY2VM?=
 =?utf-8?B?NTFXZDNqU3A4RDlQTUQyUWhXdVN4VkRjNXhkQzhBUjllRFI3dnRjcFhnS2I3?=
 =?utf-8?B?QVBkQmF6Y29DRHMrNXdWN1JMNjc1TlM2UHFXVXBHcjVSTU9MblJVN0dMQ0lB?=
 =?utf-8?B?Ylc5NEp1dmRzRUJWcDNDcktFRjNGa1JCSS93a1g1dlVCZDRYWUFpUlRUVUNF?=
 =?utf-8?B?TzNjMVZBUUNBNjNtdEdEZFNpT3VNeTkyRDVCKy9TMUZzckdSam5QS0w3Smtx?=
 =?utf-8?B?ZUNyb3hqaHpBV1ovSE1VaGZHdVZpMmMvUzJqdEtTRWtCdkowbDNqbTBjMkhk?=
 =?utf-8?B?TFJUSUhoVXE5cmFuK1JpNStHdE1jdlVBVmJ4ZjVyUmxiQ1ZuZS9uenRHR3BJ?=
 =?utf-8?B?VHUxU1dmQWFwTmFHYWc3UnhKYTZlMlRqeHZTKzVqZVlGajNPZ1ErZVZMa1BF?=
 =?utf-8?Q?w3BmUxRlGzp7h32WNocJhVxh/yOuL/E1LV9VCjQRSDBQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da46efc-6159-4ae7-5313-08dd17ddc18c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2024 23:12:15.8352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7038

RnJvbTogU2F1cmFiaCBTaW5naCBTZW5nYXIgPHNzZW5nYXJAbGludXgubWljcm9zb2Z0LmNvbT4g
U2VudDogU3VuZGF5LCBEZWNlbWJlciA4LCAyMDI0IDk6MzEgQU0NCj4gDQo+IE9uIFdlZCwgTm92
IDA2LCAyMDI0IGF0IDA3OjQyOjQ2QU0gLTA4MDAsIG1oa2VsbGV5NThAZ21haWwuY29tIHdyb3Rl
Og0KPiA+IEZyb206IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCj4gPg0K
PiA+IElmIHRoZSB1dGlsX2luaXQgZnVuY3Rpb24gY2FsbCBpbiB1dGlsX3Byb2JlKCkgcmV0dXJu
cyBhbiBlcnJvciBjb2RlLA0KPiA+IHV0aWxfcHJvYmUoKSBhbHdheXMgcmV0dXJuIEVOT0RFViwg
YW5kIHRoZSBlcnJvciBjb2RlIGZyb20gdGhlIHV0aWxfaW5pdA0KPiA+IGZ1bmN0aW9uIGlzIGxv
c3QuIFRoZSBlcnJvciBtZXNzYWdlIG91dHB1dCBpbiB0aGUgY2FsbGVyLCB2bWJ1c19wcm9iZSgp
LA0KPiA+IGRvZXNuJ3Qgc2hvdyB0aGUgcmVhbCBlcnJvciBjb2RlLg0KPiA+DQo+ID4gRml4IHRo
aXMgYnkganVzdCByZXR1cm5pbmcgdGhlIGVycm9yIGNvZGUgZnJvbSB0aGUgdXRpbF9pbml0IGZ1
bmN0aW9uLg0KPiA+IFRoZXJlIGRvZXNuJ3Qgc2VlbSB0byBiZSBhIHJlYXNvbiB0byBmb3JjZSBF
Tk9ERVYsIGFzIG90aGVyIGVycm9ycw0KPiA+IHN1Y2ggYXMgRU5PTUVNIGNhbiBhbHJlYWR5IGJl
IHJldHVybmVkIGZyb20gdXRpbF9wcm9iZSgpLiBBbmQgdGhlDQo+ID4gY29kZSBpbiBjYWxsX2Ry
aXZlcl9wcm9iZSgpIGltcGxpZXMgdGhhdCBFTk9ERVYgc2hvdWxkIG1lYW4gdGhhdCBhDQo+ID4g
bWF0Y2hpbmcgZHJpdmVyIHdhc24ndCBmb3VuZCwgd2hpY2ggaXMgbm90IHRoZSBjYXNlIGhlcmUu
DQo+ID4NCj4gPiBTdWdnZXN0ZWQtYnk6IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29t
Pg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjI6IE5vbmUuIFRoaXMgaXMgdGhlIGZpcnN0IHZl
cnNpb24gb2YgUGF0Y2ggMSBvZiB0aGlzIHNlcmllcy4NCj4gPiBUaGUgInYyIiBpcyBkdWUgdG8g
Y2hhbmdlcyB0byBQYXRjaCAyIG9mIHRoZSBzZXJpZXMuDQo+ID4NCj4gPiAgZHJpdmVycy9odi9o
dl91dGlsLmMgfCA0ICstLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAz
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvaHZfdXRpbC5j
IGIvZHJpdmVycy9odi9odl91dGlsLmMNCj4gPiBpbmRleCBjNGY1MjUzMjU3OTAuLjM3MDcyMjIy
MDEzNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2h2L2h2X3V0aWwuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvaHYvaHZfdXRpbC5jDQo+ID4gQEAgLTU5MCwxMCArNTkwLDggQEAgc3RhdGljIGludCB1
dGlsX3Byb2JlKHN0cnVjdCBodl9kZXZpY2UgKmRldiwNCj4gPiAgCXNydi0+Y2hhbm5lbCA9IGRl
di0+Y2hhbm5lbDsNCj4gPiAgCWlmIChzcnYtPnV0aWxfaW5pdCkgew0KPiA+ICAJCXJldCA9IHNy
di0+dXRpbF9pbml0KHNydik7DQo+ID4gLQkJaWYgKHJldCkgew0KPiA+IC0JCQlyZXQgPSAtRU5P
REVWOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gIAkJCWdvdG8gZXJyb3IxOw0KPiA+IC0JCX0NCj4g
DQo+IEFmdGVyIHJldmlld2luZyBWMiBvZiB0aGlzIHNlcmllcywgSSBjb3VsZG7igJl0IGZpbmQg
YW55IHNjZW5hcmlvIHdoZXJlDQo+ICd1dGlsX2luaXQnIGluIGFueSBkcml2ZXIgcmV0dXJucyBh
IHZhbHVlIG90aGVyIHRoYW4gMC4gDQoNClllYWgsIEkgbm90aWNlZCB0aGUgc2FtZSB0aGluZyB3
aGVuIGRvaW5nIHRoaXMgcGF0Y2ggc2V0Lg0KDQo+IEluIHN1Y2ggY2FzZXMsDQo+IGNvdWxkIHdl
IGNvbnNpZGVyIG1ha2luZyBhbGwgdGhlc2UgZnVuY3Rpb25zICd2b2lkJyA/DQo+IA0KPiBBZnRl
ciB0aGlzIGVlIGNhbiByZW1vdmUgdGhlIGNoZWNrIGZvciB1dGlsX2ludCByZXR1cm4gdHlwZS4N
Cg0KSSBkZWNpZGVkIGFnYWluc3QgbWFraW5nIHRoZXNlIGNoYW5nZXMuIEl0IHNlZW1lZCBsaWtl
IGNvZGUgY2h1cm4NCmZvciBub3QgbXVjaCBiZW5lZml0LiBBbmQgdGhlcmUncyB0aGUgcG9zc2li
aWxpdHkgb2Ygc29tZSBmdXR1cmUNCmNoYW5nZSByZWludHJvZHVjaW5nIGFuIGVycm9yIGNvZGUg
aW4gb25lIG9mIHRoZSB1dGlsX2luaXQgZnVuY3Rpb25zLA0KaW4gd2hpY2ggY2FzZSB3ZSB3b3Vs
ZCBuZWVkIHRvIHB1dCB0aGluZ3MgYmFjayBsaWtlIHRoZXkgYXJlIG5vdy4NCkNlcnRhaW5seSB0
aGlzIGlzIGEganVkZ21lbnQgY2FsbCwgYnV0IG15IHRha2Ugd2FzIHRvIGxlYXZlIHRoaW5ncw0K
YXMgdGhleSBhcmUuDQoNClRoZSBjaGFuZ2VzIHlvdSBzdWdnZXN0IHdvdWxkIHByb2JhYmx5IGdv
IGFzIGEgdGhpcmQgcGF0Y2ggaW4NCnRoZSBzZXJpZXMuIFdlaSBMaXUgaGFzIGFscmVhZHkgcGlj
a2VkIHVwIHRoZSB0d28gcGF0Y2hlcyBhcyB0aGV5DQphcmUsIHNvIGl0IHdvdWxkIGJlIGZpbmUg
dG8gY3JlYXRlIGFuIGluZGVwZW5kZW50IHBhdGNoIHdpdGggdGhlDQpjaGFuZ2VzIHlvdSBzdWdn
ZXN0LCBpZiB3ZSB3YW50IHRvIGdvIHRoYXQgcm91dGUuIE15IHByZWZlcmVuY2UNCmlzbid0IHRo
YXQgc3Ryb25nIGVpdGhlciB3YXkuDQoNCk1pY2hhZWwNCg==

