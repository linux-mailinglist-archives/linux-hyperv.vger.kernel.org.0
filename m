Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0923033E9
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jan 2021 06:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbhAZFIk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jan 2021 00:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730771AbhAZBpG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Jan 2021 20:45:06 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20708.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::708])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BD9C061353;
        Mon, 25 Jan 2021 16:37:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRQDY/bxuziyW09y/06Q52brwJrYFb87/jGbbmTYUi5qd4Dp1B0ljvhewxteeb/PdYhzOSzNtH3fgpJaSgC6igtTFBU3P13wKQ1rVS1ncl69AUYVHUh6H5yvGC2bI1YQ4r+Yck1UC+XjIkDj6DIIswUcWI5Y9T01Vr5jm1aDDF5uM3zzCWKisTH9ktWoEOpFpU0Iw/RZyIwcE0Rms8UBvWjRkZq0MCGPmcXTlhZgSQHIYtB4HNLpcGDeOUfyh92YATGH6Cv4QIg6jBi60DEODga58q2xPkHw0PG3zdj5S1UwPAli+dDpPxN7rm0PzxdYU8/UGSOUnfDp9zihLDfs3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOVAqUgOQa3ji4pJdHOEu55JcTrFUWnbQhlL17Z3bZ4=;
 b=K0/32TqGKGCdo7oK5KtsMCdBsXx+XZvGNc69SmM0Q/H+yyA2S6feMV7EiIykMvX+h5mNN+7l8KeBDKqoWBc+DVu4DBGl955Hae1Bp7dvpYIyCVuQOKd0GqMiCwsWoxUkvB3Bx+brOJ4kLrp/n5KxauecfrYJfCoHAarL+eG4muhKTsWMru5qzOAqYSykz46hHQNjLugspLM/tgYA2RBN+xecbnx6IDilm+qH2iyOPoNUINn+GiYKvX2n2URtUnJm8ShWi8Kbj2F7mHapFlLwkDHMsJv+F0isXbJ86I3pRGf/IWpEFoijZ59AJ/NxIHstgoaUYYv5LCizu/VO1R+IAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOVAqUgOQa3ji4pJdHOEu55JcTrFUWnbQhlL17Z3bZ4=;
 b=WsWlkTeHtHKYO425chBpxntw4hFIpYtkyl4bWUEOdcDOuYxcmRqXT2xc67X+hpq1el+H9ZjthTyfS0HKGMeNPRnRG3Ni9wMuCHzpyWL+9hTveFfVb3BB57pvETQEer4ea1tTk2mlsNJYtAEa8e82IgE+NCeoz7qOI0s7fRBKJs0=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB0862.namprd21.prod.outlook.com (2603:10b6:300:77::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.1; Tue, 26 Jan 2021 00:31:31 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 00:31:31 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v5 02/16] x86/hyperv: detect if Linux is the root
 partition
Thread-Topic: [PATCH v5 02/16] x86/hyperv: detect if Linux is the root
 partition
Thread-Index: AQHW7yPvqzTQq44n9EKlBqAzieFq1qo5FUJA
Date:   Tue, 26 Jan 2021 00:31:31 +0000
Message-ID: <MWHPR21MB159358B1D6151AC5B5D38C7FD7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-3-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-3-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T00:31:29Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=578ca824-e84b-4ffb-abb5-5b2ddd2cbd43;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b2ecc36-7574-49ba-e7c6-08d8c191ba72
x-ms-traffictypediagnostic: MWHPR21MB0862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB08622467D62F271DDB1F8C09D7BC9@MWHPR21MB0862.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMMOaBK9DJQ4oBmTkD5X3td/SmjIEE+qq1ZmEWfHUXAedGyUrRIZsziMmHN7tGarm2qY/Kxn4zoOdlBCc4FLME25C9/izHkS7l+BrO91ILu8LrDj1D/173mK8P/2MgZGZ90/1QDditroHyjrhuJf1JdMTNpAWtAX1uSb7sx3lNwy07TSLp8ohizX/IWlJxNUTMfC2+wgO6RsJ0LibRZWtQxyhHNSSUEUMcgCpSVKzmHZT9JQNXbuFnoMNbeanw6I25t99whMsMb6WFfLonZ8Pm9ZjI86Ba0I0+hijkurzSMQO/RMiZti19XeZ+1cH2Tw4E5AwneVZKhPQcUXFzn0ZrFZLBscaVuSUKDxcSlb6aze5U+/TanCkHR+ImMYWgZeT3Dcai4wqnDWmAtaf1TQ/9ylpM9Rhaxo3Tq5St11YRzxjsy5Mmrqvn8t/jIiEkGOoPibrNpyTheGZ2ii+XkiBde3p77XrePq2kJMkeaZxISWuD1pNFI4h5fG+DHOZwRG1sdJwV+5A44twjQahbQS4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(83380400001)(7696005)(66556008)(76116006)(8936002)(9686003)(8676002)(66946007)(86362001)(66446008)(64756008)(82960400001)(82950400001)(66476007)(55016002)(8990500004)(10290500003)(33656002)(71200400001)(5660300002)(316002)(478600001)(4326008)(7416002)(26005)(6506007)(52536014)(2906002)(186003)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iIl9XN4ovmqBeGYLfkxpjxqcmnJcTVhenZYn+OZMhQlv43thscOch2HLFO8q?=
 =?us-ascii?Q?PPAfbtteceryrWgJ+fa3HFGFoisrYF4wTST/UyHEYN5B9qBPkHOxGv/Qrztp?=
 =?us-ascii?Q?wvAOkLSBHfq1zSbjkwdswf5j50gBvAsWafVY9INgdzY9i3Am4zI6cVisezY0?=
 =?us-ascii?Q?og/VdMkKnlf4/rj5/PZ1YpHNIF7z6pPqRvM058PMnH8eaE31JR96BysfxkwV?=
 =?us-ascii?Q?PQ6qN0SxsllRQMX+qGfuLHc32TTMHDqb1pRQCx3GJy7/wGWgKb8v+5KrnNpI?=
 =?us-ascii?Q?aqiqBuJGHhi7F8DDlOqiDLZYxNoZ4/dA6jIr0cpZfx7Pr63Iwgp4k46S3cG6?=
 =?us-ascii?Q?Rz1YKcNfPttt8qOi5ChojWWd4iN8wLkiO/J2m04Rzwb6/bvNu8oyf4eFMweS?=
 =?us-ascii?Q?YiqvUJgtJvxjMv3HSHxcmRN53Ac1uKXTR7jTGwlUJj9oQwbNZcsjnRFxfoWC?=
 =?us-ascii?Q?PGy9LWtbhzJjS0N5A7ED7n/6jhVXRTosrrP203bhfE6cMfzgjyEErpYGtgqA?=
 =?us-ascii?Q?Kfly+PMnD5PALlUHboqm1lq5YgaoS2wi/CyqoX40UWEeMcEaAMi1Y87IZ5tH?=
 =?us-ascii?Q?jBMaNofPfYd0vsx7ty8Dd2VpmH1goMeQ0QYFrNKyoY8yM/G0pFyioyHsLt1U?=
 =?us-ascii?Q?hn6+8HpStuoZyWQPhPMwiKQMnNlZgjSO20aMZsAtEtnLaldH7tIRRb0OruyJ?=
 =?us-ascii?Q?fS+Ja1b9gW1t6+qptzUiyptHJd1gdAS0M4NspiFdTX8aSgAWRytmcD+37EY+?=
 =?us-ascii?Q?cHKswDBdLEPYcG+ePGZeaPzBxiMSA/lzRbvVApvB1mC/iepz3Z9S5rvYHgb+?=
 =?us-ascii?Q?3fo77APiz91YLQGD85VGdEw5+cEqXAfxFOyz+2qbDnP85kAGtlgzMNFwEz1V?=
 =?us-ascii?Q?wXF5kCSC3MYAE6BXot19DB6V5avPbNsf7xV54AylqQmqkDpBrep/6K1b/rCO?=
 =?us-ascii?Q?n774YIHvkCELus/HL9hI2xwZ54zO9OMQ4u6/bxHS1uU4qPpiAZEmt7waGO/T?=
 =?us-ascii?Q?Y0OIa514XbGzrbSm3KFXMfAaxUEZNkKXlOXBYpDPGlnaDun5pg83B1A1b9hZ?=
 =?us-ascii?Q?gbHdzGRz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2ecc36-7574-49ba-e7c6-08d8c191ba72
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 00:31:31.4087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zNLjjCqNIb2XEQThag1zfAMjiNxqAHCiYFhrolUuEPVtCtAC77xYKkzoGv/t7G1JIG8ZspIOQqtnKHUNHh/wqlV1DO+0SqUDhiP1Q8NbBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0862
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 A=
M
>=20
> For now we can use the privilege flag to check. Stash the value to be
> used later.
>=20
> Put in a bunch of defines for future use when we want to have more
> fine-grained detection.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v3: move hv_root_partition to mshyperv.c
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 10 ++++++++++
>  arch/x86/include/asm/mshyperv.h    |  2 ++
>  arch/x86/kernel/cpu/mshyperv.c     | 20 ++++++++++++++++++++
>  3 files changed, 32 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 6bf42aed387e..204010350604 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -21,6 +21,7 @@
>  #define HYPERV_CPUID_FEATURES			0x40000003
>  #define HYPERV_CPUID_ENLIGHTMENT_INFO		0x40000004
>  #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
> +#define HYPERV_CPUID_CPU_MANAGEMENT_FEATURES	0x40000007
>  #define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
>=20
>  #define HYPERV_CPUID_VIRT_STACK_INTERFACE	0x40000081
> @@ -110,6 +111,15 @@
>  /* Recommend using enlightened VMCS */
>  #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED		BIT(14)
>=20
> +/*
> + * CPU management features identification.
> + * These are HYPERV_CPUID_CPU_MANAGEMENT_FEATURES.EAX bits.
> + */
> +#define HV_X64_START_LOGICAL_PROCESSOR			BIT(0)
> +#define HV_X64_CREATE_ROOT_VIRTUAL_PROCESSOR		BIT(1)
> +#define HV_X64_PERFORMANCE_COUNTER_SYNC			BIT(2)
> +#define HV_X64_RESERVED_IDENTITY_BIT			BIT(31)
> +

I wonder if these bit definitions should go in the asm-generic part of
hyperv-tlfs.h instead of the X64 specific part.  They look very architectur=
e
neutral (in which case the X64 should be dropped from the name
as well).  Of course, they can be moved later when/if we get to that point
and have a firmer understanding of what is and isn't arch neutral.

>  /*
>   * Virtual processor will never share a physical core with another virtu=
al
>   * processor, except for virtual processors that are reported as sibling=
 SMT
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index ffc289992d1b..ac2b0d110f03 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -237,6 +237,8 @@ int hyperv_fill_flush_guest_mapping_list(
>  		struct hv_guest_mapping_flush_list *flush,
>  		u64 start_gfn, u64 end_gfn);
>=20
> +extern bool hv_root_partition;
> +
>  #ifdef CONFIG_X86_64
>  void hv_apic_init(void);
>  void __init hv_init_spinlocks(void);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index f628e3dc150f..c376d191a260 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -32,6 +32,10 @@
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
>=20
> +/* Is Linux running as the root partition? */
> +bool hv_root_partition;
> +EXPORT_SYMBOL_GPL(hv_root_partition);
> +
>  struct ms_hyperv_info ms_hyperv;
>  EXPORT_SYMBOL_GPL(ms_hyperv);
>=20
> @@ -237,6 +241,22 @@ static void __init ms_hyperv_init_platform(void)
>  	pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
>  		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
>=20
> +	/*
> +	 * Check CPU management privilege.
> +	 *
> +	 * To mirror what Windows does we should extract CPU management
> +	 * features and use the ReservedIdentityBit to detect if Linux is the
> +	 * root partition. But that requires negotiating CPU management
> +	 * interface (a process to be finalized).
> +	 *
> +	 * For now, use the privilege flag as the indicator for running as
> +	 * root.
> +	 */
> +	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_CPU_MANAGEMENT) {

Should the EBX value be captured in the ms_hyperv structure with the
other similar values, and then used from there?

Michael

> +		hv_root_partition =3D true;
> +		pr_info("Hyper-V: running as root partition\n");
> +	}
> +
>  	/*
>  	 * Extract host information.
>  	 */
> --
> 2.20.1


