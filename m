Return-Path: <linux-hyperv+bounces-2941-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BDF96C18D
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 16:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75333B27258
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925B1DC053;
	Wed,  4 Sep 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ah9GJ/LH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2015.outbound.protection.outlook.com [40.92.22.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F739FFE;
	Wed,  4 Sep 2024 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461814; cv=fail; b=NoLEwl36MNePBtO2V3yEyYlcOZ4j5LuZ/aBxxGzJv8De4CPtGcGO0jJl78V7nMOQ+ANTwYCvSu08vK6q7A2L6N5Wg4IZxRJbhz/o77mcXJUuuqQiBXVJB79l5bpEZYE5tXB4oz2Qnir1dzVsYHQsyBYQX6lg/ajvNktoeWh5YGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461814; c=relaxed/simple;
	bh=QYT4ppreoByOoeUa2xseJAkIav818KoNFGUrGhBQX1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BeHcfBM5VhipnvBNW79OO9T9ZCjL6qhptQQ+JNrhXtAcB4h2/tDMrGddpfjyK6NYECBBXCORlK4l9VDi8nklNDf7OSLnCgv/8SkkUIQAoHG1xoSGsv9CnzVuSbfvWDd0Ys2pYgl2cSW7GWYi8JSQfvbWeevw9BmIAgy8SHuQAGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ah9GJ/LH; arc=fail smtp.client-ip=40.92.22.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dwtgj0g61DeVfb8aeLsYghDCvfPHS9QiarzzRtlGFtb1PArLKTRCdJf81Rj1QQXD7YpqQEmNfBG15QVFDPs1FGv2JL9SSy5anMvaJk7CozKXzdzgkDUe1l18TUCM4XaUuOjkv+MXlYGjGhZ49YkE/HajjFNBLek0o25MYJv/9MdWhEiSFz37KElWC1Lutx7AH12JvlW5DgHAD94wmESjoYwKgnTu8vfL0c1WOp02yLWkvvguqXAegocGb/DAJug44efhcrcHp7LxnZCOeyQs4YoSVTFTGQRypGLB/RtpNaQoBjWy7AJ8cfnSsV8FhtwG9v0wBcAqDp5c0GBsoWk25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnFadsYLuFwzZklPUu3mrhPZM7zI6dvOc4F0+mCuSk0=;
 b=uzGpjmulE/31DGkyAP2UzqQt76ZcrTBOtk5ZEJ5xz3+dOBQS6ZRpMtwgjhJSO/ODD9L+OrjZXGGUDq6d7lTOyk30X2PD8/CtqHfH81OtxCm6qPv4/2S4d2kWAg4yQYCuJpKdioo6KJaVSstIc56vPwGgrPBOs4E7ao+ERKMtQPt2otdEqstqg+yLsEwvH3J5UjsjTyBK4cRIKIUfg5c+vEyO58l+y85RTrztgBRtVkBUbsTewZtOyfCX3JHJTFy8buKJ9SBkErFYTW2CfarfIGyYsPxeBRlu+JKptAvAwN51NQVtvSG4zZ5lhTUozGIYbqEbr1HAPNc491HFHOySGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnFadsYLuFwzZklPUu3mrhPZM7zI6dvOc4F0+mCuSk0=;
 b=Ah9GJ/LHQN8I7fyqXOLKTjUmgkjWZdOmJ3VHeKZzh41rUDumeEU/Rexd3eQpm4MoQbRfrtHwW+OsHsP0CaqBFvlE2g4N2izLpxcwDr1slBXnnUlukf5vb23R9rbG9qPbIvLpyoPkwiEaTJqv8nEEhlAJSgt1tEFom1S6QCCscE9dB09uN65Y7DUlRVYm8GxJubPc9riXcSCuJ8X0rs5zAv5rATD/acac1ZqxVD4KYC5jzDxGPY4TYc8MxA0vlEFxzwqpjZwViXvfFEaGCycciZ2s6CCGOGIbFM0fzE1WMyw4cvzwtYyOJuRiD1jegRWrmtTskJNHa+gmmP8nNIeHGg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA1PR02MB9061.namprd02.prod.outlook.com (2603:10b6:208:41b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 14:56:49 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 14:56:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yunhong Jiang <yunhong.jiang@linux.intel.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2 4/9] x86/hyperv: Parse the ACPI wakeup mailbox
Thread-Topic: [PATCH v2 4/9] x86/hyperv: Parse the ACPI wakeup mailbox
Thread-Index: AQHa9bO0nzfAUElulUSDKnXvnxUSrLJC/MhAgAOU6oCAATX18A==
Date: Wed, 4 Sep 2024 14:56:49 +0000
Message-ID:
 <SN6PR02MB4157963DE55041D0631188A4D49C2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-5-yunhong.jiang@linux.intel.com>
 <BN7PR02MB4148CC3F9091BC2604E457CFD4922@BN7PR02MB4148.namprd02.prod.outlook.com>
 <20240903201917.GB105@yjiang5-mobl.amr.corp.intel.com>
In-Reply-To: <20240903201917.GB105@yjiang5-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [CtM6usalJmcormzrmt9NTP+drlnirflQ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA1PR02MB9061:EE_
x-ms-office365-filtering-correlation-id: a38ee1bb-e8fc-4b01-6a7c-08dcccf1cdfd
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|19110799003|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 07aduoCqLcVUPwTiR3lgR1s3ltoDMYzut8dhzIH7uylfxEury5yTRVqC4kUPUpp0+ZyfFSwmCqI1uDusvIKgStYpD3i59zfIJmmj1OJyXRZk3jsTSFYyFw45ukLWHKiEIkn7C9lHoxxZ9s1BxGfNzwy3ssF25nQknXYll7KS84uDg42AXhxuLHUnVoRFPYXOrXFMdYYVu+/4hrOe2T6qiD5grPblztq6fko0giNpN6pWgiYAapRcDl7nbh/eteKAOgtFaTDHITA4DisjcEtS6aMeC39NPTeOXL1l1yQWquwxYw7vDy80g5XahvmlQP3znIWiKqoVPvqQX3Do/ki06eCYVfXuIfk6wYPFkStVgQFzyw30ogvnZuvjKhCzuYc+pDKObXtkZXSccHHv/xWJKfZfxVOfFbullASRvwubxMdzCR4EL0j1rcqEEUO7JhTz8PCAGaxnIGa6RCiiwcOgMqnQMVwgDrSz1BxW7oezhAPOqD2AEiWENQmCz3LtfaISPJmh/nx2x4O/BCMjmt1fSb+pmjFDpbTxvExleNT5KX+CTezSw8hO/DuufKvtTNbEiV756N3AMqLNSQVCAqcu64ua4p6ga65jpej+q0jTMqbkT5XOA+Q6YDHBd5QNMv0ujCW/hsxVj7TLyjoogJE0LO5lkqTZKkuBAwkpkdB0YXhSICkgobHrJHwKym4PkxHw
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xGFUeKGWvYk7vQ30guaEjz8fZoSmWcBq7NEC2ZUxwPK2Y9RZO18MWiAPzQ/a?=
 =?us-ascii?Q?zQlIUUIEXS1teNbZIf+uy3LI7RK2nXbe27bCdtd/8vxKd+STZhmsIscL5BbX?=
 =?us-ascii?Q?eIODJk908jecQUahOSh7a/9LV8I4WPrnFf/WLO5nV3T6Az8lmtuifuVFet1n?=
 =?us-ascii?Q?Kg0HzDCnfU24BYMlqytgeEOvozpifabdZootwXCweGJH0EJEUx0c2MuWeuUb?=
 =?us-ascii?Q?F+rHeDNHY6XIvHIFW+db9yOcmKDXjZZ2ut8sYKfkcTJOhEXecBCz+ZwRohtR?=
 =?us-ascii?Q?OA72vBYjDApywJ2f5HxV/YwC50uHblMpe/pmt7KXo2OfoXId6l+Nqt4aOn0W?=
 =?us-ascii?Q?o9OdzJ5tz8ECvgBV7y+Kjka8/L8N0dgDqGxsmsffuAS5g+fZihvjM+abSTzg?=
 =?us-ascii?Q?RT1Ojq4TqGorxscdvt5hYcLPuCiMOEzaaMyt/EdLY8xKbiQrL13C6W+N8fbI?=
 =?us-ascii?Q?XRwwc3wjgloiwZAsK1r8dV8pMJoAjzBJwq8a/y39+6bzof6K0kYvp6xEUwfB?=
 =?us-ascii?Q?Xr76b4vaWmKvMmSDFCkrJg6j0i1IMp91/89Nwlr7Gnu3PNVVRpJ1nRCfDzDp?=
 =?us-ascii?Q?5fPYVpSQZybD88A5eD+R5F134I8yyBSTwgJpVslKvM70XRbyUw1yVj8wVC1U?=
 =?us-ascii?Q?BM8CNpwxea962/9pj+KWKBVF2yOzO4XqQhe8exZ/G0l+LUmjFnrgH5DxFhEH?=
 =?us-ascii?Q?dh2Zpf5td5weMiPFb0EWqha7N8NAkPvTLadhH2dICLNGn6eQPuGA7qRCUgGN?=
 =?us-ascii?Q?9gDySdY9Z1qwXkJr0dcD+13QfyTpB7NRMWTT60BLvqfmFMwGLEquGuDbZYEW?=
 =?us-ascii?Q?DzEsMfXDIO9zGdOAmmAEB2YiazaHHaUgXra616WONmFtOen4hOYKRN433+Ur?=
 =?us-ascii?Q?9fVgQqiC3mFtGw6CbRI4WlWZLC6kNM3gmDe5iFvHZCu98hcqT11a8kjxjhk6?=
 =?us-ascii?Q?dCG3zB/oK/xcEj1wrK3OXun28ghPP8SBzgX9QpGm1gvKDGSHE1/JWKKAMGuQ?=
 =?us-ascii?Q?0FRQ6RDJuCMAwxXE6iiYQFdCCQt4Ga8sD+Owx3qe4XHY1GuEcDs0QioXVdJV?=
 =?us-ascii?Q?HyWn5mIsMzr2c2N7+++XGGBsETOOS1nsD9sGCrE478pYwRbf7EVZ/8zBFDkI?=
 =?us-ascii?Q?+yKhYzbMV9vNTGIzKVNgWeGc1aT4cVh6Vfgp1wIIMk27noZLHcObM7j9dBp0?=
 =?us-ascii?Q?DQJtY0qTfZeXA0yIDFjSDJPGtfWEtM6kl3CGv0JC80/ONi2ur0HxNaSU98E?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a38ee1bb-e8fc-4b01-6a7c-08dcccf1cdfd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 14:56:49.4371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9061

From: Yunhong Jiang <yunhong.jiang@linux.intel.com> Sent: Tuesday, Septembe=
r 3, 2024 1:19 PM
>=20
> On Mon, Sep 02, 2024 at 03:35:13AM +0000, Michael Kelley wrote:
> > From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > >
> > > Parse the wakeup mailbox VTL2 TDX guest. Put it to the guest_late_ini=
t, so
> > > that it will be invoked before hyperv_init() where the mailbox addres=
s is
> > > checked.
> >
> > Could you elaborate on the choice to set the wakeup_mailbox_address
> > in ms_hyperv_late_init()? The code in hv_common.c is intended to be
> > code that is architecture neutral (see the comment at the top of the mo=
dule),
> > so it's a red flag to see #ifdef CONFIG_X86_64. Couldn't the
> > wakeup_mailbox_address be set in the x86 version of hyperv_init()
> > before it is needed?
>=20
> Sure, will try to put it in hyperv_init() before it's needed.
> >
> > >
> > > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > > ---
> > >  arch/x86/include/asm/mshyperv.h | 3 +++
> > >  arch/x86/kernel/cpu/mshyperv.c  | 2 ++
> > >  drivers/hv/hv_common.c          | 8 ++++++++
> > >  3 files changed, 13 insertions(+)
> > >
> > > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/m=
shyperv.h
> > > index 390c4d13956d..5178b96c7fc9 100644
> > > --- a/arch/x86/include/asm/mshyperv.h
> > > +++ b/arch/x86/include/asm/mshyperv.h
> > > @@ -10,6 +10,7 @@
> > >  #include <asm/nospec-branch.h>
> > >  #include <asm/paravirt.h>
> > >  #include <asm/mshyperv.h>
> > > +#include <asm/madt_wakeup.h>
> > >
> > >  /*
> > >   * Hyper-V always provides a single IO-APIC at this MMIO address.
> > > @@ -49,6 +50,8 @@ extern u64 hv_current_partition_id;
> > >
> > >  extern union hv_ghcb * __percpu *hv_ghcb_pg;
> > >
> > > +extern u64 wakeup_mailbox_addr;
> > > +
> > >  bool hv_isolation_type_snp(void);
> > >  bool hv_isolation_type_tdx(void);
> > >  u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> > > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/msh=
yperv.c
> > > index 3d4237f27569..f6b727b4bd0b 100644
> > > --- a/arch/x86/kernel/cpu/mshyperv.c
> > > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > > @@ -43,6 +43,8 @@ struct ms_hyperv_info ms_hyperv;
> > >  bool hyperv_paravisor_present __ro_after_init;
> > >  EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
> > >
> > > +u64 wakeup_mailbox_addr;
> >
> > This value duplicates acpi_mp_wake_mailbox_paddr in
> > madt_wakeup.c. It looks like the duplicate value is used
> > for two things:
> >
> > 1) In hv_is_private_mmio_tdx() to control the encrypted
> > vs. decrypted mapping (Patch 5 of this series)
> >
> > 2) As a boolean in hv_vtl_early_init() to avoid overwriting
> > the wakeup_secondary_cpu_64 value when
> > dtb_parse_mp_wake() has set it to acpi_wakeup_cpu().
> > (Patch 9 of this series).
> >
> > Having a duplicate value is messy, and I'm wondering if
> > it can be avoided. For (1), hv_private_mmio_tdx() could call
> > into a function added to madt_wakeup.c to make the
> > check.  For (2), the check should probably be based on
> > hv_isolation_type_tdx() instead of whether the wakeup
> > mailbox address is set.  I'll note that Patch 5 of this series
> > is using hv_isolation_type_tdx(), so there's a bit of an
> > inconsistency in testing the wakeup_mailbox_addr in
> > Patch 9.
>=20
> I think your comment includes two points, the duplicated variables and th=
e
> incosistency in the testing.
>=20
> Thank you for pointing out the duplication of wakeup_mailbox_addr with
> acpi_mp_wake_mailbox_paddr. I didn't realize it. Yes, such duplication sh=
ould be
> avoided and will fix it in next submission.
>=20
> Agree the inconsistency in testing wakeup_mailbox_addr and
> hv_isolation_type_tdx() is not good. IMHO, the wakeup_mailbox_addr (or th=
e new
> function you proposed) is better than hv_isolation_type_tdx(), since the
> wakeup_mailbox_addr is more directly related.  But hv_vtl_init_platform()
> happens before DT parse, thus I have to use the hv_isolation_type_tdx() i=
n it. I
> don't have a good idea on how to fix this.
>=20
> Thanks
> --jyh
>=20

I don't think there's a requirement to set the "is_private_mmio"
function in hv_vtl_init_platform(). It just needs to be set before
acpi_wakeup_cpu() is called, which does the memremap() that will
invoke the "is_private_mmio" function to decide whether to map
as encrypted or decrypted.

So maybe setting the "is_private_mmio" function could be
done after dtb_parse_mp_wake() is called in its new location, and
you know you have a valid wake mailbox address? Again, I haven't
worked out all the details, so this approach might be just as messy,
but in a different way. Use your judgment ... :-)

Michael

