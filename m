Return-Path: <linux-hyperv+bounces-1107-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA277FC106
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 19:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8203B20D55
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 18:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF69C41C9C;
	Tue, 28 Nov 2023 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="a9gfbNZk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A5F91;
	Tue, 28 Nov 2023 10:08:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MA1BRXU+4Y3mxAV68TzDV74m6f9riimOYg0Ic5qO7CCtJd55pRM9CupkafU21uWn/Gsg4TfZTW+UEzgAQpQxuQGCQBmK3MAc9Yt8QhgBwWeFUHE6acqmbXCWjRI6oD1RNUjjRvI5eTU7C1qqyK2G+9sP8c7i3j1e6KVKDLkvVsU03Y0wzd0eS1dgw7rvO5UTpcKVyPJ+THKVyhSy6kFl01csBzigPX/udQpOix9ur03qdF2x9gMAgbvW9cR9iR2qCbLjbZlwyoL4UenRzIC7x8gnnn4vbz3EnIOehYGVS1bOJF0tSlGQIXnLSa1+gJfwaJx/BF7KtCHhb3vhqV5aeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS7GszjJid4705Wyzr9egtKKq3ZfMCiLvVwRi7M4Krk=;
 b=X+BzBqAH2V1bosYIDRr6BlccZ+4p6A+W3mdEmiq89rcOCcAxCv6tpZlnAMYScbRDbGzN+TqpqYE7FXpTlnNKKJ54ND6zdK4nKRkfky2Uca+7ICXGoizh0Ja/BKbwsGgkr8mMh21tF3Jz9ZQKRdomRcKFaSQXrHO6SxyZ+CloMLQhIYHQrXaMUUo26BL+xZIQWiAVQf0be7CfH/GOKajsmKJA56MEOrQEKQlbWcEeLNDPNAu7rAlgIxPN+21h2c2ehewNs25RhOf6RDycfbybhJs8ADlY3oZLw4lpni0uL4GxvEC6CzbWdJ8Q+X6hMED8UsPhzep82DVrpQRSBAcw6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS7GszjJid4705Wyzr9egtKKq3ZfMCiLvVwRi7M4Krk=;
 b=a9gfbNZkfZlpm+p9RYBP67VvMLc40QbcU4ONCd9egdEMbwM+PpgvCJ/GvV9lcbEaxGrc3T6TAuqDOZDV3TGVtlAyHzEH8/1JnppQgqhwGNvy8GCHoaKrUNoZa26gK620/gJIA8MQC5OBV9pOZG6IfiupPKRLeII148c/F2tnfkHqZMjSZ1fAfGPWPvN9adFCczTGUYHn1cNxyWz0ye6t6h/HQweb9lFsZLbTUMtQnQKwWPVEk14KxKsfFriJCQmnaJJeBgdWVVxLPXuyeNPBrKK9YOjU7eBg0oN2MkkWA3/6Chc0tuUqoi2blG9NrBwC1tNyl10362rSeuABhHjtHw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8620.namprd02.prod.outlook.com (2603:10b6:303:15f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 18:08:08 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 18:08:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"ardb@kernel.org" <ardb@kernel.org>, "hch@infradead.org" <hch@infradead.org>,
	"Lutomirski, Andy" <luto@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"Cui, Dexuan" <decui@microsoft.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"urezki@gmail.com" <urezki@gmail.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Rodel, Jorg"
	<jroedel@suse.de>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 4/8] x86/sev: Enable PVALIDATE for PFNs without a valid
 virtual address
Thread-Topic: [PATCH v2 4/8] x86/sev: Enable PVALIDATE for PFNs without a
 valid virtual address
Thread-Index: AQHaHMCfDTF3xlWByUOaPO0cv8EgVLCOur+AgAFOhjA=
Date: Tue, 28 Nov 2023 18:08:08 +0000
Message-ID:
 <SN6PR02MB4157A935C8B8F9DBB30F9512D4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
	 <20231121212016.1154303-5-mhklinux@outlook.com>
 <3ddcad72637dece4bd3ecb7c49b8ad0e5bd233c0.camel@intel.com>
In-Reply-To: <3ddcad72637dece4bd3ecb7c49b8ad0e5bd233c0.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [LVaDBOhpdIfGg+C2cuRGrSkyJisCi2HI]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8620:EE_
x-ms-office365-filtering-correlation-id: d096d65e-a7ab-4fab-5e22-08dbf03cf9ec
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mGwbDTrKIcivDO9T4hs1IOErOrE+SZIXyG546wv3PhOsCT79RdkRP+TVSXB9yKjNLkWVZZ1ePhEG7fGZuOW0cP0hkNPEiaIyoIPjrHlXeFdFAoUCm4+P5rxCfj7zXgJo3XIoQM/zTakHvi/7RkWrf5Z+jlyj7ujyGkazCT6XOQpGsiMjq63qF2bnK1UFyaBvSFiESheR3Y+57/e34VT00SKufPNsWGAq/qFwL2gFUK60p1eMr1OiN1M2l1Y6+ycBMPLECOBF4zasEuS9zzVRc/k7lygj/8OLf+4DIPWo8ACQYwmcY7rgQDC9YCSS6WwoWhtB7iMvke1g1T6QX6pBE5rIP7n3cknVKGkpUuyWcBQld930iy6CvqwelgAlHSrKxWTTNO2zBzudG5BXFKwsW+wNEJBF7zrscx0NoKHwqp8pVbhyDKSPfSpfxMlrrxjXDNavShgnbMHaH5Sft8emiWJum+h6WFMEK/Y1ID2BEpFZExg+mUU+0pyEuk2HWRvzMDB8cWzTu8YZg6L8Ob4ARGERB342/dQ8VSJ151ghp2Y4Y+g6o2zhBKo5Uz2klHPw
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1NHdmJOTnViZ2V0TEROSGs3S0J4c1pGblBkK040cGVOaWh4Z2ppaHNRZVo5?=
 =?utf-8?B?NkxMcFJoSGtYVldKUitNRktLNDNRUFVCcnUvZFRpN1dPemVyclRxbUwwZVBi?=
 =?utf-8?B?Mmw3UlUyNktpdTNDUk9SZjBVMytzajFRRGIwL3VkMVAwcS96STZKbDU3c0Yv?=
 =?utf-8?B?bURMQVhLVUQ5Z0lZU1pQSWk1MEJkUUJGZm40bHhXZFNrNmV2SmNPSEdEcUNI?=
 =?utf-8?B?VlIvWGFmUGtibHNvTDllWU5POVFwWGVjZThVcklsYUVBdWFDcmIvYThiS1Iv?=
 =?utf-8?B?ZmRvYlk3enpPSE04NldhNHR0MlhlSnFac05PZmtFTTZyUmw5dXJLaURDQUNI?=
 =?utf-8?B?WUl0WHRxU0lQRm5vZUlXVkxLTmVhVmpwRUVQR2J6LzRrN2J4d3BjQzVlMXBQ?=
 =?utf-8?B?QWx3bTdGaHBQV1lnWE43K25sNmd5S2lJMU9abThzcVBLZ1ZGWEtIdk9ERzZs?=
 =?utf-8?B?ZkVpbGQ1dE9vZGxQc0NtS0UyQi9oUStJUDBYY1I3ZHhKcnluSHp2YmdlT3cw?=
 =?utf-8?B?dkgramhXYmlscXlvTnJYSzJLb2tQNnNpdzJESDlOVjZNc1IySnZXU1luUHVv?=
 =?utf-8?B?ODVFQjB6ZE1vK1ovNndOWUlnSXRWZXExNlplT0N3em04WW01RnFmbW95NDhD?=
 =?utf-8?B?UEhTL3BLWFloQkgrU0ZaMFNmUGh0NExjRHBPNEtDeVhMQ0JkOGdyM2xZV09o?=
 =?utf-8?B?SnhTWll5RWpLNXA2NHVVUzZTNkI4UzBSOFJHcmpjeG56eklrRmtqc3o1bGMx?=
 =?utf-8?B?OFQxcjdLdnpYQlVFNjNyd2tML0tVNldEeFJHdHNuc0crOTBCTXh4SmxyY2ls?=
 =?utf-8?B?dnlpWGMzT2tFalBGM3ZsTVpkay9lNjBHaVNvcXpwWGVHNzdMOVp4bkRUUVlQ?=
 =?utf-8?B?MEtpL09RSlM4QTU1dm50ZnV2bjV3QWU3eFRuZFFhWks4ZUZDSms5ZGdvMWhU?=
 =?utf-8?B?aTJvNkQ1RjY0OGFVTDRNRXVjWnpEWnNaeHRHVng3R1gvU1NXUTlHVTZKb0J4?=
 =?utf-8?B?b0ZiRjF0T3I2VjZkenhpd1NGa2szOU9HMkxXVXZjS1RZQjF5ck1pNzkxcXFG?=
 =?utf-8?B?WjRMcW8zYVEwN1h6bkZ2ME5pYmZ4eFdkUGd4Tms4cFpMcUM2c3lNWkpnTHpq?=
 =?utf-8?B?NlpyV0d1clRsOW9FRE1KZjJFR1owZm5iOWFwK0tLRGFuMXpWblRYNUIvVGcv?=
 =?utf-8?B?N1pIbkZqRWplM1I2cDRMNHBGRkRoZm0ycEh0a3NEVjN3RXJERW4xTUU0Nlhj?=
 =?utf-8?B?WnFOeFF6cW5IelVWaUozTXpKL2Q3S1ZOeTVIeFl5aVJveWI1bDhveGlhSDZv?=
 =?utf-8?B?SHF1MWFZUE5LT2JDTkU4SDBhbXNOdUJDRjlGdEZCMk9RNGo5clhmZEFCTmk2?=
 =?utf-8?B?U3pMbUw2WkRYN1RqUXFUOHhUU1R0ZExQZTVteXJVbXV3bUFDeXhjcHFLb1Nk?=
 =?utf-8?B?d3hEOTRyYTQ0a3hlbEptQ3V3WGxVM2NTdWZrcG9NeW9yeitMYmVjNGZDTzZ3?=
 =?utf-8?B?WkhNR2lmWmtoU1RNNTJOdnN0cmFWQVFyYWV2bksydVNScTByRUJPSURQS1JT?=
 =?utf-8?Q?LBWqQYqXRAqq0tehp+p7ihWgl1mTiJqFFfHe7D25QM0M0U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d096d65e-a7ab-4fab-5e22-08dbf03cf9ec
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 18:08:08.4526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8620

RnJvbTogRWRnZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiBTZW50
OiBNb25kYXksIE5vdmVtYmVyIDI3LCAyMDIzIDE6MzkgUE0NCj4gDQo+IE9uIFR1ZSwgMjAyMy0x
MS0yMSBhdCAxMzoyMCAtMDgwMCwgbWhrZWxsZXk1OEBnbWFpbC5jb20gd3JvdGU6DQo+ID4gK3N0
YXRpYyBpbnQgcHZhbGlkYXRlX3Bmbih1bnNpZ25lZCBsb25nIHZhZGRyLCB1bnNpZ25lZCBpbnQg
c2l6ZSwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB1bnNpZ25lZCBsb25nIHBmbiwgYm9vbCB2YWxpZGF0ZSwgaW50ICpyYzIpDQo+ID4gK3sNCj4g
PiArwqDCoMKgwqDCoMKgwqBpbnQgcmM7DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHBhZ2Ug
KnBhZ2UgPSBwZm5fdG9fcGFnZShwZm4pOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqAqcmMy
ID0gdm1hcF9wYWdlc19yYW5nZSh2YWRkciwgdmFkZHIgKyBQQUdFX1NJWkUsDQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBQQUdFX0tFUk5FTCwgJnBh
Z2UsIFBBR0VfU0hJRlQpOw0KPiANCj4gQ2FuJ3QgdGhpcyBmYWlsIGFuZCB0aGVuIHRoZSBwdmFs
aWRhdGUgYmVsb3cgd291bGQgZW5jb3VudGVyIHRyb3VibGU/DQoNClllcy4gIE15IGludGVudCB3
YXMgdG8ganVzdCBsZXQgdGhlIFBWQUxJREFURSBmYWlsIGJlY2F1c2Ugb2Ygb3BlcmF0aW5nDQpv
biBhIHZhZGRyIHRoYXQncyBpbnZhbGlkLiAgQnV0IHRoYXQgd291bGQgYmUgd29ydGggYSBjb21t
ZW50Lg0KDQo+IA0KPiBTb3J0IG9mIHNlcGFyYXRlbHksIGlmIHRob3NlIHZtYWxsb2Mgb2JqZWN0
aW9ucyBjYW4ndCBiZSB3b3JrZWQNCj4gdGhyb3VnaCwgZGlkIHlvdSBjb25zaWRlciBkb2luZyBz
b21ldGhpbmcgbGlrZSB0ZXh0X3Bva2UoKSBkb2VzIChjcmVhdGUNCj4gdGhlIHRlbXBvcmFyeSBt
YXBwaW5nIGluIGEgdGVtcG9yYXJ5IE1NKSBmb3IgcHZhbGlkYXRlIHB1cnBvc2VzPyBJDQo+IGRv
bid0IGtub3cgZW5vdWdoIGFib3V0IHdoYXQga2luZCBvZiBzcGVjaWFsIGV4Y2VwdGlvbnMgbWln
aHQgcG9wdXANCj4gZHVyaW5nIHRoYXQgb3BlcmF0aW9uIHRob3VnaCwgbWlnaHQgYmUgcGxheWlu
ZyB3aXRoIGZpcmUuLi4NCg0KSW50ZXJlc3RpbmcgaWRlYS4gIEJ1dCBmcm9tIGEgcXVpY2sgZ2xh
bmNlIGF0IHRoZSB0ZXh0X3Bva2UoKSBjb2RlLA0Kc3VjaCBhbiBhcHByb2FjaCBzZWVtcyBzb21l
d2hhdCBjb21wbGV4LCBhbmQgSSBzdXNwZWN0IGl0IHdpbGwgaGF2ZSANCnRoZSBzYW1lIHBlcmYg
aXNzdWVzIChvciB3b3JzZSkgYXMgY3JlYXRpbmcgYSBuZXcgdm1hbGxvYyBhcmVhIGZvcg0KZWFj
aCBQVkFMSURBVEUgaW52b2NhdGlvbi4NCg0KQXQgdGhpcyBwb2ludCwgdGhlIGNvbXBsZXhpdHkg
b2YgY3JlYXRpbmcgdGhlIHRlbXAgbWFwcGluZyBmb3INClBWQUxJREFURSBpcyBzZWVtaW5nIGV4
Y2Vzc2l2ZS4gIE9uIGJhbGFuY2UgaXQgc2VlbXMgc2ltcGxlciB0bw0KcmV2ZXJ0IHRvIGFuIGFw
cHJvYWNoIHdoZXJlIHRoZSB1c2Ugb2Ygc2V0X21lbW9yeV9ucCgpIGFuZA0Kc2V0X21lbW9yeV9w
KCkgaXMgY29uZGl0aW9uYWwuICBJdCB3b3VsZCBiZSBuZWNlc3Nhcnkgd2hlbiAjVkMNCmFuZCAj
VkUgZXhjZXB0aW9ucyBhcmUgZGlyZWN0ZWQgdG8gYSBwYXJhdmlzb3IuICAoVGhpcyBhc3N1bWVz
IHRoZQ0KcGFyYXZpc29yIGludGVyZmFjZSBpbiB0aGUgaHlwZXJ2aXNvciBjYWxsYmFja3MgZG9l
cyB0aGUgbmF0dXJhbCB0aGluZw0Kb2Ygd29ya2luZyB3aXRoIHBoeXNpY2FsIGFkZHJlc3Nlcywg
c28gdGhlcmUncyBubyBuZWVkIGZvciBhIHRlbXANCm1hcHBpbmcuKQ0KDQpPcHRpb25hbGx5LCB0
aGUgc2V0X21lbW9yeV9ucCgpL3NldF9tZW1vcnlfcCgpIGFwcHJvYWNoIGNvdWxkDQpiZSB1c2Vk
IGluIG90aGVyIGNhc2VzIHdoZXJlIHRoZSBoeXBlcnZpc29yIGNhbGxiYWNrcyB3b3JrIHdpdGgN
CnBoeXNpY2FsIGFkZHJlc3Nlcy4gIEJ1dCBpdCBjYW4ndCBiZSB1c2VkIHdpdGggY2FzZXMgd2hl
cmUgdGhlIGh5cGVydmlzb3INCmNhbGxiYWNrcyBuZWVkIHZhbGlkIHZpcnR1YWwgYWRkcmVzc2Vz
Lg0KDQpTbyBvbiBuZXQsIHNldF9tZW1vcnlfbnAoKS9zZXRfbWVtb3J5X3AoKSB3b3VsZCBiZSB1
c2VkIGluDQp0aGUgSHlwZXItViBjYXNlcyBvZiBURFggYW5kIFNFVi1TTlAgd2l0aCBhIHBhcmF2
aXNvci4gICBJdCBjb3VsZA0Kb3B0aW9uYWxseSBiZSB1c2VkIHdpdGggVERYIHdpdGggbm8gcGFy
YXZpc29yLCBidXQgbXkgc2Vuc2UgaXMNCnRoYXQgS2lyaWxsIHdhbnRzIHRvIGtlZXAgVERYICJh
cyBpcyIgYW5kIGxldCB0aGUgZXhjZXB0aW9uIGhhbmRsZXJzDQpkbyB0aGUgbG9hZF91bmFsaWdu
ZWRfemVyb3BhZCgpIGZpeHVwLg0KDQpJdCBjb3VsZCBub3QgYmUgdXNlZCB3aXRoIFNFVi1TTlAg
d2l0aCBubyBwYXJhdmlzb3IuICAgQWRkaXRpb25hbCBmaXhlcw0KbWF5IGJlIG5lZWRlZCBvbiB0
aGUgU0VWLVNOUCBzaWRlIHRvIHByb3Blcmx5IGZpeHVwDQpsb2FkX3VuYWxpZ25lZF96ZXJvcGFk
KCkgYWNjZXNzZXMgdG8gYSBwYWdlIHRoYXQncyBpbiB0cmFuc2l0aW9uDQpiZXR3ZWVuIGVuY3J5
cHRlZCBhbmQgZGVjcnlwdGVkLg0KDQpJJ2xsIHdvcmsgb24gYSBwYXRjaCBzZXJpZXMgdGhhdCB0
YWtlcyB0aGUgY29uZGl0aW9uYWwgYXBwcm9hY2guDQoNCk1pY2hhZWwNCg0KPiANCj4gPiArwqDC
oMKgwqDCoMKgwqByYyA9IHB2YWxpZGF0ZSh2YWRkciwgc2l6ZSwgdmFsaWRhdGUpOw0KPiA+ICvC
oMKgwqDCoMKgwqDCoHZ1bm1hcF9yYW5nZSh2YWRkciwgdmFkZHIgKyBQQUdFX1NJWkUpOw0KPiA+
ICsNCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7DQo+ID4gK30NCg0K

