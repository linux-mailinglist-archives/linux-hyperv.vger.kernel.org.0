Return-Path: <linux-hyperv+bounces-7095-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA511BBCFF5
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Oct 2025 05:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52F34347612
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Oct 2025 03:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ED919E83C;
	Mon,  6 Oct 2025 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="u8w3IVaL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012017.outbound.protection.outlook.com [52.103.11.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECECFDDA9;
	Mon,  6 Oct 2025 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759720091; cv=fail; b=PCZzRXV71//Bv1OSaBoUpTRbPF85glqaNHWRuIt54ayYQOXy47QufDbSOHuCvUp24M33adU9sBKP99T8wuO5fFPc5VOrCcNYQX5RbflYqI7TPRBcXWFr+idUTXdJCmzE7sxKyr8FAyYYSAnSstB5KOPiykRXGVHpfhd1aKM7MoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759720091; c=relaxed/simple;
	bh=zslJw4hl5idwCYdzxhCAwobphJ5fFuZOeNOn0Cno/eQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LQKSynZNhImx7u79DQ5j646sEvcvOp1mEUFWNoE2azji9tPr+RyGCIgKDVYcop3clU78p93DwFxJKoMjGV3jvwtHwJJD7tXQN+NhMyeqnsrpxs5IiH0GTCEx1V+Akyw0hRZRpuxFbc+fPQDY2B7GWAt0Fy5XZUmGWLr22O8kxLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=u8w3IVaL; arc=fail smtp.client-ip=52.103.11.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfwROFeDH8sf9HfVti6k6QYhnYjHBNei7cORfxKdfiWsVwjnlWm9yEfxp5Ay9XAecTGOv24E2sv1PAbC+raT5V+irk9/H42mGLwE0k+kULqUJJNFeW7YrhAcx2rKeayrnkAWoOxnGD/Yzx0KH+8Xt7sd4+wpVM885IVu2L1wpyKD9CyOKuwPsowxDNFg43PFANHRjCA0l4Q2tdEGGJZMdlYgLqan33nub3rgoGfNk10vZ+8Yjt6PLwiktRSq1V8APBGJqtxFY4WGdPcbwI9WPK7XCb+QxCMbG5rOZHjxupeSWoRlqm+uV38/DCwTAFNXPFnYO6tLqkq8MofMrre7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zslJw4hl5idwCYdzxhCAwobphJ5fFuZOeNOn0Cno/eQ=;
 b=FyjxxiZ/yeZYzDVK+7dy6vvj6v42a9ErhQFt54xn6adT4DtH/M/gjgSUunLO9ElsU/R3z3B4OdN1/++XTtavtX+m80+Xwu/eAdrflOcLiKivVeRUgudv9tmM5sfq43k3z+hpKJZpxXm7nu/a3Ttp+2hd16huMnkOyDEBxbdpnope+5ElRIZ/0eA4+ZFqqfioUVZQY10NN7aA0Tqx66wWqOEwuXQq9DpB7g5YqBCBCI9zfN4dCZ5qqHmf6W4gXhwwO67zVzgghiSqJcjzvQ9E2WLzr9cxv6VCCx3BXdIj5W7vGkynud2WdxPN77OFHvoRJF9NEgGSbalZFyRwR4/jDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zslJw4hl5idwCYdzxhCAwobphJ5fFuZOeNOn0Cno/eQ=;
 b=u8w3IVaL8Q2LG6VUCobXmYLvXjr2+VzNMRgeWRjEVd2QmJzPQs4MZ4wtQGZMNwQ/6HHTjOD5cVnKKdV6a6a6wkBVoa+BJLC7PZrxnb7d4mxMlfUlT8qQUY8dVYEhNruUE7K2Od+WVIQVHD4PKe09YCFNKblOD2HT60uN2Cjvbmplju7CsJDlLojV5YNr0OaG6i1/SfOUD01vh10yKtEqpv0/NqacUNTxe6TBhLDwk0169DFwJwXGwMor7H9PZ4x4af8LDNzIrKMoM3lc7Csppwm6y2Xoz+4oOuhy3dSo70MMwTz9m9O60Dn6KnaCG7ne+IoXaFKTLzyHt8LGr6Li3g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9250.namprd02.prod.outlook.com (2603:10b6:930:9d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 03:08:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 03:08:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/5] Drivers: hv: Refactor and rename memory region
 handling functions
Thread-Topic: [PATCH v3 1/5] Drivers: hv: Refactor and rename memory region
 handling functions
Thread-Index: AQHcM7qrn1eh6YSTl0+3a/JQ9MSRPrS0dHVw
Date: Mon, 6 Oct 2025 03:08:02 +0000
Message-ID:
 <SN6PR02MB4157D88089F3221A853B1C67D4E3A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <175942263069.128138.16103948906881178993.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175942295032.128138.5037691911773684559.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <175942295032.128138.5037691911773684559.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9250:EE_
x-ms-office365-filtering-correlation-id: 119a01b2-f3d8-48b5-603e-08de0485900e
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|461199028|31061999003|15080799012|8060799015|8062599012|41001999006|19110799012|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFFqUExrdER0WEVJRHVqMVE1TWRTVjk3cGQ5c3llaUZHV3FkazQxQ2tGSTli?=
 =?utf-8?B?dFJpQjlCZFhxWWR2emdFY2NMOWNSY01iODZDSHd4cEdCL3NBMWFRK1VURkhV?=
 =?utf-8?B?eFVSdHo0YTFCbWdWYUh2akVmbmh3MDNzWkt4MFIrOTRpeGFvUktpTzFBYkhT?=
 =?utf-8?B?NnJVR3hqdG5seXRneUdzUk92Rzl3Zk1mcjRyYVJRamVNSkZWZUJUQkxWazBX?=
 =?utf-8?B?WGJuVE1VYThFeFVseStVbVJhZzFMTjg0UTRkTzlELzBNWEZIK1hkaHVJNmE1?=
 =?utf-8?B?OVNRMG93VS9sOW9TelVnMkVpaFJ1YjlPWU1QYmxEVk5aUGNITUMvNVF4YmtH?=
 =?utf-8?B?cTAwa3RCZ1RKYTNyRWVFVExRSG9VaksyTFNRVkVMZkQrM3VxRkowbWdNcGVr?=
 =?utf-8?B?dGdEMzFiZVc5YWg2cmRFWTd5QmUrb1ZxM3EzQkpsaHlCaHNCTjBpWmZmKzVr?=
 =?utf-8?B?R3EvQUlHbzZJZGE3NmU0b3ZGcHBoZE43TkNWN01MVVNVT0REZkFqSmxYdk5R?=
 =?utf-8?B?Qk84WHhJQUtJL2hpQmRBMXp6TWMrdUFrQ000VTFlR3NYL21jYyszRUptVGJv?=
 =?utf-8?B?UkhnWjNjUlJtZVR0ZHpXT0F0cG1rNHVjemJMQUxZcGxFZC9vcVVyL2xhNW1O?=
 =?utf-8?B?RWFFWUxuRk5zN3VldmZvOGVQd3pRSWtSRFhDWm54NDRtNGRnbFJiWVlSN1Vs?=
 =?utf-8?B?d0ZuQUtyUTQ0dmFhUEkySGdJNURPTEFQUHIyeFBMZXBDOWwwQnNGVUw0ZDN1?=
 =?utf-8?B?VFgrVVBSWkJVWExib1drQW1GbCtjeUtEVEJBUklGQSt5WU51TDVyb2F4NHRT?=
 =?utf-8?B?NHFVaGFkWHV6YlNFQVhDV2ZIUGs5L3hwTnl1d2VLcnI2VUc5anB5Q3JEc2Vv?=
 =?utf-8?B?VWFoVnY4MU9BUWFObWtyR3U5OEdLaWg5aDF3d3QxVlVla0pqWGtPMnVnRWF3?=
 =?utf-8?B?Qkh0cm5YTFowR1dHQTFUY1lGTkFwL1cweEpTK2pwQkVoMkhaL2JBTHhabTQw?=
 =?utf-8?B?QWRkajgrMTRQZHBHZWJ0YW1wSnBiVGtmdDY1QkJ5QWpVYVllTjR6dlFiMmxi?=
 =?utf-8?B?bS9SOEtYMDd4cDBMUXBOSm9GSTArV0N5cGd2WnRBYjdiSVpmWFl0RXdueUZT?=
 =?utf-8?B?Tm93V0lxVnMyQzlHUUliZ1kzTE10S1UyUDRrbjVmckV2M1F6Q3NNWnhVN0hV?=
 =?utf-8?B?eThqRm8vUXNVR1NSZWxqcEN5eUVOZGMwODVuYVNVZUdPM1plVGJwcHEzZGFB?=
 =?utf-8?B?QkVyNzZsUHBvWGpQYVU4WGFWbi9hN0VUdjhxMlJUVEp1YS9WdVU1bzc5YkhT?=
 =?utf-8?B?N3RQYUM0Qi9FS1gwUysvSjNxS0haWFhiV25hVURtNHRKZVErOUFxVkVzbC9i?=
 =?utf-8?B?TmlicFgwRTFjK3E5Q3MySzhKR25vc2JSc29sUVFnYW9tUkxIYzBlTnRFUStm?=
 =?utf-8?B?WThhazUrTDZnc0pVd0FnVFUxeHpuQW5UbXhSZWRIV2w3dnVQc2txempuL2JM?=
 =?utf-8?B?NEtWTS93L3R2bURtQ3hlYXhpRUI0QmN3N3dwQnlUblBHd1A2dXFUcHA3dk5W?=
 =?utf-8?B?d2hPTmJ4VzBiZDQrNFVSdUxjOEIxSEs3WDR4cDl5cWY3UU92RnBxdGF6dEtF?=
 =?utf-8?B?aEliS0w3NVYwN3JMNUZZejNxa20wL3c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHRsM3pyTzI3VVlBU0lzdTJ3ZmVKbDZqUGVUWU5KOG1kNVA0a3IxNWFhWXM1?=
 =?utf-8?B?ekE2aHh0MFlEaXhHWjBSbHNGN2JIZG56aTJKMExrcGcwUEVKcGdpNWlVQnJW?=
 =?utf-8?B?elJlRlRKR0lmTkJBcS9lbE9xcW56ZmlqRXIzeHBBUHN5d2lxRnJ6ckMyNEFx?=
 =?utf-8?B?K0o2ZER6ZFNBZUM3RXQwL01MNVkvdDlXbVRUK3dRMVNQM0Fzd2hCL2NMbkE2?=
 =?utf-8?B?TDdJTTRDNEw1dXh6UGU1U1BlNnpzNm1EYjRJWThMMXpvbjloMW1QN2NQYmtB?=
 =?utf-8?B?V3hwMkx5cDZkNDdqb2ZFSVpWb1FHL24yT0xvbTFtQWx4TmVXK3hHS2U2c3FB?=
 =?utf-8?B?S2NMVUx6WlVQUEJGVFdXWHQ4Sm9RVEFPcGxQYnkzSFVmVVRmTTFkei9JSVU1?=
 =?utf-8?B?bURHQ2lOVFhhMGk1QnQ1ZGdwVUFQNVhTeEtOM2xEUWFIWG9yN09zUzlPWVlG?=
 =?utf-8?B?MHROb1VReFFtUFBxMHhISHRpcG1rTUFlT0lOMU9rUGp2b2lKM2RadDM4TGts?=
 =?utf-8?B?Q0ZUend4MUltNVdOTm5ab1phZlEySlpPeTdjZS9adEU0VWlacXN5ZkRpZGNV?=
 =?utf-8?B?QmJPeTBDZUswWlozQXBzekJhbWJQMmdHNnFKOGUzeVIrSzMwZmxEUXBidk83?=
 =?utf-8?B?S2p1ZWZHTlIrdURvK2NlMnBFM1hrTzFqaEduMjA3OWJyb0pxSmlTVDJicEZD?=
 =?utf-8?B?bEdic2ZqTWRPZmRBWnZkdzd5NWlCc3BrSGcvZHZpNXVkQjcrTnpvdkNkQUtB?=
 =?utf-8?B?YUIyWXI1Z1RBejkzR3ZPSWFKOThqTHF2L0JWVDB6cVN1TklIZkkrenJMSHQw?=
 =?utf-8?B?TkhFYWNNTEI2TjQ2RE9KTENMT3hIU2FlQllOREtzZ2hRVy9rWTNEdlFIRDQ4?=
 =?utf-8?B?QmZ4YVRmdHNSdnJpSkpHSmJCTmx4Q2pOVWpxc3RaUnliUTdaRGc0bGJsemFp?=
 =?utf-8?B?WmF5NnVFOTdteFdUajNvWTl2RmVWLzNYbjJNcjNhT29icFcxRTJZem5aSCtv?=
 =?utf-8?B?cm00S1ZucDhZUDc2VkR2cmYwaS9QbEdZRVNUTERYV3J5a3Vhejc4UTJrYXBQ?=
 =?utf-8?B?V3BPRTJHRVFFSXVsb3JrU0l6MDNXTzhlR01HMnpER0VKZTVqMzRycE1seHFt?=
 =?utf-8?B?azlSSVJqaE4vSTRvdGhSV1puSXBjYTNvRHUwUkhVQVNxazZEc3c3RzNONnUr?=
 =?utf-8?B?aXd5WWpxd1dCbE1hR21ENDhuYmNHeEhXZjlhQWJEVndENmVUZW1DZWQwR2FS?=
 =?utf-8?B?ZDBGQVoydmk3RDNrTzVyYlBEdU1uUGdIVnlCZGU1TlZOeHFYeUl1ZjNIdnN4?=
 =?utf-8?B?cStMeGkvVVJTZllvdlkwNVFKWlpITXprNytJajR5WVR0Ri9US2dkSWJJdGNL?=
 =?utf-8?B?eTl5ZmswYlJKdm5rTFFPOXVldlVHRitMcDdvUlV6YVZFYVVYQnV1Y3AzQi9Z?=
 =?utf-8?B?MlROYWl6eTFydWRPeEZPemgwYnFaU3E2WWlqZXBlaDlNZisvOG5nbGxTYmxQ?=
 =?utf-8?B?c0hHMVBmRWtUZzZpUS9yMDJubEJncWhGTWVQaUhOR2xEaGp6N0RIUCt4Rjlp?=
 =?utf-8?B?UWNUZDB0eE1YTEJoL2FTM1NieVNzWkR2LzZSZ2Q4dEV4aUdtVWQwVkFXejR2?=
 =?utf-8?Q?HJtmSEexLpqaO9JlgkQ54WScdkIHBw7rHC6z+jEdskmw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 119a01b2-f3d8-48b5-603e-08de0485900e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 03:08:02.6997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9250

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMiwgMjAyNSA5OjM2IEFNDQo+IA0KPiBTaW1w
bGlmeSBhbmQgdW5pZnkgbWVtb3J5IHJlZ2lvbiBtYW5hZ2VtZW50IHRvIGltcHJvdmUgY29kZSBj
bGFyaXR5IGFuZA0KPiByZWxpYWJpbGl0eS4gQ29uc29saWRhdGUgcGlubmluZyBhbmQgaW52YWxp
ZGF0aW9uIGxvZ2ljLCBhZG9wdCBjb25zaXN0ZW50DQo+IG5hbWluZywgYW5kIHJlbW92ZSByZWR1
bmRhbnQgY2hlY2tzIHRvIHJlZHVjZSBjb21wbGV4aXR5Lg0KPiANCj4gRW5oYW5jZSBkb2N1bWVu
dGF0aW9uIGFuZCB1cGRhdGUgY2FsbCBzaXRlcyBmb3IgbWFpbnRhaW5hYmlsaXR5Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgu
bWljcm9zb2Z0LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2h2L21zaHZfcm9vdF9tYWluLmMgfCAg
IDc4ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCA0MyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2h2L21zaHZfcm9vdF9tYWluLmMgYi9kcml2ZXJzL2h2L21zaHZfcm9v
dF9tYWluLmMNCj4gaW5kZXggZmE0MmM0MGUxZTAyZi4uMjlkMGMyYzlhZTRjOCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9odi9tc2h2X3Jvb3RfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvaHYvbXNo
dl9yb290X21haW4uYw0KDQpbc25pcF0NCg0KPiBAQCAtMTI2NCwxNyArMTI0OCwyNSBAQCBzdGF0
aWMgaW50IG1zaHZfcGFydGl0aW9uX2NyZWF0ZV9yZWdpb24oc3RydWN0IG1zaHZfcGFydGl0aW9u
ICpwYXJ0aXRpb24sDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiAtLyoNCj4gLSAqIE1hcCBn
dWVzdCByYW0uIGlmIHNucCwgbWFrZSBzdXJlIHRvIHJlbGVhc2UgdGhhdCBmcm9tIHRoZSBob3N0
IGZpcnN0DQo+IC0gKiBTaWRlIEVmZmVjdHM6IEluIGNhc2Ugb2YgZmFpbHVyZSwgcGFnZXMgYXJl
IHVucGlubmVkIHdoZW4gZmVhc2libGUuDQo+ICsvKioNCj4gKyAqIG1zaHZfcHJlcGFyZV9waW5u
ZWRfcmVnaW9uIC0gUGluIGFuZCBtYXAgbWVtb3J5IHJlZ2lvbnMNCj4gKyAqIEByZWdpb246IFBv
aW50ZXIgdG8gdGhlIG1lbW9yeSByZWdpb24gc3RydWN0dXJlDQo+ICsgKg0KPiArICogVGhpcyBm
dW5jdGlvbiBwcm9jZXNzZXMgbWVtb3J5IHJlZ2lvbnMgdGhhdCBhcmUgZXhwbGljaXRseSBtYXJr
ZWQgYXMgcGlubmVkLg0KPiArICogUGlubmVkIHJlZ2lvbnMgYXJlIHByZWFsbG9jYXRlZCwgbWFw
cGVkIHVwZnJvbnQsIGFuZCBkbyBub3QgcmVseSBvbiBmYXVsdC1iYXNlZA0KPiArICogcG9wdWxh
dGlvbi4gVGhlIGZ1bmN0aW9uIGVuc3VyZXMgdGhlIHJlZ2lvbiBpcyBwcm9wZXJseSBwb3B1bGF0
ZWQsIGhhbmRsZXMNCj4gKyAqIGVuY3J5cHRpb24gcmVxdWlyZW1lbnRzIGZvciBTTlAgcGFydGl0
aW9ucyBpZiBhcHBsaWNhYmxlLCBtYXBzIHRoZSByZWdpb24sDQo+ICsgKiBhbmQgcGVyZm9ybXMg
bmVjZXNzYXJ5IHNoYXJpbmcgb3IgZXZpY3Rpb24gb3BlcmF0aW9ucyBiYXNlZCBvbiB0aGUgbWFw
cGluZw0KPiArICogcmVzdWx0Lg0KPiArICoNCj4gKyAqIFJldHVybjogMCBvbiBzdWNjZXNzLCBu
ZWdhdGl2ZSBlcnJvciBjb2RlIG9uIGZhaWx1cmUuDQo+ICAgKi8NCj4gLXN0YXRpYyBpbnQNCj4g
LW1zaHZfcGFydGl0aW9uX21lbV9yZWdpb25fbWFwKHN0cnVjdCBtc2h2X21lbV9yZWdpb24gKnJl
Z2lvbikNCj4gK3N0YXRpYyBpbnQgbXNodl9wcmVwYXJlX3Bpbm5lZF9yZWdpb24oc3RydWN0IG1z
aHZfbWVtX3JlZ2lvbiAqcmVnaW9uKQ0KPiAgew0KPiAgCXN0cnVjdCBtc2h2X3BhcnRpdGlvbiAq
cGFydGl0aW9uID0gcmVnaW9uLT5wYXJ0aXRpb247DQo+ICAJaW50IHJldDsNCj4gDQo+IC0JcmV0
ID0gbXNodl9yZWdpb25fcG9wdWxhdGUocmVnaW9uKTsNCj4gKwlyZXQgPSBtc2h2X3JlZ2lvbl9w
aW4ocmVnaW9uKTsNCj4gIAlpZiAocmV0KSB7DQo+ICAJCXB0X2VycihwYXJ0aXRpb24sICJGYWls
ZWQgdG8gcG9wdWxhdGUgbWVtb3J5IHJlZ2lvbjogJWRcbiIsDQoNCk5pdDogVGhpcyBlcnJvciBt
ZXNzYWdlIHNob3VsZCBwcm9iYWJseSB1c2UgdGhlIG5ldyAicGluIiB0ZXJtaW5vbG9neQ0KaW5z
dGVhZCBvZiAicG9wdWxhdGUiLg0KDQpNaWNoYWVsDQo=

