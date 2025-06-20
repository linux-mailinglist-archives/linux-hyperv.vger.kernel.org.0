Return-Path: <linux-hyperv+bounces-5972-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEFCAE1102
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 04:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002874A1F48
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 02:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914093987D;
	Fri, 20 Jun 2025 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aYhi5stQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2056.outbound.protection.outlook.com [40.92.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D5F82899;
	Fri, 20 Jun 2025 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750385842; cv=fail; b=UGbiU7i9TJ+7TUE/nI9EpBlXE+6ldyNZ2ou7FGtSmFFMIR0QDV6Bm2+Q7m9zyNDtUW4Qv6xZNzg3dIp0H5utx4lodcZqOmh7oI0KhaLrH61f6nkpf+PFVRUw3JUEJAW/Lp3p6jyRJyz+WDFWgjemn5ikfApzvvkpHxuq4bZ4cy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750385842; c=relaxed/simple;
	bh=KDL5y/RV2EEFMZJsmPTuBFMcNewN7fkI4WLqG6TG0YY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fk7nqKd1risNNk7OWvMuo4PR0OuQgdh9CSpqz/PpfQ84EL0N/o3G2JiKngeA5ukmHAoUp2vT3Goi2DX7VwiKf+yuh23W/gg9A/dW8FxdXcbDdtSkyVslzzZpCFkeHKXH4kkZHtXAzrOGqy1Y5HaT19HuwReaXdxAAENYU8soKBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aYhi5stQ; arc=fail smtp.client-ip=40.92.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiJOi0cXapn2r7j8wA7i8X6krpuj0KZxn7iJ+8xjIhmIRbtfope9vrh8cx64jbfZaV9fu52tKIELgPIgopp6YaAvSgEnDBGTBm793AFze80xs/4XsY6NHEC08C27A4kWdvZBAi1KqGPiwxotKDUwnoRKG5UfOX9nlpECSXj4vq7KsPfWp2qw4wq7ltT/1QvPRQUrudagi0iRzyZsoiQYmthl6agQbL2j5jvS8Z/Tc5T0EBVqAXarR99GuVGZG83ihjvj/pAHFG9+PHkgE2y+lgY8UvF2nQ5KLZ3X4LunKNxvRTuGS+K864S54BpzWdklW471q8Gc7v3JjK+vKcLg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCroOACUMS3VRU3F1R+mylQ3gCzk2FfBTkqxsOdEaSY=;
 b=HEps95PHEyp+7WoOJCJupMyTExtgvkCn2SfvGBjrx860siebW1I5ZPOpTeajn4QNq984eL9AtuyISIr6vWy09VdlgzCJKaNDpHnh43zMf8VFRrYYranfnlXBwZgeEWi2n1Hv+oqwf9tCJrMMMf3MpQN/4+TA4Qg0AHIkl115un5X436eu3HG+kaPZ1XJllrOWdXsq6tGlQf+q+AWoXyOa55umG4BFLSSwB9u7GVuMYwzBPXsfLS8VXXutzn+S2PIPs24Kjn8v0FHip50A+dt5eSLF7HtLLzyHqIoSfH46mokfzwnUYFJmafytxQh/F7kXyhVI1qgscj6B201N8mXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCroOACUMS3VRU3F1R+mylQ3gCzk2FfBTkqxsOdEaSY=;
 b=aYhi5stQs1h+9PVdRTFfpvXKa0wtmA4DUtlRqBDIVK2xsioJsA2PK7AWTgEg7SefGOZ8h3D/hdE2xHLDQshX152ywkQQUrNr53XKklZOac6wCVIwv7EuPdKoHgB8gNF7jr7yM9GEmPuWqQSFcKRPf1yzpxJ3XBjZ6cVNvtrJVMxbv4Z9KQ6+B4K6oFHiwrKCNU75F+E7KUxzi+ysy7/hu3HaozuJ2w/9oA+yluyMKh7lbCNlihbrTPrwziNlOikkvLT14VziZ+iJxXyOTzHM201F6RI8+/ePm+Uuf270E81VoAg9glxrDHd2Q00QA/9MR7Wx1O2ptqHl7fh5mkgjmw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8206.namprd02.prod.outlook.com (2603:10b6:408:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 02:17:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 02:17:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "kvijayab@amd.com"
	<kvijayab@amd.com>, "Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>
CC: Tianyu Lan <tiala@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC Patch v2 1/4] x86/Hyper-V: Not use hv apic driver when
 Secure AVIC is available
Thread-Topic: [RFC Patch v2 1/4] x86/Hyper-V: Not use hv apic driver when
 Secure AVIC is available
Thread-Index: AQHb3FOZsi65UseFT0OTgXavwRWB57QKmp9Q
Date: Fri, 20 Jun 2025 02:17:16 +0000
Message-ID:
 <SN6PR02MB4157A9D9DB6C11AFF0F9C1CDD47CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250613110829.122371-1-ltykernel@gmail.com>
 <20250613110829.122371-2-ltykernel@gmail.com>
In-Reply-To: <20250613110829.122371-2-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8206:EE_
x-ms-office365-filtering-correlation-id: bb56d11d-9cea-4de6-d35f-08ddafa093ac
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvg+tg/MNoCQ4s7gWjgMwzwpophbDS3Xzf6i9an5rZMhSMZZhCXzS8rvEWMLK6iQyqrHJg3s7VnQDnlqpDbzgbnfsqDVweI0vatkyEPQxF/eXSnXgFogQ4CGq3Wy+WBrSCbjv5DNnS67hxCZ1LTmUMVt2Zl1ONP3QYqwqyYrTgOd5e3/eLCupWA7sm7SStV2pKbPWXlhGzYvbQhgReWTdm90bowZ/hU+BzE2btOK3pD39k1fy5oIOJo7WHbw4GMXWDdvwWsU1sCaBORXk32vbGvZXu4HSuxneuRZXc88ycikWkZ+G2zjN0Yb9Tj0QOiTfswMgVC3WfRL/n2LaQTx/rRN4AEoM7dqrEv0soikCDYDuCHsEnsOG5nvkSwRlpcnRLDGajvAdDfDFCsME832X915kMagUI0v8acfsPkRdpUG6rBHeFjSM/5aw5kk5cUgajSSCKaDmJEsLRJsCEq5ghPT1fSUJRYExAYkrtAdBdsJkAk+U/UMFjkkza9bKjYlktJRAEi6KxNjHYay7VUk5yV49aD9q3jL93rvJZyfMzFIMhkUEhG2l9eejwLsVDVL8AHtZGkwbfeVliGwiRv+diP54uAOLywVi7unbwI2ockg94o7iknrDazFsuaPy/1AhKZHgpZ8LEGUw/CXExLNgKfsC8iyAY9pvGmK4AXezYFAbSnWidx9ibin6q3IvStuymAduUw9Bs9LYlQ4JqTVTkMgEcGaw00v2VAweemLvmiiqmYR3RSZz7TqcBxn7PkCLbi6pyXN2QiKN4x+GaBnZVe
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799009|15080799009|461199028|19110799006|8062599006|41001999006|102099032|3412199025|40105399003|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ID8Lm9eXqwTkZl8QSmT3jmjXbDDVKOPMd4ZdhkOZf4Lex5ITlK4tmQTtYGhm?=
 =?us-ascii?Q?D06bDL/oVyQkN5xPcZ71oAObjO1kFEmZr4M+XUszXUhgO3mZlvVn+JalCcN+?=
 =?us-ascii?Q?6okNsZNWbUL7Y16Z/Qsj3MLax1COhkEyWHpzQhbRGHBzkvuMyYkpnPj9L4MJ?=
 =?us-ascii?Q?N8JlWj5v5fB2pWLIok7EDz/N0BlS9SfWelcmp6K//cecso9S7Fq1bn24jNQZ?=
 =?us-ascii?Q?XxgRzcufRDGRgbhHxhcNOU1lbdaMteTtzA1Ay78Srm9oc332Jm6NBhENCCUF?=
 =?us-ascii?Q?gRIjK0P77SPyuqmeWx72FxohhbIaSkGjjK2Ow1owLuM08e6CqTUD1FzXvXYz?=
 =?us-ascii?Q?w9IuSTQrSXqMvPdUXwLPdDafVgQNYJm3DYO3XjZKY/sP6KVfrrqYXQkRBXSq?=
 =?us-ascii?Q?OjRmY8y2r2NCOYe0czezgMpjgALbcxlS+MILaAOtIiF3e1ZjZnaWDUtscFQS?=
 =?us-ascii?Q?PQeQzbvOYJXDIhb+AnjzPDCSQZhXY5fasxYX8ie5jPeDLELfzveMx9+glkah?=
 =?us-ascii?Q?q1iwPtJLXKl505sMXiJEJQQymDCRWqScfxtnHfYzilsuImuU2+z67eJqfmBq?=
 =?us-ascii?Q?d8KlHa54Rrr0g4kW4tnAVw59WTyf1Zy/CaTaWJ0WBDOt6zYA/E3PliUtXxv9?=
 =?us-ascii?Q?Mz+hclVnrBuLPmomnv2dXqzlxNOLyHv9vZ2ITJERbW1lC4MV3L7zoBSfEfAY?=
 =?us-ascii?Q?HZtMlYmFHZdz491aqhtSEZ3tFBjsR47tWdH5aF2nTzZzfcnWq7v9i0b8eVnU?=
 =?us-ascii?Q?+rth9bIOW3al5cxofMV3fs23i520pBsUx+rXGSgSpFeBPudEiOqPsnSGkdZj?=
 =?us-ascii?Q?TNGmKFCf1lJlaH+m7q45KXVxUGyaR73SssnD39Grc8mTRUFWkiZn1liFH64y?=
 =?us-ascii?Q?k5mCs8uYNtkz4Fm0BM2wpv8fN70lVAPz6VGc9U50e/KDm9CZ0ifxqH2VPmSz?=
 =?us-ascii?Q?DXK0sFR8AnjYPEa8qK/1R2zcsIcYStyvDXglCpSJAp6CQHwB7KdyCqUvNU7w?=
 =?us-ascii?Q?taZKQKc5GjG/XObb4ELkYjnqg0w6fvh5Ez74CCeq+7w5Yr5Jgvd2S9Fxc4uC?=
 =?us-ascii?Q?pqZiXwzJruQjINM9CGUqTimj6VYG/fg+TAJzmXoNVG8CGnsuhwbk/QY9yppV?=
 =?us-ascii?Q?oCtTN9ReAnOCERj0CXmMD74lu2V6XVznOA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SL1HvGOrxXTw82E6WSk28Hn/jC3IcqVRoXvs0BlEEqdlm72554WmCxxfdPca?=
 =?us-ascii?Q?rUzA1rv9nYlPxKoLLBim1OfcwpyXczM92EvM6hzMBWXQo0OlBRQRCeuR/Nyp?=
 =?us-ascii?Q?WfDcvQHWZX+2M/GRfiw6Cbr/ZaFOInWQA67d0DTaDjsW6hD2YNwb1fPpTLz/?=
 =?us-ascii?Q?H0kDKWb8pFFghIWuzv/lP5oKs0AperleOV2VDC6bt8F7Rn7XodNB2AuhFrr7?=
 =?us-ascii?Q?aTgSdGLnhKVIlfyUq3VMTLEQ7uoznzSa7hcmuBVC7Qxs9u5+KoYkuz2aAAfF?=
 =?us-ascii?Q?oEUh/hpGElQJJ2XSCqUnlftdd31p2d9jWoepwhjuf27TX0DO/NFKGkceLGrg?=
 =?us-ascii?Q?hOej7KE2Tj1K5KMqg3CaxBj3ip4gOgs7EgxCbM/A5oq5SD2p8Za5CEd8d/y6?=
 =?us-ascii?Q?PQ2z+zSqadwfNra3zlCMjtnmnieJtoNh9Aj/yiTgLk8AgSIQg9l4PivEVHot?=
 =?us-ascii?Q?6mkfNF4+A81D6q+/78dSQBNu26rc4yVjs783rksPXCRhkVQ159YirDbboWkT?=
 =?us-ascii?Q?SwD90jz/nYrkhz3hs/gDFuY7aSggXacTHWu/Tbu2q8nPnpWmfiFuAqkTliyi?=
 =?us-ascii?Q?qMmmotrzz8o2hNQYsWplgrl8G4EXCaxf0WJiu0uUOZ7SOIs4GFUJd+0B+CqM?=
 =?us-ascii?Q?7nhp2/pYfYNSr/Qe45G7ivJUFDJKQZtUiP919va58R6lkJ/pCq+iYJ2JKwnm?=
 =?us-ascii?Q?G4AOSCweVeKX183jUK+FeOf0ZjUTACydtujCMNM8vaTA6XB/RpV3iUe5c9Ty?=
 =?us-ascii?Q?MIcXbPzc21yGJyPKMZ0mNUJxykN/sP4XrSv/HAwgvmzPkhQVqpb6O205cN97?=
 =?us-ascii?Q?Rlhf0Lgil4ImPym+E1zXBzhzSOD4i6Ocqa3fHEpiFw4LU4Q1BlJ87yFvvLWj?=
 =?us-ascii?Q?R25fp/TzPjRnWibwKJV0bGZgPhcltAXdIaFxc6EfWVw5toYwCuK2ZyQADXKM?=
 =?us-ascii?Q?oX07QoEHbQ4gKkTr5/JglaTDfHadRfmxczuAH47ewzfBGLzfnsYygTNOwJfo?=
 =?us-ascii?Q?MB+wxdxSKwat3FLVPqLYgKuZf77dd/WuhQj2Nkmqe9XWLCNZoyPFoIQqHXpT?=
 =?us-ascii?Q?3CL8sjgllJn6YzW3dr2G/PG/J0pgNQ46+O+W7mS0nURsRLBZXAeNTWcpLLdM?=
 =?us-ascii?Q?VY3SoVJhNcxyOtrH2uYbLO8GFhrG1Zya4P0ef2Bb8W4W341C0oZ0G0UeXHXq?=
 =?us-ascii?Q?FJCzhEY+qZ32WiSnWYYlO6Yavkau0HEGYau91n2tiOQs0Q7oaGapLz12QXQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb56d11d-9cea-4de6-d35f-08ddafa093ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 02:17:16.3467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8206

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, June 13, 2025 4:08 AM
>=20
> From: Tianyu Lan <tiala@microsoft.com>

The for the patch Subject line, use "x86/hyperv:" as the prefix. Also,
I would suggest better wording. So:

x86/hyperv: Don't use the Hyper-V APIC driver when Secure AVIC is available

>=20
> When Secure AVIC is available, AMD x2apic Secure
> AVIC driver should be selected and return directly
> in the hv_apic_init().

Better wording:

When Secure AVIC is available, the AMD x2apic Secure
AVIC driver will be selected. In that case, have hv_apic_init()
return immediately without doing anything.

>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/hv_apic.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index bfde0a3498b9..1c48396e5389 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -293,6 +293,9 @@ static void hv_send_ipi_self(int vector)
>=20
>  void __init hv_apic_init(void)
>  {
> +       if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> +               return;
> +
>  	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
>  		pr_info("Hyper-V: Using IPI hypercalls\n");
>  		/*
> --
> 2.25.1
>=20


