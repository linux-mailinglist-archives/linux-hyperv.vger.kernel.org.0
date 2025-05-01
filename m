Return-Path: <linux-hyperv+bounces-5275-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F54EAA597F
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 03:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F104E539F
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 01:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB271F541E;
	Thu,  1 May 2025 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="q8JNv4d7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazolkn19011024.outbound.protection.outlook.com [52.103.7.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D422C331;
	Thu,  1 May 2025 01:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746064557; cv=fail; b=IFCoUBl6ytWAIH86ZtZ0Cl+7BLx9a0NWSQO8/Mi7ixMVkj5E7MoozAKGyAeTrLxfqpaqJER8IsDwMa2iwKo7UmhN9IU4nbHb83Cr1ZGTi4Akjov0b0tPdR0PcYwUR4LZSeT6YO/Csj3sL4WFfbbN5skDpVv6iqIZrWOD5HVYvOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746064557; c=relaxed/simple;
	bh=15P6XO1xGcAs4lkMz+NSJk4TvNErlKAMNzD5iSpdgDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uvM8I2M/5ZdAN6DXZmmlD7W0JtF0VqPMR7a9MlSRABi3DdLJfc4u5VWMNXcaQCkS1xKdWZDy/zzjBVOY1Yoq3xAkjPT43Sgta0o1ny+FTCGlDRKtSvRNNxO92+5WKua1Nr/Ud94QfXWvPpaQBTGCLuY/PApvQdtK5uTqZOPJjl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=q8JNv4d7; arc=fail smtp.client-ip=52.103.7.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5Hbs36g4zEP0T7WRl/rGiUlRtuhyYA0WSbMeuhwObgPVbtRo0fR7jqqqzWD0Z/r4alwRwb0jJGi5QiLrc9Ck7NtdgNvlBz9Z9Ec6kyib6A4bpLT0WVluMzSFVbG2QirMiF6N/pLUuaoOUpf8Tp1+0Dp/JZhrG+m4steV9DqyZpHdRDRLsbSAdwa2pTm2Ym6wu6CewCZ6gYjgUghRhhn/b0RyzqbdnQFFq5HfffpVJJ8QxqJJNoUuwEz2SnrD/fKCWyyF+sHpUCDGbA5tpzXyfpj2GLOCG40zIG1pxCSuuJ9/vaJGKVaEKq6vgM/l4pzAe04bJN+LxdVSFXhl/M5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtoGSioQpGXzHf6hmPQu5nG8kjJj0kNzfvgIOzlc01I=;
 b=rXuEuEnrx7DjeZd+s/0r4kwM1XN8j6sWlkeVgPHxyattXGPZZhtv6doLe5lzbym87m2mZJOCxHShlHl+OLE2pZiCS2q+F1UN2mc8859s79OmVpopb1+Wf8Lf6wnU6ns/JjJ3jCNJ6c9yp5DRMgpD8M2IKeB6f/s3BTqxCmphRzJG6IhO2Dc11aoVyKLTELw30vgBY5IIRQIC+Q+tUy6/Wqu9xGA9UyCCB477I47b+lAdI48e9Kf3KQJ04QvBW32cX7B3cj1tT0C/aYyzV4GrGyFLPRdlevnDZbaDCbeGaXt58pN4DVzm9wv3E9RA4kByMi6DaskElfWQFha1JpOfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtoGSioQpGXzHf6hmPQu5nG8kjJj0kNzfvgIOzlc01I=;
 b=q8JNv4d7mg+lnq0cpIKcfm8HHHTAPFchrLSLzs7kDnKI+VNmC+GN9GrIXWCT7vSr/MJzWjVVFtb5lnfrk6hw4L4yRyHLtf0hn4Ytr/NK5a9nPNgjufEl0CF0GC8ZSiU8kOfo0J9OrMDLuCE/3TVbSJsc5gpSHYzEfjgfZcCqX0pc6lHmSt8qk/gbI74MEYmzatw3Glxx71nJKgzXP+PE+l926Ti863bCj3uBNV+PEXytOAR/n7Tf0J1kBiyhqLqdKbY4xaFf1IlvnCCtuJSFopVhEj8XJ7/cJb3H7r02GsYSWVfkhLVYuCnJA94E5XBuIcRVzbvLL8D7JxPT4QUW1g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9568.namprd02.prod.outlook.com (2603:10b6:930:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.15; Thu, 1 May
 2025 01:55:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Thu, 1 May 2025
 01:55:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [Patch v2 2/4] uio_hv_generic: Use correct size for interrupt and
 monitor pages
Thread-Topic: [Patch v2 2/4] uio_hv_generic: Use correct size for interrupt
 and monitor pages
Thread-Index: AQHbuhwwiSwLknp1qkiayIMCi3y9VLO8/mgw
Date: Thu, 1 May 2025 01:55:53 +0000
Message-ID:
 <SN6PR02MB4157190802F0082EAA11713BD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1746050758-6829-1-git-send-email-longli@linuxonhyperv.com>
 <1746050758-6829-3-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1746050758-6829-3-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9568:EE_
x-ms-office365-filtering-correlation-id: 03e60753-d739-4c46-1f59-08dd88534e5e
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQl3RqqletCEFdzMlpBSGXYPcYQc3wm3Kw3Dn8krNJO9RtWW1KOa/1Jy16So5jao0FUYympM/yOE5oXxTeqmOAgqB8GYZsRMKlmKRL7z3lP7DXynxTNCZk+lWk+0BsYf8d+iQ1N/GBD3y1avYuEKUnmvOU7OfPjhGaNbAi48jrBW6E/5U9Djj6UwgZyyZFYq9Q1DrE4edsi0VLS1UOnQ+F5ItYfUqx+q/hR2v2a9CKicNed9+cECjQpG6eVIVxewOu1TJH3OSs7Vn4pdtd/T3P01UbQozWbwE1o8p/dNARBpNLlUi/aUkF0q5QT17zefV8om4ztjQUxADX+fS/IM3RnFxtqYe4xr76a2N8+EJGKiTPnOmStPki4IVBPA2WLsDpV8uM/NkgDu84ZGoqdDE0rqj6p3WgXCvtq6HD5xVpROi1NjpLeciLQm61yRB+nKOUwZmr14fkz+WNOcDbIcylkP9nbsNhVKfORG5MgbjGKcZmM0MyCg0iNSIQsv96yUXsMQQabINJcVmlowC2CaHNTaWY1J6keJw6uParKQ9J0VSMxOM8l6mu7IJEI6JE9GUMXYMSrNAmDbwa36CtZh/b8lkSJ0y2ylok/mH7lzw12YTLPPZm6SEzf9Zobv+HHCN5ci037q/pHmmhdH2rtf7+5kbLVnRKjUT26gh02XJOzJm3/VZueZjRM+5+bR0ycDhFT/mW0t2zn5lb6cbWeXwhfmP0jt+IIkoW0=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|15080799006|8060799006|8062599003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?POcgBE7xjCu5QXrCxQFs0bTFOpFnNJrMKu2Zl/AP84eHobi1kalRVYC1ux7g?=
 =?us-ascii?Q?l9aLT9xeVLIINaEK+joyNEoKWFZKAhnwQUNkWM2kzCOsf2nB5vpbudCl32n8?=
 =?us-ascii?Q?E9Nesz0PGkrPpTbCu+u0U/Wo8sKbfPoJ7PKNQG5P+rFWzjNAwF0f88ieNRZX?=
 =?us-ascii?Q?6xvIktAeASb7+YmEWZUoaeqJAzizkrDvdg/l3Tdebb3YNdyGvOCz+oyx4hpp?=
 =?us-ascii?Q?4a6xSLk0vJOo9nwSwqko29sxNESD36USawUYuTRf6ija9kHtakfmjEGFCQU/?=
 =?us-ascii?Q?o8uqbE62yBk2/9hwIFw2TyRScEXGai5n68Usb6wfRsCBB20p7Fp/FZA/pevL?=
 =?us-ascii?Q?pr1Gh+1wRE3TK5Yk216+jnITnz6N88aZkjqC38X63qs1hRwpgsEqhowCxgXX?=
 =?us-ascii?Q?0kSk28kW3BLNQGZQadnYUfr7YNjgl3w7W2r1sZlLTmAt8HmYjKhIjDnGDX3C?=
 =?us-ascii?Q?G5ZcU0scYS2NIg/ZsqvBW98FhMA/TAuF9VlgmKxumYYtZEurr+cFUTI7eWQK?=
 =?us-ascii?Q?VuyLw9C3SPB+u9w7BLr9CJh5WknyrnFQ5GgSQ0tJon3tYnAxYuaR2kIppohV?=
 =?us-ascii?Q?lHVEbI3mbiL4XXgzj1YK13SmVwv52wKt+Po/a56a8RYMypk8Z32qczTHRpR/?=
 =?us-ascii?Q?9rbHbH/esfc7K9F07E+ZBaz3pNYQQ8WRjtGdnOkg9lEID4ZLLLK+3s7JBUKO?=
 =?us-ascii?Q?9l6DhZp4RcVdHj9+8wZyxMhkhzZVTRBWx7pVnUH5nwWtKRJxZ3uBgpJqjySp?=
 =?us-ascii?Q?ibyd5/AjjOxbktKhN1e5bgHYuERpLfwDFBNpuj3418r+AKQKbmFH2kudrMvS?=
 =?us-ascii?Q?jidP+x+DbS1FZE0ZXoZzdNCQPUZlgalVBY/XzsHui3+9ey7Ax223/KrNTSU1?=
 =?us-ascii?Q?icHlfaj+93ehWfW3kPOQ0VmfmBG9OTQVXbpWCvnOo0nLFy7uZ3OJGXkbcPW6?=
 =?us-ascii?Q?ava8L/iJwG6gZsOKtqxdg8BleIEFe+w6cNCsbD9YSwhWwMYfkXYgHXXoO3aN?=
 =?us-ascii?Q?/iCoBRa5yupx9QqGlUzGdq/sjLuFhJj310ce8nOtQFf/1C+HfblS7sHqrLDo?=
 =?us-ascii?Q?5oAZ/iDlDvSqv9nra3ba3adF6o8gsg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UJQxE7JfMIGf0yM4jCqenYvcVIAQ4ivkKQOcZrChNBV0neRr5VBPOtas2Qc5?=
 =?us-ascii?Q?zi6607I4RtJ5UlGHpmjrS4EC+G2RsnvtPLOCWTkYtAyC9IgyPvKATEANSPNP?=
 =?us-ascii?Q?zDT3H9jMfNY+WyX3h1JyXdbknU/pHOjlF5yXeFg2fh6AHVX6xGufB6wE9ApB?=
 =?us-ascii?Q?8ZvUHfDfk/ILZQIDzsTJVIoaKdWHOTqJ2CnRi67bgr2Fq2WKzkUaXCeHJ4qm?=
 =?us-ascii?Q?va7VCPNIV4cGhTCaXO06T2LxAUjRd1pjfHNB+T+5SA+AVFkLtTWyKZwBnZTR?=
 =?us-ascii?Q?kNufkhXAKt5noKVBEV1OiSZCQyZtqcGpe0Oc1UyoMex0/HQk1DemqQb3iVio?=
 =?us-ascii?Q?nH5JtMK5VnG++1QKRTe0uAvonYmwCaOchkbOVUt31djDx1W8EGe7a16AylJ0?=
 =?us-ascii?Q?I9+02oMmp9/nXfy2NDpMKA2IYvWS8t3kMzPN3Dgp6HjFT6VmGDbnmX167yS0?=
 =?us-ascii?Q?jQK0wV8MMQYRWQDNb7qzYMEvq8vOCe79hdQfqtsSbbzglHhBbzVA4oi+k/rP?=
 =?us-ascii?Q?W8bKsGd4ufMuF9a1kFuNSUqTpoAB514zUDalateEe5PvheMvGrY0Tbjw0oUe?=
 =?us-ascii?Q?l34nro7WfRYx9XQPXh2ayyT7VBSToboJjcxs1zoHudYCcxNxC4ZffVdwlxh/?=
 =?us-ascii?Q?ITAYJXjarHp5YZ9hKFez2Kv0dytk3YpLoSAMx+jvnhSe4p6bmed3hTHBT7Wj?=
 =?us-ascii?Q?/Xrce4roQx6PqqYv9ThCfdxh9mW6K4n3UykWVuqZ9WE/1KJPy7MatVLGbjy0?=
 =?us-ascii?Q?DABH/gzY9ELklSKK1+HzHbv9gdMhV+b9GRbKhbo/Sj24YT8HK/F0fBpV11Bg?=
 =?us-ascii?Q?1sRMp+gydu/hacY64QFKP6wZI0eMfbChkBg0vjSjpphJjGuwvhpK095GotNf?=
 =?us-ascii?Q?9unsPkldLlSKw7J2WUi08hyfroUmr6mx8jKtX9c2tukvpVp21Le1nXbNO2Xt?=
 =?us-ascii?Q?uVFM7qTr9UoE8iaGuca+LBOMnztMCUnrFoSQlLj9FglOURxRK+KI4WR6aVza?=
 =?us-ascii?Q?nIGYLTaA6MmI00zd6CKL3mt8B+qkKS3zcHb5Pvq8r26EnqBv6tDYIGj53EQZ?=
 =?us-ascii?Q?cv7dm7/diCOCNNVuCS6hCmc+RSSk1FjmPHqv7H0vQ8/efFqGTOE7cufDqvBv?=
 =?us-ascii?Q?njhk8UsqqRajnOxoMzDnf24QzTvYh3ZcnhvKRvUgue5gBtNRBThClb9EbRku?=
 =?us-ascii?Q?CeNdgJD/MiELmK6YE/2fZ729S8mqnkEnJu5oGB8kDg3zy7HBxOhpxCIsUa4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e60753-d739-4c46-1f59-08dd88534e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 01:55:53.4293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9568

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Wednesday, =
April 30, 2025 3:06 PM
>=20
> Interrupt and monitor pages should be in Hyper-V page size (4k bytes).
> This can be different to the system page size.

s/different to/different from/

>=20
> This size is read and used by the user-mode program to determine the
> mapped data region. An example of such user-mode program is the VMBUS

s/VMBUS/VMBus/

> driver in DPDK.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus"=
)
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/uio/uio_hv_generic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 1b19b5647495..08385b04c4ab 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -287,13 +287,13 @@ hv_uio_probe(struct hv_device *dev,
>  	pdata->info.mem[INT_PAGE_MAP].name =3D "int_page";
>  	pdata->info.mem[INT_PAGE_MAP].addr
>  		=3D (uintptr_t)vmbus_connection.int_page;
> -	pdata->info.mem[INT_PAGE_MAP].size =3D PAGE_SIZE;
> +	pdata->info.mem[INT_PAGE_MAP].size =3D HV_HYP_PAGE_SIZE;
>  	pdata->info.mem[INT_PAGE_MAP].memtype =3D UIO_MEM_LOGICAL;
>=20
>  	pdata->info.mem[MON_PAGE_MAP].name =3D "monitor_page";
>  	pdata->info.mem[MON_PAGE_MAP].addr
>  		=3D (uintptr_t)vmbus_connection.monitor_pages[1];
> -	pdata->info.mem[MON_PAGE_MAP].size =3D PAGE_SIZE;
> +	pdata->info.mem[MON_PAGE_MAP].size =3D HV_HYP_PAGE_SIZE;
>  	pdata->info.mem[MON_PAGE_MAP].memtype =3D UIO_MEM_LOGICAL;
>=20
>  	if (channel->device_id =3D=3D HV_NIC) {
> --
> 2.34.1
>=20


