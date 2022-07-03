Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACCA564831
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Jul 2022 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiGCO5J (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 3 Jul 2022 10:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiGCO5I (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 3 Jul 2022 10:57:08 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020014.outbound.protection.outlook.com [52.101.61.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC7460EC;
        Sun,  3 Jul 2022 07:57:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILu4N21AWyMjR7PUTuKb/69Zhi7Nrobc9g5Z5lXttRMIKBEaI5mw2aeGimUcI3e9DrtOmK8u/3K4tlRWsY1FftaElL2bTqWlUlyxPhe13Ht8zkSKRd/2LQSDl9tWXbw2ss2cl1mXdS8hvztOM78n+4+xEhHpgeg4dqd94FC99zOXuxEi8fxfKEfNnFc2e5StUpWgGKh8CotncAXujdSMU9aO2FyDQ71sGGDPqKysGZc2UhppPhNy4pnkBbRJGj3p7fF9ifRKVxoclj4QD+5HaqTbJTQXTLYUbPjGZ//V4lWI4EbzdbRVsa9Ym4dWw2i398CyKvarfkuUJ0Xhf/KFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AlJlw0qEEXG80oeq+rYci/Isl6qoUqErSccHnJ4QUQ=;
 b=OWm/kLho0KuM8GLyImqeyurBxPc3Ej/qyq8CShJdTts5Z5F9bpJuCZ+Vi0W7K+M9eBywxDsaZ3DcPXZqMw4d6eh6uIJFqS5l9AEWqk8wp8JonqoWHZ6hWK50K5oX20/x+lwWLTs9VpgMqDCL8nYjQ0CV3D5Ixe1ElFMlkZQWHe2DiNY8PXBuOy4RYh9OE8w53PcHEhC4WmuRwBG5k7qDPyujI/V1afHAW54lNeKDKGsGoOaraKN46CRsCG/REZLGGV8nU12cmmVr/lteeg0OQ2FL8yorZ1Hcg7Er51MsHftGCuWAxrQrLjjnR2HynjZl+bvhm7xUmB6sU5rJstq+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AlJlw0qEEXG80oeq+rYci/Isl6qoUqErSccHnJ4QUQ=;
 b=Q3eLR7KUH1cqP+8BndpDUJD8+YbAoe7GZgyqiYLX4LkbpjC5W15HBSqJUVAtIAcHQ1YZvZK+GpbwQFgHfIhzDW2GBL7+Y2sCPgAhXCsJd9j5JN6uo18e7J0Oi/UVxXytR8zplxcMWZBDot2BmxCT719fE/wx8lTIjc1RqKMrOoQ=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH7PR21MB3332.namprd21.prod.outlook.com (2603:10b6:510:1d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.11; Sun, 3 Jul
 2022 14:57:04 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992%5]) with mapi id 15.20.5438.000; Sun, 3 Jul 2022
 14:57:03 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chris Zankel <chris@zankel.net>,
        Colin Ian King <colin.king@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jan Beulich <jbeulich@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        Juergen Gross <jgross@suse.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        KY Srinivasan <kys@microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <rth@twiddle.net>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sven Schnelle <svens@stackframe.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Wei Liu <wei.liu@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: RE: [PATCH v3 7/8] genirq: Return a const cpumask from
 irq_data_get_affinity_mask
Thread-Topic: [PATCH v3 7/8] genirq: Return a const cpumask from
 irq_data_get_affinity_mask
Thread-Index: AQHYjYbXczmReTSuP0mFTu45zRpEE61svhUw
Date:   Sun, 3 Jul 2022 14:57:03 +0000
Message-ID: <PH0PR21MB302584D4FE115FB39070B1E3D7BF9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220701200056.46555-1-samuel@sholland.org>
 <20220701200056.46555-8-samuel@sholland.org>
In-Reply-To: <20220701200056.46555-8-samuel@sholland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=22e47685-adf1-4a03-af55-361981d831ee;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-03T14:52:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2c72871-6097-4439-7f44-08da5d044a4a
x-ms-traffictypediagnostic: PH7PR21MB3332:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QfnXwy1BAffW42CbR5lol/MBEIUFGBCn83YL26jm74qddj3LQArwGyzdKKGXlem+JVLU7hxsJiP4oPkoakgetu57U6/rJoN3gc2rjduvoI7fZaANz+pUAr8NwdqV/FFlab6qSIAWvY3MoW1f7FhC875NUTuJdEVNeLt561swgr9t3hvGuSqM1XSu2ljJwN8QM+ecBiMqGcjzVrfi9XLAFhZpm4Ghy+lTDiNxvafLU/HHpuClzVtjSP3rdwxpF2jJFAZDuV1fdokdFQ0/p5qnm1GF+QkioI6FtCh7IBxU6K+/M1JI7yvcsJFCznPealtzkJSAOZ34DSi4VQm8dfv3Zu0UFnRoTwkbt6xj7kAhVetbe+F4xqtQReIKKjDzkoKynoUnO4p1ZjM+TF+vgYIxRF7AF3y6cNy5yqnROfc829xbcHfRk9dg/NoIJXPyV+l6k1PDQc55VasKrFpfM+mzkgWndgTnRsc15nHf7NOmO+7DJixBnr65VFrG2BtrvJkGI3nNRFVcCOV5PVI21QdHB4Eh7CsJOscYqfhJAqSxqQjmG9hGGs6z7FcuBkMizmsorXZIekzEANFwak2EiWKN+HjU6Wyy0UURa+5/G7LqTxKVGVq7d5bWaU0jOUNBBazXY6NNsyTw5rRQJhUciCfRQRVjueykmzfWa2qmBt5PC4cqTZqt+l0gspBD6jLKoWvKMR+gvxL0DQCQGyK+RuR9tIytjEyeQd9hD2BGh/EPZ8ChpEI5Qtt8aR2ve7zLm7uQcyUKQf5ltguYuOSadJHqe2G7AmvdaoZa6otMXoK92cGi2vbr0eUcIau1zro0mds4KcDoleG2q7wsYkjbqoCDsxtGmzDDFikkokwjG2VVa5w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199009)(55016003)(186003)(38070700005)(110136005)(122000001)(38100700002)(66476007)(4326008)(71200400001)(10290500003)(64756008)(316002)(66556008)(8676002)(66446008)(83380400001)(76116006)(66946007)(54906003)(8936002)(6506007)(7696005)(9686003)(7416002)(7406005)(86362001)(7366002)(478600001)(52536014)(26005)(82950400001)(82960400001)(33656002)(5660300002)(8990500004)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?HZYBz/SjFmopeaqiYNMtJ1+/z3RxpPOZzEYh79i0iQlgJt+Zki4vs7oJYr?=
 =?iso-8859-2?Q?dbG5Ca3LzVHC2SirMtYb0/Ebd1JzET0+EieJiUVJD7SndbwVHjZqNl/rm4?=
 =?iso-8859-2?Q?vYrMjlENkrSrsYhY0qWYgYbej5GMU9VYPLbN1Df9Xk6a1U30q9o7jvhpnK?=
 =?iso-8859-2?Q?J1l1ab38YVyMmeMARaYANpi/Fv3BM6B1pMzW9DdvMIPUEpswnMJaJ8+qK8?=
 =?iso-8859-2?Q?q9IcU4kGiE6ptTwAwlGxutPUmrfcM9YZCfc/ZMYYgJxlUzLW+Sg+9fmUlr?=
 =?iso-8859-2?Q?7cypNyAwo+wcxAj5jozctefH4SQaRkovHNL5D/Knlpm6hHJt/wy7csjkNC?=
 =?iso-8859-2?Q?Gio49moRX1WFCr0ZBHt0oP37Rndtvx6iGxbQfowru/bWRjGLyJ4NY6QGf/?=
 =?iso-8859-2?Q?pJsVtzwV0H6/luRPCiM5AaDCouM0JMWXpJIbgGHbN7JHY+7/ywiCwYM0Hb?=
 =?iso-8859-2?Q?aUry6tP0DeHy8QLn/Rj5Bil64JRehA+HOGAzZCXzt0NVlKnMH/muWfRIKK?=
 =?iso-8859-2?Q?I8zjEhyqmiwG0dM2e7Iss579BJ3wDXSmay8x3g+JVGUiCuDho2lhRSXIMf?=
 =?iso-8859-2?Q?FPmcDnVbIEHfdRLBiyOh5vIXCdvhYX6dhkWRKOAnQ7Ul2rBs3aKSjge5KC?=
 =?iso-8859-2?Q?QnPkdFyNivjNDCidPN9TLzXfgXeHn8qW/A3PXKhhztpqkefKA2yMie6cbn?=
 =?iso-8859-2?Q?oOYpuphXn88LrzXsVWS5/obx4JiAMCgHlNY9fCO/zBEMoZzjp4axzDe8+B?=
 =?iso-8859-2?Q?k0evSalMdZczMyqfThv+3LRdOSbK6iv27AFBHwaWh8Cw7ygOvv9niGYanf?=
 =?iso-8859-2?Q?AihQtLgHuaU8LPqshA9vN5xOeyek3Zbsvsqgu/Rqe8LUMT8wfozJdk2bZn?=
 =?iso-8859-2?Q?UnlD24PZfwvYDaK3SgiF1ao+5Hg+kmky7H7f01Jz+HEydQ4Z8NLRwJBTTi?=
 =?iso-8859-2?Q?LGtfD20GuorLBVmJbb/OELlrPydkNdob9hXzF2vNWFlrspxs8Agx9vUEj+?=
 =?iso-8859-2?Q?OUXLh+ad/J/JRfWhQAY0qK/VYAzdeNXpOGDHtg5mMS4WkA3aOhBiC5MzdS?=
 =?iso-8859-2?Q?fs6mPYziNNlH8zUE2OOX8TU5HH+3C7R563DJu3HG0hbaBYFWfXFitKrggp?=
 =?iso-8859-2?Q?0Phj/YuVBlu6/d7sNxBbIBCBXDOXNbVaQ/awoaN6Zwqgh+QN0DMt9aBvjF?=
 =?iso-8859-2?Q?6x0TpF8lwcrIcALXmmmC+2UY7nkwQPZgJkLgoNmj2GVK1Xl5/1DdMN4VjV?=
 =?iso-8859-2?Q?MO8mDEzT10y4n0TdOddH7RNwN3d4gdFy3FHu5Jq33+n6A4PPBMBHGgfmYC?=
 =?iso-8859-2?Q?S6SvzwFnpl0ZcM9ZcNiQgctAaYy+ichUFOfP0xNcZO2BhfzaXy4gEFtRQ0?=
 =?iso-8859-2?Q?C4JxC81DuMokFTQ6f5cFyEmmkEEA64E2r5KmsAN9wk5RfS38qU0mrIWGXU?=
 =?iso-8859-2?Q?saLCvVav06o0h5GABES6Z8zTb78QhyYNbra3LVMx56m+QZg/0WrP58OgiC?=
 =?iso-8859-2?Q?Pxvyz7GUvpa+RlxCZ/qZqcKMaMp1GTRu0dBkJrA763qKZecaPM7bpgO8rK?=
 =?iso-8859-2?Q?csgzswK6lIZd8QIqwzVdDTNUmNr8W0tKLuNlrlwcFdwGWcyDlWJKRcSDxw?=
 =?iso-8859-2?Q?JIyChbflD2RtsK96wMvVOeNu1mE8ADK5osIi3fXtP9rWGn/UWlNDX5jQ?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c72871-6097-4439-7f44-08da5d044a4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2022 14:57:03.3687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /jduyyxp+FyBqGP61xV+NrlSuuiTVYzUzx0e8U7mIGorcY6P2rVwbT9XSTGJBLII/Hcetd8xw+uKyTgleBzrfgvdDZMKQ/jMEYynBm8WdCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3332
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Samuel Holland <samuel@sholland.org> Sent: Friday, July 1, 2022 1:01 =
PM
>=20
> Now that the irq_data_update_affinity helper exists, enforce its use
> by returning a a const cpumask from irq_data_get_affinity_mask.

Nit: duplicate word "a"

>=20
> Since the previous commit already updated places that needed to call
> irq_data_update_affinity, this commit updates the remaining code that
> either did not modify the cpumask or immediately passed the modified
> mask to irq_set_affinity.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
> Changes in v3:
>  - New patch to make the returned cpumasks const
>=20
>  arch/mips/cavium-octeon/octeon-irq.c |  4 ++--
>  arch/sh/kernel/irq.c                 |  7 ++++---
>  arch/x86/hyperv/irqdomain.c          |  2 +-
>  arch/xtensa/kernel/irq.c             |  7 ++++---
>  drivers/iommu/hyperv-iommu.c         |  2 +-
>  drivers/pci/controller/pci-hyperv.c  | 10 +++++-----
>  include/linux/irq.h                  | 12 +++++++-----
>  kernel/irq/chip.c                    |  8 +++++---
>  kernel/irq/debugfs.c                 |  2 +-
>  kernel/irq/ipi.c                     | 16 +++++++++-------
>  10 files changed, 39 insertions(+), 31 deletions(-)
>=20

[snip]

> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index 7e0f6bedc248..42c70d28ef27 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -192,7 +192,7 @@ static void hv_irq_compose_msi_msg(struct irq_data *d=
ata,
> struct msi_msg *msg)
>  	struct pci_dev *dev;
>  	struct hv_interrupt_entry out_entry, *stored_entry;
>  	struct irq_cfg *cfg =3D irqd_cfg(data);
> -	cpumask_t *affinity;
> +	const cpumask_t *affinity;
>  	int cpu;
>  	u64 status;
>=20

[snip]

> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index e285a220c913..51bd66a45a11 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -194,7 +194,7 @@ hyperv_root_ir_compose_msi_msg(struct irq_data *irq_d=
ata,
> struct msi_msg *msg)
>  	u32 vector;
>  	struct irq_cfg *cfg;
>  	int ioapic_id;
> -	struct cpumask *affinity;
> +	const struct cpumask *affinity;
>  	int cpu;
>  	struct hv_interrupt_entry entry;
>  	struct hyperv_root_ir_data *data =3D irq_data->chip_data;
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index db814f7b93ba..aebada45569b 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -642,7 +642,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  	struct hv_retarget_device_interrupt *params;
>  	struct tran_int_desc *int_desc;
>  	struct hv_pcibus_device *hbus;
> -	struct cpumask *dest;
> +	const struct cpumask *dest;
>  	cpumask_var_t tmp;
>  	struct pci_bus *pbus;
>  	struct pci_dev *pdev;
> @@ -1613,7 +1613,7 @@ static void hv_pci_compose_compl(void *context, str=
uct
> pci_response *resp,
>  }
>=20
>  static u32 hv_compose_msi_req_v1(
> -	struct pci_create_interrupt *int_pkt, struct cpumask *affinity,
> +	struct pci_create_interrupt *int_pkt, const struct cpumask *affinity,
>  	u32 slot, u8 vector, u8 vector_count)
>  {
>  	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE;
> @@ -1641,7 +1641,7 @@ static int hv_compose_msi_req_get_cpu(struct cpumas=
k
> *affinity)
>  }
>=20
>  static u32 hv_compose_msi_req_v2(
> -	struct pci_create_interrupt2 *int_pkt, struct cpumask *affinity,
> +	struct pci_create_interrupt2 *int_pkt, const struct cpumask *affinity,
>  	u32 slot, u8 vector, u8 vector_count)
>  {
>  	int cpu;
> @@ -1660,7 +1660,7 @@ static u32 hv_compose_msi_req_v2(
>  }
>=20
>  static u32 hv_compose_msi_req_v3(
> -	struct pci_create_interrupt3 *int_pkt, struct cpumask *affinity,
> +	struct pci_create_interrupt3 *int_pkt, const struct cpumask *affinity,
>  	u32 slot, u32 vector, u8 vector_count)
>  {
>  	int cpu;
> @@ -1697,7 +1697,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a,
> struct msi_msg *msg)
>  	struct hv_pci_dev *hpdev;
>  	struct pci_bus *pbus;
>  	struct pci_dev *pdev;
> -	struct cpumask *dest;
> +	const struct cpumask *dest;
>  	struct compose_comp_ctxt comp;
>  	struct tran_int_desc *int_desc;
>  	struct msi_desc *msi_desc;

For these files with Hyper-V related changes:
arch/x86/hyperv/irqdomain.c
drivers/iommu/hyperv-iommu.c
drivers/pci/controller/pci-hyperv.c

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
