Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14DB59644D
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Aug 2022 23:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiHPVNe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Aug 2022 17:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbiHPVNc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Aug 2022 17:13:32 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3A865813;
        Tue, 16 Aug 2022 14:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ua5MFjgVlShrOf7G5gLIpJLTv3L8dFq03h79R8/HdWAUcC7hiM4ZcNId8g6fFc0n/M/rt2LZ2jpb8Sr1yHufJPx/zaT2onNPm4Li3V1ieQ5beN6G585Db1a5A+VI/s9WTRvhwzbitrUd9gay/qvAqzrb7doBX0efNt15wuRPk1m1tXlIeqJNc9dMKPkKdrY51W1pCz1qmk4m78tSPOKYoCfUIp2kRcD6xpxailBm34wDHHhaUK43C6I6wn6AJZkEEyXR5OS9cMV9ovrUaCRXMzh+mhRGNBEu9/UtxmRav+BtJxu39PqURfKR/ppiWBEFjS8YZHNbBoKawUpS0Otktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsINHE0vkJWRyL0Nb5mXBWRCNOnhdQqR1CxZ1O7vpcw=;
 b=bGWfCiT4VxPFnz7A5bm+/KfnvNVJ8Zrg224ISr8Wsn1m9bV1px4Q2OLy/Aht9SBel95UTibc+gtDAvHz+oEPgjBvkJYao052PLS4pNG/jE88pD7v187ONHSLwtpMg4TVjrYVEAQcIHVKBlIz7pI3u6+cWrqDwOiAaOSTgF0g/X6ZM0KY5mQpf/zRgY8X05R3840nS8DzV18wogH3SRkQU3bufR1YRSXJ55Z7VJEtnhvneY3+CX1IcSRBC+F+eoApbyly6YT3XhfAu3zS4j67aBHd0RKNhCXe3uMgF3tSQxRxgVLJiNRHzKu2xOf/tngZn2BMGgFV77qeB1N6HDADGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsINHE0vkJWRyL0Nb5mXBWRCNOnhdQqR1CxZ1O7vpcw=;
 b=P8iaZqdX7A+C1iE5CRKzlhAjAWfhTH7U4tV6b+AmUJE0ZqZbUqdFBLO5LfYan3iQK8dgXpdrYA62f676vN9rE9BWuvVMznPGfC6GhK97QPiiyvAt5PoCDK/LRyhDcE0+7f+2DJDpOnl4u73dR+Wn5Y5kAz+e9HqFy+qqb3/1u1c=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN0PR21MB3339.namprd21.prod.outlook.com (2603:10b6:208:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.4; Tue, 16 Aug
 2022 21:13:26 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::a4e2:7dce:4d6b:c208]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::a4e2:7dce:4d6b:c208%4]) with mapi id 15.20.5566.004; Tue, 16 Aug 2022
 21:13:26 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>
Subject: RE: [PATCH] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Topic: [PATCH] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Index: AQHYsYgIr0ByY5vvCEupYVpg2kRVKK2yAnlw
Date:   Tue, 16 Aug 2022 21:13:26 +0000
Message-ID: <SA1PR21MB1335FD78A02C0CE2632E532BBF6B9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20220804025104.15673-1-decui@microsoft.com>
 <20220816155122.GA2064495@bhelgaas>
In-Reply-To: <20220816155122.GA2064495@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=453faf14-2e29-4c1a-aa2a-7a34ff1f522c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-16T20:57:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cda0660e-9f67-4528-a30a-08da7fcc291d
x-ms-traffictypediagnostic: MN0PR21MB3339:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vJpYD3BFA/W4dmZdHkgW8oiQTdKxq6rtOdwhFrjyZuRI2hV5EnwFpjOFxIDGGH06bCxDwGfcqaif9wVPvm14pMwJBFGe1C9LuLEjI0Dlva6yBm8xiEHRjTjw+Gf4i+d43S4Rzggn0x2Q36g1TU9NzhqD0gXEg/Cb4JvEjkXeSVrJEQXT0KzQxvPbmX8SJsijQHtXHtousgYrPrXc/A0+U/2Aw/6wvNjDOGz4EYVaz8ajo5DEd3LJIS2s1MybNUIxA99ar+D+UnMh7cB54e92CzeKKwhYR8L5k87Mch/h0/vkTfKC5YGWO3HZ58PlKKMMVm4IyzbTkvm8XkNZ5uCXMMOHVWbscOI+yEfhvVT34pl9aCM6HerFd0N+bqWWq1p/heS0mazj0cat9PCE9uphRknun68H34tblAizt41INfKdujhLnkIcYomVvuf9XBmgSgZR5Sn4k1fn5QjuAp78rrYO1XHOXUjccKzn2ESfPFZZxF8dV+ZF8sFvkYhEmG+KKaGTX2duVfzQFvgGaUlQttfZ5Jjuefjz9hrTDbm49IZI6XtWcpJOsPPrg3Md21G5LewuXVdQ11UdKxoazX0sF013nPTRuzS2SsZsuYE1ZQg0h5vpoN56VmOz4zXDwTCFp755RmQjB+wLqCqeTl2/ATzgE+sFP/6xe/qW6VAlJywzlVmEQbSu35/rxArTrQE4kMCTfG60EWALO+3ZYGlV8CNT7psspcrI7q4AqRAWhw+0IEwe58KL8b7GtwBci1OtOiLa5TtgewE8E+J3hHuj9GnHHHxQPQL9HPavTMmnooKHJkXtDmFrICXjhE89LJVoOyCFiwZr7pxmhjHYmdTDfVotYo/DJbTby5ZOPc/r2nKlqAAe/rdk2K8XqVkyh+PV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199009)(38070700005)(86362001)(122000001)(38100700002)(478600001)(82950400001)(82960400001)(966005)(76116006)(4326008)(66446008)(66946007)(5660300002)(64756008)(8676002)(66476007)(8936002)(7416002)(66556008)(52536014)(33656002)(10290500003)(6916009)(71200400001)(316002)(186003)(55016003)(83380400001)(6506007)(7696005)(2906002)(41300700001)(53546011)(26005)(9686003)(54906003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tQpZOk0vjQ7Z1040wrt/re6PGf3jBvdKVl7PyMdZ1PSszwxD2QZY30/PGlh1?=
 =?us-ascii?Q?+mINkkFXFls3d6FjxxKDyXT3urqejfW9GgZhFQmYjqGtarNjJCajtm1ZeXyV?=
 =?us-ascii?Q?rqo0E/wB2z5xxgnjceokBrak774oIjyZSfxYFNmrY3RcexGRFiIV1lv01zpx?=
 =?us-ascii?Q?sNohiVZEEYM0j6GQvRVCD4bXxofhRWYFBiX001DYBX9uYJRhlWGnTZisux5/?=
 =?us-ascii?Q?+WTLZpGQan9uslBqlzJJaZvUkYUe6kIPPljcwMruC7OM0NLowzwAScEbbIjj?=
 =?us-ascii?Q?qzu5m9PSAsak1lUJy3Ck/569KB7bA5loVXaUyWJjk9SL6WUFUN+qUKkyMYIS?=
 =?us-ascii?Q?11qsYsSxvIROZTZCHDOdV5wJR5B4qIiLhNDHaxxjmz4ibrq8KpdZlqb3t0eb?=
 =?us-ascii?Q?TfIfWPvfqdWtFAY3GbTaU1WZD4zVaNJ9D8dyzJT+kTWZoWtms/ZD0d26h/Ti?=
 =?us-ascii?Q?iLhI5jH6N74E6SV1AQDfVpcvqeuxiTwgtilKGCkH8DNBzClcfSIsVcJO70Kg?=
 =?us-ascii?Q?BiP/UJ5PPK1KZ33UPnau11VS8dAkpko951O2Fh7FEGYE+bHcnkQOJ0+TWw/4?=
 =?us-ascii?Q?HlA0sZrriqy2NJjBQaOvStOx4frJdkzFzrf46H75Gx81joQG6+YUU/FPNE0g?=
 =?us-ascii?Q?AvkEosIB1txytlK0S9dmB/MF7NbP4xtALBypry3fNsYxKkH1OumOGE2bJTTS?=
 =?us-ascii?Q?sw3CVZ/nhNGmk8LwH0XEqQhi/ahCP1iKCVXUInXHq4B5mCXYzpACzAXmeBbz?=
 =?us-ascii?Q?xT5SQwBwyCvRBRp5N2Fj/7hFoy9YBsQzsAT3cnVTXFJ0ujZpkulhYFb4ontO?=
 =?us-ascii?Q?Shz6Ygj+t2j+qQcSITSgCDj+wMHSGOtGrtoQ0+8dd0nG1D8ztIGDNJoJ4iBi?=
 =?us-ascii?Q?7xesQtBg1nOe/lwWznOg73B6Jx2VBhkAbvoxhSf0Nr09lKGCUKYXWJXT1jtx?=
 =?us-ascii?Q?/Dhuo18sg+M9sXwcxTwmXzxp2SzyN4dXsdt+8qRs10CceNUMAqMC5UuxfMVZ?=
 =?us-ascii?Q?JAXzIFM3q2UaY3BedFf0dTtHqvdGKr/3Xg/D140QxwQO80jUf/0walwIOQ/O?=
 =?us-ascii?Q?LpT8bL4CNV22VQJsdtJwxn36Zg3ah6OAqCNQkFsAKOzM6W9X8FewFJp9xASX?=
 =?us-ascii?Q?4nXQ6JMiA/ALjJvniEDjDZgtkhDMgLHwrJ0T9TW5soZ9Wb087VxY+NM3h3TV?=
 =?us-ascii?Q?HuepMnPCE43rAiKonJF4a7SBE5K9lnsl9LXl/cYg0Oi770zUU3Y7pHhslIAH?=
 =?us-ascii?Q?DEJcJ5QKG5mIRoyj3Ldbwl18r0GIgpxDUVVG/ZofgRAjMF+a1wofv111bTIm?=
 =?us-ascii?Q?CjDyUUtbDq6yNru3dOOibn/wTUQw55iVJz7fQVqHdwRQZZJMKCnHR9iQ8rRE?=
 =?us-ascii?Q?c4ZKUgJjfxNGM59ZdpEI4IVOqTuk/JeGUnANOS1dsIjlu3KWMn4SZljwU47f?=
 =?us-ascii?Q?Xvgcisx+W7cAHUjsLnVeqj89gQX0gkJ6Q6go6X976prIR92oFSpVtqjzztv9?=
 =?us-ascii?Q?XWJPRkgcmjajYOgbafONW3Blu9TpqPqtozhI5OKUZ4w/aguxmSforAFh+T3U?=
 =?us-ascii?Q?rDQS3APDjicTRi1YRpO4dRhwR0TO+ibLNE2Eovy4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3339
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, August 16, 2022 8:51 AM
> To: Dexuan Cui <decui@microsoft.com>
>=20
> This has only observations with no explanations, and I don't see how
> it will be useful to future readers of the git history.
Please see the below.
=20
> I assume you bisected the problem to b4b77778ecc5? =20
Yes.

> Can you just revert that?  A revert requires no more explanation than
>  "this broke something."

It's better to not revert b4b77778ecc5, which is required by Jeff's
Multi-MSI device, which doesn't seem to be affected by the interrupt
issue I described.

> I guess this is a fine distinction, but I really don't like random
> code changes that "seem to avoid a problem but we don't know how."
> A revert at least has the advantage that we can cover our eyes and
> pretend the commit never happened. This patch feels like future
> readers will have to try to understand the code even though we
> clearly don't understand why it makes a difference.

I just replied to Lorenzo's email with more details. FYI, this is the link
to my reply:
https://lwn.net/ml/linux-kernel/SA1PR21MB1335D08F987BBAE08EADF010BF6B9@SA1P=
R21MB1335.namprd21.prod.outlook.com/
=20
I just felt the commit message might be too long if I had put all the
details there. :-) Can we add a Links: tag?

Thanks,
-- Dexuan
