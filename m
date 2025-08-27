Return-Path: <linux-hyperv+bounces-6611-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE2EB38742
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Aug 2025 18:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA0E7B75A3
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Aug 2025 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248CC2F3C0E;
	Wed, 27 Aug 2025 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NflHh8OM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2056.outbound.protection.outlook.com [40.92.23.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31727218ADD;
	Wed, 27 Aug 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310519; cv=fail; b=fdXF4u8uqekHm6icX1L9Fk1/UbKDbucq7SjKSKfgMmPMLm7W3Z2q8rbtzA9nY94lq027Lj0e5IjSULq9RkFFKwbXc93r48iMcrWe7Dsk1HxVqLio0s+vxSSIoM6at6q0cIF4dmQV2iOI5hwcTASRPrPrVnLWSU5PIC85IfTc52k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310519; c=relaxed/simple;
	bh=osFvS7nu9r0CGqZlwomUupE0DrBLS7+rqCukgksMqlY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ehDo3Uf4DergFz3ZKUmKodYIWZNJESv0ZiP4JBF3I4F7cVUx1rBF2X5lMUTJHEPX2DP9/3MW+eVQA81lgc7HSb3CH1339cJMkKgjufRg8LznNxA7S/vuePG/1a6FsVRa4Hphb37ecPk5agbWq2oE9U5o1EpA1qxa1fhCsAIJVdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NflHh8OM; arc=fail smtp.client-ip=40.92.23.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyuC19Ix9VYh4lBqdJHiTzsBa/w7Cgz+Uw+XkBpXcqM6rqcCrVIf78YO8+hm6/9SrxS2wJz56SWPhhsJku0XxleTvQzaPBA92l/hjxpsa/ITw6nNj77BJTOZxiFmjQILdTeNPTYoxa9WRiHeLba54z10ekHs5XkO27Xq4tfeo8GYgq18ahhjBg+k/JSHWsDHa57NtDn/Zh8TatxwD4exCDUnkYZ6L4xu+7WoXLa16AZZs9yzGwxn6PQi+GIvj7eMz8VigBmeAU5ISBZ+oFV8IgKENgvnH1m9q6q2foJkn5VNnDK2PuLGCVPxVu9YLN68KectDTyXnSgABB4Wz79vHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tvFhpBgw4NhDc/hFLgki/wlcqt7MlSXpIQEdlQAzNk=;
 b=tsVQTS/jByvbfJEb8+XP1ZMclAXt67YrOIY/C1xnckjh4Oz7V8IaZKGXq1M/rDmQE/2IhJdtYKrTSWX17J1U/GpMPUpW/Z9BkqX6BY11hKAuN73k/LaeHMTg4YrTB8YMGvDTNKoKFFMZ4ZDcF7OyghNKYApq4mr5jRvNWRHrxYBdNPU/wOLp04T7vLVcCV0IKndLNcP+ObbrM/OCzOTjpuGw9uLrQYDmHJy7OSKpRs0Zz2vYn4bg9oz4ue16Vkw2Pc2C/4t25yyByXjiKFE5/mP4fnlt2LzuBjyMm3BM7fjGzNbHwP8k/WEyPqpVcgl4Twj0L75lalFmeHLWCZAXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tvFhpBgw4NhDc/hFLgki/wlcqt7MlSXpIQEdlQAzNk=;
 b=NflHh8OMjg+2wjQLQXKyQnXV0EVQK3N6krRBDbNMib6mw2ljkRJ81TvsvJ0wQwmBEbt3g6fva6gSQ8pmqEGHUJkTSgNeh22qpKD+QaBMLXq3GCmLPpyXXTo76gKFHC21RkKaOEmO4JBF6Y18IUBjp40otI2WEgw1znBIQyDiQTmAn5HAZGEZA8hxQqYTCGX1PUxvfPT/ZQdtOmDsma1P31Zm0U5XSueoEX8sXxKY0q8cJXWJwsRcnp3+0mPlK/FfjLneF3sooemBXEq4b0O7/RcGMuBWU6wr0QXpPpR/fZ/nTNPD8H4ZlO2a+O3mZRdgjQpRKfldK/3nfd1liNqrIw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB8949.namprd02.prod.outlook.com (2603:10b6:8:ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 16:01:55 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 16:01:55 +0000
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
Thread-Index: AQHcEq6v/wxOnnc70EyB0UK7l4yekbR1oNMwgADcNgCAACqWEA==
Date: Wed, 27 Aug 2025 16:01:55 +0000
Message-ID:
 <SN6PR02MB4157D37EF081A7CC2E70425BD438A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250821151655.3051386-1-vkuznets@redhat.com>
 <SN6PR02MB4157581777244FE17DA3C7C2D438A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <878qj5dj2z.fsf@redhat.com>
In-Reply-To: <878qj5dj2z.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB8949:EE_
x-ms-office365-filtering-correlation-id: b36dc2e6-ed2a-4328-7827-08dde5830baf
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|41001999006|19110799012|13091999003|13031999003|461199028|31061999003|15080799012|3412199025|40105399003|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SPKZGyPQtSGPd/Nr5AMJUQjz9cc2Hd/1jyz5MNOFgbZjDeVYfMM0sANCUU44?=
 =?us-ascii?Q?/fD0NElZfTpoDAefZwuIbhnGuUPS5FZqvgvbh6IVaZSpDRRyQein7jRm5wQe?=
 =?us-ascii?Q?KJG8fF4ubE3GuWXYDBh53G7HIILD7I+EUjZrZiCqzSgkp9wM+AqD9tsDJZ49?=
 =?us-ascii?Q?LsQqMqLFEh8zS4OHfz0qGHa73N1k81DQsK6jvltX+iaNEd3BUDCYO2X0r1Oa?=
 =?us-ascii?Q?EeB0h323ynaY0JRjghrVh22spcpW34RDd1dB2EL9howqc891w3MKdVoJo13T?=
 =?us-ascii?Q?emoKzVMgdEWOSw6/IEgaERjOgsunsAFJ6FULKSZrQhACu8McMqgmMJZ8RNtw?=
 =?us-ascii?Q?eLFT3x8nZmWKoXUgDDvVA4usEuT0i2quBV39ndLtrUIWXcEWRqLwPIQUEYuQ?=
 =?us-ascii?Q?hn7HkdycYpewq8nkenIV4Wa/XtTlb6C1kTYCAZjleKqmXmy5nV0Exl7EICRL?=
 =?us-ascii?Q?/RRw5vXZIpuz0NTwdbVtlSOm+rz9DvuIMuySCYe6CSsDQrTjc65pY1zOVQFe?=
 =?us-ascii?Q?bdqwIWujLfgVP3G5Lf49xsFQXDBTcIE6fUqA29SqgAc6tdF4Ht/LgXJZh/76?=
 =?us-ascii?Q?eqNdx8cypFCEpoSzvJ+cKGCLZdwb9nBbuzKAjrCCQJuLE4BsUfzX31q2XZ73?=
 =?us-ascii?Q?U0Rlul1GgWpDLXwAOq1HqvmKi8XCE+gvTtxresb1mq0dNDlZVP17DkmJj+9q?=
 =?us-ascii?Q?qwJjhLUqguR3nfOjUvjda0tnZxVhUSrcSMcCutQZj3UrXrsTY0BxXrxsREF3?=
 =?us-ascii?Q?7JftlyOZ8JHRmSEScQVbW2971+nK/jHvSuLWDiyIE/d6E4fBscQ8kPTgropQ?=
 =?us-ascii?Q?A0dS2Hq1dLjlEgu8eTaMgX/0dp4HKQrkgQrDwi1HrSQZuk8n9FJLlRy6R0qS?=
 =?us-ascii?Q?F447pJnl+2zBYL7AcFRBKJsQtXJli9tFfuPTiwGgA57ffnFHGF4LGuKQtXgj?=
 =?us-ascii?Q?xE0IdiEQue7m8k2vTL1dzDDZGDon0Iah7LXj/Du8ksvVUBSEx0DXM1U/ZXXh?=
 =?us-ascii?Q?WrEIwcnEVxNPPi95a2hTHwWW5qfkKaOgShjXLYYYGhD7DFoP8RUvKl0OhlYT?=
 =?us-ascii?Q?1lLGwsdlMjMsO/0CTK4ssBBk+h8XJR0U/HmgqJJNdDzXksf4c9sbv8jG4XAU?=
 =?us-ascii?Q?uNXd9uXr0pCN6iwo3sSn8Et16Cd2k3Tt35naVigLkvJmXITYrr/64rm2AaKP?=
 =?us-ascii?Q?3yBJZnbesorQ8xI8XcHdzCF7XU45QsnjLJH7g1zvUGBZEqnR5YgpM6c7mUk/?=
 =?us-ascii?Q?4MRcenV7GJEBME7bmWZ4?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VR9HACEYzHgmD2YAeq4sfWzjj9L0AQ/0AZFII7Pv2ScAqmS4cM0SBRG96RjR?=
 =?us-ascii?Q?ksOLuYZxkQFIOn2OLLy3qOYkduWbQNxA9rmTVJJCJd0jcIjxhYxn2RGwRrNw?=
 =?us-ascii?Q?diU+6zfFGCZUeAEOejbFIB6cXQSgtZqTAaOj0TyiYPPb0bjk/Xqy7db8h1xO?=
 =?us-ascii?Q?dO0p4gXeh1V70RsG2KxIpG7sEW8BL5JpK0J8euI3hZiA+1Ypg9ai3k2WMfD/?=
 =?us-ascii?Q?AZIC0kNClMLnDhKMCQ+2+TZXn5DKhlmnjOuRiO8Bw/ZbglAgjevyx0Q4//sZ?=
 =?us-ascii?Q?KeqBhbhqweefDOs9OAMBE1zHWD8RVSekVMSouZHbfSo7+hO9lZrfbnhe/LgL?=
 =?us-ascii?Q?PcfI5Lgk3iACw/cAHNlLuo2G0fIc9ssSkdAsE+hl43OuTNmsq4gXLZ44O6oc?=
 =?us-ascii?Q?TF2hs0GvMhJ1FoppZ8suz5lwuDHCTqmROA6bqOGH3pWTjqQW7Df55FCj6SiJ?=
 =?us-ascii?Q?drAuW/bnyEevcLxIl1D5G8jX3c5WP15cDkaO7Z5qpifter6qPqU2AA/mWJbW?=
 =?us-ascii?Q?rgd9kZvEM80zT0DdxzqTYDoxw6+k3fdJTKwB8ztJIZh0NxMH1AesjLRbuFDz?=
 =?us-ascii?Q?duF48OZWVUwdJGOFSq9eKnD/vJgALf7AvyMWkmxkbjAtbInSrvGVinLuRpU2?=
 =?us-ascii?Q?n2JgKqa1IXBQ0P+TuYxv08f50Xh6o0WO4ew1txxFiyVh4kuiMEULMkz0DTO7?=
 =?us-ascii?Q?j2/xJiJmBK694uPzvACcFqSqnaMYhIbplSa0ZQyYWZfibNuDwYZ0T/hqVU8W?=
 =?us-ascii?Q?I5L7GGXW8WgOr27u3UCycm+Pq36bM613rbAoNJ0kDZgpAmX52d9x4IdYuRiM?=
 =?us-ascii?Q?S9Wa3lk5+N800A98KbdlG7hsES3CfdRYjIH5S598p0+D6FvokrE9axlxv+4a?=
 =?us-ascii?Q?VaZ4WLX/Uvqi6TK31fFzTSLk+JOh56Fhe8yNboNNVQpVxbc8U7nxR9FV5fo+?=
 =?us-ascii?Q?CX6LLDRKbVVqj0JxvypFbuBNsAcRPzYG93Y1NJQkCpISV/qZBCucBEW1qvhJ?=
 =?us-ascii?Q?46LFdkKndl9fg7WuHcWwrI9U3QZDcqhKojXKm1Y8TXaWluThHb3F0nySK/x3?=
 =?us-ascii?Q?YnBs+MLDdGxc8fdHMCgYIyxe+SpUy00wGt75hht1mehAKT8BZRTC7XN4wTfg?=
 =?us-ascii?Q?ILQQ45X6gfX8TPlTrm+T4eh9OowGtLxVaSmvKxrXBxuGrV2cWw/5IWQ572L+?=
 =?us-ascii?Q?+k+jTfbZF9+pn96Dvt1UKWJ1uYzNvbxr5+bQs4DTHOeYIX72+qN8HTGRiZM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b36dc2e6-ed2a-4328-7827-08dde5830baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 16:01:55.5429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB8949

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, August 27, 20=
25 5:51 AM
>=20
> Michael Kelley <mhklinux@outlook.com> writes:
>=20
> > From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, August 21,=
 2025 8:17 AM
> >>

[snip]

> >
> > I seem to recall that some separate work has been done
> > to support kexec/kdump for the more generic SEV-SNP and
> > TDX cases where there's no paravisor mediating. I haven't
> > gone looking for that code to see when it runs.
> > hv_ivm_clear_host_access() is needed to update the
> > paravisor records about the page state, but if other code
> > has already updated the hypervisor/processor state, that
> > might be problematic. If this runs first, then the more
> > generic code will presumably find nothing to do, which
> > should be OK.
> >
> > I'll try to go look further at this situation, unless you already
> > have. If necessary, this function could be gated to run
> > only when a paravisor is present.
>=20
> Yes, there are SEV-SNP and TDX specific
> snp_kexec_finish()/tdx_kexec_finish() which do memory unsharing but I
> convinced myself that these are not called on Azure CVM which uses
> paravisor. In particular, for SEV-SNP 'sme_me_mask =3D=3D 0' in
> sme_early_init().

Thanks for the pointer to snp_kexec_finish() and tdx_kexec_finish().
Yes, I agree they won't get called in the Hyper-V paravisor case.

>=20
> I have to admit I've never seen an Azure/Hyper-V CVM without a
> paravisor, but I agree it may make sense to hide all this tracking and
> cleanup logic under 'if (hyperv_paravisor_present)' (or even 'if
> (hv_is_isolation_supported() && hyperv_paravisor_present)').

I think this patch should be plugged into the .enc_kexec_begin and
.enc_kexec_finish mechanism. By using .enc_kexec_begin similarly
to snp/tdx_kexec_begin(), synchronizing with in-progress private<->shared
conversions is done in the kexec() case, though not in the panic/kdump
case. That machinery is there, and the Hyper-V paravisor case can use it.
hv_ivm_clear_host_access() should be the .enc_kexec_finish function,
and it will get invoked at the right time without having to be
explicitly called in hyperv_cleanup().

Hyper-V *does* support running SNP and TDX in what Microsoft
internally calls the "fully enlightened" case, where the guest OS does
everything necessary to operate in SNP or TDX mode, without
depending on a paravisor. In such a case, sme_me_mask will be
non-zero in SNP mode, for example. But I'm unsure if Microsoft has kept
the Linux guest support on Hyper-V up-to-date enough for this to actually
work in practice. I thought at one point there was an internal use case
for SNP without a paravisor, but it's been nearly two years now
since I retired, and so I don't really know anymore. For running on
Hyper-V in TDX mode without a paravisor, I know there's one Linux
patch missing that is needed by the netvsc driver. That patch would
provide the TDX support for set_memory_encrypted/decrypted() to work
on a vmalloc area where the underlying physical memory is not
contiguous. SNP has the support, but it's a known gap for TDX.

If you wire up the .enc_kexec_begin and .enc_kexec_finish functions
in hv_vtom_init() along with the other x86_platform.guest.enc_*
functions, then you don't need to test for a paravisor being present
because hv_vtom_init() is called only when a paravisor is present.
The non-paravisor cases on Hyper-V will fall back to the existing
snp/tdx_kexec_being/finish() functions, and everything *should*
just work. If it doesn't just work, that's a different problem for
the Microsoft folks to look at if they care.

I will ping my contacts on the Microsoft side to see if the "no
paravisor" case is still of interest, and if so, whether someone
can test it. My only test environment is as a normal Azure user,
so like you, I don't have a way to do such a test.

>=20
> >
> >> +
> >> +	raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> >
> > Since this function is now called after other CPUs have
> > been stopped, the spin lock is no longer necessary, unless
> > you were counting on it to provide the interrupt disable
> > needed for accessing the per-cpu hypercall argument page.
> > But even then, I'd suggest just doing the interrupt disable
> > instead of the spin lock so there's no chance of the
> > panic or kexec path getting hung waiting on the spin lock.
>=20
> Makes sense, will do.
>=20
> >
> > There's also a potentially rare problem if other CPUs are
> > stopped while hv_list_enc_add() or hv_list_nec_remove()
> > is being executed. The list might be inconsistent, or not
> > fully reflect what the paravisor and hypervisor think about
> > the private/shared state of the page. But I don't think there's
> > anything we can do about that. Again, I'd suggest a code
> > comment acknowledging this case, and that there's nothing
> > that can be done.
>=20
> True, will add a comment. Just like with a lot of other corner cases in
> panic, it's hard to guarantee correctness in ALL cases as the system can
> be in any state (e.g. if the panic is caused by memory corruption -- who
> knows what's corrupted?). I'm hoping that with the newly added logic
> we're covering the most common kdump case and it'll 'generally work' on
> Azure CVMs.

As noted above, in a non-panic kexec(), the synchronization with
in-progress private<->shared conversions can be solved.

Michael

