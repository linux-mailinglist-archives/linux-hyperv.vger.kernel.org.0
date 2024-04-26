Return-Path: <linux-hyperv+bounces-2049-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6208F8B3CEF
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Apr 2024 18:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C211F24059
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Apr 2024 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197B4153BD0;
	Fri, 26 Apr 2024 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WP0zktD4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2054.outbound.protection.outlook.com [40.92.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6822F12C493;
	Fri, 26 Apr 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149350; cv=fail; b=Wk8YMvHvq3wSZOiq4xy5psE72OaU4u7ERTjCK1W5UGKL4YksbI6yKKlYGX6MJct8eFt+Sxys1yq4kFcLh6iQ4UbgrIF86lFA5lQ5OgjZyVpDrOnWjx/+pDLWPDIjnUmMLEIih7CHvGCnqiyR2AyPGNxos5b1ChFIPCeGZgIyE1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149350; c=relaxed/simple;
	bh=SZ84C/dDnvpZC3v9yv+MuHttjbXrg7Vbjmu2NANRXus=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W/CNNUH3GE+dId9oWiIk3TiMjK+SXVGYFuYzxF3S8otD985qwhmjBXlcuxvAkuSxnJoWUJhT7/E7AqqZTcOFcxq4MC7PoIurVWOSgkVk9aVLTP4h9/i7QvEzQPsXfCK0mf+HiGS0VZRVxmUG3tCkdy5O1rPtneiuS0A2PIzgijM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WP0zktD4; arc=fail smtp.client-ip=40.92.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJ2h4GLNFsKF6iUzR/hgONaCECMIKAMBeMpfxlY0gjkPY1xUUxKorL5Q6RPQx9DxRlfnvQyEjN9k6Akm8d2SmzZvBD0cp/vibA2tpnP6cPkVEB+GMZRi7UfM35hsFZdYE6vUA5S6wWoxNocptjIlCoJV/lgHaWyeggdxwk4BIo3eMjNSjv457tn2wta7NCtIcm+X+6VwfZaN784mEF1k/9wMW9qZ20P/hUHKb/HxdEzkHJdnwCRFKQsqWbh6oTv3B7qXlQh9qFXPf5Z0fbGNJ4iSFpzT8HBQYN9aiCUjoxmo+1TZgkrI/aqCA8wxjLiD3sFKprV5M8PwOrvqX0nf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZ84C/dDnvpZC3v9yv+MuHttjbXrg7Vbjmu2NANRXus=;
 b=jU7IyjLuc6mOMwVSof/+0oLVzGmLscpP1V0bOGDAMRISo0NDTr1gJe0qggxQlm7vXJCM5pvMk2RKbFuZws18Q6xNfwycgKG2RBm4yQ+bxsv87euHyF8rxE0X1p3/CRUPzYaHuaYLzESmi9q6T3J+Cu/ZYwQtQBuD+LZ8bQ6TkzJRk26+YqeUV8Irw8Nq825OgzINWD6LQZ2H9AIYVU+iwHZ68EZvrhX/+eO1jpjPNe5fSw0y9K9wlDsQM09lgARVkENJr13wp+5A2feDc0lsppGOgSn+bJn1RHu/uoc/tncWEVV4YicCPvS2J2ULbpNlUVr0I0zANZ1Vq8j9G1U8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZ84C/dDnvpZC3v9yv+MuHttjbXrg7Vbjmu2NANRXus=;
 b=WP0zktD4T3CRvUpfg+0str/vOpxwbLTUw9Jw2zsfUqMyCzGOfHlVEqhnlDLpPhiZ23iHTw1xBWse3q52HaMgVsUPmzo82/Dmkh8J0pgP0nYEWPe9JBNUj6MlxJ6q3JRf2QlV8TH4CR97GZxg/n7D2jSCJuNOF5a019v/cYq0KgiXaAyfhB7C0CQTprK3/hfBG6d7+2WtDaTl7f8zDwq5pBXLUWGjFNP6oVOzNURbVQm4CDbijcRWY4Tqs2fqa50JZIexp9+/gaF7tfPbUbptIZgE+nrUNiCLviXZu4W+4qErxo039loMGrrjHUpxxcig7FxHtqCazVd6haO5Aab5EA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7599.namprd02.prod.outlook.com (2603:10b6:a03:32e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Fri, 26 Apr
 2024 16:35:44 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 16:35:44 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: David Hildenbrand <david@redhat.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] hv_balloon: Enable hot-add for memblock sizes > 128
 Mbytes
Thread-Topic: [PATCH 1/1] hv_balloon: Enable hot-add for memblock sizes > 128
 Mbytes
Thread-Index: AQHac9/FvegMInbDgEC8/Y4zZ5caUbF6iDAAgAB992A=
Date: Fri, 26 Apr 2024 16:35:42 +0000
Message-ID:
 <SN6PR02MB41571838C410EB52F328A461D4162@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240311181238.1241-1-mhklinux@outlook.com>
 <30d66f75-60c8-4ebf-8451-839806400dd4@redhat.com>
In-Reply-To: <30d66f75-60c8-4ebf-8451-839806400dd4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [tr3vH/oVWquu1w/Hz4E4CwXpRwKL8anh]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7599:EE_
x-ms-office365-filtering-correlation-id: 26f15c1f-ee75-42ac-ad43-08dc660eea67
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3412199016|440099019;
x-microsoft-antispam-message-info:
 YFoLe5xj730MHCyFBRqOvk0rUdzWUtMFAY09yJwTzWVswPUxO6bAHv4K/iyAAFS5HuH6f0xsgAWOAROhY1f0vIFONm/l0FjpBfWPJS7v/fKx2urVvlnL6ufACOa3bwgp2ak8lVFjiS3mETXJMg6obcpWE8mS/3Lq/PNoilK+9zcXvL45B7fGG+riiaOtBSQf8SXdb3BBzWicGCgnTVOwzY6MH4NypFJyYf73/iaRxSQnAvvuGmOed8VK7Mq61Eqrsy0WCsUJdd2gdQrxFl31ZBqkVxVGjfVVgH4jDsSSPwZJnkyxcHkYOsjOd51h6dlm199WqGRuipVkLDj83v7zKdMvctHBCBKwtoTS2CPL0ZLiXKX6b4V6bPDJXyc+LhuYoGDXasLYZ7STLe+EiBvXrTVR1ozo1jXas1/Z6rHSdZEchRCtLsp1rbHQAYtcKoelVtTT7CT5fZnPtJwI9Qq2F4cVYc4U4UzzYQjNbMWiSP0+R1uNMByQ/PSDIFfeJW1NZz2pk+ezI5LC2cKLTTISZIcFB0P6AqSjGXXAt9PtloNjeL9MNhqiPgpZ0K4a814G
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWU0K1o3MzU4Q3A3RDJqbUdpS1BLd0xQTS9MNTdwek5qdzZNRHhNYVJlc3M1?=
 =?utf-8?B?aUJ6TFhkRDI5T0FCZ0hUTzkyL0MrVjUybGJBdFV5eVBsMncrZlZBWEhIMXBZ?=
 =?utf-8?B?cUpLRlJhdzVqS00rOVJ2SVZSNUM2R2VvVGpBN1JpRDQ0VmxwamRTN3RVNjJ4?=
 =?utf-8?B?d09Mc2lDMTZYU0dWdDNXbU9CNTZ3WU5yZjRjeGVMb0ErZCtiTzBzRjNhNXlm?=
 =?utf-8?B?YzIwY1laS1podVA1MU5iUFNMM2pITEtLelVPZGVmYnVLOU1RZjU1SU1PV2Ra?=
 =?utf-8?B?eUxSenRrbzNXVW1HSk15SzNxTEVSTHRaL1o5Q2lYNSs0Znk4cDg0bVJRd3cr?=
 =?utf-8?B?NDByYVhVemtqbkhzdi9BaUJiZ2szTGJUbVZhL2hTVUtDODkyNDk4UlZPckRO?=
 =?utf-8?B?TmV5U29YellwVXJhbGlGbkR2L25aeGZ3L0VjdXFBQXppa0VVNitMdmxubnFW?=
 =?utf-8?B?NGNnTm1hZFNNYk0wakExLyttTE9YTUR6K0VneFRWaDN6eFVkMnFIVDNmc1hG?=
 =?utf-8?B?bWx4dGdDaGZpaXZkYXE0K0wySC9jcU1GTnluRmRUanlIc3RUZE0zMkJTMWli?=
 =?utf-8?B?eDkvODZGOWRNRG1zaXZuVmdseDUrRFowd3lPdHhua05CTWxaQzdsMHAzZ2gx?=
 =?utf-8?B?ZDdPK29Zbk5ycG83MW1oR0pwTGk5aVQ4cytEL1JveXdsWGl4TWhNaFZTWklX?=
 =?utf-8?B?QmFtR2JEcjFTbmFTb1Nab1M2eThmMkplWWc1R09NdktZa2ZUdE55TnB1S0RK?=
 =?utf-8?B?a1NIREp0bzdPWmhqM1AxQjFndEF4TThpcVZlT2lhM0xqdUhyMTBzdXcxSStP?=
 =?utf-8?B?bHpTck9haCtxK2tlTkF2azF1SDZHT2Y0dXd0Vk1DQ1hqOHU5a1EvblVpYVNY?=
 =?utf-8?B?eTlGZElTU1NlTldzVEN2ZVZKdEZPaXhVWXJRN2M1TVFGZFc5TTE4Y05rZEx6?=
 =?utf-8?B?RWQvRjU5bUNjYTBEQzloR1FaY1dwakJiKzNyR3JTcWJxeUpBL2lUQVl3eTJW?=
 =?utf-8?B?VkVmVTE5Z0hBSVZtTjkzcUlTeVNwSS9TNFg2SWY4MU1PZFc3Q3o0T0pxdHJx?=
 =?utf-8?B?Q2tkaGR0SFlOekI3WGNJcFVaZ2lvRlZYL05JM2k1MlRGWUd2R1F1WHpycVpO?=
 =?utf-8?B?Zy9mV3ladEc2SlZSU2pNM001a3VTWGNxaStUYm54MXRMdXgwNXV2R0p0ZDlo?=
 =?utf-8?B?ZG1zbHFTQ2pncE5CN0dGMHdaOUVIZXZsUkdLTXZpY2ZaOWZQMzJRZFBkR0pK?=
 =?utf-8?B?UzFienhVWUNUOUdydWdySi85OXh0OThlZEpOcFJWMlEzYmlFNUw4VUgwcEFB?=
 =?utf-8?B?SGNkRzY2aVhpaDl5Y3lmM05CS0VXdHVqN1phR1RGZndnQVJTd0orWi9ZWUxN?=
 =?utf-8?B?UjhkUDRJeGw1aFM1QTlQcDlvZlNiSEhLem9yWU8yNm9tVGhNaUtKM0dYdzdL?=
 =?utf-8?B?UldRS0pEZmRjOGNXYkt5QWZiY0RLL0Ixbm1iR0szc1k0MGZUNkhZVy9oY1lS?=
 =?utf-8?B?TVl0RW5CVXpkRU1HaUh0aStGRUpwSFRzRU1JQXc1ZU00ZHZFbVhmd3BacTZL?=
 =?utf-8?B?S3VPNHdpTnBOQWFBS1piMXI0eXhkU1RQVWhtNGxOYnFHQVptOTdwRkRNM1Zt?=
 =?utf-8?B?SWs2QTBIRUlQQWt1WElUd0xGWGZ5ZVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f15c1f-ee75-42ac-ad43-08dc660eea67
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 16:35:42.7896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7599

RnJvbTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+IFNlbnQ6IEZyaWRheSwg
QXByaWwgMjYsIDIwMjQgMTo1OSBBTQ0KPiANCj4gT24gMTEuMDMuMjQgMTk6MTIsIG1oa2VsbGV5
NThAZ21haWwuY29tIHdyb3RlOg0KPiA+DQo+ID4gRml4IHRoaXMgcHJvYmxlbSBieSBoYXZpbmcg
dGhlIEh5cGVyLVYgYmFsbG9vbiBkcml2ZXIgZGV0ZXJtaW5lDQo+ID4gdGhlIExpbnV4IG1lbWJs
b2NrIHNpemUsIGFuZCBwcm9jZXNzIGhvdC1hZGQgcmVxdWVzdHMgaW4gdGhhdA0KPiA+IGNodW5r
IHNpemUgaW5zdGVhZCBvZiBhIGZpeGVkIDEyOCBNYnl0ZXMuIEFsc28gdXBkYXRlIHRoZSBob3Qt
YWRkDQo+ID4gYWxpZ25tZW50IHJlcXVlc3RlZCBvZiB0aGUgSHlwZXItViBob3N0IHRvIG1hdGNo
IHRoZSBtZW1ibG9jaw0KPiA+IHNpemUgaW5zdGVhZCBvZiBiZWluZyBhIGZpeGVkIDEyOCBNYnl0
ZXMuDQo+IA0KPiBUaGF0IHdheSwgd2Ugc2hvdWxkIG5ldmVyIGJlIGdldHRpbmcgdW5hbGlnbmVk
IHJhbmdlcyBJSVJDLCBjb3JyZWN0PyBJDQo+IHRoaW5rIHdlIGFkZGVkIHdheXMgaW4gUUVNVSB0
byBndWFyYW50ZWUgdGhhdCBmb3IgdGhlIEhWLWJhbGxvb24NCj4gaW1wbGVtZW50YXRpb24gYXMg
d2VsbC4NCg0KQ29ycmVjdC4NCg0KPiANCj4gPg0KPiA+IFRoZSBjb2RlIGNoYW5nZXMgbG9vayBz
aWduaWZpY2FudCwgYnV0IGluIGZhY3QgYXJlIGp1c3QgYQ0KPiANCj4gTmFoLCBpdCdzIG9rYXkg
OikNCj4gDQo+ID4gc2ltcGxlIHRleHQgc3Vic3RpdHV0aW9uIG9mIGEgbmV3IGdsb2JhbCB2YXJp
YWJsZSBmb3IgdGhlDQo+ID4gcHJldmlvdXMgSEFfQ0hVTksgY29uc3RhbnQuIE5vIGFsZ29yaXRo
bXMgYXJlIGNoYW5nZWQgZXhjZXB0DQo+ID4gdG8gaW5pdGlhbGl6ZSB0aGUgbmV3IGdsb2JhbCB2
YXJpYWJsZSBhbmQgdG8gY2FsY3VsYXRlIHRoZQ0KPiA+IGFsaWdubWVudCB2YWx1ZSB0byBwYXNz
IHRvIEh5cGVyLVYuIFRlc3Rpbmcgd2l0aCBtZW1ibG9jaw0KPiA+IHNpemVzIG9mIDI1NiBNYnl0
ZXMgYW5kIDIgR2J5dGVzIHNob3dzIGNvcnJlY3Qgb3BlcmF0aW9uLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPg0KPiA+IC0tLQ0K
PiA+ICAgZHJpdmVycy9odi9odl9iYWxsb29uLmMgfCA2NCArKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMo
KyksIDI3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvaHZf
YmFsbG9vbi5jIGIvZHJpdmVycy9odi9odl9iYWxsb29uLmMNCj4gPiBpbmRleCBlMDAwZmEzYjlm
OTcuLmQzYmZiZjNkMjc0YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2h2L2h2X2JhbGxvb24u
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvaHYvaHZfYmFsbG9vbi5jDQo+ID4gQEAgLTQyNSwxMSArNDI1
LDExIEBAIHN0cnVjdCBkbV9pbmZvX21zZyB7DQo+ID4gICAgKiBUaGUgcmFuZ2Ugc3RhcnRfcGZu
IDogZW5kX3BmbiBzcGVjaWZpZXMgdGhlIHJhbmdlDQo+ID4gICAgKiB0aGF0IHRoZSBob3N0IGhh
cyBhc2tlZCB1cyB0byBob3QgYWRkLiBUaGUgcmFuZ2UNCj4gPiAgICAqIHN0YXJ0X3BmbiA6IGhh
X2VuZF9wZm4gc3BlY2lmaWVzIHRoZSByYW5nZSB0aGF0IHdlIGhhdmUNCj4gPiAtICogY3VycmVu
dGx5IGhvdCBhZGRlZC4gV2UgaG90IGFkZCBpbiBtdWx0aXBsZXMgb2YgMTI4TQ0KPiA+IC0gKiBj
aHVua3M7IGl0IGlzIHBvc3NpYmxlIHRoYXQgd2UgbWF5IG5vdCBiZSBhYmxlIHRvIGJyaW5nDQo+
ID4gLSAqIG9ubGluZSBhbGwgdGhlIHBhZ2VzIGluIHRoZSByZWdpb24uIFRoZSByYW5nZQ0KPiA+
ICsgKiBjdXJyZW50bHkgaG90IGFkZGVkLiBXZSBob3QgYWRkIGluIGNodW5rcyBlcXVhbCB0byB0
aGUNCj4gPiArICogbWVtb3J5IGJsb2NrIHNpemU7IGl0IGlzIHBvc3NpYmxlIHRoYXQgd2UgbWF5
IG5vdCBiZSBhYmxlDQo+ID4gKyAqIHRvIGJyaW5nIG9ubGluZSBhbGwgdGhlIHBhZ2VzIGluIHRo
ZSByZWdpb24uIFRoZSByYW5nZQ0KPiA+ICAgICogY292ZXJlZF9zdGFydF9wZm46Y292ZXJlZF9l
bmRfcGZuIGRlZmluZXMgdGhlIHBhZ2VzIHRoYXQgY2FuDQo+ID4gLSAqIGJlIGJyb3VnaCBvbmxp
bmUuDQo+ID4gKyAqIGJlIGJyb3VnaHQgb25saW5lLg0KPiA+ICAgICovDQo+ID4NCj4gPiAgIHN0
cnVjdCBodl9ob3RhZGRfc3RhdGUgew0KPiA+IEBAIC01MDUsOCArNTA1LDkgQEAgZW51bSBodl9k
bV9zdGF0ZSB7DQo+ID4NCj4gPiAgIHN0YXRpYyBfX3U4IHJlY3ZfYnVmZmVyW0hWX0hZUF9QQUdF
X1NJWkVdOw0KPiA+ICAgc3RhdGljIF9fdTggYmFsbG9vbl91cF9zZW5kX2J1ZmZlcltIVl9IWVBf
UEFHRV9TSVpFXTsNCj4gPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgaGFfY2h1bmtfcGdzOw0KPiAN
Cj4gV2h5IG5vdCBzdGljayB0byBQQUdFU19JTl8yTSBhbmQgY2FsbCB0aGlzDQo+IA0KPiBoYV9w
YWdlc19pbl9jaHVuaz8gTXVjaCBlYXNpZXIgdG8gZ2V0IHRoYW4gInBncyIuDQoNCk9LLiAgSSB3
YXMgdHJ5aW5nIHRvIGtlZXAgdGhlIG5ldyBpZGVudGlmaWVyIHNob3J0IHNvIHRoYXQNCm1lY2hh
bmljYWxseSBzdWJzdGl0dXRpbmcgaXQgZm9yIEhBX0NIVU5LIGRpZG4ndCBibG93IHVwDQp0aGUg
bGluZSBsZW5ndGguDQoNCj4gDQo+IEFwYXJ0IGZyb20gdGhhdCBsb29rcyBnb29kLiBTb21lIGhl
bHBlciBtYWNyb3MgdG8gY29udmVydCBzaXplIHRvIGNodW5rcw0KPiBldGMuIG1pZ2h0IG1ha2Ug
dGhlIGNvZGUgZXZlbiBtb3JlIHJlYWRhYmxlLg0KDQpJJ2xsIGxvb2sgYXQgdGhpcy4gIE1pZ2h0
IGhlbHAgdGhlIGxpbmUgbGVuZ3RoIHByb2JsZW0gdG9vLg0KDQpUaGFua3MgZm9yIHRoZSByZXZp
ZXcuDQoNCk1pY2hhZWwNCg==

