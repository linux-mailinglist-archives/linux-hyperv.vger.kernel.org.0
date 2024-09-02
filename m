Return-Path: <linux-hyperv+bounces-2924-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3693967E2B
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 05:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D58C1F215FA
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 03:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC63E7E111;
	Mon,  2 Sep 2024 03:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eo/JT4p6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010014.outbound.protection.outlook.com [52.103.11.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF5042A9F;
	Mon,  2 Sep 2024 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725248111; cv=fail; b=had29rsZF5FvQzcnTvyvj8fqcPnVRakNYoTGtdL68/CPFwInUP0QgWj/wDJPM2ot1FAu39gKpaL821vawFf5CBfsmCcNYo/H5UMt2+cgb7cyKd9mXvNTvyc0mp1qPxOVlTrmlI7lTM5KwcUZmBnl9W06v/JireyUnvq9Vp+v8zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725248111; c=relaxed/simple;
	bh=H6mJwjV+bIzDth3zjam6LT/OK29heK1fiuqepNW9E1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jiyJpK4xsGFH0cIcRjAG4GXqajmNrV6ZteB/gG7AAHtYBupK1FWXarBM9YBekOMA2OAOLmh4+nvf0eXiohSoyEfpI/xsOCWYpOcGqvdQOdCbkrIoyiUPFk/cEA2bGQ1X03uekqQEK5Fn5QRI6IJOa2oaPvjd15ty7UEYs6qpVhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eo/JT4p6; arc=fail smtp.client-ip=52.103.11.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9hp0ocrdNbUbjy+kbN7E0VE5oZ+6TDDisjnnQ48LGoexRNxgWACEc6MTBmxWOZaP0ZcgCY77O2jkxdntdB6i8zWqyJomga/p6j5QxqlBy328sLByzTQHqpPec/QHYEtpwzmUiGKLVkkO0/Tf7khcy1ojeonMlqQNiGmTbz3nDJrsMNQBw9GbCRwueaOuobY/fbaZHI4N2UOSQbTSXiU8Ch7ep0LLETfnKwtVWhldEkB2+ToIFDJWKjk2kJCByiZwyjFfo/gWg813J2+KO+mI3lPJSK4FcR8ErW9aR8wOl3+AP1/AAutQGYWu1/1PO9hoOF6vrk5QewFGRN0NH0o0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2B7UoUeW3+lTA/kjHWRVOqX9FrEcwtbWeyX2Lj0ExQ=;
 b=cx2q239QkWx8UtEjN7vrsxRa4/w4ZoOewQBxgZ6reXY67VQQKMxAwOHP/6kfabrZZUjw2/G89eyY9o0JzfGqKKC0dAanw95SGvznaXd9JoWAMmxNTuLGAgsEnlmdNYqqR+SldinOQEGz+e2m18URLW8AMosLvaqbl+kZy/aFp+D7Ot44K2zRvYy7Qi3l5lBj/r41Lo2yb9RQDH1NOb1UGw+McAP1ZfPPxsEYcJTUhhqXTa0SBQyWn8vs/aDRkb3t90MiF0IIIqG5yazBAhrt+HDYumbg0Ujjl0sSbKXyoHqu78RcFVMNF8X+kfBdd68xhXUeJUgwTE374dDu6eLUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2B7UoUeW3+lTA/kjHWRVOqX9FrEcwtbWeyX2Lj0ExQ=;
 b=eo/JT4p6TcKHv0d98u9GFj+K/1MDp2tvizD2oqFcoJVOBnTJ0V3f2n3iM0/zTOhkmWK2IqQnLFwJdTXvg3D3UR1ap2E4MdIFSsFqYxWhuiEUGQqJhhZzoc+sf8jsHdMP8rCullJKyWERCxncEA402QzyGZ/mugAk0jdknumHlH4IlboQWGDuVdo31sE7OphdGswcesaAygrAfv003ebhpPd/35l2BWMdMJNaeDChKkBzOqQddAKqZIS48E7HLSALRaW2aAJ/tB1VEn/hHhD5ROV7MZKKksq7FI81Vm2aLHRihaQmW7sfdMnMZzD6L8moS9rmRrzTdNU4L+dbIn6+DQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SA1PR02MB8655.namprd02.prod.outlook.com (2603:10b6:806:1fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 03:35:06 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%7]) with mapi id 15.20.7875.019; Mon, 2 Sep 2024
 03:35:06 +0000
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
Subject: RE: [PATCH v2 3/9] x86/dt: Support the ACPI multiprocessor wakeup for
 device tree
Thread-Topic: [PATCH v2 3/9] x86/dt: Support the ACPI multiprocessor wakeup
 for device tree
Thread-Index: AQHa9bOt/5S8CVj1dUyLXfYrtF3O7bJC+pkQ
Date: Mon, 2 Sep 2024 03:35:06 +0000
Message-ID:
 <BN7PR02MB4148C25575F1C98531B6164CD4922@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-4-yunhong.jiang@linux.intel.com>
In-Reply-To: <20240823232327.2408869-4-yunhong.jiang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [KreIzO4QQLyQiI/7pEINlaASrwcR5VjI]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SA1PR02MB8655:EE_
x-ms-office365-filtering-correlation-id: 70c752f7-e99a-40ee-1531-08dccb003ce1
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|19110799003|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 mIeZyrnxXKUX1ByVGcnpMiuyuxpuFrkDLIhOtmrHLb+Td37ZcBEWMn7UCRjuwk3Mt6DmwQiFT/1wqyz8YTsaL7PV8Auwiwva9Y0Mr2A+z3awntbGbe2vYhUsha7SbfO8E22YX7a/FjB+ngSwvf/V7lO/DOmuvrX9MNTN1PhR92HHhtcqCx85r4GJCPM01mg8Vo7Dy9zjLc58ZrvCX89/75gDp0P9BofV2Ugxj/zhB7gWnVmROsSftnASOzLuKvD0DVyttaBO5c74YozWr+sMGRG8IN8NTsKMPem8M3abPDnSFQtc51Kp7S3YPn5eDqTTmyhie3LnwmbVb/FhuyvTZjHFMGW5PrKDARGIIhdBcw9u/asNygosLdryv+eAld67lomswHhr33+pDuoI5hLZB5rhAchIOcQQ6ncIXBCmUb2lbmULUQ+E82k6CvmMgjcGQEJbT/JPOEWHw36jf6Pd4ZEXND8ajzh4ypXnUR/PatDEmwS1wVjFbywHX0aIo5hpST8KfxUJtyh4qQZEJFI6I7lID3EDXteFfpUBjk1HLV1ywwBQqpZvUUkyGc3eGhNsjvojB/Q4esgJkcP+k8JrpACjzrTmJ6P3Eb0GC10DwbtfwLxf0hrNduytStOdKLM7yJsKW3gWxLoatElZDm+zNwiCcMEkT+/c4dD0A9c7eZWZSMvsqly0OIFa7AUcc+6m
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fJ0L8IUIeKOP1E6QXROgUxqM57qWezxYbGJDAo6Wd/tOSzp30ZOs81oCqSmE?=
 =?us-ascii?Q?CWd6zLzwtslAavtSbYN3lprcr+dv8Eh0HmQ+6jPm/V8wJ1cgxP9D6TORG4Z6?=
 =?us-ascii?Q?WcxW6JSWkNMk/LB1zWVhrXcMWMseM6/tTa4Em6IG9KW7onmHVWv3L38Pjd3j?=
 =?us-ascii?Q?Kb4KeFNl76d4F/syxqdT+/MtC4sAKB0EO2S9lXniorMWUCd60oUtjvkoNRn1?=
 =?us-ascii?Q?b1N4V3wRcjKpiKLrnfB4zGnN6YEjMoP6mHvpPToVuiMK54Sfnd2huDArQ25m?=
 =?us-ascii?Q?JEj5jdKPbX2/A8zGHnjasuLa4cK4eHsfejS5uxRLbKNyFqgleUWLaggaQDHN?=
 =?us-ascii?Q?neJ2S08uOz6Ob5r7PMnknOifOO3uzFhWc1h+FFop4qtQMlf/NuqpI+VJfSrP?=
 =?us-ascii?Q?hGo+711wa4tBd5xawF7KUz5jYe6eB0RrRqL0g0sqt+bPrym/Z90mVRuJGM0Y?=
 =?us-ascii?Q?mUvS+owOsDKNKkKjlZxNdFWTd2bfs7w32qHWKVUyNqmsJGJOmnQuaRNpYBVu?=
 =?us-ascii?Q?mOoPl5E7DFqXHXEioUps1nlRnpjnRWK8bhYceZytygphuI9yHhUYdT0/3gMa?=
 =?us-ascii?Q?UdxWDdp9HITaUB/SPbBcIG2obRr5lMaQ6sw1NCdG9JyKr01zjHVpqra6TVa5?=
 =?us-ascii?Q?RVvP36q0xHbery06EO28fRVDPm3m4J0+Sm4gjKNEd5IiPxB009w9q/bCY3tU?=
 =?us-ascii?Q?YW4gc5YFiUKmW3v/l4lHavggSG5A565So9GNvOyfRM/GHDy+18sOg+sHa1lO?=
 =?us-ascii?Q?eri8Z22T6m6izRp23MNAYhs4l7NOofUrRnNcdEtilIOFYczqg78Sg+wQaFsV?=
 =?us-ascii?Q?gAXhoMgxKeIsT+93vzvvVQYHTJI/4kuTLPgumiYlMObleYF0VSZhO41xjCBU?=
 =?us-ascii?Q?JJ3iEer9Kvg6FUmKPINAkFv2S/mhnJDigqqfKr9seURbZi3B/s9SWdfULFvX?=
 =?us-ascii?Q?1QbG0rFOvJLRseBeA8HMhqiVAt2uhJ1Gm+Whxw/Z1XHX4woA/bCZxyQ4UZ9o?=
 =?us-ascii?Q?LbPsZoNgRhBkp0tec3XnjeLxXQgE+hhcJaqxd9W0uVAtyOBnIeFdXihCC/Mx?=
 =?us-ascii?Q?twqF4BQRZU2NC6FGpfj/TyXEd5vu3X8EqYjjnxdBGbfjCwzOWeyidtKboQPr?=
 =?us-ascii?Q?A3GJg3IMpyXth1p984HJzuQX4GJNAhbSy1/Qs1Hqu8bx9dFjKX5RHxCQ/SiX?=
 =?us-ascii?Q?KAjFVmx0CWTuW716OqMkhpAVy+g8K9IcjcbdazWw42wG1OdLceX107tw4MQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c752f7-e99a-40ee-1531-08dccb003ce1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 03:35:06.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8655

From: Yunhong Jiang <yunhong.jiang@linux.intel.com> Sent: Friday, August 23=
, 2024 4:23 PM
>=20
> When a TDX guest boots with the device tree instead of ACPI, it can
> reuse the ACPI multiprocessor wakeup mechanism to wake up application
> processors(AP), without introducing a new mechanism from scrach.
>=20
> In the ACPI spec, two structures are defined to wake up the APs: the
> multiprocessor wakeup structure and the multiprocessor wakeup mailbox
> structure. The multiprocessor wakeup structure is passed to OS through a
> Multiple APIC Description Table(MADT), one field specifying the physical
> address of the multiprocessor wakeup mailbox structure. The OS sends
> a message to firmware through the multiprocessor wakeup mailbox
> structure, to bring up the APs.
>=20
> In device tree environment, the multiprocessor wakeup structure is not
> used, to reduce the dependency on the generic ACPI table. The
> information defined in this structure is defined in the properties of
> cpus node in the device tree. The "wakeup-mailbox-addr" property
> specifies the physical address of the multiprocessor wakeup mailbox
> structure. The OS will follow the ACPI spec to send the message to the
> firmware to bring up the APs.
>=20
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> ---
>  MAINTAINERS                        |  1 +
>  arch/x86/Kconfig                   |  2 +-
>  arch/x86/include/asm/acpi.h        |  1 -
>  arch/x86/include/asm/madt_wakeup.h | 16 +++++++++++++
>  arch/x86/kernel/madt_wakeup.c      | 38 ++++++++++++++++++++++++++++++
>  5 files changed, 56 insertions(+), 2 deletions(-)
>  create mode 100644 arch/x86/include/asm/madt_wakeup.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5555a3bbac5f..900de6501eba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -288,6 +288,7 @@ T:	git
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
>  F:	Documentation/ABI/testing/configfs-acpi
>  F:	Documentation/ABI/testing/sysfs-bus-acpi
>  F:	Documentation/firmware-guide/acpi/
> +F:	arch/x86/include/asm/madt_wakeup.h
>  F:	arch/x86/kernel/acpi/
>  F:	arch/x86/kernel/madt_playdead.S
>  F:	arch/x86/kernel/madt_wakeup.c
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index d422247b2882..dba46dd30049 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1123,7 +1123,7 @@ config X86_LOCAL_APIC
>  config ACPI_MADT_WAKEUP
>  	def_bool y
>  	depends on X86_64
> -	depends on ACPI
> +	depends on ACPI || OF
>  	depends on SMP
>  	depends on X86_LOCAL_APIC
>=20
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index 21bc53f5ed0c..0e082303ca26 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -83,7 +83,6 @@ union acpi_subtable_headers;
>  int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  			      const unsigned long end);
>=20
> -void asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);
>=20
>  /*
>   * Check if the CPU can handle C2 and deeper
> diff --git a/arch/x86/include/asm/madt_wakeup.h
> b/arch/x86/include/asm/madt_wakeup.h
> new file mode 100644
> index 000000000000..a8cd50af581a
> --- /dev/null
> +++ b/arch/x86/include/asm/madt_wakeup.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_X86_MADT_WAKEUP_H
> +#define __ASM_X86_MADT_WAKEUP_H
> +
> +void asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);
> +
> +#if defined(CONFIG_OF) && defined(CONFIG_ACPI_MADT_WAKEUP)
> +u64 dtb_parse_mp_wake(void);
> +#else
> +static inline u64 dtb_parse_mp_wake(void)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#endif /* __ASM_X86_MADT_WAKEUP_H */
> diff --git a/arch/x86/kernel/madt_wakeup.c b/arch/x86/kernel/madt_wakeup.=
c
> index d5ef6215583b..7257e7484569 100644
> --- a/arch/x86/kernel/madt_wakeup.c
> +++ b/arch/x86/kernel/madt_wakeup.c
> @@ -14,6 +14,8 @@
>  #include <asm/nmi.h>
>  #include <asm/processor.h>
>  #include <asm/reboot.h>
> +#include <asm/madt_wakeup.h>
> +#include <asm/prom.h>
>=20
>  /* Physical address of the Multiprocessor Wakeup Structure mailbox */
>  static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
> @@ -122,6 +124,7 @@ static int __init init_transition_pgtable(pgd_t *pgd)
>  	return 0;
>  }
>=20
> +#ifdef CONFIG_ACPI
>  static int __init acpi_mp_setup_reset(u64 reset_vector)
>  {
>  	struct x86_mapping_info info =3D {
> @@ -168,6 +171,7 @@ static int __init acpi_mp_setup_reset(u64 reset_vecto=
r)
>=20
>  	return 0;
>  }
> +#endif

When acpi_mp_setup_reset() is #ifdef'ed out because of CONFIG_ACPI
not being set, doesn't this generate compile warnings about
init_transition_pgtable(), alloc_pgt_page(), free_pgt_page(), etc. being
unused?

It appears that the only code in madt_wakeup.c that is shared between
the ACPI and OF cases is acpi_wakeup_cpu()? Is that correct?=20

>=20
>  static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
>  {
> @@ -226,6 +230,7 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long =
start_ip)
>  	return 0;
>  }
>=20
> +#ifdef CONFIG_ACPI
>  static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup =
*mp_wake)
>  {
>  	cpu_hotplug_disable_offlining();
> @@ -290,3 +295,36 @@ int __init acpi_parse_mp_wake(union acpi_subtable_he=
aders *header,
>=20
>  	return 0;
>  }
> +#endif /* CONFIG_ACPI */
> +
> +#ifdef CONFIG_OF
> +u64 __init dtb_parse_mp_wake(void)
> +{
> +	struct device_node *node;
> +	u64 mailaddr =3D 0;
> +
> +	node =3D of_find_node_by_path("/cpus");
> +	if (!node)
> +		return 0;
> +
> +	if (of_property_match_string(node, "enable-method", "acpi-wakeup-mailbo=
x") < 0) {
> +		pr_err("No acpi wakeup mailbox enable-method\n");
> +		goto done;

Patch 4 of this series unconditionally calls dtb_parse_mp_wake(),
so it will be called in normal VMs, as a well as SEV-SNP and TDX
kernels built for VTL 2 (assuming CONFIG_OF is set). Normal VMs
presumably won't be using DT and won't have the "/cpus" node,
so this function will silently do nothing, which is fine. But do you
expect the DT "/cpus" node to be present in an SEV-SNP VTL 2
environment? If so, this function will either output some spurious
error messages, or SEV-SNP will use the ACPI wakeup mailbox
method, which is probably not what you want.

Michael

> +	}
> +
> +	if (of_property_read_u64(node, "wakeup-mailbox-addr", &mailaddr)) {
> +		pr_err("Invalid wakeup mailbox addr\n");
> +		goto done;
> +	}
> +	acpi_mp_wake_mailbox_paddr =3D mailaddr;
> +	pr_info("dt wakeup-mailbox: addr 0x%llx\n", mailaddr);
> +
> +	/* No support for the MADT reset vector yet */
> +	cpu_hotplug_disable_offlining();
> +	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> +
> +done:
> +	of_node_put(node);
> +	return mailaddr;
> +}
> +#endif /* CONFIG_OF */
> --
> 2.25.1
>=20


