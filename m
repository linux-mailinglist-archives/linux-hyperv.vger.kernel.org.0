Return-Path: <linux-hyperv+bounces-6608-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B14B375F9
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Aug 2025 02:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B610816328A
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Aug 2025 00:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1C63C0C;
	Wed, 27 Aug 2025 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IR2O2LC3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012022.outbound.protection.outlook.com [52.103.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB61367;
	Wed, 27 Aug 2025 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756253491; cv=fail; b=pgU5rPZJ5n3N/4n6HgjINn8WxIMyHoVl1hP3fIHrxQ6dnWa2oq0FtmYiLIYdWOXsd9Ekl3hAbCAdLLOpMaLg4KOm1tIDfdJqxNKrq2XTdJgOl864b1vCXKmJorFMz6haxjeaOL2zI60e9VV7pZ4R+IDyObBsdb4LHjd56khqR0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756253491; c=relaxed/simple;
	bh=nPgqZBD4Buw0SKGd/eOc5QPW1gXNVDYJn8qotCKzSDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uteWPIKfLDpdchaU26uvIWBv4mxOa/cc+htofTFTZCc28Vsj52CP8T0LHVOUfeM15ZmEcG9A95gEL9+JYLjW3Woye8gIZxKaygG2NhOy8WFBkDu49Idu0Q2ZRZr2QLRGed3kAOj7Yx1LonpZmlGj+5vCii85+sm3Ss3okvXq6v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IR2O2LC3; arc=fail smtp.client-ip=52.103.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPd1X2wvZHl7xpQWZ08sl/pS9MCFYa/NHSqadCDGIofTDgtiopeHA+Cu+DgerqsV57xMxKIIjUCUkDZ5/iC5I9u//bMqraUpaQNEibClWPPtaF3z0T6NUFko7M4AxsiAnJfwgoZZM3W/3QFdzWK7cY3l6188asHwr5mslSUphwk4XEQglu7GQfopn8VZM4sziCjs2go6yxxjTsYNx3bUQnIx4eQ/5OAg8fMKnqUCwMvvOub1DFs4MEOPhQi818tyV9D5NK07gYNcKC1jNdQcdtfsADGMOUahDxK8PRMjej1+nN7M70FMhdGzFHypPUHPMrTLTBxr+rIDJsKwjVfCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRtfL4kB/z5IvjEHTteyjzFbdqvvQ+QnBbg2r+sJWrY=;
 b=FtWcWdI9DBFkDuHwPNRoyE7YZ2d9LVmWM/jGmSYgqazHt9gFjIb5XWPRV8FfaLakKKBLsBGdmKK2Lbdua+UkBmXrTnzWuTwuX56t+T+5aCDjbUMt/pqEHJO0egSsQzxls+D+4WzL//r4KplcrLbSu8rNxpB2LcJ2HfjqDiiLLsj3N4wIdgKnWH1CKnJp2VPAmSz2zQKUGhy4v//0e+cbjSzOsKmph8crKwFwAwM3OxJsM+lEXc6BHvKxZWXJri7r16o+Amsn0Fn4QZszGpOa3oqE6x2wYce83l8EM55njjZb4SUz7/lnxAxNQzgVNzLaj/JzWoZCCHKzckqMcSqLQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRtfL4kB/z5IvjEHTteyjzFbdqvvQ+QnBbg2r+sJWrY=;
 b=IR2O2LC3C6xFY4WHpooeK9TMYJ4brMAmFMP2CyvNgGnCyS9X83zxX/PmSEwcFoZCHOPFx2jFhrnqOqAENtLMjqlh9ywuwtS/dhFCNGam8ergnAeBTARYcFWIaT07jhwTkDmjDymCSfNw41Erg76FxoUpgRND3zc2BAd/viNfXx0eNJrRzRxtuv/EW12EnqnIe+nt36hKmdUMb4HDyrDuKqadc/ySMVZGz6xEzbCPJDBz4pfbYkN1k1ATVRB7zk+DBf8IkTlBnVBKqElpf3cAqZrUBdA2AWHQnsZP7Y8+jMMOBNholZQZ5klCVnkJYn3GjmxPMW1jEtZLoYOINvBwXg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7391.namprd02.prod.outlook.com (2603:10b6:a03:2a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 00:11:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 00:11:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, Tianyu Lan <tiala@microsoft.com>, Li Tian
	<litian@redhat.com>, Philipp Rudo <prudo@redhat.com>
Subject: RE: [PATCH v3] x86/hyperv: Fix kdump on Azure CVMs
Thread-Topic: [PATCH v3] x86/hyperv: Fix kdump on Azure CVMs
Thread-Index: AQHcEq6v/wxOnnc70EyB0UK7l4yekbR1oNMw
Date: Wed, 27 Aug 2025 00:11:25 +0000
Message-ID:
 <SN6PR02MB4157581777244FE17DA3C7C2D438A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250821151655.3051386-1-vkuznets@redhat.com>
In-Reply-To: <20250821151655.3051386-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7391:EE_
x-ms-office365-filtering-correlation-id: da1cca33-e612-4820-a19b-08dde4fe436b
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnoyTIwSrGph0lItVprk4CpiBh4y2ZdOr2l0qOdXFuZrn6/+fpySZF9znacC8EihjO29V0THcpu1nbmOQosqkRL1sdElFE9cWityqNvsQPQziCC9J0aJhGzI1E4kZNfRcQBzT/7xC1p/bYNGwQv2EYyi9fL1TyDlPoQ8LctOcXNhS8X6Trc6qWPRk2wf2QmcTtjExj1zk9iV/A3TIDk7VXX2aXfgHvGDQs4V+jrxEQmNC4ycC4vHQZ80qvp1MB6A73anfzK9CSo0lKNzT6sZ9Cmuczw0rVBCnZdsnKJCOx05UmDlGfjcxURXWJvEYI7nXU5c7EDbrOIttUVhBJW9aWEE/XoIc5L98lU//huqBOZdaF+x1lurfgR8YHBgyxmd1jeRbh2UfmwLqKIU+bq3bea7DtqDZP3uw0EfGZYSjFgV2L7vaMM/IiEcwMWSbvWLKXp3rIWPq6bLlFxv9I0kqdxOlZT5plP9ykLM4yROxhCBRHTodcgSs0TE4ZFcf/UfmS8YVJ6NhBQ+nH+iDAeRftGFOp46WfIwAyp9dk7ejb87E2BAqzQa2pGwBX7NUHOsQdwGKYgmwcVX7IVeFSql7r4XiXkZG1IChyKzS2GwfE01sMhpKAAZvFMNpzhKmjIt5D8Xvcg7xeeNFLgLSrTyPq1JIGJwv1ctUsOzhCZhkEFV4Ke8tVR32ibBzUh6r+9Pr6vd8irPP/Azcm5SkzZoVHjldbipZsJ4X0CZqlcKNf8gpoTN+JG8mB/blQzFL7QKDWM=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|31061999003|461199028|13091999003|41001999006|8060799015|19110799012|8062599012|40105399003|3412199025|440099028|52005399003|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4wNTc/0itChL0dPZoxoyWMZAK8mUJvemlhr76ZFktzFuhPcE7hsy2k+s2+nR?=
 =?us-ascii?Q?TqDjreo+xeRDh1r0dMmdnCzI+BR7QxMrVb3mZkQJ4hzRLtfwwVG2g+D9Pi6Q?=
 =?us-ascii?Q?SbmUY7sgjOcfepOpbGYzxpirT9YMHWs5LTzzv+g3cs1e50ZVKPiY6wP7IL34?=
 =?us-ascii?Q?hl0d+MSyedNe1BglNRam0RDxOaj4emIDbrVofXVXMLXJN4C7FE298V1PaZTA?=
 =?us-ascii?Q?K7SJR778A/WK+kOVcjDM9x+atThxoiROkaAg4Kx/IRtawFBzseEYDd/djalb?=
 =?us-ascii?Q?9VPdEnr3oczNT4hqeCniGa9lPp4Z6rWIEbapHtnsDCbDPPuWCLPoI6VjDYF8?=
 =?us-ascii?Q?8UcSKMz8YGe7x+OgYtRIsfMbbfUtucWifD2KG0vA8kV5yqAEQ/SFir3ECMHd?=
 =?us-ascii?Q?uc80YLW5R7I9VVaf3X3MM5caXRxz16wRqdGQyFYivdLBbJoPqbSUtk/rq/pw?=
 =?us-ascii?Q?AMKTNjknZybvgaLJyhKt4nWPCpYyYUS6nRpZnzrguvKCD+/4OTjgXPu6SLEX?=
 =?us-ascii?Q?k5E9pNtTgKvRMEIxr/ebqRMXZGiZu6l/11vWNAJvlEKOgtu7Nrr8UGxtdffu?=
 =?us-ascii?Q?J0urRUCh4eBQJPAfqYmfzJaP1HcUsFuKCJNJP06HE2HV3ZHj4XKXWexoTv1Z?=
 =?us-ascii?Q?/W15B3Umspk3Xmp4dNCcFe1beVefzT/iVyuShDadfFZ/U72fKpwdcDCOKgIQ?=
 =?us-ascii?Q?KMuXXExx58eD67ZP9MilghE8WPWtmk+ehRzHXxv5xeMbTyJlWWJPyM9U6FIh?=
 =?us-ascii?Q?JqRgMaMziU7mOAAUGsv+wOMdXZs5EP6YX37gQ4dO6Xoq92LmFCwqdGohbC+r?=
 =?us-ascii?Q?NON/wC26HLqRrPkEZ1d0zgSdx3blBluBpy769XMvgbOW2wzk5EznVi5Szu77?=
 =?us-ascii?Q?CdN38KxW+RMLvvvTJ+YTz6IZ/3JukP9jh3UmtWmN+vDa5+JrwR1NdN1GkuVf?=
 =?us-ascii?Q?1zZhmseq35KnW9m2kVCBJSNjZsBWAz5UZYL9kycsni2KCDuzFQZPyvVmaNOv?=
 =?us-ascii?Q?Xpcp/UFhTYvkn7kkWntxQFviH3nMZNj47fARA6mKMdO8RUq/+ZazYdvl5xDM?=
 =?us-ascii?Q?atOoX9qjtmmt+OGC9ZWB5BHIw/3zS76r8sarI21dvjAbJbn503T9QXYIOrhe?=
 =?us-ascii?Q?qHrmgMA8MxgsTnizuJvACLUUIg4zzQ6udZytPogIYy7knAsj7VH83uUCtcBS?=
 =?us-ascii?Q?XvPqO8W9Ts/7A+UOyBVtmbaXS8GViy2I9drdYgY7KtAFcjETGIOQQKzMShWr?=
 =?us-ascii?Q?ONeoS2+hoMH0RN2WI8DzUD01CzDYuIoA0QMyuIry9g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/nJpRjpDemZQX6qBieCK9Gh95r0CenSksqtOFlcsPMb2ex1QjfLnbFiBb7BT?=
 =?us-ascii?Q?Glx5fYJGpJiNfBcLgzdBzL4n6Cd+wkys+OEzIHMYfzhFt04IqrHEh8aFtDvE?=
 =?us-ascii?Q?yVZau4PmEk20zf2IiqxAHHkuIHY2m+qCQG1+EKuEDfeE8gfbynJNKM41FBim?=
 =?us-ascii?Q?2eLNajqsGVGBrL7TH82TU0OriSEQnOsyup2Wlryz588Sd1MiKEjzCla8amZz?=
 =?us-ascii?Q?L4iFeH+neo0PuvtbU4ySFunDgGxigwjdbeojul70+wkbAklKPe0gOHS7PdKb?=
 =?us-ascii?Q?rB5yUpcAtawAnm2nZLKUS2+KDscDvsAh/buPc4u9wbAKChATK1N8K/66195i?=
 =?us-ascii?Q?mkAcQgp0AB/n9HVx/4Sh/GOTyfwYjka+AMjCEAqvA5sMWFWY3YMrD2CCX3Oa?=
 =?us-ascii?Q?0Wwb3Xvk9+0W0AVqZlLooPXNbACpjQM3W4GR+stTdBzu+5ItTeWkSj9SZqHw?=
 =?us-ascii?Q?42NzPrPkDPfXMwBE4JhWCZSzjqBY+bLfs6wMroKiRtDEDkPbFPGF7c5YIGFq?=
 =?us-ascii?Q?dGGYuhw5vrT4GXjf4CeaNb6fvO1tkajJYLDVeSjyqbPf9SD2XEF774si7ajE?=
 =?us-ascii?Q?/BBxKDm9XPzsaGahC4ObOITvcoF2gO9Ki/ivg+wsFEO0Nl5UQcjE86B5Sojx?=
 =?us-ascii?Q?BZYRGT+UGan5D+mCOiFkChZjKz5w2XVCyylRtEjQ1eZ1ePbkMCoMDcVYHTHb?=
 =?us-ascii?Q?cF+0ajy3YYH2m9iA3CG29gPn5l4TjJjBOalrpFh1tlqAocPjmV+qdStazXaq?=
 =?us-ascii?Q?LAHXg1hWDyy/07ROVMj+I4hSS//Net8bbsbKNdThp1inXGSr/sTuGEZgf/1/?=
 =?us-ascii?Q?LrWlTujjBcL8bq0gIqqqGOVnsUTLxUtpuK1CJFVwermKgSCDwkX+qbSFQoih?=
 =?us-ascii?Q?j6U8iSzbBqSDXaB3+utKU3uk8AgRENF3UsBvhLyDh17VK2WWjWjHzsFXaLLB?=
 =?us-ascii?Q?zS+Xxkjp6bW+xx57goED4KNuAcHtUCvyUuezkoc+lPoBGufzICE/eHli67HR?=
 =?us-ascii?Q?0GrnC2xk+PZD/zGVs91O5Q311OCys3lCGptP8O5cK7+e8MEg3r9+0VWR3LD1?=
 =?us-ascii?Q?61TlOIraG2WQveenUQDwWbF1BroyUijaeMf4R/NP6WE9dM5CImT4DSDVal7A?=
 =?us-ascii?Q?tkblb+I5y1RaEpT3xajyyp3+seN6adsXWfvt6FE/KCctekTC6x0nKRdI+XLc?=
 =?us-ascii?Q?HsVSzvuPJjy/yz4my7+oO6W4SOr6DJIMMAptdjbKrvQaI+mOHmAOH3m/lNc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da1cca33-e612-4820-a19b-08dde4fe436b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 00:11:26.0303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7391

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, August 21, 202=
5 8:17 AM
>=20
> Azure CVM instance types featuring a paravisor hang upon kdump. The
> investigation shows that makedumpfile causes a hang when it steps on a pa=
ge
> which was previously share with the host
> (HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY). The new kernel has no
> knowledge of these 'special' regions (which are Vmbus connection pages,
> GPADL buffers, ...). There are several ways to approach the issue:
> - Convey the knowledge about these regions to the new kernel somehow.
> - Unshare these regions before accessing in the new kernel (it is unclear
> if there's a way to query the status for a given GPA range).
> - Unshare these regions before jumping to the new kernel (which this patc=
h
> implements).
>=20
> To make the procedure as robust as possible, store PFN ranges of shared
> regions in a linked list instead of storing GVAs and re-using
> hv_vtom_set_host_visibility(). This also allows to avoid memory allocatio=
n
> on the kdump/kexec path.
>=20
> The patch skips implementing weird corner case in hv_list_enc_remove()
> when a PFN in the middle of a region is unshared. First, it is unlikely
> that such requests happen. Second, it is not a big problem if
> hv_list_enc_remove() doesn't actually remove some regions as this will
> only result in an extra hypercall doing nothing upon kexec/kdump; there's
> no need to be perfect.

This last paragraph is left over from the previous version. It's no
longer correct and should be removed.

>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v2 [Michael Kelley]:
>  - Rebase to hyperv-next.
>  - Move hv_ivm_clear_host_access() call to hyperv_cleanup(). This also
>    makes ARM stub unneeded.
>  - Implement the missing corner case in hv_list_enc_remove(). With this,
>    the math should (hopefully!) always be correct so we don't rely on
>    the idempotency of HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY
>    hypercall. As the case is not something we see, I tested the code
>    with a few synthetic tests.
>  - Fix the math in hv_list_enc_remove() (count -> ent->count).
>  - Typos.
> ---
>  arch/x86/hyperv/hv_init.c       |   3 +
>  arch/x86/hyperv/ivm.c           | 213 ++++++++++++++++++++++++++++++--
>  arch/x86/include/asm/mshyperv.h |   2 +
>  3 files changed, 210 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 2979d15223cf..4bb1578237eb 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -596,6 +596,9 @@ void hyperv_cleanup(void)
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
>  	union hv_reference_tsc_msr tsc_msr;
>=20
> +	/* Retract host access to shared memory in case of isolation */
> +	hv_ivm_clear_host_access();
> +
>  	/* Reset our OS id */
>  	wrmsrq(HV_X64_MSR_GUEST_OS_ID, 0);
>  	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 3084ae8a3eed..0d74156ad6a7 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -462,6 +462,188 @@ void hv_ivm_msr_read(u64 msr, u64 *value)
>  		hv_ghcb_msr_read(msr, value);
>  }
>=20
> +/*
> + * Keep track of the PFN regions which were shared with the host. The ac=
cess
> + * must be revoked upon kexec/kdump (see hv_ivm_clear_host_access()).
> + */
> +struct hv_enc_pfn_region {
> +	struct list_head list;
> +	u64 pfn;
> +	int count;
> +};
> +
> +static LIST_HEAD(hv_list_enc);
> +static DEFINE_RAW_SPINLOCK(hv_list_enc_lock);
> +
> +static int hv_list_enc_add(const u64 *pfn_list, int count)
> +{
> +	struct hv_enc_pfn_region *ent;
> +	unsigned long flags;
> +	u64 pfn;
> +	int i;
> +
> +	for (i =3D 0; i < count; i++) {
> +		pfn =3D pfn_list[i];
> +
> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> +		/* Check if the PFN already exists in some region first */
> +		list_for_each_entry(ent, &hv_list_enc, list) {
> +			if ((ent->pfn <=3D pfn) && (ent->pfn + ent->count - 1 >=3D pfn))
> +				/* Nothing to do - pfn is already in the list */
> +				goto unlock_done;
> +		}
> +
> +		/*
> +		 * Check if the PFN is adjacent to an existing region. Growing
> +		 * a region can make it adjacent to another one but merging is
> +		 * not (yet) implemented for simplicity. A PFN cannot be added
> +		 * to two regions to keep the logic in hv_list_enc_remove()
> +		 * correct.
> +		 */
> +		list_for_each_entry(ent, &hv_list_enc, list) {
> +			if (ent->pfn + ent->count =3D=3D pfn) {
> +				/* Grow existing region up */
> +				ent->count++;
> +				goto unlock_done;
> +			} else if (pfn + 1 =3D=3D ent->pfn) {
> +				/* Grow existing region down */
> +				ent->pfn--;
> +				ent->count++;
> +				goto unlock_done;
> +			}
> +		}
> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +
> +		/* No adjacent region found -- create a new one */
> +		ent =3D kzalloc(sizeof(struct hv_enc_pfn_region), GFP_KERNEL);
> +		if (!ent)
> +			return -ENOMEM;
> +
> +		ent->pfn =3D pfn;
> +		ent->count =3D 1;
> +
> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> +		list_add(&ent->list, &hv_list_enc);
> +
> +unlock_done:
> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static void hv_list_enc_remove(const u64 *pfn_list, int count)
> +{
> +	struct hv_enc_pfn_region *ent, *t;
> +	struct hv_enc_pfn_region new_region;
> +	unsigned long flags;
> +	u64 pfn;
> +	int i;
> +
> +	for (i =3D 0; i < count; i++) {
> +		pfn =3D pfn_list[i];
> +
> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> +		list_for_each_entry_safe(ent, t, &hv_list_enc, list) {
> +			if (pfn =3D=3D ent->pfn + ent->count - 1) {
> +				/* Removing tail pfn */
> +				ent->count--;
> +				if (!ent->count) {
> +					list_del(&ent->list);
> +					kfree(ent);
> +				}
> +				goto unlock_done;
> +			} else if (pfn =3D=3D ent->pfn) {
> +				/* Removing head pfn */
> +				ent->count--;
> +				ent->pfn++;
> +				if (!ent->count) {
> +					list_del(&ent->list);
> +					kfree(ent);
> +				}
> +				goto unlock_done;
> +			} else if (pfn > ent->pfn && pfn < ent->pfn + ent->count - 1) {
> +				/*
> +				 * Removing a pfn in the middle. Cut off the tail
> +				 * of the existing region and create a template for
> +				 * the new one.
> +				 */
> +				new_region.pfn =3D pfn + 1;
> +				new_region.count =3D ent->count - (pfn - ent->pfn + 1);
> +				ent->count =3D pfn - ent->pfn;
> +				goto unlock_split;
> +			}
> +
> +		}
> +unlock_done:
> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +		continue;
> +
> +unlock_split:
> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +
> +		ent =3D kzalloc(sizeof(struct hv_enc_pfn_region), GFP_KERNEL);
> +		/*
> +		 * There is no apparent good way to recover from -ENOMEM
> +		 * situation, the accouting is going to be wrong either way.
> +		 * Proceed with the rest of the list to make it 'less wrong'.
> +		 */
> +		if (WARN_ON_ONCE(!ent))
> +			continue;
> +
> +		ent->pfn =3D new_region.pfn;
> +		ent->count =3D new_region.count;
> +
> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> +		list_add(&ent->list, &hv_list_enc);
> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +	}
> +}
> +
> +void hv_ivm_clear_host_access(void)
> +{
> +	struct hv_gpa_range_for_visibility *input;
> +	struct hv_enc_pfn_region *ent;
> +	unsigned long flags;
> +	u64 hv_status;
> +	int batch_size, cur, i;
> +
> +	if (!hv_is_isolation_supported())
> +		return;

I seem to recall that some separate work has been done
to support kexec/kdump for the more generic SEV-SNP and
TDX cases where there's no paravisor mediating. I haven't
gone looking for that code to see when it runs.=20
hv_ivm_clear_host_access() is needed to update the
paravisor records about the page state, but if other code
has already updated the hypervisor/processor state, that
might be problematic. If this runs first, then the more
generic code will presumably find nothing to do, which
should be OK.

I'll try to go look further at this situation, unless you already
have. If necessary, this function could be gated to run
only when a paravisor is present.

> +
> +	raw_spin_lock_irqsave(&hv_list_enc_lock, flags);

Since this function is now called after other CPUs have
been stopped, the spin lock is no longer necessary, unless
you were counting on it to provide the interrupt disable
needed for accessing the per-cpu hypercall argument page.
But even then, I'd suggest just doing the interrupt disable
instead of the spin lock so there's no chance of the
panic or kexec path getting hung waiting on the spin lock.

There's also a potentially rare problem if other CPUs are
stopped while hv_list_enc_add() or hv_list_nec_remove()
is being executed. The list might be inconsistent, or not
fully reflect what the paravisor and hypervisor think about
the private/shared state of the page. But I don't think there's
anything we can do about that. Again, I'd suggest a code
comment acknowledging this case, and that there's nothing
that can be done.

> +
> +	batch_size =3D MIN(hv_setup_in_array(&input, sizeof(*input),
> +					   sizeof(input->gpa_page_list[0])),
> +			 HV_MAX_MODIFY_GPA_REP_COUNT);

The patches that added hv_setup_in_array() were pulled from
hyperv-next due to some renewed discussion. You'll need to revert
back to the previous handling of hyperv_pcpu_input_arg. :-(

> +	if (unlikely(!input))
> +		goto unlock;
> +
> +	list_for_each_entry(ent, &hv_list_enc, list) {
> +		for (i =3D 0, cur =3D 0; i < ent->count; i++) {
> +			input->gpa_page_list[cur] =3D ent->pfn + i;
> +			cur++;
> +
> +			if (cur =3D=3D batch_size || i =3D=3D ent->count - 1) {
> +				input->partition_id =3D HV_PARTITION_ID_SELF;
> +				input->host_visibility =3D VMBUS_PAGE_NOT_VISIBLE;
> +				input->reserved0 =3D 0;
> +				input->reserved1 =3D 0;
> +				hv_status =3D hv_do_rep_hypercall(
> +					HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY,
> +					cur, 0, input, NULL);
> +				WARN_ON_ONCE(!hv_result_success(hv_status));
> +				cur =3D 0;
> +			}
> +		}
> +
> +	};
> +
> +unlock:
> +	raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(hv_ivm_clear_host_access);
> +
>  /*
>   * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
>   *
> @@ -476,24 +658,33 @@ static int hv_mark_gpa_visibility(u16 count, const =
u64 pfn[],
>  	u64 hv_status;
>  	int batch_size;
>  	unsigned long flags;
> +	int ret;
>=20
>  	/* no-op if partition isolation is not enabled */
>  	if (!hv_is_isolation_supported())
>  		return 0;
>=20
> +	if (visibility =3D=3D VMBUS_PAGE_NOT_VISIBLE) {
> +		hv_list_enc_remove(pfn, count);
> +	} else {
> +		ret =3D hv_list_enc_add(pfn, count);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	local_irq_save(flags);
>  	batch_size =3D hv_setup_in_array(&input, sizeof(*input),
>  					sizeof(input->gpa_page_list[0]));
>  	if (unlikely(!input)) {
> -		local_irq_restore(flags);
> -		return -EINVAL;
> +		ret =3D -EINVAL;
> +		goto unlock;
>  	}
>=20
>  	if (count > batch_size) {
>  		pr_err("Hyper-V: GPA count:%d exceeds supported:%u\n", count,
>  		       batch_size);
> -		local_irq_restore(flags);
> -		return -EINVAL;
> +		ret =3D -EINVAL;
> +		goto unlock;
>  	}
>=20
>  	input->partition_id =3D HV_PARTITION_ID_SELF;
> @@ -502,12 +693,18 @@ static int hv_mark_gpa_visibility(u16 count, const =
u64 pfn[],
>  	hv_status =3D hv_do_rep_hypercall(
>  			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
>  			0, input, NULL);
> -	local_irq_restore(flags);
> -
>  	if (hv_result_success(hv_status))
> -		return 0;
> +		ret =3D 0;
>  	else
> -		return -EFAULT;
> +		ret =3D -EFAULT;
> +
> +unlock:
> +	local_irq_restore(flags);
> +
> +	if (ret)
> +		hv_list_enc_remove(pfn, count);

If making the pages shared fails, this is an "undo". But what
about an "undo" if making the pages private fails? Maybe
your thinking is that leaving the pages on the shared list just
sets things up for a failure when hv_ivm_clear_host_access()
tries to make them private. But I wonder if it would be better
to go ahead and "undo" here in case the failure is transient
and hv_ivm_clear_host_access() might later succeed. I don't
understand the hypercall failure modes well enough to
know whether that's plausible. But if you think the "undo"
here really isn't warranted, please add a code comment to
that effect since a future reader might expect to the two
cases to be symmetrical here.

> +
> +	return ret;
>  }
>=20
>  /*
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index abc4659f5809..6a988001e46f 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -263,10 +263,12 @@ static inline int hv_snp_boot_ap(u32 apic_id, unsig=
ned long
> start_ip,
>  void hv_vtom_init(void);
>  void hv_ivm_msr_write(u64 msr, u64 value);
>  void hv_ivm_msr_read(u64 msr, u64 *value);
> +void hv_ivm_clear_host_access(void);
>  #else
>  static inline void hv_vtom_init(void) {}
>  static inline void hv_ivm_msr_write(u64 msr, u64 value) {}
>  static inline void hv_ivm_msr_read(u64 msr, u64 *value) {}
> +static inline void hv_ivm_clear_host_access(void) {}
>  #endif
>=20
>  static inline bool hv_is_synic_msr(unsigned int reg)
> --
> 2.50.1


