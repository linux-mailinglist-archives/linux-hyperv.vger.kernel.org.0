Return-Path: <linux-hyperv+bounces-4726-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AC6A75AA7
	for <lists+linux-hyperv@lfdr.de>; Sun, 30 Mar 2025 17:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798FE1661D0
	for <lists+linux-hyperv@lfdr.de>; Sun, 30 Mar 2025 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41521D5CD6;
	Sun, 30 Mar 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="T+dc7Vzd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010015.outbound.protection.outlook.com [52.103.10.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A8A10785;
	Sun, 30 Mar 2025 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743348912; cv=fail; b=BGZVOlHNkaDAsIrU8YzMPAQTkGdDrRS1sJsmTWySaPj0LOqJyH7xyRTkglMENqi8o2LK8Tsb2lhVaEcvaJywesXbcS6G5Un2oCQN/JSGLMPkLo3P2VMrDtFKQzL3pdhacZYCAmBKDNzqempVAV+ZZnHlzeazuW4uoxd9HI3aWtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743348912; c=relaxed/simple;
	bh=QtZaDwPN1YNE2oo/CjiIMioeNR7Vq4pq552hdFNBefk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CXDCJ9W7o0icZinr0Uo1NspZVza+F6FEZc8GwRejivKsAHFe0pXuH41Ee3mW1cofW0OhbLPuMPnygXG5Tkj1uABCVt0ZRBHkEVeFoR3vsmrbE9kHKVBqWtpmUF9zUttbdxEuoG09JmYhri/7RD5zHUYHBLFCgVwhj9VtQRmB3qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=T+dc7Vzd; arc=fail smtp.client-ip=52.103.10.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=de4cvtzx4BWB0nv2mE8PNE4UP5WxN8wWU6fax1ynJEduOIrVEhUBnw3COVq3C8vgT0LFifaPJGRWr7qmi1wf0OnY5Djbb7Wsi0bx68+5czwZiV44JlPlQ2W88fD6QOYemGURWY6WV7xjoCl4tzwFXcJ/WAXJsg75PuODa9FfABFMScQcRG3GtCZylYh9GQZ2J4v9Gz0ep0ydXv7/zHNW+sFHbTx1LlriWT6aMN5Pm+IpUUnmBKnBhFNWXrAcOvlgQnSATeDbyRCkQiNx38Evh6DQ79NMbyG+ZYidh0YHLLzE5jiXjULO5oFDQ+QzJZRuLO7yNbghLTODRCUKgvzmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JphlOmVrX7VwWMO3gK2++7rJsqxqTDDlJxP7PFA9b/A=;
 b=k8pOqCrjxxrh/019qRNzbJhWRNx0lzsIHcqis4bytG5F0Re9zwJhsswXf4DU6SDcRS1ZzcTLbpfKWSvZ6izGY5XQolACunyKjt7L10lErjUOl1ErTVEOKmOUe5ajH8iT7hW1PWQH1+Aeq9aKX14r7TzCUNR30TROQq+dN91pQob5KGWuaIXU6ciBzPlo7IWAc6K5ALOFd5xE3SBummQn2eZnYSU+9S/4A9jq1YcTt8c+KXYtm2Cnqg8fxWvTCjzcFVGz9jlNpd3bShXtVr8b7XugBuNrfXn0TMBRwQB5DdPKGGO9+ennA4zIaIPjs+S6AdEbxmRtej6frbsbVwvn7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JphlOmVrX7VwWMO3gK2++7rJsqxqTDDlJxP7PFA9b/A=;
 b=T+dc7VzdamQh+7zrROxsISpQzYSylxcQ8kNcJ4hMOHxP9pGLpw48QWq1dyjyn+JW7ugjoMnwFA14YT0ESV1051Z4w6TQbOR1fpR4e8j+Gqb8M5G4pfHi9aYyP/5spA/+pyZXinkebeVLQzlwnbxoxaB4Hd+mG4gscZJvSDoQ2jPYbFwyTquAzG8MY6rLCN1XwNB7UFmEIDV+/SEOdX7oc3OLTh81wknQrACyizyT0GyneEQWAKeMfSa7mxaHCo++o8lTtlBYBEs4EZVBy2PFtAEQdJmJv/JGUaPfQh2LLs32Y03skGrKeanqtcEdxWySNNLEF055jVELifRRPy51DA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8301.namprd02.prod.outlook.com (2603:10b6:408:158::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Sun, 30 Mar
 2025 15:35:08 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8534.043; Sun, 30 Mar 2025
 15:35:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Stephen Hemminger <stephen@networkplumber.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@kernel.org" <stable@kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>
Subject: RE: [PATCH v3 1/2] uio_hv_generic: Fix sysfs creation path for ring
 buffer
Thread-Topic: [PATCH v3 1/2] uio_hv_generic: Fix sysfs creation path for ring
 buffer
Thread-Index: AQHbn6IrKYXAJchAMkyOzI/FdAL+pLOLz/aQ
Date: Sun, 30 Mar 2025 15:35:07 +0000
Message-ID:
 <SN6PR02MB4157C74E0E83E63175278153D4A22@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250328052745.1417-1-namjain@linux.microsoft.com>
 <20250328052745.1417-2-namjain@linux.microsoft.com>
In-Reply-To: <20250328052745.1417-2-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8301:EE_
x-ms-office365-filtering-correlation-id: 24fa2aec-193b-49b7-861a-08dd6fa0738e
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|8062599003|19110799003|8060799006|56899033|102099032|440099028|3412199025|12091999003|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jJ3H8lYQwweFjUr6o9BkRazs82f9SiK/C6UN4vl8EsBM9FVvtvK1okYKJmN2?=
 =?us-ascii?Q?kk3elpEF8VJtvY2Jl2Y1+pPTyP0G8cVS/nhsLkQ/5Od/tiikbgHVlAB4TB1e?=
 =?us-ascii?Q?a+dYy4R+CdFwiz7d+y6dihSVCmW3HGQ/n7VEc81hzhmh9PB+oRwXUfUKySMF?=
 =?us-ascii?Q?Nz1Fze3tAqy1nwa/xMrEiuqhIp/B24fa0hk4MtlaxXhf4TllF9mV9jLkU7YA?=
 =?us-ascii?Q?6jvvWTyZ9S6F1w5AgruoXVNw3ySDVWRy7h4ZvMonECexs1TWVIhE//68mHkD?=
 =?us-ascii?Q?Ecl8i4JcXGlcvV1l5wzF8E9V2tNpsDO6dPltCjCXS3t5KIblOI67mOtpBmx+?=
 =?us-ascii?Q?PLcfjnLruZ/TIRk3HM6ZXbws6yKpFsjzGjtnMt6GYWfmWS4/oTpk6NG+17xF?=
 =?us-ascii?Q?WSlCCB2/NkpjokhIniKasK4HpC5QQ0l/9VHvHKTTq1A1Hhtkis/zELm0iZam?=
 =?us-ascii?Q?CCT+ybdrlbKcPtYeTeX8QFw1ZhjoDVmT7f65vI9r3vwgLHHCTIgoBZGvbgLZ?=
 =?us-ascii?Q?0jm3FfBZJNbjVqoEMRuhWfq7mlMxN1Ht05yFqbBrHiH2YYrf2I0H7clk9s6Q?=
 =?us-ascii?Q?NsspTd/AI0OXg9/afZUdLyPIU4FtSO91L2nBXXzgTG42skPKW3hflz4aOM44?=
 =?us-ascii?Q?87anpxOhsj1RhYiwWcXuhOV1gTa7bvmEltmYM6yVRGabEh/SL3sUXW3Hfhy6?=
 =?us-ascii?Q?khUDzctExchFGebe0oml5fMoq5BSwaIn+wfwXgfY44S8W2g23/vI+mlro7gu?=
 =?us-ascii?Q?oVazN2F5UZcv6SoiuxPkIxAspbpx3ADd64frd9zhpMSKy5f+8F9wfp3PDmOh?=
 =?us-ascii?Q?pn/N9VMmtAo90KPEBqj4nkescLil2bFrzAW9jUyKZ76zZ+6kNxiqtFEq4DWy?=
 =?us-ascii?Q?Y1uxTtAWrWcDzwOgvGRH8T36S3ChrSEvrJY8CxwaJ9HFkg7mmNUcoNtrZSfq?=
 =?us-ascii?Q?EPmFebKVco6UN20FfBQ9id2h4pmWFu4sSPwG00yASrV3ooFccV0OxzhRtASz?=
 =?us-ascii?Q?SKCdse//wLgpnxD/FudD01jqx0mvjCWe65uxAfCX1efVyieM2GguMepEYzO8?=
 =?us-ascii?Q?QO7XY1Kttfqc6eXUM7bd2j6GorZLELxplGmh5QZg6wV3jV2KW1tzvfCdsay5?=
 =?us-ascii?Q?zn1agRsElQqjHDUtn6JdCbgqPtEEmmGjkA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DXiLawCeFmiSs2+sjPYzHIpSAWdEuFrCCY+Om+8FYGsTnUQ6Z/XQZNJhVK+6?=
 =?us-ascii?Q?qGgS1Ak/CTq/IB9MTneN5Q/SW0GSqklM2Done90mPBvEdRHuZIAsKJrgFSc2?=
 =?us-ascii?Q?dSE2rvnN3QBB7LVHAFs02+qHIjHOOoHnlXOvZ4TD4M7sNIHdEhmdAqLGpAK8?=
 =?us-ascii?Q?mjEWisGRW+05sux28Gh2tKQpp9odSWBv7hxaETBi69mEuB0ved35BvOeN0mz?=
 =?us-ascii?Q?a2JrN/YhaIeSBOcN0hpjFEGMYO5WKkmPs6jUlJA+NXr+u517z5dVXKvy+np3?=
 =?us-ascii?Q?lJ+m5Y7lQgGq+YnwkIVyIfVuQpDW8F8zGpqJWuzJJetuGAvA92Ms5j3ABwx0?=
 =?us-ascii?Q?R6wY/bWl8qwCgK0bpkWrfvKLOnPvK0DncSY7Q4wK64TuOQpA5PIvnNkI5jkW?=
 =?us-ascii?Q?CVfLefOTbg3J4h/lQZA6EulJppm9Um6/tQmkx6OS1r/xy6WjPGRt/wVEbvxl?=
 =?us-ascii?Q?8W2am0LBOFd4bo+MQKXWZH9P4dVsPeN1z8XECska9YqvQiMADDDglhB2RKiY?=
 =?us-ascii?Q?GFd/HAfopK7RqGy37bmhwatcr98ZCjPgRIZyr7p8H3n8Jo14XrSHxEjiROkV?=
 =?us-ascii?Q?69ZotX2x4DvLzCLLFoNu58gc6KfsMvxwXwWb2SehZSh1uICI8DpB9OObl8pC?=
 =?us-ascii?Q?ql6FcJgumDVlWsOzhU4spvjaZGIf6J56EuBhJ9kiKxaxTuOVW16mVMD1vT22?=
 =?us-ascii?Q?4tAmR5A+xYQT606IMMv30ZuWGByAtVwy+Kje9sc86CI5otvaFPNnKadTZq7J?=
 =?us-ascii?Q?sWd2NnhJgCgNmVOLRkRwb3IcSJqSWpk1qsqpGIdggzjDPHkWK4jHg0eujm6B?=
 =?us-ascii?Q?mOk7sU81vbrdrlU68cqjg3jGh2RFQGSlFX8yHMXhAxzmRpjHo2EYUGha4X2h?=
 =?us-ascii?Q?7DOTtiPotp6DCduOrrpB3KxYn9/ePrgYxPhhWYoiz4MMEq6fJ9SoK7HnBm4N?=
 =?us-ascii?Q?/Cm8A8aHxf3PpkNGdLkLXD0mw76Kkx0zYSOXfHjoMvRYgl8ZykDly9R2GLkJ?=
 =?us-ascii?Q?eeGrUoshKo6lLe9sMPxVo9eudIrn7J66BlVL72n9QNmYdFxRRAeS1DIbwim0?=
 =?us-ascii?Q?BGHv0whW5bTEfxAkUXjwsDu6tR2nG0T/z8T8dbIlv4XoQGgT310DXLcOxGph?=
 =?us-ascii?Q?Suy2LSgyMcvVdOio18ej9YVk0gKqJYG19hK/sFIoTy7PpSnFZuxt6QyGZBTU?=
 =?us-ascii?Q?52NmsBiN/I4ES9vz+tvFxTbm7RS+L2gSVHF8DGtYwdqWLB3RXFbDMd3O52k?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fa2aec-193b-49b7-861a-08dd6fa0738e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2025 15:35:08.0207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8301

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, March 27, 20=
25 10:28 PM
>=20
> On regular bootup, devices get registered to VMBus first, so when
> uio_hv_generic driver for a particular device type is probed,
> the device is already initialized and added, so sysfs creation in
> uio_hv_generic probe works fine. However, when device is removed
> and brought back, the channel rescinds and device again gets
> registered to VMBus. However this time, the uio_hv_generic driver is
> already registered to probe for that device and in this case sysfs
> creation is tried before the device's kobject gets initialized
> completely.
>=20
> Fix this by moving the core logic of sysfs creation for ring buffer,
> from uio_hv_generic to HyperV's VMBus driver, where rest of the sysfs
> attributes for the channels are defined. While doing that, make use
> of attribute groups and macros, instead of creating sysfs directly,
> to ensure better error handling and code flow.
>=20
> Problem path:
> vmbus_process_offer (new offer comes for the VMBus device)
>   vmbus_add_channel_work
>     vmbus_device_register
>       |-> device_register
>       |     |...
>       |     |-> hv_uio_probe
>       |           |...
>       |           |-> sysfs_create_bin_file (leads to a warning as
>       |                 primary channel's kobject, which is used to
>       |                 create sysfs is not yet initialized)
>       |-> kset_create_and_add
>       |-> vmbus_add_channel_kobj (initialization of primary channel's
>                                   kobject happens later)
>=20
> Above code flow is sequential and the warning is always reproducible in
> this path.
>=20
> Fixes: 9ab877a6ccf8 ("uio_hv_generic: make ring buffer attribute for prim=
ary channel")
> Cc: stable@kernel.org
> Suggested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/hyperv_vmbus.h    |   6 ++
>  drivers/hv/vmbus_drv.c       | 110 ++++++++++++++++++++++++++++++++++-
>  drivers/uio/uio_hv_generic.c |  33 +++++------
>  include/linux/hyperv.h       |   6 ++
>  4 files changed, 134 insertions(+), 21 deletions(-)
>=20

[snip]

> +/**
> + * hv_create_ring_sysfs() - create "ring" sysfs entry corresponding to r=
ing buffers for a channel.
> + * @channel: Pointer to vmbus_channel structure
> + * @hv_mmap_ring_buffer: function pointer for initializing the function =
to be called on mmap of
> + *                       channel's "ring" sysfs node, which is for the r=
ing buffer of that channel.
> + *                       Function pointer is of below type:
> + *                       int (*hv_mmap_ring_buffer)(struct vmbus_channel=
 *channel,
> + *                                                  struct vm_area_struc=
t *vma))
> + *                       This has a pointer to the channel and a pointer=
 to vm_area_struct,
> + *                       used for mmap, as arguments.
> + *
> + * Sysfs node for ring buffer of a channel is created along with other f=
ields, however its
> + * visibility is disabled by default. Sysfs creation needs to be control=
led when the use-case
> + * is running.
> + * For example, HV_NIC device is used either by uio_hv_generic or hv_net=
vsc at any given point of
> + * time, and "ring" sysfs is needed only when uio_hv_generic is bound to=
 that device. To avoid
> + * exposing the ring buffer by default, this function is reponsible to e=
nable visibility of
> + * ring for userspace to use.
> + * Note: Race conditions can happen with userspace and it is not encoura=
ged to create new
> + * use-cases for this. This was added to maintain backward compatibility=
, while solving
> + * one of the race conditions in uio_hv_generic while creating sysfs.
> + *
> + * Returns 0 on success or error code on failure.
> + */
> +int hv_create_ring_sysfs(struct vmbus_channel *channel,
> +			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
> +						    struct vm_area_struct *vma))
> +{
> +	struct kobject *kobj =3D &channel->kobj;
> +	struct vmbus_channel *primary_channel =3D channel->primary_channel ?
> +		channel->primary_channel : channel;
> +
> +	channel->mmap_ring_buffer =3D hv_mmap_ring_buffer;
> +	channel->ring_sysfs_visible =3D true;
> +
> +	/*
> +	 * Skip updating the sysfs group if the primary channel is not yet init=
ialized and sysfs
> +	 * group is not yet created. In those cases, the 'ring' will be created=
 later in
> +	 * vmbus_device_register() -> vmbus_add_channel_kobj().
> +	 */
> +	if  (!primary_channel->device_obj->channels_kset)
> +		return 0;

This test doesn't accomplish what you want. It tests if the "channels" dire=
ctory
has been created, but not if the numbered subdirectory for this channel has=
 been
created. sysfs_update_group() operates on the numbered subdirectory and
could still fail because it hasn't been created yet.

My recommendation is to not try to do a test, and just let sysfs_update_gro=
up()
fail in that case (and ignore the error).

Michael

> +
> +	return sysfs_update_group(kobj, &vmbus_chan_group);
> +}
> +EXPORT_SYMBOL_GPL(hv_create_ring_sysfs);

