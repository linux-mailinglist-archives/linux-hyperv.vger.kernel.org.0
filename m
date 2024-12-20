Return-Path: <linux-hyperv+bounces-3513-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 354659F89EF
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Dec 2024 03:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FB6188F006
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Dec 2024 02:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADB918C31;
	Fri, 20 Dec 2024 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="R696gDKt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2054.outbound.protection.outlook.com [40.92.41.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389221862A;
	Fri, 20 Dec 2024 02:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734660118; cv=fail; b=mcnwlHtNfX+A4d6wJCEOinmirTxEeRvDgVoBXu8ikjukgNRpFe5sqU7noegI0btOlfsdEv9ISijOtoy6CPEmGwUUbOVUgJMe0duk1FhMtZwoN4fYe4Ruvq69DV4fT/tUqL2ELeFRnbSPTeOjvzIQP9qEqH8BeFtEC+v6RT5amAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734660118; c=relaxed/simple;
	bh=lRoq9i7MtI5x+ui8gdyZQ3fxiep2G9KRS/uXvZJBJLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bVU9W+jLfMSay9p+S53fmY2tQSY4EXPpbAz15QN6UMgL2cxPgfAs8snqVPK8/v2bB6eiqVgyKiAYIOnno9XzceJPx3sVLzUudBXW1q+QZSGjVDnyezgHBHGZMxSNmBk0JCpoy4td6uNb5Bp1OJjPTF2OG9UGTqkQqApNghYeOKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=R696gDKt; arc=fail smtp.client-ip=40.92.41.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXaPZn5RBVp/RRinEbRM598KHJHniKMM/LDTGOA4gL4bVbvjdkVtRDPa6UP1TVpJ3q4R9+EZLVl26Li39cwo7N7XwvrnXfylhhBi1PD2rVKHcMTToj85CnuySsiwct+YyDA9fVc376HYlChI4XPNoWtmfJUcOJmXkg3fj95mqYg8QhojkhN9zipP4ep9WB3spbAFHAFnPyovJFmboKW4fHwf3jaWnxmbmwfjMU8abqkkyy9hoayfRdjX6T/A2iR87xYsFjkYkNxjYE9GX0Yt7blGLfKybHTuj4uD0FVBrwMXvLPyZc4B+dbekJr1fFvRZp/uVDvF0JbjRrHrK0Y1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyjlBqbQBT4olpyrkqgBn3K1W8DJXE0z6HgECPaj9rE=;
 b=yAZkhA02LTT1Pmut6GKoYamG/poKnK2WmSoEe1bFNeXkHkZV0HWYNGbvSkmRxCL3N+gvcDY+dvN4p0NgBIMHeTGYWtih21tPGkOqVe89qJAJysBJsuOpi+ErDoh86iaDfeDkaUlCB1ekMtZ3sNG/IZNJs7+KXYtENSXBIdEx+PoLFyP/ZumXIXyasGPBKalIi4V/5oesqqsCWGD6s7a1iB2Wu/FjnpACUEcuGlC/JIwQwa9IeZdXG7PTp6X2gZlbBm8Fqqe+NeXv30u8F5wSt6UQ5Sn+lZNzCV0EhRRD2mA+GMfP0RUqhlp0ouV7pVsXUkRmf4unT9AYLWsm/SJK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyjlBqbQBT4olpyrkqgBn3K1W8DJXE0z6HgECPaj9rE=;
 b=R696gDKtAR/ax7D9nn2yeEg1Femgg7ax3kHxvgso3XjiayRb/i+zPVpka/9/HxNjAYsrn+6dZ+IlLC2/NJpYRDmdU07vDs0wyIizbW8d3I4QQn4b/DP8Bt/EMm2Ugl5q7f7Gzl5UapGCSbAp6rl1p4fUIvQa8Y3T/fqlr8JOeaZtnnsKCX9mXJhTL030X3fW07+fnMAxEU28nJD/yqeO+YcF2rhd+E8pUltuL1moPaDrxGH+55k06xm8++p8gc7EPXsXgzf4zPPEd47NUPTMMnrjNTsvMZ79OB7Jiyqa8L/nIZOvJPQpOnLOvS9OatUMTCNGfRa/NIH0TAyTvYgfrg==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SJ0PR02MB7229.namprd02.prod.outlook.com (2603:10b6:a03:298::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 02:01:52 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 02:01:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "tiala@microsoft.com" <tiala@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "apais@microsoft.com"
	<apais@microsoft.com>, "benhill@microsoft.com" <benhill@microsoft.com>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>, "sunilmut@microsoft.com"
	<sunilmut@microsoft.com>, "vdso@hexbites.dev" <vdso@hexbites.dev>
Subject: RE: [PATCH 2/2] hyperv: Do not overlap the input and output hypercall
 areas in get_vtl(void)
Thread-Topic: [PATCH 2/2] hyperv: Do not overlap the input and output
 hypercall areas in get_vtl(void)
Thread-Index: AQHbUY8FyS1mz+ZwyUeCSpyj1Xg2I7Ls3DWAgAEFqICAAC/HYIAAKaUAgAAX9gA=
Date: Fri, 20 Dec 2024 02:01:51 +0000
Message-ID:
 <BN7PR02MB41482EDAA9CD96EF2ECE6532D4072@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-3-romank@linux.microsoft.com>
 <Z2OIHRF-cJ92IBv2@liuwe-devbox-debian-v2>
 <8da58247-87df-4250-820a-758ea8e00bbb@linux.microsoft.com>
 <SN6PR02MB4157DD7CE09E39C524775168D4062@SN6PR02MB4157.namprd02.prod.outlook.com>
 <d8c4613a-33b6-4aa6-a3ae-7c888ab2d727@linux.microsoft.com>
In-Reply-To: <d8c4613a-33b6-4aa6-a3ae-7c888ab2d727@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SJ0PR02MB7229:EE_
x-ms-office365-filtering-correlation-id: 52521ad9-f86d-4f2d-116e-08dd209a4585
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8062599003|8060799006|461199028|19110799003|10035399004|440099028|3412199025|4302099013|102099032|56899033|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AT0hJGPWCYtYUPRgNjQ0yvmX2AHOr4FX3JFwbY80y4ukqHscHKaXJZOju5rJ?=
 =?us-ascii?Q?xaJ7WKaKIgyTWOPHQu04uxXBIYwqgM6QpSfhg6RUqBfbNBPsnAPB83wSgW3K?=
 =?us-ascii?Q?+chbXPhnhME/mwuKD70mKV99BTuIWK91ZEsDMQzBuWbvBBPecZ4jxH/0lcAZ?=
 =?us-ascii?Q?b/RdJWtTLasN/YWBa8RLEMqpBAfXVMGtd0hCHUnnaFhdBCkYR2FXAxZIb0E+?=
 =?us-ascii?Q?GL7h5EIDe0YzfEOA0lQJLA3+8h3KzgVOmYoTuXdX+je02j4pkDnwFNxVra7n?=
 =?us-ascii?Q?KNRCw4+tTzVWfWXdI9f6+XYx1a2QMdt+/Er+7McB25oyKDJ8VMlY7ifPOW4X?=
 =?us-ascii?Q?uEBYci430EtISd+OHzPANU8UGz8iHehoLsFLT6yuz28FPlgVsrsdgMVBJKAs?=
 =?us-ascii?Q?x1eEYmGEXcpj2GECwlWfTEoycRImvzRizXKi2FaYmgOKs/CZahH8sQwcAjOf?=
 =?us-ascii?Q?r90X+qlDoWx3P0ikYb22NEqDXB2rVKnGJ0CcNTdSrLZqXpMOtpwNod1q/6lg?=
 =?us-ascii?Q?pqBIaQF/bU9dkSLyK/T4Ibh2AAb3VfsT7UDJ//kPrb30jzsHycNjs0LxFpnI?=
 =?us-ascii?Q?NQ03W8YkxtrbtSIGTB2Kbs9TQthub4aU7O9YfII1dt5T6ckVWSvpEhGoYmkT?=
 =?us-ascii?Q?lvCr0vKmPlullF25qwEbJE0JyGHHfH5VYME1PrL9XwXra69YikVXseVTOJCi?=
 =?us-ascii?Q?PpKNyTIqwA4QhWhe5t4GJd/eNoq/2kMyJsGUHlIDwCosIK9yjCo8M2LcyyGb?=
 =?us-ascii?Q?OR43zerDYbXBtS9t6dVkQfpbFCi5qyeBj6jskPVClgLOnwfWxgDv2FFBt6RO?=
 =?us-ascii?Q?RuzXidmXgj2Bayr99JLkgl0vSzPpcNyuefIPL7L/E5mI3EG3qsdpxyxPqL6l?=
 =?us-ascii?Q?mezdJz4RD+WS6TlVkdAj6Y4bfIplRz36HDNYxl4lGCUMHOOM6Y2CayZmvx+e?=
 =?us-ascii?Q?U3DTceYr8nXu0HJu17ifA6SF0zPqdyyYuXqk6wPa6SVR/+SGFwX29R6qH03I?=
 =?us-ascii?Q?mmNDmnqAZSrqSXwHPO8OC8HKNO6H4sqXsq2YcXpeA5w93IiRZj4nNMLt3CJr?=
 =?us-ascii?Q?QzLSQ5VcVbB5SbPnXjfVmIzgjYWk9+oikYtvD6k9g3eUaMqLENdkkLf5HRo9?=
 =?us-ascii?Q?XftuASzUw2lWSS3nCM9lqHeDNrXPaDvySfFBa9AVJNY0aRNbouMKyhI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?l3BbnYHQk5j+2Mc9gCJTDi+zYlDOIkTK3UW0k9VncoYE+LmbCsUebfVR35py?=
 =?us-ascii?Q?mFCxrpf/vV3V2Ass9QdxEg8W7G2MG3jap03bC2LKZYXe4J26j+Ac3pTaekWe?=
 =?us-ascii?Q?PgEuZhSQmdxWaZmP6AgeV+Ip8YgIy/BdSX+PQrnzrAUAHdSb8481zVrOYEY0?=
 =?us-ascii?Q?TrTkmI6tH9428P8IWUspHEbalpEt88i15G9HKSde60+cRgQlIlhV9lTvDWHm?=
 =?us-ascii?Q?hbntwOiLe1DLyJQjaQb3IVaeQWiEfCkULYS0XEsXZP53+Y+XDK2KCG9zyWuB?=
 =?us-ascii?Q?zx5Qq3fxLYkGkKVshfMmAst7MCTs3vzw5+d+5jcHcwuYxIAKnpDnIf+tdvNe?=
 =?us-ascii?Q?4I2cwY6ifmmZvipM+VEfztdeuR0AFxpLkn5ipQ6DyGJIjY7klmkwT+E7HD2M?=
 =?us-ascii?Q?yzTB8PAelVeHIVJKSPmE8w66p80ZTlKrns2Y95IHh9LC12LqJfOkZUIKWqC3?=
 =?us-ascii?Q?rQQgyKvDlN1/l11i5tknAYF1Tg81CnNFLz+NkJdRVoVdP2MCow8HvW0Gm4/h?=
 =?us-ascii?Q?KKj824YN5Qp4FRPtRenMOcYo7V1fwB7numft3QYgTG+4tDOPIdQAj70/KHaT?=
 =?us-ascii?Q?UZNxVgIysunZKBdTW2wvPHogIYsJYTHYRFTmN3huh83xJQPqebl8YSA/mbjf?=
 =?us-ascii?Q?S2oDXe/gElpEUx/wBOze/Nnz7Hqtd+Tjgis7LIcExIZk9CVn1MM94BCxin/o?=
 =?us-ascii?Q?Z1ysaeEOsXDz7wjvKJo9eMsbSwFoj45YOB+wR+71PhYpAZW4vgwD0FneSNiS?=
 =?us-ascii?Q?3ruOGonKpjRElNOttwSXTnF69LliHnozWILchy1yn/tVc9v6uuR5anNaiMz2?=
 =?us-ascii?Q?HcSwO25icdaEB99RHkxhtW3WdydS3TvlkRjb07Gx9nN2SlR5PIz8AzWdYvsR?=
 =?us-ascii?Q?HdVYMSSbquF1QoUAYyDAitb9oEyuPknckK9MNZUHM4LSAqdfr+lYfpDp+jOp?=
 =?us-ascii?Q?Z6Qdijl86OhWyx0glYOzXPjulmUM1EmMmdVTRlpBVz/qcbBQuAN4tqQe0BP6?=
 =?us-ascii?Q?qO6O/htuPVifM8Zua9xa0u4+HiT421JQzQDEHXwPwmCxOyfoz9bcEU6djmrR?=
 =?us-ascii?Q?qVgp7PaF4RiOEidj4Ms0mw/Ankrgb9QM7e0sx8+kRM8ivnT5UJeJg3tApbjZ?=
 =?us-ascii?Q?PMJ19Awhspm47/bMmfNO4dFzA7lgNNEjIK/Jx1mg+loO/TJ7nxOzrNRzUK0O?=
 =?us-ascii?Q?QWxnCTXH2zLWR7zHTkHJKu1D8D8q28mKG9qwAGNbnx1kGlC0qqPSkG2V70g?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 52521ad9-f86d-4f2d-116e-08dd209a4585
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2024 02:01:51.9346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7229

From: Roman Kisel <romank@linux.microsoft.com> Sent: Thursday, December 19,=
 2024 3:39 PM
>=20
> On 12/19/2024 1:37 PM, Michael Kelley wrote:
> > From: Roman Kisel <romank@linux.microsoft.com> Sent: Thursday, December=
 19,
> 2024 10:19 AM
>=20
> [...]
>=20
> >>
> >> There will surely be more hypercall usage in the VTL mode that return
> >> data and require the output pages as we progress with upstreaming the
> >> VTL patches. Enabling the hypercall output pages allows to fix the
> >> function in question in a very natural way, making it possible to
> >> replace with some future `hv_get_vp_register` that would work for both
> >> dom0 and VTL mode just the same.
> >>
> >> All told, if you believe that we should make this patch a one-liner,
> >> I'll do as you suggested.
> >>
> >
> > FWIW, Roman and I had this same discussion back in August. See [1].
> > I'll add one new thought that wasn't part of the August discussion.
> Michael, thank you very much for helping out in finding a better
> solution!
>=20
> >
> > To my knowledge, the hypercalls that *may* use a full page for input
> > and/or a full page for output don't actually *require* a full page. The
> > size of the input and output depends on how many "entries" the
> > hypercall is specified to process, where "entries" could be registers,
> > memory PFNs, or whatever. I would expect the code to invoke these
> > hypercalls must already deal with the case where the requested number
> > of entries causes the input or output size to exceed one page, so the
> > code just iterates making multiple invocations of the hypercall with
> > a "batch size" that fits in one page.
> That is what I see in the code, too. The TLFS requires to use a page
> worth of data maximum ("cannot overlap or cross page boundaries"), hence
> the hypercall code shall chunk up the input data appropriately.
>=20
> >
> > It would be perfectly reasonable to limit the batch size so that a
> > "batch" of input or output fits in a half page instead of a full page,
> > avoiding the need to allocate hyperv_pcpu_output_arg. Or if the
> > input and output sizes are not equal, use whatever input vs. output
> > partitioning of a single page make sense for that hypercall. The
> > tradeoff, of course, is having to make the hypercall more times
> > with smaller batches. But if the hypercall is not in a hot path, this
> > might be a reasonable tradeoff to avoid the additional memory
> > allocation. Or if the hypercall processing time per "entry" is high,
> > the added overhead of more invocations with smaller batches is
> > probably negligible compared to the time processing the entries.
> The hypervisor yields control back to the guest if the hypervisor
> spends more than ~a dozen 1e-6 sec in the hypercall processing, and
> the processing isn't done yet. When yielding the control back, the
> hypervisor doesn't advance the instruction pointer so the guest can
> process interrupts on the vCPU (if the guest didn't mask them), and
> get back to processing the hypercall. That helps the guest stay
> responsive if the guest chose to send larger batches. For smaller
> batches, have to consider the cost of invoking the hypercall as you
> are pointing out. On the topic of saving CPU time, there are also fast
> hypercalls that pass data in the CPU registers.
>=20
> >
> > This scheme could also be used in the existing root partition code
> > that is currently the only user of the hyperv_pcpu_output_arg.
> > I could see a valid argument being made to drop
> > hyperv_pcpu_output_arg entirely and just use smaller batches.
> In my view, that is a reasonable idea to cut down on memory usage.
> Here is what I get applying that general idea to this specific
> situation (and sticking to 4KiB as the page size).
>=20
> We are going to save 4KiB * N of memory where N is the number of cores
> allocated to the root partition. Let us also introduce M that denotes
> the amount of memory in KiB allocated to the root partition.
>=20
> Given that the order of magnitude for N is 1 (log_10(N) ~=3D 1), and the
> order of magnitude for M is 6..7, the savings (~=3D10^(N-M)=3D1e-5) look
> rather meager to my eye. That might be a judgement call, I wouldn't
> argue that.

I would agree that the percentage savings is small. VMs often have
several hundred MiB to a few GiB of memory per vCPU. Saving a
4K page out of that amount of memory is a small percentage. The
thing to guard against, though, is applying that logic in many different
places in Linux kernel code. :-)  The Hyper-V support in Linux already
has multiple pre-allocated per-vCPU pages, and by being a little bit
clever we might be able to avoid another one.

>=20
> What is worrisome is that the guest goes against the specification. The
> specification decrees: the input and output areas for the hypercall
> shall not cross page boundaries and shall not overlap.
> Hence, the hypervisor is within its right to produce up to 4KiB of
> output in response to up to 4KiBs of input, and we have:
>=20
> ```
> sizeof(input) + sizeof(output) <=3D 2*sizeof(page)
> ```
>=20
> But when the guest doesn't use the output page, we obviously have
>=20
> ```
> sizeof(input) + sizeof(output) <=3D sizeof(page)
> ```
> on the guest side so the contract is broken.

I agree that a hypercall could produce up to 4 KiB of output in
response to up to 4 KiB of input. But the guest controls how much
input it passes. Furthermore, for all the hypercalls I'm familiar with,
the specification of the hypercall tells the max amount of output it
will produce in response to the input. That allows the guest to
know how much output space it needs to allocate and provide to
the hypercall.

I will concede that it's possible to envision a hypercall with a
specification that says "May produce up to 4 KiB of output. A header
at the beginning of the output says how much output was produced."
In that case, the guest indeed must supply a full page of output space.
But I don't think we have any such hypercalls now, and adding such a=20
hypercall in the future seems unlikely. Of course, if such a hypercall
did get added and Linux used that hypercall, Linux would need to
supply a full page for the hypercall output. That page wouldn't
necessarily need to be a pre-allocated per-vCPU hypercall output
page. Depending on the usage circumstances, that full page might be
able to be allocated on-demand.=20

But assume things proceed as they are today where Linux can limit
the amount of hypercall output based on the input. Then I don't
see a violation of the contract if Linux limits the output and fits
it within a page that is also being shared in a non-overlapping
way with any hypercall input. I wouldn't allocate a per-vCPU
hypercall output page now for a theoretically possible
hypercall that doesn't exist yet.

Michael

>=20
> The hypervisor would need to know that the guest optimizes its memory
> usage in this way, limiting what is allowed by the specification when
> implementing any new hypercalls.
>=20
> >
> > Or are there hypercalls where a smaller batch size doesn't work
> > at all or is a bad tradeoff for performance reasons? I know I'm not
> > familiar with *all* the hypercalls that might be used in root
> > partition or VTL code. If there are such hypercalls, I would be curious
> > to know about them.
> Nothing that I could find in the specification. I wouldn't think that
> justifies investing in creating specialized/special-cased functions
> on the guest side without solid evidence that more code is needed. In
> this particular case, one day, I'd love to replace `get_vtl` with
> one generic function `hv_get_vp_registers` that works both for dom0 and
> VTLs, plays by the book and does not require much/any explaining what is
> going on inside it and why. I believe this will make maintenance easier.
>=20
>=20
> >
> > Michael
> >
> > [1] https://lore.kernel.org/linux-hyperv/SN6PR02MB415759676AEF931F03043=
0FDD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com/
>=20
> --
> Thank you,
> Roman


