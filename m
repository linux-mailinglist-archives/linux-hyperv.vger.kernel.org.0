Return-Path: <linux-hyperv+bounces-8092-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D05C9CE89E1
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 04:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E6AC3001E1B
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 03:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88B11607A4;
	Tue, 30 Dec 2025 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BSBfu4mL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011070.outbound.protection.outlook.com [52.103.23.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D82D6E78;
	Tue, 30 Dec 2025 03:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767063864; cv=fail; b=Lk3teKZcrVAh/2tw+OAkcLUTR0KXvqHGflXIVs6cxouUN8NiT6+hGKWOulVtSWMTsW5QoO9OBoPv4lbcUvaixk2sVgmDJP+0Fw6Xreu4vM2Vx3x0v5TJxT+TvY7h6bnLqq4ePpUxu9lQS+5t7ebzrdoCx3ni6AJ4bs9d/9XZTzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767063864; c=relaxed/simple;
	bh=mF+J/24hlhzJhbI+IVH/4no16uBVh5tAF8egHDjhibk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MAJvBtCydVkfd/EgQIs5/Yf7jVLawsQkI3Y89oiVWYHLyC8RduNJ1PGGR4OZpsfFmmBe+XYzvUuyTUPmlMfJXSBqN0kJnbTUXmxHX7onMUK1G+GbVqMiM80LLRzce4f1Ou58NENau3IJ17jpejWeGo8yx+bIxuN234Luv6+4gW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BSBfu4mL; arc=fail smtp.client-ip=52.103.23.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l++cWxqBnWpvKHDNOb1gYKW4JYfjLE1swcN5RroYvqKh1wZJGXtEOMEZVPZyyDHYNFeI7pxehyk1k1CnivV0BmFdyd+aM9cnc/KLRzy+7bAA5jMEi3nF2p3cdQaGyREvdxOg8vb1Pvf6sXPOtfvKeCoytwFnT9SwkNehVVbFdDB39b5XY03qXI79/oWvc+2ochSPgeaSTEQixYWWFYZs9FIwFsK2Nd++JbRYcvvB8bv6H3ln082knuyxumm1+XNauK15d7YwzDQbtndGdtKdX8iLEeWZIDvJbi8k67oPPql4tIzC7NmtGm9n5UVz4sjW+XKcRhd9aEEHCx/aPsdb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMTKPwOLlNOmcQissHwV49+nSoOTSwoEyj1uiU/Oh0s=;
 b=ApARQ15XO/Yivj2ZhwUOkPoY9pJQQwgqF5jdbpdEgDz2CSivC3/RSziM5/7Uf7Eb7O64RIWnt9vX56z94W7ZhTBLixL4B6zm3wq/TLLF0XjsBQ2h8qWSKDzJCAnCZQcRunXZf+XXfXi1PELCYFyw2gFEQEFjNlG87uEt5cr6+dOgbIu3WqiMM0s1IFa0qOB1ILUUQAU1Plk4K8KofcYTl0Xv6mLH6CxglClDnVt1JQ1m5A1WYft4u5+Wi1BrpBnPh6k95UgdiqyJdCclPJlWkrHyhxqrDNDYCzIrW7K0tinJGmLyZlq2brKEmFdsDb1j1KrCLyfkGUs4hTE23hxWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMTKPwOLlNOmcQissHwV49+nSoOTSwoEyj1uiU/Oh0s=;
 b=BSBfu4mLEOc905gjT+sXhPCD/m4WFQgksYtQFh5Tee25hBxXVx180K9K4op4VQe2W80mRiq1UbwII24dghQ8wQ255L59fd205vHeNWrBXaQczVbpi4+AOU8FUdB6v+9UWGuWx5kf7Ss9zLXuo5gZWN0TiOFsMldXrTFST9OBAnHLi5TAjOy8tl9qtM7y1m8D+POrXbjD9S+CpWtQyyU5TJ8vN5OJt+t8eaWVamIT6SvW6LcTOJtRdstaggRdNujb+ZJl5SpKkiV+su9a+j8t2RM7o1GvRTk6UucLPmWerEVg1I5z6xaNYyu7KbMxHPZZYW3so0c8lwo5wDCeX/BqBA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9570.namprd02.prod.outlook.com (2603:10b6:8:f2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.14; Tue, 30 Dec 2025 03:04:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 03:04:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "vdso@mailbox.org" <vdso@mailbox.org>, "mhkelley58@gmail.com"
	<mhkelley58@gmail.com>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
Subject: RE: [PATCH 1/1] Drivers: hv: Fix uninit'ed variable in hv_msg_dump()
 if CONFIG_PRINTK not set
Thread-Topic: [PATCH 1/1] Drivers: hv: Fix uninit'ed variable in hv_msg_dump()
 if CONFIG_PRINTK not set
Thread-Index: AQHccQSCpYnwovAUE0yn4gaYWmR63LU4EIEAgAF4c2A=
Date: Tue, 30 Dec 2025 03:04:20 +0000
Message-ID:
 <SN6PR02MB4157065BCB5064B3587F9E4AD4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251219160832.1628-1-mhklinux@outlook.com>
 <21281086.36492.1766981516854@app.mailbox.org>
In-Reply-To: <21281086.36492.1766981516854@app.mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9570:EE_
x-ms-office365-filtering-correlation-id: c54d9701-97ac-4798-180b-08de475020bb
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|19110799012|461199028|31061999003|8062599012|15080799012|13091999003|41001999006|51005399006|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y+YEcMTajZ6lsp0+3/0MeB695wHnTtfHGTMRyH86v8OZvepo06lbfdJPTh6r?=
 =?us-ascii?Q?5D3qGcbqDuSUKC6g4DVOqmX1pTFHr99D5xlNuEee/jzvCUzlmup57Spdpqyr?=
 =?us-ascii?Q?llqpOgWfKrQQeFEJ5DXAs8q4yE4RiJdPHX+e2BJMLw9E1vbfh3bcgEFkohdK?=
 =?us-ascii?Q?g3ETJS8p1wEAB3XZH7zXo2H3t831dGcmBF1pqOqmouB+gwz1+5trL3520yx1?=
 =?us-ascii?Q?aQR2Zq6mnfUSXza3vwzAl3UpY3CFEPUG8QdQGZNikfEhyhdWaJQ7ZtcTPOwr?=
 =?us-ascii?Q?XbBS/HN5ymFZxsF84787u0QoIGCJdMp6Ca1+82coR+HYDil/WetkTE11ItEH?=
 =?us-ascii?Q?hSsMccOn9fkVVmGWk+MIyMtKXC8mmR30ApogyqWHU6DiCaE3EHlKHRx9fWRm?=
 =?us-ascii?Q?oy3qFxwhCeU9Km7QSp6zjV5aOClVunh/WKNSec9yH6zFuCkzDJLHGnB5X4N9?=
 =?us-ascii?Q?XkK7hv/4V6Z0x0rPljlh+fhtQHnDp7vym/nO+BwA3PP8rnzw0xXFshqxCnCH?=
 =?us-ascii?Q?Dylb7yYx8EZHZaaRnfEmnlVLfOT1GqdjEuF/4YlsImG3RHcDMV1P1IzPm1T8?=
 =?us-ascii?Q?OI6MbQO52Qa/G162Cw+lG+48m5chZmCFC0S1Cb/hUFUT45F6yuVc9sPOrYCj?=
 =?us-ascii?Q?AD0t0LybAc4uJyZ4OwFoDU0Brq6GaDQWsvven+H42vYt4W/64xx96smji/3H?=
 =?us-ascii?Q?F/kEBKGJK6KINbGB1tjnzi52SgoGjjb31a+JUFz06GxxDIonHZ0Y4LN3BJrK?=
 =?us-ascii?Q?hbUeD3uJSFNnUTSxT8FYgCeZMI3pxpGU6RFTq0A4Wr7qedOfvhjUMMI7ePE0?=
 =?us-ascii?Q?fD6MpMpTWOPaZ9a7UGUeRuK4+HI/2+m2rR+LstOlulvNgvoXhgpnEews9U12?=
 =?us-ascii?Q?ddHL39VUW47UxoZzgT9G5jQXXne/6ajENLu0tREkuXFqPm0LWghJwAHUvd0x?=
 =?us-ascii?Q?1++c9/GCQIaWfT5/UvZQjTgsQE/GnMf5RBWvhO7t0qoMhOmRGJdp6MrR98BR?=
 =?us-ascii?Q?1POC8r8vYyokHeX/lHfpF80c6u0Nk00aLKyfNeUtW5+PYP0c4hZmuZju9vUS?=
 =?us-ascii?Q?30YcaozC/IbTOvleYcoaUCk0DDtZu3JZtmffx/Fws0TFLvy6jA6xa0cjzR94?=
 =?us-ascii?Q?NZSjaRtdAgeJfBNljLgKqPoJyKRYxnyYt5U6NenwSVWUUlQQuBKD/G73aCQs?=
 =?us-ascii?Q?5Frutk+h7NH0TPlgdrbMnrPuVsAuALNbi8eglWErwriaomI72xsQOabqCI4?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?e76Yh9sYjqiY5FMo2MLwB5kX85PVNw3s1BSVjMjuwoC+6umLPMnX0M+AYJiS?=
 =?us-ascii?Q?patYreP/4feqHzFsoMOsaFFk9V9q2W4LV5Ug1Rl085iQVdsJJhSVDcOvyVw1?=
 =?us-ascii?Q?VQwZL10u6h39lwxKV97A8FwQxAzzKGcDdms8QKjMM28aj/VbeFvuzuBAlCY2?=
 =?us-ascii?Q?ogbgXe0wQoTGjimON/CAsGZm3TyR+qws8Bp6ZvXWJcWhKQuE5Ohsa0U72PQy?=
 =?us-ascii?Q?TnBq24Bhysyvar6H1Nj6DPrhu8Ina5cvx20Z2tHIjZkNkfQOQStpYWHjqJE1?=
 =?us-ascii?Q?vhhJUVXcxJBMj7EVvslN8XiIpUQbOzbN0+s3gWPqht2yY0wLhHNgn3iZRDMv?=
 =?us-ascii?Q?COGbT/0lCmVc9lhfwYLaWh3xWPUSoipUgHbdYwhP/HTGwXa3mJFh4NAv7sfK?=
 =?us-ascii?Q?mGl0lcuOsBRJtdinwaaFy1/e/rwT+Cfke3duv/Ve0d/rGT2wmUAsUgQq/Qrc?=
 =?us-ascii?Q?SpiiAPCGOY7UaRqHxPUxLheGVXeMR7PMQHTd/jSBYWVKHOBudzu1vpKllH3N?=
 =?us-ascii?Q?JP4ibV2uR7P9wCGGjujmiFM9FqKua8YG0wg+eSWcitoOYGTug3xlBQAzVwih?=
 =?us-ascii?Q?HB0PhRxe59w/5ZHwVgkHub0xPE8mmB38sb0E3tCVwgghGrZpbG2WFrF2zEhq?=
 =?us-ascii?Q?VSt7wSnyQ8obWF1iCR7uJVxfuBPa4J5sy6f1Kp5UvdWt9GC72wwr6WDRHmVK?=
 =?us-ascii?Q?Hz3QSMp4qIN52TrvrGU5NQoRqydne2ShGghv9oIKjQnYsVugiqmFD/jnvEWw?=
 =?us-ascii?Q?c5TZ0tlOgOqRBVmGbNWCVM3HTQu1h1ONOSNl5f8UJgVEvio13jDvidpLggH0?=
 =?us-ascii?Q?GFn80kV3z7z6rIEq9hUqpl9ppqX4tAqxqghwyfylDvoe8uflkijNgfsnlMux?=
 =?us-ascii?Q?Xx2+bDYWAYzxxeSzavodrMgdI4/H+UbwrY98MGZ6gb9KhR3pDC8I270WeO1/?=
 =?us-ascii?Q?vHOgOytjsjoSAtv9QZvt7hKsDgH72nqg2+cvV34kbUREoRbI6HP64w7x0cUX?=
 =?us-ascii?Q?6FDg2peAEjR/0KgSAUYaTVmoJoUaqVREm8Pf/nSV9kWu0h32DY1FSg13Xg7P?=
 =?us-ascii?Q?jffimr3tUpewf52nqy5+ZTnlopq/bOeF4UifLIHGqLrM4rPxvAzKgFuT9fl/?=
 =?us-ascii?Q?CgcJLM6upjIbz7PXxz87zZ0PtfMiBUoz3HPTxSkmlcBic8YuMO2XweEDMimu?=
 =?us-ascii?Q?UYbr0Qsegwl8qntKTfOpMBpSlPEyimugMzkYch4L8viKDdqj5o41ez5om0P3?=
 =?us-ascii?Q?H3KYKvXsXL2WZcLdbTGvobDVk60G+HAQKtGtuHuC4wuWqoSR3kASUKehuwqY?=
 =?us-ascii?Q?5yBrg7YYFgVsqhmsTyshjk6FrYNqKDS2UfStxs4bS7Wfedt3m8CKKC7vJiLQ?=
 =?us-ascii?Q?zAb8lUE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c54d9701-97ac-4798-180b-08de475020bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 03:04:20.4767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9570

From: vdso@mailbox.org <vdso@mailbox.org> Sent: Sunday, December 28, 2025 8=
:12 PM
>=20
> > On 12/19/2025 8:08 AM  mhkelley58@gmail.com wrote:

[snip]

> > @@ -198,9 +199,9 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper=
,
> >  	 * be single-threaded.
> >  	 */
> >  	kmsg_dump_rewind(&iter);
> > -	kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
> > -			     &bytes_written);
> > -	if (!bytes_written)
> > +	ret =3D kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE=
_SIZE,
> > +				   &bytes_written);
> > +	if (!ret || !bytes_written)
> >  		return;
> >  	/*
> >  	 * P3 to contain the physical address of the panic page & P4 to
>=20
> The existing code
>=20
> 1. doesn't care about the return value from kmsg_dump_get_buffer.
>    The return value wouldn't make the function return before, why does th=
at
>    need to change?

The existing code depends on the implementation of kmsg_dump_get_buffer()
always setting bytes_written, even if it fails. That's atypical behavior, b=
ut it is
what kmsg_dump_get_buffer() does -- except that if CONFIG_PRINTK=3Dn, the
stub kmsg_dump_get_buffer() does *not* do that. Testing the return value is
the more typical pattern, and bytes_written should be used only if the retu=
rn
value indicates success. So that's why I proposed this change, instead of j=
ust
initializing bytes_written to zero when it is defined. My proposed change
makes the overall pattern more typical, and would work if the implementatio=
n
of kmsg_dump_get_buffer() should ever change to not set bytes_written in
some error case.

>=20
> 2. returns early when there are no bytes written.
>    I think it shouldn't as otherwise the crash control register isn't wri=
tten to,
>    and the panic isn't signalled to the host. Is there another path maybe=
 that
>    I'm not noticing?

You make an excellent point. I didn't even think about the possibility of t=
he
current logic being wrong. There is hyperv_report_panic(), but it is not ca=
lled
if hv_panic_page is allocated, in order to avoid duplicate reports. I agree=
 that
this code should go ahead and send the panic report even if there's no
message data. And in that case the discussion about testing the return valu=
e
from kmsg_dump_get_buffer() is moot.

I'll submit a new patch to change the behavior to send the panic report to
the host even if the message length is zero. I did a quick test of that cas=
e,
and it behaves like the case where HV_CRASH_CTL_CRASH_NOTIFY_MSG
is not set, which is fine.

I'll submit a new version of the patch focused on submitting the panic
report to the hypervisor even if the message size is zero. Avoiding the
uninitialized bytes_written will fall out of that change.

See a comment below in your suggested patch.

>=20
> That said, would it make sense to you the patch be something similar to:
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 0a3ab7efed46..20e4a9a13b32 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -188,6 +188,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
>  {
>         struct kmsg_dump_iter iter;
>         size_t bytes_written;
> +       bool ret;
>=20
>         /* We are only interested in panics. */
>         if (detail->reason !=3D KMSG_DUMP_PANIC || !sysctl_record_panic_m=
sg)
> @@ -197,11 +198,16 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper=
,
>          * Write dump contents to the page. No need to synchronize; panic=
 should
>          * be single-threaded.
>          */
> +       bytes_written =3D 0;
>         kmsg_dump_rewind(&iter);
> -       kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZ=
E,
> +       ret =3D kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_=
PAGE_SIZE,
>                              &bytes_written);

Ignoring the return value can be made explicit as:

 +       (void)kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAG=
E_SIZE,
                              &bytes_written);

Plus an appropriate comment. Then there's no need to introduce the "ret" lo=
cal
variable and the somewhat funky:

	(void) ret;

Michael

> -       if (!bytes_written)
> -               return;
> +       /*
> +        * Whether there is more data available or not, send what has bee=
n captured
> +        * to the host. Ignore the return value.
> +        */
> +       (void) ret;
> +
>         /*
>          * P3 to contain the physical address of the panic page & P4 to
>          * contain the size of the panic data in that page. Rest of the
> @@ -210,7 +216,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
>         hv_set_msr(HV_MSR_CRASH_P0, 0);
>         hv_set_msr(HV_MSR_CRASH_P1, 0);
>         hv_set_msr(HV_MSR_CRASH_P2, 0);
> -       hv_set_msr(HV_MSR_CRASH_P3, virt_to_phys(hv_panic_page));
> +       hv_set_msr(HV_MSR_CRASH_P3, bytes_written ? virt_to_phys(hv_panic=
_page) : NULL);
>         hv_set_msr(HV_MSR_CRASH_P4, bytes_written);
>=20
>         /*
>=20
> --
> Cheers,
> Roman
>=20
> > --
> > 2.25.1

