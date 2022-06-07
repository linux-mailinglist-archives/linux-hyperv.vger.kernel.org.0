Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C7C5421B3
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jun 2022 08:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiFHDGY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jun 2022 23:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378346AbiFHDFA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jun 2022 23:05:00 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064017.outbound.protection.outlook.com [52.101.64.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D61200148;
        Tue,  7 Jun 2022 13:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTU0MIDxG7zf+8lORhDUSquIR/gA1WExRxXc+4wuPzr/bl8a/K61FHjI+hruZkA5qWw4u2xpqGnxMHSqaj5wKT2yrnTOxxKpboOEeCW0TtWtf6WuL7Z+1uHPMAQp9MEj0lfyQ4QE1NVslPmf/c7Njy7juHTPdxLkuoHY+Kl/ZVDPtJgn1kxfmDC7yfIylgiA2hRY7eY6+3KF02I3mNApUQZSz4qjMI4bjnXSh2+yp3tr/f7Vq0te77m7Rstx2YyOsFy4kkhgdK2azdjNYxMY6GzwaeJRBivqy/hRx6t6ee6DcMqd0FLk8YWxHSxkiJgWdnVxhUaC+GH9dMVsja+agg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxGTOPT0pYQN4h3Mj5k1CooMFK7H2COWbhIymKZZQR4=;
 b=Va+yqHBp2R74C2wgeJviwyhoImpXoh4sYmKApHYRDbwxSYsSrxCwDrr/1jjUl1Drn1b/f6tL6fXnoLT33HmyfrXeGZ4gn8Uga+Q6jV9+eJxVcYML/cdbjsnRVyfsVJsQUfgBBNubDXmA/Gwcs/X0WLbL+XsgUuT+SB0f7ACpFQZyE9J7SBVl6FZBKn6dhHV64hCXTZBSmFKF/6MO4fZHSZ7dx+fAi0XOCW5noPEewZOxP/dH0XMtsuneqpAtA8vwuRi8UnXl5WDVx8s9xM0IwSgcyIXpEbwAK5AUsojjY0STw/wfejEGd1Jo8ZbapiMCjAzVesdjEl/GkGYfrxd6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxGTOPT0pYQN4h3Mj5k1CooMFK7H2COWbhIymKZZQR4=;
 b=Xi4rH/k/1JAQwAODVmIjnMZ68H1fNzU2EyPzO5EuKrryGhj8033GGoi0O21cS/Fc43GOkHBSoZnNAWS+x4C9UiTZ6qQd/0t3w0dbyVvtuxh4vXHmSmLNdxY3JHMd1kE27RUnn8F0TZsE4BCGXewm9MCMnhExqKIiKkz90t3elI0=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by LV2PR21MB3277.namprd21.prod.outlook.com (2603:10b6:408:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.1; Tue, 7 Jun
 2022 20:30:40 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013%9]) with mapi id 15.20.5332.007; Tue, 7 Jun 2022
 20:30:40 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>
Subject: RE: [PATCH V2] x86/Hyper-V: Add SEV negotiate protocol support in
 Isolation VM
Thread-Topic: [PATCH V2] x86/Hyper-V: Add SEV negotiate protocol support in
 Isolation VM
Thread-Index: AQHYdnCzgZf4wipbvk2rWCmd848voa1EaFRw
Date:   Tue, 7 Jun 2022 20:30:40 +0000
Message-ID: <PH0PR21MB302527315F7BE39E0709C5E6D7A59@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220602110507.243083-1-ltykernel@gmail.com>
In-Reply-To: <20220602110507.243083-1-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cdff63a3-36d4-4054-a872-2c2174e314ea;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-07T20:10:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10d32e97-b8ab-4f4e-451e-08da48c496c0
x-ms-traffictypediagnostic: LV2PR21MB3277:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <LV2PR21MB32771B335DC9D896FF278D9DD7A59@LV2PR21MB3277.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yAlT43Fj5fEIQMMsBunFOZyw1boMIYa3wEikthAojrQ6/PUG1sDdCPUMSK4+IWcx3y3RsuTsjxbLb1pU2Zf7IAFPTpQEcWNoAfUB2vkepr5kwd1RVEeCdLOTxiF5DGn1yijiHwtHaHllEMsB8p+/fEw14jXCHpuFeiOziWMct5SMmkbX+Q81yW91SGZxF2XwnkTbALEjEIrvN4xdhcKxQDDk+U/iZ6NNLs5d4ClUynhH50ypgVM4cbs1+pCaIpi2s/shy/iTkx56Zio0wz6Zi0/Cjmjvl1f7jJ/zKdOGWsPT3HbNmAKIhVZbijBcSGLJwh5q9FVDaa2BPcTE69qE+IMzWlaCfk895m8JWMzNxoPKSo+KthEEJ/QDIanIm5HNHredlTr7zSSxCNRhRYG9XLa1nIpk+YbL16YUDEz2xHnBf7xdJxdtTfoWKre4jh2DPovdZ6sqi2+UNywGVd8aLGI8xuhs7h5hAamOd5XWrY1hjIZAbd3LjJRN1ZoLy5L4Tl7QqXFPkrh6FhWXSOO4Pu/1rkbqVCAwYmDsC7C9ntRJRDrchO+D3SEtakB+zENgHSkAKlv9YBUhP7zyWQ6WCpNtfufdFHMVBsqoMd6Hbj40EG0RsyNfB9NUR5nTZZdW/0sxbncsGZ2RNrKEEtjPdbRoB2lu8JNNvkdJA0prOvjWWBKG5dbf2NMKLUaLOge1fy5HrC8dMRGD+DUtirMo8RnwIdDjLaaL5YhPiPPXSgHiQ5I5vWl5Kg9csXwaQlN/gASIJ7YAWTdY5avJngjWWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(83380400001)(921005)(66476007)(66446008)(64756008)(66556008)(76116006)(8676002)(66946007)(316002)(122000001)(38070700005)(54906003)(4326008)(26005)(10290500003)(9686003)(82960400001)(82950400001)(186003)(2906002)(110136005)(55016003)(6506007)(8990500004)(71200400001)(8936002)(52536014)(33656002)(38100700002)(7696005)(5660300002)(508600001)(86362001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8T2KpgICcr+sNg27rWEKD+t8WJSkndNjWTDu4iOOO0oraV8QEM5jctWudNJF?=
 =?us-ascii?Q?NnjHD68WpX+4jSJjhb6tBPLkPh/OGHGjbvjjg4VB541YKmXQmcqHK2clhn/w?=
 =?us-ascii?Q?w/xxgEMrWXfkVRpqVzqzibixU2IK888pnOrB2TtCRAF8/u4rYi9HBYK/L86p?=
 =?us-ascii?Q?7z4xLKUyecAEhQ7w1C83a7y0DCHIvzPaZ4MzxJZvr5heI+7iHmJkzaQsuGTj?=
 =?us-ascii?Q?07w1Pccsea3rsmhyDxERxao0IUXCOS33f1RmriQmXXIBdfbSdVPkk00xU3gP?=
 =?us-ascii?Q?GOBYBpsxgSyhebwps77u+Bd3xK9GcBT/QKyx01IElVVfUpaXo5/pQ6a3ATmW?=
 =?us-ascii?Q?1SlFUw1opVn8zUrn4Fp0C/qPiAeIyPTfBfhYe3Xx/43/EsWmI9jgN5YWl9T9?=
 =?us-ascii?Q?d1aQgITAAw1ukw35ar06eAmAT0S3SBkYwxuUotCf13jgKo+lvZbGJW2BqJ8T?=
 =?us-ascii?Q?z8jSXrii0vLuvYKS/iGIWeptmvIKeBSAjjcyT6SxSxzoCI9T2DDsee41HAOb?=
 =?us-ascii?Q?OhUslQg3S+pLGq87U4U1Bga6JD3tiJigvcRp5z3KRh2myvj33xBA6qO9zISZ?=
 =?us-ascii?Q?5ZxMUTcqigzGgbkzEl6RIMC5wfuMV+kBf8cd6UMGHRgQaTT6mOnExx/yfgqA?=
 =?us-ascii?Q?37s0b9XwXLC+lJeF1qR2+Skj+Ink1MXkd2+U0MWipg2F53a+sdIP+j03lr/r?=
 =?us-ascii?Q?5Ae/9eWTeMB9EjrI1iRogQNJAHKzsBUMrij3Eexn6l88yIodtXoeXPewUC2+?=
 =?us-ascii?Q?ygbrpDv7Pv0kHXzdkmQBl6BGtwfEFAUTRBXZGmYmr0kdukgizyzcXHcMovGy?=
 =?us-ascii?Q?6SpU9Fe2ilG2/p3XJvqeGGxX2nN6om+hLgjNPncuCLDHPuIN8um9us27Z23b?=
 =?us-ascii?Q?zwl5E0voQBDhrjI7CDQxUbW4VgXyhMRts2kEd8StaZrbRYEMHF8wCJ1brEsm?=
 =?us-ascii?Q?e8Q6/qZ/IUV1VIcDOwPDOgffHY1D3xqRbslAylXcJpnpnMeKIfffSsAFdYi6?=
 =?us-ascii?Q?sckfuP3xC4EupvjxsDP5tH2qKUq/JIRGzq0yYoiOi5N/EHyE9zJrllAfbHup?=
 =?us-ascii?Q?d80QI6tgjrxqDy4ePnZz1jrvhvLUCEnS6Bjg5mCVfT3QA5t1l1Fw1NSW/TYi?=
 =?us-ascii?Q?Az22IAVXkKc4cM4yoDCavOHJad8LRqCeFn/XN4pnmdb2awer6G++QG/4lMlz?=
 =?us-ascii?Q?i/Hm230WFGiXPeBxmYSwVnChJtFxg2bMGfD3PynavXQwtDlh+pGLZ4zVByo7?=
 =?us-ascii?Q?id5noGHF9ZZyw/hCG+NlrBxoHgNIrDcntSn/ABaLmHHRXj7FCEr6hh62av0j?=
 =?us-ascii?Q?wgddfHUWwfvvCbwP/16FcOFmI1d3JYYaJibH408EBsVcdTozBnDfYfqnd2es?=
 =?us-ascii?Q?DLMfNqUaZizVXxtHEoGkExralNR9hVXdQXktQ5Be+NhF1UUmasQfbVVoN2CQ?=
 =?us-ascii?Q?2q4TSAKXqU989LXfHwZNE2U1xFSVJ3rds2DAQD/hjsN+AMmwFBnjTf7qm1xT?=
 =?us-ascii?Q?L4KjKZcY80l9K7jvk5RWndvzGyK+COb0L2boFL5YYOHKkiLupbuWtMn0HOq/?=
 =?us-ascii?Q?KOwPkTBWwh/0k7itcvB8sRbRmlnrgXRAuoWa6GbsqBVYHtZxTMO52SJcVaDc?=
 =?us-ascii?Q?3Pm2Met1Jk9HojZ49Dd26ru7l302DLa1n6vRftIeTFYHQeTPmGr/HnXmv1Y3?=
 =?us-ascii?Q?14PnXsfhuJc+MKWTiPSz41ZNQzNkDcj5+Tx4Fsd2M9jiBj1rQ2iQpZQM9Qs/?=
 =?us-ascii?Q?0zmr+ag8yvWDHTv7PQCGgNTpi4/PNPY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d32e97-b8ab-4f4e-451e-08da48c496c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 20:30:40.6163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /KT2kEDYpeg1Bbi6pinINLGLaIPVFor6nE9uVNj1x8iwN0tb2kzmV0anRwC1GrN8TXbyJhsGwHIKOryjIlCcoQb2NKyus0JwwGHOcXJ5Nqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3277
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Thursday, June 2, 2022 4:05 AM
>=20
> Hyper-V Isolation VM current code uses sev_es_ghcb_hv_call()
> to read/write MSR via GHCB page and depends on the sev code.
> This may cause regression when sev code changes interface
> design.
>=20
> The latest SEV-ES code requires to negotiate GHCB version before
> reading/writing MSR via GHCB page and sev_es_ghcb_hv_call() doesn't
> work for Hyper-V Isolation VM. Add Hyper-V ghcb related implementation
> to decouple SEV and Hyper-V code. Negotiate GHCB version in the
> hyperv_init_ghcb() and use the version to communicate with Hyper-V
> in the ghcb hv call function.
>=20
> Fixes: 2ea29c5abbc2 ("x86/sev: Save the negotiated GHCB version")
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c       |  6 +++
>  arch/x86/hyperv/ivm.c           | 88 ++++++++++++++++++++++++++++++---
>  arch/x86/include/asm/mshyperv.h |  4 ++
>  3 files changed, 92 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 8b392b6b7b93..40b6874accdb 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -29,6 +29,7 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <linux/highmem.h>
>  #include <linux/swiotlb.h>
> +#include <asm/sev.h>
>=20
>  int hyperv_init_cpuhp;
>  u64 hv_current_partition_id =3D ~0ull;
> @@ -70,6 +71,11 @@ static int hyperv_init_ghcb(void)
>  	ghcb_base =3D (void **)this_cpu_ptr(hv_ghcb_pg);
>  	*ghcb_base =3D ghcb_va;
>=20
> +	/* Negotiate GHCB Version. */
> +	if (!hv_ghcb_negotiate_protocol())
> +		hv_ghcb_terminate(SEV_TERM_SET_GEN,
> +				  GHCB_SEV_ES_PROT_UNSUPPORTED);
> +

Negotiating the protocol here is unexpected for me.  The
function hyperv_init_ghcb() is called for each CPU as it
initializes, so the static variable ghcb_version will be set
multiple times.  I can see that setup_ghbc(), which this is
patterned after, is also called for each CPU during the early
CPU initialization, which is also a bit weird.  I see two
problems:

1) hv_ghcb_negotiate_protocol() could get called in parallel
on two different CPUs at the same time, and the Hyper-V
version modifies global state (the MSR_AMD64_SEV_ES_GHCB
MSR).  I'm not sure if the sev_es version has the same
problem.

2) The Hyper-V version would get called when taking a CPU
from on offline state to an online state.  I'm not sure if taking
CPUs online and offline is allowed in an SNP isolated VM, but
if it is, then ghcb_version could be modified well after Linux
initialization, violating the __ro_after_init qualifier on the
variable.

Net, it seems like we should find a way to negotiate the
GHCB version only once at boot time.

>  	return 0;
>  }
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 2b994117581e..4b67c4d7c4f5 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -53,6 +53,8 @@ union hv_ghcb {
>  	} hypercall;
>  } __packed __aligned(HV_HYP_PAGE_SIZE);
>=20
> +static u16 ghcb_version __ro_after_init;
> +

This is same name as the equivalent sev_es variable.  Could this one
be changed to hv_ghcb_version to avoid any confusion?

>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_=
size)
>  {
>  	union hv_ghcb *hv_ghcb;
> @@ -96,12 +98,89 @@ u64 hv_ghcb_hypercall(u64 control, void *input, void =
*output,
> u32 input_size)
>  	return status;
>  }
>=20
> +static inline u64 rd_ghcb_msr(void)
> +{
> +	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
> +}
> +
> +static inline void wr_ghcb_msr(u64 val)
> +{
> +	u32 low, high;
> +
> +	low  =3D (u32)(val);
> +	high =3D (u32)(val >> 32);
> +
> +	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);

This whole function could be coded as just

	native_wrmsrl(MSR_AMD64_SEV_ES_GHCB, val);

since the "l" version handles breaking the 64-bit argument
into two 32-bit arguments.

> +}
> +
> +static enum es_result ghcb_hv_call(struct ghcb *ghcb, u64 exit_code,
> +				   u64 exit_info_1, u64 exit_info_2)

Seems like the function name here should be hv_ghcb_hv_call.

> +{
> +	/* Fill in protocol and format specifiers */
> +	ghcb->protocol_version =3D ghcb_version;
> +	ghcb->ghcb_usage       =3D GHCB_DEFAULT_USAGE;
> +
> +	ghcb_set_sw_exit_code(ghcb, exit_code);
> +	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
> +	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
> +
> +	VMGEXIT();
> +
> +	if (ghcb->save.sw_exit_info_1 & GENMASK_ULL(31, 0))
> +		return ES_VMM_ERROR;
> +	else
> +		return ES_OK;
> +}
> +
> +void hv_ghcb_terminate(unsigned int set, unsigned int reason)
> +{
> +	u64 val =3D GHCB_MSR_TERM_REQ;
> +
> +	/* Tell the hypervisor what went wrong. */
> +	val |=3D GHCB_SEV_TERM_REASON(set, reason);
> +
> +	/* Request Guest Termination from Hypvervisor */
> +	wr_ghcb_msr(val);
> +	VMGEXIT();
> +
> +	while (true)
> +		asm volatile("hlt\n" : : : "memory");
> +}
> +
> +bool hv_ghcb_negotiate_protocol(void)
> +{
> +	u64 ghcb_gpa;
> +	u64 val;
> +
> +	/* Save ghcb page gpa. */
> +	ghcb_gpa =3D rd_ghcb_msr();
> +
> +	/* Do the GHCB protocol version negotiation */
> +	wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
> +	VMGEXIT();
> +	val =3D rd_ghcb_msr();
> +
> +	if (GHCB_MSR_INFO(val) !=3D GHCB_MSR_SEV_INFO_RESP)
> +		return false;
> +
> +	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
> +	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
> +		return false;
> +
> +	ghcb_version =3D min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_M=
AX);
> +
> +	/* Write ghcb page back after negotiating protocol. */
> +	wr_ghcb_msr(ghcb_gpa);
> +	VMGEXIT();
> +
> +	return true;
> +}
> +
>  void hv_ghcb_msr_write(u64 msr, u64 value)
>  {
>  	union hv_ghcb *hv_ghcb;
>  	void **ghcb_base;
>  	unsigned long flags;
> -	struct es_em_ctxt ctxt;
>=20
>  	if (!hv_ghcb_pg)
>  		return;
> @@ -120,8 +199,7 @@ void hv_ghcb_msr_write(u64 msr, u64 value)
>  	ghcb_set_rax(&hv_ghcb->ghcb, lower_32_bits(value));
>  	ghcb_set_rdx(&hv_ghcb->ghcb, upper_32_bits(value));
>=20
> -	if (sev_es_ghcb_hv_call(&hv_ghcb->ghcb, false, &ctxt,
> -				SVM_EXIT_MSR, 1, 0))
> +	if (ghcb_hv_call(&hv_ghcb->ghcb, SVM_EXIT_MSR, 1, 0))
>  		pr_warn("Fail to write msr via ghcb %llx.\n", msr);
>=20
>  	local_irq_restore(flags);
> @@ -133,7 +211,6 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
>  	union hv_ghcb *hv_ghcb;
>  	void **ghcb_base;
>  	unsigned long flags;
> -	struct es_em_ctxt ctxt;
>=20
>  	/* Check size of union hv_ghcb here. */
>  	BUILD_BUG_ON(sizeof(union hv_ghcb) !=3D HV_HYP_PAGE_SIZE);
> @@ -152,8 +229,7 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
>  	}
>=20
>  	ghcb_set_rcx(&hv_ghcb->ghcb, msr);
> -	if (sev_es_ghcb_hv_call(&hv_ghcb->ghcb, false, &ctxt,
> -				SVM_EXIT_MSR, 0, 0))
> +	if (ghcb_hv_call(&hv_ghcb->ghcb, SVM_EXIT_MSR, 0, 0))
>  		pr_warn("Fail to read msr via ghcb %llx.\n", msr);
>  	else
>  		*value =3D (u64)lower_32_bits(hv_ghcb->ghcb.save.rax)

Since these changes remove the two cases where sev_es_ghcb_hv_call()
is invoked with the 2nd argument as "false", it seems like there should be
a follow-on patch to remove that argument and Hyper-V specific hack
from sev_es_ghcb_hv_call().

Michael


> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index a82f603d4312..61f0c206bff0 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -179,9 +179,13 @@ int hv_set_mem_host_visibility(unsigned long addr, i=
nt
> numpages, bool visible);
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  void hv_ghcb_msr_write(u64 msr, u64 value);
>  void hv_ghcb_msr_read(u64 msr, u64 *value);
> +bool hv_ghcb_negotiate_protocol(void);
> +void hv_ghcb_terminate(unsigned int set, unsigned int reason);
>  #else
>  static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
>  static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
> +static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
> +static inline void hv_ghcb_terminate(unsigned int set, unsigned int reas=
on) {}
>  #endif
>=20
>  extern bool hv_isolation_type_snp(void);
> --
> 2.25.1

