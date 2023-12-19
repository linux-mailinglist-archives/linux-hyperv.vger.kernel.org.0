Return-Path: <linux-hyperv+bounces-1358-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DC581852C
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Dec 2023 11:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB04B23CDF
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Dec 2023 10:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFD314297;
	Tue, 19 Dec 2023 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SQf7JJVB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF9D14A8C;
	Tue, 19 Dec 2023 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bY2RG+3MrvNjpYDCdQQh83GmdDzoDptm59lp6QKVpFgQXH1+d774SFUVynsEREvWO/mPSUlJIWjj4smXlFJEx5eOQp8Ps0qIELgeo8iN2sqn8OydhoHIx0KXAKXYzU2hYI220p0u2QSkgE59292haG94+OYw8ay18sHKLJx3R8iqJaWjsyIgJRHlCBsf8NTYXuvGUBlVVrPodWT15yBhWjSHUqTjVAoFgWDRQXUzbD+oDXBTvR5Ig5G82GXIkHMGZAL6Abxf7PYFlFcpX+Nv/RBezAdWUJQufht/jm9ss8mayuZf1E/Hl79+TvyuFX8EnKbHRmklhX1LN6hfNdBIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCF5JARY+BjQahLVPGb2OXHIrVlMOs7evKeLmHAYUGE=;
 b=C3G07rNug4HU2P6xoYdI5w0JxrXV/iIn/9UNh+nzT31wYkQsER1Q7i36OAVhBxCq6AJk2sUwo9cx293lxUHCtsJUsylFYJO+7lZ4QEwTxmG07crRfzWtvf8XnYq/v1xRsFa2X6pVcHoIq8t6ZkVsl+Ez2yXQXX/6cnLZKNbpw965by0du3aR/1D5tNOo5bcdY9mod5+JML1gBHY1PybTMgR7UHxo76eBRkey6xdtGfJkeWTfiR56cB/YKceoFKLAV1E3sF3hQteetgBC87N0Q/z7koK+kD3ZalhDEQyKKEz5vJ81ZgWyTypJlZlmlDacV5KJHGS+B01HH+xu3Ehfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCF5JARY+BjQahLVPGb2OXHIrVlMOs7evKeLmHAYUGE=;
 b=SQf7JJVBGo0fttS8z7GrLDlex5y9rq3GB/LWBR6EQKOc/8hdtFDGeHsopu5NAA4uYSgrp28PxYNPaRZIUHSuODqQPpXRVgfXXEdgh6UWKixHomGnjQbJn9adDW/K11RhMPBhHiFQuG3krrLibCvEGChT7LYrVRRUtmy0Ph+wDv0=
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM (2603:1096:301:fc::10)
 by TYZP153MB0722.APCP153.PROD.OUTLOOK.COM (2603:1096:400:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.5; Tue, 19 Dec
 2023 10:18:51 +0000
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::a516:f38b:f94e:b77a]) by PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::a516:f38b:f94e:b77a%7]) with mapi id 15.20.7135.004; Tue, 19 Dec 2023
 10:18:50 +0000
From: Souradeep Chakrabarti <schakrabarti@microsoft.com>
To: Yury Norov <yury.norov@gmail.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH 3/3] net: mana: add a function to spread IRQs
 per CPUs
Thread-Topic: [EXTERNAL] [PATCH 3/3] net: mana: add a function to spread IRQs
 per CPUs
Thread-Index: AQHaMTCKhnR8tJj+p0KJn4+4XMR1UbCwUJwA
Date: Tue, 19 Dec 2023 10:18:49 +0000
Message-ID:
 <PUZP153MB07886CE88351F6B7A2AA0096CC97A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References: <20231217213214.1905481-1-yury.norov@gmail.com>
 <20231217213214.1905481-4-yury.norov@gmail.com>
In-Reply-To: <20231217213214.1905481-4-yury.norov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fbde9cfe-746d-49e8-9d17-76251d074056;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-12-19T08:58:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0788:EE_|TYZP153MB0722:EE_
x-ms-office365-filtering-correlation-id: a366854b-99eb-42de-3b47-08dc007be4da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wR54oCGciXG8a0qlwa4Dxb768M+6lFMfNid8BCUHXoIAWInyJjBs/eFk5i3bDyDr4UhkO69elV4t0seryhcI4jqvWhVgBAfJQkgrrVVjLRG560ZB+xJ9Eqa5iCLponUM1zK2rwG1+hpHB6Ks+/YIDXUapmUJ3yPgm1wYdkH01+Y9NrnZ0W/dqCkf8nr/2fk3oGYjNdzAmEiWzMsH6DmAY5+asSqiKRoETDNAqppxuM4hDxeffVzcw+nodLjNN8B55Lof7IT/VSOcWUBnV+t2Zi3tOOW/VgCzQeQqN57ZwB2V6D7NfaQOr90ys0Ba51BOULtASk1z9qqdP4W7jQjDZs2uisVW7kypAln3oSXYT/yjxSMqfvI/i+0g55N8y38fjitVmPS4w36yjNW0PyBSmYYOq5aKDTaOrWLe+fvbZxflKlo+D5VoWncm++GKTKk3kfjkMeI5y1XqxfbKVduPjR4izqrAhj9RDkUZn/Pmt09tl02dreD5V713hDnceUl47OQolPGCceQP3sHCUTe6ICxz0Hgw7DI6DqnaZhSF9ruqExkvQ3EvIfb1WIiKLI/SyPyhNWQjCTx4/gJUgFPRz+vApugXGlrK2WrHKHjZUiFYb3+ZLNKlg/4q5Lx9DbgZV/+XxgIscw2gfaBwBEnW/ue835WDevRGPyf8/TPjxAzBzIufXObfNTy17hXtWdKxakN0ixNf7zHCblPb1skKvQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0788.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230273577357003)(230922051799003)(230173577357003)(186009)(451199024)(64100799003)(1800799012)(55016003)(26005)(107886003)(10290500003)(7696005)(71200400001)(9686003)(478600001)(38070700009)(82960400001)(82950400001)(38100700002)(122000001)(86362001)(921008)(33656002)(66476007)(6506007)(76116006)(66946007)(64756008)(8990500004)(66446008)(83380400001)(66556008)(5660300002)(7416002)(2906002)(41300700001)(316002)(52536014)(8676002)(8936002)(110136005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?re1sgz+OC50gaxeq0MxHWuD4ZYvx6GSYf3GToy2Lv3v+AcHYozbdubBN5oqp?=
 =?us-ascii?Q?S76OZAv+qnBg4bkItGh4V3apu0nrUJo2ylmPV95DDyKo3aWW/IKSfLWNR0Ap?=
 =?us-ascii?Q?fa/YXaqy+DmFs+dv23sEhGLRPM6rlYNAsH6EYxDdVEZjQpespcUtdWu43ynN?=
 =?us-ascii?Q?hC7pmWSGAnvL2DTk0lztN2P6Yuo33ifGu1FM0AKUtndciG3ePG4NqqMRV06F?=
 =?us-ascii?Q?e3BDSYThQA5/1+svxtseGUypziFaf1/CWV51pyLbGe6HeJedGD61dbAg7TKh?=
 =?us-ascii?Q?EHkAC+zhLgOoBNTeUvbhkj0+eYtkEaV0GQufl0QOzJfPC4mAcujUXV1vKg//?=
 =?us-ascii?Q?laMJc0yDqyOdbjuI0aEBqVQRt1OiL/uN7ZrUNYFNbCBX/WZt0F/lV5A2q4F2?=
 =?us-ascii?Q?W17ylQGski8yZ+EM/a50OmETaHXUG1haeV88k8rnG6JXoca8py7FGsOvzC4G?=
 =?us-ascii?Q?lCY8Y6BTU/S8Me7LEBUIkQhDzkcLCXE1Gryr8kzJjFtQJS8VtnbjugnwFKdR?=
 =?us-ascii?Q?TdLACU6TjlsHwd16X1J0nWbj6YM1aLCIFaDPR2ZxhRnbuzlrTTji94I4rge0?=
 =?us-ascii?Q?gJKcj1FUxX6vmnZynCiyar0PXKGwb2IMTbUPlV2XmdCAnTmp3HWG4bVSzj6q?=
 =?us-ascii?Q?7uYVmC4QI6JYjVoL6tWh2jjUv5WZhSW2u6r8+L54vV3yES+MwRZBdDmbo6wt?=
 =?us-ascii?Q?vuIR1CKkbIoguIM15f/b6CTtH507FCEKU7dsu2x2LbsP6wepemV6e7IT1Ucr?=
 =?us-ascii?Q?s2nz5/py4rHxXd+H7E9qZgIOQrF8nuWljEvDJVm0s8QTizRj1naO2d0WZGpn?=
 =?us-ascii?Q?/VgD7g0iOC0tALuTITxw8JPy1vKTXOaORKvLOzrvgSrDRK2dt8M4VGpFzu7A?=
 =?us-ascii?Q?xpMhkyqDRsq6RdUOLgJCmHii0srDgsyeDn4pTYCjQ5wLoG/7PATR3uGeBSgw?=
 =?us-ascii?Q?jllRxMbj26bA0wgAhejNRe1d2gVfeYqHJUhuVTOfK1bSpJ8fuZI4wqgwbUDd?=
 =?us-ascii?Q?CDLGMw94inArvuvTCzP/dqbOTdLR08o59jTgiU42lorWxzJGzGyxkZ9TEYnR?=
 =?us-ascii?Q?m7EGMjnbcztvq5IFOjQedWQdIZv502rwXO2nXWxi486IstjxUnW4TTWxbQak?=
 =?us-ascii?Q?jMh3RaXWLnrFFGYTOuGRR+To/GqCoWGLC1q+Q/ZtnKqBs6PtGUVXUR4gRULS?=
 =?us-ascii?Q?68MOieYHBtwHDoIA4Zkxihe6jQcUNV05TLAm/OY2SKoSn7Jd3yxI0UCuCOYZ?=
 =?us-ascii?Q?F8fsfXdifETp31yZFYDLgCwve6OjEHYIHCG8EiI7Ow3u/yz15Yaco4IuldXs?=
 =?us-ascii?Q?mxEfmgww/bIbSsAkXspnhvShkTzNQg7bZFl1M2QBwTsyiZewFmjzSRO0tkBv?=
 =?us-ascii?Q?oHhCk+oIJb3WpN/fuGYz1ek7xFhbY6GEQYWuU8OLXOPknfUU17P7nnC01+NH?=
 =?us-ascii?Q?6N0QY+JpqMyolwAPIQJmcEBgAsArbVwlI15qlsRVh96q9NS32vdHrfjT70ah?=
 =?us-ascii?Q?ttnEwMDyCzBjUlbC7UaQme7eBxNcflVAbPaM?=
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
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a366854b-99eb-42de-3b47-08dc007be4da
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 10:18:49.9959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2puyuMVzyPv4zB237yI84f7guG+97m5DQ6UPJu4JRrBtszfwt42pd84/IcY2ZyuxeQWlEPfMJ5LxzvifYZAMrz4sSS/U+ZpkxGPtBg42TA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZP153MB0722



>-----Original Message-----
>From: Yury Norov <yury.norov@gmail.com>
>Sent: Monday, December 18, 2023 3:02 AM
>To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>; KY Srinivasa=
n
><kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
>wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>; davem@davemloft.net;
>edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Long Li
><longli@microsoft.com>; yury.norov@gmail.com; leon@kernel.org;
>cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com;
>tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; =
linux-
>kernel@vger.kernel.org; linux-rdma@vger.kernel.org
>Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>; Paul Rosswurm
><paulros@microsoft.com>
>Subject: [EXTERNAL] [PATCH 3/3] net: mana: add a function to spread IRQs p=
er
>CPUs
>
>[Some people who received this message don't often get email from
>yury.norov@gmail.com. Learn why this is important at
>https://aka.ms/LearnAboutSenderIdentification ]
>
>Souradeep investigated that the driver performs faster if IRQs are spread =
on CPUs
>with the following heuristics:
>
>1. No more than one IRQ per CPU, if possible; 2. NUMA locality is the seco=
nd
>priority; 3. Sibling dislocality is the last priority.
>
>Let's consider this topology:
>
>Node            0               1
>Core        0       1       2       3
>CPU       0   1   2   3   4   5   6   7
>
>The most performant IRQ distribution based on the above topology and heuri=
stics
>may look like this:
>
>IRQ     Nodes   Cores   CPUs
>0       1       0       0-1
>1       1       1       2-3
>2       1       0       0-1
>3       1       1       2-3
>4       2       2       4-5
>5       2       3       6-7
>6       2       2       4-5
>7       2       3       6-7
>
>The irq_setup() routine introduced in this patch leverages the
>for_each_numa_hop_mask() iterator and assigns IRQs to sibling groups as
>described above.
>
>According to [1], for NUMA-aware but sibling-ignorant IRQ distribution bas=
ed on
>cpumask_local_spread() performance test results look like this:
>
>./ntttcp -r -m 16
>NTTTCP for Linux 1.4.0
>---------------------------------------------------------
>08:05:20 INFO: 17 threads created
>08:05:28 INFO: Network activity progressing...
>08:06:28 INFO: Test run completed.
>08:06:28 INFO: Test cycle finished.
>08:06:28 INFO: #####  Totals:  #####
>08:06:28 INFO: test duration    :60.00 seconds
>08:06:28 INFO: total bytes      :630292053310
>08:06:28 INFO:   throughput     :84.04Gbps
>08:06:28 INFO:   retrans segs   :4
>08:06:28 INFO: cpu cores        :192
>08:06:28 INFO:   cpu speed      :3799.725MHz
>08:06:28 INFO:   user           :0.05%
>08:06:28 INFO:   system         :1.60%
>08:06:28 INFO:   idle           :96.41%
>08:06:28 INFO:   iowait         :0.00%
>08:06:28 INFO:   softirq        :1.94%
>08:06:28 INFO:   cycles/byte    :2.50
>08:06:28 INFO: cpu busy (all)   :534.41%
>
>For NUMA- and sibling-aware IRQ distribution, the same test works 15% fast=
er:
>
>./ntttcp -r -m 16
>NTTTCP for Linux 1.4.0
>---------------------------------------------------------
>08:08:51 INFO: 17 threads created
>08:08:56 INFO: Network activity progressing...
>08:09:56 INFO: Test run completed.
>08:09:56 INFO: Test cycle finished.
>08:09:56 INFO: #####  Totals:  #####
>08:09:56 INFO: test duration    :60.00 seconds
>08:09:56 INFO: total bytes      :741966608384
>08:09:56 INFO:   throughput     :98.93Gbps
>08:09:56 INFO:   retrans segs   :6
>08:09:56 INFO: cpu cores        :192
>08:09:56 INFO:   cpu speed      :3799.791MHz
>08:09:56 INFO:   user           :0.06%
>08:09:56 INFO:   system         :1.81%
>08:09:56 INFO:   idle           :96.18%
>08:09:56 INFO:   iowait         :0.00%
>08:09:56 INFO:   softirq        :1.95%
>08:09:56 INFO:   cycles/byte    :2.25
>08:09:56 INFO: cpu busy (all)   :569.22%
>
>[1]
>https://lore.kernel/
>.org%2Fall%2F20231211063726.GA4977%40linuxonhyperv3.guj3yctzbm1etfxqx2v
>ob5hsef.xx.internal.cloudapp.net%2F&data=3D05%7C02%7Cschakrabarti%40micros
>oft.com%7Ca385a5a5d661458219c208dbff47a7ab%7C72f988bf86f141af91ab2d7
>cd011db47%7C1%7C0%7C638384455520036393%7CUnknown%7CTWFpbGZsb3d
>8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
>7C3000%7C%7C%7C&sdata=3DkzoalzSu6frB0GIaUM5VWsz04%2FsB%2FBdXwXKb26
>IhqkE%3D&reserved=3D0
>
>Signed-off-by: Yury Norov <yury.norov@gmail.com>
>Co-developed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>---
> .../net/ethernet/microsoft/mana/gdma_main.c   | 28 +++++++++++++++++++
> 1 file changed, 28 insertions(+)
>
>diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
>b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>index 6367de0c2c2e..11e64e42e3b2 100644
>--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
>+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>@@ -1243,6 +1243,34 @@ void mana_gd_free_res_map(struct gdma_resource
>*r)
>        r->size =3D 0;
> }
>
>+static __maybe_unused int irq_setup(unsigned int *irqs, unsigned int
>+len, int node) {
>+       const struct cpumask *next, *prev =3D cpu_none_mask;
>+       cpumask_var_t cpus __free(free_cpumask_var);
>+       int cpu, weight;
>+
>+       if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
>+               return -ENOMEM;
>+
>+       rcu_read_lock();
>+       for_each_numa_hop_mask(next, node) {
>+               weight =3D cpumask_weight_andnot(next, prev);
>+               while (weight-- > 0) {
Make it while (weight > 0) {
>+                       cpumask_andnot(cpus, next, prev);
>+                       for_each_cpu(cpu, cpus) {
>+                               if (len-- =3D=3D 0)
>+                                       goto done;
>+                               irq_set_affinity_and_hint(*irqs++,
>topology_sibling_cpumask(cpu));
>+                               cpumask_andnot(cpus, cpus, topology_siblin=
g_cpumask(cpu));
Here do --weight, else this code will traverse the same node N^2 times, whe=
re each
node has N cpus .
>+                       }
>+               }
>+               prev =3D next;
>+       }
>+done:
>+       rcu_read_unlock();
>+       return 0;
>+}
>+
> static int mana_gd_setup_irqs(struct pci_dev *pdev)  {
>        unsigned int max_queues_per_port =3D num_online_cpus();
>--
>2.40.1


