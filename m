Return-Path: <linux-hyperv+bounces-2926-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73A4967E32
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 05:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637811F22420
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 03:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD7F145B00;
	Mon,  2 Sep 2024 03:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AOgqTXFY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011036.outbound.protection.outlook.com [52.103.12.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3B143888;
	Mon,  2 Sep 2024 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725248123; cv=fail; b=nF6/bM0vZ8F7XIEeiPFmVrSbbN7DZFQVKYVWMDAEfdtZwo1vgq5bcPGbMQCi7hRHhnO0/yHWXQY2+jmd7tDSg0MliYAbPfuWYWq7DQe3kKvV7Gd6w61D8+UnC2wg3DTqqwgQwZETj7olmvYryQ+YZuDEuLOvDHlDD9c2yQ5HgQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725248123; c=relaxed/simple;
	bh=ZeDBUL/48N/obMNiBqxm8P6Nn4uzR1pkjC3wjJMbDtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rVWReztJvpJxBmcKw3IhhTozBa+a0R//dMUCi6eyO7KtZsGBT4sp4yWUk4I2EDQtaYIQW6JAwPcb7sCWKWB5394zeAo4u10B6CaZQGENHlUTu4Sc+fG2KoVujwqLjx9rgz84lpcaIY3YmgDbl6LjQX4J2dOnUgzLcSclGT7GO6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AOgqTXFY; arc=fail smtp.client-ip=52.103.12.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gb8DVTZYIK+Lf1vxFXYxKiAEdRz5SZPoxtQgXvWuaEhhwwJUdVeiicv+qwRSJKTQ5DaereKA8GTMkTQO68Uv+PoXmfk6vYjNy9C5Nwnw19/c/SO29+2eYIkb95DzzmqjIcK61duP+DfPRMIM+3kBNZTCNLMeB9keyoJVS/WqOKb+p6iYVUsuNe/FtkdctZN6/oG3o8imyXtMJvqP7tJIxKiEXgNWPchRaQ1dLpQ7YDcE/uQFROYNhAumkiPvoJZV5WpgmU1V/d4m05utN4wjz7O9kmYuxhurSYG2kig23FopAqJRR0eHo7HDGrRk2g4O2IBz7qQ4H7pwyp+UbTZyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+CClqkRg177sxJ9usP34tRllPGDfhuMAnxmsgfe2NM=;
 b=vEEHGr7xhAu4WQaLQnhe/+wJsQ8weqt50tSHa/sm7I2+Gvk4y3r7cmUOxQfXst4savaWuvI/VsZEwdz3/yeY/ZAWwVyH84l1y6teHLTizmuirA51DS48XBsxlqIUurnW71AKZe2OfACOeUkHP2sIxPh25TuFiZUahvjQgHN0qH/fn3SDKScjQE10Rqjh7gmMQCRSP3Qn5mmAR/iPtYT9iLC3dZ0BeoZvQDA0SBsxSTTpO7pMObCdItVYIb5ZvzVSdyCfsPt0H/Wzxris3zZLBCc7y9Wggd2w1oxuzqJfwi8xFkNha0gBaoh2sZfy3MhBFtLB8Lw9F6hn5s3M3zwR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+CClqkRg177sxJ9usP34tRllPGDfhuMAnxmsgfe2NM=;
 b=AOgqTXFYfVe1hJik8up0dCWaCAwZK1Y7+ti9M/d7FnSn0cjaWY1WKZFaxiwYEj8i4X3uq1wcnhveHLK+gYPkJ43WrGGKIbygjjGR2Yiy4B/lfxrX5I1JWPmtbUA/UrW4F7mjGUxVhTJDpMzTdh3mFmfTHVffIQg9vmF1gFW8MglXuIUZzxx5hJeydgdDOXkxcU/KJ9CjO2SdNOItgQPohKFE69UyYsqf7CJo4R4Vpvu2ZdOpL3yg0DtTY5YnCQQX3vrf9uXfym9qm73h6ilZtLUEqpGSDXXwB+N1s2n2ldLmOVOZmVIb8OeP426Hjlb3n41xLPWIet1ML4hYPKi7xw==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SA1PR02MB8655.namprd02.prod.outlook.com (2603:10b6:806:1fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 03:35:18 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%7]) with mapi id 15.20.7875.019; Mon, 2 Sep 2024
 03:35:18 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yunhong Jiang <yunhong.jiang@linux.intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2 5/9] x86/hyperv: Mark ACPI wakeup mailbox page as
 private
Thread-Topic: [PATCH v2 5/9] x86/hyperv: Mark ACPI wakeup mailbox page as
 private
Thread-Index: AQHa9bO/8V6yP8NKL0Kh7Jr/YhMZqbJDIAOw
Date: Mon, 2 Sep 2024 03:35:18 +0000
Message-ID:
 <BN7PR02MB4148A328FA019239196CFB15D4922@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-6-yunhong.jiang@linux.intel.com>
In-Reply-To: <20240823232327.2408869-6-yunhong.jiang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [mieN62r3/lq0ZZG9ihE/ehGbcQEhxcOF]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SA1PR02MB8655:EE_
x-ms-office365-filtering-correlation-id: b740b4a1-24ff-45cf-4af4-08dccb00442d
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|19110799003|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 1QHpCZoAmYHbBqL1tdBCMqkB4EOAKaNjrSAS+H8mJQYcvyJlyEc3pCx9Nbiqs+2MLWWK/1uwltf7V3qX+T0eia7pUKdtbaqxKhT8qSppGWwTkqrl7zCSGjpjpku1lvm1E20MPo1j8FiKk15NUEy3Y9yqpCWcjsqPzSn0GwOLzC1taszh+rrdteupPnGERuHITqp5BD0AAjhXzR3u2wkN/dmhq6NE1Bk0nTRt/2PqGqaBNQX3rC5uSiu3BzJ76lB8CccapvFGqWa60KLjoQp1cmHIfwfJqyFubQYe9XanCvlJ6hbzRqL/XixK1me9usfjE66xtpcAlMeacELhUdd8+LHKYNxN1Ag/nqSM0BckIO4F/gVkf20Y62Re8zux8hV6JPAnaLVyfqYCju9VghFv0LBml2eXzz3UaPMEKAXORm7l768JGbIur5Z9d9q1fP9HVGsbGkDTZW6qyT1bi6nGKp6vZjXCE7jLH/JEd2T3mUvgiufD7JXh354cPhkwmpQWOz7xaXhr+ztyMvmzzTNaaraDciBK4uQwvBmXQuaQiVXYeMDQfPx0OBDPi3EdQisqwH7uipMUlJu+dw0Ego0gXDv6V5K5LAL0BhmeosacsQWVj4Ey7HffuC0gDyQxkGDuI0fVIrtw/AZhpXSc9P1zIvQPnKDIJrEpI4Z7z21qoUDhV27DVo2AoeeuTtkkw83x
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?owRnMCiwFmo1LZv0xiRLnnliBfnCIkJu5A4iqJc6kF2CkcL0YiOqm8zRKI1/?=
 =?us-ascii?Q?hmJET9SBPOuK9+1Fc+fDup+vzevFRfinpSbIpobGc5B5r9faHGA2SWX2FBv3?=
 =?us-ascii?Q?UGBrv/QZM5CMK5QtMqm/UXP5q9neDFr/v87koWm0CCFyAYSvDJLRYngU7bZd?=
 =?us-ascii?Q?iOVMyaIcckaElxf/PCmAZSd4rI29j27IBIRTP1LcpiTAuJva02jZ68tkHfGg?=
 =?us-ascii?Q?+vWiLmekN0kjjgSkzBsxcL6MS49WsOGaP5icHZtIE745jGwjP2bvYkCTox6H?=
 =?us-ascii?Q?BXt9d7ABDhHg4y3ppcxA9o0ELk+goDQmMEryYAQvpHAPNsrYjSU55FFGlPbQ?=
 =?us-ascii?Q?1HQlHxr+uGHV0D6k3uDlkBdaAcjDsxr5t/5dqRYIEUc/jP582UqVW78qOE6B?=
 =?us-ascii?Q?B+PVp2P5rvMe77n0abbuE9ylWinwwPJ9As9dErd19EQ5S7cwadhOB/gZ90T1?=
 =?us-ascii?Q?xEb6+FHfmlYj/y53snsteI+I8oSV0vScLkiaAMJaH31RKI0+Rhq031I6Ms40?=
 =?us-ascii?Q?sM3jgJNRb64Rzs31SrVmIJx2ODXh7NVzYjr8lTwdFrfe9fkN8ObSanh01duu?=
 =?us-ascii?Q?9oa93NqldY2oHiYMRExB8aiLohWNv/mxC5Ze3WvIjSuzD+zq4NEgYykK1DTo?=
 =?us-ascii?Q?Qel7o4tEXuGOVS/LLzQScYvUoeS0qktpYMaXfjZyctDiKORPifDWuTzqzbN5?=
 =?us-ascii?Q?j4QJJbRoKbWYKHtGki95pD1/nadQXBzQNAt18pGv42KttwdRBE19/8tJWbEQ?=
 =?us-ascii?Q?GxpgzKOL07aN0UtJwV4ARHelJ6jyRMgBTxTDG+wErQKM0h03H+I7FhkW3Nm4?=
 =?us-ascii?Q?xFPnvgj+WjiEk8w8tAxb/mklH0nwSQjsNMSx4NaVzlczttUOUoxLGE3LjCDe?=
 =?us-ascii?Q?P3KtGPiuVq8EC6DDUCKsjxUicghkbrjpP4jvqB9+VCL9HJ588q8xib6S4pCV?=
 =?us-ascii?Q?zX9ts2j9rMSaVfm1DxqD6ZyrXkmDxTS37o1TQ1bMPx7Mb0PpVKrbmoETM72U?=
 =?us-ascii?Q?14qghyQp/eniwn+lHEaUySYKZSz7vpVarZ9YKjILpYMJqFU8eh8NgQ7D1UwV?=
 =?us-ascii?Q?FS/TXbwhBG/C1a0ROHmPP+NVE2B6KFMNLEqtKYMi7Za96nz5xPEU2xrs5f9g?=
 =?us-ascii?Q?P+CP2lKQI7JC/yVm5P28Hq8/+4R8urKzv/eLS970hl3iCkPdk5fG+pp/Stdc?=
 =?us-ascii?Q?0c7T8oeK+01ILF3ATaIw/0YtKPT/SiRhiyF54vqATiBY6i9Xz2SOLEAMnWU?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b740b4a1-24ff-45cf-4af4-08dccb00442d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 03:35:18.3521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8655

From: Yunhong Jiang <yunhong.jiang@linux.intel.com> Sent: Friday, August 23=
, 2024 4:23 PM
>=20
> Current code maps MMIO devices as shared (decrypted) by default in a
> confidential computing VM. However, the wakeup mailbox must be accessed
> as private (encrypted) because it's accessed by the OS and the firmware,
> both are in the guest's context and encrypted. Set the wakeup mailbox
> range as private explicitly.
>=20
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> ---
>  arch/x86/hyperv/hv_vtl.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 04775346369c..987a6a1200b0 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -22,10 +22,26 @@ static bool __init hv_vtl_msi_ext_dest_id(void)
>  	return true;
>  }
>=20
> +static inline bool within_page(u64 addr, u64 start)
> +{
> +	return addr >=3D start && addr < (start + PAGE_SIZE);
> +}
> +
> +/*
> + * The ACPI wakeup mailbox are accessed by the OS and the BIOS, both are=
 in the
> + * guest's context, instead of the hypervisor/VMM context.
> + */
> +static bool hv_is_private_mmio_tdx(u64 addr)
> +{
> +	return wakeup_mailbox_addr && within_page(addr, wakeup_mailbox_addr);
> +}
> +
>  void __init hv_vtl_init_platform(void)
>  {
>  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
>=20
> +	if (hv_isolation_type_tdx())
> +		x86_platform.hyper.is_private_mmio =3D hv_is_private_mmio_tdx;

hv_vtl_init_platform() is unconditionally called in
ms_hyperv_init_platform(). So in the case of a normal TDX guest
running with a paravisor on Hyper-V, the above code will overwrite
the is_private_mmio function that was set in hv_vtom_init(). Then
the mapping of the emulated IOAPIC and TPM provided by the
paravisor won't be correct.

Michael

>  	x86_platform.realmode_reserve =3D x86_init_noop;
>  	x86_platform.realmode_init =3D x86_init_noop;
>  	x86_init.irqs.pre_vector_init =3D x86_init_noop;
> --
> 2.25.1
>=20


