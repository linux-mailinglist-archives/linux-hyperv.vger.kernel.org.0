Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7FB693B9A
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Feb 2023 02:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBMBID (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 12 Feb 2023 20:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBMBIC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 12 Feb 2023 20:08:02 -0500
Received: from BN3PR00CU001-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11020023.outbound.protection.outlook.com [52.101.56.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548E7BDFC;
        Sun, 12 Feb 2023 17:08:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IT0hcXImrMJu5x6HKwOTUmw3EoEWSa4xbCXHHSfX/bfMNN0V/AKFan36OL2S9J++Zdx+Vr6pnnyy2VlAls0Pm0Cjb8gQvAGznVngwRiuhrY09jLuAJOYFrdpK6P+p6WIQ2v9wv6sj6tk/o59iIwyIojqPTf7PMVOT2LJm153hiobdWx3vOE4eee5fMDCP97KrQXPgsWsdyrj148KVA0B9NRNWuVkI82ccuLMjDFnQ3iVhrYXGWyKMXsmkJJtaCDbcefojnp2LpiaeKQ6gTDd871BTz3gHwrYRfuAuzrwTCVpYWV0aeZbQs6tZ3i/F/iJhBuV/1sDpmzLkm3rJgAcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IkEGW8iBV0K7SqHTTwFcjxBYM9KFY7VJOU7II/nDVY=;
 b=W28Rk+KfigIvGvUWOt2ZDjuZaOl7IAOjHM5zBIqtgqVaaQw4L3dn3PsKKpvDemT9uqMWS6pVn7YcsfZjqb9ScABSnA8mu/Z3/xqz49eWYtlnBncohFU2e41MgaiEe9G2+VFwAI3PknGiVQ5HV/MZ5I1O8wdByllh4FrDV7em2xXtzZMpOH+sJ3Ys2mDBHZng1wrCBVA5pp0A595V5V+QcN5i6tW/Zn4dfMsquGYJ8s0ctkXhxACAeIN58SDam7JYsbN5EZMvWIW/YH8o6bVMLsZfNbvBfoLVuj8uVTiuvfI0CUykNMdneOglyZ0o0cTL45Ssc9WHVNcMWK1hGuzDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IkEGW8iBV0K7SqHTTwFcjxBYM9KFY7VJOU7II/nDVY=;
 b=I/Fstmj0gyzDKxGc/3eu7A2GtjqWiBFyBl/mjihBvTmvOfp2mZ/3ZsvCY0yvrCyJ2AIb+CFqDrUJvGE4BjXDArBL2bBSh2O9CGN0snw+C1NJRVztUA0a2wEZQ53AIEDjjQ4prllQFeYy6Q8e2B3IVwrj5LOV6FHLe8eLoqbVGMs=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3430.namprd21.prod.outlook.com (2603:10b6:8:91::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.0; Mon, 13 Feb 2023 01:07:59 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf%8]) with mapi id 15.20.6111.007; Mon, 13 Feb 2023
 01:07:58 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v2 3/8] x86/hyperv: set MTRR state when running as SEV-SNP
 Hyper-V guest
Thread-Topic: [PATCH v2 3/8] x86/hyperv: set MTRR state when running as
 SEV-SNP Hyper-V guest
Thread-Index: AQHZPFdQNE/TrMPJsEmD9dWJHuYRFq7Luw0g
Date:   Mon, 13 Feb 2023 01:07:58 +0000
Message-ID: <BYAPR21MB1688C2A893BA9D2A14D729DFD7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-4-jgross@suse.com>
In-Reply-To: <20230209072220.6836-4-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c0565a9b-4d67-4555-8284-7c9677033055;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-12T19:40:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3430:EE_
x-ms-office365-filtering-correlation-id: 7bdf40ab-40cb-45ec-d3fa-08db0d5ebf38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V6NrOxBLWe0tKdw3SaRO7Z+xuf4EGj3nWGs1/df/u7Ls2rglqduXrWZatS8AlqrrgyfFtgaIuCwUAsaH4GOk6QWNIc9VthqA9Iwo2nVXNEVOH8+P31cxxFh0MPGF9OL+SOXQyilrZ0neViyU6qCbtODJjh8p8ojFL8xS/InH7taBjZTN5HoGLPimAv4EN4Mc8Y6qqPrim89Ps7dVKUTN1CnKIpZIerQrSK3VUhMpyFjZgWjc/PaaxddI2rmyG03Cmqpv7Y7N6CHEnpC0fLJHmIbf8DmK2pcVyNo1JkYGbaU52XI7UrGP+2Sox5bF4jjoCS5qUCPte+k7sOJ/i/lRoXYFAa/Tt6gJjr/IWv0c6irVd+4Y3H63bRi7isyrYhFeWy/y4J66H0nsTTAjOF6FxZeJYaZ8yjGhT8rXqzzZNlaNQ/vQOSLUtWoTaADy7BBMMrwS56UH+oDEgAd3dbyfbpxoMeNulfpc7P/2XFVCNMjB395i4jDuOwjsVvaILcZttXE2KA58QiUTXJrW0aFKP0jbAACN+cR29tElS3PmtCkL2EIKjp+EXUJuYFtPLpIeLMRVbL8bM+ELfBuvO7gvheDR0+oYxwQQebAqDGRYVTJ31SewXSH9sP3DtLsRnn/BqQbJ6XcAsBnJ0wpkangDT/MaFmfHr2CoiuExX3DvIpkx1+8XuaMChsdlj4/lsrycVv0JhotlxtatE89zb4kAa9eaLzmPPj9v0ohtQokEh7Vt67T3CINTHsNBR4+yRh2e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199018)(52536014)(38100700002)(38070700005)(82960400001)(82950400001)(122000001)(33656002)(86362001)(83380400001)(186003)(9686003)(6506007)(71200400001)(110136005)(2906002)(8990500004)(10290500003)(478600001)(4326008)(66476007)(64756008)(66446008)(76116006)(7696005)(8676002)(66946007)(66556008)(7416002)(5660300002)(41300700001)(8936002)(54906003)(316002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IaF6FfWajpQxgu6WJEjuhVi3Ud5bbSp6VmoCDLQUJpaRyZWKsvtUB083GRh+?=
 =?us-ascii?Q?yiTO1zV+DI+XUb08uqy55EOVskGu6AAljfBR8H7j1y+iMuU85h0qny1k84XV?=
 =?us-ascii?Q?LfRJahNySArSju9B+iNYcF76XNqhzplpwIJXvJIISZqJ/YdiLWYh28keFw46?=
 =?us-ascii?Q?WnC7TZgz8FpJ64EQpIgoSNEqhgqNp6g08OK8iC+VqU6CrPncmF3Z1vLGar+j?=
 =?us-ascii?Q?BzXHyBl2fGbMfq3ai96yM9pFzoqeVZOoYcBw9AWnwXSSxxdL/0lbcyIUtkOM?=
 =?us-ascii?Q?g77KbR72vUQO5XK1+Pn69gKvQUcxX3EdvkshNciTBU3Az+3MX067H4qc6FtM?=
 =?us-ascii?Q?S/f0xia3nEkMF+r8KJB0wpa0Kbtgu7mYBLZ1BO3CcSi20y6l/ZTMqe7Roien?=
 =?us-ascii?Q?Hw22i7tcay6nE2HGr9XPpOPDJZ8ejsL0tYuEgutCFmUV8jqUj++fY3Kj+KwX?=
 =?us-ascii?Q?sbMlfLbonYKlFO9Nhl0GIjAKxCOpoqR1p4Zft+l4SIhloROgy4FbDgcw+Owj?=
 =?us-ascii?Q?ope1XW8i259aC2/wW/+RoaFF+AO+dDjzfsOvM9JhnPOOQ5QUhRkRf+cIiN+K?=
 =?us-ascii?Q?BhYI47VBNYIS34n7ehwZvHgN13qrDSeAornApgUlQFM3UgDlVo+mgtzQRUkW?=
 =?us-ascii?Q?Vnm4H54hXJqw+e0g6XbqPoD/2B7Fs/UVUrUG5paBWnTuGED/vGzJ6r5Y3Q9G?=
 =?us-ascii?Q?EXF8iEjfgHGgjZglMKHQRPIZU7tnGhLRAhVyzx4hwOkY7ILF/ZcUCzG0/D4L?=
 =?us-ascii?Q?fzj2/KyHTzN5PCpXpPqDJIpcI28K+exgertqJftqZ+mx4fc90TczpTcsTfvU?=
 =?us-ascii?Q?UcNDy+ecj1bSV7tIm6r9F3xfhHdm/7KDq8VENFvHl/zm5IyfP8549BhHKzR/?=
 =?us-ascii?Q?nNVRRjugkKIpNGzQt5uViEK03ecVHmkekGvubS82xIaazVtgUvcwgx/IrF8R?=
 =?us-ascii?Q?bqwGiZmncHW8r0ky4YRsES1BwTuoC3QPqReGnghahOu0xT8Rxnz9TH48dNJG?=
 =?us-ascii?Q?PF/yUen55i0+wIs+KSMnk/CznSUynsH2TR8oQ2wt3HPHFaJ/gLhVdDdGgz7C?=
 =?us-ascii?Q?Etyc+Y0AtwK89pgc7+HViQHPl4JK/Nti0ZYJ0T0xmg/fNz8QExFjwVgPAvgI?=
 =?us-ascii?Q?EEbIgUVMJ0AYHVXR9I0AJzY5WDVqmuIfOGQvLZrKDulYH/OQzsCqTjdRmbOr?=
 =?us-ascii?Q?w3sF09fL0zLToVyrNkOxvD6EJG8M9bHq0TTQrez8TWqTRQPFSOyRGivyy/pg?=
 =?us-ascii?Q?2CZBLQ5zGIKUI4qBILIwm6Gu0Zoq1TH56cVIiOQpqchMKvQCsipafFULbD4o?=
 =?us-ascii?Q?4dfjhER3SG3gWdXBpaSJqqwF5T4FuEmMUzC44N6Y/3vv6bVZ95mAvGZfTpyq?=
 =?us-ascii?Q?+JYcpwBmlZPwtbv4xvLBiz+kFxCo4tKJYUfiiN/iSOOA1XU4LZHQhcabZ1Jt?=
 =?us-ascii?Q?o3z8ava4mfloyJTeoPasAMUXwVlovJBYtG+QQWoiQw5rIG6g+gb2cHcnuumc?=
 =?us-ascii?Q?z6XR0DEbvUVsxHA6MysiySX79FWpjjqFsx3mghvopLmkF/xQY8ZJBBXQNLZQ?=
 =?us-ascii?Q?TKDL3M1ZEbJ75MpiPIkuCbh/E+JgGPsgb80sdyzONftgNCO6ufiUgcv5EVJv?=
 =?us-ascii?Q?vHX6TWa1VhbAbz+3ObaqFEJIbV6yMJVW1YFwNLx+gLerAiycMrppPHd/GZYO?=
 =?us-ascii?Q?dbbsbw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdf40ab-40cb-45ec-d3fa-08db0d5ebf38
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 01:07:58.8847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7MONIniL7v7IMrjcP3ibc0dcRM86SrUxn66sdX/DhGLgIT8AJ2LaDV0wJsOQD53hQpoADWuM1bJ/1BXV5QiGWPvo2q4OwuFvRUN7Nq8QJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3430
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Juergen Gross <jgross@suse.com> Sent: Wednesday, February 8, 2023 11:=
22 PM
>=20
> In order to avoid mappings using the UC- cache attribute, set the
> MTRR state to use WB caching as the default.
>=20
> This is needed in order to cope with the fact that PAT is enabled,
> while MTRRs are disabled by the hypervisor.
>=20
> Fixes: 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled ca=
se")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - new patch
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 46668e255421..51e47dc0e987 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -34,6 +34,7 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/numa.h>
>  #include <asm/coco.h>
> +#include <asm/mtrr.h>
>=20
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> @@ -335,6 +336,13 @@ static void __init ms_hyperv_init_platform(void)
>  			static_branch_enable(&isolation_type_snp);
>  #ifdef CONFIG_SWIOTLB
>  			swiotlb_unencrypted_base =3D ms_hyperv.shared_gpa_boundary;
> +#endif

Unfortunately, Hyper-V does not filter out the MTRR flag from the
CPUID leaf, so this code also needs=20

			setup_clear_cpu_cap(X86_FEATURE_MTRR);

before calling mtrr_overwrite_state().  I've got a bug filed for the
Hyper-V team to fix the flag, but clearing the feature here solves the
problem regardless.

> +#ifdef CONFIG_MTRR

Hopefully this #ifdef can go away, per my comment in Patch 2 of
the series.

Michael

> +			/*
> +			 * Set WB as the default cache mode in case MTRRs are
> +			 * disabled by the hypervisor.
> +			 */
> +			mtrr_overwrite_state(NULL, 0, NULL, MTRR_TYPE_WRBACK);
>  #endif
>  		}
>  		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
> --
> 2.35.3

