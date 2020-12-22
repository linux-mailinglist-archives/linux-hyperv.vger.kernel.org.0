Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0632E0FEC
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Dec 2020 22:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgLVVpZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Dec 2020 16:45:25 -0500
Received: from mail-co1nam11on2130.outbound.protection.outlook.com ([40.107.220.130]:29921
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728020AbgLVVpZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Dec 2020 16:45:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2vL6US+xAtBcRrRYftQQ7bATtHVPQMhFZfAcyEX/cpqQ4psgTO8Hj7dzetJHr1IaoPjQlHxXkvzD1NNLscmFbZMLHF4uPIHQcEJJAbgwmBFwID3J2sRfamwciq5DiZzQfmW4p/Qxfm4OdswS7rackjgQcjOifiiMU2wMRuU8wjH+MU5pa1cIm0Wm0sw+2CxsKCMMjD+4X3m7Riw1vMb/tk6wj2nSAmTTV7nTwPyGlJPsrdDF/DcYDKgFmWtn3u46Q0u6A+aCjYIKJ0zg99lhgvCFFCW+3TKsRJQFeHw363nGD7geEIZsRzUmuYG93J+J1nRc/Aw+gMHrU02Akbl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5WwUAe30zWOww0ysRjtaMicApVr9lfW9DGV9kRx4iQ=;
 b=D2OfqIR0wSdSwkbJTKoBtnnYjHZT9gjRI9MhztvCL30VqmfFHuWmTp5gxsBeeAxlH35f0jfTi8h3fZqUuOBBcLr6Z2WPNVKanVAnnRC2ADqtfW5wJXLQyqTc6t9OlD/69FosAG4A8k+zuGwX9Qlez5Ae0q0tQgRytFA8hqu3SS2haRHJAx1i+6Zfljzy48Sd6fGV+lhjoLdH85CRGJuI3C+SAeW6SgjnEiVBY0Q7PB3EzW17RO21Z1vo1i59Z3QDdeHwX/G2PGjl63MbaWKleWxN72RrS4jbcccFfK2ss7v3A8lF41tMTGq7zeiKAaKpHjxV5aQIl6j2gjlX+N+N1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5WwUAe30zWOww0ysRjtaMicApVr9lfW9DGV9kRx4iQ=;
 b=PE+ESb0cqG3JUFb23BTh5WsfOlBn5f5WiTSuVBh6tOWVifK9AAKFn0qzCSKyD9eqyMyT5lkmghaH7AO4bM324sxbF43LsHQ+uHUvkSyrQLQecN2LEOKCxtxfLBuvUoSpd86kkiZr+hUedxQQxs7hqUJIQCgNdFGnZ2qwN5ai5s0=
Received: from (2603:10b6:303:74::12) by
 MWHPR21MB0638.namprd21.prod.outlook.com (2603:10b6:300:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.6; Tue, 22 Dec
 2020 21:44:37 +0000
Received: from MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485]) by MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485%5]) with mapi id 15.20.3721.008; Tue, 22 Dec 2020
 21:44:37 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: v5.10: sched_cpu_dying() hits BUG_ON during hibernation: kernel
 BUG at kernel/sched/core.c:7596!
Thread-Topic: v5.10: sched_cpu_dying() hits BUG_ON during hibernation: kernel
 BUG at kernel/sched/core.c:7596!
Thread-Index: AdbYQq18xc9NlU57RRyWL/lF+Wmp7AAJT/qAAA389SA=
Date:   Tue, 22 Dec 2020 21:44:37 +0000
Message-ID: <MW4PR21MB1857209BF0AB8C074FA4A5B6BFDF9@MW4PR21MB1857.namprd21.prod.outlook.com>
References: <MW4PR21MB1857BF96E59E75EF9CE406E2BFDF9@MW4PR21MB1857.namprd21.prod.outlook.com>
 <jhjlfdqrmc6.mognet@arm.com>
In-Reply-To: <jhjlfdqrmc6.mognet@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fb843c89-09ad-4820-a28a-56ffa5c50622;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-22T20:20:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:3591:4820:2a8b:862]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9be2d7c1-aa32-49b6-7bed-08d8a6c2c78c
x-ms-traffictypediagnostic: MWHPR21MB0638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB063828C199C123369CE9F56ABFDF9@MWHPR21MB0638.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:556;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SbC+0wNP1S55B76qnSW0rTkCnVEXnTSLCzsRsY7GZAq/HV7DziaHNw60szdkduGIZrN1+RWQBs0Toah9zDbZuuogmx8cTuCVYMy0Z5/83Acj15kPya+qR+HUrE9d/Jem8fLhAuZ23RWZAJLND5Z3zGSg4AKcI5LNoNRWevp2HRFEAo4bXUDakrHF7YU+5bI36Hn7s7PLwTPV2G6OtdGuRP0x5Kjen6vwiFETeYjPrvgHvZbu3g3Nc8WX1mstAP1VY/TMOJSEIB7PSd9esO1OUbZ/UoaDXi/Da8ZBLUR0T2Y/zemxcJ4LLUdWNvmW4jcjKNkW7IgC3sDa21Ufugxzguvygc418ql8UyOcxhn1eMEQs2dM5uFMgsXhkmUDgEfRS1kQwHhCltvlOepC8+aY8JcCDKE7ybpfskOq5C6E6q0abmqj++qPL0nZQ/UotuYElN6V0OSC44XQklHfAPD1SA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1857.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(7696005)(66446008)(76116006)(86362001)(186003)(54906003)(66556008)(6916009)(33656002)(478600001)(9686003)(4326008)(66946007)(316002)(64756008)(83380400001)(66476007)(5660300002)(7416002)(107886003)(8676002)(52536014)(2906002)(966005)(53546011)(82950400001)(8936002)(82960400001)(8990500004)(6506007)(55016002)(10290500003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FUsixhVWT0K7CTQvApYUXTHb4T9D/OMW3bLhzN1n2ojWZTfAj/ULuoyhJwVc?=
 =?us-ascii?Q?p82ug2nP1cajGgpHjuuTBluuutJOXSsy+sbo6++0PsxTAFGnyOqzwJDU8dsj?=
 =?us-ascii?Q?h4v60POgx1yC0uaOi5YTUUc7KHLZHm6keSNUio/9AL5XkkoMwHp/4VzCF6gi?=
 =?us-ascii?Q?S51Qg9xmyFYNlfwNqhgTE6Qiq6cs2YwWkILPV7eb71+SByVtvqePrOXKA/lV?=
 =?us-ascii?Q?sof2wFvDL9/F4rvDyVSQhkew+QUDJ5CsTjvH1mKxO2MAYt0W3Rc6kbad1Brg?=
 =?us-ascii?Q?Lkcl7LR9Re00WVfy51ZePtqRzLEFau1ETvil1oxpP4ZTOAydwzGIaU5o2Lzi?=
 =?us-ascii?Q?gotyYNa6f6BluaC+JBvs7NU4DRQguVlAFfWZLZOG+mxep0CE2wV82bbv8MNM?=
 =?us-ascii?Q?68fuByQKJUQQ+TLXMI0g1SYyjM6DWUosvePTPvd9TyioJzdPvcemovUKTGIs?=
 =?us-ascii?Q?Bb6khKf/UKoAYI4hHT4cSxezGmtACVVJ75xAy+EmzNyARPTDFatrbBlCnTOt?=
 =?us-ascii?Q?xgYHnOsxBJc5REmNseR7UbsAGYDUzAERdBmFErrPFKF3h4syq/0rlSfhgPWr?=
 =?us-ascii?Q?KfoXwgMZE4/UX6GilKL46BN4FZ+Krd5m0fqKdVFaa3GN0ZXeIHtf6/vuV4Tn?=
 =?us-ascii?Q?9Vj1a2HTWL9Rnr1RSkxAcVq0h8mvpXolkTo2dquBT8FNqX4O2c3t8Bcawmjr?=
 =?us-ascii?Q?h96x6DZk9452x6G8JA20z+s5bODqNWofhZ17njPdUzTX7nUeHd6oFpwqk3bR?=
 =?us-ascii?Q?90T0NuVLxdFsnKwX0q6/XSi2IF7D3EVAGk6BgXnaChFc6Ljgq6UXIPAzc+Lg?=
 =?us-ascii?Q?Mate4xMR2IMSLewJo3bkNCSLrkkc3xFUyA70O5eR8hKQ8EFbqiJCsTcHugb1?=
 =?us-ascii?Q?lJG2hodV7l5DutSgxJgZOIfLHemUWMROWXt4fBGmV+EQGuaFN0qZRHy0XPXb?=
 =?us-ascii?Q?u/YETT8+Qa8Ah9pYiO1BYsd1W+oW/60MtyYhV5R6mZpEVtNJ1L5DaE8s2upq?=
 =?us-ascii?Q?45rTRjlC4kKhf9QxGf/Z6mRQKfbR6m1FKI2XRS9FbKRAnjw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1857.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be2d7c1-aa32-49b6-7bed-08d8a6c2c78c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 21:44:37.3608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AHnKklLLjPsjvFPJuQnSR2u+BiKecOtMQJHxcHNf1Y+q3fIptZWf9GGwnz20oRlRzOA1KhULv419QLhjZtbAew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0638
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Valentin Schneider <valentin.schneider@arm.com>
> Sent: Tuesday, December 22, 2020 5:40 AM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: mingo@redhat.com; peterz@infradead.org; juri.lelli@redhat.com;
> vincent.guittot@linaro.org; dietmar.eggemann@arm.com;
> rostedt@goodmis.org; bsegall@google.com; mgorman@suse.de;
> bristot@redhat.com; x86@kernel.org; linux-pm@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; Michael Kelle=
y
> <mikelley@microsoft.com>
> Subject: Re: v5.10: sched_cpu_dying() hits BUG_ON during hibernation: ker=
nel
> BUG at kernel/sched/core.c:7596!
>=20
>=20
> Hi,
>=20
> On 22/12/20 09:13, Dexuan Cui wrote:
> > Hi,
> > I'm running a Linux VM with the recent mainline (48342fc07272, 12/20/20=
20)
> on Hyper-V.
> > When I test hibernation, the VM can easily hit the below BUG_ON during =
the
> resume
> > procedure (I estimate this can repro about 1/5 of the time). BTW, my VM=
 has
> 40 vCPUs.
> >
> > I can't repro the BUG_ON with v5.9.0, so I suspect something in v5.10.0=
 may
> be broken?
> >
> > In v5.10.0, when the BUG_ON happens, rq->nr_running=3D=3D2, and
> rq->nr_pinned=3D=3D0:
> >
> > 7587 int sched_cpu_dying(unsigned int cpu)
> > 7588 {
> > 7589         struct rq *rq =3D cpu_rq(cpu);
> > 7590         struct rq_flags rf;
> > 7591
> > 7592         /* Handle pending wakeups and then migrate everything off
> */
> > 7593         sched_tick_stop(cpu);
> > 7594
> > 7595         rq_lock_irqsave(rq, &rf);
> > 7596         BUG_ON(rq->nr_running !=3D 1 || rq_has_pinned_tasks(rq));
> > 7597         rq_unlock_irqrestore(rq, &rf);
> > 7598
> > 7599         calc_load_migrate(rq);
> > 7600         update_max_interval();
> > 7601         nohz_balance_exit_idle(rq);
> > 7602         hrtick_clear(rq);
> > 7603         return 0;
> > 7604 }
> >
> > The last commit that touches the BUG_ON line is the commit
> > 3015ef4b98f5 ("sched/core: Make migrate disable and CPU hotplug
> cooperative")
> > but the commit looks good to me.
> >
> > Any idea?
> >
>=20
> I'd wager this extra task is a kworker; could you give this series a try?
>=20
>=20
> https ://lore.kernel.org/lkml/20201218170919.2950-1-jiangshanlai@gmail.co=
m/

Thanks, Valentin! It looks like the patchset can fix the BUG_ON, though I s=
ee
a warning, which I reported here: https://lkml.org/lkml/2020/12/22/648

Thanks,
-- Dexuan
