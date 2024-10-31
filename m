Return-Path: <linux-hyperv+bounces-3222-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850B99B7259
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Oct 2024 03:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA031F24CD7
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Oct 2024 02:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FAB6E2BE;
	Thu, 31 Oct 2024 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cyTtNGSF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010002.outbound.protection.outlook.com [52.103.20.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3317557;
	Thu, 31 Oct 2024 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730340238; cv=fail; b=DsVi0pI3+ne4s6bBIsPkM5TAowaoqJw8Pk670T4gE005jDHJfJ5KNwvggXqUwmu4kxiBuq4eTyeZMXaJtQQAcjC+mxHbnsS4dSKViws2lEg8mU90oV9hQ5rP80DXVO4sNPgAKZAHmHeE63wyDwQ3kNO2wMPRC6viBFY7xHqAAqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730340238; c=relaxed/simple;
	bh=HlVyq9t/qVlsIe9F0m3bwJo+pG3l6KqaoC0s3m3biGY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tcMGYNlROZ0wefVK24B/A+UhcQsmiXCN2+HSD99769hhxWsnCpBxWSA0XP5Ez25N83dAPaqaqmVz6vwF9Xnz0LGkt6BcvBiwAZP20NO459HU4mSgrDPSCXSqjGsRTajcfNLRVAJNUmWOMAr7+dpqNqwosf42cmxDpI9KSkgzgZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cyTtNGSF; arc=fail smtp.client-ip=52.103.20.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQz1Y364+Noy361n2kZ//QGeC/Wdai/RJh2bCzzU7xuPpnRyJ7bTW9wT2Lne/HJlwU5KTpAmYfCYCTZhZOeXPdLFLdzv9a/2cJQ36lVpo6rjArTdRGssLkX0s+tBdYOEfeBnNsULA1K3sn+jx3csUNmbcEsBoo0uLlVkSBhO2+AOAfNTT30xdI/yisVUrcfD2Q3oNCRJo5VQ/TBz3r89i1CXLxHum1b7Mzp+X89Nr6uCtCspzd7keAgVABEfmXfdmiEnOxfvNxueyOGlg2P1ykveB9CkVVqFg7JmS2ms8WMC3EU2FGKhd+0X7KP33Z19t5ii90tnFbnuoUstKKbqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlVyq9t/qVlsIe9F0m3bwJo+pG3l6KqaoC0s3m3biGY=;
 b=dRv0LKJl14ugLX2R/sevmwyatCTSH8vJ7tiCicBckJdxdlHHeMtOuKZheKStfFcl6F+xnF/eB1esNkMswPiEaV0/bzLMnkJKePovr6EmBYa//o6uOjSqEMb9xApxRouCKhdjdM8zG+yNi4pF8sB9bn9Q7I6Yw3xyf8J1HtHsfikXx+D7PZnS8neggYIrTcZQRl7PoVPMYxfbHtc5ih2kEqcCJp09Tv8r0zlnTRwJ4DRUNnGszRYJA1yVVN35Ryjet5X4lamKTuo/27/KcqDCuMHdOZSr/Ruf7SIBeDKrEEBCykOmJIRgMAvdgco8yuuMf9vAwjSudNbVwAs0PWUUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlVyq9t/qVlsIe9F0m3bwJo+pG3l6KqaoC0s3m3biGY=;
 b=cyTtNGSFl03rRauv6AQ62Yb14yaPn5LX96tW35q6tcHuRnjb5cDg4V/ZpVJkpeoaHjeLCVHEfQv4VgrGfEK7/ehZISmc8I886SVcVMrlFZe5NYM+RvOU18QZ+d/vowebBYB6wJeDamE2JqfCktykARTBfbeSbNw0z4jMipYvlCn/BR07/il1paOfqXNmZJhAUMFSRdB7QkzaZWL3ZRLa+xEnIMhGkcCMFOWAN+1Q2/6xuAug9NeR61hZA5mrkYE2NEwrzVbcThbqVE257T13AJLObXMufysKJxhu7HG7bATMYkex+ob/sspafkOM7kVoUD0Bl1QxBZWodeRjopyhtg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6986.namprd02.prod.outlook.com (2603:10b6:5:22e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Thu, 31 Oct
 2024 02:03:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 02:03:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Marcel Holtmann
	<marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto
 von Dentz <luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Praveen Kumar
	<kumarpraveen@linux.microsoft.com>, Naman Jain <namjain@linux.microsoft.com>
Subject: RE: [PATCH v3 2/2] drivers: hv: Convert open-coded timeouts to
 secs_to_jiffies()
Thread-Topic: [PATCH v3 2/2] drivers: hv: Convert open-coded timeouts to
 secs_to_jiffies()
Thread-Index: AQHbKvPZcTSOhM6HKUa6ajSMFhass7KgG2Sw
Date: Thu, 31 Oct 2024 02:03:53 +0000
Message-ID:
 <SN6PR02MB4157B87089C2A561146F0CE7D4552@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com>
 <20241030-open-coded-timeouts-v3-2-9ba123facf88@linux.microsoft.com>
In-Reply-To:
 <20241030-open-coded-timeouts-v3-2-9ba123facf88@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6986:EE_
x-ms-office365-filtering-correlation-id: 18978083-49f3-4ad8-e881-08dcf9504567
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|461199028|8062599003|8060799006|56899033|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?V0hKR0gwZ09GTFRoYWpnMEViRytDcDU2cFBtVUM5K2x4dVdRWWIyaWF3b0tI?=
 =?utf-8?B?Q1ZmQ0Yzb3laTGg1QXhLWk5CUVU0YlQ4OXZRRVdkUlNRNWw3YkRVSWxoQWFk?=
 =?utf-8?B?eSs5L09ibktscE40Q1ZBeXJsOS9ScXBpNVpZdGI2RUJOZTR3N0tXc3RnZEJY?=
 =?utf-8?B?TXdpcGFGOEZjQnVUL0xNanhrNDNGa1NzNHNOQktSdlZWbnNOUWRBRURCenla?=
 =?utf-8?B?Vmc3bkFQYi94NzNDdTNrTGo0UlJobkk3cFE2OER3RlRlYmZkL3VOQlNSejBJ?=
 =?utf-8?B?eHhkVWIrK1VRY3J3OVVrWkNJK3pGcnJUWHV6bWpwajVNY2VDZmI2NzVNRDlI?=
 =?utf-8?B?c0dDRjVQcS9ObE9pVkgzQnp2Y2o5b1BmTE9QSXkyOC9RemVCZVJOZ1dXa09p?=
 =?utf-8?B?UUpRY000SXdxU0tyZjNnNHlnYjdQQzhPQmk4OEpaVUdMand2czBRdkQ4WnU2?=
 =?utf-8?B?YU9KVjg1UUFtWEpMVDhHSUc0WS9BSUVRMGhHMkN6VFVqRkRuWityMlZMbjdH?=
 =?utf-8?B?dUlmTVU3OE5sNzJmZ3AyZTJlK0hMUWU5UEJDRkFxNTNVdXpZSDM4TmJjZTdm?=
 =?utf-8?B?b0NYWE1ZQ1lZcTZ4SDBvSWhZQlVIV1NkYmdZRUtuWDA4QjB5dFpkVUlXbnMz?=
 =?utf-8?B?Q3JjRUVFMVQxN0JOWE8rb1Z6c2VBdjloTU54UVBnNms1UWhWSHN4TVNiSEF6?=
 =?utf-8?B?NE8rcmxkVEhQU2RTeXA0TXVSYmhXZEFOWjcySEtMZFB1OWhMMHdqRUdVcDlr?=
 =?utf-8?B?ZHptTy9GbTI0Y1Rlc2VtRnlVcHVhaExUOHZ3NW9yQVFwNkFCK1EwVEFGUWdO?=
 =?utf-8?B?QWplOTMxKzhoWmJFdWZWMS9aenh4ZExQaVVuejhsK2tTeURZWHBEN2pscnRy?=
 =?utf-8?B?Zkg4MDBVZmE3VCtjR215K1BkY1pybll1bzBFNEd3WXBQdFdqMkw2dW1ZNTJN?=
 =?utf-8?B?TER5OWZHcCtCeFNBUGJIT0ZBRmI5OFM5VVZRT1V0MHQrYnorN0lLQXh2azNP?=
 =?utf-8?B?eTdodEZPK1kvSHREVFBjS1RKQk92blRGREJWUjIycVRQanVqOE9xMUpUNEJS?=
 =?utf-8?B?R2tTY0M4cnJsNmNvbHRtVTZaZ1V3a1ptOGlTR2djZEg2eHBwR2JHVVorQzJk?=
 =?utf-8?B?V2F0ZGNwRnQ2UWJBbmNBU3lYSDh2NG1hbndpQlRFR1ppSkVVQ1FaSWt1ajlD?=
 =?utf-8?B?ZHhaUnZyWFlzVlBtMlJKTHlNV3VhMXFKV0lFY252a1ozeTBZMEZab1lwcldC?=
 =?utf-8?B?UDhUQTBuZHVHaC9rUG9LS3JrVC9BZFFxamlnc24wMUxuaEZ3NExsdzVJZXJv?=
 =?utf-8?B?TnNJZmZzeUQ5V2tsYStaZVRVMVY4cS9JZnBmR0NPOW1WWWkvSGF4RGFNeGU4?=
 =?utf-8?B?NWszRU1lTnZmOXc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0R0bVhQbWVObzRnNlJhckR2YWdxd1Rja2J5cE05V3VqRlhOc0doVjh2UU0y?=
 =?utf-8?B?NzlQNkZUbW1uNXdmUVIrRmZ0di82U05ydCtkK1laWjhRWE9HM0dEWGNrdW9O?=
 =?utf-8?B?a1Q2ZVA5VDFEQUNaOFhzV0FSckpYR1dKcmlLbjFObVd5OEFWQVJML0RidTE4?=
 =?utf-8?B?M0lTRm5CWnhoRWxKSVBYczNNT2JCSDc3a2lCOFdMcGpheG5nS2lmbGU5MitS?=
 =?utf-8?B?MFZrNU9Ua0tiMk8vVXJud2xWUkxjUjZXWE00aTVSem9IK2RVWC9ZMFlWbXlT?=
 =?utf-8?B?WHM3ZmJZMy9jWHBOdWRnOWp2dnFqRkcvWlFGUTA0VzBDRUVDQ01WeXVXajFl?=
 =?utf-8?B?cmVveHJ4L2lVZFRmTFhLZlJqODRMVkgvdGZ5cmtMNUlqa0h5SStGelFxT1Qr?=
 =?utf-8?B?VjNMNkpzSkt0eDkyY29ENEl2cHd3YWhnMXhvTlZOMlhmYjlsSWR4MWhiZCtp?=
 =?utf-8?B?RjRpL08rcldtL3pqYkwvYkNaRDU4MTRQOTE3NVBERGpaaC9RdVlzcWVjL05D?=
 =?utf-8?B?Y3ZDQ1QrMUcwVjMrOXJuY2hNTXdpRUtxYWVucHl4SzRzZTBFSjVmb0pVOU8x?=
 =?utf-8?B?c2c4aGgrWVAxN29KeHdXSmNSMjhiQ0FGODl2QVJ6alZGclV1dlhlTnNlRFls?=
 =?utf-8?B?QWgrMGhUVFdPdXduUXFWZlRhTzJQNDcrQ3B4djRiUkRXeDJNS1ZWbWFpVTlj?=
 =?utf-8?B?RTRxdFFqY3hQL2k2eEZFTWpIRmV6bVJlK2UrYXdXNWM1VXhTdEg1ZjBNN1M3?=
 =?utf-8?B?V3p2a1JjY2owQTliR0VtdW1hSVJwWlZuUm9Xem13cWpLUExETnFRNGtINlhF?=
 =?utf-8?B?RjNFeTN3VXVIUTBuVW1rTVNNYlllWThRbXNsdkwxWWFrRUhrL2I4aFV3WHRG?=
 =?utf-8?B?NUlEQ1p1NUM4aERJbnAvd3p3a2pZaW9ZZ3haVDEzd1E2WUJIcXJ3RjRyN3g4?=
 =?utf-8?B?NExlZ1hVdS9KR1pUb3U5Q0VzWUpoVmVKYVBtbGgvdkdFaFdmK01hYmtuS3pJ?=
 =?utf-8?B?b0dVcndHUXJpRldwYWNib29IU0pjK0E4eGpQYlhKc3RuNlZPYml5cEtyTHI0?=
 =?utf-8?B?U0Q2ZGtDOXdOemxjTHBEM0JIZDJ3ZjVJRzdIQmxlOWhHSFExeXlYekwraElQ?=
 =?utf-8?B?RjNmN0dtdGd1bjY1am9zOGYvdUw4Zmp1ZkVZcERUZ25pVHdkQUxWclNxQ3B3?=
 =?utf-8?B?VEFxQWhETDF2bkJYK2E2ZjlsNUE2OXE2Yk9sVzEyS3NJVmtWNDNrZ3JyUXRD?=
 =?utf-8?B?K3BvOHlURmM2aGoxdE9Dc3pBVjRaR21vK3ZoelFZUm12QmtaZEU3Vnd3VXhz?=
 =?utf-8?B?QU9FdEhBenErbFZrWkdvVC90YkdRTFBuY0NlSHp6MEM3UlNQbitucmJScnpP?=
 =?utf-8?B?aCtwYk5tc3d3cTlVajBYTHBBOWhhWjdDT2QwdFVvV1h0VGJwcXBGc0sxSldS?=
 =?utf-8?B?UmtLVnAxWkJJRVVZOEpvckRTalZXWEp3VDhwcFNyWUhZRFMxY2k5Rklja0Vy?=
 =?utf-8?B?cVNteTNJeWlNRFpYa0MzeFV6cHI0QjBPY3d0M3BSRjE5QmFZY0lhM2Q5Rmtv?=
 =?utf-8?B?anA2VWEwSnBWejViQVZKZ05JcVlHdFNtVHUxUWNHSWN1NlVuUHNzZkh4SFln?=
 =?utf-8?Q?zjGknuJXkr6StjAzp7eqY6guQPtWh5yUWUcdDS9laKrA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18978083-49f3-4ad8-e881-08dcf9504567
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 02:03:53.6872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6986

RnJvbTogRWFzd2FyIEhhcmloYXJhbiA8ZWFoYXJpaGFAbGludXgubWljcm9zb2Z0LmNvbT4gU2Vu
dDogV2VkbmVzZGF5LCBPY3RvYmVyIDMwLCAyMDI0IDEwOjQ4IEFNDQo+IA0KPiBXZSBoYXZlIHNl
dmVyYWwgcGxhY2VzIHdoZXJlIHRpbWVvdXRzIGFyZSBvcGVuLWNvZGVkIGFzIE4gKHNlY29uZHMp
ICogSFosDQo+IGJ1dCBiZXN0IHByYWN0aWNlIGlzIHRvIHVzZSB0aGUgdXRpbGl0eSBmdW5jdGlv
bnMgZnJvbSBqaWZmaWVzLmguIENvbnZlcnQNCj4gdGhlIHRpbWVvdXRzIHRvIGJlIGNvbXBsaWFu
dC4gVGhpcyBkb2Vzbid0IGZpeCBhbnkgYnVncywgaXQncyBhIHNpbXBsZSBjb2RlDQo+IGltcHJv
dmVtZW50Lg0KPiANCj4gVE86ICJLLiBZLiBTcmluaXZhc2FuIiA8a3lzQG1pY3Jvc29mdC5jb20+
DQo+IFRPOiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPg0KPiBUTzogV2Vp
IExpdSA8d2VpLmxpdUBrZXJuZWwub3JnPg0KPiBUTzogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9z
b2Z0LmNvbT4NCj4gVE86IGxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmcNCj4gVE86IEFubmEt
TWFyaWEgQmVobnNlbiA8YW5uYS1tYXJpYUBsaW51dHJvbml4LmRlPg0KPiBUTzogVGhvbWFzIEds
ZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IFRPOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdl
ZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBUTzogTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1h
bm4ub3JnPg0KPiBUTzogSm9oYW4gSGVkYmVyZyA8am9oYW4uaGVkYmVyZ0BnbWFpbC5jb20+DQo+
IFRPOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gVE86
IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmcNCj4gVE86IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gQ0M6IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogRWFzd2FyIEhhcmloYXJhbiA8ZWFoYXJpaGFAbGludXgubWljcm9z
b2Z0LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2h2L2h2X2JhbGxvb24uYyAgfCA5ICsrKysrLS0t
LQ0KPiAgZHJpdmVycy9odi9odl9rdnAuYyAgICAgIHwgNCArKy0tDQo+ICBkcml2ZXJzL2h2L2h2
X3NuYXBzaG90LmMgfCAzICsrLQ0KPiAgZHJpdmVycy9odi92bWJ1c19kcnYuYyAgIHwgMiArLQ0K
PiAgNCBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvaHZfYmFsbG9vbi5jIGIvZHJpdmVycy9odi9odl9i
YWxsb29uLmMNCj4gaW5kZXgNCj4gYzM4ZGNkZmNiOTE0ZGNjMzUxNWJlMTAwY2JhMGJlYjRhM2Y5
Yjk3NS4uYTk5MTEyZTZmMGI4NTM0Y2Y1YzhjOTYzZTM0MzANCj4gMTkwNjFiZDM0ZjYgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvaHYvaHZfYmFsbG9vbi5jDQo+ICsrKyBiL2RyaXZlcnMvaHYvaHZf
YmFsbG9vbi5jDQo+IEBAIC03NTYsNyArNzU2LDcgQEAgc3RhdGljIHZvaWQgaHZfbWVtX2hvdF9h
ZGQodW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBzaXplLA0KPiAgCQkgKiBhZGRp
bmcgc3VjY2VlZGVkLCBpdCBpcyBvayB0byBwcm9jZWVkIGV2ZW4gaWYgdGhlIG1lbW9yeSB3YXMN
Cj4gIAkJICogbm90IG9ubGluZWQgaW4gdGltZS4NCj4gIAkJICovDQo+IC0JCXdhaXRfZm9yX2Nv
bXBsZXRpb25fdGltZW91dCgmZG1fZGV2aWNlLm9sX3dhaXRldmVudCwgNSAqIEhaKTsNCj4gKwkJ
d2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZkbV9kZXZpY2Uub2xfd2FpdGV2ZW50LCBzZWNz
X3RvX2ppZmZpZXMoNSkpOw0KPiAgCQlwb3N0X3N0YXR1cygmZG1fZGV2aWNlKTsNCj4gIAl9DQo+
ICB9DQo+IEBAIC0xMzczLDcgKzEzNzMsOCBAQCBzdGF0aWMgaW50IGRtX3RocmVhZF9mdW5jKHZv
aWQgKmRtX2RldikNCj4gIAlzdHJ1Y3QgaHZfZHlubWVtX2RldmljZSAqZG0gPSBkbV9kZXY7DQo+
IA0KPiAgCXdoaWxlICgha3RocmVhZF9zaG91bGRfc3RvcCgpKSB7DQo+IC0JCXdhaXRfZm9yX2Nv
bXBsZXRpb25faW50ZXJydXB0aWJsZV90aW1lb3V0KCZkbV9kZXZpY2UuY29uZmlnX2V2ZW50LCAx
ICogSFopOw0KPiArCQl3YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVycnVwdGlibGVfdGltZW91dCgm
ZG1fZGV2aWNlLmNvbmZpZ19ldmVudCwNCj4gKwkJCQkJCQkJc2Vjc190b19qaWZmaWVzKDEpKTsN
Cj4gIAkJLyoNCj4gIAkJICogVGhlIGhvc3QgZXhwZWN0cyB1cyB0byBwb3N0IGluZm9ybWF0aW9u
IG9uIHRoZSBtZW1vcnkNCj4gIAkJICogcHJlc3N1cmUgZXZlcnkgc2Vjb25kLg0KPiBAQCAtMTc0
OCw3ICsxNzQ5LDcgQEAgc3RhdGljIGludCBiYWxsb29uX2Nvbm5lY3RfdnNwKHN0cnVjdCBodl9k
ZXZpY2UgKmRldikNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIG91dDsNCj4gDQo+IC0JdCA9IHdh
aXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmZG1fZGV2aWNlLmhvc3RfZXZlbnQsIDUgKiBIWik7
DQo+ICsJdCA9IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmZG1fZGV2aWNlLmhvc3RfZXZl
bnQsIHNlY3NfdG9famlmZmllcyg1KSk7DQo+ICAJaWYgKHQgPT0gMCkgew0KPiAgCQlyZXQgPSAt
RVRJTUVET1VUOw0KPiAgCQlnb3RvIG91dDsNCj4gQEAgLTE4MDYsNyArMTgwNyw3IEBAIHN0YXRp
YyBpbnQgYmFsbG9vbl9jb25uZWN0X3ZzcChzdHJ1Y3QgaHZfZGV2aWNlICpkZXYpDQo+ICAJaWYg
KHJldCkNCj4gIAkJZ290byBvdXQ7DQo+IA0KPiAtCXQgPSB3YWl0X2Zvcl9jb21wbGV0aW9uX3Rp
bWVvdXQoJmRtX2RldmljZS5ob3N0X2V2ZW50LCA1ICogSFopOw0KPiArCXQgPSB3YWl0X2Zvcl9j
b21wbGV0aW9uX3RpbWVvdXQoJmRtX2RldmljZS5ob3N0X2V2ZW50LCBzZWNzX3RvX2ppZmZpZXMo
NSkpOw0KPiAgCWlmICh0ID09IDApIHsNCj4gIAkJcmV0ID0gLUVUSU1FRE9VVDsNCj4gIAkJZ290
byBvdXQ7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h2L2h2X2t2cC5jIGIvZHJpdmVycy9odi9o
dl9rdnAuYw0KPiBpbmRleA0KPiBkMzViNjBjMDYxMTQ4NmM4YzkwOWQyZjhmN2M3MzBmZjkxM2Rm
MzBkLi4yOWUwMTI0N2EwODcwZmRiOWVlYmQ5MmJkZDE2Zg0KPiBkMzcxNDUwMjQwYyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9odi9odl9rdnAuYw0KPiArKysgYi9kcml2ZXJzL2h2L2h2X2t2cC5j
DQo+IEBAIC02NTUsNyArNjU1LDcgQEAgdm9pZCBodl9rdnBfb25jaGFubmVsY2FsbGJhY2sodm9p
ZCAqY29udGV4dCkNCj4gIAkJaWYgKGhvc3RfbmVnb3RpYXRpZWQgPT0gTkVHT19OT1RfU1RBUlRF
RCkgew0KPiAgCQkJaG9zdF9uZWdvdGlhdGllZCA9IE5FR09fSU5fUFJPR1JFU1M7DQo+ICAJCQlz
Y2hlZHVsZV9kZWxheWVkX3dvcmsoJmt2cF9ob3N0X2hhbmRzaGFrZV93b3JrLA0KPiAtCQkJCSAg
ICAgIEhWX1VUSUxfTkVHT19USU1FT1VUICogSFopOw0KPiArCQkJCQkJc2Vjc190b19qaWZmaWVz
KEhWX1VUSUxfTkVHT19USU1FT1VUKSk7DQo+ICAJCX0NCj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4g
QEAgLTcyNCw3ICs3MjQsNyBAQCB2b2lkIGh2X2t2cF9vbmNoYW5uZWxjYWxsYmFjayh2b2lkICpj
b250ZXh0KQ0KPiAgCQkgKi8NCj4gIAkJc2NoZWR1bGVfd29yaygma3ZwX3NlbmRrZXlfd29yayk7
DQo+ICAJCXNjaGVkdWxlX2RlbGF5ZWRfd29yaygma3ZwX3RpbWVvdXRfd29yaywNCj4gLQkJCQkJ
SFZfVVRJTF9USU1FT1VUICogSFopOw0KPiArCQkJCSAgICAgIHNlY3NfdG9famlmZmllcyhIVl9V
VElMX1RJTUVPVVQpKTsNCj4gDQo+ICAJCXJldHVybjsNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2h2L2h2X3NuYXBzaG90LmMgYi9kcml2ZXJzL2h2L2h2X3NuYXBzaG90LmMNCj4gaW5kZXgN
Cj4gMGQyMTg0YmUxNjkxMjU1OWE4Y2ZhNzg0Yzc2MmU2NDE4ZWJkMzI3OS4uODZkODc0ODZlZDQw
YjNjYTlmNjY3NDY1MGU1DQo+IGE4NmE3MTg0ZTJmYTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aHYvaHZfc25hcHNob3QuYw0KPiArKysgYi9kcml2ZXJzL2h2L2h2X3NuYXBzaG90LmMNCj4gQEAg
LTE5Myw3ICsxOTMsOCBAQCBzdGF0aWMgdm9pZCB2c3Nfc2VuZF9vcCh2b2lkKQ0KPiAgCXZzc190
cmFuc2FjdGlvbi5zdGF0ZSA9IEhWVVRJTF9VU0VSU1BBQ0VfUkVROw0KPiANCj4gIAlzY2hlZHVs
ZV9kZWxheWVkX3dvcmsoJnZzc190aW1lb3V0X3dvcmssIG9wID09IFZTU19PUF9GUkVFWkUgPw0K
PiAtCQkJVlNTX0ZSRUVaRV9USU1FT1VUICogSFogOiBIVl9VVElMX1RJTUVPVVQgKiBIWik7DQo+
ICsJCQkJc2Vjc190b19qaWZmaWVzKFZTU19GUkVFWkVfVElNRU9VVCkgOg0KPiArCQkJCXNlY3Nf
dG9famlmZmllcyhIVl9VVElMX1RJTUVPVVQpKTsNCj4gDQo+ICAJcmMgPSBodnV0aWxfdHJhbnNw
b3J0X3NlbmQoaHZ0LCB2c3NfbXNnLCBzaXplb2YoKnZzc19tc2cpLCBOVUxMKTsNCj4gIAlpZiAo
cmMpIHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMgYi9kcml2ZXJzL2h2
L3ZtYnVzX2Rydi5jDQo+IGluZGV4DQo+IDliMTVmN2RhZjUwNTk3NTBlMTdlYTM2MDdiNTJkZWU5
NjdjMWMwNTkuLjdkYjMwODgxZTgzYWQ0YjQwNjQxMzY0MTQxMw0KPiBkNjgzMjlmYzY2M2UyIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvaHYv
dm1idXNfZHJ2LmMNCj4gQEAgLTI1MDcsNyArMjUwNyw3IEBAIHN0YXRpYyBpbnQgdm1idXNfYnVz
X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJdm1idXNfcmVxdWVzdF9vZmZlcnMoKTsN
Cj4gDQo+ICAJaWYgKHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgNCj4gLQkJJnZtYnVzX2Nv
bm5lY3Rpb24ucmVhZHlfZm9yX3Jlc3VtZV9ldmVudCwgMTAgKiBIWikgPT0gMCkNCj4gKwkJJnZt
YnVzX2Nvbm5lY3Rpb24ucmVhZHlfZm9yX3Jlc3VtZV9ldmVudCwgc2Vjc190b19qaWZmaWVzKDEw
KSkgPT0gMCkNCj4gIAkJcHJfZXJyKCJTb21lIHZtYnVzIGRldmljZSBpcyBtaXNzaW5nIGFmdGVy
IHN1c3BlbmRpbmc/XG4iKTsNCj4gDQo+ICAJLyogUmVzZXQgdGhlIGV2ZW50IGZvciB0aGUgbmV4
dCBzdXNwZW5kLiAqLw0KPiANCg0KUmV2aWV3ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51
eEBvdXRsb29rLmNvbT4NCg==

