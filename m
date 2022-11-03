Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEF461860F
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Nov 2022 18:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiKCRWj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Nov 2022 13:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiKCRWh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Nov 2022 13:22:37 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11022014.outbound.protection.outlook.com [40.93.200.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FB81001;
        Thu,  3 Nov 2022 10:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QErctPg/rQVOhaXbVrgEyxD60sRZ7r15uNFVjRsVSzK+RwEKGp5x3E+Ab0+8VSN0RUqJlXzJKwMWAEnD7Ys6a3TiRsGOU1n8FJRQb/trYOlv0Q3O10W74ci9D2oiQC3hysd+RUcoukeuuhdCqgQJlv0LjNobnxHIQSqEhZvJj9mlUFL9Aeg4Ku+B2Rz+6P8JvaVcuoq7MkZggblS24LOYket8+IPjpR7YPBhwV/Vs1+mqZJelTP8Re2Wnb6W2+rJ6T/dFZumI3jg6dxrN20CvxhU8pWcHTdhfF+kYpRRtY9mdZKTaaDKKzSAXMswVYgIb9Hf/whS7kZctoWAcpWd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ww5tzu3wdGX2tVI3zZdicD9Jr+8cEVc672bdvJlgOE=;
 b=QWOkryKEvDHI7cYYFmLKmzvIaa2dlt9SnxDpsIBIWlFoBlaH03X0l9LN0f21VOwRqAsJVlOVnKLJ66+fRsP19xubxW1kO81k4qlfc/oB4TXMY9vA1n9CjXB9pN+Z99GjUlhXTQQ5yXEEd5DAHav+TIxwP1usXIA4cYqM/lOyVnTDOLK7kWlsFjCxoiOZf0wJS8fVUYge+zOY4VAjXwMLFkMDjkyZHnEEouueRCQBpdJu4egP9HAJEuAh75n+dZLmZzS/WNMzCcNAHRQFsPP6GGLF5TQzByZirtNz5ndONzJ33ySxGdFAe/pye3txKS9/PSoYW7x+jFWWGe1qDUwEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ww5tzu3wdGX2tVI3zZdicD9Jr+8cEVc672bdvJlgOE=;
 b=ANIhVSpuxLFGQt72fdKh+8G70nqXxHz+59RNOT0P9wRzPG5gh7Nhb365eFEpIZthR3F4cnSk7qEd+rfJgAfjsN61mhxQvMTvYvhLP4K+XMZ1MqHLPGScVu6qvqG+Es3WZG1A63z5XwYPmbPux3Jz05Ppmfxb43NETg0Qms/IjWg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CO1PR21MB1300.namprd21.prod.outlook.com (2603:10b6:303:163::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8; Thu, 3 Nov
 2022 17:22:34 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.008; Thu, 3 Nov 2022
 17:22:34 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] drivers/clocksource/hyper-v: Add TSC page support
 for root partition
Thread-Topic: [PATCH v2 4/4] drivers/clocksource/hyper-v: Add TSC page support
 for root partition
Thread-Index: AQHY7web4nCQJ3roNEmkc2vgSsTv0K4sSBLggAElgACAAAQckA==
Date:   Thu, 3 Nov 2022 17:22:34 +0000
Message-ID: <BYAPR21MB16880B640804AB12482C4FA4D7389@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166742670556.205987.18227942188746093700.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166742685995.205987.1519185062889413335.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <BYAPR21MB1688672E692E9B618F3B5587D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y2PzvhwbLzlq3WHm@skinsburskii-cloud-desktop.rtlyha0sdvfehj3ppc5ptuaytc.xx.internal.cloudapp.net>
In-Reply-To: <Y2PzvhwbLzlq3WHm@skinsburskii-cloud-desktop.rtlyha0sdvfehj3ppc5ptuaytc.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f5908092-3c3a-4d43-8efe-c7e318ddab43;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-03T17:15:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CO1PR21MB1300:EE_
x-ms-office365-filtering-correlation-id: 90ca7a82-9be9-4cc0-229f-08dabdbfff2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hxefy9mjSA2oFLFsIn9e4Gs+X1UzyFo41IPokGYBJY3rkqm2fWIrBNhBv9qncxK1jJ/42Q7PYloCITqhqOZPCgUoc0Cax6BovQ1DTaQrkTj3/41ig8mD5eoxF2MJD3DkdMbrWn0EAkHxmILYCE69FpKJMDC3tqdnsqjI7pIpTg2rAkmUh1epkZsUqdi7xt/EAJ3R6GBRF+STAyEIdqzRQxBEKpg9zmmjnRW3ePkscE28RnjRJgqs0ihVhmu2BKsodQ8rNfuK2ff1/9rrlGxnMkmCE0SWld8p6DTz9mzVUOLJCM9LzCUg2fsBjokJBmcX/o/cj+L6EQSAeWA4THbql7cGu/1tXUsQ21Z6LbCMi54UWzoPk7uzL9LBKMJqEa5AoRDrRCMvpKSssfBxlwaXTl3nOx9ClZ7nb3/cdofPsEEDBVYa6FAIIn4wdMI5/RLHh6z7L48q5RvTES+5A2xKF8GnufwYOiS9Ll03CX7Xn3xPlLUhijsIHhqaKkvlR0Scj9zyjWWgsimw+5tNBajL3et5pKXO82JBV0RLshEwcKmio7zzEd+XRTpTZcewqwIfdoqgd2BBcx8gUMga3U3rDqF/HBGWrshP1xZ2ganrPI+k/yWe6nKucc7iH/Mx/qYn3pFVMYU7CB613s7p96sKDRYDBU8/Ol1q7rYPB0tHIwT0VOwu1NrOS09r+9TbKtBrtoAoG4DestEr9EE51fPkBioEy8yE2h3qYnhYrzKkoxs5p0QBWKHkSDOmOEV7syECJUryPfrOIAgvpyImLe50/4Vejo94PB6d7cQ0qedkCrCMchZPcZshYaXgd8RjU1di
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199015)(71200400001)(8990500004)(478600001)(2906002)(82960400001)(4326008)(7416002)(76116006)(66446008)(66476007)(64756008)(10290500003)(66556008)(66946007)(52536014)(5660300002)(8936002)(41300700001)(86362001)(38100700002)(122000001)(55016003)(6862004)(316002)(54906003)(33656002)(82950400001)(38070700005)(8676002)(66899015)(83380400001)(186003)(26005)(9686003)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gLJdjsR+hpay36+7oG9HPm5J1i4dt43uhBtyaeTWveGEiedaPr74VhfBlZpf?=
 =?us-ascii?Q?SuPW6UhG7tUgN4YvOYSn5+5Wlr7cYTvdKIeuHFIZjxfZ8dThcR3ZnBj42M0T?=
 =?us-ascii?Q?nDDPubtWQf+xYkymOYpaLldrMff0XQE5oUAs8PNtMvkH8xGGDUSGwrqxGpMh?=
 =?us-ascii?Q?5yl0IX060ZJ4zIkpJR1np24Gic4KVeCAxVpFFszi6Ws1lP5rlgd/1fp8f/dQ?=
 =?us-ascii?Q?gKBITvJugHedgP7+AXjq7EF8fDE4SPFqFG36hIcxPHRmYv3X+IkszCgAqz55?=
 =?us-ascii?Q?Cr1AoeuaIj63AvOreo//2NFOUmOklM03lcFFXP7v06IOQBdJMTay42k1tn0s?=
 =?us-ascii?Q?kQfsyQ/r5v7w/PqA+tpFETIpiReAuxiIDn62xBnlnWnIU2HO6FhbnGx8miLz?=
 =?us-ascii?Q?CoPtxi8WphpK3UpeS8FLrSeq+9v2WYqNI4apfwFcBD3xQvlwBSXRxAsJ1xJe?=
 =?us-ascii?Q?BiGGUFhpRoX/ZBtWyD5LM0iT/H0T8H/GLVVJTKOGDA9wGUFyh35PMk8fOyQC?=
 =?us-ascii?Q?3ajMM9y4acvNf0v3AwdjfFWKsNLdCijSKcNgbw2Lusq2MG+qjVKDUYIX8mSe?=
 =?us-ascii?Q?GZlwWdRN4GmesIHu4n+uAPVeqSWtIEFT8mJwqA3V6SL+RM58Yw6Z82SneJVO?=
 =?us-ascii?Q?n4oR57MKilRKx/klWtdKi0KlhSyu6w9j9mRAC115fg4mV1ijkai5pO235GAn?=
 =?us-ascii?Q?qyuhHp1zT0ssFnLMAZiTfvbKCJ/q1/1leQPvgO42ijYyiiwhtQONwvII3842?=
 =?us-ascii?Q?0ymh3nwUGvtnd4peavvCwLVSQwbz2xsUuJmNxZ6zJ+rLnNWuX7vmjNRy9ksk?=
 =?us-ascii?Q?IHVZP1n4vUWFoh/3suNy5vflIvrRsEp/5S6FB8LodKNnL2rnkKm/ja+APRBd?=
 =?us-ascii?Q?os6k5dMhmnCq7IFbclW8Y9JnBbGBcUEThyLoknZkpVGCuowyT99pwVW0vpzA?=
 =?us-ascii?Q?MQPcu22jKFBTU4xi9NlG1BgPnb99Z0iqLx9no3fMwpMw04DOFOjstb1yrvyP?=
 =?us-ascii?Q?N3z1/cZ+q/hFZtEuA4w2J331seeQZxYCgLhCm847Agh2jB7D9fm1G1PDT4kT?=
 =?us-ascii?Q?WKU2B4CBFRfUslrIJStffZA1UQ779jNpMTuZINzhZxnvfovXXGzpG/Z7O+Ll?=
 =?us-ascii?Q?MvTGPBDjRHyKAiFr4Sy4Ir6RfHim6SNu8yDs+6cJqMw1/pW12Mx+DpGsxmMX?=
 =?us-ascii?Q?vdInyhpTeaT0EelwpPRFey8Ge7Pmu2aAaxRbGj2RDLUDL29i60HPMguouRzI?=
 =?us-ascii?Q?NORWB9iJ/49unzimW43HW9hW+7mdmFA45X12UJAJXDAA6DhewN65/V+XOzeb?=
 =?us-ascii?Q?SujHvlVLg/S/w0XRmtdrF/lv0pY1LbYlUVAZNLwuQIDqAp67COwuMGaE0DCu?=
 =?us-ascii?Q?a+Ds8Plx3WD+bAt0XGo3rOXozP7ajr1f7AY9+X3a4AqyGQaDXyaWO7QNSNyX?=
 =?us-ascii?Q?xsWe6XCUd/dXEzQUvSM0XK3ShCkjqmMxaeJl0vOi1tNxCxNhwAwP7rdgwke6?=
 =?us-ascii?Q?tbqiX9RNNChSzkziWYfY9UCpLXG/rRWVGnabaTaKCnjROdx1/rJmLYAOX+I/?=
 =?us-ascii?Q?uXH8Yvu33rO3bYiVB78iZUoAJfHYFWZiXFnhLiVeQxcg07f2D7VmdrLPLwZa?=
 =?us-ascii?Q?kA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ca7a82-9be9-4cc0-229f-08dabdbfff2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 17:22:34.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uvW+/GYn06PJSTvbi6axRS0wIs1nmjEXvwDx6jWHMKrDu4gnl2r8xQb03oH/WeJjGiw0YXFh9JSLuKaevkNcyjwKyyX/RWf6lrTexockFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1300
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursd=
ay, November 3, 2022 10:01 AM
>=20
> O Wed, Nov 02, 2022 at 11:36:45PM +0000, Michael Kelley (LINUX) wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: We=
dnesday,
> November 2, 2022 3:08 PM
> > >
> > > Microsoft Hypervisor root partition has to map the TSC page specified
> > > by the hypervisor, instead of providing the page to the hypervisor li=
ke
> > > it's done in the guest partitions.
> > >
> > > However, it's too early to map the page when the clock is initialized=
, so, the
> > > actual mapping is happening later.
> > >
> > > Signed-off-by: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com=
>
> > > CC: "K. Y. Srinivasan" <kys@microsoft.com>
> > > CC: Haiyang Zhang <haiyangz@microsoft.com>
> > > CC: Wei Liu <wei.liu@kernel.org>
> > > CC: Dexuan Cui <decui@microsoft.com>
> > > CC: Thomas Gleixner <tglx@linutronix.de>
> > > CC: Ingo Molnar <mingo@redhat.com>
> > > CC: Borislav Petkov <bp@alien8.de>
> > > CC: Dave Hansen <dave.hansen@linux.intel.com>
> > > CC: x86@kernel.org
> > > CC: "H. Peter Anvin" <hpa@zytor.com>
> > > CC: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > CC: linux-hyperv@vger.kernel.org
> > > CC: linux-kernel@vger.kernel.org
> > > ---
> > >  arch/x86/hyperv/hv_init.c          |    2 ++
> > >  drivers/clocksource/hyperv_timer.c |   37 ++++++++++++++++++++++++++=
+------
> ---
> > >  include/clocksource/hyperv_timer.h |    1 +
> > >  3 files changed, 31 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > > index f49bc3ec76e6..89954490af93 100644
> > > --- a/arch/x86/hyperv/hv_init.c
> > > +++ b/arch/x86/hyperv/hv_init.c
> > > @@ -464,6 +464,8 @@ void __init hyperv_init(void)
> > >  		BUG_ON(!src);
> > >  		memcpy_to_page(pg, 0, src, HV_HYP_PAGE_SIZE);
> > >  		memunmap(src);
> > > +
> > > +		hv_remap_tsc_clocksource();
> > >  	} else {
> > >  		hypercall_msr.guest_physical_address =3D
> > > vmalloc_to_pfn(hv_hypercall_pg);
> > >  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > > diff --git a/drivers/clocksource/hyperv_timer.c
> b/drivers/clocksource/hyperv_timer.c
> > > index 635c14c1e3bf..ec76303b2a76 100644
> > > --- a/drivers/clocksource/hyperv_timer.c
> > > +++ b/drivers/clocksource/hyperv_timer.c
> > > @@ -508,9 +508,6 @@ static bool __init hv_init_tsc_clocksource(void)
> > >  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
> > >  		return false;
> > >
> > > -	if (hv_root_partition)
> > > -		return false;
> > > -
> > >  	/*
> > >  	 * If Hyper-V offers TSC_INVARIANT, then the virtualized TSC correc=
tly
> > >  	 * handles frequency and offset changes due to live migration,
> > > @@ -528,16 +525,22 @@ static bool __init hv_init_tsc_clocksource(void=
)
> > >  	}
> > >
> > >  	hv_read_reference_counter =3D read_hv_clock_tsc;
> > > -	tsc_pfn =3D __phys_to_pfn(virt_to_phys(tsc_page));
> > >
> > >  	/*
> > > -	 * The Hyper-V TLFS specifies to preserve the value of reserved
> > > -	 * bits in registers. So read the existing value, preserve the
> > > -	 * low order 12 bits, and add in the guest physical address
> > > -	 * (which already has at least the low 12 bits set to zero since
> > > -	 * it is page aligned). Also set the "enable" bit, which is bit 0.
> > > +	 * TSC page mapping works differently in root and guest partitions.
> > > +	 * - In guest partition the guest PFN has to be passed to the
> > > +	 *   hypervisor.
> > > +	 * - In root partition it's other way around: it has to map the PFN
> > > +	 *   provided by the hypervisor.
> > > +	 *   But it can't be mapped right here as it's too early and MMU is=
n't
> > > +	 *   ready yet. So, we only set the enable bit here and will remap =
the
> > > +	 *   page later in hv_remap_tsc_clocksource().
> > >  	 */
> > >  	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > > +	if (hv_root_partition)
> > > +		tsc_pfn =3D tsc_msr.pfn;
> > > +	else
> > > +		tsc_pfn =3D __phys_to_pfn(virt_to_phys(tsc_page));
> >
> > Same problem here with setting tsc_pfn to a guest PFN, which may be
> > Different from what Hyper-V is expecting as a PFN two lines below.  I k=
now
> > the above line was just carried over from Anirudh's previous patch set,
> > but I was thinking you would fix this issue. :-)
> >
>=20
> Fair call. I guess Anirudh has addressed it himself, so I'm going to
> rebase on his fix.

Sounds good.

>=20
> > >  	tsc_msr.enable =3D 1;
> > >  	tsc_msr.pfn =3D tsc_pfn;
> > >  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> > > @@ -572,3 +575,19 @@ void __init hv_init_clocksource(void)
> > >  	hv_sched_clock_offset =3D hv_read_reference_counter();
> > >  	hv_setup_sched_clock(read_hv_sched_clock_msr);
> > >  }
> > > +
> > > +void __init hv_remap_tsc_clocksource(void)
> > > +{
> > > +	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
> > > +		return;
> > > +
> > > +	if (!hv_root_partition) {
> > > +		WARN(1, "%s: attempt to remap TSC page in guest partition\n",
> > > +		     __func__);
> > > +		return;
> > > +	}
> > > +
> > > +	tsc_page =3D memremap(__pfn_to_phys(tsc_pfn), sizeof(tsc_pg), MEMRE=
MAP_WB);
> >
> > Note that use of __pfn_to_phys() is at risk of being wrong depending on=
 whether
> > you decide to keep a guest PFN or a Hyper-V PFN in tsc_pfn.
> >
>=20
> It's Hyperv-V PFN that is stored in the variable (to match the MSR value =
for the root
> partition).  I guess this approach will workd regardless of the guest pag=
e size.

I agree that it's best for tsc_pfn to contain a Hyper-V PFN.  But if that's=
 the case,
the above use of __pfn_to_phys() won't work since it is expecting a guest P=
FN
as input.

Michael
