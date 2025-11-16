Return-Path: <linux-hyperv+bounces-7617-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 858AFC61DCF
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Nov 2025 22:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B2EA4E056E
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Nov 2025 21:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43DB2609D4;
	Sun, 16 Nov 2025 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VZD9ZAJY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021140.outbound.protection.outlook.com [52.101.62.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3923BD06;
	Sun, 16 Nov 2025 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763329842; cv=fail; b=cpbqfk0NJ3YLFFlJIYd6XOMWK3OTQxx9CRbuYDBC0CQx2xsVj1rmxKM3Dlpo9Xpm3fGfSoyTzF/sAUpOCrbzDU55GX7BKuxWqq5887tcQjIyD+WkqCdBKl7bwS6X7xS33A6uiWn4TwABnzxBTm8+wpHUQZthQ1Rvdc3T84xRlzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763329842; c=relaxed/simple;
	bh=KnzNHSPlQ/3UplCQcr23g/zZEF5mFgchfNEv4vHer9s=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JwRINqnqQJzg75H3l2urN+c8tV67TKzdRtKgWo4tjpeu2cGs7BRCQItM9UF9f1RlwKFZBD5ND5ED2l4txvh4LUtsQcZ0jWpwQqu2Rzurg/r+FXKutj3Wa6GEG5oMB/N6TUuFH8NKGhjy/5+hjT65akoInt8P1JwhiDyV6e80TvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VZD9ZAJY; arc=fail smtp.client-ip=52.101.62.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnjIisIhbr3CtNIBKSq7XdEQQ7dJaFlSMrLkypSLW+NclgTHzP9Z65OVhQKm71+0con9HgPFRkPFcOf/wLu6AsUyHOXpsj1/QNWX51FW+pp/Cs/dJrurH66VaeiV1cMYxVmYW31YwsnGRkZU5/Re1avxvQGmDPdslc0kM3Mx5j50+nZQrUFPJOsUr8E8xOMpxs0Qe4i1dUUy1ikht33k4nKi8vcI1KR9teS7oLAP1Vxpn2S1rYoCiKbD6s0sv6/6/lLwkR/y+EY/TqJgjb24ZbScYzotcXi8L6EAeq0bFC00j9WBNCO0vOmomRlRkCSGwXpvVuM44gB9bJMmWSMXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnzNHSPlQ/3UplCQcr23g/zZEF5mFgchfNEv4vHer9s=;
 b=B+Z19SZ+NCN6DV60OFmD7sFtOZ18yBg6SWttGh+nzN17uM7+G88XZvLWbU1oWhi8CmlEWorOcBC7aaR6jfvtk876axcpB0wz8tJucn4yowAVLNgA0KIjCfTdvu+m4KnpEBCIR8d6SE6Jgk2oHck8rf4BA+iImy6WsWpxdw+Je3hGWhVkc3GsYdHd9RcTpn8CLcA4H1VFTL7a5HadbWgCTPuGsK/9PUqkXaj3RySHOCSrEowFG55UkNcFfUn3UiybkCG2fPPF9fL3dHm62GLMECKOn0yTKczOENLkwOboGZNuZ/UJuKBynzPecpNUEetkrVjQaP8Cpi0AU3Aof/jOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnzNHSPlQ/3UplCQcr23g/zZEF5mFgchfNEv4vHer9s=;
 b=VZD9ZAJYcwmlDocZx1+LKbsp6RZBkU/pdnwomo4UL+R9DZpPtbIqkmTUDXkDGS1W19N0PZngC2cnHKsbKiI0C3ANYmlS5kNu8Chnl2SzTWx1f5jUuJip0nRHCXm9M/a5xPBoMSeHRr7xmswxiXLBTYfmV2g5lao8s4sEsiMgFHs=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by LV5PR21MB5066.namprd21.prod.outlook.com (2603:10b6:408:2f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.7; Sun, 16 Nov
 2025 21:50:38 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%4]) with mapi id 15.20.9343.006; Sun, 16 Nov 2025
 21:50:38 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "horms@kernel.org"
	<horms@kernel.org>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "dipayanroy@linux.microsoft.com"
	<dipayanroy@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"sbhatta@marvell.com" <sbhatta@marvell.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v3 1/2] net: mana: Move hardware counter stats
 from per-port to per-VF context
Thread-Topic: [PATCH net-next v3 1/2] net: mana: Move hardware counter stats
 from per-port to per-VF context
Thread-Index: AQHcVVvj4fN9bwcqe0qJgrIuVX7ZqbT120gQ
Date: Sun, 16 Nov 2025 21:50:37 +0000
Message-ID:
 <SA3PR21MB3867C38F2A986E22284B444ECAC8A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1763120599-6331-1-git-send-email-ernis@linux.microsoft.com>
 <1763120599-6331-2-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1763120599-6331-2-git-send-email-ernis@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ebbd1b58-b865-4807-8b51-585fcc2f9f6f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-11-16T21:50:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|LV5PR21MB5066:EE_
x-ms-office365-filtering-correlation-id: 81e27599-d2cb-4916-4da8-08de255a2de1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?szPdXkUobfp9SqChkMk+J37V/eeBHrZPe0rurrkvA60+kHKpIgn843Qs+r/p?=
 =?us-ascii?Q?HlnAXVa2mrehLhe22CVe5jMExlmLWMxI3s4/pQAIybMuIXdR7WuU7f+VwWHp?=
 =?us-ascii?Q?lUk8aDsq5/BDp//NNYX/87uFTqC938eNQaiMd0iBxPMI3sccQbLoglL44ptE?=
 =?us-ascii?Q?onCw762chzuvDTSc2NRYXT7aYyqWB+tLka4GmR5brnTwc5KdydbrP9BpIYyo?=
 =?us-ascii?Q?zHkfiZIYkbl6y5xyFsmTk9C05iMQSEIiD3FUbcVLQHUz6LY8ztjAaph8AhpL?=
 =?us-ascii?Q?hTeCguVpAS8Jol6WhOCqoy9cQxaCFORB7kbe72NTmo6BAw5u/5/hOb7cxF8S?=
 =?us-ascii?Q?4o5ykyttBxnor26SCnnaN53KXkLdbS6wjZ2LCgtbRCfl2/eL99bFeaEVGc9M?=
 =?us-ascii?Q?MacJPGcLGWh98tKYC/BPAJN5u7lD3sm9WqO9JyVkN0IUP2e2IWXvlTjx9Swo?=
 =?us-ascii?Q?emsRX/Ecj7eBEWpouSElOspjxyYqOnLU67zIVYs+RxdNkWuGHCYqpXyNDSVd?=
 =?us-ascii?Q?249d/lrr6YGyRRG8p6+uK2Yc14jUVvkAG8urcqOX4rR08B/CrEO9D+0MqDIi?=
 =?us-ascii?Q?mXPrzCFF8HXepRDn8Njf4BBH56IFBDXygfbRJ6jTSjVm//jU87QeNrtebyGD?=
 =?us-ascii?Q?HdphY7LlGRI5dX1Kp4xfjFi7GsFtLQe2S8tLx3SMUaYMTJEEMksYP7/cjxXb?=
 =?us-ascii?Q?WkfS8TKpEZzlImUaLyd+CBLkCqPFchNLL0aH13nYd57HMvxbz5ivT5LSeluk?=
 =?us-ascii?Q?x/Km5g4dhfD0elVkaQWyB7FFHGMcZPrn9AmSaS46rDQxRF0znu2eWDDvGouv?=
 =?us-ascii?Q?UBgB9yNMQ0Gt1nlGDkQtGLjzKxCIuOLs6ZyinDfetZrKXRc15NEFL2DLNrN3?=
 =?us-ascii?Q?YWqUt1V7k+vKhJP77pJb2jQH7sY1sKRACLSm4pRsg5dKr2R1Kz3dFGUCcorG?=
 =?us-ascii?Q?NbypkYNa4anokXiqNMZqagLIw1sZODUrDfGHHafOoYSCf1e6UfQyyJTjtI48?=
 =?us-ascii?Q?0XFgFTZCpU2XWbcbagUadXhTrA12QoILiZbjglpTOzsDVkmFDUo1ewW+GzSx?=
 =?us-ascii?Q?6KD0Iqw0l1mymYyzD948ysCGph8PycAbG4wSONXj5rAAYU6SqAXeGeap2nGS?=
 =?us-ascii?Q?lUE8MINItgDA4CgKKB1zD64f8TEFQeRqo51AXm+TM6HgAG7BKyNMxBcHuN8t?=
 =?us-ascii?Q?V2oaMX4R7VEiL4zO3hnRaNZFPVkjkOGW7BWv7AxUp8HALj+t+k+mAx4eWS8T?=
 =?us-ascii?Q?qJYUXNd2nnyAtZ/5qLIQ3DbTBD0KP535f8BaL2ZVbcGyzdp9eruk8W8O0tvv?=
 =?us-ascii?Q?OFeOBBfYRMU61SFqxSyL7ZF5mG4FkM5FCsX/6YjjEMuV4xtzO/HT1BAeFDd4?=
 =?us-ascii?Q?BoNZtAp/V672dyvptMty8gGtwzt9vuwuRiZ07nNiycl7feUo+skRP8yQUWCR?=
 =?us-ascii?Q?rofiD5pgIbtvcIiRgDeqXLZLxTmhJ3S+cTTknfrNf1yMamr5+xVVv8O6w9Bs?=
 =?us-ascii?Q?XrEBQd+DvmlD4LVLvm7ZmaFQMxoOlk5hrAaT2KBA69hGcUD22JtO3cyDig?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/i8VHfb7a1IfHwb1ySWF7foUrHAmBIcVaMqQF9M0Skh4A+fMHrmEnsWh7Zm3?=
 =?us-ascii?Q?40h0cksZWTuYvNkBpT6thmSPGKNTBu+Bcxa9iqUv5PGSQySNBAyo6b16z1a6?=
 =?us-ascii?Q?2HOclsFNjcfOoq252Dw4VpvmzKl23PkhMxoQUlZ2/tRiSUHK/tV8h4FQZXNR?=
 =?us-ascii?Q?g+dvZe5LW/zFnTJuexoS8nAZNzlYtsd8chOE8C/3nPanmiy9G5Kppd3DU41u?=
 =?us-ascii?Q?Tyz+W2g2GOYGqr7gGsMAHnOI7GdXxdn+N0y07C5o/m1W49j9k+7GWO/IWDdV?=
 =?us-ascii?Q?FxB5b/o8YmbV+++dwyjAg7PHXefPep6BWs4mX4OHourkbzas1BKeVKI6jWzP?=
 =?us-ascii?Q?jDr4Dqss1mIHHuwmvlNESuOgVjojBW9PPHIwNBAIbnV3kNerllMaNzcliiUx?=
 =?us-ascii?Q?HUrHS90bLZ84c2MRwGM7huox58NjiqQtKCQpRxLmdvQnkzEjd3Mcj1QGNS9d?=
 =?us-ascii?Q?5VM3yRBwNkfa52Hx+uzJupS1IVcIqb9Wq5ajmh+r5PNri/jhewr8Dl6VWfL8?=
 =?us-ascii?Q?1RVkk7749bWR+sb7uq7wfTSsn7+x+IT87aj9p0IX6IuOnpYWqXLS0rX8wjWQ?=
 =?us-ascii?Q?dWjDgKSazDlQsFKod4KOYW9MN6PP3qw33Z7dPef8IOIvwMzBm7Tqshn6SZ9F?=
 =?us-ascii?Q?OnxqXPuBaqpJhN1IpGo77jbDAzNhM6DviHbf61j3b6itbU2wnMGQaJzYbQVJ?=
 =?us-ascii?Q?1GIlB/Limx+Oa/bceuljFGBPqOqRx3KHnZ5jv+f8hPbm+5TqABw5sKn1v5yY?=
 =?us-ascii?Q?Dy1bv94S7JSCEcGotryZI9LnwSrQOily0HsQdmS9wNRlCTEUWTRE9A0NBblZ?=
 =?us-ascii?Q?G/054tWIpeqFWR8oEmPD2Eb+GRmUovJoKoOmGw1y1xYz8BzsMkmvwbcK/QGm?=
 =?us-ascii?Q?/eGMeHBH2ut47Fsw6orly9IcIo5x4xZMZhyvVFKUIxawy1SMaIaMP0gLh8ib?=
 =?us-ascii?Q?nAuq0tc/4DgW8IDyJvL6rM3jY/oh6vM3D5xpQtFK+3cd8DTAU+iKhd/ngRG5?=
 =?us-ascii?Q?dahKOQDiGmiKYrjaVEdXWPuz5X7RqxCkoKzFGpBImZLsOzU2LQtdnL9lfQq3?=
 =?us-ascii?Q?453pF9nSXGJGuP954zV8PtCV0R9tUJkTjAbILRD+3tmaVREHl0wAH83VFz0K?=
 =?us-ascii?Q?0AtBrrDraebCsPEfSfNQfQGrjHgWvP6LgYVmEty4BKK4W3kNwPCY7W97hoCH?=
 =?us-ascii?Q?UG/dJ+1pp1HCqBwK++bOLcv4dXZmGNKBfHq2UPAhEYtI0mZwzrUDTPEv6Rtp?=
 =?us-ascii?Q?EkMg/ELfY8VINYnCIyGJ4D1uD0Z4IC0XOL9PKAxRIx6YyQLWwLTK2Up6tC0x?=
 =?us-ascii?Q?zK1mScRM3cqnLEJcWQp7UKAH7W0u0gaNtjQadYguYwHfASjdUNkmuEU++2+F?=
 =?us-ascii?Q?uXzwPdYAoF8OBcQob7I8nhAkhS/pGoj6MHcSbu7se1HfBA/7ANKXBQqwdqSb?=
 =?us-ascii?Q?3Tdnpu3nzGW1zO/wADjTJiNOQxiu42aSthcY/IcUrLYyuEjhKyGQp00XlM/6?=
 =?us-ascii?Q?Kwpk+XcWDK3X24VPKy6Kwwxn5RiS/awMvQJ5GsGCabnDEPY5Iz3r7fVunRmL?=
 =?us-ascii?Q?saTKr4IEBfUg7ZMDj4dzgXQ4SyY0lTvr5swXb3t1?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e27599-d2cb-4916-4da8-08de255a2de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2025 21:50:37.9590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LR16/4KRXMTSv81rgBqIoF1uFdyEMFAekgQHPIRAxwMEamdvd7JLqOI66Q3d4KJV4/RJFZBBNDCvylV0KDrmxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB5066



> -----Original Message-----
> From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Sent: Friday, November 14, 2025 6:43 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Long Li
> <longli@microsoft.com>; Konstantin Taranov <kotaranov@microsoft.com>;
> horms@kernel.org; shradhagupta@linux.microsoft.com;
> ssengar@linux.microsoft.com; ernis@linux.microsoft.com;
> dipayanroy@linux.microsoft.com; Shiraz Saleem
> <shirazsaleem@microsoft.com>; sbhatta@marvell.com; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Subject: [PATCH net-next v3 1/2] net: mana: Move hardware counter stats
> from per-port to per-VF context
>=20
> Move hardware counter (HC) statistics from mana_port_context to
> mana_context to enable sharing stats across multiple network ports
> on the same MANA VF. Previously, each network port queried
> hardware counters independently using MANA_QUERY_GF_STAT command
> (GF =3D Generic Function stats from GDMA hardware), resulting in
> redundant queries when multiple ports existed on the same device.
>=20
> Isolate hardware counter stats by introducing mana_ethtool_hc_stats
> in mana_context and update the code to ensure all stats are properly
> reported via ethtool -S <interface>, maintaining consistency with
> previous behavior.
>=20
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>


