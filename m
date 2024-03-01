Return-Path: <linux-hyperv+bounces-1632-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0E586E906
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 20:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB9A1F28E97
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E463D0D9;
	Fri,  1 Mar 2024 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ua0C1chP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2010.outbound.protection.outlook.com [40.92.22.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07428BFE;
	Fri,  1 Mar 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319622; cv=fail; b=EDm869W4NBuhG4ScggExy+X52fDQJRwR8g/7FAnqvVPo2CX/nSIVivDAUNZe78hCtrmmnjTxO6FNQ6Uq0l8T49ogN61N17aKMWjJWMZqPW8Wzz+Uh0/YJ6Sz7vHKkpT+mrzRjFZsfk2341fQWQuVjAclD0uMfygGznrP+MJa14o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319622; c=relaxed/simple;
	bh=c9/ekrgUusyDErPMHkUQsbrdBocnCP83illsxbrOqvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fDQR7stu9OmrcNKXNdhqijykejM0u4l/2oXcmixXkBvUnS4M+kR+TzzG+6QS48ichmCbofVcIAzn7rSRE8IvZqHOd84R71ZlgWLEUFxhQCnXaPcZkBgMOihexOINjWw3LGx/YMrquNEdj9kcXiX1LoQS5UkaqQLRdz3EqCvSVpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ua0C1chP; arc=fail smtp.client-ip=40.92.22.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kerRoRjx2fDV+PsVEGz+uvKtIqiBrN6s3eiQnKL/owWYGnX9KlcR7pxtlTvVAwKBsuYfa9PutfKkfckzi4dLZUjsaVgkuNlp7OBv1aRzABkXrBYW2bxB9WsZA7oN8d/XndBxrkfq5RhbEOTZQYopUEawr0MTcoXzE4dEsKYwNqN4TYljOmG6bF44QFvWxCDoCTnYzydmK31ZLJvMwQVED9DVHDc+OiN3V3KhEK0R0MNLCIR4ekuxkQFABX1l6z6S1IW1/SHYsFqiZIRn+6fEvezZE9mBHnhJxxWQRLyOl6PGlDoH10G+K0GkSyPbNNY0U+/yKc1EhRbmqTkEYPkAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IygXFdz5Ggm6k298yzBjZlKAVxhHNoA6ZNBdg/ymVc=;
 b=J43uXvQO6RWfAh2DUNde9E4XXv+qw9WH2KOslLUjeB8HNZ6Pk5YHMK2Yayrt/Z9Os2vWtwRj0RN8Fxu5Jqw/Q+V0HcmZRn2ralFlRQeJHuDeSOjJpLAp7Snj99ZtVvJIuwMknM2PPWsPZV8HS46Z2BPfme73u2swxXwrMj7n8xj+ZOLehmNtObCtN+LeEOVrDU/OiwXwdlQJVmSbadRaA2HpEorCxU41BWPiVraz5/hx92I8xfsH/UJ43HbmlFCfSmvTZQ2qRYE37HEQHBOXxq2nQNaxMF/ufduG3LVLsvXHVxtxcxbqcx5a0tfzaijpkUZMlp8NG9gVvPFjHf8nDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IygXFdz5Ggm6k298yzBjZlKAVxhHNoA6ZNBdg/ymVc=;
 b=ua0C1chP2pjrRJqmiZbr3/mDfsH9MlAwjPaUTPnNhgEHV3InYuWYMmXWYA61Lk2pBTd9BioLg4uBHF9+yU8eXwRLuE0uW/G2N/WPfVZ1wIWBRtJeCNp7gtOJdtIK6Sm4/EjE43srLJLLkZGwMVnBJY09Mv+J5pnE3cU50yizhWuqxVUiU/+FogSJclHuEOLfiDBtOTbHfDz3qxTfY2jvmamTrZAtQSpcUKK3wUG9P96TS1n41kzh7RkvUVDgdwTffkMzO4KUXW7LKmRHYE6O1NfpMB1qO0HaZO0HUawvIjLA5aphvxBhZpScpzUQ2vbvKdBw2y5U2LKKAkJPIpr7Pg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY5PR02MB8941.namprd02.prod.outlook.com (2603:10b6:930:3a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Fri, 1 Mar
 2024 19:00:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 19:00:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>
Subject: RE: [RFC RFT PATCH 0/4] Handle  set_memory_XXcrypted() errors in
 hyperv
Thread-Topic: [RFC RFT PATCH 0/4] Handle  set_memory_XXcrypted() errors in
 hyperv
Thread-Index: AQHaZTRXjdPXYbhP4karQ0dDTiSBNbEjNf9Q
Date: Fri, 1 Mar 2024 19:00:16 +0000
Message-ID:
 <SN6PR02MB41575BD90488B63426A5CAB4D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [vtQnFaDfEU9jCla8ERcBAant7gkF3BGL]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY5PR02MB8941:EE_
x-ms-office365-filtering-correlation-id: 7e82d9c9-5679-49b7-9075-08dc3a21d551
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 i6m7JY4yfZjV1E1gOKcsvpwpdpxpM4zRZAyPb+uzloSjsYBhPQ8B8S36x2Mvmm9cvsNxGr4ZYJalVTT/lDy71HcGXIzteSzcLIpUOnQln+qr1Nbj8PktTu3dDgFHyAaunJ2Mk9tAB1d/khFjZGbvXOQ9zZiLcM+XiiO1t3CukkNpKTdcCmxJROZ7cvigU6me6duyZIvc7Yf/hHqoTmyVQt307MecxWmgndsa+sdNV2398oRpSlWBOEgxt20xLDdoo/j1T8Ex98v4334lBALpHDb8nqGsuQIU5CsdPD/KrHfrVIBeo4LbCyfdk6MHG46fJjq+vso6IPNrgdozGqS+34JxR2adiMw1yO+s1TLUe4+l2DPDlUt3IFq4A3mehaqXnCzt9AEXqBi4zmxMaCCcE9yKjcYQXDKKcAfPvl3zQQ8tvJ3MMtQpt29Du1/EQC6OXAVK6DQZ4jJYGXTHBxq/AxbHKZ9RrYakSbCbL6w4pkQLv/dLXRr0IvIjVdczKOyj2YQhxMnrIa2+f/xlvuHUOs9JfBaCn8Rv/+D8fRHNKkULwcf/M+AvBDu2RcplXew8Uo4p92NVWIxKbdoewN6QTPD5BbHySGnInbrwzu3vRvVoi74kuA8L6muYPip7O9GTunVOl/q+Dt/aQkJmvnRPMr2ifpnqWxemqS4Hb+SPpmk=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?echPPz7JWFY+7YVAPz/Y7CQvpVz9Y4mdGCGxsn7+UZTEHCseoxjk41tg3Jeo?=
 =?us-ascii?Q?gFYsb3OoBD9qY+Vmr8IFBOjj/GFCZOMrVOdXEcApTHrxD3qmPIVlbs3JeIVE?=
 =?us-ascii?Q?2Xr9hoxtzqW1fDE0aNyLaOpHtnL2wFRMjSPRCqFffn1zYWOikKfUWjbBFfmL?=
 =?us-ascii?Q?LOpCWzJ4YqEBz3eGbfhcvtc/l8QjRhmkIlFKsY3oNhvR53VaLOamfh2ec3gs?=
 =?us-ascii?Q?Y2yk/Y5uNCcdiuzjq9KPPCdcJu6U/E7sl5LbBayeV9tiWBYNr90rnlLp5zOq?=
 =?us-ascii?Q?YaStDQOz3FfkRy8pB9I7RUh6YabnL0gqDwMiDS+/Pp/2+EVahqHthXh0Qfqw?=
 =?us-ascii?Q?eIWcy7PKdlFcMS2d+/vDnH8LHQ1J7FWsnfJ0DMS0hYX08bHmHVVrv79LW5tF?=
 =?us-ascii?Q?vx+7GcUTFMvbC08JmBmp5aN/qxmCTy9Uc8IcTpHQ85kWbvhuQfq/cT6+kOb1?=
 =?us-ascii?Q?b79V9YRhJQC44FA2aLSxtVOdffEpQV92rKpEE6rr5Hl4/wZB1BUXUj9a4vTv?=
 =?us-ascii?Q?yOBfm46be8TFupwSIXw4gnoA1ApSpUNhuUWlLBK8yftrnAZSMhMg46xK3JNu?=
 =?us-ascii?Q?1zWUHk+dhCZL/EFE3D09nEYdy4etQeyImw0y/JsI9jKCvV4gkQlewcFR7QyO?=
 =?us-ascii?Q?loKCAePLOBnN94L3mVkarColzf1MzbJvo7fs0lVXN9D6JcniUbW3jTD9ocNc?=
 =?us-ascii?Q?VodBKCQrlSvfqlDWjPTUBcMTX+qH4m7A4toj8wvNOVBGMtNxqk43bJnKDRUz?=
 =?us-ascii?Q?Gd/DAIalmmQDshCKzQu9MOBb17miVZoKp3G9Yi3olIHrlJ7osg4dBb58hIaI?=
 =?us-ascii?Q?eQH2rXgcRJxvApSzdSNQJuCBDv+wWsQYDxS0MoIbGwYtJjYvlMG2w8gQArfd?=
 =?us-ascii?Q?EYTuTc4XH6ptLtSTnZBb1tqK6TjIPENAl5AVxQQidWdTAEOKFv9wEUr3ncBC?=
 =?us-ascii?Q?JjyyZVcHG/kE6mHZmY3rvL/4hwofOFjVgWwifA8cNzn7jpvIHW54NBvkn0kb?=
 =?us-ascii?Q?O/eTlzNIN+8at51pItM8QW4LHepdTsz93ycen867lsymsTkZQItSHMfqFgVo?=
 =?us-ascii?Q?UW5RDf5f0insdcPPn19Lus2h0qkK5btUVQPAdpRsct3ozaJ531+7MksNdOWs?=
 =?us-ascii?Q?z8h1y5zKrbCxq8eZJlDG3GN69/h/VOA04e2cCwuxZO7FULKnTP0OUaQiT7hf?=
 =?us-ascii?Q?w9EMVrN9+tc1OP00woNVpTkbZpNvi4oqe+jlrw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e82d9c9-5679-49b7-9075-08dc3a21d551
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 19:00:16.6500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8941

From: Rick Edgecombe <rick.p.edgecombe@intel.com> Sent: Wednesday, February=
 21, 2024 6:10 PM
>=20
> Shared (decrypted) pages should never return to the page allocator, or
> future usage of the pages may allow for the contents to be exposed to the
> host. They may also cause the guest to crash if the page is used in way
> disallowed by HW (i.e. for executable code or as a page table).
>=20
> Normally set_memory() call failures are rare. But on TDX
> set_memory_XXcrypted() involves calls to the untrusted VMM, and an
> attacker
> could fail these calls such that:
>  1. set_memory_encrypted() returns an error and leaves the pages fully
>     shared.
>  2. set_memory_decrypted() returns an error, but the pages are actually
>     full converted to shared.
>=20
> This means that patterns like the below can cause problems:
> void *addr =3D alloc();
> int fail =3D set_memory_decrypted(addr, 1);
> if (fail)
>         free_pages(addr, 0);
>=20
> And:
> void *addr =3D alloc();
> int fail =3D set_memory_decrypted(addr, 1);
> if (fail) {
>         set_memory_encrypted(addr, 1);
>         free_pages(addr, 0);
> }
>=20
> Unfortunately these patterns appear in the kernel. And what the
> set_memory() callers should do in this situation is not clear either. The=
y
> shouldn't use them as shared because something clearly went wrong, but
> they also need to fully reset the pages to private to free them. But, the
> kernel needs the VMMs help to do this and the VMM is already being
> uncooperative around the needed operations. So this isn't guaranteed to
> succeed and the caller is kind of stuck with unusable pages.
>=20
> The only choice is to panic or leak the pages. The kernel tries not to
> panic if at all possible, so just leak the pages at the call sites.
> Separately there is a patch[0] to warn if the guest detects strange VMM
> behavior around this. It is stalled, so in the mean time I'm proceeding
> with fixing the callers to leak the pages. No additional warnings are
> added, because the plan is to warn in a single place in x86 set_memory()
> code.
>=20
> This series fixes the cases in the hyperv code.
>=20
> IMPORTANT NOTE:
> I don't have a setup to test tdx hyperv changes. These changes are compil=
e
> tested only. Previously Michael Kelley suggested some folks at MS might b=
e
> able to help with this.

Thanks for doing these changes.  Overall they look pretty good,
modulo a few comments.  The "decrypted" flag in the vmbus_gpadl
structure is a good way to keep track of the encryption status of
the associated memory.

The memory passed to the gpadl (Guest Physical Address Descriptor
List) functions may allocated and freed directly by the driver, as in
the netvsc and UIO cases.  You've handled that case. But memory
may also be allocated by vmbus_alloc_ring() and freed by
vmbus_free_ring().  Your patch set needs an additional change
to check the "decrypted" flag in vmbus_free_ring().

In reviewing the code, I also see some unrelated memory freeing
issues in error paths.  They are outside the scope of your changes.
I'll make a note of these for future fixing.

For testing, I'll do two things:

1) Verify that the non-error paths still work correctly with the
changes.  That should be relatively straightforward as the
changes are pretty much confined to the error paths.

2) Hack set_memory_encrypted() to always fail.  I hope Linux
still boots in that case, but just leaks some memory.  Then if
I unbind a Hyper-V synthetic device, that should exercise the
path where set_memory_encrypted() is called.  Failures
should be handled cleanly, albeit while leaking the memory.

I should be able to test in a normal VM, a TDX VM, and an
SEV-SNP VM.

I have a few more detailed comments in the individual
patches of this series.

Michael

>=20
> [0] https://lore.kernel.org/lkml/20240122184003.129104-1-rick.p.edgecombe=
@intel.com/
>=20
> Rick Edgecombe (4):
>   hv: Leak pages if set_memory_encrypted() fails
>   hv: Track decrypted status in vmbus_gpadl
>   hv_nstvsc: Don't free decrypted memory
>   uio_hv_generic: Don't free decrypted memory
>=20
>  drivers/hv/channel.c         | 11 ++++++++---
>  drivers/hv/connection.c      | 11 +++++++----
>  drivers/net/hyperv/netvsc.c  |  7 +++++--
>  drivers/uio/uio_hv_generic.c | 12 ++++++++----
>  include/linux/hyperv.h       |  1 +
>  5 files changed, 29 insertions(+), 13 deletions(-)
>=20
> --
> 2.34.1


