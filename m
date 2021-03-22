Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F48345310
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Mar 2021 00:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCVXcn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Mar 2021 19:32:43 -0400
Received: from mail-bn8nam12on2137.outbound.protection.outlook.com ([40.107.237.137]:19424
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230411AbhCVXca (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Mar 2021 19:32:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMD1udaYwG0+akT/onuXnCGP8R1sGLGZJOuSC9lsm5r2cb3PYI8UaO0W8zpB+/ZouIzGd+cToaPv9vVADiaR92EX0Ob9ro90mO8cb9KaadDhLcN0UdD8YHjjz/Quetq+U44NULcEfdSTDGz0tMoOdaWkN8K3A/J1cvLx1LYogR+zcjwl7VKioTH5EWJKvzFX142L5Qh6qtLjDuunIO1Oddxe5QYVTSY9MZ29ioMbVHuV0BOfl6/8W0QWnh/NxSwPjIylaXTMiCmaFXyHYRuHEmQgfDmYEwmOSvh7xfxsC4FouPqtJL0bpz7lFWicmZVMHQsNmwUaNUp/4uXyWyHzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0L2c9iPOA9kX8fHp4mImtqGhBtcX+xgVjqH/PQGfrA=;
 b=P9DahlsATnp/G0inZ6Qw+lQQGiv5dD5QEyqoHwpWye8I3abdpdDIMLNCV0sQWO0bJzcKzjRBFN2PrQwx4tY+1NS/TfPSz9XVxt+BwvEqyNsbU/lHu7tappR5/RrVuQhKZjwzeaZPE4PLd4BaimJhUHN/4gTL8uS3o0CxWUC+1UAi5vFHJ37Rcv+dSrdA5zfhv82y/q7AlUKYT4U4zPlkCyEKkYFLbGqfgn8MTLQ7H/LiKz3n9rsC+s5I6gkjXHH+c665pdXHJlc9aygJfCaxfLuKwq7OhHEgi5qJsPe0mVenPqjMfSV4umieh1R8mBmnDyua5axde2pkLBJfHNgLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0L2c9iPOA9kX8fHp4mImtqGhBtcX+xgVjqH/PQGfrA=;
 b=Z/yGTKLIqwhtKuv67PHAOqfPLlCQbn9X7IOFgN3liAxPsk9027HtYLc0SLzc5dIxvVqItfdzVku0MR6Wll+3+nRL4F/0luEtE6PiwRprCZ9YxHLo2tcwxf6DYEeA6oXoy32LTwr83W4hXWjxb7w08EusZ0KaJdEL0b4nOOpYSJk=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0478.namprd21.prod.outlook.com (2603:10b6:300:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.1; Mon, 22 Mar
 2021 23:32:27 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c%8]) with mapi id 15.20.3999.004; Mon, 22 Mar 2021
 23:32:27 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Ingo Molnar <mingo@kernel.org>, Xu Yihang <xuyihang@huawei.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johnny.chenyi@huawei.com" <johnny.chenyi@huawei.com>,
        "heying24@huawei.com" <heying24@huawei.com>
Subject: RE: [PATCH -next] x86: Fix unused variable 'msr_val' warning
Thread-Topic: [PATCH -next] x86: Fix unused variable 'msr_val' warning
Thread-Index: AQHXHsoFQEsTM3hxi0W0DEPF+rg7dqqQgW4AgAAmoHA=
Date:   Mon, 22 Mar 2021 23:32:26 +0000
Message-ID: <MWHPR21MB15939242EA50C7C1728412D0D7659@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210322031713.23853-1-xuyihang@huawei.com>
 <20210322210828.GA1961861@gmail.com>
In-Reply-To: <20210322210828.GA1961861@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8a26ae3-9379-4c9a-e54c-08d8ed8ac0e9
x-ms-traffictypediagnostic: MWHPR21MB0478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0478EEC0DB346C453150A67BD7659@MWHPR21MB0478.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/cHNuwgmnTZwyvkwOERpjeD9o99SF1PdbcC1plK0OOYV8Jdg+4SBexRNdXIU0ZfkceA8gKRZoi1G6M++quWhFEhmSIzqcwyPfcn+OgtblrFdOr2mtRSk5X9MemlfqqBlZIiUzc7HrkAh1Chtiy+YgQ7imfO6A0OqlEuGHH6ry1y1F4bWm11KyyqZCCkV28ELOCbDVUoyMeVfoc42awKGr1lqx3KsM7F/lAM6ZfC1XdIuu2lDVguPPPr9Y9rcCsxinBMP5Aq4w5bsPLlY5AWaRmaUlPvOMu9MxVf6cy58eC0MQKHBRu/y3NXC2w392finfFD4TwOk06wzPtXPh5L8smWIvI/vRykSIUksv/zmBNNBO7E/X+D10LlibcMd5WNRQJP1Epqgkz1dX8pYfJxmibcM4PKDzU5VA6eqBAt2f7ISSsXdKc/bN53Dny0DtzKwKhkEkmkqnB6+0HZQVhxpxaLQeHRCnAHcKOX/aloKcfI23YFpKnd9Z4oyc3mSXfqc46C58mEKJxxsuTFRtYb141a0bXL89uPx27Jk1Rnd0KZPGR399DBij0OXccApbOacZz9MsJbdW0f5Mvi3cg+Q8LjYBTCAQOn7bbaYCTIZTwWLajiika8+ZY88lYkkn8ZvCQM/7yK26v157jtzMHGdEs0PphKuQjBrodeOe36izZcRHZeZFd/G2vq7BEh2xeP4GPVvvM1dbpFOiJMRqeYgxQBUmY04oWwHbCr7FICeTsY0RLQTkB1d1wlNUr8RA7z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(10290500003)(8990500004)(66476007)(86362001)(66556008)(6506007)(7696005)(66946007)(26005)(966005)(478600001)(76116006)(52536014)(4326008)(66446008)(64756008)(33656002)(71200400001)(38100700001)(186003)(316002)(9686003)(8936002)(8676002)(2906002)(82960400001)(82950400001)(5660300002)(55016002)(110136005)(54906003)(83380400001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bDIhcjJN4VARviA8/vTUi7JN4p9oJaAcVH7zc6NtJYSf9+uTbTr/gDDOq/kL?=
 =?us-ascii?Q?yln4UkBaYSDgHLmZUul6dpkDktNBYx+UTHPRYSug63BQo8jluuR4ZfrmUGXt?=
 =?us-ascii?Q?HOc9fCZ1kwJ0MeSgQjJgYCG1BEJ/5KqFchIbgqRrQ/YWKBC5A5GGUGf6N8qP?=
 =?us-ascii?Q?Z4paYsTKTbsqhDjYX8KOWP814SY1lfVdigSDYTr2in2r5dSDd3hYbXDWIGJ7?=
 =?us-ascii?Q?IZFLYOPJjGrrRX/3Dy0AEopgQQKRSZ8QFbJPCwMm8/XdQ4Fcda8EIc7L2b3k?=
 =?us-ascii?Q?3iVp8Kjm4y4rUxoOZRRySKXLsxjKVa2S354HwTmOweBNz2Dgk8fkyW2YrMR9?=
 =?us-ascii?Q?PZNOuT78o2gou4Oh4NmDlSPQyS7XYH3l/CMFeu02ONqPpfOj1HtwBlNWVMkt?=
 =?us-ascii?Q?FyiVLRBoILsf+7yyIbsX49Fh3Y36a+gpF+w1aLRJ9f5s5/k2eJQgV0Ra5SR4?=
 =?us-ascii?Q?kbMlH6GEL2fvOFm4LW3oYUg+/FmFUHxoIID1XuK1jTYb6kFMrh2miLA74F1W?=
 =?us-ascii?Q?kWUdddyJGHfVzo2v02+wpiDqrzTwjU2YzmJr8sKiKQd+f2Aup8DdEjCdpnOK?=
 =?us-ascii?Q?IyLEdGcGMBrBbqV6WUb2xYBj+XycsnbqR8mVJeI7crsqteNKecXSy+r4u4sh?=
 =?us-ascii?Q?yybqOZFZTjOJT3Uk/8yGLbJn3johuDdKmKqAtFHqk/8F6KQfq2jUB9tlVq1z?=
 =?us-ascii?Q?wTp+EH9avadiIPO3cwe/p514khGH5EVMCwIJFVCrcfw2MFABXXIh9j3DU7hJ?=
 =?us-ascii?Q?/3L/T7EUwS4ie+XKQ8jghnDQHkTD1Jto1NYEpq7Sy7rG3V8f1n7KJvruyJ0j?=
 =?us-ascii?Q?G3vz5VF3GzrTBbbguN0An7nAbMVyjNMYmHbfK5r/8fQA0Bp3cFyU7lwHLh8u?=
 =?us-ascii?Q?vMOEjlNYnRcP108OXd/3x77tvMyCnGB2KbEVwXQ+Kvbir57xkLTjXXMGyn8f?=
 =?us-ascii?Q?yIQCCZLz3tsxliocQ+oRhr5sRMMaGslNi3FAqeGQTXFveXS95H5KpAQwwa6K?=
 =?us-ascii?Q?jXfEvLaBRqPwkFZQe6ocU8Yf3o/Sbnot/YP6pumIfrMNwyY7BCHP5RTAC6aa?=
 =?us-ascii?Q?V3AJQ3IH8Kk8BXEbppLkM6qCtQ6DFm1TQgLIDsGKoakgQlHJ96Tqo8z4wT8X?=
 =?us-ascii?Q?Ec2/BNweiRA9p5HaePxJalXD+nnjP2ix8iFII4pxWkw8MO8miqDC3nBk65Er?=
 =?us-ascii?Q?ow40u+fSg9xno7cU59Z6OT2T8ToprA4ZoqGzibcqq6gQcDBQMDpq71Fr6Hsd?=
 =?us-ascii?Q?Kc5QIaE/j/BPJBjWhpSDrhKl49no/FtzmvRuqoKV9yq1zbLaHNX4XYCDxeII?=
 =?us-ascii?Q?5oMV/lAAjZgqnB/YhV1VE2xh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a26ae3-9379-4c9a-e54c-08d8ed8ac0e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 23:32:26.9020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7oCmDOf4cWGcWKaXbR4tXikhBFYFTQoQOG3LeQ+Gt9Dtd0i2dqL9hWs9VpsGQv10+isdbjcG/3QCnQyoPHo8n3zaZCvbV4lBeMiWztiqxY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0478
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Ingo Molnar <mingo.kernel.org@gmail.com> Sent: Monday, March 22, 2021=
 2:08 PM
>=20
> * Xu Yihang <xuyihang@huawei.com> wrote:
>=20
> > Fixes the following W=3D1 kernel build warning(s):
> > arch/x86/hyperv/hv_spinlock.c:28:16: warning: variable 'msr_val' set bu=
t not used [-
> Wunused-but-set-variable]
> >   unsigned long msr_val;
> >
> > As Hypervisor Top-Level Functional Specification states in chapter 7.5 =
Virtual Processor
> Idle Sleep State, "A partition which possesses the AccessGuestIdleMsr pri=
vilege (refer to
> section 4.2.2) may trigger entry into the virtual processor idle sleep st=
ate through a read to
> the hypervisor-defined MSR HV_X64_MSR_GUEST_IDLE". That means only a read=
 is
> necessary, msr_val is not uesed, so __maybe_unused should be added.
> >
> > Reference:
> >
> > https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/refe=
rence/tlfs
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Xu Yihang <xuyihang@huawei.com>
> > ---
> >  arch/x86/hyperv/hv_spinlock.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinloc=
k.c
> > index f3270c1fc48c..67bc15c7752a 100644
> > --- a/arch/x86/hyperv/hv_spinlock.c
> > +++ b/arch/x86/hyperv/hv_spinlock.c
> > @@ -25,7 +25,7 @@ static void hv_qlock_kick(int cpu)
> >
> >  static void hv_qlock_wait(u8 *byte, u8 val)
> >  {
> > -	unsigned long msr_val;
> > +	unsigned long msr_val __maybe_unused;
> >  	unsigned long flags;
>=20
> Please don't add new __maybe_unused annotations to the x86 tree -
> improve the flow instead to help GCC recognize the initialization
> sequence better.
>=20
> Thanks,
>=20
> 	Ingo

Could you elaborate on the thinking here, or point to some written
discussion?   I'm just curious.   In this particular case, it's not a probl=
em
with the flow or gcc detection.  This code really does read an MSR and
ignore that value that is read, so it's not clear how gcc would ever
figure out that's OK.

Michael


