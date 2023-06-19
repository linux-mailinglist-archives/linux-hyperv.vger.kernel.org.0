Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24E4735C63
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jun 2023 18:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjFSQpf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Jun 2023 12:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjFSQo7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jun 2023 12:44:59 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020027.outbound.protection.outlook.com [52.101.61.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AADE73;
        Mon, 19 Jun 2023 09:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afLOZ8k4GCQY48ISTD3KaqSDuBM5HeeD5PoMgMGnRKPbgNyQh5YE9sgMlilRaBChezHOxoCP2lS2VCCjNmmunBKJhK2QKDKDvleac4V7Nowc+D52JNudSknGlVL/JchZaC6vO/5zCAO9w8d0YSIhq2aLsYpbhTHbrp3SKlyAycjlAhgc6vkMuo7wEJAGEP8k2V4kgQwjB3ehlsRAPi6yymW+rnnEkOFX7D2ER13fcCTxoC9a39km1jmC6UMyzIb50BPqiHK9ycKfqNioR0c260ZTgvl2Q0vaKjpem3OVZSsypXxYkjCv3rYEZjr6f+dFUsz0Rp23OFHftjyneGgeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AinLXsvSInbrtCh06i8mXrUB0P2VfkjlXsg+AxJz4c4=;
 b=cAuCAdJEZxpMI5KMQL4PrY4x67uwqe3/hnRc81I4305sPhvoZhNF7tsGVKibvb55Wk9q6uKApyB6KCgG1cpzkKYMErxaEeDPVI/o8HqI2TFIb6DOa5tIGcgV9FONeIeYDS5td0yaWzuABkw88ybzAkqgPlf62hjfZ/klO3nHHLvXiShZeMRDdZu7E+blSgOtpR3gny+aCJSrAE5JbQSu1CgLpT2qX7fo2SgfJdssI7QkFhPfJanz4v0egEAZOUCdocVxQA3BUaCF7SUy3/MU41nJL8GxusKT2wimAG/M7pReOqqFpSCWWVjPd96sUp/Qt/urx9Y2fOwt+FtF333wuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AinLXsvSInbrtCh06i8mXrUB0P2VfkjlXsg+AxJz4c4=;
 b=jY6484zlKHGBPZ+oYFUypnRBJCbfO7bGquRWxBRsFNBlUNRwdP1GvKMw/Aph0AP2YSO3GcpSNQs34nhFbwhM2rEUYFSzYby4bevj0GzS9eeiL2z5OIkCdTT+GCCrXScNKI+RS2diuJlbaNDRrHZQw2JGsuECgq5RaDkO5rjpHYc=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB3877.namprd21.prod.outlook.com (2603:10b6:510:241::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.14; Mon, 19 Jun
 2023 16:44:47 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6544.002; Mon, 19 Jun 2023
 16:44:47 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] clocksource: hyper-v: Rework clocksource and sched
 clock setup
Thread-Topic: [PATCH 1/1] clocksource: hyper-v: Rework clocksource and sched
 clock setup
Thread-Index: AQHZmunMRY0uWgs/g0+c1NT6w1jjM6+SXPaAgAAFcRA=
Date:   Mon, 19 Jun 2023 16:44:47 +0000
Message-ID: <BYAPR21MB1688E1163BB36DF03CC8E00BD75FA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1686325621-16382-1-git-send-email-mikelley@microsoft.com>
 <fdc643c4-6298-d337-1d8d-3f28f6c1acfc@linaro.org>
In-Reply-To: <fdc643c4-6298-d337-1d8d-3f28f6c1acfc@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ab8c7f20-2eb6-4bbd-9b62-a144511f8c50;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-19T16:35:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB3877:EE_
x-ms-office365-filtering-correlation-id: 4db1af26-e2ff-414d-8341-08db70e47e2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wAsEajaeqZ4crgjk2Rkp5Usl/LgzxurDDKJtsYeOuW7wgCE3EMGKi+KyMSp9lmvFMHZTmxsLCJYbDE8BQiDoTza7KATbogjjiMeGHB4r0411V+D+UUMmfBrNgEQBzdoMKV4tuML6ZYGMHg5xFvWx3nHvW30GdgLIKl/3A2nYeVnWewC5R6s06c9dFSDH2hh6BHIsA89MkLOzqfq58id2SLdSDgExqwjSoLzY+B2EI5Ykt0KXFFDF2sxiF7YKx8u/OaP0AYr4XkD3G5fd3X0SdoiiAzf40Khwm/Z6RfBtFwVG8r0K6qCmk5xMuySSVyKs86SGl8C25QnY4mfhkFqlFbzGlFBkFJQKEw+UOlbP/NROKqsKF1pH08K5dvsK/wD20n8Ivo1uzQ7US8uVsfKcbKNahKIr1yuoFo4x8dDNWHjJ9vn0dw4s6fOoLwx4OaSCNMGPmUklI7Os2Ysnx1NIOKzT0XhLqeCxYZHSWkPd+qm8ZnDjWEWnnZDUXq9jMmNqC5OrEmQ7Eo47QDknCzPSMWP7AOIb9yzKKHMdCx2HHuGFISWzAoltUhJke6fcoYxPCIyVDHDVc0xzyFhiKLAdnfd6gNrwCFPjtMrKlDO/Mq1K3HiXAD0TKZJ8fbywzVUp1Q/ZFiwsau+6Y5vn9DoFlpaeP7Qd0a/KZEXUvld/nHB2Q3VZNO6+M8a2wOrG0HoA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(10290500003)(478600001)(7696005)(186003)(38070700005)(83380400001)(55016003)(82950400001)(122000001)(82960400001)(38100700002)(33656002)(6506007)(26005)(53546011)(966005)(86362001)(71200400001)(9686003)(8676002)(41300700001)(5660300002)(8990500004)(52536014)(2906002)(110136005)(8936002)(76116006)(316002)(66446008)(66556008)(66476007)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZULtvF30KjdYMMEMzFspbnVoht8Idj1dexMAFwvJEQs4bZ4QRCsZA7GDibfY?=
 =?us-ascii?Q?RkjxFaTyBrIziurOU0nFwOEViZq7VjulVDWM2b6N7lI1cg8mDjqdukWfxT/c?=
 =?us-ascii?Q?Vi/M3+Qm/OcV0CpgNeqNqu5gy4uLf2dxZ5UtUW48MIeO+cdCW/JaCer+aPe7?=
 =?us-ascii?Q?hK4Qe50HY2ak2fQqkHMDniR7VsDUgiAbom6BujpZE2nY6oLH2DlF09wm6hXi?=
 =?us-ascii?Q?TgnB7zDmeM7oYVm3wfxKX6yR2pWXHmpYOAzMrCjO/qOufjV0e/CrxXTEo3KQ?=
 =?us-ascii?Q?39OLgEFUNmARtqgnzwzoHE72OoinAktXn+Mk6U9gGXaqNmSWBKU505XWPa9H?=
 =?us-ascii?Q?1/FWjFp742nFER+kT1Hbkr7+aqNbXiDDeA4ITI50PWZLJfupVWY1/eSxPrkq?=
 =?us-ascii?Q?s2yIKMHI0ojAtaevZdaXeFTFNmHGw8P2LMgilnlnQSfe2hmbwtFE3YdArx2j?=
 =?us-ascii?Q?ToZR7J3jlORPnHUifAlCqLqLkC90070KBAZrlw5kr65cz3QgyIW4KUtfzl9f?=
 =?us-ascii?Q?VvzHZynsx/pf4G12Ey325mCzMl8lwUSdK8a/xoUffNeU7l7XGzK8Qwi3w/ig?=
 =?us-ascii?Q?KnrqH9F97JJfZd1V3VLa9PdzHt1887lBkJWH5/IE9OdSQHieI60fv+Fj34Mt?=
 =?us-ascii?Q?JkZRtQ58cI2ik63bm1Zh5VQ+73HqgZ1Ch57On23HBknAL1wcHLSaxKysFhnu?=
 =?us-ascii?Q?C2smBqjXlJDlStpTDyauyLEPpVWVvQajjX6lRJUhlrdH8n22lCU2DSlMmU2E?=
 =?us-ascii?Q?6CqRkUvC0tYrV7uXMMlw0gEkarq7M2ug0ty0VGJrzRm4jjEWNQvSrhTHjJw2?=
 =?us-ascii?Q?hJbmMN9xVpVdYSGKEsv3Gqz6NrM9hOqKUTP1bfscK7XFo/iFTZ+nxdNoJoeL?=
 =?us-ascii?Q?u2FecsC2BlvJkA5ify3DBrYwc3KVoWTsuy1k9UTXgQ2Mqq80gI89iDTdGEFG?=
 =?us-ascii?Q?u+11wG3btxtemxYZRVdRcwmUgGmhfC3MM8x1Ec80ITDYhRe/3t6xcXTcErGy?=
 =?us-ascii?Q?ASWySDVjIEZw+6o3xkhCvncDsqsks4IOtBoKiMH+pssvYF14GT+h+Q/OMXtb?=
 =?us-ascii?Q?aYSMvnfq9a59pHjvPKT4TtBoDn2CDbT2GAmDmVAVXR8xCduL+0MwynXQBxud?=
 =?us-ascii?Q?iae8GcyVPmsIfdtXC3uGPlYGK7//9AkP8oDElAi/zP6T2OkTNVRuXv9ntB2n?=
 =?us-ascii?Q?PI8l1Hvzxt1fjwqfFlpEYE0/i14XOQgycZn4yiPi+yqZzB5bAS+K/rO03dLL?=
 =?us-ascii?Q?DMa8e7EsM6y0DIp8GafI+qVJhjJ7sHAK0xgDGRavlKEBdG9yOoOgd8OWJXel?=
 =?us-ascii?Q?BtVBAMDDmEJ2UYhsArwOV6knTeoXf2oMUe7VLSDmzbCwW5xtFlzY/Z35Mq98?=
 =?us-ascii?Q?I7ZNkcD9hCnMKjzMno4b08nwbhOQrGb7O4r1XwG9yZiZ3hQHTtkkc0BTyRB1?=
 =?us-ascii?Q?yUT1TtsoH0jR8aVDy9aIWOIU8FnRy7+SOvl+yGSraaloTVnVYCOawZe0EYX5?=
 =?us-ascii?Q?nleD2MM7zq2gvixy8iEYPexLLdblk3HVg3fXrBFQxFEzIcJk3j5cVTgUz8uP?=
 =?us-ascii?Q?Cs0+/ciJ8yA8Wo4bw7FZcWdjCSt7S9HZB4SomnXoVwVPlpnDqBskE0obfIYq?=
 =?us-ascii?Q?NQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db1af26-e2ff-414d-8341-08db70e47e2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 16:44:47.4574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1VURkWVw9DbdfY6D1Cjf8pmGVcf0alZt5H8iqc4tK7E2FSZIsOj6D/To/7so+uHuv9Gzcy32DcVUGte7/mYG6Q2GespKt1W1/Qzztl+jY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3877
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org> Sent: Monday, June 19, 202=
3 9:16 AM
>=20
> On 09/06/2023 17:47, Michael Kelley wrote:
> > Current code assigns either the Hyper-V TSC page or MSR-based ref count=
er
> > as the sched clock. This may be sub-optimal in two cases. First, if the=
re
> > is hardware support to ensure consistent TSC frequency across live
> > migrations and Hyper-V is using that support, the raw TSC is a faster
> > source of time than the Hyper-V TSC page.  Second, the MSR-based ref
> > counter is relatively slow because reads require a trap to the hypervis=
or.
> > As such, it should never be used as the sched clock. The native sched
> > clock based on the raw TSC or jiffies is much better.
> >
> > Rework the sched clock setup so it is set to the TSC page only if
> > Hyper-V indicates that the TSC may have inconsistent frequency across
> > live migrations. Also, remove the code that sets the sched clock to
> > the MSR-based ref counter. In the cases where it is not set, the sched
> > clock will then be the native sched clock.
> >
> > As part of the rework, always enable both the TSC page clocksource and
> > the MSR-based ref counter clocksource. Set the ratings so the TSC page
> > clocksource is preferred. While the MSR-based ref counter clocksource
> > is unlikely to ever be the default, having it available for manual
> > selection is convenient for development purposes.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>=20
> The patch does not apply, does it depend on another patch?

It should apply to linux-next.  It depends on two previous patches from
Peter Zijlstra in the sched/core branch of tip.  See:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=3Dsch=
ed/core&id=3D9397fa2ea3e7634f61da1ab76b9eb88ba04dfdfc

and=20

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=3Dsch=
ed/core&id=3De39acc37db34f6688e2c16e958fb1d662c422c81

Michael

>=20
> Rejected chunk:
>=20
> --- drivers/clocksource/hyperv_timer.c
> +++ drivers/clocksource/hyperv_timer.c
> @@ -485,15 +485,9 @@ static u64 notrace read_hv_clock_msr_cs(struct
> clocksource *arg)
>   	return read_hv_clock_msr();
>   }
>=20
> -static u64 noinstr read_hv_sched_clock_msr(void)
> -{
> -	return (read_hv_clock_msr() - hv_sched_clock_offset) *
> -		(NSEC_PER_SEC / HV_CLOCK_HZ);
> -}
> -
>   static struct clocksource hyperv_cs_msr =3D {
>   	.name	=3D "hyperv_clocksource_msr",
> -	.rating	=3D 500,
> +	.rating	=3D 495,
>   	.read	=3D read_hv_clock_msr_cs,
>   	.mask	=3D CLOCKSOURCE_MASK(64),
>   	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
>=20
>=20
> --
