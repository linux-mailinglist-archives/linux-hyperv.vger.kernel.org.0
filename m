Return-Path: <linux-hyperv+bounces-8492-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEOQNrTHc2lZygAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8492-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 20:10:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFA77A0A3
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 20:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FCC33009563
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 19:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5022F257843;
	Fri, 23 Jan 2026 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DAxPam7R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012014.outbound.protection.outlook.com [52.103.14.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA71F03D9;
	Fri, 23 Jan 2026 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195442; cv=fail; b=gEauEpKnOo63g0AITUNuOODcYmmYv1goz0WxjRM/7bmvlO0+OBqYEdICpWfFDg2QfeBmQL+DaW8DoL2XZ3ILiWbIkZTptieuNOOHgpjeEywYw/AUuvilMwdeV/sURS+kXiOlHCSSHDkhPY9X4VmESG5wwxumd8rlcoFhFSdS7oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195442; c=relaxed/simple;
	bh=Q6ItzdwM8w0esOsA07Cz8IghmSYl2Fx5u13+b2+ah5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e2SkVOpO8/Y+MK6PJ/UNrZI834FZUxV2iPyHPYXJpHr0n+B/1or0nJoLxoUdnYCJFBb8ogHomVQrZoOkqFajK/Y2FbuB+pGmoab7mS2RjXFMt/leaZtavDfCheUzGUHISW6irVl7zMg5d6Bt2PWYM1IF2K0Y0DWTul1oGXDGWmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DAxPam7R; arc=fail smtp.client-ip=52.103.14.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qW9oPkpiq1PzRG4lXw1VaibyYAztXGHfM51/83SgAsQPkLBlpIgf14pNyocP3bB8mbYNh175RQ5tuY6PZCsbCdip2EpdCTDAMo7MWC9L6/YXA7MoGED/Hp62mAKg+DUETjnNYja46RxEUf83YLy17168cVNDes0/OzCu87nL16acc01aKGYkNjQBagHJntz9C2Dqm3M4jp6LKXMcC8XWpvXe3cpzK30ZAeNCj9pwVlwU31NSABhGijv2uEV1CCT1Oa2vnP66iNkt2vL/CsgvYWP2PILGQRn1+Bhgmr5KZNZqRuCkgC1JTsD+fADJA1Scnmka0DqkPOHQ1CTVVT63yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6ItzdwM8w0esOsA07Cz8IghmSYl2Fx5u13+b2+ah5s=;
 b=pfNAjocCSq4Jh2ESTm6uq/zWgacJoZnjpylck1D4cgWnWlNru/7O5OJ6JuSpcK9FnyF0Bdejj0gXUfXMUJKlLzp1pw04UuWUzCPATCqePTcI6WMJ8U9Cx4hecc9J8IHMsJjKOuQBHy3KnlhuZenhAJCNOGg4HoOQ0BFVihc9CugW8WtgtYIhA1YQVcEAILpjGXztdi8zVpjKvqy4COZmXEiRuYUfE8wZc6q89suvg0u6iznYdlqZJz33semUAu1/0QVxKmarYl9DjG6Y41+EN+S6B/bQvv6oa+ZflXxLlhXxrUD2zTzHKO7fQ/vz558YeKltV8iIAC7P9T7tcVip6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6ItzdwM8w0esOsA07Cz8IghmSYl2Fx5u13+b2+ah5s=;
 b=DAxPam7RQpYjDiKAEMCnxqD4Ijskm0Ddd5iZERHxzyR/CCaxXssC9UU96s6t7R3iMd8W2qU4aZstd2+6kcyfMoZX86nSBee7u5QeVErTHjPuA3qMWGRvjPDLkrY26UCAisg/hOc+51HZEQw5OrDsjZ3gemmWjeWuVYeAQcy7UgDyMCWsSWe1YnxBicyIGeQxoKke3JrWbCa5XFAEQtYvXCtZMUZcXUjYt0DXNGVB/uCK4XEuJtXSnRxZgXjE5NZGj4E8AsJkMitIJeGOZguycI+EE8IBo6bm1o39u24e+bUwAV6Id0in0A1xweP3psSO9I2VsIjZWNIcMsUksWw7AQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7410.namprd02.prod.outlook.com (2603:10b6:303:7f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Fri, 23 Jan
 2026 19:10:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 19:10:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "paekkaladevi@linux.microsoft.com"
	<paekkaladevi@linux.microsoft.com>
Subject: RE: [PATCH v4 6/7] mshv: Add data for printing stats page counters
Thread-Topic: [PATCH v4 6/7] mshv: Add data for printing stats page counters
Thread-Index: AQHcix9mx12lepGkcE2/p3HiI/apmLVfOm+QgADloACAAAFMUA==
Date: Fri, 23 Jan 2026 19:10:37 +0000
Message-ID:
 <SN6PR02MB415774C4D55D5D68DCE2ED01D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
 <20260121214623.76374-7-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41572B2CC3494BE6BC737424D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <2ea6f13f-ac2e-4ed7-9f2c-6c079cb25b85@linux.microsoft.com>
In-Reply-To: <2ea6f13f-ac2e-4ed7-9f2c-6c079cb25b85@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7410:EE_
x-ms-office365-filtering-correlation-id: 08e8a9b1-c3e7-4ad8-09cf-08de5ab317db
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|13091999003|19110799012|51005399006|8062599012|8060799015|461199028|31061999003|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXVadDV6RG5jZDdVQUtxQi9GSjNBdmx0Y1k0OW5FYU9EaDB2Sk9KNnhKQXRl?=
 =?utf-8?B?TEFpbzhtRWNQY2tFQ3dwNzB3OXlLcEZ2YWt4dkpremZ6NzlQM1ZoTE1mRWJ3?=
 =?utf-8?B?cnkrVFp1OGt3aExtZUpHVVNvTzVTQkdleFdnMlYweDROVXIzVHlFNW9pa20v?=
 =?utf-8?B?cnVoK2l3UFZnSGh4QTluWlhaY2l4amVLVDgraTUrRTB2N1ZJSGhXUTBudjBR?=
 =?utf-8?B?ZjNybFpmWUwwVGdnOVk5M3R0V3A3QmlmdmtmVmRVTjVad3RSZHc3UFppb2w0?=
 =?utf-8?B?RWJoTEFmTjlkUmVVS1NRaTZyR2RudUJld01VU0oxdmNiNFJ5eTBQakliT0VG?=
 =?utf-8?B?WmVtNkpITCtNQjRPWk04TGdvZEtzNStObkdNOGxGWmJVaDI3ckljbXJaTFRL?=
 =?utf-8?B?Rk1aYW1EQmgxaHZ1WGlOQU9jSmZ2SjZLdFJicDFacDNzNTlEL0J6d0V1NCsx?=
 =?utf-8?B?akVxdG5mMTZXRU5iT0t4NWtuTEZNTmZsWVpWaUhKaUVhejFwVWY5U24yT0pB?=
 =?utf-8?B?OGZ2SWJLVytlUFFxbzdERCtWNkViQlpiRnFLSGw1RDdoVGdBMXN2ZmpIbGdq?=
 =?utf-8?B?djV4TWptNlFuRDluVElVVHlPWVZoSFlIamI3N0VlQ2xMclZ3ankyV2I4QmR0?=
 =?utf-8?B?VFhxN1JOOTNMNE1OWW1BVFo2ak9MUkE0MlY1eTJ0N1hobmlCWlZMV250VXg0?=
 =?utf-8?B?cWF5a1V3dmU4cGRwbUhuMWgvTFlBeDZmUzdOTlYzYTZ3NGRvWTgwd0RmOUxh?=
 =?utf-8?B?WmxHMURHMk5MWHA2NnJpSCtsZDBCSmRYcTNYazczb0R2V2lJUjdwaXVjN0F4?=
 =?utf-8?B?OGJ0YTUvMDZsUGhRUThDS1VqRzc5a0xvcUd3Q2txaVV5SmRMRHlhUjd4T29t?=
 =?utf-8?B?QUs0UXY5UG9VQytyWDZBSlNsNjZqT1hWR2s4bjliNEdCUkZBQ3B6UE9sUThQ?=
 =?utf-8?B?WjVISHQ1cEc5ZHgyNW56Uk1kQjBqVktaamF1WHMzQ2lqdlN6b1BtbXpvZ2JI?=
 =?utf-8?B?cHdKMnhuYytlTUJCVndpdVdXQUIrSnZuRDhYRStYUGFrOW1NMDB0WjMzMTk3?=
 =?utf-8?B?VlNkclh6TFBUTURwRkZOT1ptZUh3L2d3Nm5NeHpmRWZwZEV5SDV5UzRCTGNu?=
 =?utf-8?B?ait3SGNzMU1oNHQ0SU1IZ0FOUzdZTWRXN1lYWDJUamMvWHBYMEZRT1dZRXZm?=
 =?utf-8?B?WXZKNXJsdGNMNElCUjFoR1FXamUvaWZ0eVFqTGpkbklPQy9ob01OOXVzUGlH?=
 =?utf-8?B?UlYrV3FZTUo2Tzl6RWVVQWRGN1B4ZlkyWDNZOGZLYjBlSDRJS0JQWkVHK3hZ?=
 =?utf-8?B?VEQvVGNPelJSa3FidmFDRCtPZWhodnF2WTZVcENpNElJOFJwUFRmNkdLN0VW?=
 =?utf-8?B?QktRKzhmcVowdXNyRTR2aGJYczFDVkdVRjBuUlFOOTdwc3hNZ01yS3R2N2Zv?=
 =?utf-8?B?cDc1MTFtZTNNcnNYemVybTZaZkNrRGM3cGlKLzc3c09vaWNmQmN3bmNOWisw?=
 =?utf-8?B?WDlYMlk3eUxwb0JWK25FYm1VSkJZMVRRT2VrVzFUOE1vZ0p1WXVrTjB5MWRa?=
 =?utf-8?B?TTVJM0d2ajJsOFlqVGJRQmk4RG1mdVBEOXdIN0hYaXhRRW45TnZzSEg5YzZI?=
 =?utf-8?B?MTlGZE95VjVRSG9Wbm9McnJNTE1Janc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXZkZHJLR1ViajEzbXFJVlc1UHV6U1pTQzc2Zk9WamdhNVdOd0N1b29WdUZN?=
 =?utf-8?B?Vy9zSDlyUG1tN2ZOdU9RTVhReDFxWTZhckRvRjYyUHZkQWVhTHdnK1IrTnhS?=
 =?utf-8?B?dEZwM2dKZFp2K1l1eVZTRCtXNURaeTFvbmM5UEV5SDh2aVI1Y0FiTXFPUnUw?=
 =?utf-8?B?NFNvR1FURzRRSElEYjhEbjluSUc3N252RXhxSnlCZWNpYVpnQlc4Q09XL0ll?=
 =?utf-8?B?Z3UzZzVzZEhtRFRZZS9KOVBCeGt6TnRzOTlEbHFUZnU5dXVJSXZ2UFlKV0hJ?=
 =?utf-8?B?dERRZ1NXQURaY2l5YzFoMHk1TkJhVmNxRyt1NnQxVUdHMDZJZ3ZuRXQ0aEVm?=
 =?utf-8?B?bUFWK0xUL3I3MTVpUjJ6NmcxeUpYV0hVcENTdmlIS0tieGJKT3F0Wk5TVWht?=
 =?utf-8?B?TnZDeDBHV3RPaWFXQk1TbzEwcnlMUGgvV1FXYkNmMmdMc05vSU05UW1Xd1Bx?=
 =?utf-8?B?UG84N1RoWHhPV25vK0FIbmZ6VU5lc3U1RFVjZUFyRmhxaC9QV2Joa0dYS2l0?=
 =?utf-8?B?dVZwUGFYZ3Z3N0QwSmZUSDFIMUNpMGNCSWh6VjNvM0FuSWp1WDlYL21wcXNF?=
 =?utf-8?B?ZmF5dXRsd2RVTDBhODZLbG51UWVnWS9DSitFZFd6L1lhcG5MZHNod0F3REVR?=
 =?utf-8?B?LzJKakYwMHJQeDdlWGFEQzNjTFVRY1ZrZm1mM2d3eDRrWDhUVVk0MU9YeXdW?=
 =?utf-8?B?UWxwbjl0aHdBenhHNWdMeFB2WmdFNWpYZUZHeFZNMTVVcjBDZGI3OFlaK1d5?=
 =?utf-8?B?NXZpWUxOb2RiOElnTTN1ZXBGVHl1dVFrd3JmNE1MempJUG9tR1JXbzlsRFZN?=
 =?utf-8?B?R1ZGbFFhd05SSDhibkhScXRJdG9hd2RHOG56RTF6bFFxdnF0Rk16ekJYM21C?=
 =?utf-8?B?L295TU5YK2xEQkNrMDYwTjNiQzBBNERoZkFpam5hWnJQMDZ2Z0xpenUwQXU3?=
 =?utf-8?B?eU9yTEpZR1ltMGlLU2dBd2VuN3U3UWt4dzdlTU1QSWVURjcrdWx1azAvcGhx?=
 =?utf-8?B?M3BabDV2VTU3UGZmU28zQXJsQm84OWV1MExMUm1sTjg3L3U5cGZ1SnhHekJZ?=
 =?utf-8?B?S0VSZG40NjZMVGJaeWM4WkNMZTkxLzFYNkE3eUpQOGhXQmZjd09nUjhwWVVU?=
 =?utf-8?B?NnZxUXZwQTVpWEJjdjBkOGNoU0tUeE9kS0tjeW5ZWFM5eVRqeVJtU3pIcEl2?=
 =?utf-8?B?ZHlIbHN4Rms5RHhvRE5aU1FzZEpxRVZwaW9Kb3Y3UExySkhKeEpHVis0enc5?=
 =?utf-8?B?aDl3c2FiVVBRb3grMWdNdzBCRDhiQmJvakxyOWh2Q1MvM21QemwrRHcxUDNi?=
 =?utf-8?B?SCtxaGlBMGVoTDJNZkN6c0hXaURwNTB2SDJPQ2YzcTdlMUtJNmcvMWU1VC92?=
 =?utf-8?B?WjYyR0lrUUdNUVdRdC95SW9HbjMxeFlnNURBZEdnVEx2Y3lkZTRrQWdWbXpT?=
 =?utf-8?B?eit0U21nSDdqcHMybnhMajVibGppK0JjaEFzeXpoTVdDc1lRMjV1ZDJnSlNS?=
 =?utf-8?B?L3FacThUYWtXMjFEbHBjQkV4TzZIb1U0aUhVblN1WHptcUNlRzNoTnkxdCs0?=
 =?utf-8?B?dTVlNWRxMWlYMGhISlhYTFczdjlJdVJJMTh5SWFkM0J3VGdueUIzWlFqdzdP?=
 =?utf-8?B?SXdXcDM4bzhiTGl6T1MzU2c5ZWpwL0JpUzU0eDhzT1NhS0ltcUw4NmhiNW9E?=
 =?utf-8?B?VnJNUXRYT0ZoM2F5ZmF5QWtUb3pTNitSVzdZM3pTMXBsRG9RQVZLWmZLSDRM?=
 =?utf-8?B?azdWZUZzeUY4VnpSb3M2WkRCTGVYeTcvZWtkM0pHNmlaWitYbXBhcnlnUUtX?=
 =?utf-8?Q?B6C+E6gPQvv+5n+7HwjPprHAjJntPqrnyQzes=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e8a9b1-c3e7-4ad8-09cf-08de5ab317db
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 19:10:37.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7410
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8492-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EFA77A0A3
X-Rspamd-Action: no action

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBGcmlkYXksIEphbnVhcnkgMjMsIDIwMjYgMTE6MDUgQU0NCj4gDQo+IE9uIDEvMjMvMjAy
NiA5OjA5IEFNLCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBOdW5vIERhcyBOZXZl
cyA8bnVub2Rhc25ldmVzQGxpbnV4Lm1pY3Jvc29mdC5jb20+IFNlbnQ6IFdlZG5lc2RheSwgSmFu
dWFyeSAyMSwgMjAyNiAxOjQ2IFBNDQo+ID4+DQo+ID4+IEludHJvZHVjZSBodl9jb3VudGVycy5j
LCBjb250YWluaW5nIHN0YXRpYyBkYXRhIGNvcnJlc3BvbmRpbmcgdG8NCj4gPj4gSFZfKl9DT1VO
VEVSIGVudW1zIGluIHRoZSBoeXBlcnZpc29yIHNvdXJjZS4gRGVmaW5pbmcgdGhlIGVudW0NCj4g
Pj4gbWVtYmVycyBhcyBhbiBhcnJheSBpbnN0ZWFkIG1ha2VzIG1vcmUgc2Vuc2UsIHNpbmNlIGl0
IHdpbGwgYmUNCj4gPj4gaXRlcmF0ZWQgb3ZlciB0byBwcmludCBjb3VudGVyIGluZm9ybWF0aW9u
IHRvIGRlYnVnZnMuDQo+ID4NCj4gPiBJIHdvdWxkIGhhdmUgZXhwZWN0ZWQgdGhlIGZpbGVuYW1l
IHRvIGJlIG1zaHZfY291bnRlcnMuYywgc28gdGhhdCB0aGUgYXNzb2NpYXRpb24NCj4gPiB3aXRo
IHRoZSBNUyBoeXBlcnZpc29yIGlzIGNsZWFyLiBBbmQgdGhlIGZpbGUgaXMgaW5leHRyaWNhYmx5
IGxpbmtlZCB0byBtc2h2X2RlYnVnZnMuYywNCj4gPiB3aGljaCBvZiBjb3Vyc2UgaGFzIHRoZSAi
bXNodl8iIHByZWZpeC4gT3IgaXMgdGhlcmUgc29tZSB0aGlua2luZyBJJ20gbm90IGF3YXJlIG9m
DQo+ID4gZm9yIHVzaW5nIHRoZSAiaHZfIiBwcmVmaXg/DQo+ID4NCj4gR29vZCBxdWVzdGlvbiAt
IEkgb3JpZ2luYWxseSB0aG91Z2h0IG9mIHVzaW5nIGh2XyBiZWNhdXNlIHRoZSBkZWZpbml0aW9u
cyBpbnNpZGUgYXJlDQo+IHBhcnQgb2YgdGhlIGh5cGVydmlzb3IgQUJJLCBhbmQgaGVuY2UgYWxz
byBoYXZlIHRoZSBodl8gcHJlZml4Lg0KPiANCj4gSG93ZXZlciB5b3UgaGF2ZSBhIGdvb2QgcG9p
bnQsIGFuZCBJJ20gbm90IG9wcG9zZWQgdG8gY2hhbmdpbmcgaXQuDQo+IA0KPiBNYXliZSB0byBq
dXN0IGJlIHN1cGVyIGV4cGxpY2l0OiAibXNodl9kZWJ1Z2ZzX2NvdW50ZXJzLmMiID8NCg0KVGhh
dCBzb3VuZHMgZ29vZCB0byBtZS4NCg0KTWljaGFlbA0K

