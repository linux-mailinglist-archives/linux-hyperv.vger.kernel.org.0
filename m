Return-Path: <linux-hyperv+bounces-7428-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A98BDC3BDF0
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 15:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F56427440
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C56733DEDB;
	Thu,  6 Nov 2025 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lOAcX++n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012048.outbound.protection.outlook.com [52.103.10.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207718D65C;
	Thu,  6 Nov 2025 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440340; cv=fail; b=ocgD6fdIViRGcTZAZP1ddF2/YsQz+OTNVkOcE5xc7lD68RxlFxZUj3bepvH9j0GrpcuMAJ1rRIlb6k4Sd5ckZ2tNisrhfT2HwsCj7SMDf+SX/UtLxVCFFEhD4IsC5zh0RRoTb4kUrq3jWdb5qUwMHIEQwSFSwURrEhOZs5ac+YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440340; c=relaxed/simple;
	bh=mlxgmDaIQzwAXa5wDL4+NoVoyQdVzYldvwV9U6WE9vA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e7dPo3IIxX0JnV4TJd4X4s0yA+kBma06QM7AnjK618CesLo/6s2CiYCByZ8UoJNP/FNflo2TMku6pWZ/8ggSd6Gpf/fSlc4jX4wevzayRdneUCB7MY+XpHZOKeJW5oA+8jgIQW5jigW/h9s4UBgYDP4XbEE4wn72Xmg73WeSnuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lOAcX++n; arc=fail smtp.client-ip=52.103.10.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLmrv1nRrqyJPatwbKYXPRABj4qMpgATcAoR2SQJW4ufDg9yucFVUPT2E9VjcyxRjlJW5nn3N9Znqcr94cvV+FKMg5QMm9l2GKluICP3QAqEwQajVxMbMcJ/oAysdvnomJA8sFrtk5pu5cdlUvI7MqifEllnMwRetPKDYlFZ8fSJiTRs/HtZ8FC171bFO4IMb6/qkn+KGO+JmtYFYdU7rKUN55/SCub/FfaN2M7rpng40glOKmczJzfTHX00G89mOGdpdJz3GqEpafW88OjoAMXLUQQPkPtYiFVtm9HvqKmPXUmegqdHAueLK5mXZTbQqb03yIChxYW6cdYqzQZszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE0Y3ehPhcTLNO9LQBMbMx9ZnWn0Dkq9hq/LOO5SoaA=;
 b=ZE1HLQtSft3fppfZGBfdhMBab9icvtLEaS6tqNMfeDh12O6tT+8bhGI6uIdepBCRLZzck3n01j8zUfvxbPNtXzT0cNUhd903S+ZQNUu9xhcKnsHKtY9B8n6D7KdT07XvXjYtKgRuuxntvY3ZkZtCSyDTnKKUmkiR4q1bj5KwWoBqssj2xxVXYZw6By5AD8g6xw6on/FjHKVj51iVk53PngALhjLD3Bsr/aKwvGSG2ydMVX0HSDZT7cXStwBVx6+ijBGOyqTAlFNoYWQexpCYRDmgLwQoV5ckgV2pi4eOHYbxBAuo26DSQI9A7jXP22MLOBEQQaoifgqmYOVstowEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE0Y3ehPhcTLNO9LQBMbMx9ZnWn0Dkq9hq/LOO5SoaA=;
 b=lOAcX++nFCyWKyOgO8xFl4cSSdVG7EqX9qGaTqCkQvOvBD0xev4r/q1u5i+I0BzXAqunTBTxGHVMxYRQZAPpOt1LRA17KvtQTXQ3PumhsoMwc8OpPBqMQBMEiDcea+i/nNGbznn2WZEHHwqNtLtsBf7aB15l24xLjvSSZNV/wWWGJhcMZmkHrcJjKGKg3Ob4pjrGm/rfNvNGWPZr1pyAtaOddXAcUggVbXJQvnBop98YmB4tblc299SU5ogT1ywiUylvNS2sRvYWr8qQRGsR9jDtW/J3nUd5vBNnv1adSbcLZ7jH86m90Gs/Rc9Rda8DiL9MznSjXk1hERqmucYqCw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9689.namprd02.prod.outlook.com (2603:10b6:610:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 14:45:32 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 14:45:31 +0000
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
Subject: RE: [PATCH v10 1/2] Drivers: hv: Export some symbols for mshv_vtl
Thread-Topic: [PATCH v10 1/2] Drivers: hv: Export some symbols for mshv_vtl
Thread-Index: AQHcSJEpGFIkEtGY4UuN1kU1c5WHQrTlxkVA
Date: Thu, 6 Nov 2025 14:45:31 +0000
Message-ID:
 <SN6PR02MB41576606068AD742B6490BB1D4C2A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251029050139.46545-1-namjain@linux.microsoft.com>
 <20251029050139.46545-2-namjain@linux.microsoft.com>
In-Reply-To: <20251029050139.46545-2-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9689:EE_
x-ms-office365-filtering-correlation-id: fb5df86a-3015-49f7-0bda-08de1d4322ec
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|15080799012|461199028|19110799012|41001999006|8062599012|8060799015|13091999003|102099032|1602099012|40105399003|440099028|3412199025|4302099013|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ymHFNa/qciAQwUnTAi4GYKCLfZwmLRh3lRfIUnvmGusaTiVCRYu+HA2JtpIZ?=
 =?us-ascii?Q?2wfb8Jvt+5tYNh8sMYIuhnaVzwAJhXvFIg0DKv7n5OLSyLHSUYCnAILY1CYC?=
 =?us-ascii?Q?ivWLOjBZiUOB9TtErnzq5KtNNf07q2ikeZPgzHrcyxRk7U9jPuYErqjJmH6r?=
 =?us-ascii?Q?zYItNbRwkJoDTxkHww/TbbTjTT8K9zLeqxAgj0BKIiRJ9dcqbTa6ww1buaUZ?=
 =?us-ascii?Q?lI7vwXCOxfGvZSEvUwk9MI6moYBjwLPEC9iYGxjlMEdX99frAjOAE2vgwMqu?=
 =?us-ascii?Q?/USGdZSq8qXScRbQi9yzc+3oNZD2j1VKf1RMQlqyCes77T5J3RZZYrR58E1+?=
 =?us-ascii?Q?HQQzmFMK47zU85mCTN3RMnmmSOr63myZbBzNEmtUTWdo7EehjBNGI3xchZ02?=
 =?us-ascii?Q?LMbnsOZXwvSyMkefggVf9SYQC4k9T4ofoiPg4PbTJUAABeViPWcqiIHyYj5H?=
 =?us-ascii?Q?n22VDDkTBOl6oKrNTJRkgDKsDVg39H7n9l00QR/JvVtlz9qE63bEbQIqH2Tm?=
 =?us-ascii?Q?C3IguqERMS6EmjKxuv6emuVy40B50p4q2kUpGoACVuJbtzUiGZXTRtT8mHyR?=
 =?us-ascii?Q?WEyhUI6g/pj8q5bNktjLjaplXNRighr5Cseayb/L6I80CTzWy47RvhvrIRiI?=
 =?us-ascii?Q?mCou4ut6OsZnazKKWXPp/3S+jEjiuGQFBUvpKhcmEmOzE46Igm7lNzp+M1wB?=
 =?us-ascii?Q?9FD/Ooc4S3QTCrhY0zTneWM38F9YeI9sA4xmjHb0aJELBq3VFQn5F72WZBwT?=
 =?us-ascii?Q?wTvm76c7RTgtGlk2hvm7CD6wVICEzMrTRNpz6nwodCDv7299KrCW1y9IbENo?=
 =?us-ascii?Q?jN35e6MlVcMPvBrNMfpGtER/3KFL7O+IFROSgzZ+0uT8utPgB+fuoLaYDIOw?=
 =?us-ascii?Q?s6bI1v35Dn4MABgCB7LFLVPMybIrvoIqPL6/cecy7Nt2NLdLf3im29sBIxRa?=
 =?us-ascii?Q?oHQHtagRNU+KdiQ7ZUeyb27gNtPehDeI7Y965atnLJJRaIPIvNqlbvLW2dMe?=
 =?us-ascii?Q?LUCOn+WQbsFtFz/t9gCd3wSdDFVhOoi49H+JUvvE7oPt67iUwCQ4RPwLd6P7?=
 =?us-ascii?Q?Ae3gv1VibF2IezY4IJuZdBKFXm7OfFDI1A0P2YHBK8W3vcnNcyUhyWc0Szlr?=
 =?us-ascii?Q?WO3CGkRaDH0YYzx1osAGE2XZ6n+rTKlQG7Vu3auJfVJ1NAUIRs12gWMZs2Z+?=
 =?us-ascii?Q?ciXDPVIMUvJg6RjArmom64ivMfnFl8QBauLilGqlJqaEdvLS5D4rbW9AvmIv?=
 =?us-ascii?Q?75BEpgebYBAU0X1yDmIvqlEy/tbmlP/kyB3PPZxv0bhLXVrTBtQ/bhwpjfWe?=
 =?us-ascii?Q?1QsvGOUXoyQrPKAbRo2XT56fQQJPmFwJwmKounczXXVIRw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HylkIdOYwzrQ/8B1m3FcDBiyrTRZqu8IBe3eMJvnOyztDW0Qw1vaFgx+gvZF?=
 =?us-ascii?Q?y1BQ+BawvtuEXvFUPXc5PrnWrURobJz2OCpFfdJVzVxvMRMHm84IP4RenBTW?=
 =?us-ascii?Q?ZUE7UGx9mp9XBW/Klv1hTXAmchMpjmXWWZgJdlHOd90fP56Fa+zX8lBu1WFU?=
 =?us-ascii?Q?/VhjiJHroOdRnMsroiwHCmK5Q1Z8MCqxmyP7tGJAeIE/gSy4iLtwPihfigH/?=
 =?us-ascii?Q?uifW1HqJD+NeGEv73jD2zLmM33BoZhmydXEPRs1ddSzl7BnhljU699NBVI01?=
 =?us-ascii?Q?1h4bPPRlarbE3Oz2ZvOmcaOrIeKjP3HBmph1cYvlsgpVVz8fW3B6oPjtsECH?=
 =?us-ascii?Q?XLNISqne+XS10fTj/CykM3yy4X2rTxuZJ2ngQbWNq2gTayJ1VB83HFipoFbO?=
 =?us-ascii?Q?DH+WgCjZ0P0qLItkBwLO8C8nGAa/GQcuJCDMTwBCshOPybppQ/F18YGAXOgH?=
 =?us-ascii?Q?cATtGH8+8BKMj3K9N1YZtDfMahG3hVJO7ZMDK1rEsQkIdy+lSc9UJ7sH+/hJ?=
 =?us-ascii?Q?kt7C3gV6sG76rv2n1cUcPevOeNfXpQcxETDpafmDRMg/MKOVa6bEpJliew6P?=
 =?us-ascii?Q?swK1MAiKX33M5UQQLI/PCuR6xruzFfZLTYjCYyXPmIDbfM8ZS9Vg3LzhCan4?=
 =?us-ascii?Q?x9m1+3OQkCwLX6xtqkCz2+LbSv8EIG+BfggurvnoXnJ12UhdWl4FjmLVzaIU?=
 =?us-ascii?Q?0xdmka4Syo7F8k472iArQz0FZqO6+TijOxZ04VaQGwrCD3BG/ZQ/7Rp+yXrG?=
 =?us-ascii?Q?9oJRPVx2Nu+pxgE7tCYckG5R1cae04X7eZV/XkW+oHKY9UNt+AaQJRTY0ixl?=
 =?us-ascii?Q?NrdbcOHDrGEpScIR0B2bb/7T1gd5SJmBlc/Riu+wZhW8jtnj2K1EPlI/cxS0?=
 =?us-ascii?Q?ifpi7BY9Wu3i2V5QtQZhEvaXVKTM9wSOVuqI06XfIzqvLCXgFunhKDc6vxDm?=
 =?us-ascii?Q?C850Ogxt7PTl7QqJNNYANQpHj152X7ZEGI+KB2ZjSxTKFhn1IlIRRVMStHTj?=
 =?us-ascii?Q?lybgmEkJZL+wV8OmfI/L2SLgrpwUIRB6h4pvlu4fc4DAIHcK29+yNjsFwmfL?=
 =?us-ascii?Q?gxNFB7RpDgfTM2ra2SFg/ePK0j+3Z/1yD+I312lPizo+nQ4gYg6xMDMXR55I?=
 =?us-ascii?Q?6XdevPbvyJ0gcF2PJXT2M/d4owDaRzb9/VbbCQrevVA2eqCtCE5gXGgA7iIx?=
 =?us-ascii?Q?802FoBhqCsW0TpxKFLtOIGv8BKlmInbjlPZrbR0zjWdIWtszKWAjDikR/jo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5df86a-3015-49f7-0bda-08de1d4322ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 14:45:31.8606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9689

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, October 28, 2=
025 10:02 PM
>=20
> MSHV_VTL driver is going to be introduced, which is supposed to
> provide interface for Virtual Machine Monitors (VMMs) to control
> Virtual Trust Level (VTL). Export the symbols needed
> to make it work (vmbus_isr, hv_context and hv_post_message).
>=20
> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506110544.q0NDMQVc-lkp@i=
ntel.com/
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/hv.c           | 3 +++
>  drivers/hv/hyperv_vmbus.h | 1 +
>  drivers/hv/vmbus_drv.c    | 4 +++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 936c5f310df6..c924e3294b8b 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -18,6 +18,7 @@
>  #include <linux/clockchips.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/export.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include <linux/set_memory.h>
> @@ -25,6 +26,7 @@
>=20
>  /* The one and only */
>  struct hv_context hv_context;
> +EXPORT_SYMBOL_GPL(hv_context);
>=20
>  /*
>   * hv_init - Main initialization routine.
> @@ -104,6 +106,7 @@ int hv_post_message(union hv_connection_id connection=
_id,
>=20
>  	return hv_result(status);
>  }
> +EXPORT_SYMBOL_GPL(hv_post_message);
>=20
>  static int hv_alloc_page(void **page, bool decrypt, const char *note)
>  {
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index f7fc2630c054..b2862e0a317a 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -33,6 +33,7 @@
>   */
>  #define HV_UTIL_NEGO_TIMEOUT 55
>=20
> +void vmbus_isr(void);
>=20
>  /* Definitions for the monitored notification facility */
>  union hv_monitor_trigger_group {
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 0dc4692b411a..c9ad17ed562d 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -36,6 +36,7 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/pci.h>
> +#include <linux/export.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
> @@ -1349,7 +1350,7 @@ static void vmbus_message_sched(struct
> hv_per_cpu_context *hv_cpu, void *message
>  	}
>  }
>=20
> -static void vmbus_isr(void)
> +void vmbus_isr(void)
>  {
>  	struct hv_per_cpu_context *hv_cpu
>  		=3D this_cpu_ptr(hv_context.cpu_context);
> @@ -1362,6 +1363,7 @@ static void vmbus_isr(void)
>=20
>  	add_interrupt_randomness(vmbus_interrupt);
>  }
> +EXPORT_SYMBOL_GPL(vmbus_isr);
>=20
>  static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
>  {
> --
> 2.43.0


