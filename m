Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A22E626C1A
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Nov 2022 22:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiKLV4D (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 12 Nov 2022 16:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiKLV4C (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 12 Nov 2022 16:56:02 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11021016.outbound.protection.outlook.com [40.93.199.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084112DC0;
        Sat, 12 Nov 2022 13:56:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKalHjDRC2apW6O5tTyUVL+qSxx1NfE3NiVlPy9dHsxfVEWAPYx8gkAc98px75BLrqqvSWTW9PGtp3+/I5Kx1YF3h75PI2gy6FY9saY1siYadFPMHxZSUFGBRz+k9Sk9/zqRfXQ2oUt+djW0rhxFBO9bP0mA+wKGYd+QDLsBeCLo5aDLx/i9pgCmvCuMhAhKGaOW+FtBYcLXIrW1jFDEvUrTBF5SjxwGf9A6HG7rPAUWuafEr34VFvRJkbvq/QKQKkJS2ppGMAmXs7U9zuLrfE07FaEqIPuZoyC6KmITUgYx6noGng0lxYD/Q97A06HSVRj/EuhvrbGK++3HfNVEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0mmsa4yrdnWseS2L4/fatNNcOAB2UZU58AmAx8G+8U=;
 b=D3snpsVuwkqugsGTyvITzFW73nSe11OS3xCsmYGNZKo5x6BrUeWUlOtSQEA2m/amG3pRRDve+HevEmdMJh2cHv+dnKehtX+5wPLzWYDNdfc5UlJ48UyRVYBV6FKbVug3TZOmX8+iR5PJc0/+/mL01yW2aoGS9Qd8lCogHrSzxmihODC5PhgGypeL799uSdtenYEnJo3WVTipk9wAB6jxGjbFsno9XydZCmA9fdneW2973xlGPMb8jeg6KkYBZZ2VGyAUHnG+b/3W/O8MhwL0TS3lhQYhuHMGM/jUKXMnmyehsgGA5evby9qGgkH0TvjkbGuUtE7RRr2hLzpejkLugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0mmsa4yrdnWseS2L4/fatNNcOAB2UZU58AmAx8G+8U=;
 b=QVLQ0j/EBs5l8rMdL6htXWnMH9PQrUtgAxjfsctzlOwI3znlon4yYBSxJew7mQdC2IHdKLt8rroLVp565h6ksR66GrYpCgws6aNSTHm5kk2XZPn79EBejAX/N9Pmv/zE/YhMIWKfPNzH+CFCi7t48QtNeHWy9XxZPxwyG2kmbBo=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3660.namprd21.prod.outlook.com (2603:10b6:930:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.6; Sat, 12 Nov
 2022 21:55:57 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::6468:9200:b217:b5b7]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::6468:9200:b217:b5b7%3]) with mapi id 15.20.5834.006; Sat, 12 Nov 2022
 21:55:56 +0000
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
Thread-Index: AQHY9slnwdraMHlbf0CZaajLWUgExq470lCA
Date:   Sat, 12 Nov 2022 21:55:56 +0000
Message-ID: <BYAPR21MB1688C5BCDF3269BA070DB884D7039@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <87zgcwt2qg.ffs@tglx>
In-Reply-To: <87zgcwt2qg.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0035cf30-9e58-4554-85df-8f9795b5835a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-12T21:44:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3660:EE_
x-ms-office365-filtering-correlation-id: c0c63e6e-6970-448c-f0c8-08dac4f8ad49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YcphV8B1WYS1MMzSZkJqSncbpSVy3V1eBx5qNTzaHAzZS6gqIJFPnuhyKI57I13EFgVObr51bxsASl9Ko9cub33jZY9cgV+G/QNu8lPR65fjbCRIhR7bkeCIV2dIGiQMgtGmrqs/bIb70GyFOJUPwHuj+baXf86TwYiVrG/A1tciujcqZx9fnuXjM98W+wp4GLgU9Tptjy/y1Z/JQSesdCIf9e6F837jdK5pydnTjjINW63NSpTS3FQVUtOyZuo6f3Fb4yXXpXGALyDwXcr81g6RA/cNu+1gf0HGfBUP9dwQMjzZbo8rVC1oRyRgA30GhVcdhoZV27onUgpAmsjmJvnxLbDQZFGRq87CYv6HjR7DNQ2ufbml3fGxF1ry5ZljBVOMr4VlAE1M/Pz0vnE+GNUF9ynb+Qwlo+9Dli1L5ZWYknXoruMovfUqtFGiFbVFREQ8UlhjWaE4VNdhRcWWPJiskc+ubeykueeHY/37n8C2klBdwLdzK8cjLiMbOycd5COgxQ6YxsLb2Rr9N5DdLtNwPtrri6NFZd23Oga7JPIOGSksPkIdAM/mZ/ARg7n6qBmFEcVGqOymHtEuUjPPtE9I+6GJcJhi8vUM/99wx3eXgJouQ85ho6DP5jkCdHIk5YElNTw2nj5yOzssfg8wQ0bcltjUCYH5LJ1ZfWaX4FjEu5MK3fuS8v/7OA7q1XkHvKoS6REIwd+e0f2T0uo+58zf/Ffh3nTCm65drEeRNUpoXlRazyFhiiOYUuOUlfsh8wqYu1XOspDksGdC+/MaY8pT9dhmgOXXt9JUwJ90EiZs6C3ZjLdKRLtwd6LqQlNX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(8676002)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(4326008)(316002)(110136005)(54906003)(186003)(66899015)(2906002)(82960400001)(82950400001)(33656002)(10290500003)(71200400001)(8936002)(52536014)(478600001)(41300700001)(5660300002)(86362001)(8990500004)(55016003)(7696005)(6506007)(9686003)(26005)(38070700005)(38100700002)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NQM0bRYkWstICudk8oKdhX+o3ag4XJBHNyqrDR/ZoCTKu9mD+VfrTA0U6iFJ?=
 =?us-ascii?Q?6z88t6dmGKscXAO8iOs/cECBxZnDVuD4koQGHH8UO/4R9CpmpgGVz5T+Qi+S?=
 =?us-ascii?Q?JPsvmI1cdgxQ9b19K0VKej4HOIStFndA4adu0KLG/Yyfv1fw+MjerVcKtxoN?=
 =?us-ascii?Q?vlr0JxbQvB/mqHoN1S27f5t/CHIgtuVzTvAjKHUTLFNikU+QX4zJnqSv4kUx?=
 =?us-ascii?Q?1PNLWh9gNhbhf1d1YBSlRBsCtYeY5jjB/sd2q1cNUGCPeKd+RgdPYzcXTXYv?=
 =?us-ascii?Q?W+W8IHWdYT9qRlNumZmRz90HI1v07kMMxfW0mJnDIL0kky6AuGl6ngSTqtPg?=
 =?us-ascii?Q?xlLn4lkT24tkXM578cjm8y7eV5UrZX6rO4nUKaXKk9FpQy6FNXWI3YrjfykA?=
 =?us-ascii?Q?/0F9XU8wUO9GueOVarojNfmwwkxlxZbK/EKafPWh41kDul8RIK9MeLq0oOIl?=
 =?us-ascii?Q?7Mngpk3r9x+yM/XLUhH3D4K8KdP9VcGlRWnLK+gBmDN22BuN9jyhuOD3Tz/J?=
 =?us-ascii?Q?g7wwCFiiRPwO5ZD8uE44aAVJ+bYmAv5jDXUoYx7fRyD+Lw/VwWY6lrcK+n+q?=
 =?us-ascii?Q?YmVYEf3lC36pqbz31htVW4pArzGp+8A5yAicCdLaJ5QF1pRcMk86krZ3/OmN?=
 =?us-ascii?Q?V5mvWKvy966kZY7xtKOppNMuRwuiJ3dyu2/TCXxEXKRqdJrwu7ywwFT+Bkq2?=
 =?us-ascii?Q?aWsoIwh/wiDohqFCZHxSwfFzF0/rL7m8SoOTbCLh7wT3M8THaAjnSj0exEPE?=
 =?us-ascii?Q?P0R4dR4AqXDph1D9KVjkZw04+lz6NRkdTdIaSlnwisphviSOQLzAzMiz3TIY?=
 =?us-ascii?Q?ZjD1U6skXz3JB/pWoZT7TgY1kfsVu77DZEXPEvTlmKmkfZWpdonazBq0KNuk?=
 =?us-ascii?Q?WfuZIsD3vsNnnSaQwCnK8yk1ldPWWgk9dTUnvtF9R/P1xOYIh0l05F1EePF1?=
 =?us-ascii?Q?fdaUSIb1nMIZujGqz7PqhWgriDYdLPff/wOwbuhLV4eTGw/gkR2XOtYhfZH3?=
 =?us-ascii?Q?CVjby/6EqFyBBcLLq2GqJ7Rm6l8o3T22X6UJdq4bpYSkfJoJ8SoNPOXR2zyV?=
 =?us-ascii?Q?w1Iiby+xohFp0oBbS6YTHyMdW60hpwaRy27L88libX/E/xYKeL1bAuG/nIh9?=
 =?us-ascii?Q?Zfg+X+C8N7R0/Gdmq0/p9Y/R08479/sZodYxwYbNs4yDfxza4syl5rKOlP5x?=
 =?us-ascii?Q?e2MyPXTOA3+JMS+Ven6JJOe64X0eTaOxhWu7maPtcAFChw+Y0mM90m3+ak6Z?=
 =?us-ascii?Q?iJoh99OBpF75mHkX/o380IyiVU70QJROBucA07H1qIMEKBm2+wBHl0Xgts5L?=
 =?us-ascii?Q?ADMu1q7cxn0EnYR2GxjcJwptSjEQEGiA0uEwY8ZONdP4ege1v7HbcGT87yQ8?=
 =?us-ascii?Q?Rl8pyyOiV0xRvYvX/lWekOPfb6bW87WHp9p0o4MKuYosPbo/la2w+P55Mrhb?=
 =?us-ascii?Q?VBI6Zykv1ih1wFVT6SpRsBPdQp7FfFh0nGNha2HbwxSPCXWStyupSb4SzxR1?=
 =?us-ascii?Q?/ILXhzB49sJ4nDH8gI9NKwUSpnuEbtHvJu0dZCVxYLZMmt5RnUd5MWM74IyN?=
 =?us-ascii?Q?cuQI8chR4ozc9Hhm+8hNHpxS47Z1Kd8f8Vr5ZROwHLAaWaIK9wrP+CrfHjXX?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c63e6e-6970-448c-f0c8-08dac4f8ad49
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2022 21:55:56.4115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2zfAIXhZeVeGVMiaDZeRR1hkX3SSkWlRiyI9HMT2OwIJAnXzZP9tOPQbQd8ZIahIqKdR1TwocFDedQTKvLAyDwKJGtA2qricwEy8uBDYt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3660
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Saturday, November 12, 202=
2 11:03 AM
>=20
> clocksource/hyperv_timer.h is included into the VDSO build. It includes
> asm/mshyperv.h which in turn includes the world and some more.
>=20
> This worked so far by chance, but any subtle change in the include chain
> results in a build breakage because VDSO builds are building user space
> libraries.
>=20
> Include asm/hyperv-tlfs.h instead which contains everything what the VDSO
> build needs and move the hv_get_raw_timer() define into the header file.

We've been keeping x86-isms out of hyperv_timer.c and hyperv_timer.h so
that they are architecture independent.  That's why the #define for
hv_get_raw_timer() is in an x86-specific include file.

But I can see the problem with too much getting dragged into the VDSO
builds.  If hv_get_raw_timer() is added to hyperv_timer.h, it should
be under #ifdef CONFIG_X86.  Adding an #ifdef isn't ideal, and a more
more proper solution might be to have a separate hyperv_timer.h include
file under arch/x86/include/asm.  But the latter seems like overkill for ju=
st
hv_get_raw_timer(), so I'm OK with the #ifdef.

Or does someone have a better idea?

Michael

>=20
> Fixup drivers/hv/vmbus_drv.c which relies on the indirect include of
> asm/mshyperv.h.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/mshyperv.h    |    2 --
>  drivers/hv/vmbus_drv.c             |    1 +
>  include/clocksource/hyperv_timer.h |    4 +++-
>  3 files changed, 4 insertions(+), 3 deletions(-)
>=20
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -19,8 +19,6 @@ typedef int (*hyperv_fill_flush_list_fun
>  		struct hv_guest_mapping_flush_list *flush,
>  		void *data);
>=20
> -#define hv_get_raw_timer() rdtsc_ordered()
> -
>  void hyperv_vector_handler(struct pt_regs *regs);
>=20
>  #if IS_ENABLED(CONFIG_HYPERV)
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -37,6 +37,7 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/pci.h>
>  #include <clocksource/hyperv_timer.h>
> +#include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
>=20
>  struct vmbus_dynid {
> --- a/include/clocksource/hyperv_timer.h
> +++ b/include/clocksource/hyperv_timer.h
> @@ -15,7 +15,7 @@
>=20
>  #include <linux/clocksource.h>
>  #include <linux/math64.h>
> -#include <asm/mshyperv.h>
> +#include <asm/hyperv-tlfs.h>
>=20
>  #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
>  #define HV_MIN_DELTA_TICKS 1
> @@ -34,6 +34,8 @@ extern void hv_init_clocksource(void);
>=20
>  extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
>=20
> +#define hv_get_raw_timer() rdtsc_ordered()
> +
>  static inline notrace u64
>  hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cur_t=
sc)
>  {
