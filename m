Return-Path: <linux-hyperv+bounces-1400-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1A9828E73
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jan 2024 21:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766EBB21757
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jan 2024 20:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AF23D57E;
	Tue,  9 Jan 2024 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GJqIo1Sf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2356B3D960;
	Tue,  9 Jan 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ovf1agRxy/Hi4nELPPtEVvKsWAt3fYz5A4F7fX2myeRwRugXN4WvH6i6EUQ2969iFg4w1JlijLv7CWelfyxcECSQkE4P6eW3+JIZcKk3euI3tgxPNDIrtBWVTW4IRWluKd8I23OrXs20UCszm9OlsI9VDHK1ZXnhy9LDpdTvHwmcD7Aapwe4Dby31K73mWoIfYIUBGTOgoijxCKHvPclwKnsPkwHX3mSLRqVH16zOkiueVHLpwphYo+2h2wWwU/imjCFbveLPTfVkG6pGSAPHr4P+JC3pBOTfgUZEsih6OiORVyK6zsIM8NQiUMUPwzGDID6JYUZeKNlDVhMqV6kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKzGFp9FgW3wR9OyfRAXhDBtiqppm9rPvsv5h3AL63M=;
 b=BK1dN9bbGsrud5gwXjkhaxuuUWxsWGbT5rZg5TOvQ0xLrpGcGhWEHG102Wua4Fi+Ub3C9E/37yHeMmPazWbcGL6gQQu625tCUgP9r7/zzfP6JjECkBP/oUwzxuTGv/DLf7x/k4eOeDPaIDWoSlEl3Cq7Ee+bKcClqBREY6aGa3NokdCalFH+xppS38Iyg4DLoaG3Qhdbl9MIKp8tQoiMcbkqHI0Hp1bueyMFhxjdQa/PikMXol5tSNkABopz3lb9V9fmuHBssXxPbwsP3SYwakNReQSghFC9+Abb+XYAvl0CK8Ti4CnBoA4y+lpiUQwXI1YmJefdtdUi/0zyLNwD8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKzGFp9FgW3wR9OyfRAXhDBtiqppm9rPvsv5h3AL63M=;
 b=GJqIo1SfQAPSbdt4tPFQIX58qR1aX4MTDJJ6jynecEgLSXoTvjaGZMwk6Lv0E/+Sd5mwjGcLLzFFDszEC88gZ83YRQ3IS+EaPtXaqRcUyW1xs8zc17/V0Z4RvvlAmiANT+3Fw+zNiNSxwOE2RXnR5LRJbzxw+zoQWwIQwq67UI4=
Received: from MW1PEPF0000E691.namprd21.prod.outlook.com
 (2603:10b6:329:400:0:2:0:15) by DM6PR21MB1513.namprd21.prod.outlook.com
 (2603:10b6:5:25c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.8; Tue, 9 Jan
 2024 20:20:31 +0000
Received: from MW1PEPF0000E691.namprd21.prod.outlook.com
 ([fe80::a93b:72df:f1d8:6026]) by MW1PEPF0000E691.namprd21.prod.outlook.com
 ([fe80::a93b:72df:f1d8:6026%4]) with mapi id 15.20.7181.004; Tue, 9 Jan 2024
 20:20:31 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
	"yury.norov@gmail.com" <yury.norov@gmail.com>, "leon@kernel.org"
	<leon@kernel.org>, "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Souradeep Chakrabarti <schakrabarti@microsoft.com>, Paul Rosswurm
	<paulros@microsoft.com>
Subject: RE: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs per
 CPUs
Thread-Topic: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs
 per CPUs
Thread-Index: AQHaQunR3RrbavDz00+r/Bf4otFslrDR3JYAgAAND8A=
Date: Tue, 9 Jan 2024 20:20:31 +0000
Message-ID:
 <MW1PEPF0000E6910254736DF77F99E04DD4CA6A2@MW1PEPF0000E691.namprd21.prod.outlook.com>
References:
 <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1704797478-32377-4-git-send-email-schakrabarti@linux.microsoft.com>
 <SN6PR02MB4157CB3CB55A17255AE61BF6D46A2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157CB3CB55A17255AE61BF6D46A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5a560160-a342-4beb-ac00-2af74747d2e4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-09T20:09:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW1PEPF0000E691:EE_|DM6PR21MB1513:EE_
x-ms-office365-filtering-correlation-id: a9c9686e-c6c1-4eae-41f2-08dc11506ddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VBMopLyw0pSeXlriJxmz6C/nRJ0ihN2wYJR//niZVLAjb5zHZ7kDwLcLr8n8GTHsZi3I21SKbUjSoYAZ+/lB0VV4wtK5JxZBhfi89XwwCfnSr8td6CSnpS5VoP/rH1EvIDGBv/VhO98Vhz/Fav+jaTTKMV/IVKmFPfYCpgKyZr3XqoACRofHp48irmm+mdfT760TqUe5gaNRHGm2fiMsa6/Dj/Ul4dkxXVTrbGVzfzPl5xtxIluNULhXu1ITP21OsW1CsqBKTNU2PsILlccgm489hb0ptJGLcZ0t6zfQhVERx74eOWDBMA6IP3e077H4BlHHOpb4fdDPH7RWY+3Y5E/rg4tTJe/aXAMSqy0y97R3hAUL66a5ZqV4p7/jR9T9azqHGhjRamIEsROgPR3N8TAIfOmQioJsm0Ikg/KDJke9NJl9Xhax5fXQnEzhOBSX1NZjosKrnhLY0R3X8AbM7FMuGaD4d9U7/DdLvmbvNI/8XMG9InVvhFa2ZWj8srUdAQ+gNyTj/oCzM993JIYTcrNgWCdy+UQjRQIWcBxmsTOJwiuxgT0kgTSmtlL0WR9rdIyR82/k87GB3KEDqfmOtpNAry6vyzjU6ZGxcYRet68AZU+RXKuP9fCJP9NykwZ21OVDabsAI+czsYgu/8K/BYusUE3ofGECmWQH74ctaAWclouaxOiRKU/5KVV8ziG9ZkSzGB5TmmAKZ8jncGAgufM5r6wxoV4pm4oNIi5x15k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW1PEPF0000E691.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(966005)(7416002)(478600001)(5660300002)(71200400001)(82950400001)(33656002)(10290500003)(6506007)(86362001)(107886003)(53546011)(8676002)(7696005)(9686003)(66446008)(8936002)(316002)(41300700001)(54906003)(76116006)(66556008)(66476007)(64756008)(66946007)(122000001)(38100700002)(83380400001)(26005)(82960400001)(4326008)(110136005)(38070700009)(52536014)(921011)(55016003)(8990500004)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?A015Rdkr+AqbMNqk+4ztZhFAUDkDkFWdZLk6Q+p45aKrVB8h9eStLfH8Kixc?=
 =?us-ascii?Q?9vRT52dKld4trsFz8/cbk2l8jAzrEe/SsmRDhKLcVE8KFTd+CpxrxQqWyM54?=
 =?us-ascii?Q?bsEfHhtkPzntBnW3zw8xmHAzAxvzYSkjcq6PKLuEDyYSnBnJ1cx3Su0SK3ED?=
 =?us-ascii?Q?twp4DWUreuyqvTCVHnN6WeEwHqoW/aaMF3no6URDlBGJTA9+l313iX4S0wfa?=
 =?us-ascii?Q?RYEUNFozhpLbN+pmw5HfuTN6M5M5B5bKeoyHEhEPjVohVyp4W2jwR6Qv1ndp?=
 =?us-ascii?Q?lqASqRPvDgiqN0vSlVfD3YwZqlsXPK1XbhrZuPFJ4iobwgd249QwsXXVcC7s?=
 =?us-ascii?Q?qm91JhUXq7sITKUm5+q3C8UCm4krNWuk9oNOWQ4JHduN0CU0vYhaWVz3Z3pQ?=
 =?us-ascii?Q?SSYfF5iYlEZO5vHH35co79ww3L8AHuf0VGeLPb9YBwJ70kB3wR1L5fgsmMfu?=
 =?us-ascii?Q?20MhuGnLAWhbd0B5Pm7h60RSm4THVpnvY4G+nr/tc9/haQ+FEOeONrP5yrII?=
 =?us-ascii?Q?uEwvPVOuQ4EO3iBcc+Jckq5uM8nJ7tnznWyVDf0SGCun/ALi6Nna3BFTOQvv?=
 =?us-ascii?Q?VyMf8lOWTxAbbHa5UWF6JoZa/g4e2gWAC8nwTNFP+aZJ129SmQp7rus5/OFZ?=
 =?us-ascii?Q?PqDfVHUm1Uvs5rkN5GV2+i/9CeBrJ9guVEK1G6m1bxuVN0hIA1QMASMT3nNR?=
 =?us-ascii?Q?ff5U9+jznGwyCm2Pp61sfK30nrO4I2g5XyUgWHFFdvmdQILGJbvUytbDKCYW?=
 =?us-ascii?Q?ZDL7Yuf0kjxa74nPvmGC7jaG5DtAlZqVV9uhrqtiQvaKODOdBPVWzW2AtC4R?=
 =?us-ascii?Q?/CHpu/AwDExyOibpZb6yyXsT9HNbYf+pSq5o5NCgeyhJ3HyhxvmMwuDxodzq?=
 =?us-ascii?Q?F7/bQtmGNu0w25I02sbks0gAcU9dUZG5xubsksq46W7f7l4t5LLlArpIaXes?=
 =?us-ascii?Q?7N00JSpogT3ukZJAfR+mdmRDFllHb12CY+tGThq6wlALtMXZ0ZoOJGYGkbeO?=
 =?us-ascii?Q?XPBe4yGJl1t7lignTjdtvuetd2EdIURtD3fIjdT6Lt5jJo/2R+O3+Ou0sFOQ?=
 =?us-ascii?Q?FvJOlXMxN10pE1OqetEmadpNu1lgiG7ZyNmNmfLfMz3lPwdPt48gSwvi6n/t?=
 =?us-ascii?Q?gWjMKpXinRcH5lqer2L9yRIpdQkDn0cjYb7MQyjVheJdx+J4H8OU3eIfSdWY?=
 =?us-ascii?Q?BZv2x5V4qXjDTmb28Jtr9Eh4WWzOIgLoAsSztycHGEvAZkM8zSEe5Z8OsbMK?=
 =?us-ascii?Q?dDix3DN/CyzSp9fciT3gb7JSrRoqoWEfuUhUTn8uM+AQbcpRBvGVVDUvou5N?=
 =?us-ascii?Q?bLZstuM40hJuU+/FWVjNORI1pYwWQllfBRZEDNVwR5Ch5FKTzYE7YScrJOcK?=
 =?us-ascii?Q?C1gRltVCYcWwHzVf2Ai+M/qgUYPnEVPv4pknDi8XCdb3qwHLBrE137oIXSEt?=
 =?us-ascii?Q?N1uWCa/zGgbdmtbmd9n9nPXYItY9hfoyJXecKIsgC6QTLF2XGXQmGs7i/wMp?=
 =?us-ascii?Q?00zf2xvY0bNr+paXiRW/El39eGjuiWuF8c6VAOb2NSAxGeIjzXhmK+qz/YY2?=
 =?us-ascii?Q?m9rjELApG9nkAx6TGH/zsSn4NykrmUM3TNfcGahJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0000E691.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c9686e-c6c1-4eae-41f2-08dc11506ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 20:20:31.7615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KA9tbIuXQYbayE15rR7SFvGqMWwJGWk/EbExkZXygxekKjgRXnPqhge21fbwk5ylJc4I6ALWV/Wgiqyzj2Dv3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1513



> -----Original Message-----
> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Tuesday, January 9, 2024 2:23 PM
> To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>; KY Srinivas=
an
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Long Li <longli@microsoft.com>; yury.norov@gmail.com;
> leon@kernel.org; cai.huoqing@linux.dev; ssengar@linux.microsoft.com;
> vkuznets@redhat.com; tglx@linutronix.de; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>; Paul Rosswurm
> <paulros@microsoft.com>
> Subject: RE: [PATCH 3/4 net-next] net: mana: add a function to spread IRQ=
s per
> CPUs
>=20
> [Some people who received this message don't often get email from
> mhklinux@outlook.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com> Sent:
> Tuesday, January 9, 2024 2:51 AM
> >
> > From: Yury Norov <yury.norov@gmail.com>
> >
> > Souradeep investigated that the driver performs faster if IRQs are
> > spread on CPUs with the following heuristics:
> >
> > 1. No more than one IRQ per CPU, if possible;
> > 2. NUMA locality is the second priority;
> > 3. Sibling dislocality is the last priority.
> >
> > Let's consider this topology:
> >
> > Node            0               1
> > Core        0       1       2       3
> > CPU       0   1   2   3   4   5   6   7
> >
> > The most performant IRQ distribution based on the above topology
> > and heuristics may look like this:
> >
> > IRQ     Nodes   Cores   CPUs
> > 0       1       0       0-1
> > 1       1       1       2-3
> > 2       1       0       0-1
> > 3       1       1       2-3
> > 4       2       2       4-5
> > 5       2       3       6-7
> > 6       2       2       4-5
> > 7       2       3       6-7
>=20
> I didn't pay attention to the detailed discussion of this issue
> over the past 2 to 3 weeks during the holidays in the U.S., but
> the above doesn't align with the original problem as I understood
> it.  I thought the original problem was to avoid putting IRQs on
> both hyper-threads in the same core, and that the perf
> improvements are based on that configuration.  At least that's
> what the commit message for Patch 4/4 in this series says.
>=20
> The above chart results in 8 IRQs being assigned to the 8 CPUs,
> probably with 1 IRQ per CPU.   At least on x86, if the affinity
> mask for an IRQ contains multiple CPUs, matrix_find_best_cpu()
> should balance the IRQ assignments between the CPUs in the mask.
> So the original problem is still present because both hyper-threads
> in a core are likely to have an IRQ assigned.
>=20
> Of course, this example has 8 IRQs and 8 CPUs, so assigning an
> IRQ to every hyper-thread may be the only choice.  If that's the
> case, maybe this just isn't a good example to illustrate the
> original problem and solution.  But even with a better example
> where the # of IRQs is <=3D half the # of CPUs in a NUMA node,
> I don't think the code below accomplishes the original intent.
>=20
> Maybe I've missed something along the way in getting to this
> version of the patch.  Please feel free to set me straight. :-)
>=20
> Michael

I have the same question as Michael. Also, I'm asking Souradeep
in another channel: So, the algorithm still uses up all current=20
NUMA node before moving on to the next NUMA node, right?

Except each IRQ is affinitized to 2 CPUs.=20
For example, a system with 2 IRQs:
IRQ     Nodes   Cores  CPUs
0       1       0      0-1
1       1       1      2-3
=20
Is this performing better than the algorithm in earlier patches? like below=
:
IRQ     Nodes   Cores  CPUs
0       1       0      0
1       1       1      2

Thanks,
- Haiyang


