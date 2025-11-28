Return-Path: <linux-hyperv+bounces-7899-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218E4C92D2A
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Nov 2025 18:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BC93A8CEE
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Nov 2025 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C594F288535;
	Fri, 28 Nov 2025 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Q/QfJ7pD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013083.outbound.protection.outlook.com [52.103.14.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B62B285406;
	Fri, 28 Nov 2025 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352032; cv=fail; b=jvjEGu45IL2yBTGCchzJngTo3SIV/Q/r6sYwFraNvm5U/H/fC1IhxC99P68CW6CjRStBkYhGfCzxjqBCgm3Nfm4WrPxwmea2oT//5nZgN7iJaxAScusvwss2lN93oq9tCzVpd/EZ3HzRW22OWNgP+rQMElkkqdLgBekYMQTjXd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352032; c=relaxed/simple;
	bh=8y30V/JrPiezWx5KpZNJTE6JrOyHhGIzzP46LmVWEXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BaYfeeZVSY3iYXUlUmyg9NXZF/MjzZIcXqyJwDN2fOEsuBW9Q5Q918SlJWa6sOP8kbrgyMsEOvxGkrrFbVOJdpWznTA9ntM30dayURpW2DFSrCJHuFo04eFimd5KOeDLb4Q73/Tgv2liLXYGj/70kLVmSqXBIrxnsXGR/K/L3us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Q/QfJ7pD; arc=fail smtp.client-ip=52.103.14.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejS9fpLjp68WU7FmvGOiPOphiLVC+xtl4C9yaV+stBw4OMo4Vzk5sogUeLR6hvWGWoZed8NkK4UNeu15oMV2dhBGHfCZmoXluV9gPYXpf0+iqaoSWGLJzK2pAs6jpa59bjSDRr+I2V5ngykc/AGO6cuLaU/31K/uEX9xlFVRtWqK44UMVDIBfPkMQV1JswPFrF6UAGxeBIbbQxr9hl5bp8agu0m54fRUYbi1GtJlTKC09ZL3ewG220G0UMzte3LPB6hrAykNTSOfU/4gSOPHLrMxYlqjsF15z/rjyMLiCHOp01qO9+wdBMRz0Emetd87higOpJd+VPOqp18MwkGr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUDUMvIkyqBtAZTP4q6XxptOhqU7Uc7OFBIKqSgMEX4=;
 b=lHNQWxA4jpfrxPMg+sD9w89BPGdCVXkO17QC8ywQE74qi2ahVK0XRE3ZFwqtmX6RoIhxjuENQx7nlEBVTkvoq4wCC/oBCUe6/lQb/1dBorVuaVc+qipotVV8imrYmsZZWhdwqETzZkrk+U5bJahfw464wsA3TnYRO5Y4ZpGDqrJ7m8vOs3zA82lhaMx9OlTNn0+FmxC36YQIx1ZGOSZwRRSajsTH6nSdkj0F5C0KW2ZmBnDhUU7SvNqVKzytV12GyBaSFHMvw2Rugaf0T3hybwaHKr6D5f9lE+ZEG484O4i4qNRpGOVINBcmyvtGagpYj4fb4mJtr2Q8RFSMM8XoMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUDUMvIkyqBtAZTP4q6XxptOhqU7Uc7OFBIKqSgMEX4=;
 b=Q/QfJ7pDtWxQ/qfGBzYUbjIJ9+m3LLMtDJB+b/OFSaA80ROdXnLiss7yFhfXZ4FQNEGruvBgasplvOwLPJES/5o33OtlDglfuiabQkkZTQ8DzEgEHhNl8hmigUIfeT1cbCSMOzR5VuLoEeeb4FKwo7hXdcIOeMHDHhlc7C2JzSTsW3HzMbthv7Tw57VJGOY/6myfQKoU6CD33inKPz9rPu6pbQYbnwUm1xK2GoFtRCwzxemyfZsV+z2jnaIv6DZ9stkLdKrUP5Vuo3GMQllUwmpvMQ2fdLfC6dBx1IglrJ4oPt2hSETscv5JXFSCjmQVqLeb85e8Qge+tow6NCrOwg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB7070.namprd02.prod.outlook.com (2603:10b6:208:1f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 17:47:08 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 17:47:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
CC: Tianyu Lan <tiala@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] Drivers: hv: Confidential VMBus exernal memory
 support
Thread-Topic: [RFC PATCH] Drivers: hv: Confidential VMBus exernal memory
 support
Thread-Index: AQHcXXBK+tjOpvoLpkujwICroliGzLUIRIrA
Date: Fri, 28 Nov 2025 17:47:05 +0000
Message-ID:
 <SN6PR02MB4157DAE6D8CC6BA11CA87298D4DCA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251124182920.9365-1-tiala@microsoft.com>
In-Reply-To: <20251124182920.9365-1-tiala@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB7070:EE_
x-ms-office365-filtering-correlation-id: 3f14f6d6-0c1e-47fb-1e4c-08de2ea62581
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|51005399006|41001999006|15080799012|461199028|13091999003|19110799012|8060799015|8062599012|440099028|3412199025|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yS8No3SSRxkFHmeq3YUkSI1RZST79PirLeclZV+lAwXEngaaLuF+JZvZtJBS?=
 =?us-ascii?Q?AQB0ZVioBpKuJeydrMqjLcRI/5jdYfTZwtUi+8lEdcCkAEfqlCBw7Jl8pDL+?=
 =?us-ascii?Q?eTJyigCH4tOLaDb+4Kl8y9mrMKgCkPXBJZx+ui9u8Ea4O+7NedRQODwaQi6i?=
 =?us-ascii?Q?LK45cw3O8NVsD8S1aoZXUu8eVC2E+SAYtFl4ep7XYapdtKIgVpUiXxQYsdK3?=
 =?us-ascii?Q?i8wVE8c7h320mrSgbIIWGINO5gwrsAXDy8x7sHge7E8CgUi51dYcTJF0GLg1?=
 =?us-ascii?Q?wxu4lEb3nCxA7r49cBdTDHLW+Sj5XEF2Ma+Y+xcF/HJ0AsHTiv+rU/yTsOA/?=
 =?us-ascii?Q?MxbEP9KURaLTAOMWc9OGvD0a5N2MECoHuw5ZnGal8O+hPAi92gxApEReFVQp?=
 =?us-ascii?Q?qU17RQTXNJXyEdalh0Vhqgq9Choi4QG5gaGk2WxHp4A1OYKVdJyk3dxio6BP?=
 =?us-ascii?Q?tuLDtPj38EFpmQt2hTqjQDWlQbRGmEc9vnfbzfJduSAwekVLvjhar9zsotWy?=
 =?us-ascii?Q?cmaJcr0ZUEUdO4Mq3+E740WZNZOsqYRMpxkTcjr3JPBes/wpYRwFpRjUBrzz?=
 =?us-ascii?Q?hdfuC4gvDfq0t5mgCTY2Pz4mj/jMSdaJjtFCaD12Suy5NbpkESaW7d8u9Vx1?=
 =?us-ascii?Q?SFHRewlrVrDBYxcyNklM9vpWovjElay6hCj7EtRELsopwEQmuyWSJBO0wdf/?=
 =?us-ascii?Q?Bxqv3bwUFCXQ7walCC3GvSk7Bf+oDgMNU2/+GyOr1gKyHI78Oi36UuUVT4kC?=
 =?us-ascii?Q?H0sR0AqwPZI4OMdrjKvMwgzW64OZMNZA6WFznRUT1gdHVYA7hQFFJrS5KklH?=
 =?us-ascii?Q?aCtIyuf9wHaC+WItuOMah4hJwwchsGPmlyHBgBdGWWJjFrpeeHlVp2pjUrtF?=
 =?us-ascii?Q?6Mjss2xlZf2Kycu/4fvksGNLC14ECKMidcGYuE3XzrcqNJcexgA73b9qEllX?=
 =?us-ascii?Q?ZGiaeqDkpIfeQTtBzeA9MPKa1kg0VzCNYHr8xVHnwJNAU224wlt64+HSINTJ?=
 =?us-ascii?Q?7/+Gnk60PC2r1F22eMQLBdyD3aIE0VK8dWdpcCOP9nLbGFSQ0zTWBcXSfWDB?=
 =?us-ascii?Q?kH6GgjAovgxTFmhtvzK75oOuSdgOCgLyJfPn3LWS6WKBwdfX/LtrmS6NLyiC?=
 =?us-ascii?Q?hWMu9i/fO6MRsyZzndCptmWBFUnD5VWK9veNHVK+t4YlYnsxSeEei0VO8Hnx?=
 =?us-ascii?Q?g0h5C6uCAncJYbJa3UVla2nh4KT9hqqz5X//OBRjPngtN9uK3u1N/sZfB8O6?=
 =?us-ascii?Q?7j7C/+HIKDxgN2oN5yZv?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s6izGQP/INydB1EvEEUfl2fGUkIOtAyJsh+bvUReIW6P+H1EYwlTLTr7AE1v?=
 =?us-ascii?Q?LBya2ou3CjoORyoChSuczI83Ti11wZ5BYLWMoPPkGkCJ2vZqJRkbt2ZwxaRr?=
 =?us-ascii?Q?MRpS1y85UhvhPy7ctZhlGtc+tqkBO/sa3SFBkcrjKf4cp/HZkeZdBJuvXwiP?=
 =?us-ascii?Q?tdycCqhiefML7oy2jMaKkFGNIxvlFC3mIrJfheF+L2o54Wdz43Dnv2C2k91z?=
 =?us-ascii?Q?9uqva/C3opmThsxprJ9JKOONsGnvurauM6pXjPOnB69/xhP5vVwk0yGISWnt?=
 =?us-ascii?Q?WCUyCeSo/8zGM2P/scMVdaGyhh0Yve+HEE4XuANVpvTxQZzE886mI3o2XYuF?=
 =?us-ascii?Q?yHvNwRwYCyxIyb2DcDKL+r/9HyCHsZnd+LU5oU2JoMNoe1xEfH+kf/iAfbFK?=
 =?us-ascii?Q?/qqncOpZSUIPdZX4NHD9pO+3Z9eUv/pZDaTZvr/uXMEpCREMuqrAuQEZT3xH?=
 =?us-ascii?Q?0M0GRwG+aTWOvub5yXUgBP0kBqIujatVDbCCfWNJUF0c623GGASaTUCST5gG?=
 =?us-ascii?Q?QpzIGOUYax71C0LS1f2gJU6S/ZIli9gfdL+5EK/EOb82k772nz0eYcU5XaUJ?=
 =?us-ascii?Q?hU2ZAarkJF6Kw7H/UrKF1h4+IHMqRYUexZZAYGfGOtisvn4YmxtKfxndFreB?=
 =?us-ascii?Q?KUYvN5OT5KY3pIlM3LIomqeMyStORgUi6WUaLblqKbKrBFzlSZadhLonn4JR?=
 =?us-ascii?Q?CWzNX3S1Vp4uS+yaJO28e8YJB33NIs7m3a6MVeArlIAFVTHH+ClkqTUqIx8h?=
 =?us-ascii?Q?OutsajWtQhHBVLYjLKuhqufbde+/0GhL0zPFosii7nAbLnhciWBW7eV7qzuU?=
 =?us-ascii?Q?zZH2tUYLWzsnerdG7wTEZutYEfk6sHMDnSCeayG7/WWJZFagWPkdeMfzNogQ?=
 =?us-ascii?Q?xk4AK4PQQYtfhieYQKnMEKHBx/nrfMtfGtcXNFt42Z00TekhCSf6sllilCC6?=
 =?us-ascii?Q?6zOAbAY6hP+Y9zJeXob9SRgU1RHcCT5+VxonfLWSB4jG2MDuwOufLkC/Mp0M?=
 =?us-ascii?Q?/SKMrq3hlT4+s/BjRfOW9S0zGW0SAghTFqCeAzEY7D2gYo+tjhjaFLzmQWrm?=
 =?us-ascii?Q?Bf6C9tKdvLOSgZ/QcRwAruOMOB9FBM10FzhreTORbKrprnEkp5oMnLwsenkz?=
 =?us-ascii?Q?y0QB8wwYcxoN4+yUSpDwBuhmkVloNiHaRSuJd/9pGSVP0nk7noXe4DZM5csH?=
 =?us-ascii?Q?YX1yZVJloiqC2bPpQfzHOoDPS3w6cqRAEEHV9ShfXpeAgJCQ7NgLqvZzvek?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f14f6d6-0c1e-47fb-1e4c-08de2ea62581
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 17:47:06.1434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7070

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, November 24, 2025 10:2=
9 AM
>=20
> In CVM(Confidential VM), system memory is encrypted
> by default. Device drivers typically use the swiotlb
> bounce buffer for DMA memory, which is decrypted
> and shared between the guest and host. Confidential
> Vmbus, however, supports a confidential channel

s/Vmbus/VMBus/   [and elsewhere in this commit msg]

> that employs encrypted memory for the Vmbus ring
> buffer and external DMA memory. The support for
> the confidential ring buffer has already been
> integrated.
>=20
> In CVM, device drivers usually employ the standard
> DMA API to map DMA memory with the bounce buffer,
> which remains transparent to the device driver.
> For external DMA memory support,

The "external memory" terminology is not at all clear in the context
of Linux. Presumably the terminology came from Hyper-V or the
paravisor, but I never understood what the "external" refers to. Maybe
it is memory that is "external" with respect to the hypervisor, and therefo=
re
not shared between the hypervisor and guest? But that meaning won't be
evident to other reviewers in the Linux kernel community. In any case, some
explanation of "external memory" is needed. And even consider changing the
field names in the code to be something that makes more sense to Linux.

> Hyper-V specific
> DMA operations are introduced, bypassing the bounce
> buffer when the confidential external memory flag
> is set.

This commit message never explains why it is important to not do bounce
buffering. There's the obvious but unstated reason of improving performance=
,
but that's not the main reason. The main reason is a confidentiality leak.
When available, Confidential VMBus would be used because it keeps the
DMA data private (i.e., encrypted) and confidential to the guest. Bounce
buffering copies the data to shared (i.e., decrypted) swiotlb memory, where
it is exposed to the hypervisor. That's a confidentiality leak, and is the
primary reason the bounce buffering must be eliminated. This requirement
was pointed out by Robin Murphy in the discussion of Roman Kisel's
original code to eliminate the bounce buffering.

Separately, I have major qualms about using an approach with Hyper-V specif=
ic
DMA operations. As implemented here, these DMA operations bypass all
the kernel DMA layer logic when the VMBus synthetic device indicates
"external memory". In that case, the supplied physical address is just used
as the DMA address and everything else is bypassed. While this actually wor=
ks
for VMBus synthetic devices because of their simple requirements, it also
is implicitly making some assumptions. These assumptions are true today
(as far as I know) but won't necessarily be true in the future.  The assump=
tions
include:

* There's no vIOMMU in the guest VM. IOMMUs in CoCo VMs have their
own issues to work out, but an implementation that bypasses any IOMMU
logic in the DMA layer is very short-term thinking.

* There are no PCI pass-thru devices in the guest.  Since the implementatio=
n
changes the global dma_ops, the drivers for such PCI pass-thru devices woul=
d
use the same global dma_ops, and would fail.

The code also has some other problems that I point out further down.

In any case, an approach with Hyper-V specific DMA operations seems like
a very temporary fix (hack?) at best. Further down, I'll proposed at altern=
ate
approach that preserves all the existing DMA layer functionality.

> These DMA operations might also be reused
> for TDISP devices in the future, which also support
> DMA operations with encrypted memory.
>=20
> The DMA operations used are global architecture
> DMA operations (for details, see get_arch_dma_ops()
> and get_dma_ops()), and there is no need to set up
> for each device individually.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 90 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 0dc4692b411a..ca31231b2c32 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -39,6 +39,9 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
> +#include "../../kernel/dma/direct.h"
> +
> +extern const struct dma_map_ops *dma_ops;
>=20
>  struct vmbus_dynid {
>  	struct list_head node;
> @@ -1429,6 +1432,88 @@ static int vmbus_alloc_synic_and_connect(void)
>  	return -ENOMEM;
>  }
>=20
> +
> +static bool hyperv_private_memory_dma(struct device *dev)
> +{
> +	struct hv_device *hv_dev =3D device_to_hv_device(dev);

device_to_hv_device() works only when "dev" is for a VMBus device. As noted=
 above,
if a CoCo VM were ever to have a PCI pass-thru device doing DMA, "dev" woul=
d
be some PCI device, and device_to_hv_device() would return garbage.=20

> +
> +	if (hv_dev && hv_dev->channel && hv_dev->channel->co_external_memory)
> +		return true;
> +	else
> +		return false;
> +}
> +
> +static dma_addr_t hyperv_dma_map_page(struct device *dev, struct page *p=
age,
> +		unsigned long offset, size_t size,
> +		enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	phys_addr_t phys =3D page_to_phys(page) + offset;
> +
> +	if (hyperv_private_memory_dma(dev))
> +		return __phys_to_dma(dev, phys);
> +	else
> +		return dma_direct_map_phys(dev, phys, size, dir, attrs);

This code won't build when the VMBus driver is built as a module.=20
dma_direct_map_phys() is in inline function that references several other
DMA functions that aren't exported because they aren't intended to be
used by drivers. Same problems occur with dma_direct_unmap_phys()
and similar functions used below.

> +}
> +
> +static void hyperv_dma_unmap_page(struct device *dev, dma_addr_t dma_han=
dle,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	if (!hyperv_private_memory_dma(dev))
> +		dma_direct_unmap_phys(dev, dma_handle, size, dir, attrs);
> +}
> +
> +static int hyperv_dma_map_sg(struct device *dev, struct scatterlist *sgl=
,
> +		int nelems, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	struct scatterlist *sg;
> +	dma_addr_t dma_addr;
> +	int i;
> +
> +	if (hyperv_private_memory_dma(dev)) {
> +		for_each_sg(sgl, sg, nelems, i) {
> +			dma_addr =3D __phys_to_dma(dev, sg_phys(sg));
> +			sg_dma_address(sg) =3D dma_addr;
> +			sg_dma_len(sg) =3D sg->length;
> +		}
> +
> +		return nelems;
> +	} else {
> +		return dma_direct_map_sg(dev, sgl, nelems, dir, attrs);
> +	}
> +}
> +
> +static void hyperv_dma_unmap_sg(struct device *dev, struct scatterlist *=
sgl,
> +		int nelems, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	if (!hyperv_private_memory_dma(dev))
> +		dma_direct_unmap_sg(dev, sgl, nelems, dir, attrs);
> +}
> +
> +static int hyperv_dma_supported(struct device *dev, u64 mask)
> +{
> +	dev->coherent_dma_mask =3D mask;
> +	return 1;
> +}
> +
> +static size_t hyperv_dma_max_mapping_size(struct device *dev)
> +{
> +	if (hyperv_private_memory_dma(dev))
> +		return SIZE_MAX;
> +	else
> +		return swiotlb_max_mapping_size(dev);
> +}
> +
> +const struct dma_map_ops hyperv_dma_ops =3D {
> +	.map_page               =3D hyperv_dma_map_page,
> +	.unmap_page             =3D hyperv_dma_unmap_page,
> +	.map_sg                 =3D hyperv_dma_map_sg,
> +	.unmap_sg               =3D hyperv_dma_unmap_sg,
> +	.dma_supported          =3D hyperv_dma_supported,
> +	.max_mapping_size	=3D hyperv_dma_max_mapping_size,
> +};
> +
>  /*
>   * vmbus_bus_init -Main vmbus driver initialization routine.
>   *
> @@ -1479,8 +1564,11 @@ static int vmbus_bus_init(void)
>  	 * doing that on each VP while initializing SynIC's wastes time.
>  	 */
>  	is_confidential =3D ms_hyperv.confidential_vmbus_available;
> -	if (is_confidential)
> +	if (is_confidential) {
> +		dma_ops =3D &hyperv_dma_ops;

arm64 doesn't have the global variable dma_ops, so this patch
won't build on arm64, even if Confidential VMBus isn't yet available
for arm64.

>  		pr_info("Establishing connection to the confidential VMBus\n");
> +	}
> +
>  	hv_para_set_sint_proxy(!is_confidential);
>  	ret =3D vmbus_alloc_synic_and_connect();
>  	if (ret)
> --
> 2.50.1
>

Here's my idea for an alternate approach.  The goal is to allow use of the
swiotlb to be disabled on a per-device basis. A device is initialized for s=
wiotlb
usage by swiotlb_dev_init(), which sets dev->dma_io_tlb_mem to point to the
default swiotlb memory.  For VMBus devices, the calling sequence is
vmbus_device_register() -> device_register() -> device_initialize() ->
swiotlb_dev_init(). But if vmbus_device_register() could override the
dev->dma_io_tlb_mem value and put it back to NULL, swiotlb operations
would be disabled on the device. Furthermore, is_swiotlb_force_bounce()
would return "false", and the normal DMA functions would not force the
use of bounce buffers. The entire code change looks like this:

--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2133,11 +2133,15 @@ int vmbus_device_register(struct hv_device *child_d=
evice_obj)
        child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask;
        dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));

+       device_initialize(&child_device_obj->device);
+       if (child_device_obj->channel->co_external_memory)
+               child_device_obj->device.dma_io_tlb_mem =3D NULL;
+
        /*
         * Register with the LDM. This will kick off the driver/device
         * binding...which will eventually call vmbus_match() and vmbus_pro=
be()
         */
-       ret =3D device_register(&child_device_obj->device);
+       ret =3D device_add(&child_device_obj->device);
        if (ret) {
                pr_err("Unable to register child device\n");
                put_device(&child_device_obj->device);

I've only compile tested the above since I don't have an environment where
I can test Confidential VMBus. You would need to verify whether my thinking
is correct and this produces the intended result.

Directly setting dma_io_tlb_mem to NULL isn't great. It would be better
to add an exported function swiotlb_dev_disable() to swiotlb code that sets
dma_io_tlb_mem to NULL, but you get the idea.

Other reviewers may still see this approach as a bit of a hack, but it's a =
lot
less of a hack than introducing Hyper-V specific DMA functions.
swiotlb_dev_disable() is conceptually needed for TDISP devices, as TDISP
devices must similarly protect confidentiality by not allowing use of the s=
wiotlb.
So adding swiotlb_dev_disable() is a step in the right direction, even if t=
he
eventual TDISP code does it slightly differently. Doing the disable on a
per-device basis is also the right thing in the long run.

Michael

