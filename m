Return-Path: <linux-hyperv+bounces-7724-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBCFC76D53
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 02:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56F8F355F1A
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 01:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E921E5B60;
	Fri, 21 Nov 2025 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="n63E8VoU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012012.outbound.protection.outlook.com [52.103.14.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678EF7261E;
	Fri, 21 Nov 2025 01:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763686998; cv=fail; b=i9nL97qos1h4W9Yt5Zom9yfhtqW0PO7S3v+N0CFgNRFakEspEcCCmuEdQC65a4RWqPIidQXWpNyBLikGXShsTisUZbf5N8AuLXxugCpEgy8vt4pNKfq2UnwdsdXT1XQgaUk3H8GVI6heDUdwcfkwB3iTHnjHimOcUstyY4FtBec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763686998; c=relaxed/simple;
	bh=xTtdhlQ7Q2h5xJul6o5UqhCW/HfBHDG7uAD8Qxazqy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jQAw/SmY/+qKvTbC+T1CyHIcOgqBobVhP/PBeQuyR0p6iVZZ6QkH+oXw3TS3BUgQzYk9nv1HL4ibMKPbRErV04dNCcJ3f7+ljlxxV/WvpxWKCb1A7lawTfbHpuluxeysJTWNWfGVIV8zuAWl3BQy08k1/So104RLBOz82Jlejj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=n63E8VoU; arc=fail smtp.client-ip=52.103.14.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4Q5SGgmXosFxUXnAmKI5bn/zQ8u3sCXmU5KDVl5rKHcyr0e80hCyhHDWG4mkZcZz2/sX0X0WXJMoon4NwIobPQvZbTo1YL2DfM/fSFH+uxRENvvZ5jHJ3a/DFJ5SQ3SprF5GM4CqDYehSxDLOFwuhnRH/4bnIL1d1JSBSVWuY8BPyhlP1OpeAwH6GyQQ5Q7xATns6FgtWjyACXA3xkYARg/DDciK3NoDk0AXbNTBQzLjs77Hb0fQQT0ExOfSvpp5RUJdSbo4k7wag4Lz7EHJmoGTXuVlVxM/ZGDCyra9kMtpRcNhMecafzk9v7NlEXmAGTBPTYU7gJvVF5kzpLoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyiR/T2bGCdTgYCs3UPUZjO6CKX0QmDzXDnXICKt+tQ=;
 b=prLjsYO4GGNKKi+fSBg6DEVuXOBj2HkqdBeORo3sn0S1HNkLUYpDvUZOxtKtb1v3NdttHMXTEQIdriEy57dILfAS1WgvF+0mKW3tRy10QoCFqJTA40EZCXM5DsKibai1kISMroOFJf2AwpleWLVcgBuoyf8jU9AyBHR5iVlj6h3Irsh8dVuN/OdMhvaT/lQ+Xd6WE/RUEXS1OlyQBs2VFZb+5YsC4SiBE9y/qlgNoFc7zlMcv8pBOEY0abQsiDNk5XpJxl58xStD+fkDfiK7dEWHnSrZ7gOpWwsIySiSZ2Yeru3iTlhaXc+Ie/SUYfhMxt8k84UJ4G2wiGGg2r+pfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyiR/T2bGCdTgYCs3UPUZjO6CKX0QmDzXDnXICKt+tQ=;
 b=n63E8VoUUM1cm9sU6zINky+dF5rG+29dZB/rAUyt5ijiTelfZ4BeMhPIMh9alfZagnjNoedDlrA7ssbOTTDNtRmzj8TJQ0UvrvfWwR+fuN8gP+ZFYXjq7MKRg3iURB16YaqNCM/iVI3pP1OuH6uN+OBsxlOOITp1W3k2d/nFj+OyCAoFDqV7jHomHWXafY0MJpGyMP/gywt/fBh9Otv6Y8Pg3uJUAuLohHtFzDo2SJh/z8pZaw2vInXJYXkDuTi7IA9sLKma/UyMHEAwTgf1YYZSSDmBbRBhb7WZpmX0vAwLstfpV/dRIt4O5EQdqx8uEAbgXW5nEsm/KC8ASsaMpQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8451.namprd02.prod.outlook.com (2603:10b6:a03:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 01:03:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 01:03:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Uros Bizjak <ubizjak@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH 1/3] x86: Use MOVL when reading segment registers
Thread-Topic: [PATCH 1/3] x86: Use MOVL when reading segment registers
Thread-Index: AQHcWiQxASm8Q0JcykOZmH6QhcKbaLT8Sfbg
Date: Fri, 21 Nov 2025 01:03:13 +0000
Message-ID:
 <SN6PR02MB41571E23242892F03B528C56D4D5A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251120134105.189753-1-ubizjak@gmail.com>
In-Reply-To: <20251120134105.189753-1-ubizjak@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8451:EE_
x-ms-office365-filtering-correlation-id: 84fb48fa-8a1d-4f32-9608-08de2899bf6e
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKwyfdzYMH3tT7cdcaU4cPgpKx9Ufopkb5Fu6SIZzGa4m2mdsMPveL1GENxX9VQP8khzRYz9sC0xmp6r5Y73BND9SXvN4VKCZ9TILosW5foEIn1Jbxhx02B8f3TzNlYyIOsmmHFg6kXwCxP+n5S2NPcYf9vel9p0DYXtW6K1/eWxoAkdqWWv/nxy6a9EpR5MfUQ7k8sb97v8v9cJ6WkyXwWWNb+0qVN+qiRjGCX3eLdjZiKbcULrOG/zHeSXAWE95r0xce78s9hSbYyiIH6Ukw4DNV6alVu1cEkoR7qKBFasQvu8oKiJ5P/rn4l/CPjKcvMwbvBitq5ekiOTi1L2B3HxZ/HlcHLluzOHcxMGraBJIlEwRX+Ujy/7iX+rkLYnDgWVYKxt5fcjt+yRqVb/LA8URbpXuj7AuG2fQcCzf0T2Y+R/OPYSIKHBCQ+BgZh1xQs4thud1VgAuhUybijPZQhvVBK0p6PHNXi9ZYB33e8igZkHN0/GOKL+15AMXn+VoaYT+HByQ7rqW+QzGIE/EikAZpDaqwdCTU2R7HMkn3V9G0XsPaXLKfjbEQoPiQlvWfINauIPqHPBzBc20YMiE7y4IrwbH1t4bmbtQUro7q0kDtSeCfx0WFMlZ7bNb6DS2MMV/krSfvPpn5SWl+Bng0RSW7OxQt/dPEGtDKHoIIqW8IMCb2pFZGOwvboVnGzsANwf7Jw2fTR2aNHEIgoSc27qPACNucQ7GqE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|461199028|13091999003|19110799012|31061999003|8062599012|8060799015|15080799012|40105399003|440099028|3412199025|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bNZfUMxfE6T4URwjNlq3z1Dc40htqXEpgMJj531wAXqzD05kL9A/BxEY4H73?=
 =?us-ascii?Q?Vr7TgVMmEcgOOdlSJVriMj4K0LGj3orwytFf2vvkcBgnqRyorORgK6c97qaF?=
 =?us-ascii?Q?EC06OKtGm3ygRBLq+mEoLr+5f6RnUgZ68tH+NXrUhOeYOCT9FikXp/gbU63R?=
 =?us-ascii?Q?PG8u7Rfx/Nk6LpZF1BNOVQsMtuLS2SJTLHTjwP48mX3fgR/xC6aelMMQHT/x?=
 =?us-ascii?Q?ptsmolmyWa2QM8xOeTjrgHBSPOekjBU5PXUEXcUKDvl+Q3EEY2u6jihS+Do/?=
 =?us-ascii?Q?WPLVJa7mBTx46DZyfs+YR4fCORucqR54cbmmRdu8rCxd+/oX1Po17UhVJ8e1?=
 =?us-ascii?Q?h/AKfOHYLtdPRcyZAtgncdexBjxl8k6XBmaU5b6Ik/JIRQfPEJctAt/9hpK0?=
 =?us-ascii?Q?W5tdYz0DZijrq27HcOAHBbLGN3vWNSe0oq0CH7wjGacTMY71lKPl3PDX0ToR?=
 =?us-ascii?Q?k+1Al+T1OydUOfmO4hwo67DhUKurfig+7iE7Nd3UqhE1NrB/uitXpd+NNlXQ?=
 =?us-ascii?Q?F8Dv27qNsFSyW7wwJvqE9SJcBGhJcex1cZTgluduny0aNcSF0TmNeJV82MCk?=
 =?us-ascii?Q?UtManxFsuellypyWoIZ65b+to8zZbcg/yD922YAQqbcgsh0mdP0G/IyzEQq+?=
 =?us-ascii?Q?IKTFrtT/E6Y+2JnFok7Ko/7AE2dEk2gD8a+yIQ50h80yr0LTbBsZB5R66YRT?=
 =?us-ascii?Q?Q3yfV7P6HJKpBLqjMq7jO+ml0zCOQL3msVNbSqtuCLwXG2eclvqSiGOBk6Yx?=
 =?us-ascii?Q?dv1vu2GBcZ7wlqF/BpLLCGlTQIs3GVcMeSscGBGFkUXeF93AfwbHw12OJgmM?=
 =?us-ascii?Q?SKWl/8xzy7jAeg2kIuZWKzq6SkNt/4a64BlMgNKQdnQRcDkkJDr29+2TtBZo?=
 =?us-ascii?Q?wq89PDVKyFohyTnpWuwWUF77aZ8IvWui0sLrTXdM0IvSTbkSyZbcbFrZbTS4?=
 =?us-ascii?Q?HEVTrA4nGg4PrGzg4kGypc6nC6IF1rADvVO6kgIC+LYL9WHSCDGGhXnkxt2x?=
 =?us-ascii?Q?liB2odkUAx7Jfq903h6Br8vBxgci1ECu4uI/b5MP7UT7/uQXx8iHmKJvrIBz?=
 =?us-ascii?Q?Zi67UE8SavpZjSUq5aNefrM1/Gd+GYbI+52BM8koKTWhYoO1fnKhyVgAg+lT?=
 =?us-ascii?Q?Bq8RExAwkWCI9AZUBDe/HK05BC9dcYhOGkhMCQheronL2Uer1X8BG3SfXl0U?=
 =?us-ascii?Q?vlvmY0o5suA/p+UrKU06+aWs2Cc41DU7CSSHuVzzQQZb4S86pYKPowSLOLVZ?=
 =?us-ascii?Q?3dfj+H5OuHGaOtwVXqt+?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bKGn2VnuCBpfbBqVmYBrDzdWZd1D7ZPEEnHoMMFzzz2FT6PZaAafyoV8+AxK?=
 =?us-ascii?Q?Rtv4dEcWYOCuQlUsf0PJ57PfHtnJdDQ5PacNGxYQpvKjsMgDujd4dTPt4l4S?=
 =?us-ascii?Q?7iHceqKXQBhh6LASlylXsrqiZYZMS4OVDk85G1F8fnKlVAVr5/GMMI/T+DqX?=
 =?us-ascii?Q?v6AJn23abxG97aTyw7nOmFbrfGOOmtmh7jQL6SmD8OeZyI5K0vCmAnjzGP8i?=
 =?us-ascii?Q?aTnsIanzzPxI0dKJ8z8z3FGjkI8/Z3206BbBe+o+POyrOd/wpnjmSGTXUDeq?=
 =?us-ascii?Q?/l8Dz+jLiyfwR0mVBQMOjErQjhRL3NSyC2nA2l0vPADUuQcRgDAQqlvkjUXb?=
 =?us-ascii?Q?C1oZaswZ0zdtd9kFNajARS1ZtSmjM/SYrbRsLYfu74JXltKefWw0JNVYLgR/?=
 =?us-ascii?Q?Tcl2heJTqScHulibYYWm0Y8shc0yJf2SKA5sH234V6T/+05bIKFJI4csyLH8?=
 =?us-ascii?Q?PtL+XmHQ0XICkwveYYVq2CF9DcLfPXnPzVR0Ot2FHSzhN2NnTuhRGFOQmDcG?=
 =?us-ascii?Q?VRNepHUlR/aiGHfJaj21o7hFkHF39cUIvK0jh0dH+6WEra2wf56mWLXRh5Ew?=
 =?us-ascii?Q?My7latA8dYayIj0c9obLqtzOTseP+7Q7MHfplY13b1c3zIEomBloBmxpp+pt?=
 =?us-ascii?Q?tEq285OI2sgxJgz7p1wxhCfbQiV8wqqhVKkra0KTyBqSpvNi77V+olfq6joa?=
 =?us-ascii?Q?ke8Z4vgszDzMwN9lb6UB67ZmDALuC+jRJLPa2yjDT2FuJBZsvkKyAgV5GA9m?=
 =?us-ascii?Q?qIa/MITNtoDkzOJyOIrRu9kedsT+869VbljWPL+Nju/YPuAHSA1seZ2Gjw5r?=
 =?us-ascii?Q?kdx9DDBT0lGuEXe0y4Dfj2MfQRNLO0X0VgtANVK6IxlADD+GgcvenYg8Z+Ya?=
 =?us-ascii?Q?n7I75NPMwtRToR+phWLua28Xh6t+uwJjWsK7HIcpTNWwTewPbwIEMy5OAKqa?=
 =?us-ascii?Q?q37uEBvdGJ+lYq9Z59qJVy4CBwYlJcISZTK1BgeR1sqUgsq2H9wyE8AlW7wk?=
 =?us-ascii?Q?Q6fKQgXCB4u6ihERF2kwZFy9I3hU/R2wtW+zT6tBUL0i3S0jKRfe9GL2+jVk?=
 =?us-ascii?Q?O070Bl2vSQ8dCP2p8FvHb84a8ckAy24LWLqX7KW4XZ+AAz1GNo1oKOsXyFc6?=
 =?us-ascii?Q?X/Go88U5CD5lsgich7x+Nb+VfU3aCKtGc3udOugx5hPnjo/ZNoZmW6nJWw32?=
 =?us-ascii?Q?Lc6AgpcWJFq4mXDEU7ckHW+5ytkbCeFQB3U7gycMOTIz/x/GipyJLZEVlOY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fb48fa-8a1d-4f32-9608-08de2899bf6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 01:03:13.9550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8451

From: Uros Bizjak <ubizjak@gmail.com>
>=20
> Use MOVL when reading segment registers to avoid 0x66 operand-size
> override insn prefix. The segment value is always 16-bit and gets
> zero-extended to the full 32-bit size.
>=20
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/include/asm/segment.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segmen=
t.h
> index f59ae7186940..9f5be2bbd291 100644
> --- a/arch/x86/include/asm/segment.h
> +++ b/arch/x86/include/asm/segment.h
> @@ -348,7 +348,7 @@ static inline void __loadsegment_fs(unsigned short va=
lue)
>   * Save a segment register away:
>   */
>  #define savesegment(seg, value)				\
> -	asm("mov %%" #seg ",%0":"=3Dr" (value) : : "memory")
> +	asm("movl %%" #seg ",%k0" : "=3Dr" (value) : : "memory")
>=20
>  #endif /* !__ASSEMBLER__ */
>  #endif /* __KERNEL__ */
> --
> 2.51.1
>=20

I've built a linux-next20251119 kernel plus the three patches in this
series, and tested it in an SEV-SNP VM in the Azure public cloud. The VM
is a Standard DC16ads v5 (16 vcpus, 64 GiB memory) running Ubuntu
20.04. It boots and does basic smoke tests with no issues. So, for all
three patches,

Tested-by: Michael Kelley <mhklinux@outlook.com>

I do have a comment on the commit message for Patch 3 (I would have
replied there, but for unknown reasons the third patch didn't show up
in my LKML feed). The commit message says "VMMCALL ... may be inserted
before the frame pointer". This text was somewhat ambiguous to me.
I initially read it as "the compiler might insert VMCALL before the
frame pointer is set up". But I think you meant "it's OK to allow the
compiler to insert the VMMCALL before the frame point is set up".
Maybe the intended meaning is obvious to experts in this area,
but I'm new enough that it was confusing to me. ;-)

To avoid any future confusion, I'd suggest this wording, which is explicit
about why this patch is appropriate:

Unlike the CALL instruction, VMMCALL does not push to the stack, so
it's OK to allow the compiler to insert it before the frame pointer gets
set up by the containing function. ASM_CALL_CONSTRAINT is for CALLs
that must be after the frame pointer is set up, so it is over-constraining
here and can be removed.

FWIW, removing the ASM_CALL_CONSTRAINT does not change
the generated code for hv_snp_hypercall().

Michael

