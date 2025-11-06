Return-Path: <linux-hyperv+bounces-7430-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5C4C3BEB0
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 15:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AA2D500409
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A63E33E356;
	Thu,  6 Nov 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Aw6RZ4xO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012056.outbound.protection.outlook.com [52.103.10.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775A3431E4;
	Thu,  6 Nov 2025 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440876; cv=fail; b=E8Z0cFdy5k7OLAafA7pvN7o/LcFyZT9xro45ywypEcaFcQeqm6k0Irt72QAyvFWuvoH5HkMAmVQbkUa5bJsrjrjJTKA+RtUhY8kv6zedxeEpD5JJivK8IOhM+h+TcFofIdq+Cc9pMMtp5fV1+JPY67MSXx5uuWDp1qWRnXe4Ctw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440876; c=relaxed/simple;
	bh=BDJgYClJiKfRDfgzK4vxehH9voneyh8/H/oZgBgct98=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g9MkEOUheeHiRUooy4QBRfZd7sQMpsD5Usc0ydHjKBUhxa8YfNPnSMRp56G4+nt+nlAx8ZSs06ruY2M+v89hNZsQTMrXpeN/E8KnMO0Z+Ik5fJ+UtcfW/eSTQljx59Pw37tyHXcB2EYI3c+E+B+oQH/zysRFi12gKqRtwTvR730=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Aw6RZ4xO; arc=fail smtp.client-ip=52.103.10.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PS5uGULEFbCLeWUv3x9/85jqtrwK15mGqdCZ7pYDLphij0D5NHubPN7rZt1Tr9RI3lH00ilD6NlWACXIdmEzRevV5wUcTKFOIGk0DmAfksWs7rjiPgDrUW9sz3CGzf2IGls1GZLe5uj82K8XxD1OMhVoBBtiCEVVfgnCnv5aZJe+yCNYOAc7pqU79AFFgVgktUw5JcEqYVVue+W3AKyOn9wOxZEuOUqjwJM3ibp1S1nZ9nN8bSP+oPxmM+r+ahDZRTdgvLdkO/G0JGghhXHLlyK7ALTSPJOMYHYXyqAK7Lbc4RsEErC9/YGzHdUDgUTd9ts0QbbT62TQfGx3sQAuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOeNll4HB24izyKGVPQini3YLI8X6KDyqahKPlns8wY=;
 b=N6c0B+D0fCdD4DPB5xBvNwc7RWjB+VohmDlWhJX9bPfyZoEc4D1pQ3A7pjGfKlvZVSoxBdQxdetr/1Auo9p/ux2wiPZ25uR0Wc3WLFERxLZzSqq6nK5FB/jX9V569C3/aIFqeHbNhqk7Wk0t1Pp6WovgIJlEXkgmhd3wETUVYgUA/jqju17kgi6jN7oy+wNXg0GzBCmsGC6rzH/9kQdDLNU7OhXLMjHZrglTXEADtiN4GOA0ahG1Y97uQ0ZeGidUGLHwxQJbkwtSpkKP+XDeHgInFGFacR6sPoqBSjxolD3LU3aV8xDpVMNRn7U0VJOUsC7La7vPrl2lUV4dtsJoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOeNll4HB24izyKGVPQini3YLI8X6KDyqahKPlns8wY=;
 b=Aw6RZ4xOCWmHQ4gBTzJT8Ltf46FhihbdFRbHk+6MSLARZlx7aMBUL9m7WFQMth4OVM1XhkFuthta+eM9lKDBybZxlKTQ8Ty/NLv1GWB2mA1S0eOSwOMuXrxYrCocJMY6lZ8RwJ2327lY+5aVQIpzm2N9rNNuR4rIl7qYec4GdmNlvEwBqRJxYj5tDRAP7qMJE2aWZPt6MKrynCOsQIV0zkp5sZ8AymMAOh6ReR4x2s/hKyCusnUVsWde2hvaaJQmQkPU7dxaVZwYi9XaZQsgl6JQ7bsDrdf1+uJhEuleJNEJA3l9OZIu9QLfSWLlsQjTGtP9TW+OrbZfB44fjKk9iw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7751.namprd02.prod.outlook.com (2603:10b6:510:51::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 14:54:31 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 14:54:31 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, ALOK TIWARI
	<alok.a.tiwari@oracle.com>
Subject: RE: [PATCH v10 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH v10 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Index: AQHcSJEwuPVN9e1pIkKH+tLlojvmSLTlxt8w
Date: Thu, 6 Nov 2025 14:54:31 +0000
Message-ID:
 <SN6PR02MB41574847FF9B66A3D7321167D4C2A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251029050139.46545-1-namjain@linux.microsoft.com>
 <20251029050139.46545-3-namjain@linux.microsoft.com>
In-Reply-To: <20251029050139.46545-3-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7751:EE_
x-ms-office365-filtering-correlation-id: bf8836a0-db14-48db-7276-08de1d446495
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|8060799015|8062599012|19110799012|41001999006|31061999003|15080799012|461199028|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0yAOEVMLpCexzlyU4wddcwLstaLgNvL1HtfwGVr0Gnm6cVBi5QQ4Seh4j6oS?=
 =?us-ascii?Q?t6HsgpYsebsVNsPwbwbB6PQFs+aCwOQ8DO/Kc0SKtO7Z5Zo6GRBALQUQJsiE?=
 =?us-ascii?Q?8JWA3bY/NS5XdvV7vzdNSXTMnEYwEvvEEX24O6qLS1WXCna9qS+dmysTQ6up?=
 =?us-ascii?Q?cbh1YrER1pANS4UMmipG7Fnndtnti/I4GwvLazdhUzI6htazRCxsL8zeqen0?=
 =?us-ascii?Q?IiTHZSGsXQQVTOs4+3Y5/mBCgDLLcWou8YaDjr/rZKIzTiel162kMBHnR697?=
 =?us-ascii?Q?GF7v5IU9mQkMFU6V30UaY1NzsTWJ7DRsoC/O8Uh8zP008RltkESXUDyaUVAL?=
 =?us-ascii?Q?qrX0auJmzkM99289+LtDC+yCCJsyoe73qkF5ggHK+7+UVNUL3vb01iyRWF6o?=
 =?us-ascii?Q?7qq3NkBwPKDM+MvG5nrI98VpY6IW76qjKLHlAJL+k4RvRrAGco/122MuLvjc?=
 =?us-ascii?Q?Gw8UZb3FXZvcg7g8GT3bpvPEhd5fwfw7C9yLMheIPUELhW0u7+GJZLoj7S7a?=
 =?us-ascii?Q?9AYxiWDXyHwAso5F80Ga2rdWBciEbBaULFNMO9pquQTdM3CavxnOgjIuMF8U?=
 =?us-ascii?Q?ZOxqUvw+6KqCKOeMJyjCzMf5p3POd57vAJ8Si5UroYNfFvWzDlrJKE/OhhQS?=
 =?us-ascii?Q?y87C2IxvMKgCA19GjeeWeiaOf8fecvKeY0ALGtBDt5TwE144mD6ASUYvalRe?=
 =?us-ascii?Q?b3csXbl5Cpu3oMRGYTxNnqp5wOKu9vHZWV86wjxWQ4pnzm7ziqA7d0BJ53iS?=
 =?us-ascii?Q?FOW1R//rOxPM/b3DYkDGzcEJXYKwp34lEaJex0mJM9GIyl4K6PNQAuAq2ceV?=
 =?us-ascii?Q?sSKd1D2lCj9GcanmlN7FsNGNn/xpa+mBiLtk1Wuw2czCHz7Q/lQxgDdK3Sqt?=
 =?us-ascii?Q?/uLcnfwWwc1j2qjiI/v9QcGoFHnpCt3pTxmjGhCl4zXmxwoxALoNS5fYaqPp?=
 =?us-ascii?Q?orEst6E0jNgvJN+cXbtqnJpRHTKkD8GUUb+/ZMeP8P8C602LxAZit+HH7Tx1?=
 =?us-ascii?Q?m/MejBd4iQjqHC9CotY8T2/p7msNEg1dk8gn286b+4EMFKV4Ol4mQpHMbDlR?=
 =?us-ascii?Q?04qy0rV89W2V9wq3A0MAsfMnAKNJbGFS7QTE6cDOecrCwkfJrHPBbnpeyy4F?=
 =?us-ascii?Q?z7mk83cJsA4Fam0AaXchU+aSeWItXPmmZRaYaDC8mkdvjzY1gIkFD6weV6U5?=
 =?us-ascii?Q?mGzDtYrTbK9/z0ND4Fx1qhoNLdXOTntodNI8FQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qA/j1ZDebxAyHM/ixRTzqkUiGz8FrUoaKjAWK9fw2VlV6oiYrGDE3knYfPgj?=
 =?us-ascii?Q?Ju/MNP/Hed0NzrnMeBj7fZGJBZmFjeIW0ORlKKDkvCfJeHA91ULA+wBjWznT?=
 =?us-ascii?Q?NfMsa/V88+WbSQqgX9HDf1xfh30MREGDpoD9eFE60tvLOwqzl1W0wwMlAhTb?=
 =?us-ascii?Q?J/QWxKC83rBnYttFHS7NEJmRMKdzWhSPHQ97yVml40zHQOOzcm5TJnoWbh2r?=
 =?us-ascii?Q?gDxGMoe5ugOdLpKiCxkE+tHgsk1MYWZsM5a5bQ4pouxZreehhOInmZkGG2ua?=
 =?us-ascii?Q?Bba+P8DnRkXFfnPMGjSdfj5J2sZz2NqSr+Innb410ikwtSGwdvi6U0zflMzE?=
 =?us-ascii?Q?Qj2ZK49fDqK0DC2CkIBzmOLDM0kx6tuFpuQtrJiZHrKImdDcxSulKPd1sFye?=
 =?us-ascii?Q?hBgu2gkVBwEVsEqifBm1rG5aDDXVW0oF59nZOwlAQ7PYpUXB0u6uFEH6D+Ri?=
 =?us-ascii?Q?hCxDyvRjoXFcSqbuGhfKym8RB0h1wUFFxdmHwoxDpkHL6BRgMV8PXIw/r8z1?=
 =?us-ascii?Q?9Q827iHpTYQj8zI0/BN/rsKH14+1+1ee9atn2M20SoleZuYJp1Byx9v4cFE+?=
 =?us-ascii?Q?V8pcoh/gAFdohp8W09MZosmSedFuhVBDYfu/yMUTi57BYzsaQIMLPwiHqfEO?=
 =?us-ascii?Q?BqkVJVaHJAsy641hP1L7CJySQbbegSjSpZk/dvORuFNAkQvlTKdKVSmJFhDQ?=
 =?us-ascii?Q?I8K42RXbR/WpcuaoSOZ/3mhQOhj7FJLvpxl+Dq54LMK0vfJr0W2Uo+SE6Ghc?=
 =?us-ascii?Q?HGlT2NcTb40IaCh8JF4/R88gVaqgZXW+5u0rxrVBOq0cXg5s6vUjQ+WDljlt?=
 =?us-ascii?Q?F7rw1feG2HdRKtyAz0Ye6uO6/em9es+fWtWrll1JlYhF+R1f45f3+5BBUyyU?=
 =?us-ascii?Q?4/+o6gOvbKf+jrP3qraDjK+kbCWFZkHy30EIc6ViCCpLY6fuVgmtSu0dWlyI?=
 =?us-ascii?Q?ctFLxouMixcuxwNHweQwCn37IdvYgyn01ZX9CRQNN1ndbdxZ5CPhGhosdOip?=
 =?us-ascii?Q?GyMzfmzql7QLTpYz/Q5ryNv8hCMSjkcP9bbOlh6H6Wyzz/dt/kX0/xMr0dup?=
 =?us-ascii?Q?rdNlcDIrla3jwBoDAiZHdtwGARZaRhIPpvykxxm0/b7QF9T2PUZomoJl9DY5?=
 =?us-ascii?Q?v7tUVYJwbQv/ViVGbv03+JVFcKDoi4hE/BApGwuFS3JPwcqdIiA+LpbN0K9S?=
 =?us-ascii?Q?QplgqUHFmbequCapQV80Wh7hyuvmtGTVrOPs7STVxGKoPXVkBvd0VCX5i8g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8836a0-db14-48db-7276-08de1d446495
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 14:54:31.5091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7751

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, October 28, 2=
025 10:02 PM
>=20
> Provide an interface for Virtual Machine Monitor like OpenVMM and its
> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
> Expose devices and support IOCTLs for features like VTL creation,
> VTL0 memory management, context switch, making hypercalls,
> mapping VTL0 address space to VTL2 userspace, getting new VMBus
> messages and channel events in VTL2 etc.
>=20
> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/hyperv/Makefile           |   10 +-
>  arch/x86/hyperv/hv_vtl.c           |   43 +
>  arch/x86/hyperv/mshv-asm-offsets.c |   37 +
>  arch/x86/hyperv/mshv_vtl_asm.S     |   98 ++
>  arch/x86/include/asm/mshyperv.h    |   34 +
>  drivers/hv/Kconfig                 |   26 +-
>  drivers/hv/Makefile                |    7 +-
>  drivers/hv/mshv_vtl.h              |   25 +
>  drivers/hv/mshv_vtl_main.c         | 1392 ++++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h        |  106 +++
>  include/uapi/linux/mshv.h          |   80 ++
>  11 files changed, 1855 insertions(+), 3 deletions(-)
>  create mode 100644 arch/x86/hyperv/mshv-asm-offsets.c
>  create mode 100644 arch/x86/hyperv/mshv_vtl_asm.S
>  create mode 100644 drivers/hv/mshv_vtl.h
>  create mode 100644 drivers/hv/mshv_vtl_main.c
>=20

I've reviewed and made suggestions on most of this code pretty
carefully over the past few months and through 10 revisions. This
version addresses my suggestions and looks good to me. There
are a few areas, such as the assembly code in mshv_vtl_asm.S and
the details of the hypervisor ABI for doing VTL Return, that are
outside my area of expertise so I'm limited to a surface level
review.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

