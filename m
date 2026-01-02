Return-Path: <linux-hyperv+bounces-8114-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1886CEEEFF
	for <lists+linux-hyperv@lfdr.de>; Fri, 02 Jan 2026 17:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3953230057EE
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jan 2026 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C403129ACE5;
	Fri,  2 Jan 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z+marjZB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010023.outbound.protection.outlook.com [52.103.20.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0629AAE3;
	Fri,  2 Jan 2026 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767369778; cv=fail; b=sMU5PY+cQFs6kY/XV9R1mBFJiX1RNlFBy78L819IxU1mQMnKJGOLdeaw78/TXw9JgORrHPFYzyPvLgN2Vk3u2UYhwvIzhOzQ/ONCcmaHidNoRk9H/CET64ivnXODG4fOEKD2QCRyABg3cYO5KErKje47504s6XH39bVJ921/YG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767369778; c=relaxed/simple;
	bh=Qkc0lDNKVQXdq89JuOvP4XfMwJm+SPwGhweeKBDZaI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e18TZprKJJaxqRSP1oZt4ZyUpOpjIH9qmuarptDOFujADzuwfuEBtsuCERHCjnbPG4UliqAekGCXd4y15cKw7CLgGTB1fR8BNo+gF4jdnJWd5OnOOmeQEmrPchfExATl/joG/jDvx/7yA9jWDzGSKwONRcjHbdi6HO7zOeLWnec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z+marjZB; arc=fail smtp.client-ip=52.103.20.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nb5s7G6Q7UNsCn393MrG+Ii92hcTnfGagdjSjx62O3xWeDdmBOrMenawIt5KxBBF3oQTqRmcEc+AiB7mVRqzwhhdJdYPleIN7LSMxpiw7jIXndM/D4qqH0zrdWuEjqIIKm8xgIzRpHKTG4fBLx8qibXyt5xCULHLrubjrNtprZRYW3UEwsW558GEo6HV260PFouDw7dzSmEJjIgLYbIjMkQ6rAR0JB/logfbj5TPqr09hjEiViYD7b+THo4r6vpmNCT4YZdA0QSC1mRqt6nW7qJaJm/23WZeZjKIMHGh0vqK0n0kLH+ToY1gzNxGifVhfevJd2SZ+GYxKB+ZXjxFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMR3lkd0rg+sXZkx577A+0DzOM98opdQwbsmAxzrfy8=;
 b=W8Sq2Q4TVoeZxpoOD+cJ6ccJSANRnwNFfvkMNwc9wg6W2wivLUmqXk5YgUQEsZzEolN37bPKeo+EWonybBxnPPLomUzPd/qjPzi5XCDFsp7XsYF9bhsuNvh9kNqfuWPFznKhdpM5xW4DU8wE6yIVjxfzQrw4LhL7mWsYxi7TMVZmw24C7ZFLU2VsMAdIgu+d6KRGSlDpJGh3VumVMHcH5C+1U4tOzLUR2qxruUiWyrsn1nWU4rYTKXOVHBK966wwRjEoce5/YKUtSeMKPXyUdA0MCek/I0cq9QxCYTxF6SNVnJWvgZ6Ie6plxXsj+0zqRqhUkjiJunk+ZHGXqhbNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMR3lkd0rg+sXZkx577A+0DzOM98opdQwbsmAxzrfy8=;
 b=Z+marjZBve+sRt54nMAfvkSTUcXTMDwCsG1MpYcTCaVT2SijLjMZk/reeUcmyZpZs8nJCTKK7I9FIusOCllZWram8anp8pFE9femd8xYKkaFLGQC0EJqP1TSGFstCpy1J2S9OV56zYTJn8w9R0UPDfEpteUjKjt8MBFzQbBuw5+ZANqKtrGJ9HzsFKHTcH0knmWgqG8qNnJDsUTg8GGiFVignHD8aTJCBFQvt6nKM9pDM24fyKTpsxZ//6Zia8ALh0Zqvem+eAllF8iMMfT3qhhjBZdRjQMnYnxoC7qpPMEbUelNZbvyJFeaNWaHDd/cW1S1IvwMk2xKT6+vmrjldA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7421.namprd02.prod.outlook.com (2603:10b6:a03:2a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 16:02:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 16:02:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Mukesh Rathor
	<mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [RFC][PATCH v0] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
Thread-Topic: [RFC][PATCH v0] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
Thread-Index: AQHcefPFv5oGmx+lI0OJV9/GZUX9t7U/DHEAgAABIiA=
Date: Fri, 2 Jan 2026 16:02:52 +0000
Message-ID:
 <SN6PR02MB41575124C6D2CD7492899991D4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251231012100.681060-1-mrathor@linux.microsoft.com>
 <877bu0au1t.fsf@redhat.com>
In-Reply-To: <877bu0au1t.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7421:EE_
x-ms-office365-filtering-correlation-id: f46e43b0-4ac7-4a85-6bfc-08de4a1862cf
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|31061999003|13091999003|15080799012|51005399006|8060799015|8062599012|19110799012|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CH1XpffqvoLkfvePBwSUEMz4C1soOflk5ykpezoDt2Rx1zDzNfv4KC3GXijG?=
 =?us-ascii?Q?Zr2/rLFdsh0+Ir6E0ZsG9/OCZSK5VfBq4dQJ7Cs8pgpXB9eZ+zeFcNLQcLPv?=
 =?us-ascii?Q?aql/EMiAfoDSXHgRXKpPcQyeitW0iMsENxhs8urnB3rsbWyPsyQyiVXIQRph?=
 =?us-ascii?Q?M+pHd35WdH9p5m/tDr3eodY3TbqClfNUNlVTTelQOntmvy+0Th8RLL3dJ7/W?=
 =?us-ascii?Q?sm75rKYUBItv/jWXEuejJLOEkzBe+eN1Fa3I1bngilVZxGBPbJgg5WiBIJMg?=
 =?us-ascii?Q?d9QFodqlE6CoFSLkM6x+uYQIq/DcueJTfERBzRdUwR9T16Z2nSm/NsM2ZkeG?=
 =?us-ascii?Q?cGsOi4bUALTp66huo/TmMHkuaKpHhMDT85FiVwyre5kb5GAPllxVHuOZkeLX?=
 =?us-ascii?Q?5nZy2/xUfityOsClsbddtuk1Kmk5X8rNvcnjATGHhOiGsMnesUPDu3w9KzQw?=
 =?us-ascii?Q?DK80BKZXTarBr5v4p+ZVfF2plt4dBeLXNdDQh+xQTvRF/1LtyZQJk5PZ8Bhb?=
 =?us-ascii?Q?eKt6VX4gG84CyQjBzNZN0C4KDx14WqqlZHUQt1R/11iTM1vRb5sgHlgiaQWx?=
 =?us-ascii?Q?K8lSabNUskmIsxIwdGxNJUAUiX84ZfN4Wl9OsnYiiX6sRYOut7AV/8THo9nD?=
 =?us-ascii?Q?cf7cBujxErUkDpGhN+OjcqxfPlPuZDrXCwprdoPvGT1VFgiEfOEKjp5UQ7sc?=
 =?us-ascii?Q?iHPGb5QO0AgbL+bFoocl9fnTZyrfI57BsNX19PNVN0rKDaqdzIa+IpOmKi5c?=
 =?us-ascii?Q?FGGnIzdeghRAbBjC+BZ9Xlb3JNo/5fkWkzcgF0jhuZ5JsEWJ1m2og3S64r9f?=
 =?us-ascii?Q?MXeICnuEbqaeivGZ5WwD4QFWbHnlTzJItobzUFGUfnyU3HFEuma5T+uXjz6i?=
 =?us-ascii?Q?BagrnDyv33Rnjhu34lDqNzGRuXf5AkVyBeRjQXn8jLn+DuXhnqWLkkmVrxYp?=
 =?us-ascii?Q?iTiQwu/Jsqr1f/N8P6BxlNjY0JjF40xmvk5WI74w1FXmS+XMkSm18qdHGPR4?=
 =?us-ascii?Q?1Fm87lwA9pX2RZdmRbzmP8mnQkVYDn65axNlC0vNAKWG9bsT/Y0925t1Xg4Y?=
 =?us-ascii?Q?LZMrzUaSZ20MuuewcMjUNkPEYbbnsjCvpwlTbZTMOauXqjUybcvHJFqg+ClR?=
 =?us-ascii?Q?YNgUZWcBwQp7riro7nRPeTiBKRnUiEB7M7+qpIwwhC4Ghi3gqnYqd2qo3tcg?=
 =?us-ascii?Q?OGpzFGiIlmZxIWTqryN2aJ89jxJJhkzhDHUznQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LjesWdHrpR6beD4Lqa0ZuW1NxeV8Gc+THsBhSofXhMXEOCdaEykn6e9FmZXg?=
 =?us-ascii?Q?mbrqQCXOeTSIUk/5uPTWZH9LtcaAM2gbhL6C3YGrEUgJKmYPd+781Zc98kH5?=
 =?us-ascii?Q?6vYWQ/71YgpJ85PHz/OHLVAz8Vm4BoG7ZrhstjEU11x9ezWyz2AmrO6wVdCt?=
 =?us-ascii?Q?7YayCdcwMXhagIQxLgm2Oy61zAOZh2vv5oXqGEOBVuxM9bmF2/layr6m6tF5?=
 =?us-ascii?Q?w823jbqaF6PFtNvWAZGuf7lIFgwTSsdEDyK6CtEmP6ZlugonabsTLvtWd7nU?=
 =?us-ascii?Q?g1q3uMlanGbZCVTk96tBBFA5yu4rKlrJ3CPay4ru4+3JDyqdWvukkBrtMlio?=
 =?us-ascii?Q?RX00cBanh8JKGd0bLElPrFPzB6c6ANKLEe+Zah08IHsmLLkWitOrnM2NCqvc?=
 =?us-ascii?Q?mmCA9BaquJpG9PzgdS1FTE3rRgzbGJlrHONflwSPqysdQwX2lFFzEboF9F0D?=
 =?us-ascii?Q?7b9eord7S7Kh/ti7JcAZxvL5MM6BvKcM309oKaNufsstbTeU0hho3FE9GGXH?=
 =?us-ascii?Q?oQZyQUidAb8cNMpKm+K39+idU9q3L6n2P9CIzI/CzMrQ/NlYLYcp6yhec/DH?=
 =?us-ascii?Q?hjFQBk1e5RCozUh7KdmsLFFL6yVzS9q5MP3a329pgLw0MDRNLKtDJKSuD6hc?=
 =?us-ascii?Q?trzTc8HnMaK3CjkvkRvtfKrTqd/vg23hVU5/kgkD2nflprOeWfyIH6UX41AJ?=
 =?us-ascii?Q?JkQeTPn92k1BCQzATN9ZWc2dEAPsaZPidi6g8THKr9wadt9LzQ4oOorxIVi3?=
 =?us-ascii?Q?dKfukmi2U9xxsujmDA//MOy5vHXu+QIkhnT0AdhPNy53xj9+g4zwQpH3DNgK?=
 =?us-ascii?Q?GG7d5Tn15UXcYg/RuwijfXHKotQnYoE9BiNEjWh7iXszubnyIZvBV0s6wMMt?=
 =?us-ascii?Q?A+EQyBEwWwyLD9gIlZQHdUFfUSBBilzifa92Zb1nzrdoD7+Fow5eeNgnO60O?=
 =?us-ascii?Q?WHcDatPpYUKBC90WaVSLtiQ56YsxbmGxL5QAD9uH/7hxRZmWPXn9YVuMkipa?=
 =?us-ascii?Q?IR5Z2EJhfmr8mWrHQdc1slhVVgSm26XLl2hLQywnC0spFf50YSwlVUFt6Wb6?=
 =?us-ascii?Q?7eVhXX0zmKgwrpQKNM3iGc2/PoRIcjajOwfgDecWeJPd3ASXcqFKs0vzWAd2?=
 =?us-ascii?Q?9CMQjkRlsdQXTDzxf78IACQNveVhTFB33RaGdNEY/7mxBSgCeTzdc/LH2Ntl?=
 =?us-ascii?Q?1pPrzkx5dZ3HQ6qlxaHyYnQpNHGHJ4SICnPmsxximBU8UxPLKI0IrwWdpJFk?=
 =?us-ascii?Q?o7q0r7rnY/MPZyY5RaCZqdEH7P0SueONuxikStYA/qn0QOi3FPwR559XdR9Y?=
 =?us-ascii?Q?DwfZOS5AVKYlcRbMxPjsA+mfIGtZsErFTbXPY5iabldWIWZT6ULueUojtU0v?=
 =?us-ascii?Q?Hicv8fI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f46e43b0-4ac7-4a85-6bfc-08de4a1862cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2026 16:02:53.0173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7421

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, January 2, 2026 =
7:55 AM
>=20
> Mukesh Rathor <mrathor@linux.microsoft.com> writes:
>=20
> > MSVC compiler used to compile the Microsoft Hyper-V hypervisor currentl=
y,
> > has an assert intrinsic that uses interrupt vector 0x29 to create an
> > exception. This will cause hypervisor to then crash and collect core. A=
s
> > such, if this interrupt number is assigned to a device by linux and the
> > device generates it, hypervisor will crash. There are two other such
> > vectors hard coded in the hypervisor, 0x2C and 0x2D.
> >
> > Fortunately, the three vectors are part of the kernel driver space, and
> > that makes it feasible to reserve them early so they are not assigned
> > later.
> >
> > Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyp=
erv.c
> > index 579fb2c64cfd..19d41f7434df 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -478,6 +478,25 @@ int hv_get_hypervisor_version(union hv_hypervisor_=
version_info *info)
> >  }
> >  EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
> >
> > +/*
> > + * Reserve vectors hard coded in the hypervisor. If used outside, the =
hypervisor
> > + * will crash or hang or break into debugger.
> > + */
> > +static void hv_reserve_irq_vectors(void)
> > +{
> > +	#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
> > +	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
> > +	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
> > +
> > +	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
> > +	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
> > +	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
> > +		BUG();
>=20
> Would it be less hackish to use sysvec_install() with a dummy handler
> for all three vectors instead?

It would be, but unfortunately, it doesn't work. sysvec_install() requires
that the vector be >=3D FIRST_SYSTEM_VECTOR, and these vectors are not.

Michael

>=20
> > +
> > +	pr_info("Hyper-V:reserve vectors: %d %d %d\n", HYPERV_DBG_ASSERT_VECT=
OR,
> > +		HYPERV_DBG_SERVICE_VECTOR, HYPERV_DBG_FASTFAIL_VECTOR);
> > +}
> > +
> >  static void __init ms_hyperv_init_platform(void)
> >  {
> >  	int hv_max_functions_eax, eax;
> > @@ -510,6 +529,9 @@ static void __init ms_hyperv_init_platform(void)
> >
> >  	hv_identify_partition_type();
> >
> > +	if (hv_root_partition())
> > +		hv_reserve_irq_vectors();
> > +
> >  	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> >  		ms_hyperv.hints |=3D HV_DEPRECATING_AEOI_RECOMMENDED;
>=20
> --
> Vitaly
>=20


