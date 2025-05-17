Return-Path: <linux-hyperv+bounces-5543-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D7EABABE9
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 May 2025 20:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699093BEBA0
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 May 2025 18:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B61195FE8;
	Sat, 17 May 2025 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WjW/qBTP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2019.outbound.protection.outlook.com [40.92.46.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2541136358;
	Sat, 17 May 2025 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747507648; cv=fail; b=vBRPdXtHQsYOqN4AF7+gjcOoPXBx0TAUKZf5ff6JYfZMFQ7laBTXDNHfyIHgX7vV8cBzo1dE4RGJpQZ0nBctekMuTmoDyn+7bjHUHAn1yVvYFXaddP/QOG6iXnYE5iEGrtLFDhB7j04CFBBdyEPtGJ7y8UzTfQ9zFqVlUkKWdUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747507648; c=relaxed/simple;
	bh=2mRbrcbscmu3f0T8/UI263uSKKqgZo1Tt46ZwGpItu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dLjJbY9TGgPpIJp6Y1zkPgG3UQn496k0fnyL5YZEkOiT8M0uy3T+eCa9d7ily5XSm7SOsuzEwYFIk6RFe2DRhNAmrFPF8ae9RwT+TxiEuyBNtk3Vxd/LZ5dfTPdb3GuoJgB1EQcQi9tc2eJXxKGBDsWVi/1Cx+MwWiZWxbRanC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WjW/qBTP; arc=fail smtp.client-ip=40.92.46.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgS7EHd2xW/JZQa8GLTCvpxDcDkspp/EbwW9dyt8m0g4RkQ3OxmR6ka3gSkpA2MQzu9nnuBUWJRtYAcDhWU+yJbCgsA1vS97lcBN5HYv9pHVRhUSa+81pCF7JPdUQ99x4yt4uFcGoP5DldoVy81KDVhM3BtpRNEk5Uap4abfIbIq18Ur/Yz18dys30ZpD9JFNobJk3X2UJ5q6pPZKtLatzRiBjO11KTVqCsOP759Ak7n9fsL23o6YsglfU2XYl8kQtzYowULmCvEvYS7vvvZVV8KywcF3iIDA+a84vK6T5KEjzQr0oOz2uQFD6kj5Il7jzPRJgfbuE4BuD9gA3248w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mRbrcbscmu3f0T8/UI263uSKKqgZo1Tt46ZwGpItu0=;
 b=Y1byhDYjz5EbNmL71QB0KMnacqKzO1G1o4axZPxFqjUr1RKKMBAuGlMc2pVzSw7iYI6oNjuQO+K+8zV1vipWO+9Dbz2gTLKZ5BDcpvTBfUzVi2VeUKFJImZbfJdvLQHrKEHZpNI/ZCLS265U7vf6/u0rutrvw1Ep0wrXSYVCEhs/qSO+9+OXeqcxHZqxYUKVOJCt5UtlLdZPKsxUAec0ueXT+3b7Zpx5SPLVYklCFfa4WYkZz9RXve/ZQqkBgFARhBZbvIn/bPG4DDvPrf7rvYBKy249RVIue1XpLxLb7OAKjTlPdHSYTFW8cSSva1n3qrixg1XYwhzWs7+hyQM/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mRbrcbscmu3f0T8/UI263uSKKqgZo1Tt46ZwGpItu0=;
 b=WjW/qBTPrvsFaz/xLPNn33XqpmawjJXW2QxZvXfnBncTDZd5Xjzpe1yX9sktk4Zz2dZGltWkcC/YyuRAf7z4p+y6oDtGpPsHa2zPV60MIPQM4LrNoDjuK5WXOBkF5luuFyQjH+z40SnIPZYwiq8mjRRbaDCyv2iV86lXjmFduPvyV4dIQYfMC75EXDfTP3WWqUvpVE3p2qJkwC+geFGG2ktHcuLjY6ofS7EFLww/Y/A+Lhfps2QGhtfwrQ3GLNQme4VMuCWksS0MLCJU1PiWDnq/VKzGRDNxGBHPS7MV7P5ZclbtSNiCSbM49daq1SRCJQnzWMMP5I5QeiAlfWhDkA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB8929.namprd02.prod.outlook.com (2603:10b6:510:1fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.24; Sat, 17 May
 2025 18:47:23 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Sat, 17 May 2025
 18:47:23 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC: Saurabh Singh Sengar <ssengar@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"deller@gmx.de" <deller@gmx.de>, "javierm@redhat.com" <javierm@redhat.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 1/1] Drivers: hv: Always select CONFIG_SYSFB
 for Hyper-V guests
Thread-Topic: [EXTERNAL] [PATCH 1/1] Drivers: hv: Always select CONFIG_SYSFB
 for Hyper-V guests
Thread-Index: AQHbxr50JRYwwviVjkKTy5BtFNRPi7PWPWqAgACTq0CAAC7cgIAAKlIw
Date: Sat, 17 May 2025 18:47:22 +0000
Message-ID:
 <SN6PR02MB41574848C3351DD1673A2855D492A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250516235820.15356-1-mhklinux@outlook.com>
 <KUZP153MB144472E667B0C1A421B49285BE92A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <SN6PR02MB41575C18EA832E640484A02CD492A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250517161407.GA30678@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20250517161407.GA30678@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB8929:EE_
x-ms-office365-filtering-correlation-id: 9d2b9fd6-9979-4f09-139b-08dd957342a7
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|15080799009|8062599006|8060799009|4302099013|3412199025|440099028|34005399003|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5LwChulKUZg4CoO52jl+VYXoohQRB5V9bfzccDwIPM3/u9SI16mOrlQ3cZ3O?=
 =?us-ascii?Q?qQxsjB3iuVhEkW5y2OKlN+5jbuYDzwHZ+FMCwG3aM/i6bRM7xbEFDV6icyYZ?=
 =?us-ascii?Q?DTNYChitD+TIZALnr7b3QSRBusZaOJY7+C6H/ktT/f74fHlFC1qLDsEarVGU?=
 =?us-ascii?Q?tMmRdoUhfoeXHabkKJOs680ST2FqU+J/vIjmuPtTRvvdx9u77yAUAvgged7m?=
 =?us-ascii?Q?NqGZR9JfQe0WgIKv/JpjWmh21kb5CFWA7bVEo57B6wExkH2WYyQInx+vk69H?=
 =?us-ascii?Q?CCZ0bnWxZUfbIMK8KthWhutMm6t9CTR8TLqgbnEHogj0BIXCjjtpouLUv8Gi?=
 =?us-ascii?Q?K68NShiLXIuE45wogoDzYm1IBWso0ru/Qjyzh4pbPvUqlWjowYLXmHtPb6zr?=
 =?us-ascii?Q?2q6eTMU1ezxE2OAHep3sFN0nZLvC/qP7Up1P6Lsynzu5WC9lJku5pmybbrNa?=
 =?us-ascii?Q?zpfvtPUqyKw+no5Vy+UtwhloBN52Eqp73xQVif1FUPuz5N9dxOmlkaM1Nh8o?=
 =?us-ascii?Q?4DLIBEsySMSl1UzujntoKCss2jT8szrZHpvXmGEIrCBPO45yDN6z2KDnAhPV?=
 =?us-ascii?Q?AsQyKOnR1Nsaabo5evesLG5tSKtpOVs9Vk/TxSRLInpNzl1WlvI9H6LxBde+?=
 =?us-ascii?Q?Ro7Vn+gJeRyCI+O6zFCZX21zqitcWdCjT11AnVHCzlJY4+QW0vGkKamhqlEi?=
 =?us-ascii?Q?VkNRrQYucU48vkny7zbIinQpo+eRpcq/73j22AA6zj8YRZy+DDz2SP+ToVPW?=
 =?us-ascii?Q?Zwp4vBCb4NOv9TP/C9zJXNu02FfnBIN8LQ/Y5IFGBJa8KQNi56ae8mEl0pSS?=
 =?us-ascii?Q?3A4bJ/YDINT/fcklIIyMbABSJF/xIlkHJt7nAs+sbn/3bngyAxGb+fQZQcZQ?=
 =?us-ascii?Q?FXlTpuzU3QQ/JmrGdp1lgLuAUOHSv4+X8Uw0As02dekRFPUbnydHVhHfazNA?=
 =?us-ascii?Q?liTE0wzD9c/QbuX853aCetSOQ9WTfYgaCOzslAWj+vEPJ/dGy043+3R1Fyea?=
 =?us-ascii?Q?VYgsp6SxzGBVLpWe8XAOY+8YvO5Tsqax0l5rSCNpenGnOVgtpz0A4H73tPZb?=
 =?us-ascii?Q?ghpPOnMc5TRmKArsokaojp1lB5mLBN0oU4BEb8h/nDY2Ra81Ays1kQ1eQ4aV?=
 =?us-ascii?Q?lYd4EtOXXv9/0cFwWt4iEg0DJbMJOssU2bQTkwIFxXRXOmwIN7pQvqJpwBEF?=
 =?us-ascii?Q?v/XEHoccpFQzFkp4GBfgESHiNGJ73bQFVgL0gKzqkf5qdiqHKSrXC6aKang?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n+G0On+fZSRkfdoiq783ZLx4cgNQqSRpkGGxQ/VHh6awKGevDCOOyhFUvRUY?=
 =?us-ascii?Q?EC5sHTzUJ96CUX4npeUM0UbVfapTBw+8q/z/gET1S6tfVVnvH/izx8ZHc2Ek?=
 =?us-ascii?Q?UIfep0sw8zopRaTfOQoijg1ExyteLYVF55BD1VlZJZpwS8XVJfTR+rdgrMWQ?=
 =?us-ascii?Q?NWYww1/uDCfEJHDtTvVVv25ubNY0sr5chKNx335EJlAW5Fafis9moUJFsD7Y?=
 =?us-ascii?Q?nWNVCewCpkBCH2Gb7JN10cHqj+oY37uqkjJEMkXOAAzxPP2QxXgOZNsSPBvd?=
 =?us-ascii?Q?VqLV+d4UeC7r1mRWBWChVRr7R3MGmucfEZfhTpVHjBVvWCTCYcLnWBbd6b2T?=
 =?us-ascii?Q?pTKnXA5b7aKBTJ1QTR4SudgYUavoz8231bXFZdf34aaDEF6zVovBiUTpjtnL?=
 =?us-ascii?Q?C5ID1p7T6HyoLyFlMVAdVVUmesQeVHbpHZXoVBoSFpgPmf6Oihpz72MGiSkW?=
 =?us-ascii?Q?xv48A0rZ+Xopo9KLW05xm7KbPjSscVfYs5P1OwrA2MavLIhAbmBymja8UQl7?=
 =?us-ascii?Q?119HvPQCwalrEHUA3Il8iUARoK9rSh46THe6rhYf0N99S4A12gkPAP4RWmmn?=
 =?us-ascii?Q?/0RtMGmVaPXlajhZzrBEHo5K+kD48jXRd3xriw3TxavuZEwyukZbZxH3S0f/?=
 =?us-ascii?Q?a5XL7RBNwqdlzoNlHf26PGKjXHgAbiT6V4IiL8WZ4+csLt2XtcwgMZnCRY2x?=
 =?us-ascii?Q?Rf/TA1Gd5TcvlF1ss0mt7HQLMzMMMB/FB9pd9U5eZnJwCaanGnOW0059j5cV?=
 =?us-ascii?Q?1YnfU6T1VFThbivqmvkUa+FZnldXb80fSGm7LBqE9rjE5S4DIrc6RDZQEpbD?=
 =?us-ascii?Q?hy3VeyQjRnxN9Lg3dcc7eLTxUHFAZcT7j5qDo6T0mEE5ZWQVL7YtnGKa74TY?=
 =?us-ascii?Q?e3OH/2CD4d4B3lNqFJbckcUpgLWy2H03rYNZIU4juLndcoFGJX5VaBX+bYDC?=
 =?us-ascii?Q?bnoPLMNQBv76lMB1qOUtdb51ZeofF5p6g+kQdu3bhWJp9yM2Ls3OGQ5+irep?=
 =?us-ascii?Q?12z+NNhu7kd2jnt0LuVepWh3NTYMcwsP6YUAHk4IX9d3v7dHNmyf72m1xHfE?=
 =?us-ascii?Q?PIxrbY08a7HwGt/il+0oJ/w0cCYN8pkRDp4D9KjH4Nmjga8nducwKHH1NIY0?=
 =?us-ascii?Q?ROW48jSthcAN6KOvEPia/GHO6VMANeGdnOPg4qHAyIue7sBSAMQcLTOSftY5?=
 =?us-ascii?Q?nr0eSyxSOqr5iMqDAHclMYPgWDZO+Ykp+M0em43k2ukbwtXTMQi0IH/9MCw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2b9fd6-9979-4f09-139b-08dd957342a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2025 18:47:22.8353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8929

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Saturday, Ma=
y 17, 2025 9:14 AM
>=20
> On Sat, May 17, 2025 at 01:34:20PM +0000, Michael Kelley wrote:
> > From: Saurabh Singh Sengar <ssengar@microsoft.com> Sent: Friday, May 16=
, 2025 9:38 PM
> > >
> > > > From: Michael Kelley <mhklinux@outlook.com>
> > > >
> > > > The Hyper-V host provides guest VMs with a range of MMIO addresses =
that
> > > > guest VMBus drivers can use. The VMBus driver in Linux manages that=
 MMIO
> > > > space, and allocates portions to drivers upon request. As part of m=
anaging
> > > > that MMIO space in a Generation 2 VM, the VMBus driver must reserve=
 the
> > > > portion of the MMIO space that Hyper-V has designated for the synth=
etic
> > > > frame buffer, and not allocate this space to VMBus drivers other th=
an graphics
> > > > framebuffer drivers. The synthetic frame buffer MMIO area is descri=
bed by
> > > > the screen_info data structure that is passed to the Linux kernel a=
t boot time,
> > > > so the VMBus driver must access screen_info for Generation 2 VMs. (=
In
> > > > Generation 1 VMs, the framebuffer MMIO space is communicated to the
> > > > guest via a PCI pseudo-device, and access to screen_info is not nee=
ded.)
> > > >
> > > > In commit a07b50d80ab6 ("hyperv: avoid dependency on screen_info") =
the
> > > > VMBus driver's access to screen_info is restricted to when CONFIG_S=
YSFB is
> > > > enabled. CONFIG_SYSFB is typically enabled in kernels built for Hyp=
er-V by
> > > > virtue of having at least one of CONFIG_FB_EFI, CONFIG_FB_VESA, or
> > > > CONFIG_SYSFB_SIMPLEFB enabled, so the restriction doesn't usually a=
ffect
> > > > anything. But it's valid to have none of these enabled, in which ca=
se
> > > > CONFIG_SYSFB is not enabled, and the VMBus driver is unable to prop=
erly
> > > > reserve the framebuffer MMIO space for graphics framebuffer drivers=
. The
> > > > framebuffer MMIO space may be assigned to some other VMBus driver, =
with
> > > > undefined results. As an example, if a VM is using a PCI pass-thru =
NVMe
> > > > controller to host the OS disk, the PCI NVMe controller is probed b=
efore any
> > > > graphic devices, and the NVMe controller is assigned a portion of t=
he
> > > > framebuffer MMIO space.
> > > > Hyper-V reports an error to Linux during the probe, and the OS disk=
 fails to
> > > > get setup. Then Linux fails to boot in the VM.
> > > >
> > > > Fix this by having CONFIG_HYPERV always select SYSFB. Then the VMBu=
s
> > > > driver in a Gen 2 VM can always reserve the MMIO space for the grap=
hics
> > > > framebuffer driver, and prevent the undefined behavior.
> > >
> > > One question: Shouldn't the SYSFB be selected by actual graphics fram=
ebuffer driver
> > > which is expected to use it. With this patch this option will be enab=
led irrespective
> > > if there is any user for it or not, wondering if we can better optimi=
ze it for such systems.
> > >
> >
> > That approach doesn't work. For a cloud-based server, it might make
> > sense to build a kernel image without either of the Hyper-V graphics
> > framebuffer drivers (DRM_HYPERV or HYPERV_FB) since in that case the
> > Linux console is the serial console. But the problem could still occur
> > where a PCI pass-thru NVMe controller tries to use the MMIO space
> > that Hyper-V intends for the framebuffer. That problem is directly tied
> > to CONFIG_SYSFB because it's the VMBus driver that must treat the
> > framebuffer MMIO space as special. The absence or presence of a
> > framebuffer driver isn't the key factor, though we've been (incorrectly=
)
> > relying on the presence of a framebuffer driver to set CONFIG_SYSFB.
> >
>=20
> Thank you for the clarification. I was concerned because SYSFB is not cur=
rently
> enabled in the OpenHCL kernel, and our goal is to keep the OpenHCL config=
uration
> as minimal as possible. I haven't yet looked into the details to determin=
e
> whether this might have any impact on the kernel binary size or runtime m=
emory
> usage. I trust this won't affect negatively.
>=20
> OpenHCL Config Ref:
> https://github.com/microsoft/OHCL-Linux-Kernel/blob/product/hcl-main/6.12=
/Microsoft/hcl-x64.config
>=20

Good point.

The OpenHCL code tree has commit a07b50d80ab6 that restricts the
screen_info to being available only when CONFIG_SYSFB is enabled.
But since OpenHCL in VTL2 gets its firmware info via OF instead of ACPI,
I'm unsure what the Hyper-V host tells it about available MMIO space,
and whether that space includes MMIO space for a framebuffer. If it
doesn't, then OpenHCL won't have the problem I describe above, and
it won't need CONFIG_SYSFB. This patch could be modified to do

select SYSFB if !HYPERV_VTL_MODE

Can you find out what MMIO space Hyper-V provides to VTL2 via OF?
It would make sense if no framebuffer is provided. And maybe
screen_info itself is not set up when VTL2 is loaded, which would
also make adding CONFIG_SYSFB pointless for VTL2.

Michael

