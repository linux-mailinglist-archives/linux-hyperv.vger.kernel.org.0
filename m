Return-Path: <linux-hyperv+bounces-3348-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CD69D6433
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Nov 2024 19:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0AFA281639
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Nov 2024 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065571DFE03;
	Fri, 22 Nov 2024 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WQxkEBth"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010000.outbound.protection.outlook.com [52.103.7.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC2B1DFDA7;
	Fri, 22 Nov 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732300398; cv=fail; b=h5b8fPfeU7qoGloLBHZvRVs6Q9AGj/UYCypiRF7SyzcN1TIlxLakYfujXyBgNt/42XylwtTIFCnl58mA4jjM5ZoW5bt942h9i7pZu/npynHPn41Mi9NJxap6c4s9oCUS9QwuN682lNASxu8ORnZpn95zchtZnOosTWOzHqj3yuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732300398; c=relaxed/simple;
	bh=Q5qg5JeZH5/KhA2/PSz85lnuPRuUwBL+AqC99Y2U+vg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BP4CWMyfTJeNQkbzf9fswWVQAcRU8MoR10yhmaWBjWUjGw8z9PakBBW8pgsJKTBE5ji4fTHUTfgC6khmrYSHJAApqs3xb5v8DSGIZZPfElH1J5sE9VlIh8LaBpLkIR3fTd3sRfw60ucrt5POWDb3ufJnspSSbog5zOwuxTPxgw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WQxkEBth; arc=fail smtp.client-ip=52.103.7.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEmc7YoGaKZZUkbhrSzuoFPU8E9svfn5Qvgm58uwKpwbb5KLhIFAZyLt2KPmxbhI17Lm1qeU5E0eg7wRGLOO2TcrJbdUG7YkVt12s2dZCtVz01yR5r+PabVCzu3335CesKnI5JOpWqU7aK/GgZX5naCoRUFqPOrtyQ2v7FzOt8tvPNhCd+hMwzfD+upryfqtPUx91oXFvWSHKLgWn0HvgHOM5G2gSB/2tmYEEf/UNCKzitXrcA4b8CcSTxos4sdY438BvVdbbZrpy0h/bpbARxXGF55xZERzqGps/LlY/Fpg4i8yWu0/6QVVjKSqjuX28G92s8wa92dmB5N+57wNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5qg5JeZH5/KhA2/PSz85lnuPRuUwBL+AqC99Y2U+vg=;
 b=MWHXwrrNjkCTO5nTS4w2a7dgefyPIp6spgX3dAyF0sV97fxsV9lt+V6O2sa/J+6l1S6Ddp8mDlj457m0rMp8Vs/g3OL+HdI1/h34tdKMJ6UvYKpFHKMRSG0BfRZO6UIT8VYnJDMMyDnSgWeDsMAQeLAJ4e4ExqfpvSc+o/j+YmfjJhiel5sM7+akcDIsCc4ppdwSznD0MEJJfDsVCM85q2Hh0wV+n/eBH6ov5NQNAJKbdmJD3ENhGQygDIrKL4UDgBRvy6KhnkN8JaUxyybaoBddy4t7lmyfsP/OURiMhP9tX93qRHRSK8JMtNq9aRH85zH0Y7oJIPYNCU7OYMa7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5qg5JeZH5/KhA2/PSz85lnuPRuUwBL+AqC99Y2U+vg=;
 b=WQxkEBthALWpRQLk5KHbROR0+xeTBt4EKGRniJ0huTUteebhcZAl72+EdMA+f3ZuGQpmSr7k2saazQ5syXkBY5QqE8bRigEQHCVY+LDHVZuYHa5/7sUa3uonAYW3wxEaaysCz4gXpDeqEDEFqV7Q25MuC4V+lUp35ojJXkYWogtnG+7iaBI8DoMlYK5Q/u/Q+q5QPl5snpufzMGjyrVVX19igTBgr5nhUc1YEQDQJVkMEHqj5MxRviQnjwi5fH3nPgk+TKcRpIFE5Tq93MqRtnlP4yRvfNz0Z0Y/8Wz52BVGrDtsSUIkcT1lgdDzVuIZ/oFw3WjF7RQVe38ClEt5ow==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY5PR02MB8870.namprd02.prod.outlook.com (2603:10b6:930:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 18:33:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 18:33:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyperv: Set X86_FEATURE_TSC_RELIABLE unconditionally
Thread-Topic: [PATCH] x86/hyperv: Set X86_FEATURE_TSC_RELIABLE unconditionally
Thread-Index: AQHbNS9UbXwh5KJBoU2oxHpKRgf4mrK0CjPAgAtX/gCABEfyYA==
Date: Fri, 22 Nov 2024 18:33:12 +0000
Message-ID:
 <SN6PR02MB4157121B6CD9F5CAAFB39637D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <173143547242.3415.16207372030310222687.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB41575A98314B82C498A3D312D4592@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20241120005106.GA18115@skinsburskii.>
In-Reply-To: <20241120005106.GA18115@skinsburskii.>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY5PR02MB8870:EE_
x-ms-office365-filtering-correlation-id: 39e6a0ef-4173-4c6e-7ce8-08dd0b241ee5
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|19110799003|461199028|8062599003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGdLOG83ZDBEUXpMWFZkamx4aGhtc2lRT2VsZnU0a0JvSHEvaGpmVWdrWVNP?=
 =?utf-8?B?cStacm9ENENoS21lMU00amJLWnA3TndMdThkVlk0Ulc3NlNmemlwbDJ2Vnkz?=
 =?utf-8?B?S2xJQ3gvSkxYaXJDTlRZWDNYTi92Y01GTzR3akJpRSthbjc3TFRnbmtjemJl?=
 =?utf-8?B?RFZuTGxoeE1nNlBPRERUOUdZRE5IZGJmZTJlazFRbFNnUjVCWlhUS3R3RjRk?=
 =?utf-8?B?ZHgweUJWQVU0MjVtbkp4VnVnb21wWmx1RGRwckRodCtxZ1hZZ0QxcE9UZHlT?=
 =?utf-8?B?aU5zSWlZRTFUQ1pxbnp3WGE1aVZDS2ZKOUd5Rk9Sc0MrTitmMEhkRjlHUUlK?=
 =?utf-8?B?c3owU20rS082R2JMSFFhVG1nY3dEZ3I0UGVUTk1BMkU2U1JndXJBVFRrUm1X?=
 =?utf-8?B?TUg1VHJtNTNjcW9TYTZGVTd0WnI2L2twNlJRUDgvMmN6bDU0K3kwY25HTG9S?=
 =?utf-8?B?OXIyeGFmRjVaV1BlKys5OFZuY3VJRHBGSDh6eGRoKzkwME56NFEranhjZkRX?=
 =?utf-8?B?UnpPYUFqanZ2ditwb01qcDFXSCtiL21YVURROUlmZnhXcDd2QW41VnNyYWcv?=
 =?utf-8?B?REpVNnhFakNtM3E2TERxelNPL1NGbnYwdGlkZFpmM3d0aW5FSnNpTmpudlhT?=
 =?utf-8?B?NmhjSDA3M0lEYUx5VUp2RGFXMGZVeWJpd2xoZWV1YnpmYVEzS2src2d2V1BX?=
 =?utf-8?B?c3R3Q0VDZ0JtL3lmdHVnVTF1LzJvdkxzMlc2bVoyRkFTeXVYUCt3VVp4UFdS?=
 =?utf-8?B?U2NVTkxVcmRKUUhSVlNObjFJdTdmY3FJTTMxS0ZTMUFQWXdnVWdQM3hNcTRJ?=
 =?utf-8?B?UGorQjZYb0VwWE1hQkY3WVhhU3pNZkVlZkwrVEpuMzVIdTQyNVJodXlVM2M5?=
 =?utf-8?B?N042VkV3Y00wblNnSHJxS3hzazRhNlYvQ1ZjZ01zU25KV09PZHVMNVRJV1dP?=
 =?utf-8?B?NDd2SVhnNmFRUTJxbkRacGxoTWc4RHZRSEZDSnFPdGdJQ2FZZE9GMzF1TjVG?=
 =?utf-8?B?Z09yZHhrNWVkQnZ4MFdGR05aUzlwdFhmUURQK1EzWjNIYTNZb2cwSXNRVjVJ?=
 =?utf-8?B?NGg0SzhUUlczRmFsZS9SOEMyUllEWHB0QTNiUGVRZnl4b0RFYXoxQlZLZzZv?=
 =?utf-8?B?ZEZHVDJnWlpRSUdZdWs2ZmtGMGdsSWhVT3VtckU0TkE5QnZ6WW1ENElReWJz?=
 =?utf-8?B?aFhNVDZYdkQxWmtxMC9FMUkrcWpFUnl3REpsTlBGSlRsczd4SnNRVnFKZzIx?=
 =?utf-8?B?YWpza0cxaGhOSTVFWWQrZzhkQU1PUUQveXFqS21vUklEUkxsWUNFb3BqVTdN?=
 =?utf-8?B?dGJUOTVmaGdxSm96N1p3SlFvQkZZWTJmYzMreVpXNTdZV2UxVENTNVdmdXpt?=
 =?utf-8?B?cmhHNWtTcVZLWmc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWlNTjU2Uk8rU09PSlliQnp1VWpoNHJOL3JtVGFOVjd0NmtMNmdTaForK3Uv?=
 =?utf-8?B?dVVTblNmZG1UdEd0YlNrZEFTN09qcytCbVlkY2p6elQ5NnNtRzdkdnpJWkZF?=
 =?utf-8?B?bEExcDdzRUpyZmh5dHlTeWRIYWU2MnRlNGt0dVZQVjVqZnhzYXR2RXVXNFFI?=
 =?utf-8?B?RnpZaGRWU1hmV3NiM3pDbDJNZnN2L2Q5bEY3a0JDUERGQUZTZmZRVFV1NnVx?=
 =?utf-8?B?OEFlT2lVczk3Uy9ieTcrQ0tqZTYvNTZYY09JWWRLOURWQjBLcHVBcHFvb2Fz?=
 =?utf-8?B?blF3MXVsZGJCeG9UTGhzTlZsY0VpUnUrdlBHQk9kWStOYmpmWThucmFIa29s?=
 =?utf-8?B?ajBzSTJFV2RPWEtWOHUyTXN1K2Q2cXJ0SVJmRU9laFBZMUFaeFpwbDB4MEsy?=
 =?utf-8?B?dmMzZmNiZ20zTllRSktMUXpIYUtvMW9rNzN6TjN2TXNvWTZ4OVFGMUtCQlN1?=
 =?utf-8?B?a29HVU9rYTlDcDVXM1dlckRmTjI0NHUwa1k5Snh4STVlY1Uvck1QVkV4Skto?=
 =?utf-8?B?cVJRMFlBeGQ0VW10cDFtZzVodGpINlN4MG9pWW5qVThkanYvaStiK2p0ckht?=
 =?utf-8?B?TktvWVRVa2hsb2J6cGkzRHBYUW5tOFc4Umd1SHJwRmhvV2ZyTEd5Qm5IRVJO?=
 =?utf-8?B?dlNUcnE5b2hmQmpaZEg1VTNlTVl2S003MzBvU04vODNXVk0wQW5LdW5iNHFK?=
 =?utf-8?B?MHpzWkdZbXRlM1BEeGlTdUUrZXJXeEJsNnBIM1orMHF0bmFPMU5qOVNwaXFr?=
 =?utf-8?B?K3pHV1p2cEVwNWNDYk5MNTBhWHVBZWFIMFhKaVlMdWxkaWFvdHJIT3hjREt3?=
 =?utf-8?B?WksxOGJ5YUt6eWtwb1B2Y0JtRWlsOFJ2ZGpCaUFoc3hCdm1DUTFNd2d3Rys3?=
 =?utf-8?B?WGdIZkU3cm11bzBwN2VxcDg1SFR5NE1maEZibDlBSG1zcnRyam5hcUVSN0lU?=
 =?utf-8?B?enVndXZsaVZrMnA1SnpVbW40VnhkMHlNTXFPKytkbThkazl4WHBSRjZEd2w1?=
 =?utf-8?B?c1pVV2JDZGZkOWE5dERhdDRneDczNjYrRFdwWWJCeDJoeDBpZk5jbXllZ0Ix?=
 =?utf-8?B?SEJKdWJHUUhZL0I0Tko4RnhNMFF6TXB1RVhXaGllRTVrNXE1QktKaVFjQTZl?=
 =?utf-8?B?T2I3VHhkMGpEYXJ3YWt6ZEhHcFNVMGtHaVYxeWRuVVdoM2RuVTVlSWhRaGRS?=
 =?utf-8?B?NUZsSEM3VHFNUzFOb2c3cnF5K2pZdG85eHZETzFBaUtMQXZzaHFMeU5ieDdD?=
 =?utf-8?B?SDlMVzk4QlNHN1oydXFZZWRkdzlxby80a3pHZUUvVDJubE43VGtNSnJrVU01?=
 =?utf-8?B?UVArWXdXRDdGRExkQTlodU1tbmthQTBuVUFZTmxIQkJVaHNaUDZFRW1GeHVF?=
 =?utf-8?B?aW10cGxkVlVLNXFrRGYreEdqaHNTb25lNW1rTGJ2Unh6cDA1VFp6T1VDYmpu?=
 =?utf-8?B?ZVR2ZDBtV1ZGK3YwZitHQUdMOXhZNEJhMC84bk1uV3VRWWNpZ0VzOXcveWFX?=
 =?utf-8?B?Y2c0RHdacjdUTUtQTmg5US9HVWkxTGtyTHh5d1RZcW5YS01hR0tFeThrUG9S?=
 =?utf-8?B?V3M5TXJyV2FrdXhjWUh0dlUxMjU4UWpyV0E2MmV2cExvVW40S2k3R3AxbnJQ?=
 =?utf-8?Q?GkJbNbtwT5Bm90vg0zqiN3Omx4FyY/XAfkjiajYsi49M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e6a0ef-4173-4c6e-7ce8-08dd0b241ee5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 18:33:12.1247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8870

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTksIDIwMjQgNDo1MSBQTQ0KPiANCj4gT24g
VHVlLCBOb3YgMTIsIDIwMjQgYXQgMDc6NDg6MDZQTSArMDAwMCwgTWljaGFlbCBLZWxsZXkgd3Jv
dGU6DQo+ID4gRnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgu
bWljcm9zb2Z0LmNvbT4gU2VudDogVHVlc2RheSwNCj4gTm92ZW1iZXIgMTIsIDIwMjQgMTA6MTgg
QU0NCj4gPiA+DQo+ID4gPiBFbmFibGUgWDg2X0ZFQVRVUkVfVFNDX1JFTElBQkxFIGJ5IGRlZmF1
bHQgYXMgWDg2X0ZFQVRVUkVfVFNDX1JFTElBQkxFIGlzDQo+ID4gPiBpbmRlcGVuZGVudCBmcm9t
IGludmFyaWFudCBUU0MgYW5kIHNob3VsZCBoYXZlIG5ldmVyIGJlZW4gZ2F0ZWQgYnkgdGhlDQo+
ID4gPiBIVl9BQ0NFU1NfVFNDX0lOVkFSSUFOVCBwcml2aWxlZ2UuDQo+ID4NCj4gPiBJIHRoaW5r
IG9yaWdpbmFsbHkgWDg2X0ZFQVRVUkVfVFNDX1JFTElBQkxFIHdhcyBnYXRlZCBieSB0aGUgSHlw
ZXItVg0KPiA+IFRTQyBJbnZhcmlhbnQgZmVhdHVyZSBiZWNhdXNlIG90aGVyd2lzZSBWTSBsaXZl
IG1pZ3JhdGlvbiBtYXkgY2F1c2UNCj4gPiB0aGUgVFNDIHZhbHVlIHJlcG9ydGVkIGJ5IHRoZSBS
RFRTQy9SRFRTQ1AgaW5zdHJ1Y3Rpb24gaW4gdGhlIGd1ZXN0DQo+ID4gdG8gYWJydXB0bHkgY2hh
bmdlIGZyZXF1ZW5jeSBhbmQgdmFsdWUuIEluIHN1Y2ggY2FzZXMsIHRoZSBUU0MgaXNuJ3QNCj4g
PiB1c2VhYmxlIGJ5IHRoZSBrZXJuZWwgb3IgdXNlciBzcGFjZS4NCj4gPg0KPiA+IEVuYWJsaW5n
IHRoZSBIeXBlci1WIFRTQyBJbnZhcmlhbnQgZmVhdHVyZSBmaXhlcyB0aGF0IGJ5IHVzaW5nIHRo
ZQ0KPiA+IGhhcmR3YXJlIHNjYWxpbmcgYXZhaWxhYmxlIGluIG1vcmUgcmVjZW50IHByb2Nlc3Nv
cnMgdG8gYXV0b21hdGljYWxseQ0KPiA+IGZpeHVwIHRoZSBUU0MgdmFsdWUgcmV0dXJuZWQgYnkg
UkRUU0MvUkRUU0NQIGluIHRoZSBndWVzdC4NCj4gPg0KPiA+IElzIHRoZXJlIGEgcHJhY3RpY2Fs
IHByb2JsZW0gdGhhdCBpcyBmaXhlZCBieSBhbHdheXMgZW5hYmxpbmcNCj4gPiBYODZfRkVBVFVS
RV9UU0NfUkVMSUFCTEU/DQo+ID4NCj4gDQo+IFRoZSBwYXJ0aWN1bGFyIHByb2JsZW0gaXMgdGhh
dCBIVl9BQ0NFU1NfVFNDX0lOVkFSSUFOVCBpcyBub3Qgc2V0IGZvciB0aGUNCj4gbmVzdGVkIHJv
b3QsIHdoaWNoIGluIHR1cm4gbGVhZHMgdG8ga2VlcGluZyB0c2MgY2xvY2tzb3VyY2Ugd2F0Y2hk
b2cNCj4gdGhyZWFkIGFuZCBUU0Mgc3ljbiBjaGVjayB0aW1lciBhcm91bmQuDQoNCkkgaGF2ZSB0
cm91YmxlIGtlZXBpbmcgYWxsIHRoZSBkaWZmZXJlbnQgVFNDICJmZWF0dXJlcyIgY29uY2VwdHVh
bGx5DQpzZXBhcmF0ZS4gOi0oIFRoZSBUU0MgZnJlcXVlbmN5IG5vdCBjaGFuZ2luZyAoYW5kIHRo
ZSB2YWx1ZSBub3QNCmFicnVwdGx5IGp1bXBpbmc/KSBzaG91bGQgYWxyZWFkeSBiZSByZXByZXNl
bnRlZCBieQ0KWDg2X0ZFQVRVUkVfVFNDX0NPTlNUQU5ULiAgSW4gdGhlIGtlcm5lbCwgWDg2X0ZF
QVRVUkVfVFNDX1JFTElBQkxFDQplZmZlY3RpdmVseSBvbmx5IGNvbnRyb2xzIHdoZXRoZXIgdGhl
IFRTQyBjbG9ja3NvdXJjZSB3YXRjaGRvZyBpcw0KZW5hYmxlZCwgYW5kIGluIHNwaXRlIG9mIHRo
ZSBsaXZlIG1pZ3JhdGlvbiBmb2libGVzLCBJIGRvbid0IHNlZSBhIG5lZWQNCmZvciB0aGF0IHdh
dGNoZG9nIGluIGEgSHlwZXItViBWTS4gU28gbWF5YmUgaXQncyBPSyB0byBhbHdheXMgc2V0DQpY
ODZfRkVBVFVSRV9UU0NfUkVMSUFCTEUgaW4gYSBIeXBlci1WIFZNLCBhcyB5b3UgaGF2ZQ0KcHJv
cG9zZWQuDQoNClRoZSAidHNjX3JlbGlhYmxlIiBmbGFnIGlzIGFsc28gZXhwb3NlZCB0byB1c2Vy
IHNwYWNlIGFzIHBhcnQgb2YgdGhlDQovcHJvYy9jcHVpbmZvICJmbGFncyIgb3V0cHV0LCBzbyB0
aGVvcmV0aWNhbGx5IHNvbWUgdXNlciBzcGFjZQ0KcHJvZ3JhbSBjb3VsZCBjaGFuZ2UgYmVoYXZp
b3IgYmFzZWQgb24gdGhhdCBmbGFnLiBCdXQgdGhhdCBzZWVtcw0KYSBiaXQgZmFyLWZldGNoZWQu
IEkga25vdyB0aGVyZSBhcmUgdXNlciBzcGFjZSBwcm9ncmFtcyB0aGF0IGNoZWNrDQp0aGUgQ1BV
SUQgSU5WQVJJQU5UX1RTQyBmbGFnIHRvIGtub3cgd2hldGhlciB0aGV5IGNhbiB1c2UNCnRoZSBy
YXcgUkRUU0MgaW5zdHJ1Y3Rpb24gb3V0cHV0IHRvIGRvIHN0YXJ0L3N0b3AgdGltaW5nLiBUaGUN
Ckh5cGVyLVYgVFNDIEludmFyaWFudCBmZWF0dXJlIG1ha2VzIHRoYXQgd29yayBjb3JyZWN0bHks
IGV2ZW4NCmFjcm9zcyBsaXZlIG1pZ3JhdGlvbnMuDQoNCk1pY2hhZWwNCg0KPiANCj4gQnV0IHRo
ZSBsaXZlIG1pZ3JhdGlvbiBjb25jZXJuIHlvdSByYWlzZWQgaXMgaW5kZWVkIHN0aWxsIG91dCB0
aGVyZS4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIGlucHV0IE1pY2hhZWwsIEknbGwgdGhpbmsg
bW9yZSBhYm91dCBpdC4NCj4gDQo+IFN0YW5pc2xhdg0KPiANCj4gPiBNaWNoYWVsDQo+ID4NCj4g
PiA+DQo+ID4gPiBUbyBlbGFib3JhdGUsIHRoZSBIVl9BQ0NFU1NfVFNDX0lOVkFSSUFOVCBwcml2
aWxlZ2UgYWxsb3dzIGNlcnRhaW4gdHlwZXMgb2YNCj4gPiA+IGd1ZXN0cyB0byBvcHQtaW4gdG8g
aW52YXJpYW50IFRTQyBieSB3cml0aW5nIHRoZQ0KPiA+ID4gSFZfWDY0X01TUl9UU0NfSU5WQVJJ
QU5UX0NPTlRST0wgcmVnaXN0ZXIuIE5vdCBhbGwgZ3Vlc3RzIHdpbGwgaGF2ZSB0aGlzDQo+ID4g
PiBwcml2aWxlZ2UgYW5kIHRoZSBoeXBlcnZpc29yIHdpbGwgYXV0b21hdGljYWxseSBvcHQtaW4g
Y2VydGFpbiB0eXBlcyBvZg0KPiA+ID4gZ3Vlc3RzIChlLmcuIEVYTyBwYXJ0aXRpb25zKSB0byBp
bnZhcmlhbnQgVFNDLCBidXQgdGhpcyBmdW5jdGlvbmFsaXR5IGlzDQo+ID4gPiB1bnJlbGF0ZWQg
dG8gdGhlIFRTQyByZWxpYWJpbGl0eS4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGFu
aXNsYXYgS2luc2J1cnNraWkgPHNraW5zYnVyc2tpaUBsaW51eC5taWNyb3NvZnQuY29tPg0KPiA+
ID4gLS0tDQo+ID4gPiAgYXJjaC94ODYva2VybmVsL2NwdS9tc2h5cGVydi5jIHwgICAgNiArKyst
LS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2
LmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2LmMNCj4gPiA+IGluZGV4IGQxODA3ODgz
NGRlZC4uMTQ0MTJhZmNjMzk4IDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2Nw
dS9tc2h5cGVydi5jDQo+ID4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2LmMN
Cj4gPiA+IEBAIC01MTUsNyArNTE1LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IG1zX2h5cGVydl9p
bml0X3BsYXRmb3JtKHZvaWQpDQo+ID4gPiAgCW1hY2hpbmVfb3BzLmNyYXNoX3NodXRkb3duID0g
aHZfbWFjaGluZV9jcmFzaF9zaHV0ZG93bjsNCj4gPiA+ICAjZW5kaWYNCj4gPiA+ICAjZW5kaWYN
Cj4gPiA+IC0JaWYgKG1zX2h5cGVydi5mZWF0dXJlcyAmIEhWX0FDQ0VTU19UU0NfSU5WQVJJQU5U
KSB7DQo+ID4gPiArCWlmIChtc19oeXBlcnYuZmVhdHVyZXMgJiBIVl9BQ0NFU1NfVFNDX0lOVkFS
SUFOVCkNCj4gPiA+ICAJCS8qDQo+ID4gPiAgCQkgKiBXcml0aW5nIHRvIHN5bnRoZXRpYyBNU1Ig
MHg0MDAwMDExOCB1cGRhdGVzL2NoYW5nZXMgdGhlDQo+ID4gPiAgCQkgKiBndWVzdCB2aXNpYmxl
IENQVUlEcy4gU2V0dGluZyBiaXQgMCBvZiB0aGlzIE1TUiAgZW5hYmxlcw0KPiA+ID4gQEAgLTUy
Niw4ICs1MjYsOCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgbXNfaHlwZXJ2X2luaXRfcGxhdGZvcm0o
dm9pZCkNCj4gPiA+ICAJCSAqIGlzIGNhbGxlZC4NCj4gPiA+ICAJCSAqLw0KPiA+ID4gIAkJd3Jt
c3JsKEhWX1g2NF9NU1JfVFNDX0lOVkFSSUFOVF9DT05UUk9MLA0KPiBIVl9FWFBPU0VfSU5WQVJJ
QU5UX1RTQyk7DQo+ID4gPiAtCQlzZXR1cF9mb3JjZV9jcHVfY2FwKFg4Nl9GRUFUVVJFX1RTQ19S
RUxJQUJMRSk7DQo+ID4gPiAtCX0NCj4gPiA+ICsNCj4gPiA+ICsJc2V0dXBfZm9yY2VfY3B1X2Nh
cChYODZfRkVBVFVSRV9UU0NfUkVMSUFCTEUpOw0KPiA+ID4NCj4gPiA+ICAJLyoNCj4gPiA+ICAJ
ICogR2VuZXJhdGlvbiAyIGluc3RhbmNlcyBkb24ndCBzdXBwb3J0IHJlYWRpbmcgdGhlIE5NSSBz
dGF0dXMgZnJvbQ0KPiA+ID4NCj4gPiA+DQo+ID4NCg==

