Return-Path: <linux-hyperv+bounces-2053-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6EE8B5DBF
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Apr 2024 17:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB43528A698
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Apr 2024 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF28287D;
	Mon, 29 Apr 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="S3v0B+Zb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19013006.outbound.protection.outlook.com [52.103.13.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21015823CC;
	Mon, 29 Apr 2024 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404660; cv=fail; b=nt4rj4X56grfsfUXggERwnea043g62hFhXZ/MbJCNyqVuW26CtAVZK7DYDNq3WUvp05TRkHlKvxClRx39WI5d6PRq0X8virVE/ibaWjN7HAawh9wbRi1vGoda3dR8iotS3JdZ3jJxRNkTPF2EFqzeeG1Hn9vbXlkcB+L3Q151PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404660; c=relaxed/simple;
	bh=qAmD9kkc/gn13RK/WVdghY09IHuVSYiJgDrG5Jt6dBM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BhpMjrMjGz6x+yryYrlY55Tzsvc/WtNhyNp+XGtBxfGuP8E1DKeaI4GCdcfu7E9ZSupu1dVYGZAuE7yya4zWHhu9azqZOKsxEcNV1AZ8+g+OH9zlVZSo7weQZRMQvlAk+BICzOUNQsmhwRn88cwWgFpPc55Lrh92U8LaODH+oVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=S3v0B+Zb; arc=fail smtp.client-ip=52.103.13.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn/LgZzFbyG3wZGPLEp915WOvxIQ1g3Y4v04ymBgav8kgM9iokaV+BRgamZv4JhUtI7sRPgXcdLE708ngOdjnorKYPTgMbHkigQZSBdMlL/FPFcwNVoYN7+dGQbgb9IlhsRP3nnyTsy0w7cX4/0AYZrf+NiZhabxuNqIhFlQEhV6/+GwBO8nRkhjsOea/VKJH5I47krpBoNT30ZBq6FzBiLSc+UnEnCDSK/zqOtCrYOz4EW6MFNuOt2nU4wAK7pv06Utc74mguKB+VmeXq+9M9tbodjHOEfHcQu4r+YEnbBiaiA2JAPCE28kDFNdXVp6txR0OV3CVUpfCsq6KLNfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAmD9kkc/gn13RK/WVdghY09IHuVSYiJgDrG5Jt6dBM=;
 b=oJpFl38YUxJ8m6TNxYGO4/+Lvndbom86X23RpQ4ZoU/yAHhbXn6FJ91u/pajWl7C6lz5NTEjDkmzwe6NT3YL7cDEmJLoBE0e90qBJBoegCLm/Og2db0SFh/YyvxajgbSJ5CENZ5IK71zgJqTaqOs2IqOnQQ1MQ0QDgugrZUJ/mFY9C9PzaFNso4sEu+zwAozfCZuSa+edSERt3nKmXaUJXZCwCu12VS631TcAtkKfJ3zt5pzhOT5ay8PpxQ3SgKF64T9DMVAvCQ6hMxWX9+5bCwCpowMeF/9ECvdeuthdad/rzpHYhs4eyFf3H4ufdvZyrqmy+Q+gjnBCWYvhqyS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAmD9kkc/gn13RK/WVdghY09IHuVSYiJgDrG5Jt6dBM=;
 b=S3v0B+Zbu8rk7k9m9yKkQHicsaz0d9KDMbicSXAnvMgyNe5bCr2XU6MwL6aWjljjA7x6MYsbmBf3fBCJ6WR0skHYww/8/nR05tlDOXYKUxOdVC0WT6xvqAziaoq88UsN/ruNxnvREud1FBN8iyo5G/uOY/fVv89PBenvMSUBkFLsh4v3Ob/2l5Hf3WX1VhjpbNsBvN4+TwuTZrcc2CJ2yljMovVqOTgndlY4Sgp/TMEVxo9mV30ab4KH/EmGz6sHSmr5x5nlb+801ebYUzkb1W5bT6HkP3lVDTVdcEXZ9pNCrWQXNfadRKvAEjS8OOvT9kzIwGSIA97sBuRYpjr4uw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6540.namprd02.prod.outlook.com (2603:10b6:610:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 15:30:55 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 15:30:55 +0000
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
Thread-Index: AQHac9/FvegMInbDgEC8/Y4zZ5caUbF6iDAAgAB992CABKK2UA==
Date: Mon, 29 Apr 2024 15:30:55 +0000
Message-ID:
 <SN6PR02MB4157D5BB1C140D229875AB50D41B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240311181238.1241-1-mhklinux@outlook.com>
 <30d66f75-60c8-4ebf-8451-839806400dd4@redhat.com>
 <SN6PR02MB41571838C410EB52F328A461D4162@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41571838C410EB52F328A461D4162@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [D9xQgKjsDq/iTmC+PgNrFgQVRtv/75lE]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6540:EE_
x-ms-office365-filtering-correlation-id: 2443b07e-d04a-4ef6-7479-08dc68615ca5
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|440099019|3412199016;
x-microsoft-antispam-message-info:
 ogxRTzX22x1x7y4a/XU2nnfkSofuDiSlNVjcA01Sqhh3xCo/CVHKUy97kRyKeO7IdrtA0q/Zn0Aj7CinaEwC2hmSTMMO7+TuAqg/I0L/7Zy/exdmeW2OxjMci9fX2KlHfuLtCHIj/17P94xEzLfqkYEOXIUyLuboBnzENb2nOdFrSetnFiyl71mo4MwNQ5uFY3PEzFMobb46uRw6LmyLEm9W7YbLvQ5LeRY0mZuQEDpH7dsNtissHItgqhMFxXgTgSTenOpnMNi9KXkMmgRSpGB4tHTdkFwAEQrlirZEfvmAzmWi78DG4ur8BR2HRMKCrMWCTt8U/NqKy8Chv6CbyIVmB9pdXE8jOg27K+KdUA3QyfO/lHWkA49KoFw/QQaAQY/Ao+tCsaKZ63QjLr6JZ2qOUubtUTIEYd6CZ9QBjciVYCJlqkyVUr33GG8P3r3zVExeclNw0745FJriXVeeg9MQGodiDnqfVz00PvLYMKkMGstg5ZVy/bVMF8t5GFLOd0GpDJ0VovVDT3IVaNvZTTifqDUhJl+FMvzR3lOjmkXJqOKMQ32yWmNHPGn80oZC
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzVjTWwvZDJ1Q085Nkc4alp3SlVkZ2lDNWNLKzAyNWlaUmJ4VDIrOGFsd29l?=
 =?utf-8?B?QnhTMUFCSkFBSk1mVjM2QUR6V0s1MlY0dk14amhOemxpSENpVXlvYTNSeENk?=
 =?utf-8?B?MmdzK29oY1o2aGppRm1FQ1UwN2ZYa1lQaU1xOUxFWU1BNW15RWNQRHJhejFp?=
 =?utf-8?B?d1cxelJ4eTlvYUdZOXhMNG9Ld0dZa05tZGthY25CZ080dkFBMUFKNk0rRzl4?=
 =?utf-8?B?dWxkR3d0cExYaGVpRE9sV09JNmN2WSt6aTlqYlRKU3RSVDZ3ZzkrMWx3elZ4?=
 =?utf-8?B?NWNQR1ptZFk3MmlpeGV2alhIMmhrSXpmeWtoM3hIY0IvUTR4ZFM4VHNyTE54?=
 =?utf-8?B?Wlk0TWFlUXpWNHhkWk8wVmxTQjlxc250Ujc1L3dLUTU4WThTK3FHNDl0bFk2?=
 =?utf-8?B?WnlLSlpKa2ZCZ0pmK0d5c0VsdG05dlpodDZ5UGtXY0dRMk5Tb0l6eGV3S3lC?=
 =?utf-8?B?NmwxazBWYnRheXJBSWM1Mm5pUTRBQnJzZFA1Z0I4YnkrZUswaGJVS2kvRTht?=
 =?utf-8?B?L2QyZ00xTFNXNzZzdlNQWHdlQVRUa2hvcnpVak9NeXdFcWttSHVFVkI1eFBB?=
 =?utf-8?B?eDZjTjJSTUNiRjUwcFdNZ085T1ZscmliNmk2VldOVkxjRUorUDAzei93d2tO?=
 =?utf-8?B?Wk9IMkFTZ2VsUWR3WUZUSUQ2cXVhOWh2OFA4ZXNhbFI0WS9hVkZhclBrNlpQ?=
 =?utf-8?B?TTVVK2VOSDJqWW5SSnJXd1duMk5DRDZ2RmlZdGZaTmhXVU5rZVVick1MVGNq?=
 =?utf-8?B?STNqWHJlcFo1dDJ4MXBiVGY1NjN5cGtibDNxeEtjWklQNG5SREV1MlM4eDNT?=
 =?utf-8?B?Y0NTNnIyWUpTQnc4aXlNYkVFNEJXV1R2NUFsSjdrdGRJSkttRkowMUlIOXNk?=
 =?utf-8?B?Zm5RSkNqeEZoeTlQZnJjcWpjSmJpTjdScTVJb2gvWit4ZkZadk0rNHVrTmI2?=
 =?utf-8?B?aURuS3FPMDF4a3lRdjVCL1VTMDNSb3luTTAxT3NwSGxYTk5jRlpKd1JLSkZj?=
 =?utf-8?B?bXg1eE1FdmMwR2oyengrRHduUVN2QStmdXFRUjlzZGpXL3k4WmZDZlliZlYr?=
 =?utf-8?B?RG5BbzhOVHlRRzdaOG8wcFdFVTBEMW1FSTEvYXJEUm5uMWw0cXB5alF6OTNG?=
 =?utf-8?B?cjd2bnhuNk1WR0tJZEhDS2pTa0dHdWs4QmVoRFpaazFVSWlrTzZmSzZnVm96?=
 =?utf-8?B?THNhL1A1ZTlEUmJKODRWTjQ5a2NET3BlOUcwcDYyZURqWXZxbXZXNEFGMDlF?=
 =?utf-8?B?bWdPYnRVSFNnd0wzVENaT1BndCtyb3ZMdHlRVnpGRVJVNFhkZkI4Y2swcllC?=
 =?utf-8?B?a3hGcC9TYUdKY1N1TEVZZU5IbUFVYk9qYWMrb1NHdXRDN1F3d2xIUUJOaUxs?=
 =?utf-8?B?eCtONVdmdDlaNExtay8yTVlINWNFZWFJS2J1VzFyQllIQ3l2L0hOQkN0MVBW?=
 =?utf-8?B?YzZlNFJGQWlWU3JneTJTQnlZYWluQlpyeUpzMW9ncTNlWWRzeGRGcE1neFBR?=
 =?utf-8?B?MWVjR0ZXQkFPL1hDTXV4WklrWVIzVmpycVdUWWJWRU9UZDhGRWdVbnI4bk15?=
 =?utf-8?B?TDNScXE1elhuZzJyMFV4dnNQdkV6bVRZVW5jS2YvUFBtQzhZMG1VSXNya2Zo?=
 =?utf-8?B?RC9qYlpHODlvbExuRGhjcnJwZkMrSGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2443b07e-d04a-4ef6-7479-08dc68615ca5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 15:30:55.5020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6540

RnJvbTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPiBTZW50OiBGcmlkYXks
IEFwcmlsIDI2LCAyMDI0IDk6MzYgQU0NCj4gPiA+IEBAIC01MDUsOCArNTA1LDkgQEAgZW51bSBo
dl9kbV9zdGF0ZSB7DQo+ID4gPg0KPiA+ID4gICBzdGF0aWMgX191OCByZWN2X2J1ZmZlcltIVl9I
WVBfUEFHRV9TSVpFXTsNCj4gPiA+ICAgc3RhdGljIF9fdTggYmFsbG9vbl91cF9zZW5kX2J1ZmZl
cltIVl9IWVBfUEFHRV9TSVpFXTsNCj4gPiA+ICtzdGF0aWMgdW5zaWduZWQgbG9uZyBoYV9jaHVu
a19wZ3M7DQo+ID4NCj4gPiBXaHkgbm90IHN0aWNrIHRvIFBBR0VTX0lOXzJNIGFuZCBjYWxsIHRo
aXMNCj4gPg0KPiA+IGhhX3BhZ2VzX2luX2NodW5rPyBNdWNoIGVhc2llciB0byBnZXQgdGhhbiAi
cGdzIi4NCj4gDQo+IE9LLiAgSSB3YXMgdHJ5aW5nIHRvIGtlZXAgdGhlIG5ldyBpZGVudGlmaWVy
IHNob3J0IHNvIHRoYXQNCj4gbWVjaGFuaWNhbGx5IHN1YnN0aXR1dGluZyBpdCBmb3IgSEFfQ0hV
TksgZGlkbid0IGJsb3cgdXANCj4gdGhlIGxpbmUgbGVuZ3RoLg0KPiANCj4gPg0KPiA+IEFwYXJ0
IGZyb20gdGhhdCBsb29rcyBnb29kLiBTb21lIGhlbHBlciBtYWNyb3MgdG8gY29udmVydCBzaXpl
IHRvIGNodW5rcw0KPiA+IGV0Yy4gbWlnaHQgbWFrZSB0aGUgY29kZSBldmVuIG1vcmUgcmVhZGFi
bGUuDQo+IA0KPiBJJ2xsIGxvb2sgYXQgdGhpcy4gIE1pZ2h0IGhlbHAgdGhlIGxpbmUgbGVuZ3Ro
IHByb2JsZW0gdG9vLg0KPiANCg0KSSBkaWRuJ3Qgc2VlIGFueSBwYXJ0aWN1bGFyIGNvbXBsZXhp
dHkgaW4gY29udmVydGluZyBzaXplIHRvIGNodW5rcy4gQnV0DQp0aGlzIHNsaWdodGx5IG9wYXF1
ZSBzZXF1ZW5jZSBpcyByZXBlYXRlZCBpbiB0aHJlZSBwbGFjZXM6DQoNCgluZXdfaW5jID0gKHJl
c2lkdWFsIC8gSEFfQ0hVTkspICogSEFfQ0hVTks7DQoJaWYgKHJlc2lkdWFsICUgSEFfQ0hVTksp
DQoJCW5ld19pbmMgKz0gSEFfQ0hVTks7DQoNCklmIEhBX0NIVU5LIChvciB0aGUgbmV3IG1lbWJs
b2NrIHNpemUgYmFzZWQgdmFyaWFibGUpIGlzIGENCnBvd2VyIG9mIDIsIHRoZW4gdGhlc2UgY2Fu
IGJlY29tZToNCg0KCW5ld19pbmMgPSBBTElHTihyZXNpZHVhbCwgSEFfQ0hVTkspOw0KDQp3aGlj
aCBpcyBhIGxvdCBiZXR0ZXIuICBJJ2xsIG1ha2UgdGhhdCBjaGFuZ2UsIGFuZCBhIGNvdXBsZSBv
ZiBvdGhlcg0KY2hhbmdlcyB3aGVyZSB0aGluZ3MgYXJlIG9wZW4gY29kZWQgdGhhdCBjb3VsZCBi
ZSBleGlzdGluZw0Ka2VybmVsIG1hY3Jvcy4NCg0KUXVlc3Rpb246ICBJcyBtZW1ibG9jayBzaXpl
IGd1YXJhbnRlZWQgdG8gYmUgYSBwb3dlciBvZiAyPyAgSXQgbG9va3MNCnRvIGJlIHNvIGluIHRo
ZSB4ODYgY29kZSwgYnV0IEkgY2FuJ3QgdGVsbCBvbiBzMzkwIGFuZCBwcGMuICBGb3Igc2FmZXR5
LA0KSSdsbCBhZGQgYSBjaGVjayBpbiB0aGUgSHlwZXItViBiYWxsb29uIGRyaXZlciBpbml0IGNv
ZGUsIGFzIHRoZQ0KY29tbXVuaWNhdGlvbiB3aXRoIEh5cGVyLVYgZXhwZWN0cyBhIHBvd2VyIG9m
IDIuDQoNCk1pY2hhZWwNCg==

