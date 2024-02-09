Return-Path: <linux-hyperv+bounces-1534-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3FB84F8E2
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Feb 2024 16:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045DC1C21154
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Feb 2024 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6389374E32;
	Fri,  9 Feb 2024 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ek8Aq4Ma"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2078.outbound.protection.outlook.com [40.92.46.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3585B73186;
	Fri,  9 Feb 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493879; cv=fail; b=Z+Oin08HgfYapxYf+laDbV8SmRjzvjcNK+3VjHDhQPOsxrotpk6chorf5yOJHlooBPq2gp84+6wCQl7wDCMjNKnOgZ0T5NozAgVh13y8UMLrJSoeXfFfFetl80GWlF1ULOPNDzWIkdw0CvjZBythgNcqiK2kghrEKWtBE6r0TWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493879; c=relaxed/simple;
	bh=SrKqnSszn0y1bOyTjJxXDvmXq7HoUh7qBRpw85zvrZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UqqttvWHrNMKLv3W2bqAkj6dxABb+2Z8YqVPUMQeV5sTEdKLO0Fd3qPc1SCHpgFpbB9HV440/Pa6oOLLtzz+Qpf45iZwPH4wGuYA+1UGAjfkvaO3OF0Pta3l3Eb84jybJdqkDu/B3skYdh6oOGxvx+aXy3xDMiabMT+lV7QzBok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ek8Aq4Ma; arc=fail smtp.client-ip=40.92.46.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMtoXlVZXQ56ua1Fqhik53+tvyUX3lQR5d7ksDdEHw6y2Mu5eev6nmwWUoHIOqmY+bxu/Abb4L2vTRkHnhpUqZPhPotIAfa+f/7Gki99AQuFoe0S58LMu4nqlxh2YyBv8ejv4ivA4BdvPhsuViG/h3uvkady5cp4gKDBXH2/pYF1YSq8jAzPyqgZUz6/yPLIAkKG06r5aeres+LZeiye+Ib4EEWoUV39fDNCXeXqg/SE+qdwtNymXZyfCb2CxnXsUZeuia0WOAoCDtAk8YQ6btEAHo+dSOcVro9oJojOq4sNbx2C44rigS8qEecVkirLc8uylyZiduNQoJ6Wu/1zWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8CHvNv7PFbrd0VVBGEfglDX5/lrXoLYbZn9aB6aDtI=;
 b=JM9mFRIiKRx4QMcMedgP1WXux+KePLf0UTg45oXDPSLRdkNt9oh3eIogfESZ1sN46OYfo9KRg6Ey1XpEX5+zT1P6bvJ6klT+Yp6UV+y3IrUQKmJBeJRSuR+s4fOYyGY3prjMFw6WksNP/AwUfAoY+XrSpecZQPOk0KIqkkKGGN1a/GVMB45XOUDTNyangROtOzVNjA9tM+Rpn19rNqo9s4UEB2ufXegUZzvNbsvDIYt/AT54U/ce2n9XUHMwCP5A+0pn42xiEbbLiyxsU83tgf7gXEDQQyO6RPbwVvwInH0OkC7QYhiY+G6RfB6yJ9Y88aYuh9sTjUeI2kgGYccvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8CHvNv7PFbrd0VVBGEfglDX5/lrXoLYbZn9aB6aDtI=;
 b=ek8Aq4Ma6We50+wR7W2bFCa4dMzf5TCYCoKnfr1D5oKC1+grWIQWdULY5VWjJ5WddP2K2KoWTtIysHR8a9LK9iyH8FBGovac8h8VxE3GTopt0H+iEZCs68fFHSXKVcL3XN8/hM5eAfjPbzPZQOFBLHBbjWVX/QUffkBwjbQhjHtz631RlpH1xfTM++dDE5OxR0ie8w7VzThTxRK9BgSSB3892QQNrv7AxsML+umD8zClE96cjTbVJ340A6TyRwWTC1t+HdXwFNircFVuahFBIpUXMJlQBsVhGEWXZNcNXyfZw8fgepR8DMwoyrWTxnVY2ackoNqrJGLSu+FZuXCmfA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7492.namprd02.prod.outlook.com (2603:10b6:303:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 15:51:13 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7249.027; Fri, 9 Feb 2024
 15:51:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "urezki@gmail.com" <urezki@gmail.com>,
	"hch@infradead.org" <hch@infradead.org>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ardb@kernel.org" <ardb@kernel.org>, "jroedel@suse.de" <jroedel@suse.de>,
	"seanjc@google.com" <seanjc@google.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v4 0/3] x86/hyperv: Mark CoCo VM pages not present when
 changing encrypted state
Thread-Topic: [PATCH v4 0/3] x86/hyperv: Mark CoCo VM pages not present when
 changing encrypted state
Thread-Index: AQHaSCKexFAY/xZWtkOyLYyKvYn/6LECTKjA
Date: Fri, 9 Feb 2024 15:51:12 +0000
Message-ID:
 <SN6PR02MB41571A797CF7BA7ADE60AF03D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240116022008.1023398-1-mhklinux@outlook.com>
In-Reply-To: <20240116022008.1023398-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [G0Ndzn12MV+32UH1fR6q8PazfioyiZB2]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7492:EE_
x-ms-office365-filtering-correlation-id: 6b768536-7678-4862-e6c3-08dc2986f11f
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7tmkelpnU4exZliC2btPV8AbjsVP/vAqn6U8aCrOaj13oKcjhA5CsnoN35mtFXhkQA3ZyCyFbt85AZs/nGB/jV0p0e8pFRit2dXxcbav2b+5tV69B9WU+ivXgY4Rb4VxdEY/Qb4fdZsxXfKFFJv2Em9pskNEXBWjVg9DkU3Df4XxJZAYPmOBnc/KT339FFCOFSkekoTIvSSHqkluOF5YQvt7kI5JMbugIE2ienKf4vZgp+z2m7qu8+FqthQ+oUimIRnXwYmdVb9GMXB9eQ83aEtesHOhGTWB4FSGtv/JhXSLm17o1ov5MxAcRe9Hi4kyjIRlWeyBJfV17chay4Fkh9bY5gpcWzYeHA5DmYaeKybxS97YQRcmFebJjahxaQrgc+DIhfjqe9eWgRvdxhlUYfVvXr73yivytD56Vd1N6JaQ1jBEqJgDvu/cFnGBfOq9Q9WX5Gm9dObc/Z+pVfBY57mnqcHVe2VsdEgDO83kq36NDS1PgZYRJlqcab9Fe5yyRuvDORb8RXz0qvJs6CvTHQV6MBABP6Ul1w+b2/3F+3s=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tKb2rB0KSVx8MNyWSPWc97epu7kltnzxCI32rOcTI7r0NqzV8rI7VKWqPNKt?=
 =?us-ascii?Q?Qojdq9Zj8jRILH43UbeD8Ki8ZyLTkzYGvgdMeWBRHR5ZI3jLEpi9so4rFG1r?=
 =?us-ascii?Q?xhthW+RZ3ZqunxD3vlV/hMc6LJpToSpkT2b2RAdZ0T7BHUHY5c69QfTVxyuf?=
 =?us-ascii?Q?RMsqeHAW7gcVjJceFlXx4r/wiuzoyjIj6ab4dR8Qb83L+yTkl3Jo5p8hJLKM?=
 =?us-ascii?Q?7VM1aqNJeEw+nXZG+w5tASb9YB26Z5204sG5I5kpxkamhExnmPhtuRcVDJJz?=
 =?us-ascii?Q?KyZRSZ6CItNYfRm43JqQOkkbEuZx64X7izsAtEyz6HR9ukLrqcdBZhlnyqeH?=
 =?us-ascii?Q?CI9ZSVmvwgAO7y61C2OtxRni/W8kWBPKr3EE9lw052SV/vNY+9UFRvtSFi6R?=
 =?us-ascii?Q?BH2pNe8khDV3/j8snR/LOeLakk/0V7mrXuM9JbQvk/RKaDBxszcw0phlqGPn?=
 =?us-ascii?Q?llnoDl8i4h1QT51UxJGt7X0dwf9UwJNMa9DUdYAm3jP+DjrWQGP409aRLYL4?=
 =?us-ascii?Q?jJpBXGTW50of+eh54034Unex9EQmZd9eXHqVVvWUjs/vF9XTXApwhLjwOhJ3?=
 =?us-ascii?Q?8o9/qtncij9J41DpxOwrh6MMITegWqu6s3UvmRa1ruzDVs7eveYzmPDnUj8z?=
 =?us-ascii?Q?7OBJdye4WWEyj0cH0KEFQ6LJPCqlsWnBVjGYopE/iZO/bwH33u/17pl4Sdqg?=
 =?us-ascii?Q?IsTYUBCUWLQNeeKlDE6bHuoBcvQMmDRs0xw/ZSJfRjjWASPK9rnbojVI+wrh?=
 =?us-ascii?Q?JuyRUSEnHmh6g3SqND4TM2w61NO2zRGSNLUApUFKXNb88y/PTIMhdnu3xfQO?=
 =?us-ascii?Q?d93VLCQU48j16/BhR8kJoUdqQdstDpdscErXQc9ZfwMc5CP47hvs8Mb4S4Dr?=
 =?us-ascii?Q?+Pl7ANx6a5KOZITHigsvTQrKkPV/4aWHGrlrfaKTGHSg52EPL6nO6s1hc/Sz?=
 =?us-ascii?Q?aKL4UbDVnEZi6WdxuD3SbDPGwQVD1XFleTPcugDy1tH1zU5Kbo/efVWsnNM9?=
 =?us-ascii?Q?KFCgkC5URT+xiQd0H3+Ta6qdhQrohdP1+g5rmeXsZWLcvsPKt4lel763MlJ3?=
 =?us-ascii?Q?7Z9LVD48qRz65HBvE3GAsltCwhlSGnY2X1r+pX0rKhpgkB/65/U1ai11kvFB?=
 =?us-ascii?Q?zBSPpC1GqN85+d/gpMdaGYAHNrzlRGakgovGFHCbtUn0pn2AIpBhgvU1RTD1?=
 =?us-ascii?Q?jUnWm4IuzkaE4gXhCg5Vqjn6LXCKFfCBTi0cr0pYSrBTCyqz8BaYZwWTeGg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b768536-7678-4862-e6c3-08dc2986f11f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 15:51:12.7338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7492

From: mhkelley58@gmail.com <mhkelley58@gmail.com> Sent: Monday, January 15,=
 2024 6:20 PM
>=20
> In a CoCo VM, when transitioning memory from encrypted to decrypted, or
> vice versa, the caller of set_memory_encrypted() or set_memory_decrypted(=
)
> is responsible for ensuring the memory isn't in use and isn't referenced
> while the transition is in progress.  The transition has multiple steps,
> and the memory is in an inconsistent state until all steps are complete.
> A reference while the state is inconsistent could result in an exception
> that can't be cleanly fixed up.
>=20
> However, the kernel load_unaligned_zeropad() mechanism could cause a stra=
y
> reference that can't be prevented by the caller of set_memory_encrypted()
> or set_memory_decrypted(), so there's specific code to handle this case.
> But a CoCo VM running on Hyper-V may be configured to run with a paraviso=
r,
> with the #VC or #VE exception routed to the paravisor. There's no
> architectural way to forward the exceptions back to the guest kernel, and
> in such a case, the load_unaligned_zeropad() specific code doesn't work.
>=20
> To avoid this problem, mark pages as "not present" while a transition
> is in progress. If load_unaligned_zeropad() causes a stray reference, a
> normal page fault is generated instead of #VC or #VE, and the
> page-fault-based fixup handlers for load_unaligned_zeropad() resolve the
> reference. When the encrypted/decrypted transition is complete, mark the
> pages as "present" again.
>=20
> This version of the patch series marks transitioning pages "not present"
> only when running as a Hyper-V guest with a paravisor. Previous
> versions[1] marked transitioning pages "not present" regardless of the
> hypervisor and regardless of whether a paravisor is in use.  That more
> general use had the benefit of decoupling the load_unaligned_zeropad()
> fixup from CoCo VM #VE and #VC exception handling.  But the implementatio=
n
> was problematic for SEV-SNP because the SEV-SNP hypervisor callbacks
> require a valid virtual address, not a physical address like with TDX and
> the Hyper-V paravisor.  Marking the transitioning pages "not present"
> causes the virtual address to not be valid, and the PVALIDATE
> instruction in the SEV-SNP callback fails. Constructing a temporary
> virtual address for this purpose is slower and adds complexity that
> negates the benefits of the more general use. So this version narrows
> the applicability of the approach to just where it is required
> because of the #VC and #VE exceptions being routed to a paravisor.
>=20
> The previous version minimized the TLB flushing done during page
> transitions between encrypted and decrypted. Because this version
> marks the pages "not present" in hypervisor specific callbacks and
> not in __set_memory_enc_pgtable(), doing such optimization is more
> difficult to coordinate. But the page transitions are not a hot path,
> so this version eschews optimization of TLB flushing in favor of
> simplicity.
>=20
> Since this version no longer touches __set_memory_enc_pgtable(),
> I've also removed patches that add comments about error handling
> in that function.  Rick Edgecombe has proposed patches to improve
> that error handling, and I'll leave those comments to Rick's
> patches.
>=20
> Patch 1 handles implications of the hypervisor callbacks needing
> to do virt-to-phys translations on pages that are temporarily
> marked not present.
>=20
> Patch 2 makes the existing set_memory_p() function available for
> use in the hypervisor callbacks.
>=20
> Patch 3 is the core change that marks the transitioning pages
> as not present.
>=20
> This patch set is based on the linux-next20240103 code tree.
>=20
> Changes in v4:
> * Patch 1: Updated comment in slow_virt_to_phys() to reduce the
>   likelihood of the comment becoming stale.  The new comment
>   describes the requirement to work with leaf PTE not present,
>   but doesn't directly reference the CoCo hypervisor callbacks.
>   [Rick Edgecombe]
> * Patch 1: Decomposed a complex line-wrapped statement into
>   multiple statements for ease of understanding. No functional
>   change compared with v3. [Kirill Shutemov]
> * Patch 3: Fixed handling of memory allocation errors. [Rick
>   Edgecombe]
>=20
> Changes in v3:
> * Major rework and simplification per discussion above.
>=20
> Changes in v2:
> * Added Patches 3 and 4 to deal with the failure on SEV-SNP
>   [Tom Lendacky]
> * Split the main change into two separate patches (Patch 5 and
>   Patch 6) to improve reviewability and to offer the option of
>   retaining both hypervisor callbacks.
> * Patch 5 moves set_memory_p() out of an #ifdef CONFIG_X86_64
>   so that the code builds correctly for 32-bit, even though it
>   is never executed for 32-bit [reported by kernel test robot]
>=20
> [1] https://lore.kernel.org/lkml/20231121212016.1154303-1-
> mhklinux@outlook.com/
>=20
> Michael Kelley (3):
>   x86/hyperv: Use slow_virt_to_phys() in page transition hypervisor
>     callback
>   x86/mm: Regularize set_memory_p() parameters and make non-static
>   x86/hyperv: Make encrypted/decrypted changes safe for
>     load_unaligned_zeropad()
>=20
>  arch/x86/hyperv/ivm.c             | 65 ++++++++++++++++++++++++++++---
>  arch/x86/include/asm/set_memory.h |  1 +
>  arch/x86/mm/pat/set_memory.c      | 24 +++++++-----
>  3 files changed, 75 insertions(+), 15 deletions(-)
>=20

Wei --

Can this series go through the Hyper-V tree?  It's mostly Hyper-V specific
code, plus some comments and a minor tweak to a utility function in 'mm'.

All comments on earlier versions have been addressed, and it would be
good to get some mileage in linux-next before the 6.9 merge window.

Michael



