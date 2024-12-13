Return-Path: <linux-hyperv+bounces-3479-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7BD9F1781
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 21:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51684168BC3
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 20:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F67191F62;
	Fri, 13 Dec 2024 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="soKYE+Gz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2050.outbound.protection.outlook.com [40.92.23.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C78175AB;
	Fri, 13 Dec 2024 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122624; cv=fail; b=Gk+Hccq+GS6sTdIx7w0PHRplHl+gIEUD6rRJOYFxDncgJg9dFHkPxug8kDq3K/Q+PHGuidLowHBWE5Cj24Zz49xK+WGEfgUAhszJlTXOIMu8YsZ5qX/TUfeOgBHTa1GEK5CuQ3ruFRuP94tltW8rsQNxZ0R02LHXiTvErWNZFOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122624; c=relaxed/simple;
	bh=6kiRBdEuBQV2ffqf1xI5HQY4FXU/NqfgWrnLZSg1LEk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YNbHtMxJ2Jxp97ttPRYsr+nGdXjFZTKQfWWXAnwegRtBBs3ikHNvDF5CpWs1HS5nYL09s0pdhCLyHS9EspmGRCsjKQHFhLIiDIMw1VHM814LwkLKqra9zOi569LW7Uix1zBVifMGZISDYeyxUBrZ5q15kzDijAnUTJOdrhnzcMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=soKYE+Gz; arc=fail smtp.client-ip=40.92.23.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRUDaMfyL/icZVCTIYdLc7/XJRF7wu2giVeK1XhYP+v8/I63IPa0x38SvIG7XDwaY0PN6NhMPuUh/y8KvH7aMzFGPEbUIuxZT7EiVJ8Lm24pwwf57EbTyAQRuw2ZIosuMUksw/wkY/L2WIRde98BduClVQlO+p4NoqddzDfisDMVZDizA+E3AycBgxUZR3pK80J2wzVF0N//0KgwtGMiweBZr2oVvKoIN/dLtZslKh1X+E4hIiNX7/1rxS+xyQgVbbhUhWy1BTPMN+6oMTAo8aLQDpz9aJ9fsXb+pbMC2I09pnwBfAvJXZ4jtmTGXcAraw5CdungLxmvH4CYjfF6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kiRBdEuBQV2ffqf1xI5HQY4FXU/NqfgWrnLZSg1LEk=;
 b=UwbNr5kypWhYZv1y9NzBtVeyoVROiQA/KjsM2/3+1YDdeLaTs1LGQZnOxqwsxa+STBtSl2sC4tF2yVSSHAnBalefJhkeK8k9TdHZSeGXhWNHbl1GPi4yfx7ZN4QJt6YciK1B+TBuRWRA9YUzRXGOiXF2R14WQ50a4lARktMWCQco0yrerNu/tmrXaCkooJwd4tQgoqiN5Pg5xIQ8Vza8MsleR+KfITVdgJrZ03bEJ6UhJwRIUALU5fMo/6W5CQZeYQPnOh4lMHFplXFQK/I98KK2JKPIIzaJnd+RJOLN9aJ44g7k7qy9pYNfnWJsGGomuxMBCnf9GWBLGHb66eJGGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kiRBdEuBQV2ffqf1xI5HQY4FXU/NqfgWrnLZSg1LEk=;
 b=soKYE+GzPEe7PCkRnlsYW3pszigc8uVAEJHoJKuZSe98SmddDCSzZtf6RCNmgeWhFEGcP+Yuh2h/fmAdjRqne6GVVInjttj5x6TjF0kHH2NSRqNE9TLHquNIpDuVGZwFwZ4LSmDpU5BSCFpH4bs3gn1y5qCpueEs3Z2k54F4EjSeWxe1+8tPGmMgalBG+n+Mw9ohtbFEH2T1PeeCmnRShvCmpf8qLLdqPzvlAwzQOgXLs1kaJXaFjZdI9iaOFQBSvu3wQMT8+onJUqvtTLJY+HHxlSbJSrU6T07Uk79Gs7CeS5C2Jlx9MlvlUUB4lseMLJpPszEwwlk5IlaEuht6BQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8594.namprd02.prod.outlook.com (2603:10b6:a03:3fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 20:43:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 20:43:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH 1/1] Documentation: hyperv: Add overview of guest VM
 hibernation
Thread-Topic: [PATCH 1/1] Documentation: hyperv: Add overview of guest VM
 hibernation
Thread-Index: AQHbTOwE2iYUULdR/EuXGldydxxFyrLkhA2AgAAdZrA=
Date: Fri, 13 Dec 2024 20:43:40 +0000
Message-ID:
 <SN6PR02MB4157E5305FB26618AE5AEEC4D4382@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241212231700.6977-1-mhklinux@outlook.com>
 <130fb73d-110e-4aec-9491-371da9d0e338@linux.microsoft.com>
In-Reply-To: <130fb73d-110e-4aec-9491-371da9d0e338@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8594:EE_
x-ms-office365-filtering-correlation-id: d8b9d036-8a94-4b7b-d65e-08dd1bb6d3a2
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|8062599003|15080799006|19110799003|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?QXhxcEZ5RGxjNHhSRWlvNHFxTHE1cEE4MHh4UkttajRiV011dzZ2K0R1RW9O?=
 =?utf-8?B?bWwzdHZzZVB5aDMxeXg2b0NTUHp3Wi92SlV2bnNCbmtRTXhmbldQVHVuZmph?=
 =?utf-8?B?Y3l0cmZBVjAxNWZNWTJ1d3hIOGMzcE9aRFlmK2VXVWw1cEo5UStBY1d1S01v?=
 =?utf-8?B?MG1rZmdxNlZkWjFVL1ZBUUhnelFqcWVZUUhRUHJYRk1tRjVNWDFMMVpIbU1h?=
 =?utf-8?B?akVkQjdBTG1vMGJxUnpPdEtHd041MnF5WUdjaXpJYk14am5MN1ZadlZINnFG?=
 =?utf-8?B?SVUvdVFzZUc4a2FsYzViZVBkQWloMlVIbklyWjJIeVB6SlFwTzBaQTVwMVdQ?=
 =?utf-8?B?S0NpL0xMUUdUdE1kdWlnMnVnL2ZQQWhaVEN2eEFjclllUW9MTklWaFFSWkNZ?=
 =?utf-8?B?STNscFVMQUQ1V2JZczNjWVMzNWVicmJNYUE0Tm4wZXlHelZVZWJQQ05ydktt?=
 =?utf-8?B?R0tHakxzOXErZVZoblVRNjVKck1wYmRxaFF4MVh3bndXcWhaaU80VkZ6SkY2?=
 =?utf-8?B?Z2d2N01DK092YkZ5aU9mQVRtOXFLRmNuUzNmZDh6SWVxTVNtUWxVbTdtejgx?=
 =?utf-8?B?VExDRjA4dFRsQ3dEVHBVaVdDeUVyL0h0NW1SN0VQdU5rM2l6aFJ2MEZLR0I3?=
 =?utf-8?B?YTU4RkZDSk0rMUdwa3FVRFdnWDdnWElpVC8zNDhlekxlWmdEc0V5endKbmJu?=
 =?utf-8?B?ekRvbkF4S2p4aEFxNUFKWFpEdzdCcVREanVOUEtTS1VON0x2M0pIOGdhWTc5?=
 =?utf-8?B?cHp4dXhnK21RR3R3c0hmSnVnK2pyYXZCT1JPaWRLOUtLeU14ZE9wbXpXRUxG?=
 =?utf-8?B?Y0x2UjJ0WTl3Wm40bFVhYWo2WUN4OTNqQVEwVmZMbnVpR3BXalJHVlkweGxM?=
 =?utf-8?B?SVlGOWF2WVRFMU03M2hDZXQvNjFpLzdjbDkwQ3g1R1prbFdqQjk1c3VOM25J?=
 =?utf-8?B?aXVSQkNpUVlJSWVPVlBFcmQvSGwxZW5BUWZXYzlycjhJa3NlMkZCTzkya01Q?=
 =?utf-8?B?WVAyUk9wV3pLb2RmSW5Kbkl6dWhHYjFVcVFrU05mV2FlbmRNT0UxTFhCN3J0?=
 =?utf-8?B?aG5KSm1FSVdWTVlQYUhEWE1pb3R0QXVySjF5aklQQ2ZETkc1RVYzZENmbUpN?=
 =?utf-8?B?YnlSdW54MFN3a2JEb3I1elFOUUUvVmZrL2RjczJUMkVPaHJGZVM4QnYvVUhB?=
 =?utf-8?B?TllES3pUeDlyVklGck12ZGtmY1A1WCtmWXJYeFpHOFZwUTRFY29LbmY5MW9F?=
 =?utf-8?B?S1V1ckd1ekpkZmUxcGZHVTlHV0d5RTZ3cWtyTyt5aVAxRGdxSEtyRXE5Qklm?=
 =?utf-8?B?SUNhc2l0ZHNGY3RZdHBzTzlQTk9iMEhRN1prdXFpUHZnd2NzR20zZnRLTzhL?=
 =?utf-8?B?UFFoNVNyaEhoQlE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjhuL3licFVmd3Z6ZGJwNjRZSFV6bjZjZFc4ak0zSVMrNXcxdTA0bFhSZVRy?=
 =?utf-8?B?Q2piWHcyN3FVZXpjTlc5VTd2RG5qSDZ5R3U5V3AvY1Nnd050bTFNLzMyYXho?=
 =?utf-8?B?N3JBRnVMa2NXVDF6aUsvOUJ6Z2xGQnltSDlqLzI3YXdXM2h3emxCZmtPTHZE?=
 =?utf-8?B?T0p3OWJVZEQzbS90ZVBiRkUyend5U0xabzB4MHhvMUE0d2wrbjlOM2hQeEp0?=
 =?utf-8?B?K1lITUZTcm5uNHlza0tHd1lXeWZIVzlzUXl1c05nK2NqR1JHamtrbE4zMFhU?=
 =?utf-8?B?RUswZXYvZXh5ZkRpcWpCSEdqUTdZL2NKY3JXNkFkbzNDZUJQUnMyZHp4V0R3?=
 =?utf-8?B?VVZZOHdCaFpicnpHY3MrYnNNbnk3MmNRa0U0RnY1dEVUQlR6YTMraGNjV1d5?=
 =?utf-8?B?alY4WHdtMEZ6N3lPa2FsM21GVG9IK0R5dzN5NmFXd1l1RkF2NDZRM2dVZEw2?=
 =?utf-8?B?ZGdXVW1uUEZ5TVRuVTlEekNuVWEwVkIvYWxMYXkxZk1PcHVxUEVqWHdEN0pL?=
 =?utf-8?B?WVFZbjNhck1qcVZVb0pKOUVHaHhhZUNDWElrMG50SnZ6TysrWG56VjNxYllT?=
 =?utf-8?B?Ykl1VkZuSURtSzUvV0lCYmFyY09rdWl5MmhqdkU3Q0tIZnNJZ0kvWjV5VC9I?=
 =?utf-8?B?Sk9lbWREK0l2TTlwYmxQTXY2a0Z4WTFPUUtrTWY3M0R1aTdlR29tcDNlYXBL?=
 =?utf-8?B?VnRBSnQ4SXZGSVNPcFJDTHJRczh3T3FrTi9WaE5KMmdockQ0eDhMVDc2YU1r?=
 =?utf-8?B?Z245U3VXVVFvTUhBbjBYL0w5dEl1S0ZFS21DQkJEN25MNXdWdEpUaHdrK3JV?=
 =?utf-8?B?aGpmb1k2RzFBeFFFR2VNOTltQWtFcnU0bXZCbXd6Tzk2aC84aUYrdWpWWTJ6?=
 =?utf-8?B?elBnektiMDBZeWxkUU5pNnQ4dTlZbTJidjBTRWVjYUtMNXhGa3MzSG90MmFT?=
 =?utf-8?B?UjJSTDdPUjBUN2JHdy95Mmd2cVRtMDJNMFNVOVNrdUQxVE56YUhlMU1DYllK?=
 =?utf-8?B?cFB1Q1k5RTU0Sk9NQ2pRQjRRSWk5SEFyOS9KZngrT2R2KzNQczFSVjhvS0hx?=
 =?utf-8?B?cEtSaEVqcGdKclJoTE8xTUVKRE5BU3lWbi9MVGlocEUvV29CeUJRUDlQQk5G?=
 =?utf-8?B?NU9XZVhaYXB4SzVocExHQ0hac3ZkMFdhZFVuV1RxVUFLaTgvbzg1NFdGSWJI?=
 =?utf-8?B?UUo3MDM0SzNvQ3l5bWE0c080SGZMRkdwQnJLT3BHSERlQmk0Ui9VVUNMcFdk?=
 =?utf-8?B?T3I0VE03OVhlRDk4eWxQZ1VvNmlSWHZlRW9WaTlmZjY3NnlrZTRWaFFoYjc5?=
 =?utf-8?B?a2t3T0Y2MlQxclNUdW1qMGtEK0hybmcyclhyS3k3bWJISHdiUmFjamkrSEpS?=
 =?utf-8?B?bXpFRk1rK2ZaOURxODNwOEh6S2w1aVpWRTl2MW5FT2l3YzFIWVBFdi8xOGo1?=
 =?utf-8?B?bEtYcHZlN3owL25raVR3RVExWG1wcVJLK0todGx2cFBpelV2S2VocFdmOUpB?=
 =?utf-8?B?TnFZQzMxQnNTYlBwRG92dGd1SVlnS21UMVhTS091L3hUNjJ3aWNRc1hHY2pV?=
 =?utf-8?B?cUdqL1F5ejJsNzJjSnlrYVdBOVhZMURNOVA1RTUvZDFMVkhWUjlsTUJUeEFx?=
 =?utf-8?Q?Q6utOZKHk40HCoQ6qp9BSLlxgP98TUidh6gy+7MwyQTI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b9d036-8a94-4b7b-d65e-08dd1bb6d3a2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 20:43:40.5046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8594

RnJvbTogUm9tYW4gS2lzZWwgPHJvbWFua0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBGcmlk
YXksIERlY2VtYmVyIDEzLCAyMDI0IDEwOjQ0IEFNDQo+IA0KPiBPbiAxMi8xMi8yMDI0IDM6MTcg
UE0sIG1oa2VsbGV5NThAZ21haWwuY29tIHdyb3RlOg0KPiA+IEZyb206IE1pY2hhZWwgS2VsbGV5
IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCj4gPg0KPiA+IEFkZCBkb2N1bWVudGF0aW9uIG9uIGhv
dyBoaWJlcm5hdGlvbiB3b3JrcyBpbiBhIGd1ZXN0IFZNIG9uIEh5cGVyLVYuDQo+ID4gRGVzY3Jp
YmUgaG93IFZNQnVzIGRldmljZXMgYW5kIHRoZSBWTUJ1cyBpdHNlbGYgYXJlIGhpYmVybmF0ZWQg
YW5kDQo+ID4gcmVzdW1lZCwgYWxvbmcgd2l0aCB2YXJpb3VzIGxpbWl0YXRpb25zLg0KPiA+DQoN
CltzbmlwXQ0KIA0KPiA+ICtDb25zaWRlcmF0aW9ucyBmb3IgR3Vlc3QgVk0gSGliZXJuYXRpb24N
Cj4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gK0xpbnV4
IGd1ZXN0cyBvbiBIeXBlci1WIGNhbiBhbHNvIGJlIGhpYmVybmF0ZWQsIGluIHdoaWNoIGNhc2Ug
dGhlDQo+ID4gK2hhcmR3YXJlIGlzIHRoZSB2aXJ0dWFsIGhhcmR3YXJlIHByb3ZpZGVkIGJ5IEh5
cGVyLVYgdG8gdGhlIGd1ZXN0IFZNLg0KPiA+ICtPbmx5IHRoZSB0YXJnZXRlZCBndWVzdCBWTSBp
cyBoaWJlcm5hdGVkLCB3aGlsZSBvdGhlciBndWVzdCBWTXMgYW5kDQo+ID4gK3RoZSB1bmRlcmx5
aW5nIEh5cGVyLVYgaG9zdCBjb250aW51ZSB0byBydW4gbm9ybWFsbHkuIFdoaWxlIHRoZQ0KPiA+
ICt1bmRlcmx5aW5nIFdpbmRvd3MgSHlwZXItViBhbmQgcGh5c2ljYWwgaGFyZHdhcmUgb24gd2hp
Y2ggaXQgaXMNCj4gPiArcnVubmluZyBtaWdodCBhbHNvIGJlIGhpYmVybmF0ZWQgdXNpbmcgaGli
ZXJuYXRpb24gZnVuY3Rpb25hbGl0eSBpbg0KPiA+ICt0aGUgV2luZG93cyBob3N0LCBob3N0IGhp
YmVybmF0aW9uIGFuZCBpdHMgaW1wYWN0IG9uIGd1ZXN0IFZNcyBpcyBub3QNCj4gPiAraW4gc2Nv
cGUgZm9yIHRoaXMgZG9jdW1lbnRhdGlvbi4NCj4gPiArDQo+ID4gK1Jlc3VtaW5nIGEgaGliZXJu
YXRlZCBndWVzdCBWTSBjYW4gYmUgbW9yZSBjaGFsbGVuZ2luZyB0aGFuIHdpdGgNCj4gPiArcGh5
c2ljYWwgaGFyZHdhcmUgYmVjYXVzZSBWTXMgbWFrZSBpdCB2ZXJ5IGVhc3kgdG8gY2hhbmdlIHRo
ZSBoYXJkd2FyZQ0KPiA+ICtjb25maWd1cmF0aW9uIGJldHdlZW4gdGhlIGhpYmVybmF0aW9uIGFu
ZCByZXN1bWUuIEV2ZW4gd2hlbiB0aGUgcmVzdW1lDQo+ID4gK2lzIGRvbmUgb24gdGhlIHNhbWUg
Vk0gdGhhdCBoaWJlcm5hdGVkLCB0aGUgbWVtb3J5IHNpemUgbWlnaHQgYmUNCj4gPiArY2hhbmdl
ZCwgb3IgdmlydHVhbCBOSUNzIG9yIFNDU0kgY29udHJvbGxlcnMgbWlnaHQgYmUgYWRkZWQgb3IN
Cj4gPiArcmVtb3ZlZC4gVmlydHVhbCBQQ0kgZGV2aWNlcyBhc3NpZ25lZCB0byB0aGUgVk0gbWln
aHQgYmUgYWRkZWQgb3INCj4gPiArcmVtb3ZlZC4gTW9zdCBzdWNoIGNoYW5nZXMgY2F1c2UgdGhl
IHJlc3VtZSBzdGVwcyB0byBmYWlsLCB0aG91Z2gNCj4gPiArYWRkaW5nIGEgbmV3IHZpcnR1YWwg
TklDLCBTQ1NJIGNvbnRyb2xsZXIsIG9yIHZQQ0kgZGV2aWNlIHNob3VsZCB3b3JrLg0KPiA+ICsN
Cj4gDQo+IFdvdWxkIGl0IGJlIHVzZWZ1bCBtZW50aW9uaW5nIHRoZSAobGlrZWx5IGxldGhhbCBm
b3IgdGhlIFZNKSByaXNrDQo+IG9mIGNvcHlpbmcgdGhlIGhpYmVybmF0ZWQgVk0gdG8gYW5vdGhl
ciBob3N0IChvZiB0aGUgc2FtZSBhcmNoKSB0aGF0IGhhcw0KPiBhbm90aGVyIHNldCBvZiBDUFVJ
RCBiaXRzL2ZlYXR1cmVzPw0KDQpZZXMsIHRoYXQncyBhIGdvb2QgcG9pbnQgdGhhdCBpcyBzcGVj
aWZpYyB0byBWTXMuIEknbGwgYWRkIGl0IHRvIHRoZQ0KZG9jdW1lbnRhdGlvbi4NCg0KW3NuaXBd
DQoNCj4gDQo+IEFwcHJlY2lhdGVkIGRvY3VtZW50aW5nIGFsbCB0aGUgaW50cmljYWNpZXMgb2Yg
dGhlIGhpYmVybmF0aW9uIGFuZA0KPiByZXN1bWUgcGF0aHMgZm9yIHZhcmlvdXMgZGV2aWNlcywg
YW4gaW5jcmVkaWJsZSByZWFkISBBcmUgdGhlcmUNCj4gYW55IHNwZWNpYWwgY29uc2lkZXJhdGlv
bnMga25vd24gdG8geW91IGZvciB0aGUgaGliZXJuYXRpb24gb2YNCj4gdGhlIGRldmljZXMgZHJp
dmVuIHRocm91Z2ggdGhlIEh5cGVyLVYgVUlPPw0KPiANCg0KVGhlIFVJTyBkcml2ZXIgZm9yIFZN
QnVzIGRldmljZXMgKHVpb19odl9nZW5lcmljLmMpIGRvZXMgbm90IGhhdmUNCnN1cHBvcnQgZm9y
IGhpYmVybmF0aW9uIC0tIGl0IGRvZXMgbm90IGhhdmUgInN1c3BlbmQiIGFuZCAicmVzdW1lIg0K
ZnVuY3Rpb25zIGltcGxlbWVudGVkIGxpa2UgdGhlIG90aGVyIFZNQnVzIGRldmljZSBkcml2ZXJz
Lg0KQ29uc2VxdWVudGx5LCB2bWJ1c19zdXNwZW5kKCkgcmV0dXJucyBhbiBFT1BOT1RTVVBQIGVy
cm9yICgtOTUpDQp3aGVuIExpbnV4IGdvZXMgdGhyb3VnaCB0aGUgaGliZXJuYXRpb24gc2VxdWVu
Y2UuIFRoZSBlcnJvciBjYXVzZXMNCnRoZSBzZXF1ZW5jZSB0byBhYm9ydCwgYW5kIHRoZSBWTSBp
cyBub3QgaGliZXJuYXRlZC4NCg0KRldJVywgaGVyZSdzIGV4YW1wbGUgb3V0cHV0Og0KDQpbODY5
NDUuMzM1MjkzXSBQTTogaGliZXJuYXRpb246IGhpYmVybmF0aW9uIGVudHJ5DQpbODY5NDUuMzQ0
NDAzXSBGaWxlc3lzdGVtcyBzeW5jOiAwLjAwOCBzZWNvbmRzDQpbODY5NDUuMzQ0ODUzXSBGcmVl
emluZyB1c2VyIHNwYWNlIHByb2Nlc3Nlcw0KWzg2OTQ1LjM0NjMzMV0gRnJlZXppbmcgdXNlciBz
cGFjZSBwcm9jZXNzZXMgY29tcGxldGVkIChlbGFwc2VkIDAuMDAxIHNlY29uZHMpDQpbODY5NDUu
MzQ2MzQwXSBPT00ga2lsbGVyIGRpc2FibGVkLg0KWzg2OTQ1LjM0NjQxMF0gUE06IGhpYmVybmF0
aW9uOiBNYXJraW5nIG5vc2F2ZSBwYWdlczogW21lbSAweDAwMDAwMDAwLTB4MDAwMDBmZmZdDQpb
ODY5NDUuMzQ2NDEyXSBQTTogaGliZXJuYXRpb246IE1hcmtpbmcgbm9zYXZlIHBhZ2VzOiBbbWVt
IDB4MDAwYTAwMDAtMHgwMDBmZmZmZl0NCls4Njk0NS4zNDY0MTNdIFBNOiBoaWJlcm5hdGlvbjog
TWFya2luZyBub3NhdmUgcGFnZXM6IFttZW0gMHhlZTliNDAwMC0weGVlOWJhZmZmXQ0KWzg2OTQ1
LjM0NjQxNF0gUE06IGhpYmVybmF0aW9uOiBNYXJraW5nIG5vc2F2ZSBwYWdlczogW21lbSAweGVm
ZjQxMDAwLTB4ZWZmYzRmZmZdDQpbODY5NDUuMzQ2NDE1XSBQTTogaGliZXJuYXRpb246IE1hcmtp
bmcgbm9zYXZlIHBhZ2VzOiBbbWVtIDB4ZWZmZDMwMDAtMHhlZmZmZWZmZl0NCls4Njk0NS4zNDY0
MTZdIFBNOiBoaWJlcm5hdGlvbjogTWFya2luZyBub3NhdmUgcGFnZXM6IFttZW0gMHhmMDAwMDAw
MC0weGZmZmZmZmZmXQ0KWzg2OTQ1LjM0NjY0OV0gUE06IGhpYmVybmF0aW9uOiBCYXNpYyBtZW1v
cnkgYml0bWFwcyBjcmVhdGVkDQpbODY5NDUuMzQ2NjU5XSBQTTogaGliZXJuYXRpb246IFByZWFs
bG9jYXRpbmcgaW1hZ2UgbWVtb3J5DQpbODY5NDYuMTczMDg4XSBQTTogaGliZXJuYXRpb246IEFs
bG9jYXRlZCA2MTExNjIgcGFnZXMgZm9yIHNuYXBzaG90DQpbODY5NDYuMTczMTA1XSBQTTogaGli
ZXJuYXRpb246IEFsbG9jYXRlZCAyNDQ0NjQ4IGtieXRlcyBpbiAwLjgyIHNlY29uZHMgKDI5ODEu
MjcgTUIvcykNCls4Njk0Ni4xNzMxMTRdIEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFz
a3MNCls4Njk0Ni4xNzQ0NzJdIEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MgY29t
cGxldGVkIChlbGFwc2VkIDAuMDAxIHNlY29uZHMpDQpbODY5NDYuMTc0NTY4XSBwcmludGs6IFN1
c3BlbmRpbmcgY29uc29sZShzKSAodXNlIG5vX2NvbnNvbGVfc3VzcGVuZCB0byBkZWJ1ZykNCls4
Njk0Ni4yMDU5NjVdIHVpb19odl9nZW5lcmljIDFmZTNmM2VlLTc2ZWQtNGJmZS04NzFmLTk4NGQx
NTYzYzdhMjogUE06IGRwbV9ydW5fY2FsbGJhY2soKTogdm1idXNfc3VzcGVuZCBbaHZfdm1idXNd
IHJldHVybnMgLTk1DQpbODY5NDYuMjA1OTg5XSB1aW9faHZfZ2VuZXJpYyAxZmUzZjNlZS03NmVk
LTRiZmUtODcxZi05ODRkMTU2M2M3YTI6IFBNOiBmYWlsZWQgdG8gZnJlZXplIG5vaXJxOiBlcnJv
ciAtOTUNCls4Njk0Ni4yMDY4MTJdIFBNOiBoaWJlcm5hdGlvbjogU29tZSBkZXZpY2VzIGZhaWxl
ZCB0byBwb3dlciBkb3duLCBhYm9ydGluZw0KWzg2OTQ2LjI0NjcwMF0gUE06IGhpYmVybmF0aW9u
OiBCYXNpYyBtZW1vcnkgYml0bWFwcyBmcmVlZA0KWzg2OTQ2LjI0Nzc1OV0gT09NIGtpbGxlciBl
bmFibGVkLg0KWzg2OTQ2LjI0Nzc2Nl0gUmVzdGFydGluZyB0YXNrcyAuLi4gZG9uZS4NCls4Njk0
Ni4yNDk0MTVdIFBNOiBoaWJlcm5hdGlvbjogaGliZXJuYXRpb24gZXhpdA0KDQpJJ2xsIGFkZCB0
aGlzIGxpbWl0YXRpb24gdG8gdGhlIGRvY3VtZW50YXRpb24gYXMgd2VsbC4gR2l2ZW4gdGhlIHBs
YW5zDQp0byB1c2UgdGhlIFVJTyBkcml2ZXIgZm9yIGEgYnJvYWRlciBzZXQgb2Ygc3BlY2lhbHR5
IFZNQnVzIGRldmljZXMsDQp0aGlzIGlzIGEgbGltaXRhdGlvbiB0aGF0IGxpa2VseSBuZWVkcyB0
byBiZSByZW1lZGllZC4NCg0KVGhhbmtzIGZvciB0aGUgaW5wdXQhICBUaGVzZSBhcmUgdXNlZnVs
IHBvaW50cyB0aGF0IEkgaGFkIG5vdA0KY29uc2lkZXJlZC4NCg0KTWljaGFlbA0K

