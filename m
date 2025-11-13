Return-Path: <linux-hyperv+bounces-7555-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8E1C59D19
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 20:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE75A34546E
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 19:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD62931D72C;
	Thu, 13 Nov 2025 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WDx4FGQy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010007.outbound.protection.outlook.com [52.103.13.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF0E31D384;
	Thu, 13 Nov 2025 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062938; cv=fail; b=NVmE9SNt56uS4FFOBTr/WlYf9WHJCnflb7Dt+3LoGSVTVxwkq1IVXtNrhoTZTwaDyMKJbELa1nJk6YpInnsgkaS46G+pho7ig9AU+jBY3bQlVALXglsYZdXz7io3A9k72rXab21lUGuP220et8wB2b7p0ou/T7GnYpur7t/I/E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062938; c=relaxed/simple;
	bh=/JBl029aUZ8jxyVx807wyOFh/wCDxskAgO4OLhhc18k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eC8eui0VxMewbdKfVxA/8uNPQGw633fjN9D9Z7h4/oEKV8nrtO0KinnXAoWsKSZvDMG2YuvCclTlhJTVLfhQeHT3u/nI8U17giSIPqvQ7+bGPcbQFp1LUt9YWuqZnnYJSY1qnleriIbP2ndg42VrmNFVIqrDtC+FrVyVqtZWGWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WDx4FGQy; arc=fail smtp.client-ip=52.103.13.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQFvVz651yeNXSFgYNP1JmLOa+ZHyq1qKb9NRjSiw8Q3SMoXVo4MAO//rMh0r9uYu1KD/9uR1CrRlxc3+y/Ny224DrcSQ2c52g2tHXFkuaoHKLLjv7Rd+ptksXIBWuuZ2qnaM8jkqn8K41g7UbxmgrZ+lQ+pcBOxP2iNrDTRjB3W4NqSHDs2S+BqoqF7jD+tX9i8A3vtP55ZA1U8silJXfRzU6/2aMoh8wj3dGyGwlhHUyH+rdbkBAe7AidRLoR2a81ieNz96BKxQ4Ny26UPGfygQktGRBp85p+bwLgxGPliPy+PVqD1me9Ra7ih2yjkFgQ5rp+VZg6kychNvAHMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAfJf7yChYBavrmbrNhLiR6VzjfRo2wkvqb8a9DlOV4=;
 b=IGyF0B35DvctrdC4PLKToN/a3Qj6KUQNrz9wVUrViCFx1SeVrrUi1s34fXbAXW4sno1ZHfhyzm7nCcYMBRGIK3S0cshBi4YbYgYwSWAOmyNA+d3BbC1Js7M3a6pFa28oO//wW9b9wt8O3aI3sQAvSk+r2uekAh3nBIFQyg4RYiR4G5t9wkPgfBzrVDGO8XMkNF0UCB9VY6DK1Q8HR/0mlqbcmGn5xvTbJCErP20m0I1z6MnIlMPM6RZZwsRWZA8TB98fWbttlXHvGtQNxh9fYhgs0yZjXJ77ljqAB1bxGuJdU4FqUwRZXWuRvYr9tbEdsd4iVKiAm4XaHYoB04dm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAfJf7yChYBavrmbrNhLiR6VzjfRo2wkvqb8a9DlOV4=;
 b=WDx4FGQyItoiFMXHCexFy0nD37IcmA9Y/Mmxko6S0u88oBlkHDRhC7b4R1q98h+EO+HtGJnqewfXf/wYgHREJCSn6jTgNcR6fLpGOGAVioP69sWrzvwrNnbVfm+Y2sbm4oplSGrT+1jdGO1wnNEnPpOuUsflBGgcSE6lQV6CKQmZzQxUn8UxM629xxArxukWMBvU6EeFXBCmAZdVqtBkg3NYBdxBBRxTFESmWPiT5ot8KnPyZNa8dWAXSaSqiT0qKZFkDXLB4xCtqiZ7nSLvTrVtyPqMkVjh4ciQwEZISRXo8ELMP72LNqJwsb6YuLbVL54fcXN+6xZRHmr+e/UgRw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CYXPR02MB10195.namprd02.prod.outlook.com (2603:10b6:930:d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 19:42:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 19:42:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>
CC: "anbelski@linux.microsoft.com" <anbelski@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>
Subject: RE: [PATCH v4 3/3] hyperv: Cleanly shutdown root partition with MSHV
Thread-Topic: [PATCH v4 3/3] hyperv: Cleanly shutdown root partition with MSHV
Thread-Index: AQHcUDRH+dc6yAPQoU2Iu6/B/b58irTxB7IQ
Date: Thu, 13 Nov 2025 19:42:10 +0000
Message-ID:
 <SN6PR02MB415764759BCA5070B8303AF2D4CDA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251107221700.45957-1-prapal@linux.microsoft.com>
 <20251107221700.45957-4-prapal@linux.microsoft.com>
In-Reply-To: <20251107221700.45957-4-prapal@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CYXPR02MB10195:EE_
x-ms-office365-filtering-correlation-id: e82eda5e-9ca5-4b65-6ae1-08de22ecbce3
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|31061999003|461199028|8060799015|41001999006|19110799012|51005399006|8062599012|15080799012|12121999013|440099028|3412199025|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?c3A2XXzZQ4GBmIy99g/GHmcH9MGiCmHn9OBXuEAxjhbxTRU4yDmAiZZaEOTf?=
 =?us-ascii?Q?4tT7+QMP7hLunc2RS52sLdEmbJO+nSVj5hEyN3kP3HeG5UZ2ILk/BYSsbPcg?=
 =?us-ascii?Q?P5Nbht/dWSUuUa9cQNosXAR2OWmK5YZYYe9WiyPzcBnehdINTrI0AKokbZIA?=
 =?us-ascii?Q?kiqts8abHmP4zUUODouhlXI331fjjdpbOtDGoLMppOQCHLT1eW1JuKcFl+2c?=
 =?us-ascii?Q?C4MlByPNWEO2VlM2HIBlydIcxphOwqnhbirXa4H6UCKkUfSezb4f8wgKsFYS?=
 =?us-ascii?Q?wmFOI6wIhcy41qYL/NSoCxSFUO7wefDDbpWAap2J73pQCDnZC2DyoteV0ISR?=
 =?us-ascii?Q?3CoCZehfzUHdrE6KtX6MGF4ulJL6t+lSZlXMl65sXq/eLaj7Gat4P5NWPmTe?=
 =?us-ascii?Q?RD4HwrNAUS67f3yLQR3QOcs8ohtOQ6lO1SaA6pEEfeB4/9UQK7WSDdqV6/Xw?=
 =?us-ascii?Q?uckot+WDdylMgMz7Y+UXpGo/ewW4N8gdcymVTOc3Cp6TAx7quI+1KGJAaWqE?=
 =?us-ascii?Q?by/fFVXMxlXOe6vCPZivo6PigwqH4tR/UgB+PlqsA+KjHOBj7XAwpf2oCNvk?=
 =?us-ascii?Q?CpK7rs9YyLcNs0N97T0FwkJvcqBButDYG+BJhL+TPPMkcdl9aBAvAhAzI/H0?=
 =?us-ascii?Q?HZPZAISMGQvWkY2OzF2toIo2aa3mV6fCkUUlhLsURmKMCBV2tnzCMWvsi5vO?=
 =?us-ascii?Q?sWL+zF+vkvJzGYm38WPVvMfm3EZIXRj5drxqDVg35b/kTH6LVEJJhxNRlh5W?=
 =?us-ascii?Q?LmmFTYq7Ju8HmI+YboPAp+vtTrrPThRFOANtTXlU3b/zaCRBy3HjcizAnobh?=
 =?us-ascii?Q?MhwKCPiQ0HjbDTQNI2oFg95bRbv2Mv9ay/ptTYVrgvADr/4faImDKuZJ5KLN?=
 =?us-ascii?Q?QFUvs96GbZbKGvklcPo83yhOPXSthOr+qFOTU5LqQW4kd5sE3m/jHAAQJMf9?=
 =?us-ascii?Q?UlRSYXEN1aPQrdj4mRoZjvlzkNEpKZRIRL43gDcLWS0GMNX4IUU7RVEJWQvx?=
 =?us-ascii?Q?POTrw81BxGm/+bFiXHcs1E64ulohg+Abepajl093K/tTUKN9dhHrJL3GHSZa?=
 =?us-ascii?Q?ICSqGCWI2aGFEX2TH1bYIOvpl35A5utCsrp1opeTELON5O6jWGDe97DunqO6?=
 =?us-ascii?Q?zN/KJStem5lsPneDgwcCX1aYUkxlY3PGkBQw2VQbqIjD9y7mENW0hZi42s0j?=
 =?us-ascii?Q?W+YpFsnmenugbxYh9St+KBSVmxZmta6cNry/3+jwrS+xz23pQuLg6bVxDs+X?=
 =?us-ascii?Q?wy55/IbrxedIoOVW5q9RlsjvaWume3oKoWxYkPj3+Oh+GORghrdVr3BJsgRM?=
 =?us-ascii?Q?7AJdvqAMIV9q5QX5bYV/UruX?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Rvk7lVFAEn1DiFlMr7HO2SizmbbGIU0uItwHgWQNwwZ6flcU3jeSInb0nPE9?=
 =?us-ascii?Q?g2bLkPUF9RoxMst1pau3IP5Tv3P8lwVJ7ejOhiC5HshOiM+kpOmzhyNBTyYW?=
 =?us-ascii?Q?x8l35qKm7FkTeTpRmxQ8mXIqUH0TyS/36t4l1J/133VwpHKZDXrgdTORGEiO?=
 =?us-ascii?Q?3pSXh0diJObZgSygY+bOXjOLtPvy/Lejs4TWse94bgRUo1LPYLSisVFo94PN?=
 =?us-ascii?Q?vHPZpHPApzwJbxChDnrLORwY+ee+qF694Xei/1tjvS/3M/WBbfMmeQaaAgSZ?=
 =?us-ascii?Q?wV5ZuNBGT0bnfRfiBD6HqkaqW1mhTmXgMPWBMYMOT1KLWAFrBKuRUlwwhrOu?=
 =?us-ascii?Q?P746t3aw6+QRwcAItmEIU6C7epE0dBJ8gpFlhxssMdjEr82mli5Mpz0H/+4z?=
 =?us-ascii?Q?09Sp7sdS7S6P6R4ftu31Q9N4Z9Co1ea4TNevpYjSEiNZiLcc96P1G8Ywqlsd?=
 =?us-ascii?Q?neGBC7nasPAHWW3dO+pwLiWwMUKstMOmJYlji62ylgV8AUF03vIYALHAEiMI?=
 =?us-ascii?Q?GT9+J3xG4P/2sq06inMhu4ge4/Mum0WSMTnDT+eHqY0Bp8655cWf1JXJaGvH?=
 =?us-ascii?Q?z0m5DO3+LrxvIUglkaqXc4iJD6CCCexRLNTgnGbGqpYpPDltPV4EB9iPy0LZ?=
 =?us-ascii?Q?V4Jn6mdaRp+T4LrOP30Oyaba/F8X7sVGejzLfvthY6oLrbAZwIiqqfsokDOq?=
 =?us-ascii?Q?o33hGQ1xjT8kI+Wp4t0Nc4MaQpoBShvxproJ+1lAWYABerTJbULcmAVvcLMs?=
 =?us-ascii?Q?LlxYjFppcNAuzsykOD52Po8rokLoJs+8YOs0+VI+YUAwM+6VaN/NOXcptGyu?=
 =?us-ascii?Q?+jlUyhxW55ro+HrsK4cermtwE1K74tI8mVVYT+tNfFx/CSRbZLbhtKujX3e/?=
 =?us-ascii?Q?UkdSDMloaeQjCIghSivsfRga+TX2AXLwA+wTO/q+AZFHU3hJluzHCk3c5RfE?=
 =?us-ascii?Q?ZrHhuxy7wbX+aSBlpbZAeB69tftgxK3P2e7D9dKLfGRFsuouFi0Js7d5MITh?=
 =?us-ascii?Q?HP4f3xgOVRrzGLC0UTSFK2T5aSoR2S3Pkn8E2NP8j+EkoP2AVqI5f7/BNgXb?=
 =?us-ascii?Q?5fDudE9H8iocUN+W7hsWrBDBnayGF4I1A2gqd06MHsUrh+u0WJewskAi7pm+?=
 =?us-ascii?Q?bbQbgA+pjgaUQNfZ6DP9tp7vtKo5z0H1G50UUGgmDRi1pQiOdys3dO2/JrAz?=
 =?us-ascii?Q?fsCxozJr7VbWcQNSLgPuslHmd5WtwFD/BXWUTkbiy+yfMVYRHfmLxAf2Euk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e82eda5e-9ca5-4b65-6ae1-08de22ecbce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 19:42:10.9545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10195

From: Praveen K Paladugu <prapal@linux.microsoft.com>
>=20
> When a root partition running on MSHV is powered off, the default
> behavior is to write ACPI registers to power-off. However, this ACPI
> write is intercepted by MSHV and will result in a Machine Check
> Exception(MCE).
>=20
> The root partition eventually panics with a trace similar to:
>=20
>   [   81.306348] reboot: Power down
>   [   81.314709] mce: [Hardware Error]: CPU 0: Machine Check Exception: 4=
 Bank 0: b2000000c0060001
>   [   81.314711] mce: [Hardware Error]: TSC 3b8cb60a66 PPIN 11d98332458e4=
ea9
>   [   81.314713] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1759339405=
 SOCKET 0 APIC 0 microcode ffffffff
>   [   81.314715] mce: [Hardware Error]: Run the above through 'mcelog --a=
scii'
>   [   81.314716] mce: [Hardware Error]: Machine check: Processor context =
corrupt
>   [   81.314717] Kernel panic - not syncing: Fatal machine check
>=20
> To correctly shutdown a root partition running on MSHV, sleep state
> information has be configured within mshv. Later HVCALL_ENTER_SLEEP_STATE

s/has be/has to be/    --or--   s/has be/must be/

Nit: Be consistent in capitalizing "MSHV" (or not capitalizing it).

> should be invoked as the last step in the shutdown sequence.
>=20
> The previous patch configures the sleep state information and this patch
> invokes HVCALL_ENTER_SLEEP_STATE to cleanly shutdown the root partition.
>=20
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c       |  2 ++
>  arch/x86/include/asm/mshyperv.h |  2 ++
>  drivers/hv/mshv_common.c        | 19 +++++++++++++++++++
>  3 files changed, 23 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 645b52dd732e..24824534ff8d 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -34,6 +34,7 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <linux/highmem.h>
>  #include <linux/export.h>
> +#include <asm/reboot.h>
>=20
>  void *hv_hypercall_pg;
>=20
> @@ -562,6 +563,7 @@ void __init hyperv_init(void)
>  		 * failures here.
>  		 */
>  		hv_sleep_notifiers_register();
> +		machine_ops.power_off =3D hv_machine_power_off;
>  	} else {
>  		hypercall_msr.guest_physical_address =3D vmalloc_to_pfn(hv_hypercall_p=
g);
>  		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index fbc1233175ce..9082d56103ce 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -182,9 +182,11 @@ void hv_apic_init(void);
>  void __init hv_init_spinlocks(void);
>  bool hv_vcpu_is_preempted(int vcpu);
>  void hv_sleep_notifiers_register(void);
> +void hv_machine_power_off(void);
>  #else
>  static inline void hv_apic_init(void) {}
>  static inline void hv_sleep_notifiers_register(void) {};
> +static inline void hv_machine_power_off(void) {};
>  #endif
>=20
>  struct irq_domain *hv_create_pci_msi_domain(void);
> diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
> index d1a1daa52b65..0588d293a92a 100644
> --- a/drivers/hv/mshv_common.c
> +++ b/drivers/hv/mshv_common.c
> @@ -217,4 +217,23 @@ void hv_sleep_notifiers_register(void)
>  		pr_err("%s: cannot register reboot notifier %d\n", __func__,
>  		       ret);
>  }
> +
> +/*
> + * Power off the machine by entering S5 sleep state via Hyper-V hypercal=
l.
> + * This call does not return if successful.
> + */
> +void hv_machine_power_off(void)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_enter_sleep_state *in;
> +
> +	local_irq_save(flags);
> +	in =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	in->sleep_state =3D HV_SLEEP_STATE_S5;
> +
> +	status =3D hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);

As flagged by the kernel test robot, this should be

	(void)hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);

so that the intent to ignore the return value is explicit. And the local
variable "status" can be removed.

> +	local_irq_restore(flags);
> +
> +}
>  #endif
> --
> 2.51.0


