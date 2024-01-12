Return-Path: <linux-hyperv+bounces-1428-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286B182C56E
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 19:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70B41F21FA9
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7524C1BC50;
	Fri, 12 Jan 2024 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HtVpHxtc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11023014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE0C1BA5D;
	Fri, 12 Jan 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=af71Ni/j4l4TWA9vx77pBj+g1w9eHxd87olq+srWfEC8bBtN3yhRpceBhwdTlI9lZjGe6kxXJqsWJ1Ff2kpzdTQozFWYyPlet7STkI4cJn2mtu1In4MubU1hwhCOWxdf809Dc8uJaxmkp2NtrGv0P5Soaq+GfKqyJkK1j/FogEMhGbX+MJbNCYI7osyaEXGhgr0TeMx/GxGfwnvh1OvY3IpC853oRpb7euFtRnwpg2FRs0mB4P4+csI0CzP92PXuZ5F2a7XiviSdbxX7O8BEuisXz7PKUHUJaJfbOkpoxRklZ+cvsruKnNVfqCWSHH++lKtu7tduIDawUmWTVcx1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yn7+X1zjGis/P3+26owTuIFeLSUDz1pvBoWTJykyQlU=;
 b=dw5JPSEBJGIefZOXujrBD7kYiaINp/NNEbfuoT4xBeS0trxAgdNyBSao8zp48CnH97Y95WIlDqXlqmEAXMnmPbcMsm/k8db8Y9hhEqX8sXT9l0JFGhcRJYFEU+qU4olWIB9BiOw7cfHduGQg87TpbfHx0JMJAyQeCPHxNi2wcUMxDAW3LtPcVU/CuNcy0rPNPJlNDmxTlyQ0pztMqnC8QKriRoVnPVNTL4kwmjytORLWbFh9h1H1XmZK2OFZZL9EGOAZXQhw4tqBljFdiBdisdz5Mjz98KJNPny/hWTUuq3c92q7UxA2pmYii3WfsdxdziLUJha5+C9sGzUlmdVx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn7+X1zjGis/P3+26owTuIFeLSUDz1pvBoWTJykyQlU=;
 b=HtVpHxtc+JDiq2sKnC+GLl63DBEMf8Ef3o2vM+rmyq2hYK7HURAmyY1l6KFbo70wsuSASCJtdZbTWpFf0hKllV4gbf9J3C61i34LhgHtJHOfqigrCf9VwqtdFwk97r2Ll1IxV+EH7+itzoQvp3WxqZLVcYBsAi6Gv4La6os8xhU=
Received: from DS1PEPF00012A5F.namprd21.prod.outlook.com
 (2603:10b6:2c:400:0:3:0:10) by SN6PR2101MB1344.namprd21.prod.outlook.com
 (2603:10b6:805:107::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14; Fri, 12 Jan
 2024 18:30:45 +0000
Received: from DS1PEPF00012A5F.namprd21.prod.outlook.com
 ([fe80::ff76:81ea:f8d6:45]) by DS1PEPF00012A5F.namprd21.prod.outlook.com
 ([fe80::ff76:81ea:f8d6:45%8]) with mapi id 15.20.7202.002; Fri, 12 Jan 2024
 18:30:45 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>
CC: Yury Norov <yury.norov@gmail.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>, "cai.huoqing@linux.dev"
	<cai.huoqing@linux.dev>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Souradeep Chakrabarti
	<schakrabarti@microsoft.com>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs per
 CPUs
Thread-Topic: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs
 per CPUs
Thread-Index:
 AQHaQunR3RrbavDz00+r/Bf4otFslrDR3JYAgABE1ICAABB2AIAB8teAgAJAkQCAAB8NgA==
Date: Fri, 12 Jan 2024 18:30:44 +0000
Message-ID:
 <DS1PEPF00012A5F513F916690B9F94D3262CA6F2@DS1PEPF00012A5F.namprd21.prod.outlook.com>
References:
 <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1704797478-32377-4-git-send-email-schakrabarti@linux.microsoft.com>
 <SN6PR02MB4157CB3CB55A17255AE61BF6D46A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZZ3Wsxq8rHShTUdA@yury-ThinkPad>
 <SN6PR02MB415704D36B82D5793CC4558FD4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240111061319.GC5436@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB4157234176238D6C1F35B90BD46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157234176238D6C1F35B90BD46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=afd57b44-64e7-4e9c-a23e-7f005544b8dc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-12T18:28:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PEPF00012A5F:EE_|SN6PR2101MB1344:EE_
x-ms-office365-filtering-correlation-id: 16d0784e-c015-4e15-0c1e-08dc139c9712
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RB9m8zxfAVlGus+Npn/IIDQ1ZTDxUc6xFV7Cq0Ry9oyeyuUohtfqI5ZOqAu2idqUZHYi6wKGDyIK6BwwEbo2ia5+aKqkLtK4zjyzf6w/89OIrH/qVMfGAJLPDocJF4+qiKEkbIHn49x7QSSPimP1m6Vg/pPbqgrvznB6O183rEqEqWDck1lDaSd/MFTXEbHsiPZ9u4uBMHIK0hnwZvVejqe+rV0q+unD8gXnOH5fva0i72zl4GGy/EclZ1iYt8uGETFfpHlWwA4YePXa4Lga4iTZx+ZYw5Kc1MPxd4l6Z1KSEfypLmb5RyuLooh0v8I+nwid1ZMSd1mHWQDj4qaiEbUs9wFcT4alaFEAx1PyjN0ZBmY5GS0F6ojfqIdq9SBPNYqDzgAkKg2JwD+R+bE/cbBZ+wLAhTvf/404/ujQRuF60jzaulnYu5OpU286YazzBjUVTCxAMieDfeFcvMpBgOh2uEEnmVaDJlgFv/DWwyLEoQcxXvxf/JZatch5RZ4L2Ebqvxit2AAM+lDcQGS+Wnn9kSuYLXdIpXQsw8n6x9dffaQi72BOcJ9QaBwNu538IOi4/2jK2rDGqaz8v2n4AKT1NvVLlFag90tw+rW+FRJXa03GzYw63rcO06wOD4PdcIAP56I6x6bGcyqElkeBJDNU9NJmiVeqjHzSuSwGVns=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PEPF00012A5F.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(107886003)(26005)(7696005)(53546011)(71200400001)(6506007)(9686003)(7416002)(5660300002)(4326008)(66556008)(41300700001)(8990500004)(52536014)(66946007)(2906002)(966005)(316002)(10290500003)(478600001)(8676002)(8936002)(66476007)(54906003)(76116006)(64756008)(66446008)(110136005)(38070700009)(86362001)(38100700002)(33656002)(82950400001)(82960400001)(122000001)(55016003)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dZdemcQPbaGgTGqJHResDdaIlz3O4Ig2Oca0siktqqzytjVpL/P6vJtcIGvz?=
 =?us-ascii?Q?LYuno/W95TTkof9qOOSaS+9/E8z+9dhgXQxfCeBTBGkQ3wmgBEXw58nYx0he?=
 =?us-ascii?Q?BL5nM3pUuaUIyg1fO6dXPzYuqnioLIpHFwBVq/GE73txEUo7naj1jgUbde2V?=
 =?us-ascii?Q?o9VLXReV22T4nU/VYsQsvxLHMMhL3JmNlncwaQW1BiirJ/W6nFZzFfnpsWT+?=
 =?us-ascii?Q?5ZUoJ0F/Hp2Furd6HmdIS29k/e2My2QdxujdQtJPiVzh4Or+j19LS3NqyFuU?=
 =?us-ascii?Q?/o1vDOlpwbbmyWYybL3ENVTfQdIrzurSHCe4fTAyYNwJYSteebqhI5tD2I8V?=
 =?us-ascii?Q?uT2tKsoa7ACBGt7+jBO2oY6uIvKA0T5ZJvQKXCj+Hn4Gx/TyHebAI0GBKTbD?=
 =?us-ascii?Q?ZZpwKELu7KPZymKB9SNn6ysG92UfDBtAsYgNBdFCm42rm3M9/IyBqnY3+/B2?=
 =?us-ascii?Q?7qdceSDz0iYw+JNP2svpUTFSBkQj1ZkcskkSqrujdaSmo76z+Pe0i39x2yeh?=
 =?us-ascii?Q?y24bRoHs+d4tI0Q50dj0s7NOQB4ucb2KmICznnTf/xNg8R9E13z5Rl1U+vOm?=
 =?us-ascii?Q?FOMQjuG22YJv9Lp7+FIBtwBxN1SIE1g49CJg/Is52bLpeO0FC05OekkZQ/uw?=
 =?us-ascii?Q?HsBoHaWW8M+9HvcOCqvcGqoJsCFJ/LpQX5P6VWCxUaCJy5HUFfto7Qy/aq2R?=
 =?us-ascii?Q?bWMwgoYBOGBAambZ0m4730z413LaTmZ+Rb0P7YQ6V5hs1N/hcDJJeahDFBQ0?=
 =?us-ascii?Q?ixhue9EESn9wjhM0u4AoiLzPgah3VsmRlWf8LN4gf4Gw6VqUAieZVTaAFNMw?=
 =?us-ascii?Q?On0cLD7zfi1P81wY+3033MrLUERUFd68S2ndXFVJsiPhqe/un7fpZjiKl4Ua?=
 =?us-ascii?Q?h35xgZj8C+YcE4NqMfvuPPs2jdojhTtHysMLdig7Sx0ceqDXqVWNJXJBLadL?=
 =?us-ascii?Q?twLhkU113fYoglYvBYuiMrwUCGB00L72uz19wfr2mZNjuHTjxI0iBxPOEDrM?=
 =?us-ascii?Q?nn/VHm38p4/e6SLeSpL8cPS7fGzZTSdw8Cv05Bi7tiGU2pPSRg5L3lD2EadK?=
 =?us-ascii?Q?xRxsP9YGXgDeovwO78LNriobadA332HvNi1LJZ6WX5t+TIM9qc3WJBe9kjmU?=
 =?us-ascii?Q?/8A0HCcLgnFUhWhvUTfvemUNlkD5ir2UY7poHWC8Q9a0bNNpm3+Mt38XBXy3?=
 =?us-ascii?Q?yWFWCXQj0Lfd7RLYL/4pe/oR/8j067KkehipSZLUGGLEWFL/YvXdCGudHm6m?=
 =?us-ascii?Q?LxjdCV6aG9U1bqAo9vjJB5H/v/hk4LUKTBmmL4HIFruHsBF+y5Oj0WG8Oub+?=
 =?us-ascii?Q?z0zvHEMvTVpayVhejG4jfZdqmc95eoIFf/oKWssNKm1Pui3jIvhlWemk3s7R?=
 =?us-ascii?Q?dKV3ndrUm4eKuYQRCEl18RBpJHFPBqUmr03bTRvwQI7r26gQo8zwYgai5nj4?=
 =?us-ascii?Q?eZDaGJtjYVa7usrGGCy5z/+34o6w68NdARNFvN3zt/swsWSVfQ5yPNO4fxwi?=
 =?us-ascii?Q?5X65GnOEGkn/XeCZzWSgvgGDwi8gJ3KZb125r/oYHzSEUcVLaGhzq0HRj0Kn?=
 =?us-ascii?Q?GwpJ/wlukC7/otDw/Bs7ThdNKUtQ/Yw1xozBLBgc?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00012A5F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d0784e-c015-4e15-0c1e-08dc139c9712
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 18:30:44.9565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3HlWzcRVHcdW4DQFO/wpUjtcuyulfPMogytDuNt86mNR5g1D1297ic25uE8059RZhOkqgw1ySCn4KhJzXqtMcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1344



> -----Original Message-----
> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Friday, January 12, 2024 11:37 AM
> To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Cc: Yury Norov <yury.norov@gmail.com>; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>;
> leon@kernel.org; cai.huoqing@linux.dev; ssengar@linux.microsoft.com;
> vkuznets@redhat.com; tglx@linutronix.de; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Souradeep Chakrabarti <schakrabarti@microsoft.com>;
> Paul Rosswurm <paulros@microsoft.com>
> Subject: RE: [PATCH 3/4 net-next] net: mana: add a function to spread
> IRQs per CPUs
>=20
> [Some people who received this message don't often get email from
> mhklinux@outlook.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com> Sent:
> Wednesday, January 10, 2024 10:13 PM
> >
> > The test topology was used to check the performance between
> > cpu_local_spread() and the new approach is :
> > Case 1
> > IRQ     Nodes  Cores CPUs
> > 0       1      0     0-1
> > 1       1      1     2-3
> > 2       1      2     4-5
> > 3       1      3     6-7
> >
> > and with existing cpu_local_spread()
> > Case 2
> > IRQ    Nodes  Cores CPUs
> > 0      1      0     0
> > 1      1      0     1
> > 2      1      1     2
> > 3      1      1     3
> >
> > Total 4 channels were used, which was set up by ethtool.
> > case 1 with ntttcp has given 15 percent better performance, than
> > case 2. During the test irqbalance was disabled as well.
> >
> > Also you are right, with 64CPU system this approach will spread
> > the irqs like the cpu_local_spread() but in the future we will offer
> > MANA nodes, with more than 64 CPUs. There it this new design will
> > give better performance.
> >
> > I will add this performance benefit details in commit message of
> > next version.
>=20
> Here are my concerns:
>=20
> 1.  The most commonly used VMs these days have 64 or fewer
> vCPUs and won't see any performance benefit.
>=20
> 2.  Larger VMs probably won't see the full 15% benefit because
> all vCPUs in the local NUMA node will be assigned IRQs.  For
> example, in a VM with 96 vCPUs and 2 NUMA nodes, all 48
> vCPUs in NUMA node 0 will all be assigned IRQs.  The remaining
> 16 IRQs will be spread out on the 48 CPUs in NUMA node 1
> in a way that avoids sharing a core.  But overall the means
> that 75% of the IRQs will still be sharing a core and
> presumably not see any perf benefit.
>=20
> 3.  Your experiment was on a relatively small scale:   4 IRQs
> spread across 2 cores vs. across 4 cores.  Have you run any
> experiments on VMs with 128 vCPUs (for example) where
> most of the IRQs are not sharing a core?  I'm wondering if
> the results with 4 IRQs really scale up to 64 IRQs.  A lot can
> be different in a VM with 64 cores and 2 NUMA nodes vs.
> 4 cores in a single node.
>=20
> 4.  The new algorithm prefers assigning to all vCPUs in
> each NUMA hop over assigning to separate cores.  Are there
> experiments showing that is the right tradeoff?  What
> are the results if assigning to separate cores is preferred?

I remember in a customer case, putting the IRQs on the same=20
NUMA node has better perf. But I agree, this should be re-tested
on MANA nic.

- Haiyang



