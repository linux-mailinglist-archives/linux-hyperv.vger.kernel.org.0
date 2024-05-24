Return-Path: <linux-hyperv+bounces-2214-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B2C8CEC79
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 May 2024 00:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36EAF1F21C0A
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 May 2024 22:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CCB127E34;
	Fri, 24 May 2024 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AHHHZQsK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2080.outbound.protection.outlook.com [40.92.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99991272A3;
	Fri, 24 May 2024 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716590658; cv=fail; b=ZBs5fIu3QmJ/ImLh1r+1xt7njVRfoxe3gT4RsBEQnSyLB5oxev9Y++cFiQ6ppK7/enFAGdBjkiIsDmJJCCqvkKFlWn/0+3AnhljL+6Pg14kWP7omJekqZBvc/AjiTSb0Pm0/FC78HDGPaTEtxWyMikX3Nf8v7rXkucFb0aj6XaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716590658; c=relaxed/simple;
	bh=ZlUlZ/UPPA6yG017920plhUn9nqImV2O0uX+Pu3GUUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IMWbWOhHX6nB/iFlRdg0p9Q1hTWylJXLjAIELEsmldCCxz10wQ/lHgBDEEUUBzwm19KRwBn5AGz6rZKvVok6b/6O5prHj4j6R1s3k76tM3F6M0eDJxaBybyu44IlFwjc/qA7SFeiIzK5IudoEgeDNBkMTBRUyIpQom1guP3+gaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AHHHZQsK; arc=fail smtp.client-ip=40.92.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DG6FUPfqFsOaF3zOya8KPcLoEyrqgX8cKWJPxc48CCKYzxOIHKsjE7Wo2qorasJrkOZ86JfqtBThe27fQ6U6wps0VQUuIF7hPvKFy+t3xW5qH2tvRdIVxnw9EZthRnE0MwusvZCSD8e6AIPRwznRGxUfKo50/rV9SCtqtoRyHbpMLhiFFyg1DYBuB0+MrKL1U2/mzo/T6w46ADGmy9VpM0dR52oIfS8PY7Je6x8WTtinIiBL8+QvOZT26jVFpvd41txOTMTjFtBfIxbAqXCrtxDJMTrv0PSanbLAeF3OrNU5TU4j77IbntCWl0Q0o8xIlhuGTxS6MVuHUa0OBo99lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnZF2W3zzt74mLaq+BczW1CylzTYlIiTDkA9hFdUi0o=;
 b=cACC8y/yfWm3j+ka/o+w6OUTBkYeWoDujESIcM8fwLhAcf7/b6b6pbTg+Tn6gSi+8rLCpeq+J0inQ2G8aMB3iBuwd6Ze9G5diDYPzCSPHdIXkhzoAE9U+1Z14peoItiJ4sspWR67I/9dhhqmxgPvJFjv8ovScyTvD7hTmmr+X+SRWt1ouwIHABUiDvaprS59r9+bpYspgz97OA8R1CUltjQN95+OdHNexDz40+Mtgg7xo9opspeEY+9ziv2Csl0hoNCTcZtag7AcGzIHfBxL89jTtBmFdz4FfBLYAZUNWo/pdu/YEMI8jDRldn5uSswOP9EubG3AAa9ZAomEkxcqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnZF2W3zzt74mLaq+BczW1CylzTYlIiTDkA9hFdUi0o=;
 b=AHHHZQsKUKbJuaBWBysGrxgbMch1qoZKcJzqb5ZH4KTMw//7HhcZVk6JWmFKhje0pY4yM6dXMBpDVh7M37rdnQyVMX07Wrr/wVJG9yI9BJFo60xhlsqUj66+ZtzCyqw4g2nPKNvRHnW2yodNgeFM7CL1uDefPnpRvNdXXjpxPXQJNrVnpRZ9KHvlWtImCRAmxp/vgeZHHv9WBXyUIlFHsY9nkUAbt+MiqLLIBIaFDSivQDTzm3L9Xq8jbXb26733mFWqWH1BUcFOf7le25PBvrZsoFxUxt69r+hT3KF8EmBK0FT0xmyOJMN4Tmb1D5UloVgzKXulp9Crw8NjiLoJqw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8641.namprd02.prod.outlook.com (2603:10b6:a03:3fb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 22:44:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7587.035; Fri, 24 May 2024
 22:44:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <decui@microsoft.com>, Dave Hansen <dave.hansen@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, KY
 Srinivasan <kys@microsoft.com>, "luto@kernel.org" <luto@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "wei.liu@kernel.org" <wei.liu@kernel.org>, jason
	<jason@zx2c4.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"tytso@mit.edu" <tytso@mit.edu>, "ardb@kernel.org" <ardb@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tianyu Lan
	<Tianyu.Lan@microsoft.com>
Subject: RE: [RFC PATCH] clocksource: hyper-v: Enable the tsc_page for a TDX
 VM in TD mode
Thread-Topic: [RFC PATCH] clocksource: hyper-v: Enable the tsc_page for a TDX
 VM in TD mode
Thread-Index: AQHarLiA8Uk/mxkmvE2SV2tw0ZprALGk4MOAgAEzUQCAAOMKQA==
Date: Fri, 24 May 2024 22:44:09 +0000
Message-ID:
 <SN6PR02MB4157B940ED0A5F39D49A897BD4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240523022441.20879-1-decui@microsoft.com>
 <299a83e8-cb13-4599-9737-adb3bb922169@intel.com>
 <SA1PR21MB1317CD997CCD64654B438754BFF52@SA1PR21MB1317.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB1317CD997CCD64654B438754BFF52@SA1PR21MB1317.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=35a5da35-c3e5-48e7-a751-21c02511084e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-24T08:22:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-tmn: [efLzUtyVFM/xV0WIKur7gBCFxByNP74U]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8641:EE_
x-ms-office365-filtering-correlation-id: 3ef5c893-0db9-4c41-9c91-08dc7c4306ec
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|56899024|3412199016|440099019|102099023;
x-microsoft-antispam-message-info:
 w9eyTcwdWU+9b77KtfJs4lC1g7e2uHDwGlD5JLWhf6iqgF+9sqHhad6EPvoXrptklDEmGpzLeNCVOqgq3AE4aFJyffzts5eciLz7WkTk3GFS8j++8Es3noCzs96eR9bE3o6omnstXNOrU2RwqHUuGHu2li7tQuWXzdoqd5DyqZk80nCN4u6eChT22fs4OO/lU5FVNYWMEOpBspPP4w2Y7TH+Exe3ToiS7XJlIFKmXLbwZhict9z5gFVUv+1fjKpbFCZDKefo8ASKiyM/OHAjgfHoM9oI+AGzVkR2+YFS5ZsLDjeU/+pk3undA1GleUXV+IQpINFkzHsGIyLRdCqVn/62EFW7YaJBokEiF3cZ/9qlL6mnfkQygF+iPEA4rXfslK91V3KVCgv9IX2jPeIjtmyNDyREKFXJpOrAvAMLbz3LSflJiG6gCyJJ/BF5Kyl6eZlAMJOPAVkqsxtwGHZk/VDRrQQXZ81pBA7VOjbg1lqfHflxocQTjCuY8J54K7TIK0GBleDuJ4F1qyVzovOqoR/trcVE/dLt3q4TdDnzNF08I8R/xq/m7vu+wRKf0E5c
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2Cui7nEdXexesOx7rM/cflVRzI2iSUI2V+hgZ+8olqq4hEtxDBwtuRnlddMq?=
 =?us-ascii?Q?JfEirBKrWs+EEEQm/urrD2i9eAay1piVVMDq1bHVP5UL7rO+wdA0NjDEkuDG?=
 =?us-ascii?Q?LkoNzolgg6RlW4sttNTyLC8u2nLamDikdIEowidK7bGW4+zK0Mtd+hE9dy9J?=
 =?us-ascii?Q?sNHTq3MlzBVsA6JxePF8CmSczJWm2Ra+cxn+XHQZFcjRRWWsDjxqGLmceuPi?=
 =?us-ascii?Q?nj8M028j3+nreab8/DBUkuxV3IZHV4qT6ldLj3LHvB01s8J4ZFieZoqxDnm6?=
 =?us-ascii?Q?4Oy+XTzMtbAIKrHo5HYyOl8gmo8Fpq9z5tILk4bShDpcO6prCC32bjtQIa5A?=
 =?us-ascii?Q?QIcOSTq33zhW/UgdnbM+w3iA7czu/FajAceoNjIu6fvG/szsPLEH6AhcVQaa?=
 =?us-ascii?Q?b1Bz1gRF/WJX+fmZ9g/V0U91WMgxg5occsjWwIHiZVnKSbmBdeJDdHWMIupv?=
 =?us-ascii?Q?oaJ3CVzum+RKrrzmepXJUZ9NMbWQuIpX8tS0uHkr75m89lyVxYSh2qtS4hOs?=
 =?us-ascii?Q?gESda2lx2KMpEc6RKpJlZ6Fh7tUOzDIQHsJVe0E0jDP7wkLoGTHDZYuta0vw?=
 =?us-ascii?Q?uyT5YiymVxbam8sET/AH/+JmVlNg1z9vgxjqNpv65YQGLdu05zlEDEzZho2A?=
 =?us-ascii?Q?gT+lTe2fSwyNqgcwCTtOxrxM3aWUq5dFhAuQ6GLh1iW5wXDAp8zlwrt8niIG?=
 =?us-ascii?Q?Q3xPhMsCxarhMpLncFdRkG1m0Rhx9bycKz2POaPsaZsKOEWmlYUml1fV2WCm?=
 =?us-ascii?Q?mvJ6CZKfYVUQ4e0Y0iB6X1M5Cn9XlOcmDnrqkUtIuzVL4gxHsyjFl9AzWS6d?=
 =?us-ascii?Q?CyFD5R9hE1hkXPcQFyETuxzHkvULq01RLbO2IBDoH031C9B2rWJoTdjaGdGH?=
 =?us-ascii?Q?xkhR1JFkfKgls+PQykhtPYlfxLoQe12wsgiSHSvjLsJ7pThDSUJlO6KWLmKG?=
 =?us-ascii?Q?HccEcwh3yxlFFB0xhnVOkPAiWAQbjk5SHdT3pdUOvEtkckYydRz/m1CoA2bO?=
 =?us-ascii?Q?ci+nCWZJA3BMxciZmADtz9OwYmr/RVwGCdBAGzeQwUjYs0FYfH/sjNJ0EHNv?=
 =?us-ascii?Q?JIkWHbaEKzx8tS2+R6gPkhPyYHS58TSXsu8bgEJS0h7/A7QxDsDfrNAipSYp?=
 =?us-ascii?Q?o/zbw1XSn4Obu3rV9wsoynzJSCzkCB6oL67K5wkpZmXU7dLFGK3OyZY3CdwY?=
 =?us-ascii?Q?yf+6l8G+DSQvw3bBc+hOZhpfJ5hhdlzsMMe7EJQtJUMYQhOjFKWu5j+JOU8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef5c893-0db9-4c41-9c91-08dc7c4306ec
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 22:44:10.0222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8641

From: Dexuan Cui <decui@microsoft.com> Sent: Friday, May 24, 2024 1:46 AM
>=20
> > From: Dave Hansen <dave.hansen@intel.com>
> > Sent: Thursday, May 23, 2024 7:26 AM
> > [...]
> > On 5/22/24 19:24, Dexuan Cui wrote:
> > ...
> > > +static bool noinstr intel_cc_platform_td_l2(enum cc_attr attr)
> > > +{
> > > +	switch (attr) {
> > > +	case CC_ATTR_GUEST_MEM_ENCRYPT:
> > > +	case CC_ATTR_MEM_ENCRYPT:
> > > +		return true;
> > > +	default:
> > > +		return false;
> > > +	}
> > > +}
> > > +
> > >  static bool noinstr intel_cc_platform_has(enum cc_attr attr)
> > >  {
> > > +	if (tdx_partitioned_td_l2)
> > > +		return intel_cc_platform_td_l2(attr);
> > > +
> > >  	switch (attr) {
> > >  	case CC_ATTR_GUEST_UNROLL_STRING_IO:
> > >  	case CC_ATTR_HOTPLUG_DISABLED:
> >
> > On its face, this _looks_ rather troubling.  It just hijacks all of the
> > attributes.  It totally bifurcates the code.  Anything that gets added
> > to intel_cc_platform_has() now needs to be considered for addition to
> > intel_cc_platform_td_l2().
>=20
> Maybe the bifurcation is necessary? TD mode is different from
> Partitioned TD mode (L2), after all. Another reason for the bifurcation
> is:  currently online/offline'ing is disallowed for a TD VM, but actually
> Hyper-V is able to support CPU online/offline'ing for a TD VM in
> Partitioned TD mode (L2) -- how can we allow online/offline'ing for such
> a VM?
>=20
> BTW, the bifurcation code is copied from amd_cc_platform_has(), where
> an AMD SNP VM may run in the vTOM mode.
>=20
> > > --- a/arch/x86/mm/mem_encrypt_amd.c
> > > +++ b/arch/x86/mm/mem_encrypt_amd.c
> > ...
> > > @@ -529,7 +530,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
> > >  	 * CC_ATTR_MEM_ENCRYPT, aren't necessarily equivalent in a Hyper-V =
VM
> > >  	 * using vTOM, where sme_me_mask is always zero.
> > >  	 */
> > > -	if (sme_me_mask) {
> > > +	if (sme_me_mask || (cc_vendor =3D=3D CC_VENDOR_INTEL && !tdx_partit=
ioned_td_l2)) {

FWIW, the above won't work in a kernel built with CONFIG_TDX_GUEST=3Dy
but CONFIG_AMD_MEM_ENCRYPT=3Dn. mem_encrypt_free_decrypted_mem()
in arch/x86/mm/mem_encrypt_amd.c won't get built, and an empty stub is used=
.

> > >  		r =3D set_memory_encrypted(vaddr, npages);
> > >  		if (r) {
> > >  			pr_warn("failed to free unused decrypted pages\n");
> >
> > If _ever_ there were a place for a new CC_ attribute, this would be it.
> Not sure how to add a new CC attribute for the __bss_decrypted support.
>=20
> For the cpu online/offline'ing support, I'm not sure how to add a new
> CC attribute and not introduce the bifurcation.
>=20
> > It's also a bit concerning that now we've got a (cc_vendor =3D=3D
> > CC_VENDOR_INTEL) check in an amd.c file.
> I agree my change here is ugly...
> Currently the __bss_decrypted support is only used for SNP.
> Not sure if we should get it to work for TDX as well.
>=20
> > So all of that on top of Kirill's "why do we need this in the first
> > place" questions leave me really scratching my head on this one.
> Probably I'll just use local APIC timer in such a VM or delay enabling
> Hyper-V TSC page to a later place where set_memory_decrypted()
> works for me. However, I still would like to find out how to allow
> CPU online/offline'ing for a TDX VM in Partitioned TD mode (L2).
>=20

My thoughts:

__bss_decrypted is named as if it applies to any CoCo VM, but really
it is specific to AMD SEV. It was originally used for a GHCB page, which
is SEV-specific, and then it proved to be convenient for the Hyper-V TSC
page. Ideally, we could fix __bss_decrypted to work generally in a
TDX VM without any dependency on code specific to a hypervisor. But
looking at some of the details, that may be non-trivial.

A narrower solution is to remove the Hyper-V TSC page from
__bss_decrypted, and use Hyper-V specific code on both TDX and
SEV-SNP to decrypt just that page (not the entire __bss_decrypted),=20
based on whether the Hyper-V guest is running with a paravisor.
From Dexuan's patch, it looks like set_memory_decrypted()
works on TDX at the time that ms_hyperv_init_platform() runs.
Does it also work on SEV-SNP? The code in kvm_init_platform()
uses early_set_mem_enc_dec_hypercall() with
kvm_sev_hc_page_enc_status(), which is SEV only.  So maybe
the normal set_memory_decrypted() doesn't work on SEV at
that point, though I'm not at all clear on what kvm_init_platform is
trying to do.  Shouldn't __bss_decrypted already be set up correctly?

The issue of taking CPUs offline is separate. Is the inability to take
a CPU offline with TDX an architectural limitation? Or just a
current Linux implementation limitation? And what about in an
L2 TDX VM?  If the existence of a limitation in a L2 TDX VM is
dependent on the hypervisor/paravisor, then can cc_platform_has()
check some architectural flag (that's independent of the host
hypervisor) to know if it is running in an L2 TDX VM and return false
for CC_ATTR_HOTPLUG_DISABLED? If a host/paravisor combo doesn't
allow taking a L2 TDX VM CPU offline, then it would be up to that
combo to implement the appropriate restriction. It's not hard to add
a CPUHP state that would prevent it.

Michael


