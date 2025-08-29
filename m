Return-Path: <linux-hyperv+bounces-6668-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F420B3C053
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 18:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D3D1893390
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D5F320389;
	Fri, 29 Aug 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SqxlockI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2076.outbound.protection.outlook.com [40.92.47.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4962B9A8;
	Fri, 29 Aug 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483638; cv=fail; b=Lk2xOxqlMCOHFL8KUtGtgyE2jcMrzCjm2yB0moginwEs5Iwf5ZV7tv/GI1aK18GABgaiKxFSjNlqfG5/fQlA1SEJqHo+zpO3IyLD4ByN8VbRkCBLmuaBWwbHL/B5YrFHDkkXZaEoqQGsPu91D80rr7K6AwMmqN2ZCHxXisRcOL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483638; c=relaxed/simple;
	bh=Z/03JpgHCMZOK0JFw0ryHTt1ias2OaPKGMb+HipGy+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W/9I45pXuwq106glfC576x+CDgG+FailuPRyht3BtYrBAN2I/TrbpNNzyUzVhdDoSZBchV0KlKpJMbEN0lOVih0LUxWQbMsIH6rGFA64p+ajlPeFz6m2dmkTfzdTGgom/B5Jh0wtbTIhyDmSCTOEjDG3SwcpwyP+kgDErjBNIA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SqxlockI; arc=fail smtp.client-ip=40.92.47.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnGe5ZaV5uh6jgyUp+V6GLPqhMquRh7uTs/XIMaMC11S7jAPUkRORNiiXplPRJeo6NELBlbQqf5jk2Z8Fz3UqC+ZzWbjfHxFblnhbnX1m+2TqgFjf9Y43Eta4Xc8djqQyTwK9BebTxQTEU39F9HsiFMfXHb7qfPVxnOOSibJ5v8R9kd9LYogkVLQDAtm3i/yV1lpMxaI3oPdu2XZ+zUEH/rzHuDVUz+/ddltuaYCuwXML4sJpMTtuyLIZFLu/e1EV0V0J5GhYeD3VEFLQ8XptB8YU0xjxIDcd2lKSMacY7wmpAIQsairiBdqjRlYebTpynA0HbRl7Sf9lpdU3imDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04eZpyN0lO9MkxU9sqFBKorSVsGkKJydsECU0b550Yk=;
 b=qi92RBFPZlY8EN2/KglXgAuP3aYtTVSXMw+9LHQh5UEIAt8LxVYgr0ZiRGvr6wf4HgFwuxHb7XUzMSK988GvGvjroEYhzETmN+6OSnpe7nV3HTivJzz34WtzJrVSp2ZpwXkoKOX40xlfVDj6knpsBCZXnXSJXyyclNA9GlghTsrZ7QgwxhOch5uUyzC/VFtugAGh92/4MRDdady/jBWmYbL+26rrrrkRimmsamMpciHF3dCqGJ0rkNJOZlv7l6/8W+k0bpQImTy5dUDA4peMjZWw9AIN9ApJeEI4fr3Y4qvJlGtjZi/HqUoW4cQz/dyR+81Vhdq0IWnOTyOblUzX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04eZpyN0lO9MkxU9sqFBKorSVsGkKJydsECU0b550Yk=;
 b=SqxlockI31Q7WRKJ4gcRiWO5GTQeylJI/TyqZmZoCwUQCqtO/VuzEwmJIczFvcUdozxrYIbwmeohYIhEaStAVtIh0FckrlopUEG4gI0YklEfKowE4L7ozQA7Diyu4B9AWWkU6EtFFg7i76P05KgARF13a1D2vB5SOORewVcQlRqzL+YNCBNA4/laFZcYRBvtc0PJ/pVwO3VDtNsqL+r9Tmiyyrarir/T8Cw6CeKxRU+wzw0OWeB1cEQq1noNvCrmu/26AlINeBdnDCWXJJ0MjuVLY8UxiC/8ckY5udRWWcfCokmjlHzsPjAaQxSEgGqvwWp3/HmxMAw/fBKgmUcDRQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8569.namprd02.prod.outlook.com (2603:10b6:303:159::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Fri, 29 Aug
 2025 16:07:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 16:07:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH v2][next] hyperv: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Thread-Topic: [PATCH v2][next] hyperv: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Thread-Index: AQHcGNpOix28RFOZZk2zj9sE1V34NrR5yENw
Date: Fri, 29 Aug 2025 16:07:12 +0000
Message-ID:
 <SN6PR02MB4157D4C3A66E0563A9071DF1D43AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <aLGSlaa6Llqz7jkJ@kspp>
In-Reply-To: <aLGSlaa6Llqz7jkJ@kspp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8569:EE_
x-ms-office365-filtering-correlation-id: e0855122-0d15-4fc3-3c2e-08dde7161d53
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|13091999003|8062599012|8060799015|15080799012|461199028|31061999003|4302099013|3412199025|51005399003|440099028|40105399003|102099032|1602099012|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?y2B2Z01xSZM4RSGHyx9hf467lg8AOoOGJ7eAh52tlKHDWUJpgNNbw9dGaVZj?=
 =?us-ascii?Q?nE4Wk8b/wOVjymNahimVdifdCrpCdWeT5aTuYHgMJ43CU7FhvOEq9SR6Xzjv?=
 =?us-ascii?Q?elpRYLqv4GhAHRiSS9TVSOiUTm7x9roWkn71SbBbRhUCAmEiguUjunV7trPn?=
 =?us-ascii?Q?F67Co6b+wQLS1xJCcLsTnTqldE55gZe56W5SqYZXluM+mPFmKY+XL6AbdHid?=
 =?us-ascii?Q?5IlNqdx8uyXSeFLSstxEzy+ZW6DyCVbSRW0q5G+CBQKmyvKMrpM26G5tJIKr?=
 =?us-ascii?Q?f7FaWPm6tAMlKjju2dE8QjvwaSA0qEUGwsduGCZ9f4Lc9Y8yhyxF/1faUs02?=
 =?us-ascii?Q?0rJOJCmF5mzZM4PaK2xZbeRjwB3fofxNVA2FuZQWfIO4RE1wWrpIUdcU6W5u?=
 =?us-ascii?Q?I2fuN+h7AP1V5oqvwB54fLrk9SuK1dlrgfxdAg66OJ4p65xcAAsrz7QdP1Tb?=
 =?us-ascii?Q?Wyh/f626kD4F7m6Z9RtxlREp6ehA0F40Y8sGEzYdowt7H2alfUAY86Vo2Z9a?=
 =?us-ascii?Q?WJdx/68wNHS0g6kCDzMvPwcSQZ1ANBy85BK3fwbnGtIRwf0URvajvEgn24S8?=
 =?us-ascii?Q?P+7JWOOdhT/hvrbQkIV/hvesjtjjchX7DNkLWRQzAfFyYX3qdMjEi4xmytSC?=
 =?us-ascii?Q?Bbs4s0Z6k0Sc016zXLYsxAzOi/6pYNYw/Is8PPirDxVeSZ0ppqJzMqTpUfHl?=
 =?us-ascii?Q?UBRrJ/qXCMCqetJmdb29qmhovSBQwrj6gNI2R0EuFvNHLuj6VcwPihNL7Wws?=
 =?us-ascii?Q?XTYeqA5yISmneU0+KM8NPSrwj0I8AsCJ5U48+SE56YJ8Qa4pL1CvFURnJOyk?=
 =?us-ascii?Q?uLgEZL6+Xxg3usiGy5TSzgINpRDV11AxWJKPiwe5dZqcemXBodrQpNV9sg+7?=
 =?us-ascii?Q?6vu+piAnW+6KcIsVPEjyfA+GUvbg9qpt5KDp6UWRV1LtjGsWIoRymrQEQgjg?=
 =?us-ascii?Q?ZGFhEHrGIIqcjwUlsn2a0FPNx/fpaLJ6IvVbkWUhLcBjx+Y+I/v76c1onR7l?=
 =?us-ascii?Q?ZNFB/6OuuRNe1CU5Opud9pcKSIDZ99DMriYh+AVd4nDVll+GDin3A0kqq0y1?=
 =?us-ascii?Q?Tcskb0tvIvUPgC5iVIFXzNFuJdVnDIOD/g8NkHmsz8RUZEuBiiBLlzl5U2Fp?=
 =?us-ascii?Q?8EGaGwItvk2mA72+8FqyFnCFhvilv0HrwV+iTbbvhD7uu8g/d4pzlOWVz1qB?=
 =?us-ascii?Q?16yGR08iTbxauxBbGzP+cKk5s0+0uci4NcXHhIUVrNCXp5La+MtjTzCrQeF8?=
 =?us-ascii?Q?8dHMmEox0AEmpB5E84IYbwQY5q23RkEGzckrzXF07xBzCS4sqVmBJ8XBYX3/?=
 =?us-ascii?Q?9mugoBmYEW5qaAwS22JWUz57WSuv9+l7woUOSeDbzmTspw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ObzZpYAimA6rc/H1Ni7IH8zI3s8mZmZk+nr+jvbu9WF328ta7r7wRkD0xxLv?=
 =?us-ascii?Q?YxnNkQ3rUqFh7wLvOw7UTBDg2Dxjb7A3Gw6KJJ211WPcYKA8MQ2QmK+y/9dU?=
 =?us-ascii?Q?TvjXdI+mnV+pFRTK1P4jafJD9BXXgDVtsGF52Bk5afVvPHA7IQ1ARKcf0yXL?=
 =?us-ascii?Q?1eU466+Szwel+nJM/YNZUTJ/FuKLahbpnDIZI2Xic0YesuF9mNJBLcDnieqL?=
 =?us-ascii?Q?pAvBT6O/5lTqw8moq5GLOqMBGz5zm0WMGtjilyzIfu3sQxak+ZOOyCFqAoic?=
 =?us-ascii?Q?t+6s6TdxkN8fkq8xvWiHWpm0SS9fXIeTDjx6fU7qZA1b33Y2l6AheYTPlqEF?=
 =?us-ascii?Q?VybqHRJR/YfswLUPvtI+ctaBmxsUuj9PbEp2u0dyvO1Ndhl08vkl49J3f6LK?=
 =?us-ascii?Q?xux7VZLOwUSx513rlCMtMeytdxa/6GXHLzNCA7vBD3qrC5P/xr2MppNAW7BU?=
 =?us-ascii?Q?VD8r2QIpj5NKXYBiSrnAAWpU+LwcB10NV0SksZU9mfNu4VY2FNeKDQCi1BjB?=
 =?us-ascii?Q?xxzuygir5A70juIbzhZhgXW254EEF8TRTpwoGmCCQRIT6Nyeld9U8OiY8xDo?=
 =?us-ascii?Q?9L7D6sW5XUOQPfEyczjrsAXQwxIkZWAvgtIJMPri5M0otJ1nhCJcVdKbFgAQ?=
 =?us-ascii?Q?7Izyr0v9bIxTB9KzS8VuKrH9PiHaoOzwYCSaLQzoFvQb5IdTDQrpKlj3CPZN?=
 =?us-ascii?Q?TzdyaFxixI3BjI6lh+FAwZov3sFK0bVR4m4RgJ1a9kZQxx5RayJqjHpnU7KX?=
 =?us-ascii?Q?y/YbuRk8vH9n5T+ezx9NA/MaqgUnxTQgsmkWYdhTZ1RIPgblwhntZE5b2R4d?=
 =?us-ascii?Q?nWjH69qmD/wYu5KgmMDCa+B9Vo5hrq5W234sNYCKTQwV7yBsYKFcRkVVpOZE?=
 =?us-ascii?Q?PNdNqx5/KqjhMKNcVhWpDI4Ekl2Z6gPeK92FWeu7Ktub3gspdM3gQzXNdUD+?=
 =?us-ascii?Q?4K14/7sVMgwat7w2sLpLkxih5jHrGDkfwCZVqCNVnFD8KARVDLrnNRRZ7a7G?=
 =?us-ascii?Q?quRNO2q+2wCQ94KjmYO2DHkPMCdZzgvz7WUwoKGUjkHY6SUTQJ+pF9MXFvRr?=
 =?us-ascii?Q?5Q40gWI34PX8l8hHKbvbNbzLI15hudJP7AfIT8b+EzvHe2nQ5yATypEpWBVD?=
 =?us-ascii?Q?MRyyt3UCuoONEoXjTbOi8/anl4kN9mlm/CA9bkis5Y/ZFd5GEvJPwizpN/vB?=
 =?us-ascii?Q?pWGZnYqnIoiIZyFZL/6jDjhZcPH3SeoHuXzlBDoONHC+OE+OBt4DVVP9Esc?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0855122-0d15-4fc3-3c2e-08dde7161d53
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 16:07:12.3345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8569

From: Gustavo A. R. Silva <gustavoars@kernel.org> Sent: Friday, August 29, =
2025 4:44 AM
>=20
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>=20
> Use the new TRAILING_OVERLAP() helper to fix 159 of the following type
> of warnings:
>=20
>     159 ./include/linux/hyperv.h:711:38: warning: structure containing a =
flexible array
> member is not at the end of another structure [-Wflex-array-member-not-at=
-end]
>=20
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it. This overlays
> the trailing members onto the FAM while preserving the original
> memory layout.
>=20
> Also, move `struct vmbus_close_msg close_msg;` at the end of
> `struct vmbus_channel`, as `struct vmbus_channel_msginfo,` ends
> in a flexible array member.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> --
> Changes in v2:
>  - Fix subject line.
>=20
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/aLGSDpi4xDjUUYVm@kspp/
>=20
>  include/linux/hyperv.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index a59c5c3e95fb..efdd570669fa 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -708,8 +708,9 @@ struct vmbus_channel_msginfo {
>  };
>=20
>  struct vmbus_close_msg {
> -	struct vmbus_channel_msginfo info;

It turns out that this field of struct vmbus_close_msg is never used.
It dates back to 2011, so maybe somewhere along the way it stopped
being used, but struct vmbus_close_msg was left unchanged.

So a better solution to the "flex-array-member-not-at-end" issue is
to eliminate this structure entirely, and use struct
vmbus_channel_close_channel directly in the one place where
struct vmbus_close_msg is currently used. I've done a quick test of
this change and I don't see any problems.

I'll submit a separate patch with my proposed change, and this
patch can be dropped. Does that work?

Michael


> -	struct vmbus_channel_close_channel msg;
> +	TRAILING_OVERLAP(struct vmbus_channel_msginfo, info, msg,
> +		struct vmbus_channel_close_channel msg;
> +	);
>  };
>=20
>  enum vmbus_device_type {
> @@ -800,8 +801,6 @@ struct vmbus_channel {
>  	struct hv_ring_buffer_info outbound;	/* send to parent */
>  	struct hv_ring_buffer_info inbound;	/* receive from parent */
>=20
> -	struct vmbus_close_msg close_msg;
> -
>  	/* Statistics */
>  	u64	interrupts;	/* Host to Guest interrupts */
>  	u64	sig_events;	/* Guest to Host events */
> @@ -1008,6 +1007,9 @@ struct vmbus_channel {
>=20
>  	/* boolean to control visibility of sysfs for ring buffer */
>  	bool ring_sysfs_visible;
> +
> +	/* Must be last --ends in a flexible-array member. */
> +	struct vmbus_close_msg close_msg;
>  };
>=20
>  #define lock_requestor(channel, flags)					\
> --
> 2.43.0
>=20


