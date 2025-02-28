Return-Path: <linux-hyperv+bounces-4178-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C571A4A6B7
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 00:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8893BBD0E
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 23:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BE21DEFF4;
	Fri, 28 Feb 2025 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="X9S7U8M5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2081.outbound.protection.outlook.com [40.92.40.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A953523F380;
	Fri, 28 Feb 2025 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740786804; cv=fail; b=cWlHUfo9W/c5W0tRx5pPztzcYja2g9mcodLCObtmTagVnME5kDykRSCBCnm7L0zhTPpbjiY0icxF+VfNmnCbsX7BQlyW87UdjnNyD4mdDjdmQcoqJ1Usjz1b1icrezkgHKHJV5qHFcsoAwg6lez/732Juy7bVrVgn6CNBILHBtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740786804; c=relaxed/simple;
	bh=Z1QTzv3VTmAHzGkWv9IxcVpQ+EvlnT6hYNstYA6GioU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hG5GHRwaezzvDeVdWYu8Kwx0+AcNN7+mbTFVbea3ZZm5sw/kVJXxUS9P5adTlU5QxagPw5Z4Iz4ZBj3b+VeJmYks1tMFi2e9yBq/eWsbMVEt5vbSJ6quoMznYSxaXHL2lwo/DkMuiMbaGORzRgfHnCVNtBbhjZTQ8ZTWZd1TR9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=X9S7U8M5; arc=fail smtp.client-ip=40.92.40.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coqTM1lvhVjwHQXPPpQqv1QNK247qq1D/4zbvZ7qE75SwMVEL4SXJYEyIeCZ/T89tT0MeXg2ySPfoKzRP265nlDO8PJSbvlyNcGVcmWAPeiVbJKu4MUDw10mSZ5E6yKM2XQwPNqr6XNVfEHRNeKn9VD/rfj5CV88n7y9nvSCLIvOzBU0wIj1foaIS+uUSZgU98uyxx6X3/I5+3vDWviFv/PtaLWS70yjzR/KiZeS5q6EPVFm9XAVZbbxCwDzraAJph/7NmFnDdvrttkQPrK3QSUpErNRztaNDXjAqk/vexCrRrckMEqaxfr77dk6M9RHw/56rHTZTgoyiYkqVuYRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1QTzv3VTmAHzGkWv9IxcVpQ+EvlnT6hYNstYA6GioU=;
 b=OcEWvp16J7rQCTgBIKa1JLAexZfICmayzWN8FMk8q1IvCCsHnGTRQ6EbJU1byZCyAjMjqsPyEDfPpisaobeixtPd+znHH21qivgZ1ghbtmNFKquaOjr/5ZLyQCfIh+9Ux+OFOUghLpOb8y9g6P6S9+Jezil3rCF8D28ldknkIcyIJp2CvzGhjGWl1bZTPsTYeg2gF3c4SfC64blPcZ2wf21hPMDPR49pJYaX7QdTrQoOwvzalkxJOSGb0/H7vW1jz8hH4mEmkiqZVin1EqGd7SBD/8CzbxBAf1HQen2a8gWrLuOH4wJL54kAxbNg1ktXf06o5tXXCjh1CMCUxbAnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1QTzv3VTmAHzGkWv9IxcVpQ+EvlnT6hYNstYA6GioU=;
 b=X9S7U8M5pbNk8iM8EkYKD0pgAUDdYM3TPIYfecWsBpG7cY4rnYISZwy3rr0KLLCePIPy4WLC9F0iSUGCObL4oJtuW5ps5+TtUExYOLEgnieFJWWVamR0hIbITvIJHUqsS71Rg4D/Brc2hRkgObwD3FTSa1xhTmXZFsfa5nhdZsUZrp/zt6p3aWlJcYidqauB48+M+ghAY4NyGU9tBphtD0FWnidOwm42AG6E1CV0Jue5HU73luN10R5zFycM0GpdvlNSsaELdV4peVAuvgPEl78idg2f9nDCeUqiDUP65xANmdqmUfdKQb6m/uvoasRx/1D7DzkKbMu2zd+9lwDAfw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7528.namprd02.prod.outlook.com (2603:10b6:510:4d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 23:53:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 23:53:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next] scsi: storvsc: Don't call the packet status
 the hypercall status
Thread-Topic: [PATCH hyperv-next] scsi: storvsc: Don't call the packet status
 the hypercall status
Thread-Index: AQHbiW/CBMS6VYjfVkGy2I3sv9oGd7NdL2GAgAAlOICAAA/d0A==
Date: Fri, 28 Feb 2025 23:53:19 +0000
Message-ID:
 <SN6PR02MB41578042F4450CFE575389B1D4CC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250227233110.36596-1-romank@linux.microsoft.com>
 <SN6PR02MB4157749BCF2F3226008575E0D4CC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aba327ea-ee90-4868-b23e-c2a3ce2ede43@linux.microsoft.com>
In-Reply-To: <aba327ea-ee90-4868-b23e-c2a3ce2ede43@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7528:EE_
x-ms-office365-filtering-correlation-id: 38491ba4-c019-40c5-2796-08dd585313b3
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999004|461199028|8062599003|8060799006|19110799003|15080799006|13041999003|3412199025|440099028|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q01LR3pKWXNZbDBaQkJ3V1NNNDFGc2RDSG05Y3loZkxMSGRsUW1yZEtHL0dh?=
 =?utf-8?B?cnVlR1JHRE5rN1RLbmlsZkxoUUJCMDBseWFrdVJRQy9ISVpoSXlIdTc5Y1ls?=
 =?utf-8?B?TG11bFg0UTFjR1RrclZRMmFqQ0dDcEJtSngvZ3ROOUFMVHBOdHp0Q0xKU0hs?=
 =?utf-8?B?TFlFZmNtaVNSb2Z3ZzlMb0ZUYWV3RVY3UTNPaGNsWUUzUWd6R0xvYlZ2L2dL?=
 =?utf-8?B?aCs4SUxtYjFCK3JrVDFwdVkzOU1nM0d5bUhDUnNuMDMvZEZiTzEwcUNHczZX?=
 =?utf-8?B?NGsxRGEzTkx1MGpGek1Fd3drN3VBZzh3QVdJS3BoUnp3RFF0VVVFVkxNZk9x?=
 =?utf-8?B?OUgybmdVZHBzaVBBYnpYeVFUNUdvT1NvVUN0dnVQR3h4Z0FhWDl6Q2ZqaThN?=
 =?utf-8?B?VlByc2NNNHpkeUdTMEZ3NjZaYmFUbTNiZlNkZytVSXNMUTNnc3ZNNmR3N05V?=
 =?utf-8?B?eXNjVDJLNFFDSG9jOXlXaWtNMCs0QlB5VU5DcE05a1FFODlOaytjWWI1Y3gw?=
 =?utf-8?B?QnpGdDFqeVlESVJOT0R0V0N6dnhvOE51ZmVQVUZxZEVUSXhqQUFCQzVHM1I2?=
 =?utf-8?B?NWVjU0JOeitFdTVreXNiRkw2dGVvRGRSZFAvaUorbzJ6eG4yOStJUEE3TUlv?=
 =?utf-8?B?OUJOeG1MS21VL2hoUTJnWVFaWWhMQUFFNE9MSUp3ZWdpendZcEVUMXhrU3Mr?=
 =?utf-8?B?bEpCS2x6endGV0dmVkp1RTArd2VSVFNvY0lZV0JkS2UrZ2QvMU8yWEFKWHo3?=
 =?utf-8?B?cTZYZzFUdzdJdWFRaVgrR0taL3UwdHlJa1l2MjZCQ3NrM2xhRHRodGhQYTJo?=
 =?utf-8?B?RUUzZ1VOb3VzODR2OXFNckMxMjJHZnM1Q090bW5xSkMzcGNaVGRDV1V5UUNU?=
 =?utf-8?B?OHdSQ2J3UE56aVY4S3pBdUIwOG1EbzlrR0JQNUdyVmQ2TkFxcGgza2JZakc1?=
 =?utf-8?B?NWtIc1ViV0tRbUhkK0V0RExFSzdpSWd6VE9pZ3RONllUcDA3dlBUaC9hSEd2?=
 =?utf-8?B?TFVoRGorUmI1QTRBMUpXRGVHcEQ5U1BLYTBnYjN4aldSM2p4ZGZMaDIwYmxa?=
 =?utf-8?B?SjlFNmV3YjJleEI5TkprS0Z0bG1RbjJNcnBDMHhUWkxFK2lzYk9uOTRCdkNp?=
 =?utf-8?B?R0EwY0NFd3k2aFhKay9uMDZOb0tCeGhxbFhBZXlnOFFmVmM4WENQVVdMRHln?=
 =?utf-8?B?amtnV0g2Rmh1Y0NxUUVQZGx6YUh1eE5ZZWFzSFRWZSt3WnNDVkRJVm9mQllK?=
 =?utf-8?B?Y0JUSlh1N2hzUFhMRFZpazBHSHh2dmRiZzQ3RzBFSDgvekxZM2pONXc4QkRG?=
 =?utf-8?B?cGg0aGVuSkF3STNUTnZZSWIzTjhRbXVybVJTc2Vla243QVBHZnNXNlNvaVVL?=
 =?utf-8?B?bVQyazY1NW5FSE1kc3BFRUFNNHF4SXFyT2NYczZFZmxaSHY4bHFydnRtdVRQ?=
 =?utf-8?B?MU5DelpUc254RlpMSFVVTXdvWDlxWlRUVTRRaVJEczdKaFdOYjRDaWtnU2lS?=
 =?utf-8?B?QUpaYU1zcWdzb2NpcXJPRUQvZzQyZUdpeHl3T2F0V0dSckR3eFlHb29hYm85?=
 =?utf-8?B?dWJLdz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0VuQ3VZNVBkdmY3cDZNVjFUTk1Za1N0ZkcrbHU1Zm1aZWhWakhzM0Mvc3l0?=
 =?utf-8?B?ZWlnS0tCRjR1OXpwMlVmRHV3ZjhWQlVRdGt5V3dtaVFodXdJUXVYajlTeXlh?=
 =?utf-8?B?RHh0Y0VOem0rSUQrRmVCQ2o4UTFXWUpjN2JHUW1HdW1YT05CWkZPOXBIVUF5?=
 =?utf-8?B?MDg4VVUxcG1iV2pQN0RsV2tJSWlQZG9mK3NJM1p6NktFaHB6WmRsRlVaTTBl?=
 =?utf-8?B?YWNiM0RnV0U1ODZHcTg4SnNxZmh6bFhiU3RiTmEzK0t2OEgxaWtkVStHbnJR?=
 =?utf-8?B?QlBKemRjMkM4TGx0eTBPcEFyTjNnZFp2ZlJuTkJkM0JrWXdBMHBkMnVFRk5L?=
 =?utf-8?B?SFlaZkwvbUVmQjBKdkJUUms2QzNoQ0NHV1RYaGRTVlA1bzJZN1U1UEprTzdj?=
 =?utf-8?B?c0d3N1JZalpJRFY2QjEzdmFZbENwdnZ0QStkbGNSTDlZVzhONzNHK3FOYzBQ?=
 =?utf-8?B?UWJyRDdvVmlLeVBZeUdXYWhuQ0pjVUl2N1JQSXZLb3BEZVhQWmZxUHdEV1Nh?=
 =?utf-8?B?NmMzODVYVlNnVmpkbFJ2UlpjZXBQOFd1UjNrNVlrdVZQNklDbU1zOVZvdGhL?=
 =?utf-8?B?djQwbVJ0MU5keGlLN0FrNTk1SU1NSXlCcnUrYmJWK1Q3VmdGZ1R2M09rQmlj?=
 =?utf-8?B?WHY0S1cyZ2tkeU1rb2NQczZVYVdhMnJJZU5TUVVBZVg4MktTQ0dkWHJ5aUZm?=
 =?utf-8?B?N1h4K0VqdkowWHQrQlZ3QjJKMHVJejdIQk9JcGY3ckhyaE5PaVhockhJbHRW?=
 =?utf-8?B?TkZMVTIrWUZsWXpscDhwdlpnMm1DRFNITEhaNTNPdStMYzFMcTBoVm1xT1NZ?=
 =?utf-8?B?VS95V3JDRFp2alZKa1lJWXBqUE1PRzlDRHVkdzluU2FEY2dkb1dkaVU1Uzll?=
 =?utf-8?B?Ukk5VmRCV1JOa2hXNmo5c0cxZW5TUGZLM2EzcmhjblVDZ09qTlQwVGVxSWpo?=
 =?utf-8?B?K09VTnc0bEtkUWx4TmRvODV0RjVmY0l6MUR4bUFUNHdXQW9TblozVnJDVHVa?=
 =?utf-8?B?SlRYMkVoeHpUeVU1bGdJODNVQncvWUFKRUFIVlhIbW1XdnRwMWZBd1YvcU1s?=
 =?utf-8?B?Q3dhVEhrV0lJR2kyZFhvcEdjbmYraDYrYjZtZmhQNVpycVh2akx5bGZIb096?=
 =?utf-8?B?L0VPaGVZRkRZdzdFQjRzVC85Y0RPK0lRK1ZIWm5USENMdVptMjlIUUYrR0lz?=
 =?utf-8?B?MWZ6RC9xZXpxQisxSlhWMkc1VktVaVNMVU9LRFhIdVMrZGVDaWVUeDlKTDVB?=
 =?utf-8?B?WFV4K2dnVlE0MkxwUjNJZmYzQ2RKWDN5MW9YUEM0OGVUeDR1RDBZYmorQUpy?=
 =?utf-8?B?YmRMLy9tVjBLdXBsa1BIM2RWVWt5S1ZjdWV2cXpmd0l6VURDU0tDeWFVU2FW?=
 =?utf-8?B?S3Q4V21ucUJydTUreC9kR2xsSVk2QW5YVmp6VUczQUdCYmEwUkdvSFRPTXdt?=
 =?utf-8?B?dXJSQklIT1pobVFIbG01cFZadGNrWmI4QlhycWdPckR1Mnl0UGt2ZjNrMW9X?=
 =?utf-8?B?Z29QRytBVlY1VWZ0Y0xNd2J2dXh6c1pWUGpJZzRmQy91YnM4V05GMVIzRUVT?=
 =?utf-8?B?dzE4NmR6bG1CSDFZUkIrUGVKTEtRWDBYWndJN29abUpPdEFZWUNJUVRieVdK?=
 =?utf-8?Q?nQ7Dn8MuAepAEB3ZGqj/HNslwNWTdkRLqrrhRu7uVWgs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38491ba4-c019-40c5-2796-08dd585313b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 23:53:19.2012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7528

RnJvbTogUm9tYW4gS2lzZWwgPHJvbWFua0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBGcmlk
YXksIEZlYnJ1YXJ5IDI4LCAyMDI1IDI6NTUgUE0NCj4gDQo+IE9uIDIvMjgvMjAyNSAxMjo1NSBQ
TSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gRnJvbTogUm9tYW4gS2lzZWwgPHJvbWFua0Bs
aW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjcsIDIwMjUNCj4g
MzozMSBQTQ0KPiA+Pg0KPiA+PiBUaGUgbG9nIHN0YXRlbWVudCByZXBvcnRzIHRoZSBwYWNrZXQg
c3RhdHVzIGNvZGUgYXMgdGhlIGh5cGVyY2FsbA0KPiA+PiBzdGF0dXMgY29kZSB3aGljaCBjYXVz
ZXMgY29uZnVzaW9uIHdoZW4gZGVidWdnaW5nLg0KPiA+Pg0KPiA+PiBGaXggdGhlIG5hbWUgb2Yg
dGhlIGRhdHVtIGJlaW5nIGxvZ2dlZC4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogUm9tYW4g
S2lzZWwgPHJvbWFua0BsaW51eC5taWNyb3NvZnQuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBkcml2
ZXJzL3Njc2kvc3RvcnZzY19kcnYuYyB8IDIgKy0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvc2NzaS9zdG9ydnNjX2Rydi5jIGIvZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMNCj4gPj4g
aW5kZXggYTg2MTRlNTQ1NDRlLi5kN2VjNzk1MzZkOWEgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZl
cnMvc2NzaS9zdG9ydnNjX2Rydi5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvc2NzaS9zdG9ydnNjX2Ry
di5jDQo+ID4+IEBAIC0xMTgzLDcgKzExODMsNyBAQCBzdGF0aWMgdm9pZCBzdG9ydnNjX29uX2lv
X2NvbXBsZXRpb24oc3RydWN0IHN0b3J2c2NfZGV2aWNlICpzdG9yX2RldmljZSwNCj4gPj4gICAJ
CQlTVE9SVlNDX0xPR0dJTkdfV0FSTiA6IFNUT1JWU0NfTE9HR0lOR19FUlJPUjsNCj4gPj4NCj4g
Pj4gICAJCXN0b3J2c2NfbG9nX3JhdGVsaW1pdGVkKGRldmljZSwgbG9nbGV2ZWwsDQo+ID4+IC0J
CQkidGFnIyVkIGNtZCAweCV4IHN0YXR1czogc2NzaSAweCV4IHNyYiAweCV4IGh2IDB4JXhcbiIs
DQo+ID4+ICsJCQkidGFnIyVkIGNtZCAweCV4IHN0YXR1czogc2NzaSAweCV4IHNyYiAweCV4IHN0
cyAweCV4XG4iLA0KPiA+PiAgIAkJCXNjc2lfY21kX3RvX3JxKHJlcXVlc3QtPmNtZCktPnRhZywN
Cj4gPj4gICAJCQlzdG9yX3BrdC0+dm1fc3JiLmNkYlswXSwNCj4gPj4gICAJCQl2c3Rvcl9wYWNr
ZXQtPnZtX3NyYi5zY3NpX3N0YXR1cywNCj4gPg0KPiA+IEZXSVcsIEkgYWRkZWQgdGhhdCBsYXN0
IHN0YXR1cyB2YWx1ZSBsYWJlbGxlZCAiaHYiIGluIGNvbW1pdCAwOGY3NjU0N2YwOGQuIEFuZA0K
PiA+IHRvIGNvbmZpcm0gdGhlIGRpc2N1c3Npb24gb24gdGhlIG90aGVyIHRocmVhZCwgaXQncyBu
b3QgYSBoeXBlcmNhbGwgc3RhdHVzIC0tIGl0J3MgYQ0KPiA+IHN0YW5kYXJkIFdpbmRvd3MgTlQg
c3RhdHVzIHJldHVybmVkIGJ5IHRoZSBob3N0LXNpZGUgVk1CdXMgb3Igc3RvcnZzcCBjb2RlLg0K
PiA+IFRoZSAiaHYiIGlzIHNob3J0aGFuZCBmb3IgSHlwZXItViwgbm90IGh5cGVyY2FsbC4gUGVy
aGFwcyB0aGF0IHN0YXR1cyBpcw0KPiA+IGludGVycHJldGFibGUgaW4gYSBXaW5kb3dzIGd1ZXN0
LCBidXQgaXQncyBub3QgcmVhbGx5IGludGVycHJldGFibGUgaW4gYSBMaW51eA0KPiA+IGd1ZXN0
LiBUaGUgaGV4IHZhbHVlIHdvdWxkIGJlIHVzZWZ1bCBvbmx5IGluIHRoZSBjb250ZXh0IG9mIGEg
c3VwcG9ydCBjYXNlDQo+ID4gd2hlcmUgc29tZW9uZSBvbiB0aGUgaG9zdCBzaWRlIGNvdWxkIGJl
IGVuZ2FnZWQgdG8gaGVscCB3aXRoIHRoZQ0KPiA+IGludGVycHJldGF0aW9uLg0KPiA+DQo+ID4g
SSBoYXZlIG5vIHN0cm9uZyBvcGluaW9ucyBvbiB0aGUgbGFiZWwuIENoYW5naW5nIGl0IGZyb20g
Imh2IiB0byAic3RzIiBvcg0KPiA+IHRvICJob3N0IiB3b3JrcyBmb3IgbWUuDQo+IA0KPiBUaGFu
ayB5b3UsIE1pY2hhZWwsIGZvciBoZWxwaW5nIHVzIG91dCB3aXRoIHRoYXQhIEknbSBsZWFuaW5n
IHRvd2FyZHMNCj4gImhvc3QiIGFmdGVyIEVhc3dhcidzIHN1Z2dlc3Rpb24uIEFzIEkgdW5kZXJz
dGFuZCBmcm9tIHlvdXIgcmVwbHksDQo+IGl0J3MgZmFpciB0byBrZWVwIHRoZSB0YWcgYXMgeW91
J3JlIGZpbmUgd2l0aCB0aGUgImhvc3QiIG9wdGlvbi4NCg0KWWVzLCBteSBSZXZpZXdlZC1ieTog
aXMgZ29vZCB1c2luZyAiaG9zdCIuIEFsc28gcmVtZW1iZXIgdG8gZml4DQp0aGUgY29tbWl0IG1l
c3NhZ2UgdG8gbm90IGNhbGwgaXQgYSAiaHlwZXJjYWxsIHN0YXR1cyBjb2RlIiBzaW5jZQ0KaXQg
aXNuJ3QgZnJvbSBhIGh5cGVyY2FsbC4NCg0KTWljaGFlbA0KDQo+IA0KPiA+DQo+ID4gUmV2aWV3
ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCj4gDQo+IC0tDQo+
IFRoYW5rIHlvdSwNCj4gUm9tYW4NCg0K

