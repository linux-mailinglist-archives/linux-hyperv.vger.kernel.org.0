Return-Path: <linux-hyperv+bounces-5827-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E01AD3EA5
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 18:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC713A2C28
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB111F0984;
	Tue, 10 Jun 2025 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CXd+esRY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2022.outbound.protection.outlook.com [40.92.41.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE88BFF;
	Tue, 10 Jun 2025 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749572231; cv=fail; b=IQiR8GOPyRMUudIh6QiUjJOeourWIdA3Ree6iryf6B3oUJ3thCN8Af2hmaQBO8wzKsQcmNF+nsRSFMemtK6zLIbgRBhdtjW8bzsk7PtdnsN58QgVTg5E89ru07e1s6PYlj4mUBqxiZ0UJkfh5O07CfYopstOLqQX1dBeDQQjzaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749572231; c=relaxed/simple;
	bh=F5mYLAc6dbzhup2XF9WNXXXlMOZLJqgUl1trpoAGc5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FnmvUok0bFhe0sPLdS6zT6ED2KxbWhjPT2GMgfkx7vN3eSYSAJEv1cHI8BH9989q0nP57XurK4g2OxeXVpnl+GNi10pHBIDYvcA5cIZfTvaVGTS2JJO99ZqF5INhVIpP9A299A2o4BkEc54nZF5Of8o/dJpe+whpC9B/wobXxp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CXd+esRY; arc=fail smtp.client-ip=40.92.41.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPtqMeouu7pvLMSvSngwD87n3qe/25usR9uYfTKO8rvY2sowjtB8lIb6XGW92GUdMpRorDCi22fKage8SmGGWMfQK/P8O7LNgNPPDg3tHc7MvfG+0tQ7ngw6I8YbySPy+nQq27ynnGY4+GI026ldma1p/W2+xUp+HgAb3vUzQN2Mja3vADGRHdvAer0foufBxxdiVSjMxGpcrvxoY2xJSmreCTWy/K/gxTDB/GJWjhCD/1JpJz9z1tReBC2lDWU+DWrsd+zAUo/0JEe6qfH/xFQKmXRzFegMAE7+WI/QpdbgKn8Iy2jf/mbwsWYIIMnYlKEaLBhUAdZkgGmlE+sR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnGvpIRuZMiaJ55dNeumFgQJxfOigB8U/o9LvlI0Uq0=;
 b=DI2qk4N8CxWaZGZ7ngYG0pfX/5O6Rf0bZaB4MhJOELIqxuALTuuyImP2M+mB/vPzj6LNc0lUA4qKDxOfYNQpyTzeUmWzSHmg2bb+IIl9dkPMxjaFLgOAiS5zrB4Et1BpLxkj7y4Y09kU47XLBC5oWIEMm+2LhFjKTtnCwG9XX35cBtTAxFnVgvxUy3KUICRKlLtaYWpKtv5JrZsmU+/MxsTlBHQM0xvV74od5sCwXeJ8Xsc2aeG/XnkXxtobDYmJAFsBYphYdn8kxSNA5BuYWsDSk/SGtNjk4/YjdSRtweOaHrk40iXuh5O+sC1jMnI4taDsyVKu93ZB3GsvzG2hLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnGvpIRuZMiaJ55dNeumFgQJxfOigB8U/o9LvlI0Uq0=;
 b=CXd+esRYg7/oOGTy6YGcMyRdjixSOVLNXU9zGCrx0G9c5bgK9HKaGTBmVdWdI0ISVpft5z808i0VkvuS3QBFj5mtONaFXO7+g2YNo4DZMy2tL1RVVKYAg/sKYjwrbbeFpSpUVZyJA3QQbZ0NJX7Ykrgr6iq2ga0rtG+4EdAe+1kYw5sxs8+AuGxp48rz1efKC0gUNKGPPXsGyhemX3guB8qqM5UlGkg2c9aRMNe+AWshy+wHHrunLhPmGJFn12a73nj5dDm476ou5nQaCwBpZMAGTXjHajj2O/YVbMa8c70eu+xe9j5HBL4dTYV+jFEBNW85Mq1pP0eS0+2zyCfyMg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA3PR02MB10770.namprd02.prod.outlook.com (2603:10b6:208:50e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 16:17:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8813.016; Tue, 10 Jun 2025
 16:17:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Arnd Bergmann <arnd@arndb.de>, Roman Kisel <romank@linux.microsoft.com>,
	Arnd Bergmann <arnd@kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH] hv: add CONFIG_EFI dependency
Thread-Topic: [PATCH] hv: add CONFIG_EFI dependency
Thread-Index: AQHb2eia04zHIDnue0WZOFD8f2qY5rP8hlQAgAADWgCAAAFzcA==
Date: Tue, 10 Jun 2025 16:17:06 +0000
Message-ID:
 <SN6PR02MB4157CE643DEB6CE4B0AEFC00D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250610091810.2638058-1-arnd@kernel.org>
 <20250610153354.2780-1-romank@linux.microsoft.com>
 <df1261e1-25d4-43ae-88c4-4f5d75370aee@app.fastmail.com>
In-Reply-To: <df1261e1-25d4-43ae-88c4-4f5d75370aee@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA3PR02MB10770:EE_
x-ms-office365-filtering-correlation-id: 4c75945e-5ca1-455d-c28b-08dda83a3e99
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|15080799009|8062599006|8060799009|461199028|4302099013|3412199025|440099028|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zbbwG1ub5jK/H9+W5D4QEE2dNXnzz6razNl2C9Da5guevR9PyD8YDfio0QxC?=
 =?us-ascii?Q?Z6GLd/iYLAOhEFq+9r5Eil8Wkk66J0RG1Z1gyWoY2jJMkYLPUABuacc0xpvT?=
 =?us-ascii?Q?4iC3CJIfW4pxkdfgaSYQuJpXJLf53WhsUcD13NRGANRDVUXbMNcq7/aq25JO?=
 =?us-ascii?Q?HrTNLGz+htUTL8nuOhGQUPxb8maU5Bij+uZr9DIZHSotNb3AKQ9QEGdPL9FY?=
 =?us-ascii?Q?TjGwfX8qdise0yLVhb9HgPSAARHmsFgT0GoGesOKz+zvEch7uUVOIc2lgimx?=
 =?us-ascii?Q?0td4uS9kqJ5XUGtvYh+1SBy/wVz/VdlXpSlwIryuLVivLgK6E0kCOUFMgBiF?=
 =?us-ascii?Q?//W9o0qgd0IchgGo+hrxFPq/sM4xaJhYtShiKIIf2D6enbgU4f/dwOStDxba?=
 =?us-ascii?Q?Q/q1qVMic1P/hoDq6VlONEtbByBRioacb3+zX/MCOLA3QOSO/ME9YvDtRI3Q?=
 =?us-ascii?Q?DninAPuaJ+AhgpkRjifdfKKkXcVhBbH2RyNRt2qPLFcF2jL1G3iaMUup1fnM?=
 =?us-ascii?Q?YVztMkAjbUPTm/5ZPkg5n6u3pk/mWvZ/xcGWtm5rDrAdcnVj4igt8Tucnbg5?=
 =?us-ascii?Q?bxuuyjSwR1k2mI7u0cqk5IrAoBM1cYEp4+cmNmc5/lcnoUbDcBLvQq/LZ2AC?=
 =?us-ascii?Q?kx5reYYd4AqS67NHPnBfpMoXEqYROW0IFlhlqNMT/oK2B1QvEfG2cXwUdI9j?=
 =?us-ascii?Q?BE0BT8MrZE/w912FJVTq1cwSeCFy2oFHNM8qzjVmpEoRh/cNdPPJSQp/JxS6?=
 =?us-ascii?Q?koxBVaS3ItLaYAa45sD21FO209b5jBN+7E6gVAmqVrs5QzLjhqbLrnVfH6aV?=
 =?us-ascii?Q?Ze2qENPle+UsCW1I6T6tAtkAN/AX4BOELMKIp8e1veNCyx9EmP7GefFegCe5?=
 =?us-ascii?Q?n22kbPajYygZsVyyIpJyqwWC1QmnKjzIhHJ5nikfNnmuLRsq51cyZyKxwEUJ?=
 =?us-ascii?Q?qEhRNxe0Dd1g/4W4YTwi/dZACRyZoWDJO/LOkSDji1Iipk7INf0mL0qi/gyk?=
 =?us-ascii?Q?vZhZg9A7Fn5/Ghc3dVrA77nyp+VHUSHVHWTWAQrf8Tl5fOqDHS+I0i2G1xWH?=
 =?us-ascii?Q?Qb4joPoPl0/T9NT/FIsYc6U/XWzJFXtvWD81t8xWCcnwQOYwstkLmqLaCG2C?=
 =?us-ascii?Q?xwub00uN259fSIYH7weegd7+WYyecZEEDt/zDOajNIP6BT1vbb4F7Ls4PV7s?=
 =?us-ascii?Q?xJ5d517FA9EIva2OhLV174dXSnvZj8wj25dUyRx0cla/crcjjJSxEH0/JnO2?=
 =?us-ascii?Q?SXr0wprxZ0ljmMCHc1UF?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mVVmHZO0ytdzywMo1vrZ3ap9tmz/8UX1AZuBrJVFlQK9sQfuK3/DArfQqWqh?=
 =?us-ascii?Q?iLjpnUcaq1NTVRPDDC3J30GHLFcnkVsZqmPXRJvkw5EQO+hruvWRPrggxsbq?=
 =?us-ascii?Q?o9aRDs8cw7cka9Uv7BC9NCxMx3YnaydH24CpSq3KE21FenIbWbeIPUySWnc1?=
 =?us-ascii?Q?nTlj+6k/FYnZzZbQ7HzSy/tOoCNYmLAbOn9YWkLYOg9YIy8YSrbwnT7dQxQv?=
 =?us-ascii?Q?KRgtdlw6TSngOaJ2zmTAo7IdYfnrvyFgX6WN3+AsiUiEDJ/LfqDxs6nhi84m?=
 =?us-ascii?Q?hL1xecXIjCfUtQEiC2PqcyWjmwhr8MqzoZe7ecD+BDdzMJO1nAEXJ3NBoMmD?=
 =?us-ascii?Q?GV3bhGuUZ2vq6lvPRUpDsSr4ZJ5717h/Bt5SoYbBJsYEp2u4zsU2/ANI0Cqh?=
 =?us-ascii?Q?ODC6MsVChoYKkuvC9GWGZhzVvlwJflmaveIRPAm+NiVvCzgcTkbcJV413k2D?=
 =?us-ascii?Q?ANfA4/7TnttyFpe/k2/IlVAaLf76XrXHi+4CxrehySRXA1q+aqAsQGDTpmea?=
 =?us-ascii?Q?LOOyiSr8NR3i8tjiTDBrV9ZoMSUCx4toZxacL3wzrFP+s3JxYfCNkWDsiNyf?=
 =?us-ascii?Q?ze1oj9O/mB7/cgMTw7Y8TNqNqfVQNICERv+b6LMgN915ezn4Vc19rFk7F6h3?=
 =?us-ascii?Q?i5zALmQHJ76cYhDF2MejO/gCh/6dn5O1m4JsonWtyt6TGbSMUK7pteUY2BoO?=
 =?us-ascii?Q?W9gf3V7GkzGgvWnBJl+2ehp16It8j0SjfhFgPXd4xa9XOkXsl0X+QVvhZqkZ?=
 =?us-ascii?Q?mKz9ahjbQCaMHian5ReTewa/BXfmtiKjDZ8as/ne3vYdRPl3QV+qRjc3Y4rZ?=
 =?us-ascii?Q?z8ayk1eIWW3KGBwmbuQNfzFbGBTkDBmgQ2UQjA5aVRRU3CQm/a5v82mE/Cer?=
 =?us-ascii?Q?rXGF6gdzE4NFeGUqGwBJOxCEAbItR1qiXc0XKbHy36CvTHqMr1jwQrJKQjyo?=
 =?us-ascii?Q?nsqBc3DWacJGKhA+DhdkB9eS0QYlDNygP2cE9ddEbz5JhiZ+QB/Tb3N2OaTc?=
 =?us-ascii?Q?a5tClTdGaOuLX+T4NHZhVUrOiW5FmYJTyHQ+bRIvMM1O7xdvPe4576kP6jFs?=
 =?us-ascii?Q?vQEoFnviA3iBZzm3iWAqMJBzUFwaf0+/x+7CEe4EkSvHPSfrsDknoWMXVshU?=
 =?us-ascii?Q?GegjGyVk22BKxUVXJJ+GUzyJ5bItgr7KhlEBQTlbdzFybGHEJqbrxds+3DH4?=
 =?us-ascii?Q?vgp+pTC6q6LlrK1bVML7hG607LkHOPRdQTD/4g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c75945e-5ca1-455d-c28b-08dda83a3e99
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 16:17:06.7904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10770

From: Arnd Bergmann <arnd@arndb.de> Sent: Tuesday, June 10, 2025 8:46 AM
>=20
> On Tue, Jun 10, 2025, at 17:33, Roman Kisel wrote:
> >> Selecting SYSFB causes a link failure on arm64 kernels with EFI disabl=
ed:
> >>
> >> ld.lld-21: error: undefined symbol: screen_info
> >> >>> referenced by sysfb.c
> >> >>>               drivers/firmware/sysfb.o:(sysfb_parent_dev) in archi=
ve vmlinux.a
> >> >>> referenced by sysfb.c
> >>
> >> The problem is that sysfb works on the global 'screen_info' structure,=
 which
> >> is provided by the firmware interface, either the generic EFI code or =
the
> >> x86 BIOS startup.
> >>
> >> Assuming that HV always boots Linux using UEFI, the dependency also ma=
kes
> >> logical sense, since otherwise it is impossible to boot a guest.

This problem was flagged by the kernel test robot over the weekend [1], and=
 I
Had been thinking about the best solution.

Just curious -- do you have real builds that have CONFIG_HYPERV=3Dy (or =3D=
m)
and CONFIG_EFI=3Dn? I had expected that to be a somewhat nonsense config,
but maybe not.

Hyper-V supports what it calls "Generation 1" and "Generation 2" guest VMs.
Generation 1 guests boot from BIOS, while Generation 2 guests boot from UEF=
I.=20
x86/x64 can be either generation, while ARM64 is Generation 2 only. Further=
more,
the VTL2 paravisor is supported only in Generation 2 VMs. But I'm not clear=
 on
what dependencies on EFI the VTL2 paravisor might have, if any. Roman -- ar=
e
VTL2 paravisors built with CONFIG_EFI=3Dn?

> >>
> >
> > Hyper-V as of recent can boot off DeviceTree with the direct kernel  bo=
ot, no UEFI
> > is required (examples would be OpenVMM and the OpenHCL paravisor on arm=
64).
>=20
> I was aware of hyperv no longer needing ACPI, but devicetree and UEFI
> are orthogonal concepts, and I had expected that even the devicetree
> based version would still get booted using a tiny UEFI implementation
> even if the kernel doesn't need that. Do you know what type of bootloader
> is actually used in the examples you mentioned? Does the hypervisor
> just start the kernel at the native entry point without a bootloader
> in this case?

Need Roman to clarify this.

>=20
> > Being no expert in Kconfig unfortunately... If another solution is poss=
ible to
> > find given the timing constraints (link errors can't wait iiuc) that wo=
uld be
> > great :)
> >
> > Could something like "select EFI if SYSFB" work?
>=20
> You probably mean the reverse here:
>=20
>       select SYSFB if EFI && !HYPERV_VTL_MODE

Yes, this is one approach I was thinking about. However, this problem
exposed the somewhat broader topic that at least for ARM64 normal
VMs, CONFIG_HYPERV really does have a dependency on EFI, and that
dependency isn't expressed anywhere. For x86/x64, I want to run some
experiments to be sure a Generation 1 VM really will build and boot
with CONFIG_EFI=3Dn. Then if we can do so, I'd rather add the correct
broader dependency on EFI than embedding the dependency just in
the SYSFB selection.

>=20
> I think that should work, as long as the change from the 96959283a58d
> ("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests") patch
> is not required in the cases where the guest has no bootloader.

Yes, I think this is true.

>=20
> Possibly this would also work
>=20
>      select SYSFB if X86 && !HYPERV_VTL_MODE
>=20
> in case only the x86 host requires the sysfb hack, but arm can
> rely on PCI device probing instead.

This doesn't work. Regular ARM64 guests require the sysfb hack
as well.

>=20
> Or perhaps this version
>=20
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -19,6 +19,7 @@ config HYPERV_VTL_MODE
>         bool "Enable Linux to boot in VTL context"
>         depends on (X86_64 || ARM64) && HYPERV
>         depends on SMP
> +       depends on !EFI
>         default n
>         help
>           Virtual Secure Mode (VSM) is a set of hypervisor capabilities a=
nd
>=20
> if the VTL mode is never used with a boot loader in the guest.
>=20
>      Arnd

[1] https://lore.kernel.org/lkml/202506080820.1wmkQufc-lkp@intel.com/

