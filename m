Return-Path: <linux-hyperv+bounces-9943-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBRTC5Yrz2kNtgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9943-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 04:53:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3573907AD
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 04:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C2430131EC
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 02:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FE131F9BC;
	Fri,  3 Apr 2026 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GDqZ1bDi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010018.outbound.protection.outlook.com [52.103.20.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE511B86C7;
	Fri,  3 Apr 2026 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184781; cv=fail; b=IQ5NHKkQd6IVyklNEadrPU+M96Binx6fsnrAMqzQXMS2G8hiVnSExxDn0TugcYW5LJFZrd0w1Uw8/MmEEwhuNszlgzSz5A1NZrH5x2Ub+U6zXxM4XwrifwUGt0BmkEAsh0FZe3VtRq5XYGU+k1rzTjCa1WV4saJRfRSxgfJCIK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184781; c=relaxed/simple;
	bh=Zqq5zm/+RaQeUapIG78/whSYIK0qNJMhFIAtMjQudfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MAs/r0zZ0h+PDHpG3DIZ6YsYiw2KauP3owEmufFI1Y0Wo3nxtdhle/KWRgVZ4UxcaXngItyUylxwlpsH5nK7qri7AgDTLRd1fvY0Ek1NkVYhsxIM/U4Xu8r7Q+hGnOICPbmV91cIDwfEC5p9lXH0p8EF2GrfyOtPs4iYGW4P+4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GDqZ1bDi; arc=fail smtp.client-ip=52.103.20.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiR2t03WjGu1W1vSCwU2VAURTjKGsYCK17OlmJS0K4mCZmMEND/XsqjTCxqFYjITALYnyJ7FmLkSUHa7Ne5BgRVl9Sxyrwj9bu0uySur1BTAyCvyhnbgiMWaiMVndYD3DP2gh5AYFEFjhfxuKxOu0ayTzv9ocYIvr7HUCmqrVKumyQ4/RKPJa/vPIESLVPUX7i4U5c3QXw/LFIhEO/LhqavuOdmdQmINbJmwAhnLvvcxlv5aoFLMn0kD6MHD5rsEByWx9pQEd4zlSzIcw7kDMHRF4dHvcpIU9A3hIlfF/Yh1cyv4OhdB23slpkCfVsPLZmlLMMbtF5eNciQ2wIhjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqq5zm/+RaQeUapIG78/whSYIK0qNJMhFIAtMjQudfE=;
 b=f8CpJdAaowO9BwL3E+ch3XHysKccmOn2IgY9cyBj/kYneogohvEfmk1lWwh4dnFd3k5eKjDIlJY8L9RuIMEuNxLzyHgVbZjXpviq++QeZ+4ILKXr1zQb5hwUBbOWVWd55GjXJ1OmMFNl6r9ZQ/IZVOqMj9IlDY/aBIozU4s/qEjZ5l91BiGD7lk4Blj1ViQWjIOxql7wbLj98HVFx4JwQXpC/xjAHv4rAr4m3zuSItIh5cjLjTt+xYztWyykGU9DHjEKRWqmCQc2CLkguvDAs2JA78TVyXbq1LsbohjG9sFjXsoTj2k3qxBiy09X2n9cMAeIpx7jBMrhb0r7NbFwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqq5zm/+RaQeUapIG78/whSYIK0qNJMhFIAtMjQudfE=;
 b=GDqZ1bDiZvgW6DWDPdDkCUdotIAORsxNvBK71Bg0a/hXpf2Rm8lWMgwDE0w5+ExoEc2WMe3iXVa143ieUzJ/mj/KufRTuXq/37ocpp0ZpCbbltmIgi3tvkTrlr6DuabKL1waut68zQ0x4/PQ1K7lufFfSH8F7bRtV6Ge7tgAiSjoFtYD+IBtZcwCLSl379JaNbKrFW4kSMDBnaeYWLKd96eOAJoKkdFN6SuwsSu8s0t7ICSq9xfZjTSgTsZIGchEXJdT2dEEvDHOkjxYzjD4kcNb+KHCyfimm+EpTKQmCd136jTPVWMFWyMgttJkkKtjpLn+YU3Ku+sCnJ/XKJN+Ig==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8521.namprd02.prod.outlook.com (2603:10b6:303:158::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 02:52:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 02:52:57 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] drivers: hv: mark chan_attr_ring_buffer as const
Thread-Topic: [PATCH 1/4] drivers: hv: mark chan_attr_ring_buffer as const
Thread-Index: AQIA5n8utbFNLZq9HsGD5u2/wbCFbAEKIUsYtXwLwFA=
Date: Fri, 3 Apr 2026 02:52:57 +0000
Message-ID:
 <SN6PR02MB41576DA7538355C95D26B345D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260402-sysfs-const-hv-v1-0-a467d6f7726e@weissschuh.net>
 <20260402-sysfs-const-hv-v1-1-a467d6f7726e@weissschuh.net>
In-Reply-To: <20260402-sysfs-const-hv-v1-1-a467d6f7726e@weissschuh.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8521:EE_
x-ms-office365-filtering-correlation-id: fa358097-1827-4ef2-44f9-08de912c1cb3
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|41001999006|461199028|19110799012|15080799012|31061999003|13091999003|51005399006|37011999003|440099028|3412199025|26121999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?d09xMzFOVnJ0ZlhkU3pTSlM2REV5TDdtdHBsS01UTG0waWwzT2xhWjBtcnZK?=
 =?utf-8?B?TGpHcThxNWhKaVVtcjBERVRURmk1dmFISHp3Y3BkbHRxdmJHNVIxLzhZOGVr?=
 =?utf-8?B?MkJKMW1Xb01XeWprcVIzY3hDLzNtT1h2MUkvdHRWcE0veWVWdk9UemRiaU1s?=
 =?utf-8?B?YTdUSzhrZk9ueUd1NzJ0T1pwa3lmblNlMWcxcWFsMkxSdG9iaU5Eb3JKUmJ6?=
 =?utf-8?B?YjQ2aGJUWXJENDFVdlA1WkVVSzBFYld5bEowZHpsdlowQXBpbktmd0xWWUpX?=
 =?utf-8?B?bU5TcjBBcTMreWVBSndZZ0JqOFBQUnVrMjFhVS81NnVPRnZDd1BIbUozOTVt?=
 =?utf-8?B?VlMxNzdkakZNeEJobWoveHA3ZzVSS2hKSElzOHFyaURZWU1RVnFYeTR4UXVo?=
 =?utf-8?B?bWpRaEt5cmdlbTFqQk1KRUovWU94RjdLZmJqM3E1ZXRDeTk0K0tmaGpjelcw?=
 =?utf-8?B?anJabU1kMVZsTUZFVzRHYVlyMnJ1RHc0cG85Z1JzMU1lTUpwczBpRmRVK01o?=
 =?utf-8?B?bjN4YW5WeUtLTlFrM05Zd25DQmV0bTJNOSt3cXJHZ3pRYTBoZHRYVUd6ZDhj?=
 =?utf-8?B?eG1aR0RmOVZhaHQ1REJqMURweVByMlJsNmRGeGZZWFRzRUpNWVVOKzdJNnkx?=
 =?utf-8?B?a3ZaSWJvdDQwV2l6UTJKbnlibmY3YW93WWtXT2xTRVRHbkliMWxaTmtsa29r?=
 =?utf-8?B?Vm83d0pCNGFtMGlSUjNldHpBa29VS09xYXFld2lOd25OeUpRVkhhLzg4Tk5V?=
 =?utf-8?B?SUZibjFqQVlHdWd5R1VjY2JCYkxWUE5iUFZSMGlWaFBWM2ZDbmE5cStnQUtI?=
 =?utf-8?B?YXVKQ3ZYd04rMlE5dXk3QlZpa3JORWwvbTlvMXlpcld5WEU2alRBbXdCV3Qv?=
 =?utf-8?B?R2FOeWdneFh4NlVyMEdxNWg1bVZFSS9BK3o0TFBsNVJ0Y1MwSUVDVEdXQ3Fr?=
 =?utf-8?B?TDRjeDErK0dQTzIxaG9xbTMvYnZHT1JsTWoxWTB5K21ycGg2cDFLY2tUQng4?=
 =?utf-8?B?a1pkQTg4TEQ5bTc0WEdZaTlUMDlKNFpOVXBWaWQyaUFTbG9wV2ExREZ5bGJ6?=
 =?utf-8?B?TGNqL3BEdFlya2NvNXhqd2d5ZTRVSzZlS3JyNjRrUkpQQVUvTU4wTW16cnVU?=
 =?utf-8?B?aHArNVNxM01nSG9MQzJWZ2d1Q3c1QUw0R0hpcUZucDAvT1R3cVQybHpMazls?=
 =?utf-8?B?SmNQaTc5a0o2aklWUTQrNEZIcExBb2FBbVJTN2ZrY2U3OCttbHFoRHgrd1Vj?=
 =?utf-8?B?L21CamU3SHpaRE1oa0lrb3BkQktqL3dLZlRJQkN3OWlCKzNUZHNNNmpVdFQ4?=
 =?utf-8?B?VXJvTDdUcjRGeWFxVGNwZFpWRHZncS91Wm1SNmVXcmpOVlVBb1hNZTFXVjE4?=
 =?utf-8?Q?BXghe8eKsjAkozGOkjOQHhWWxm/Y4eBM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEc5M1FTcUxDWDZjZ3duNVRrRmhMM3VFUndYUE1laU1uR3VmVHNYYlVYL2I3?=
 =?utf-8?B?dGZuUC8rRTFnck1ZSEsvZWpqbGllNGJyTGUzOFE5VXVJb1ZwL09qeVp5QmlN?=
 =?utf-8?B?S09uRnB3VVczUmRzcEFWTU9qSWRPWERRY0xqYU9XbzNwUzlOaHhrOEcwWUt2?=
 =?utf-8?B?NnZTOVZuU1Ftc2MrYzFaajhvMS9kSXY0YnVKa2Uxa2EzQ2lWWWhGc3I0U2c0?=
 =?utf-8?B?MTYrRjdvNWg3VGR0dnVqYXpEeHRQTzc5S0NpU1BwQVZEaUE1VDJKNzRsNGhh?=
 =?utf-8?B?VXBlaDdDUmtNSG9JcjdKRXdJbmRtYlo4Mkl2NlNmSlZpRW5WZjBXTGk0N2pP?=
 =?utf-8?B?K3BxODBqYy9pYWVlbEtxNW4vTUlwR29aTysyK1JCRG1WeFI0UzZSalR2YmJB?=
 =?utf-8?B?V01kK0Z2ZUc4OW00aHdtTm14UkFQblk4OGZ4Z0VHLzhHYStlYjk5Um9YenMy?=
 =?utf-8?B?UTAyaC9tUlhyNzVuVFZvVGdUV0hOMjhvZkRwZjJ6SkQzdEVUZ0VoNUZJSFZD?=
 =?utf-8?B?alN4ZFZkd0NXTnJmQzdjcnpZRXFCNUhJOEdGNUNpczM3aW44WTBQLzNoSUtJ?=
 =?utf-8?B?RkhraXhzZmc2b24yd1A1NkdNU0Y5QWxKb0tneFZNYlRsRkhiczNvMnBhWFU3?=
 =?utf-8?B?Qm9YUVhCSi9PVW9oTzdHMkU5bXpQcHVHbzRHQTc3NmZqY0dBL2FYd0doekhS?=
 =?utf-8?B?c0RCQ3BLbzZ4NHZyOU5EL3VWeDlyY3VEWlNvbG1DK1BUdC8xcThBT3YwRVRB?=
 =?utf-8?B?ZG91WDdPMG5LQ254ek1wUVcwNFNRcWJqQW4wbWdkbnZnVEJSenFQSlZFTHEy?=
 =?utf-8?B?TUpCL3ZqbTFlVE1LT1lhQVZjbE1wOUp5SVZBYjkzUVRKN3hHWi9aQWtMeTNZ?=
 =?utf-8?B?NlFCekx5cXAreEVaR1lBemNSTlo2U3dVVFVrV1Z5eE1Nc0lOZjB6MEVyNkJT?=
 =?utf-8?B?TFFlQnhxdzNZZEhzTmcyQnJjTUhoYklxckFsUlVsMG9KSXRMcXBZR0VVdExP?=
 =?utf-8?B?a2NVZ2tHd0dMdURWYzNZc0R5OEhJSC9sUjJhVEtoNWhPZ3A5OFZadm1nRm9h?=
 =?utf-8?B?Mmhnc3RIMDJKNURtZWMwWlc1UUlCMTgrNVJEVVBhSUIrTzU0c1hHMEF6NWpC?=
 =?utf-8?B?S3JjK1pZeXVXd0V6Tnpia1JQdXdGRUpnaGNIelQ0cDgwRlZBRFZtQVk5TjRV?=
 =?utf-8?B?TlB0T2Z1MXV2Y2VLalJUdkNaM1M4L1Erem44TXVFbEppUUU4MWw2SjV0bUFP?=
 =?utf-8?B?WFlQWTljRTRDeXdiaTg5M3FHckFmUzdWMjFpQ2tOMGdKZjRYSVA4YnpZUHdF?=
 =?utf-8?B?VUpjZW1tUVlqNFF4YTR3S2dwbWxnd0NrQ0h2dHFSdjdlOUZSV0VobmpERE4z?=
 =?utf-8?B?blljaE1IaXc5K2RJYVVRR3lucWhIMVNGWm5iVkVTcTZlQ3F0amRURHZMZWE1?=
 =?utf-8?B?OHNMUFJSUGowNi9RdHg4b0RVWGhHQ09lbXhqTnVDQXFsczVyZzRVbkNVREow?=
 =?utf-8?B?Sk8zMWIxK3UrWE9Ec2hhSlozMGdhS3dlWE9yYjYzM1ZUUnBFOHNlTWFFOHo3?=
 =?utf-8?B?N0V5cDR3dE05SjRjZytNRUk3VCtvQ2FsQlQ1TWpWUUt0a1FLTDZiTWU4YWpt?=
 =?utf-8?B?aGVvVENPdnA5anJEcmhBL1Buc1RxTnZEMkJlUDRSZmFpL2tKN3JnMTRzWStW?=
 =?utf-8?B?Zk5BSk4zQitiL25qZkdXcVYrS0paYy9oeHpoUUx0SlUzM3k5SmEyb0lMbC9y?=
 =?utf-8?B?TWdtK2ZjL0NsNDFBMk1oanhxeGEwdEpvVnMwbDJFUHRMVWQ4YzJLYlFZVXpT?=
 =?utf-8?Q?tY0ZI5HPPGHkaoBGflD79q7wBNnSMn5IrJzWs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa358097-1827-4ef2-44f9-08de912c1cb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 02:52:57.8663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8521
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9943-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,outlook.com:email,weissschuh.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A3573907AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogVGhvbWFzIFdlacOfc2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0PiBTZW50OiBUaHVy
c2RheSwgQXByaWwgMiwgMjAyNiA4OjE4IEFNDQo+IA0KPiBUaGUgc3RydWN0dXJlIGlzIG5ldmVy
IG1vZGlmaWVkLCBtYXJrIGl0IGFzIGNvbnN0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGhvbWFz
IFdlacOfc2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0Pg0KPiAtLS0NCj4gIGRyaXZlcnMvaHYv
dm1idXNfZHJ2LmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi92bWJ1c19kcnYu
YyBiL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCj4gaW5kZXggYmM0ZmMxOTUxYWUxLi41ZjliN2Nj
OTA4MGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCj4gKysrIGIvZHJp
dmVycy9odi92bWJ1c19kcnYuYw0KPiBAQCAtMTk1OSw3ICsxOTU5LDcgQEAgc3RhdGljIGludCBo
dl9tbWFwX3JpbmdfYnVmZmVyX3dyYXBwZXIoc3RydWN0IGZpbGUgKmZpbHAsDQo+IHN0cnVjdCBr
b2JqZWN0ICprb2JqLA0KPiAgCXJldHVybiBjaGFubmVsLT5tbWFwX3JpbmdfYnVmZmVyKGNoYW5u
ZWwsIHZtYSk7DQo+ICB9DQo+IA0KPiAtc3RhdGljIHN0cnVjdCBiaW5fYXR0cmlidXRlIGNoYW5f
YXR0cl9yaW5nX2J1ZmZlciA9IHsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYmluX2F0dHJpYnV0
ZSBjaGFuX2F0dHJfcmluZ19idWZmZXIgPSB7DQo+ICAJLmF0dHIgPSB7DQo+ICAJCS5uYW1lID0g
InJpbmciLA0KPiAgCQkubW9kZSA9IDA2MDAsDQo+IEBAIC0xOTg1LDcgKzE5ODUsNyBAQCBzdGF0
aWMgc3RydWN0IGF0dHJpYnV0ZSAqdm1idXNfY2hhbl9hdHRyc1tdID0gew0KPiAgCU5VTEwNCj4g
IH07DQo+IA0KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBiaW5fYXR0cmlidXRlICp2bWJ1c19jaGFu
X2Jpbl9hdHRyc1tdID0gew0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBiaW5fYXR0cmlidXRlICpj
b25zdCB2bWJ1c19jaGFuX2Jpbl9hdHRyc1tdID0gew0KPiAgCSZjaGFuX2F0dHJfcmluZ19idWZm
ZXIsDQo+ICAJTlVMTA0KPiAgfTsNCj4gDQo+IC0tDQo+IDIuNTMuMA0KPiANCg0KUmV2aWV3ZWQt
Ynk6IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCg0K

