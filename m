Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9506B50F0
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Mar 2023 20:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCJTaR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Mar 2023 14:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjCJTaL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Mar 2023 14:30:11 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021021.outbound.protection.outlook.com [52.101.62.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A5ED1AF3;
        Fri, 10 Mar 2023 11:30:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhR8EGcKv+w2nuiYwnFH7YE9LVpXsAcABvpOaqyPIZE2JZg+/NorWAwhXU01+81022YO4YoAqO7QN4/aGVfjudiU+uv6luF7tp3WumvJp9FTgxROjbQ7ha1l5ffOXEudOWdDUHNU5oY6rgJupWIIOKakEu0vH9AYprBbKzjBiaO270AJXJcIcI6111pkzyjnUPe76fqZj1ioUIlvX+iKE2UW+6bu/9BZPW8muoq+4ZtDCIVIgwlJS4qwDK5t4TJHfmZZL8EFR7YPRxPXW+uk1EipUSzBnh7YFmGW2efdRSsO9cOo1wn3HTnSF6DR9Wt9WNX1wHTURn0Qkkkd4iSS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxLiSXOsqC049bWkc6jMKABCfBTcsupk2JWZ44g+3/0=;
 b=GWBTMQvEMLQraiAbO1KNb27s4ZfxPmUn9STCEOWnKaPUBpXV2rm5gFDD3XQk+JHbsNwRozw/tMi9bS/mrG4VtB+BhcPQ0cRiSzClpJLKfMm55eFvJ8VriMi2ZyIMi3xzdwsv1adt/TXM9Waosbmc/CJeeAcXOGAvV8Tmte2tEcQQbIuXX3oV5u9IkChF5KWpEkF2jMHag/lKwUKS83jkOAuVLevERc4M/iL+l9J6oPjj2wceWVxvBsMKoeh0t3uNN3dnRYt3gY/WrUPNe/T7HN9ce8wG8MKqEok97sMuQZruvdJ5TRTaTDwl3fCbxEWHCf8FpR1UU9z+mHh9gAR5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxLiSXOsqC049bWkc6jMKABCfBTcsupk2JWZ44g+3/0=;
 b=Zs8Ze4eYLjgnF1C0XQFAEYbUOTjcMLZ2bFOV4RUS0nltQ0V90wb5wNhg6Fa/vpP8uawnL5SiRwpiiiqXKOYJuEOTl+nv3IW6I4IMBzICFOjMIT5uxntt23661qaaGEC+xhkY333vAOyTeb/AqdNxKWWpQo3OYAMC78PiHZzBh+U=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SN7PR21MB3827.namprd21.prod.outlook.com (2603:10b6:806:29a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 19:30:02 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%4]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 19:30:02 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [RFC PATCH] hyperv-tlfs: Change shared HV_REGISTER_* defines to
 HV_SYNTHETIC_REG_*
Thread-Topic: [RFC PATCH] hyperv-tlfs: Change shared HV_REGISTER_* defines to
 HV_SYNTHETIC_REG_*
Thread-Index: AQHZUTma1YX9/OQzMkiQz3mMWYqOma70Wb1Q
Date:   Fri, 10 Mar 2023 19:30:02 +0000
Message-ID: <BYAPR21MB16889A9D76888A485D7BB19FD7BA9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1678223570-25242-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1678223570-25242-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=66a639fa-d367-4be7-9df9-959c38271df4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-10T18:28:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SN7PR21MB3827:EE_
x-ms-office365-filtering-correlation-id: 546a8d8b-2609-473d-ea22-08db219dd813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wXTgwxcR40sLtSCXOLsDsnpm3hVW8Vme00VWwnn/bulQBKwk6w1ocuqQt83E3/TnAx81qUfOeJj2Yhimweedcy7qSmAPGtViQNCCIUMZr5Im0upraGZUQWQiN5D2w8dKIFRXyqQgzyGb5Qsig35rlKu9H9LMXLpi+x6YzxAECBzIqym0XIQ0BzNCSGnUDR3Vz7XO9SAvqWbVlhl9hD/5S184sJtMqjzHHa11rS6D4AZf978ZQU+GlLRYqA5zCAqYHQLsKN71MawissugWzXzZTfLi4wz6TdCbP3k4d5n8mimb4P/ScXZA6ihdV18qtvjL0OPRSwZuqDz4qwZI48Ss6prK5boE2ueVJkjhVBLPgX+ph4mvvRJt14698L1yH7RkrDTyyvyH1WyQN670HQ7aOKh15F+G0Fi/lDbOu+Zr9CCI/c8PGPVMz/E9acz+KVvov6IkLJO5/yM2P6JxfH20ydlQvW6gzecZTnaMRh8v98P6E+hwdoWq9KLCSNtOpHomxD8pAP9PWUC+KSH2Ow/FVV6aJEd3IDEnyANVBqBIaHH2RgQHhzhgo1LpeotHTnm/J8oG3zGGw7z+SXWy1ctkks5pEhCTVveNpxOJqSl/qVnOWQG8QbnDg6gDLgnlNGdoL+XR7J8sXFs+c83nGI6+IIALyjOJrcQzapySN2kzwP8k471T6Fyl3ONOOvaAAeODkxZcqtOSE8CpXNdSrV/y5FvHtXJOq80o4N0CZEYviotdDmLMhtclfr0psszKur6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199018)(52536014)(8936002)(30864003)(41300700001)(5660300002)(83380400001)(82960400001)(38100700002)(82950400001)(26005)(9686003)(6506007)(2906002)(122000001)(186003)(66476007)(64756008)(66556008)(66946007)(8676002)(478600001)(10290500003)(66446008)(76116006)(4326008)(55016003)(110136005)(54906003)(316002)(86362001)(8990500004)(7696005)(71200400001)(33656002)(38070700005)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N+v4b93QUznc0Eddk+n2CD2nYfdb8wTwk8l8h5aQ7x7TUC5GuF/fzrB2BP96?=
 =?us-ascii?Q?iqgSjRDm3z3YxL60/1n9mPbdjPt8fYIfUInWknczt/Y1cUqh/X88iJf1graz?=
 =?us-ascii?Q?iFfACdBaIfkGVlrZHO1D+prOyW4HpC6Fj7Tt3P4oiQcPPd39mlu69BoAAaBx?=
 =?us-ascii?Q?9p9o46lKcjgcXvMA9+hPnwAeRJM/uCPg/lLnaCF0LN9rOC4dJXfcVBbOdsZv?=
 =?us-ascii?Q?6xi/HKC23BaPXFno4IeruBlvRNnaIIqsnfDhblq6v5D6YX6msY/H4806Njrp?=
 =?us-ascii?Q?OxycCJtuO4W2ZW+IyJtXYDFU1C6ak31naP+id5hrXzUz0HAkSIPzdQdJV280?=
 =?us-ascii?Q?9wO87OSmvUugyEPWckG464gs/FR1a9mjbAgoxO8gffbnLzUtDS8wleMeOeaY?=
 =?us-ascii?Q?Lo47cf705lg1Rc0srZtk2k5IJcDbQbx+Co/2x/SVmaPOcLgsfnWvGRZutKq7?=
 =?us-ascii?Q?S8OlncvjzF3i7l3VeyKPBeU6UVX5GDmrr0b66LpCD6qF6+nx2JHdt+OZQmeM?=
 =?us-ascii?Q?EEthDUGtcFYV2mP5qwotLyQmdWeY/He32uBCQSlihtHQ/PopCFtzLFATe/MT?=
 =?us-ascii?Q?cgcmo6Vjsc4eLcPOZ1Cn/BSfn3JhwNz0WrubyH1xu0LfxeMrkN235pBvp1AB?=
 =?us-ascii?Q?ocWgxRO5Sr5By+yWV4uc0lXQH7SuxYWpM7kLGo5rq7T1PwozAVfxKhCu+/P7?=
 =?us-ascii?Q?dSlk8cReQy7U/pNsjaOQcY2hjiL1IAHjK9hVr5YuZuO2qqO/oZgzxin/GzRa?=
 =?us-ascii?Q?UIMg9hi00yEP2hZ7grRstxA4bda1WR47tyG7yF/sSHXvqSJV0EMhNPbbSDhN?=
 =?us-ascii?Q?Uv7Gl91LDMZCQcWCBTewipOwR4CN7PS1cbBccd2v7VqjdCtEhXrZ10ZTcp2e?=
 =?us-ascii?Q?zskl9sI7qFUr5+pUkyMsvNnuB+qpRqYqMxDwQFUPBsHCs9oQ3Hbj7+/be5Gr?=
 =?us-ascii?Q?7ktBeI6fLxAIJGYj5EK1HOaxTtTj0BybcBiu7PRxN8LtqOsrlPH2QrdoFMDI?=
 =?us-ascii?Q?grbg/GL2JOg5r4a14wzErjOXFBuFG4iaeuVXb3fhpaQfiBp7ehgHcHcENYVa?=
 =?us-ascii?Q?4lGS5DXY5m0y0uuPsWRSrcTNAcc0UPMSzi5Oo5eXvE/6IK7NZbt8C1w8qTVh?=
 =?us-ascii?Q?W7L2gwGer7zivLqRDAjMClOUNSevv0PMNDAa5tUbZZglQ6+BAEQpQcDL6H7n?=
 =?us-ascii?Q?Xfrk7Q7WpFf61fYGNbll37Zq7MYseDJZfAiqomdiQYXfVZbeDB5GHVJqiA39?=
 =?us-ascii?Q?9cvdgLHbRjo34tRAThBgAYL6RjkMHGWvginArTvhSGfgcHMX/K9k+bOpQaah?=
 =?us-ascii?Q?OEqMK+vXsyGMeKTIuTtjCUIwGtTan6el9sFTVEhfDLuiUZPPHl7GXHHQrbk3?=
 =?us-ascii?Q?hv4e3Vy3X+SM9iiM2/I56Ub8/tivjdhFYsCPVBGdHNcAaaF+zbQxurCaKJny?=
 =?us-ascii?Q?FML/e7XWgbzyzfsHQrYp4xj7f7XjIG51xhuvaYuYXqzs2ScFZQ8Yqk/mR6ga?=
 =?us-ascii?Q?IDOXHBl2Ks6Ad7tceg3xkCiO05SRIJmbDq6xBhBZ6UO93b8e/G3CDe7WSwDL?=
 =?us-ascii?Q?H8qXOlPzvnQLxhunag1h8uGbTzsscN2fg786VxxO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546a8d8b-2609-473d-ea22-08db219dd813
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 19:30:02.1198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzK68SmQg99ZdsHjQAGO9Y/ZRZvlXIjKeOMDXkzjVax4ZKwrZdNq++G8qqD7TBKNlCMmshrdJqhqZJDRLgtgizMVKw5lDKN1RsUWpuCIxQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, Marc=
h 7, 2023 1:13 PM
>=20
> In x86 hyperv-tlfs, HV_REGISTER_ prefix is used to indicate MSRs
> accessed via rdmsrl/wrmsrl. But in ARM64, HV_REGISTER_ instead indicates
> VP registers accessed via get/set vp registers hypercall.
>=20
> This is due to HV_REGISTER_* names being used by hv_set/get_register,
> with the arch-specific version delegating to the appropriate mechanism.
>=20
> The problem is, using prefix HV_REGISTER_ for MSRs will conflict with
> VP registers when they are introduced for x86 in future.
>=20
> This patch solves the issue by:
>=20
> 1. Defining all the x86 MSRs with a consistent prefix: HV_X64_MSR_.
>    This is so HV_REGISTER_ can be reserved for VP registers.
>=20
> 2. Change the non-arch-specific alias used by hv_set/get_register to
>    HV_SYNTHETIC_REG.

I definitely messed this up when I first did the ARM64 support a
few years back.  :-(    This is a necessary fix.

What about keeping HV_REGISTER_ as the prefix for the architecture
independent alias, and creating a new prefix for the Hyper-V register
definition?  This would allow the existing hv_get/set_register()
invocations to remain unchanged, and eliminates the code churn
in the arch independent code.

The HV_X64_MSR_ prefix is definitely good for the MSR addresses,
especially since a lot of definitions that are x86/x64 only are still in us=
e.
Then perhaps use HV_HYP_REG_ or something similar for the Hyper-V
register definition.

If you don't like that suggestion, I wonder if the HV_SYNTHETIC_REG_
prefix could be shortened to help avoid line length problems.  Maybe
HV_SYNREG_ or HV_SYN_REG_ ?

>=20
> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> ---
>  arch/arm64/include/asm/hyperv-tlfs.h |  25 +++++
>  arch/x86/include/asm/hyperv-tlfs.h   | 137 +++++++++++++--------------
>  arch/x86/include/asm/mshyperv.h      |   8 +-
>  arch/x86/kernel/cpu/mshyperv.c       |  22 ++---
>  drivers/clocksource/hyperv_timer.c   |  24 ++---
>  drivers/hv/hv.c                      |  32 +++----
>  drivers/hv/hv_common.c               |   4 +-
>  drivers/hv/vmbus_drv.c               |  14 +--
>  include/asm-generic/mshyperv.h       |   2 +-
>  9 files changed, 146 insertions(+), 122 deletions(-)
>=20
> diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/as=
m/hyperv-
> tlfs.h
> index bc6c7ac934a1..474025eb3d7e 100644
> --- a/arch/arm64/include/asm/hyperv-tlfs.h
> +++ b/arch/arm64/include/asm/hyperv-tlfs.h
> @@ -64,6 +64,31 @@
>  #define HV_REGISTER_STIMER0_CONFIG	0x000B0000
>  #define HV_REGISTER_STIMER0_COUNT	0x000B0001
>=20
> +/*
> + * To support non-arch-specific code calling hv_set/get_register:
> + * - On x86, HV_SYNTHETIC_REG_ indicates an MSR accessed via rdmsrl/wrms=
rl
> + * - On ARM, HV_SYNTHETIC_REG_ indicates a VP register accessed via hype=
rcall

Nit:  Let's use the full "ARM64" instead of just "ARM" here so that there's=
 no
confusion about whether 32-bit ARM is supported.

> + */
> +#define HV_SYNTHETIC_REG_VP_INDEX		(HV_REGISTER_VP_INDEX)
> +#define HV_SYNTHETIC_REG_TIME_REF_COUNT
> 	(HV_REGISTER_TIME_REF_COUNT)
> +#define HV_SYNTHETIC_REG_REFERENCE_TSC
> 	(HV_REGISTER_REFERENCE_TSC)
> +
> +#define HV_SYNTHETIC_REG_STIMER0_CONFIG
> 	(HV_REGISTER_STIMER0_CONFIG)
> +#define HV_SYNTHETIC_REG_STIMER0_COUNT
> 	(HV_REGISTER_STIMER0_COUNT)
> +
> +#define HV_SYNTHETIC_REG_SCONTROL		(HV_REGISTER_SCONTROL)
> +#define HV_SYNTHETIC_REG_SIEFP			(HV_REGISTER_SIEFP)
> +#define HV_SYNTHETIC_REG_SIMP			(HV_REGISTER_SIMP)
> +#define HV_SYNTHETIC_REG_EOM			(HV_REGISTER_EOM)
> +#define HV_SYNTHETIC_REG_SINT0			(HV_REGISTER_SINT0)
> +
> +#define HV_SYNTHETIC_REG_CRASH_P0		(HV_REGISTER_CRASH_P0)
> +#define HV_SYNTHETIC_REG_CRASH_P1		(HV_REGISTER_CRASH_P1)
> +#define HV_SYNTHETIC_REG_CRASH_P2		(HV_REGISTER_CRASH_P2)
> +#define HV_SYNTHETIC_REG_CRASH_P3		(HV_REGISTER_CRASH_P3)
> +#define HV_SYNTHETIC_REG_CRASH_P4		(HV_REGISTER_CRASH_P4)
> +#define HV_SYNTHETIC_REG_CRASH_CTL		(HV_REGISTER_CRASH_CTL)
> +
>  union hv_msi_entry {
>  	u64 as_uint64[2];
>  	struct {
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 566ac26239ba..0dbb0218d0fa 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -178,7 +178,7 @@ enum hv_isolation_type {
>  #define HV_X64_MSR_HYPERCALL			0x40000001
>=20
>  /* MSR used to provide vcpu index */
> -#define HV_REGISTER_VP_INDEX			0x40000002
> +#define HV_X64_MSR_VP_INDEX			0x40000002
>=20
>  /* MSR used to reset the guest OS. */
>  #define HV_X64_MSR_RESET			0x40000003
> @@ -187,10 +187,10 @@ enum hv_isolation_type {
>  #define HV_X64_MSR_VP_RUNTIME			0x40000010
>=20
>  /* MSR used to read the per-partition time reference counter */
> -#define HV_REGISTER_TIME_REF_COUNT		0x40000020
> +#define HV_X64_MSR_TIME_REF_COUNT		0x40000020
>=20
>  /* A partition's reference time stamp counter (TSC) page */
> -#define HV_REGISTER_REFERENCE_TSC		0x40000021
> +#define HV_X64_MSR_REFERENCE_TSC		0x40000021
>=20
>  /* MSR used to retrieve the TSC frequency */
>  #define HV_X64_MSR_TSC_FREQUENCY		0x40000022
> @@ -205,61 +205,61 @@ enum hv_isolation_type {
>  #define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
>=20
>  /* Define synthetic interrupt controller model specific registers. */
> -#define HV_REGISTER_SCONTROL			0x40000080
> -#define HV_REGISTER_SVERSION			0x40000081
> -#define HV_REGISTER_SIEFP			0x40000082
> -#define HV_REGISTER_SIMP			0x40000083
> -#define HV_REGISTER_EOM				0x40000084
> -#define HV_REGISTER_SINT0			0x40000090
> -#define HV_REGISTER_SINT1			0x40000091
> -#define HV_REGISTER_SINT2			0x40000092
> -#define HV_REGISTER_SINT3			0x40000093
> -#define HV_REGISTER_SINT4			0x40000094
> -#define HV_REGISTER_SINT5			0x40000095
> -#define HV_REGISTER_SINT6			0x40000096
> -#define HV_REGISTER_SINT7			0x40000097
> -#define HV_REGISTER_SINT8			0x40000098
> -#define HV_REGISTER_SINT9			0x40000099
> -#define HV_REGISTER_SINT10			0x4000009A
> -#define HV_REGISTER_SINT11			0x4000009B
> -#define HV_REGISTER_SINT12			0x4000009C
> -#define HV_REGISTER_SINT13			0x4000009D
> -#define HV_REGISTER_SINT14			0x4000009E
> -#define HV_REGISTER_SINT15			0x4000009F
> +#define HV_X64_MSR_SCONTROL			0x40000080
> +#define HV_X64_MSR_SVERSION			0x40000081
> +#define HV_X64_MSR_SIEFP			0x40000082
> +#define HV_X64_MSR_SIMP				0x40000083
> +#define HV_X64_MSR_EOM				0x40000084
> +#define HV_X64_MSR_SINT0			0x40000090
> +#define HV_X64_MSR_SINT1			0x40000091
> +#define HV_X64_MSR_SINT2			0x40000092
> +#define HV_X64_MSR_SINT3			0x40000093
> +#define HV_X64_MSR_SINT4			0x40000094
> +#define HV_X64_MSR_SINT5			0x40000095
> +#define HV_X64_MSR_SINT6			0x40000096
> +#define HV_X64_MSR_SINT7			0x40000097
> +#define HV_X64_MSR_SINT8			0x40000098
> +#define HV_X64_MSR_SINT9			0x40000099
> +#define HV_X64_MSR_SINT10			0x4000009A
> +#define HV_X64_MSR_SINT11			0x4000009B
> +#define HV_X64_MSR_SINT12			0x4000009C
> +#define HV_X64_MSR_SINT13			0x4000009D
> +#define HV_X64_MSR_SINT14			0x4000009E
> +#define HV_X64_MSR_SINT15			0x4000009F
>=20
>  /*
>   * Define synthetic interrupt controller model specific registers for
>   * nested hypervisor.
>   */
> -#define HV_REGISTER_NESTED_SCONTROL            0x40001080
> -#define HV_REGISTER_NESTED_SVERSION            0x40001081
> -#define HV_REGISTER_NESTED_SIEFP               0x40001082
> -#define HV_REGISTER_NESTED_SIMP                0x40001083
> -#define HV_REGISTER_NESTED_EOM                 0x40001084
> -#define HV_REGISTER_NESTED_SINT0               0x40001090
> +#define HV_X64_MSR_NESTED_SCONTROL		0x40001080
> +#define HV_X64_MSR_NESTED_SVERSION		0x40001081
> +#define HV_X64_MSR_NESTED_SIEFP			0x40001082
> +#define HV_X64_MSR_NESTED_SIMP			0x40001083
> +#define HV_X64_MSR_NESTED_EOM			0x40001084
> +#define HV_X64_MSR_NESTED_SINT0			0x40001090
>=20
>  /*
>   * Synthetic Timer MSRs. Four timers per vcpu.
>   */
> -#define HV_REGISTER_STIMER0_CONFIG		0x400000B0
> -#define HV_REGISTER_STIMER0_COUNT		0x400000B1
> -#define HV_REGISTER_STIMER1_CONFIG		0x400000B2
> -#define HV_REGISTER_STIMER1_COUNT		0x400000B3
> -#define HV_REGISTER_STIMER2_CONFIG		0x400000B4
> -#define HV_REGISTER_STIMER2_COUNT		0x400000B5
> -#define HV_REGISTER_STIMER3_CONFIG		0x400000B6
> -#define HV_REGISTER_STIMER3_COUNT		0x400000B7
> +#define HV_X64_MSR_STIMER0_CONFIG		0x400000B0
> +#define HV_X64_MSR_STIMER0_COUNT		0x400000B1
> +#define HV_X64_MSR_STIMER1_CONFIG		0x400000B2
> +#define HV_X64_MSR_STIMER1_COUNT		0x400000B3
> +#define HV_X64_MSR_STIMER2_CONFIG		0x400000B4
> +#define HV_X64_MSR_STIMER2_COUNT		0x400000B5
> +#define HV_X64_MSR_STIMER3_CONFIG		0x400000B6
> +#define HV_X64_MSR_STIMER3_COUNT		0x400000B7
>=20
>  /* Hyper-V guest idle MSR */
>  #define HV_X64_MSR_GUEST_IDLE			0x400000F0
>=20
>  /* Hyper-V guest crash notification MSR's */
> -#define HV_REGISTER_CRASH_P0			0x40000100
> -#define HV_REGISTER_CRASH_P1			0x40000101
> -#define HV_REGISTER_CRASH_P2			0x40000102
> -#define HV_REGISTER_CRASH_P3			0x40000103
> -#define HV_REGISTER_CRASH_P4			0x40000104
> -#define HV_REGISTER_CRASH_CTL			0x40000105
> +#define HV_X64_MSR_CRASH_P0			0x40000100
> +#define HV_X64_MSR_CRASH_P1			0x40000101
> +#define HV_X64_MSR_CRASH_P2			0x40000102
> +#define HV_X64_MSR_CRASH_P3			0x40000103
> +#define HV_X64_MSR_CRASH_P4			0x40000104
> +#define HV_X64_MSR_CRASH_CTL			0x40000105
>=20
>  /* TSC emulation after migration */
>  #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
> @@ -269,31 +269,30 @@ enum hv_isolation_type {
>  /* TSC invariant control */
>  #define HV_X64_MSR_TSC_INVARIANT_CONTROL	0x40000118
>=20
> -/* Register name aliases for temporary compatibility */
> -#define HV_X64_MSR_STIMER0_COUNT	HV_REGISTER_STIMER0_COUNT
> -#define HV_X64_MSR_STIMER0_CONFIG	HV_REGISTER_STIMER0_CONFIG
> -#define HV_X64_MSR_STIMER1_COUNT	HV_REGISTER_STIMER1_COUNT
> -#define HV_X64_MSR_STIMER1_CONFIG	HV_REGISTER_STIMER1_CONFIG
> -#define HV_X64_MSR_STIMER2_COUNT	HV_REGISTER_STIMER2_COUNT
> -#define HV_X64_MSR_STIMER2_CONFIG	HV_REGISTER_STIMER2_CONFIG
> -#define HV_X64_MSR_STIMER3_COUNT	HV_REGISTER_STIMER3_COUNT
> -#define HV_X64_MSR_STIMER3_CONFIG	HV_REGISTER_STIMER3_CONFIG
> -#define HV_X64_MSR_SCONTROL		HV_REGISTER_SCONTROL
> -#define HV_X64_MSR_SVERSION		HV_REGISTER_SVERSION
> -#define HV_X64_MSR_SIMP			HV_REGISTER_SIMP
> -#define HV_X64_MSR_SIEFP		HV_REGISTER_SIEFP
> -#define HV_X64_MSR_VP_INDEX		HV_REGISTER_VP_INDEX
> -#define HV_X64_MSR_EOM			HV_REGISTER_EOM
> -#define HV_X64_MSR_SINT0		HV_REGISTER_SINT0
> -#define HV_X64_MSR_SINT15		HV_REGISTER_SINT15
> -#define HV_X64_MSR_CRASH_P0		HV_REGISTER_CRASH_P0
> -#define HV_X64_MSR_CRASH_P1		HV_REGISTER_CRASH_P1
> -#define HV_X64_MSR_CRASH_P2		HV_REGISTER_CRASH_P2
> -#define HV_X64_MSR_CRASH_P3		HV_REGISTER_CRASH_P3
> -#define HV_X64_MSR_CRASH_P4		HV_REGISTER_CRASH_P4
> -#define HV_X64_MSR_CRASH_CTL		HV_REGISTER_CRASH_CTL
> -#define HV_X64_MSR_TIME_REF_COUNT	HV_REGISTER_TIME_REF_COUNT
> -#define HV_X64_MSR_REFERENCE_TSC	HV_REGISTER_REFERENCE_TSC
> +/*
> + * To support non-arch-specific code calling hv_set/get_register:
> + * - On x86, HV_SYNTHETIC_REG_ indicates an MSR accessed via rdmsrl/wrms=
rl
> + * - On ARM, HV_SYNTHETIC_REG_ indicates a VP register accessed via hype=
rcall

Same here:  "ARM64" instead of "ARM".

> + */
> +#define HV_SYNTHETIC_REG_VP_INDEX		(HV_X64_MSR_VP_INDEX)
> +#define HV_SYNTHETIC_REG_TIME_REF_COUNT
> 	(HV_X64_MSR_TIME_REF_COUNT)
> +#define HV_SYNTHETIC_REG_REFERENCE_TSC
> 	(HV_X64_MSR_REFERENCE_TSC)
> +
> +#define HV_SYNTHETIC_REG_STIMER0_CONFIG
> 	(HV_X64_MSR_STIMER0_CONFIG)
> +#define HV_SYNTHETIC_REG_STIMER0_COUNT
> 	(HV_X64_MSR_STIMER0_COUNT)
> +
> +#define HV_SYNTHETIC_REG_SCONTROL		(HV_X64_MSR_SCONTROL)
> +#define HV_SYNTHETIC_REG_SIEFP			(HV_X64_MSR_SIEFP)
> +#define HV_SYNTHETIC_REG_SIMP			(HV_X64_MSR_SIMP)
> +#define HV_SYNTHETIC_REG_EOM			(HV_X64_MSR_EOM)
> +#define HV_SYNTHETIC_REG_SINT0			(HV_X64_MSR_SINT0)
> +
> +#define HV_SYNTHETIC_REG_CRASH_P0		(HV_X64_MSR_CRASH_P0)
> +#define HV_SYNTHETIC_REG_CRASH_P1		(HV_X64_MSR_CRASH_P1)
> +#define HV_SYNTHETIC_REG_CRASH_P2		(HV_X64_MSR_CRASH_P2)
> +#define HV_SYNTHETIC_REG_CRASH_P3		(HV_X64_MSR_CRASH_P3)
> +#define HV_SYNTHETIC_REG_CRASH_P4		(HV_X64_MSR_CRASH_P4)
> +#define HV_SYNTHETIC_REG_CRASH_CTL		(HV_X64_MSR_CRASH_CTL)
>=20
>  /* Hyper-V memory host visibility */
>  enum hv_mem_host_visibility {
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 4c4c0ec3b62e..1afa77ab9a04 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -224,14 +224,14 @@ extern bool hv_isolation_type_snp(void);
>=20
>  static inline bool hv_is_synic_reg(unsigned int reg)

Should this function name be changed to hv_is_synic_msr() since
it is based on MSR values and not register values?  Argument
name should probably also be "msr", not "reg" to avoid
any confusion.

>  {
> -	return (reg >=3D HV_REGISTER_SCONTROL) &&
> -	       (reg <=3D HV_REGISTER_SINT15);
> +	return (reg >=3D HV_X64_MSR_SCONTROL) &&
> +	       (reg <=3D HV_X64_MSR_SINT15);
>  }
>=20
>  static inline bool hv_is_sint_reg(unsigned int reg)

Same here.

>  {
> -	return (reg >=3D HV_REGISTER_SINT0) &&
> -	       (reg <=3D HV_REGISTER_SINT15);
> +	return (reg >=3D HV_X64_MSR_SINT0) &&
> +	       (reg <=3D HV_X64_MSR_SINT15);
>  }
>=20
>  u64 hv_get_register(unsigned int reg);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index f924a76c6923..7140ee32d7be 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -45,19 +45,19 @@ struct ms_hyperv_info ms_hyperv;
>  static inline unsigned int hv_get_nested_reg(unsigned int reg)

Same here.

>  {
>  	if (hv_is_sint_reg(reg))
> -		return reg - HV_REGISTER_SINT0 + HV_REGISTER_NESTED_SINT0;
> +		return reg - HV_X64_MSR_SINT0 + HV_X64_MSR_NESTED_SINT0;
>=20
>  	switch (reg) {
> -	case HV_REGISTER_SIMP:
> -		return HV_REGISTER_NESTED_SIMP;
> -	case HV_REGISTER_SIEFP:
> -		return HV_REGISTER_NESTED_SIEFP;
> -	case HV_REGISTER_SVERSION:
> -		return HV_REGISTER_NESTED_SVERSION;
> -	case HV_REGISTER_SCONTROL:
> -		return HV_REGISTER_NESTED_SCONTROL;
> -	case HV_REGISTER_EOM:
> -		return HV_REGISTER_NESTED_EOM;
> +	case HV_X64_MSR_SIMP:
> +		return HV_X64_MSR_NESTED_SIMP;
> +	case HV_X64_MSR_SIEFP:
> +		return HV_X64_MSR_NESTED_SIEFP;
> +	case HV_X64_MSR_SVERSION:
> +		return HV_X64_MSR_NESTED_SVERSION;
> +	case HV_X64_MSR_SCONTROL:
> +		return HV_X64_MSR_NESTED_SCONTROL;
> +	case HV_X64_MSR_EOM:
> +		return HV_X64_MSR_NESTED_EOM;
>  	default:
>  		return reg;
>  	}
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index c0cef92b12b8..0ab3fbca34c7 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -81,14 +81,14 @@ static int hv_ce_set_next_event(unsigned long delta,
>=20
>  	current_tick =3D hv_read_reference_counter();
>  	current_tick +=3D delta;
> -	hv_set_register(HV_REGISTER_STIMER0_COUNT, current_tick);
> +	hv_set_register(HV_SYNTHETIC_REG_STIMER0_COUNT, current_tick);
>  	return 0;
>  }
>=20
>  static int hv_ce_shutdown(struct clock_event_device *evt)
>  {
> -	hv_set_register(HV_REGISTER_STIMER0_COUNT, 0);
> -	hv_set_register(HV_REGISTER_STIMER0_CONFIG, 0);
> +	hv_set_register(HV_SYNTHETIC_REG_STIMER0_COUNT, 0);
> +	hv_set_register(HV_SYNTHETIC_REG_STIMER0_CONFIG, 0);
>  	if (direct_mode_enabled && stimer0_irq >=3D 0)
>  		disable_percpu_irq(stimer0_irq);
>=20
> @@ -119,7 +119,7 @@ static int hv_ce_set_oneshot(struct clock_event_devic=
e *evt)
>  		timer_cfg.direct_mode =3D 0;
>  		timer_cfg.sintx =3D stimer0_message_sint;
>  	}
> -	hv_set_register(HV_REGISTER_STIMER0_CONFIG, timer_cfg.as_uint64);
> +	hv_set_register(HV_SYNTHETIC_REG_STIMER0_CONFIG, timer_cfg.as_uint64);
>  	return 0;
>  }
>=20
> @@ -387,7 +387,7 @@ static u64 notrace read_hv_clock_tsc(void)
>  	u64 current_tick =3D hv_read_tsc_page(hv_get_tsc_page());
>=20
>  	if (current_tick =3D=3D U64_MAX)
> -		current_tick =3D hv_get_register(HV_REGISTER_TIME_REF_COUNT);
> +		current_tick =3D hv_get_register(HV_SYNTHETIC_REG_TIME_REF_COUNT);
>=20
>  	return current_tick;
>  }
> @@ -408,9 +408,9 @@ static void suspend_hv_clock_tsc(struct clocksource *=
arg)
>  	union hv_reference_tsc_msr tsc_msr;
>=20
>  	/* Disable the TSC page */
> -	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> +	tsc_msr.as_uint64 =3D hv_get_register(HV_SYNTHETIC_REG_REFERENCE_TSC);
>  	tsc_msr.enable =3D 0;
> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> +	hv_set_register(HV_SYNTHETIC_REG_REFERENCE_TSC, tsc_msr.as_uint64);
>  }
>=20
>=20
> @@ -419,10 +419,10 @@ static void resume_hv_clock_tsc(struct clocksource =
*arg)
>  	union hv_reference_tsc_msr tsc_msr;
>=20
>  	/* Re-enable the TSC page */
> -	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> +	tsc_msr.as_uint64 =3D hv_get_register(HV_SYNTHETIC_REG_REFERENCE_TSC);
>  	tsc_msr.enable =3D 1;
>  	tsc_msr.pfn =3D tsc_pfn;
> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> +	hv_set_register(HV_SYNTHETIC_REG_REFERENCE_TSC, tsc_msr.as_uint64);
>  }
>=20
>  #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
> @@ -456,7 +456,7 @@ static u64 notrace read_hv_clock_msr(void)
>  	 * is set to 0 when the partition is created and is incremented in
>  	 * 100 nanosecond units.
>  	 */
> -	return hv_get_register(HV_REGISTER_TIME_REF_COUNT);
> +	return hv_get_register(HV_SYNTHETIC_REG_TIME_REF_COUNT);
>  }
>=20
>  static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
> @@ -543,14 +543,14 @@ static bool __init hv_init_tsc_clocksource(void)
>  	 * thus TSC clocksource will work even without the real TSC page
>  	 * mapped.
>  	 */
> -	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> +	tsc_msr.as_uint64 =3D hv_get_register(HV_SYNTHETIC_REG_REFERENCE_TSC);
>  	if (hv_root_partition)
>  		tsc_pfn =3D tsc_msr.pfn;
>  	else
>  		tsc_pfn =3D HVPFN_DOWN(virt_to_phys(tsc_page));
>  	tsc_msr.enable =3D 1;
>  	tsc_msr.pfn =3D tsc_pfn;
> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> +	hv_set_register(HV_SYNTHETIC_REG_REFERENCE_TSC, tsc_msr.as_uint64);
>=20
>  	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 8b0dd8e5244d..319f21205a9c 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -213,7 +213,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	union hv_synic_scontrol sctrl;
>=20
>  	/* Setup the Synic's message page */
> -	simp.as_uint64 =3D hv_get_register(HV_REGISTER_SIMP);
> +	simp.as_uint64 =3D hv_get_register(HV_SYNTHETIC_REG_SIMP);
>  	simp.simp_enabled =3D 1;
>=20
>  	if (hv_isolation_type_snp() || hv_root_partition) {
> @@ -227,10 +227,10 @@ void hv_synic_enable_regs(unsigned int cpu)
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>=20
> -	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> +	hv_set_register(HV_SYNTHETIC_REG_SIMP, simp.as_uint64);
>=20
>  	/* Setup the Synic's event page */
> -	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
> +	siefp.as_uint64 =3D hv_get_register(HV_SYNTHETIC_REG_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
>  	if (hv_isolation_type_snp() || hv_root_partition) {
> @@ -245,12 +245,12 @@ void hv_synic_enable_regs(unsigned int cpu)
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>=20
> -	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> +	hv_set_register(HV_SYNTHETIC_REG_SIEFP, siefp.as_uint64);
>=20
>  	/* Setup the shared SINT. */
>  	if (vmbus_irq !=3D -1)
>  		enable_percpu_irq(vmbus_irq, 0);
> -	shared_sint.as_uint64 =3D hv_get_register(HV_REGISTER_SINT0 +
> +	shared_sint.as_uint64 =3D hv_get_register(HV_SYNTHETIC_REG_SINT0 +
>  					VMBUS_MESSAGE_SINT);
>=20
>  	shared_sint.vector =3D vmbus_interrupt;
> @@ -266,14 +266,14 @@ void hv_synic_enable_regs(unsigned int cpu)
>  #else
>  	shared_sint.auto_eoi =3D 0;
>  #endif
> -	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
> +	hv_set_register(HV_SYNTHETIC_REG_SINT0 + VMBUS_MESSAGE_SINT,
>  				shared_sint.as_uint64);
>=20
>  	/* Enable the global synic bit */
> -	sctrl.as_uint64 =3D hv_get_register(HV_REGISTER_SCONTROL);
> +	sctrl.as_uint64 =3D hv_get_register(HV_SYNTHETIC_REG_SCONTROL);
>  	sctrl.enable =3D 1;
>=20
> -	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
> +	hv_set_register(HV_SYNTHETIC_REG_SCONTROL, sctrl.as_uint64);
>  }
>=20
>  int hv_synic_init(unsigned int cpu)
> @@ -297,17 +297,17 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	union hv_synic_siefp siefp;
>  	union hv_synic_scontrol sctrl;
>=20
> -	shared_sint.as_uint64 =3D hv_get_register(HV_REGISTER_SINT0 +
> +	shared_sint.as_uint64 =3D hv_get_register(HV_SYNTHETIC_REG_SINT0 +
>  					VMBUS_MESSAGE_SINT);
>=20
>  	shared_sint.masked =3D 1;
>=20
>  	/* Need to correctly cleanup in the case of SMP!!! */
>  	/* Disable the interrupt */
> -	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
> +	hv_set_register(HV_SYNTHETIC_REG_SINT0 + VMBUS_MESSAGE_SINT,
>  				shared_sint.as_uint64);
>=20
> -	simp.as_uint64 =3D hv_get_register(HV_REGISTER_SIMP);
> +	simp.as_uint64 =3D hv_get_register(HV_SYNTHETIC_REG_SIMP);
>  	/*
>  	 * In Isolation VM, sim and sief pages are allocated by
>  	 * paravisor. These pages also will be used by kdump
> @@ -322,9 +322,9 @@ void hv_synic_disable_regs(unsigned int cpu)
>  		simp.base_simp_gpa =3D 0;
>  	}
>=20
> -	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> +	hv_set_register(HV_SYNTHETIC_REG_SIMP, simp.as_uint64);
>=20
> -	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
> +	siefp.as_uint64 =3D hv_get_register(HV_SYNTHETIC_REG_SIEFP);
>  	siefp.siefp_enabled =3D 0;
>=20
>  	if (hv_isolation_type_snp() || hv_root_partition) {
> @@ -334,12 +334,12 @@ void hv_synic_disable_regs(unsigned int cpu)
>  		siefp.base_siefp_gpa =3D 0;
>  	}
>=20
> -	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> +	hv_set_register(HV_SYNTHETIC_REG_SIEFP, siefp.as_uint64);
>=20
>  	/* Disable the global synic bit */
> -	sctrl.as_uint64 =3D hv_get_register(HV_REGISTER_SCONTROL);
> +	sctrl.as_uint64 =3D hv_get_register(HV_SYNTHETIC_REG_SCONTROL);
>  	sctrl.enable =3D 0;
> -	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
> +	hv_set_register(HV_SYNTHETIC_REG_SCONTROL, sctrl.as_uint64);
>=20
>  	if (vmbus_irq !=3D -1)
>  		disable_percpu_irq(vmbus_irq);
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 52a6f89ccdbd..77a68f16bc6e 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -142,7 +142,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  		*outputarg =3D (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
>  	}
>=20
> -	msr_vp_index =3D hv_get_register(HV_REGISTER_VP_INDEX);
> +	msr_vp_index =3D hv_get_register(HV_SYNTHETIC_REG_VP_INDEX);
>=20
>  	hv_vp_index[cpu] =3D msr_vp_index;
>=20
> @@ -246,7 +246,7 @@ EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
>   */
>  static u64 __hv_read_ref_counter(void)
>  {
> -	return hv_get_register(HV_REGISTER_TIME_REF_COUNT);
> +	return hv_get_register(HV_SYNTHETIC_REG_TIME_REF_COUNT);
>  }
>=20
>  u64 (*hv_read_reference_counter)(void) =3D __hv_read_ref_counter;
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 1901556efe79..9ca8a7b73b81 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1405,17 +1405,17 @@ static void hv_kmsg_dump(struct kmsg_dumper
> *dumper,
>  	 * contain the size of the panic data in that page. Rest of the
>  	 * registers are no-op when the NOTIFY_MSG flag is set.
>  	 */
> -	hv_set_register(HV_REGISTER_CRASH_P0, 0);
> -	hv_set_register(HV_REGISTER_CRASH_P1, 0);
> -	hv_set_register(HV_REGISTER_CRASH_P2, 0);
> -	hv_set_register(HV_REGISTER_CRASH_P3, virt_to_phys(hv_panic_page));
> -	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P0, 0);
> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P1, 0);
> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P2, 0);
> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P3,
> virt_to_phys(hv_panic_page));
> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P4, bytes_written);
>=20
>  	/*
>  	 * Let Hyper-V know there is crash data available along with
>  	 * the panic message.
>  	 */
> -	hv_set_register(HV_REGISTER_CRASH_CTL,
> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_CTL,
>  	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
>  }
>=20
> @@ -1555,7 +1555,7 @@ static int vmbus_bus_init(void)
>  		 * Register for panic kmsg callback only if the right
>  		 * capability is supported by the hypervisor.
>  		 */
> -		hyperv_crash_ctl =3D hv_get_register(HV_REGISTER_CRASH_CTL);
> +		hyperv_crash_ctl =3D hv_get_register(HV_SYNTHETIC_REG_CRASH_CTL);
>  		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
>  			hv_kmsg_dump_register();
>=20
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 8845a2eca339..76bf968d77a8 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -147,7 +147,7 @@ static inline void vmbus_signal_eom(struct hv_message=
 *msg,
> u32 old_msg_type)
>  		 * possibly deliver another msg from the
>  		 * hypervisor
>  		 */
> -		hv_set_register(HV_REGISTER_EOM, 0);
> +		hv_set_register(HV_SYNTHETIC_REG_EOM, 0);
>  	}
>  }
>=20
> --
> 2.25.1

