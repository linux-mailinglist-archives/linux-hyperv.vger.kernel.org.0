Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A3C62CDBD
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Nov 2022 23:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiKPWek (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Nov 2022 17:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiKPWej (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Nov 2022 17:34:39 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11020026.outbound.protection.outlook.com [52.101.51.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230C36AEF8;
        Wed, 16 Nov 2022 14:34:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnKAmap91bQW3ALlfrAQaa1Ajyi0y+MQCSkF6pt23zMjlPvAhs+2hCfLSXnKZE2vusYOZRYbfaA1Jogv3JNDs42Qr5rtk9sWWFdaA7mCKATOwnQbRK3zZwSrwOcTmRN0JnEak2bAUwm+G206VDahzM7rIFR9xKhHg/6vee0V47cNtn+xf/VgIWlMzvLApPsbq4RboUc3aQeyN5i56g3IpQkHBF3NNnH9U2IHi2mOqNHgbAJt0K9sp7zRRwnPDJS0TooqfG1I4J/s0AWdGCIoXqRNAaMIXIn8qsjSQGXfCCbMxfV6vz4teEPUDzR8Y9zlrFqVShTjPkLVqtYTQOB2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAHExWAsa0z3nm2QJe34qB8gpF/fvvINvL9QxEFi5m4=;
 b=NuJ0i4X79+vyGHwFngiGLbzYDFa9XCYFy1rQGnHyQqMK4D51HT+6+lrYqVQyG5JwvYpG8wuldu+lAzcCEpelvMbmBnXvhMoKCBqj8w3JhoI9eX6DnItKkvBI/SFyjQjWEwdOrIaf5WhuTrZtfIpPNBM5aLWfpKIobpeRIJcuYgxk4nch7C4cCh2w/pbkU9MX89azFj44dzTi1lGAKvhJ0xyXy1SySnKKqnwXt3lkL/9uTHAHPaPF2Dj3z2e8f2syAymhwiUzFRPJUuyEfLcs7bFk8D8NYitqEEo9hkvYmRTupH2twG2OyN3Ha9ZueKgalJ+sFZFkKRFUO0tJc9mn/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAHExWAsa0z3nm2QJe34qB8gpF/fvvINvL9QxEFi5m4=;
 b=MEWGChAhPBVWH2WV5D6Vf4Xof5X6K5eIZGReHG0x1ecv/fZ6h21A+WbFZi1IM8vITn9tEpvZtfa+OMziEPEWxQ6PxkNt5m9NwUwhmGgIMifYT4apegfguKEzKxAKpmCdmUXheQL31b4ghBQQRmwLZEfm3bcL3kcHHaWcseYbTSw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3250.namprd21.prod.outlook.com (2603:10b6:8:6a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.5; Wed, 16 Nov
 2022 22:34:35 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%7]) with mapi id 15.20.5857.005; Wed, 16 Nov 2022
 22:34:35 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: RE: [PATCH] clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h
 not asm/mshyperv.h
Thread-Topic: [PATCH] clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h
 not asm/mshyperv.h
Thread-Index: AQHY9slnwdraMHlbf0CZaajLWUgExq470lCAgADKxQCAAAv9gIAAAiEAgACy84CABK7xAIAAG2ew
Date:   Wed, 16 Nov 2022 22:34:35 +0000
Message-ID: <BYAPR21MB1688424DD14B46712F2992E9D7079@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <87zgcwt2qg.ffs@tglx>
 <BYAPR21MB1688C5BCDF3269BA070DB884D7039@BYAPR21MB1688.namprd21.prod.outlook.com>
 <87wn7ztc89.ffs@tglx> <87sfinta8q.ffs@tglx> <87leoft9w1.ffs@tglx>
 <87fsemtut0.ffs@tglx> <8735aipqph.ffs@tglx>
In-Reply-To: <8735aipqph.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a067fa68-4f60-4cf8-bf17-fbb0ebbdbb96;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-16T22:30:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3250:EE_
x-ms-office365-filtering-correlation-id: 6623a7ba-f215-4e58-d71b-08dac822bd51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ErUrjGDLRoy0Lt/K/CB/5TtzlDjBRZ2Eq1gAQXbWl5kbbnwWy9fC2F0rtA5qahjQ7os3IQpQNvHFI3lgZibGMmLtLdicMu1LOLKDvtglGZ3enWSvA3pVTnz7TQQxxQQfYBpOr2T3MKNG/ChaYDQhS73MUR70YB/P2F82lkPI5JHOJ+USL1OLaWYqcjG9LUwwMSWjiyfGyQdkhRn0jKr+JjNThatOLKIQHLMgIpow6+soUbrYupGYD1q04xFU0c/21AHwym1pGZsQ5Fqe+k6+8TP+MRMWHpuwi5ATowrZreAyN6GGlyVzBezsQguBYqzgUPUxPHiwpzwMFiQPFt5IvHNiraWz4nj0rtZKIsZaYyLKNcxPpIqZKB025lUaNis+N95R5+TUFWth6YbgQ+XjFMkb5b1IILwJSzc55qAhFVGb6bhW+D2PDyjRyMGQapEV8utDZbxPMsklz6imUrBaKJoIOumjFlIAB6y3x9Xw1hR0byUYzpkEsaKc+dGRFm3V32RriKg1MNeX2IzxIbaZEVlvXm3wQSvEpBFdHR9mYf/UWmG9QpeEy/Px0iSdMINNwEAjy91RpiI1CjnsrU95h8X5UkUW+mw88sxnfQYPXo6XwkmBlbjfNUolKjxlWH9RstCsI+nVx9Lpmk8VJFvOVVAaSNv0oMmZCGZ3CO/kw9QYpCkyCGgcVF5ZHlyzicvmvPU8DhFQd1fwmvqT1fnszO9Hz36EDE8mzNOL/Tu1ENCZmg297V0GRet4htfokTkLPf48e2YJLj+qYYTsyESJ5C/mvB1nOQ+B/8+rsa99RQ+5FLFz30io0/5wxSg5uziJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199015)(52536014)(8676002)(4326008)(5660300002)(66946007)(66556008)(186003)(64756008)(2906002)(41300700001)(66446008)(82960400001)(316002)(66476007)(76116006)(8936002)(55016003)(26005)(9686003)(122000001)(38100700002)(8990500004)(33656002)(83380400001)(82950400001)(38070700005)(10290500003)(71200400001)(478600001)(86362001)(6506007)(7696005)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/DXIHV3+FH1RZ0pOouKIsa/vTUvKRdF7TUaycd1SAc2v9sgN9RZ9yf1Yh/wk?=
 =?us-ascii?Q?QN644LYJdZz9s6RAYGevgoIJn2jSVvVuKuP5YPvJmBu3iin1kOAyTeigd6Ib?=
 =?us-ascii?Q?BORPC76dBfPpQ9SLQWxxEf65OZL55zW5aOH0in5JYMbEHD7H1MJmHxoJK8mL?=
 =?us-ascii?Q?YmcWSZFW3H6/eysLL5NiDBGS4QX/gGfYY9hYGQjJUKgnfY6E/gSXmykfVDMA?=
 =?us-ascii?Q?VnoBrCUxjSslZK4UsovlM3Yk4sud+XAEbc0MpisJVR4kYD3Q1WhmlmUT3Z6s?=
 =?us-ascii?Q?UBFx8MSB77McWsAjIbRRrtU9eyNO3AR8KYfA3tQrN5Oky2OPqH3foSt6XPca?=
 =?us-ascii?Q?/rF164LPPVCYCm6SDDAHEK0XK51wPgbCTtQNIVOigvUe29eatm7l7EiKLhvD?=
 =?us-ascii?Q?R/pxs0TTT/MroXEuWV+UaZ7PXZ7/1jtN5zOYy049HdBD27vbXOCtvY6CNHla?=
 =?us-ascii?Q?EmmAW/YN8so9bzH3gj5STF0PkK6k9i5RATGCEOcOkzBHiKZc4LMuZIkuqrV7?=
 =?us-ascii?Q?7pHRSuvD9/x5TXfgNjsj9+NWJj4rUeTxMGZU8lE/lP5k4fB/lKeLk3/4yyAd?=
 =?us-ascii?Q?NqYHRAR0+RQ/16kcGVtYSpXDdXPn+/K4ep1WF5nGg4vMHKJ94eqs3f4yUpca?=
 =?us-ascii?Q?U0jBCKUCGeSBTlrG++avvhjcxY2dF364s91vJ89XF+LtNuAl4K6fU0Uf7wyn?=
 =?us-ascii?Q?fW7tYKVd3XFd1A8aWVy4HUGkv6ojKOZm/EDdmP0qHgUIXXai1xHS8ZN0THm8?=
 =?us-ascii?Q?KFFzAFNrFvM0WpxIg9vzXgqsyUuF7IT6KqXlBs0hgn0NtkDUEFW5nHGXcACt?=
 =?us-ascii?Q?g7skhZTbKXe5O1tJWB2DRcNkFbMDKP2LNmkoPfsiA+XyAg7leXLsNvwPOJLI?=
 =?us-ascii?Q?Bd/stqu14gJPzbQ9j7nSc16bTjCyhFeltjHU6fQn4Y6EjbsgmhigG/zbO6K/?=
 =?us-ascii?Q?QNgcYTOA40HPdDVhdxwnk/rA9HoTlU01NKtqb+wKmUCKvhvGGNuTXL3yX3ph?=
 =?us-ascii?Q?A1Y4lHnsBHBpQ4Fil66p9RqxRy6suEH+UFtlX1E8KXZFhPX6Yae2vXiJZBV7?=
 =?us-ascii?Q?tx6OO+sUqZC0cE0mNvWcxqnlmskZviheczsHQYe+FaImw7Y0OjLu2QurlDLI?=
 =?us-ascii?Q?HTu0DZh3dhx0RiDwW6KpZXbFKAOMuSEIXdGVl7AuMGwvBNQHusKFs4knBos1?=
 =?us-ascii?Q?6Mv9uVienF/G6eVfous+iQ/1MKrXqVEIhYZuPHysF/5/bvBy001eqkaq247U?=
 =?us-ascii?Q?B/y1M2fgHdnhL7jfgnFW2DPOmi/qLFF7/jgp+b3n7UJWKUDBIvDlgKJ3OeN0?=
 =?us-ascii?Q?KcN/Rna/0JyjAdD0I0VwXd6d4729Vx2QQmRy6hsezT0jC2/hV5ytFPTk5PKh?=
 =?us-ascii?Q?beG4vPKAnUzb/p66LibcYszUtkcT16v1DHka8MEQ6rzJYGciqWcYPPfBgsTP?=
 =?us-ascii?Q?oGkROKn/+dQBM/g9mZmLh9hQ1kSUxns1sx11SceJRz9ccuhFRfZYm+akdQOx?=
 =?us-ascii?Q?y1tvdkrnrWBSlRFnX+M1U1/yVmFp9pci2WLi38Co4VzCwAUjM9fOz2dvEJd9?=
 =?us-ascii?Q?Tjmz5YVoPak9R7fMFR0soHcjU6W93dsYNyAb46bBSYINp+Qkt3WYMr8X7ovi?=
 =?us-ascii?Q?yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6623a7ba-f215-4e58-d71b-08dac822bd51
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 22:34:35.6734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOKauN9uAWYfJzRkSTGfUpCei9wbtOoXOvzFKUvbRzAv84AKKdWYGohHoJ42A79U0heloWGxTCP3oG8Cfwey3+nuMqiyvNzpoh9PHyNUB/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3250
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Wednesday, November 16, 20=
22 12:52 PM
>
> Michael!
>=20
> On Sun, Nov 13 2022 at 22:21, Thomas Gleixner wrote:
> > Subject: clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h not
> asm/mshyperv.h
> > From: Thomas Gleixner <tglx@linutronix.de>
> > Date: Sat, 12 Nov 2022 19:08:15 +0100
> >
> > clocksource/hyperv_timer.h is included into the VDSO build. It includes
> > asm/mshyperv.h which in turn includes the world and some more. This wor=
ked
> > so far by chance, but any subtle change in the include chain results in=
 a
> > build breakage because VDSO builds are building user space libraries.
> >
> > Include asm/hyperv-tlfs.h instead which contains everything what the VD=
SO
> > build needs and move the hv_get_raw_timer() define into the header file=
.
> >
> > Fixup drivers/hv/vmbus_drv.c which relies on the indirect include of
> > asm/mshyperv.h.
>=20
> Any comments on this latest version?

Sorry.  This looks good to me.  Maybe the commit message needs a
bit of tweaking -- it's not clear what "move hv_get_raw_timer()
define into the header file" exactly refers to.  But otherwise,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

>=20
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/x86/include/asm/hyperv_timer.h |    9 +++++++++
> >  arch/x86/include/asm/mshyperv.h     |    2 --
> >  drivers/hv/vmbus_drv.c              |    1 +
> >  include/clocksource/hyperv_timer.h  |    4 +++-
> >  4 files changed, 13 insertions(+), 3 deletions(-)
> >
> > --- /dev/null
> > +++ b/arch/x86/include/asm/hyperv_timer.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_X86_HYPERV_TIMER_H
> > +#define _ASM_X86_HYPERV_TIMER_H
> > +
> > +#include <asm/msr.h>
> > +
> > +#define hv_get_raw_timer() rdtsc_ordered()
> > +
> > +#endif
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -19,8 +19,6 @@ typedef int (*hyperv_fill_flush_list_fun
> >  		struct hv_guest_mapping_flush_list *flush,
> >  		void *data);
> >
> > -#define hv_get_raw_timer() rdtsc_ordered()
> > -
> >  void hyperv_vector_handler(struct pt_regs *regs);
> >
> >  #if IS_ENABLED(CONFIG_HYPERV)
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/dma-map-ops.h>
> >  #include <linux/pci.h>
> >  #include <clocksource/hyperv_timer.h>
> > +#include <asm/mshyperv.h>
> >  #include "hyperv_vmbus.h"
> >
> >  struct vmbus_dynid {
> > --- a/include/clocksource/hyperv_timer.h
> > +++ b/include/clocksource/hyperv_timer.h
> > @@ -15,13 +15,15 @@
> >
> >  #include <linux/clocksource.h>
> >  #include <linux/math64.h>
> > -#include <asm/mshyperv.h>
> > +#include <asm/hyperv-tlfs.h>
> >
> >  #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
> >  #define HV_MIN_DELTA_TICKS 1
> >
> >  #ifdef CONFIG_HYPERV_TIMER
> >
> > +#include <asm/hyperv_timer.h>
> > +
> >  /* Routines called by the VMbus driver */
> >  extern int hv_stimer_alloc(bool have_percpu_irqs);
> >  extern int hv_stimer_cleanup(unsigned int cpu);
