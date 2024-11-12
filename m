Return-Path: <linux-hyperv+bounces-3328-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324549C621E
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 21:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36775B87DEB
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FFD21A4A2;
	Tue, 12 Nov 2024 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Qjakr/vN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010000.outbound.protection.outlook.com [52.103.11.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BD0219E24;
	Tue, 12 Nov 2024 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440892; cv=fail; b=bE6C7haHir1FSsC8BZ+Mqgwaoyz4vdC9s9oqjGJe34QPtrD2fuygr1y91IQegIOeO0l96fgPuPj2esJ9mhnU1DOWsH5dk752cwM3Nm1dhQu5GcfDVSc6SJ/jgcu4LtQ/RqEP1ZfSIzuTN+iXvS2tIGLDM4OqSe/Fvw01PW+8Ebc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440892; c=relaxed/simple;
	bh=UY+lrc0ZLdjKv0YRj9f/9OUFhYiFRNs2o2Wc91f0EZw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e0wMGrVF5zOixO28WDo+RNVfYaoJUfgHZcFJxqjQ5rYmeXVtj/d+VzJDgwD5oCHeULOL1dnnoOA9QczVFENVeopJrRz4YeQPKR3WIBvmhWfd0/8rRha+zIT2Zm8scy75JfMbEaGDfGRxeprMRKeMp0VibscUiUeoP7tYTU1HW4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Qjakr/vN; arc=fail smtp.client-ip=52.103.11.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPUgkHnv+R5pzs79HAKoZDeuS7vr2xC7v6NR0GI8L3FgNrmeFwMd6tHz+RjKTBONRSNCy2CvhctyROxovUncAoiDARhKd+CWIodKITe9wl4r7hoaip9ZNyzFRlxP3FCH9BNpCKKvfnyxzf6W+zE3GW/xGrNAEZ+Cr+QK0AcoyxS9CgnxAXy5gKnJDnL0QCtRRwLvxZhR7AnSqybargHS/6dyZGRh5TEO7vuMoaI+GuQuwrHQ4fNPchiYlIzzJmUlCd45MmbScnZYpWc0MJMksar2f8r7lDehoElwLT2PqNwv64I69kP1FHx3vf7cprgVulcsKtZIvrQa1moEGuDfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UY+lrc0ZLdjKv0YRj9f/9OUFhYiFRNs2o2Wc91f0EZw=;
 b=v0W/djH6zOukmJJpgTEqqKLc72yGNVL0EOyVv1qTCRMG8zNrPFzD8hwEDo07LFcoKc5pY4yEp0xUm2OHVPhccpashT997BppH52CkFPNqP5EdeB11yW3S0u6vGOKW1N5zPeNtgmymV+fEj2eRVGBJ+E9heGzmJDJKRDT4SLpaDhmqQFzuyQQXVB8sGgnDT2hzE0FRXut172XJBUpYGd6ooEb++buIVuiZ4NF7+nrKrlQwI+8KaYXiXpsaRKyL5Ydl+XXX6YzbhwgVqvgBMf5vjh8Wcap/TPGCFAJg0/NgQ6LWYfnNR+cYaeILsY/UAfHuyw3D7EWjoSzP0cUU7huqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY+lrc0ZLdjKv0YRj9f/9OUFhYiFRNs2o2Wc91f0EZw=;
 b=Qjakr/vNHX4Qwr2t1JTjafXe88lhBrwbt7IuSHjJ3wNoBi9qgbfJbi510iwXnM4tiUQrg8d1UwVg1aO2BKxq2zVWzU8K46hc8q9y1YZ7zEXGBc1wLpWkPSfLWHkuw26UFF1TWKGhWNqE1dJlFf+O0Aq/Ggb1yU7zvYQ9NTkMYzHz1rEshcDEvPYDP8OxBsIrZrm3e0LQDdZ3NZqShmlJj00bKEdYXxPvN8mtEhGk+/Nqe9W+CODp4W0nZLCqj1oNwVsTwSS6y5rcCOaFmSTaYnWaGLWRFu8zF4uzG6GOurSd2Bc9UWkdUVgPkjjLH/ZJsFtI4Mj+h2EAZd7aWNvrOQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7057.namprd02.prod.outlook.com (2603:10b6:a03:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 19:48:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 19:48:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyperv: Set X86_FEATURE_TSC_RELIABLE unconditionally
Thread-Topic: [PATCH] x86/hyperv: Set X86_FEATURE_TSC_RELIABLE unconditionally
Thread-Index: AQHbNS9UbXwh5KJBoU2oxHpKRgf4mrK0CjPA
Date: Tue, 12 Nov 2024 19:48:06 +0000
Message-ID:
 <SN6PR02MB41575A98314B82C498A3D312D4592@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <173143547242.3415.16207372030310222687.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <173143547242.3415.16207372030310222687.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7057:EE_
x-ms-office365-filtering-correlation-id: 7294e8cb-e086-479c-f7df-08dd0352ed83
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|19110799003|8060799006|15080799006|440099028|102099032|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEJjU0tDdmdHakxCc1pjQmV6ZytHWW9hM25MZ2pwckcxNkFaYmU4TWhSZk4z?=
 =?utf-8?B?OWNjaGtVRWhsNjErbHJMZksvRVhPaS9za2FMZ3pTeGZKcVUyOE5rZDArNGhV?=
 =?utf-8?B?b1JIOUgzd3pNalpZdW8vblcrcXREK1Rhbk9teHMwSGxaV3lpcHhpR3VrRGNn?=
 =?utf-8?B?c0NhemdWVlBmUEgzWkg4cGs2ck5tbjZsdklWTURZcnNQNDJQWmRxUUpmWG9B?=
 =?utf-8?B?YjZJL1FobW8rWTRVeVZmbkt1TkZpZzMrS0poNTZZTjdnMFBrc0d1UEZYRVFz?=
 =?utf-8?B?UzlGTlQ0RXJUOXF3MFY1NFh0eXJEc2s0Sks3eWVvUlhvWldkZnd2NHhqTUVm?=
 =?utf-8?B?NmprbndsZHpQSURVRG9RQTN6ckZNbUZMWFpWN0hLTnhYbVlmZTI2a1g4M1Nn?=
 =?utf-8?B?ZWh0V3VYNVZ2dFNlKzZqMllyRGMzRFhZeUdMV0N6SjRIY2tPd0xGVDV6WlV3?=
 =?utf-8?B?ck55eUZhNHU3aTNrVW1waDZ6bHJHTGFEQTdiNUpWL1NaYXl1cTR0SjV2bnZ5?=
 =?utf-8?B?cGpTRWE2ZlpUQkE5b0Nod3l5M1JJc3BDV0JtMEhpS0EweXJwT3M1MmVub0Y1?=
 =?utf-8?B?OVQ1M25xSEtWYWZZL1dweVhZRkVyN2NyN2Q2T3M5cUNVMGxxMy85bWFjeDN2?=
 =?utf-8?B?RzJueDV0Rmp0VHJmemlwSWVxcGJiSlRybU05OTJ4WmJ1bzFubkd3K1VsWFpC?=
 =?utf-8?B?U3dMQXBOcHhlZ2duc2hRVHBhUEJrUEh2R3hUdzB4UWRaTGJuZStyL2d2cHFV?=
 =?utf-8?B?VUpZOTkyc0lLckVFWlB4T1h6NzRlK0VleThNYzl4WHN3K29qQzBnR29XTlpW?=
 =?utf-8?B?OGV3eFIwMDFBM1JBOEV2RVkzUWo4ZW12NUZ4U3A1ZXVVQlVueTJlR3FCZkJo?=
 =?utf-8?B?RHE1d0JxdFRIYWRzb0E4M0RBL2ZYN2RKRGd4MDBtM1VoRWlkNXZCekhNV283?=
 =?utf-8?B?YWJsSkRCMzY0WlRSaEw0VkEwNFhGY0ZOb21zcDE5Kzd3cWErMUpUVHR2Wjhz?=
 =?utf-8?B?TlllN1B1ZlR2Q0dKSHpWZEJYS2NyMFZRcnVXajQvMmh5NnhBczcxeFJvcGlB?=
 =?utf-8?B?SzlxTmlLcDVZcmlIVXYxRmx2UGhaQjZ2VDRqZzcxSDBGQzRMRVFZUk9DY3Vj?=
 =?utf-8?B?RFlvWVJrL1VsTk1KNWE4clZvMUt5RVBWcEZkVUdkQ3l5ZzQ2WFMvSkZkcHFj?=
 =?utf-8?B?UlNaamJva21QMk9oUkJRQnIxZmxkVmJGUndBeXRCVmdCNE0vbFBhY2JsOE4z?=
 =?utf-8?B?bEVNajVodm9XL3V2OHF0L0pEUVBuRjAvL1N3dGtua0Vhci9GeEZ6OWgyeFBr?=
 =?utf-8?B?RHpJOVBTWFliZlZPRWtCSDFXWndzSWRiU3V0MXlia1VKaisvS2JUVGpqa3di?=
 =?utf-8?B?V00rZ3FKdjdwTWc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzJRQ3prQ3AwTEJzZVBXSk4xdVlsazk2RkFHdm9LZUxaZklXUjZOazRVbDNP?=
 =?utf-8?B?dkFFVEJhWlpta3R2S00wbENmdmFaYnVrc1lJaVhTUGlEN1FWRDRYQ1VGd0pT?=
 =?utf-8?B?RUJvS2NKN041aFN3RVFrN1QraG9OUkFJcUNaNk94OWxsZFdPMVk5cFlUSzRV?=
 =?utf-8?B?NG1CbklkekVVY2dFcTVKY1Q3OVZQQXpXWXRzcjVVRnFaSzZtVVRkY054VWVZ?=
 =?utf-8?B?WFBMdkpWcFZiTVBvajRiYTFLbzRUci9yUVBzalA4cEpITHJPQjlFdyttNFFn?=
 =?utf-8?B?cGQxUXhabWxWRkhweHFvY24rdllGeVdDbmxLeU9mSSt0RlZ5ZzlvK3BGQlds?=
 =?utf-8?B?TVNubnVrY3U0SzRYTGUwUGg2VFVXejI4NWRLOWRsRFNsVm91NjNqcnJsbG5u?=
 =?utf-8?B?WmZKRFBha2JZUEs0UXpWRkhmZnB3aDJsYTByRW13WUI1QUxzNE4wZU1pK2lj?=
 =?utf-8?B?dkVZMHFiOGlrWHZvR2RzSldGL2cvcWQ3TnEweXZSMHZicE96MERLcU9PZWFU?=
 =?utf-8?B?U1VOZFdJdG5IUHAxUWhWdWZacVYwQWxqY05USzZBdlRSdkttT0tvRzE5RDl4?=
 =?utf-8?B?aVZuRnQ4N2YxNTVVdStuU3g5T05oRFJHaVQydU85UUV5UWk3RDR6NHRlbEFl?=
 =?utf-8?B?dVBxWWovUkJBZ3VrOWdJTlovaHNsZ2FsdmtkNDYyaVJyTzEzTVlZSWVDS0V6?=
 =?utf-8?B?M0NKd0JYTE1CUnFCVm5EWHpUZE1CbUtMNStHcngySzNiczB4a0tDRUFyeUNU?=
 =?utf-8?B?dGlYVHdGYTJIRXNERFZ3UEpjRzFuU1JwalhscGRQYmxCTnQ3dDk4bm5rdWRD?=
 =?utf-8?B?ckJ0THFDTkZLdnVidW1CL0JuN09NdVB2aGo2U0VOYjM1WmNHVDJVR3BsM0lM?=
 =?utf-8?B?RXZsQ1JKSjB2WFRsWHhDUkRlUys4ZzJoWXMrbGxJN2NjT2VzNTMvSTJZZjlI?=
 =?utf-8?B?WFRBSUF1cTZtRHp4STlYY3JtQmgrWjVtQjFxTUYzakgzeWZlem9zYTF3RXZ0?=
 =?utf-8?B?MFNyTEhiekR2MU1YMTJwUVA3SVFzanBNeHNoQTVmQ3Y4QTIrL2lQczlhZUpx?=
 =?utf-8?B?aElFaWpDT2sxUUZXbVQ5OEhYZk9leTlrdnZWSkRlb1ZUNDM0cTIrTlZTZ0Nj?=
 =?utf-8?B?QmkrcVlzcjRpZFVEQmxBSmc0ZE5SVnR2bDlNS0huZUw2ckl6eVRtL1FmWjBQ?=
 =?utf-8?B?ZlZzWTdYcWVvY2hEUThNT2hSQ1lldzZLaXF6TzZwRlo3T0JPamxaOWVrQlZs?=
 =?utf-8?B?aVgrR0JrS3ZwZFdybGxjSmVQZU9MMXhRWVBMd0F5R08wOXNpTHJBbTErYjdx?=
 =?utf-8?B?L2ZoYU8xTDNLNndmOG5oc0pSQXZRQmhUM3gzanRKTUMveVlZa2ZtUVB5bkVP?=
 =?utf-8?B?bWozMXpSbGdGTm5hQjBQQkluSDBTM2owWTJFUFlHdEtIeFNucUN0N05YNnhs?=
 =?utf-8?B?eFhiWW5wdTh0VWxNM1E5MWFNa28rWXpCZEZaYnd0anZUUEQ4MTlFUE45K0cx?=
 =?utf-8?B?V2tzVlBjOStHZ3JHTGFGcVRJeHN1WDVlNUg2K2FPc2oyMlRRc2N0VHV6L1hx?=
 =?utf-8?B?SW5zTGxOWFhvSjVGN05EVFBubEFmR1Z1MFBQR2FNb1h0Y01HUFo3Mk5zdzVD?=
 =?utf-8?Q?Q9H+W0/ErBgZtUwXz1+LFfchHZJ5RElA2qIQoYX19YLk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7294e8cb-e086-479c-f7df-08dd0352ed83
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 19:48:06.3242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7057

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTIsIDIwMjQgMTA6MTggQU0NCj4gDQo+IEVu
YWJsZSBYODZfRkVBVFVSRV9UU0NfUkVMSUFCTEUgYnkgZGVmYXVsdCBhcyBYODZfRkVBVFVSRV9U
U0NfUkVMSUFCTEUgaXMNCj4gaW5kZXBlbmRlbnQgZnJvbSBpbnZhcmlhbnQgVFNDIGFuZCBzaG91
bGQgaGF2ZSBuZXZlciBiZWVuIGdhdGVkIGJ5IHRoZQ0KPiBIVl9BQ0NFU1NfVFNDX0lOVkFSSUFO
VCBwcml2aWxlZ2UuDQoNCkkgdGhpbmsgb3JpZ2luYWxseSBYODZfRkVBVFVSRV9UU0NfUkVMSUFC
TEUgd2FzIGdhdGVkIGJ5IHRoZSBIeXBlci1WDQpUU0MgSW52YXJpYW50IGZlYXR1cmUgYmVjYXVz
ZSBvdGhlcndpc2UgVk0gbGl2ZSBtaWdyYXRpb24gbWF5IGNhdXNlDQp0aGUgVFNDIHZhbHVlIHJl
cG9ydGVkIGJ5IHRoZSBSRFRTQy9SRFRTQ1AgaW5zdHJ1Y3Rpb24gaW4gdGhlIGd1ZXN0DQp0byBh
YnJ1cHRseSBjaGFuZ2UgZnJlcXVlbmN5IGFuZCB2YWx1ZS4gSW4gc3VjaCBjYXNlcywgdGhlIFRT
QyBpc24ndA0KdXNlYWJsZSBieSB0aGUga2VybmVsIG9yIHVzZXIgc3BhY2UuDQoNCkVuYWJsaW5n
IHRoZSBIeXBlci1WIFRTQyBJbnZhcmlhbnQgZmVhdHVyZSBmaXhlcyB0aGF0IGJ5IHVzaW5nIHRo
ZQ0KaGFyZHdhcmUgc2NhbGluZyBhdmFpbGFibGUgaW4gbW9yZSByZWNlbnQgcHJvY2Vzc29ycyB0
byBhdXRvbWF0aWNhbGx5DQpmaXh1cCB0aGUgVFNDIHZhbHVlIHJldHVybmVkIGJ5IFJEVFNDL1JE
VFNDUCBpbiB0aGUgZ3Vlc3QuDQoNCklzIHRoZXJlIGEgcHJhY3RpY2FsIHByb2JsZW0gdGhhdCBp
cyBmaXhlZCBieSBhbHdheXMgZW5hYmxpbmcNClg4Nl9GRUFUVVJFX1RTQ19SRUxJQUJMRT8NCg0K
TWljaGFlbA0KDQo+IA0KPiBUbyBlbGFib3JhdGUsIHRoZSBIVl9BQ0NFU1NfVFNDX0lOVkFSSUFO
VCBwcml2aWxlZ2UgYWxsb3dzIGNlcnRhaW4gdHlwZXMgb2YNCj4gZ3Vlc3RzIHRvIG9wdC1pbiB0
byBpbnZhcmlhbnQgVFNDIGJ5IHdyaXRpbmcgdGhlDQo+IEhWX1g2NF9NU1JfVFNDX0lOVkFSSUFO
VF9DT05UUk9MIHJlZ2lzdGVyLiBOb3QgYWxsIGd1ZXN0cyB3aWxsIGhhdmUgdGhpcw0KPiBwcml2
aWxlZ2UgYW5kIHRoZSBoeXBlcnZpc29yIHdpbGwgYXV0b21hdGljYWxseSBvcHQtaW4gY2VydGFp
biB0eXBlcyBvZg0KPiBndWVzdHMgKGUuZy4gRVhPIHBhcnRpdGlvbnMpIHRvIGludmFyaWFudCBU
U0MsIGJ1dCB0aGlzIGZ1bmN0aW9uYWxpdHkgaXMNCj4gdW5yZWxhdGVkIHRvIHRoZSBUU0MgcmVs
aWFiaWxpdHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdGFuaXNsYXYgS2luc2J1cnNraWkgPHNr
aW5zYnVyc2tpaUBsaW51eC5taWNyb3NvZnQuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5l
bC9jcHUvbXNoeXBlcnYuYyB8ICAgIDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tl
cm5lbC9jcHUvbXNoeXBlcnYuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXNoeXBlcnYuYw0KPiBp
bmRleCBkMTgwNzg4MzRkZWQuLjE0NDEyYWZjYzM5OCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYv
a2VybmVsL2NwdS9tc2h5cGVydi5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXNoeXBl
cnYuYw0KPiBAQCAtNTE1LDcgKzUxNSw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBtc19oeXBlcnZf
aW5pdF9wbGF0Zm9ybSh2b2lkKQ0KPiAgCW1hY2hpbmVfb3BzLmNyYXNoX3NodXRkb3duID0gaHZf
bWFjaGluZV9jcmFzaF9zaHV0ZG93bjsNCj4gICNlbmRpZg0KPiAgI2VuZGlmDQo+IC0JaWYgKG1z
X2h5cGVydi5mZWF0dXJlcyAmIEhWX0FDQ0VTU19UU0NfSU5WQVJJQU5UKSB7DQo+ICsJaWYgKG1z
X2h5cGVydi5mZWF0dXJlcyAmIEhWX0FDQ0VTU19UU0NfSU5WQVJJQU5UKQ0KPiAgCQkvKg0KPiAg
CQkgKiBXcml0aW5nIHRvIHN5bnRoZXRpYyBNU1IgMHg0MDAwMDExOCB1cGRhdGVzL2NoYW5nZXMg
dGhlDQo+ICAJCSAqIGd1ZXN0IHZpc2libGUgQ1BVSURzLiBTZXR0aW5nIGJpdCAwIG9mIHRoaXMg
TVNSICBlbmFibGVzDQo+IEBAIC01MjYsOCArNTI2LDggQEAgc3RhdGljIHZvaWQgX19pbml0IG1z
X2h5cGVydl9pbml0X3BsYXRmb3JtKHZvaWQpDQo+ICAJCSAqIGlzIGNhbGxlZC4NCj4gIAkJICov
DQo+ICAJCXdybXNybChIVl9YNjRfTVNSX1RTQ19JTlZBUklBTlRfQ09OVFJPTCwgSFZfRVhQT1NF
X0lOVkFSSUFOVF9UU0MpOw0KPiAtCQlzZXR1cF9mb3JjZV9jcHVfY2FwKFg4Nl9GRUFUVVJFX1RT
Q19SRUxJQUJMRSk7DQo+IC0JfQ0KPiArDQo+ICsJc2V0dXBfZm9yY2VfY3B1X2NhcChYODZfRkVB
VFVSRV9UU0NfUkVMSUFCTEUpOw0KPiANCj4gIAkvKg0KPiAgCSAqIEdlbmVyYXRpb24gMiBpbnN0
YW5jZXMgZG9uJ3Qgc3VwcG9ydCByZWFkaW5nIHRoZSBOTUkgc3RhdHVzIGZyb20NCj4gDQo+IA0K
DQo=

