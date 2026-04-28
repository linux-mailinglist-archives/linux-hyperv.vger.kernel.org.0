Return-Path: <linux-hyperv+bounces-10443-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEvsKw388GmqbgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10443-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 20:27:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C636748AA24
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 20:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E05873031ED1
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52180450911;
	Tue, 28 Apr 2026 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IXxMmREN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023085.outbound.protection.outlook.com [40.107.201.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3EE44E047;
	Tue, 28 Apr 2026 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398792; cv=fail; b=l+i2Z46GNiqIIojOOI+Loq3XonU1Y7n26JAPtxODUzRj1W37bt6t89I24VMELcQnAVqK52bzOW0Xw5SNsCcYEbY4+P1DsrUQchfdYlK2b8CY4+xJTePrpI98tovcP1rUO7/w40JcdLmshY6QFnTcgDfIRJ2j5wTEkYkHBwsR2Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398792; c=relaxed/simple;
	bh=Oyc90ZkmpdmZbdHgT+F8RyQUh+1Mv06/ZOmt60PEMp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ow68SWb8/f78oWDtk/ax8kIzGp+vi6SWvClql8ESYIwSab46drmOqwqA3FZACTpQ3mf7KDiXIl4TUWpkNNSENxYgqb+g6h9x4xy43L8dMvkCJN4OG5pnhYwQ87jy4kF56BSBaLnI8XiM3n4vZHve8teziYeJW5wmMQOSlEeffJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=IXxMmREN; arc=fail smtp.client-ip=40.107.201.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRSmAQEZTwefg9lOSRdLDZLoxNxQQ+BAPiy1zhQcavv6GWcKZFzZFsLY7M3KfH6flXgxp24qQxmHM1/wAfc3Qvew2t+0FII9L+WhtN3Tyly0Yi+aLvr8wOa0iH7E3EXnpKOROB7mk9FH00To0aLSx7tUj3A9mywOT+AIxejZ5nro4+bKM0ynTGePk1R8Ul82m/bMqSxNt/O3Q9vt0d+GrFfI3mALNZj/5L8Tt9gXpQHNnz8moVPTYl6U3difxAUDgsqplBy9KqcpEVpBBRw/jQKtSwn6vra4Zk58v7qL/+hg2WCcbckAlQJtFm/9OOFvTmJIo8eC683ENlgRHbxsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YRtFEy4ajxrmqa2N20M6PZSEzeTZq2omZaHSFXn0x8=;
 b=ee52p39RHVd7ISBZTsfisshdU8lX5g7lHcxQ9RB3BFRx1IcQJoEPdgcW7fipAZELugpfhQUwT3B5G5QW2OQvb9K6Eyze/zwIBtleJlXOtb0nFLU8JurDElwz6Wmw0IjF/Rpo5yofzAim/t68JVMMcwbwe6IUBlDvlsGb7NSGidhjquGYezxpL4eiaVNoNZnjZqbVq23IPjlstVQirHYibV0+6wHKxOvvoOM23iRRrCT1AZGrVR8usWKpGNYsowjL60d2Q0HX7jpoy2ErYUIoxOvjLrggSTSrz5uiiT5qdYg30wMHD0PZAplczTBh8FjRXGERKUyvxF4UXXU9tWXPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YRtFEy4ajxrmqa2N20M6PZSEzeTZq2omZaHSFXn0x8=;
 b=IXxMmRENqCsCLQdbThAkepZjwTGwjOFNtuZUM90WPYjlaSTJksM0oTkfGX77tgeEz12AM2CHblVSQkeynMtzM//R0/KKOuNj5EMYb/0rc7nDHJ7NK/89U8trC5bRUxXgvdurYH50PcFTs2vM45s7mOU3wuHhELsen+F5bAjN74Q=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6874.namprd21.prod.outlook.com (2603:10b6:806:4a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.3; Tue, 28 Apr
 2026 17:53:05 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 17:53:05 +0000
From: Long Li <longli@microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>, Eric Dumazet <edumazet@google.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Selvin Xavier
	<selvin.xavier@broadcom.com>, Chengchang Tang <tangchengchang@huawei.com>,
	Tariq Toukan <tariqt@nvidia.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
CC: Abhijit Gangurde <abhijit.gangurde@amd.com>, Adit Ranadive
	<aditr@vmware.com>, Allen Hubbe <allen.hubbe@amd.com>, Andrew Boyer
	<andrew.boyer@amd.com>, Aditya Sarwade <asarwade@vmware.com>, Brad Spengler
	<brad.spengler@opensrcsec.com>, Bryan Tan <bryantan@vmware.com>, "David S.
 Miller" <davem@davemloft.net>, Dexuan Cui <DECUI@microsoft.com>, Doug Ledford
	<dledford@redhat.com>, George Zhang <georgezhang@vmware.com>, Jorgen Hansen
	<jhansen@vmware.com>, Jianbo Liu <jianbol@nvidia.com>, Kai Aizen
	<kai.aizen.dev@gmail.com>, Leon Romanovsky <leonro@mellanox.com>, Leon
 Romanovsky <leonro@nvidia.com>, Yixian Liu <liuyixian@huawei.com>, Lijun Ou
	<oulijun@huawei.com>, Parav Pandit <parav.pandit@emulex.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Roland Dreier
	<roland@purestorage.com>, Roland Dreier <rolandd@cisco.com>, Sagi Grimberg
	<sagi@grimberg.me>, Ajay Sharma <sharmaajay@microsoft.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Tariq Toukan
	<tariqt@mellanox.com>, "Wei Hu (Xavier)" <xavier.huwei@huawei.com>, Shaobo Xu
	<xushaobo2@huawei.com>, Nenglong Zhao <zhaonenglong@hisilicon.com>
Subject: RE: [EXTERNAL] [PATCH rc 07/15] RDMA/mana: Fix error unwind in
 mana_ib_create_qp_rss()
Thread-Topic: [EXTERNAL] [PATCH rc 07/15] RDMA/mana: Fix error unwind in
 mana_ib_create_qp_rss()
Thread-Index: AQHc1yqYKohEXkneKkKg313+VFmvW7X0wRXQ
Date: Tue, 28 Apr 2026 17:53:05 +0000
Message-ID:
 <SA1PR21MB6683D76104D43E95AE395284CE372@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
 <7-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <7-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6d2cd649-e5d9-4225-89eb-989c0d57a44f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-28T17:51:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6874:EE_
x-ms-office365-filtering-correlation-id: e75c3b66-aae5-473f-cd86-08dea54effd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info:
 2b8ystf6rqXcVd3uPCjg41JRTGgtkGQX7ni7w02ZvVJk+8AjsR9DndzUJ4BjTc3M4zIP+ZtBB4hx3xz3+iTHAv/UEKsSA+NqbnaDvr+wzJvkxup6XCK/Ofk3vOWpxlZgz0XYX/uT3ZasTTJXXX50fa3RVg+CyAQ93paKHBTWY44jkU2jl9VZHbfr6u11dSTHOGo6ymIVxwAWljjJqT7ry7oHWP1Lj/2907iNStv/BY1vzS5jQYSJM+U7aDwl0M3HKv+WSr8Q7111Ta6kDdoNYyDq9iFNnfa2eOt4HCXvUATvSHbKzlngji0T0LnaabYU7bckXtPC5ZdNm3eR7fCFUm9NmBDafW8jbBg2Cw4h0iT6IK6Yr0dlz9ChuK8EUQlWeYfjkNDYsOvncJ8qG3ecQJM9UmV1FjmuJFNkqxdcIqtLMRkV500Tx7/8Vx2drn6EKpd98zjgjN9bvbWblals9uG6HB9sQiERQkEwtyYiRcgTEZqMkjJaEt4dMnjn5w3KkdzDLvuoYLlxLTS4NOjUvh4UMbWCuiHs0Z/4DB9X8dGsPoBEvPj3Cd33TJdIp+CYGmjRpeM7rbG9wt6ZQR5Q6WRlnBYcxVl3fV2gnRzN8SeswfGBlulgmSm6BdfSB1QuwSvZhAx900ajTwAehJ9NI4keopfllhAaNsmh4SoJtZeKp7DRFPc8XoKbKPNgZTQW9HTz1spYURyt6UoazMgcbfQwchXFghBb+WrPD6dTgmURJG6QrsYvouRrSioVUphy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JR6PGFD+nh8SA88MB/2OGBfCY/bl5TPnox/4MbVH/v88IR04T4fQvlJHUXL4?=
 =?us-ascii?Q?+BZhv0u9GWYZXzZ6R58+8jbux3X90GkhySV1nbgUAlo2NHK7Ue4ce4wNFvyy?=
 =?us-ascii?Q?209QVg4VlfThrvo7Q7iOTb2aoZ8FCg2yQ3PRcdtdZOtxTtAey6F7NLOCozlS?=
 =?us-ascii?Q?2d5rJXCuVT0Xo+NS0UHpgVdBrPYh8bMtrcp8fc3+X0B+P+AlmCbFx9B584tS?=
 =?us-ascii?Q?6NDqs7OGoZ0BMuntbGpMX3jH8LC6Sqv0SHwXPgriqg8EQj2zOTLaBbt0F+Md?=
 =?us-ascii?Q?BZsskdPtKWNyPOjRPIep1FhmqXrCvZPfYuDnn2SAAqGh+Rdi2dUcRWOIT+zW?=
 =?us-ascii?Q?By1XXMdT1BAD/IkqrvTFu4ooZMdmG/GOx750Mjyh8jwJXEu0qlPPuVdbnq9L?=
 =?us-ascii?Q?scZn2jEG8tb0GuI0JcCX2P3OH3u5B3aDPq4J/njvPvZx9TUQOoi7u9Lq5N9C?=
 =?us-ascii?Q?eTW9+HTmA2L7k3+HDhOTy2VYvcyF3G17IJHopjkh1Mb7C7yvOApv2FVjoQMh?=
 =?us-ascii?Q?Th0qIuDCMu81qt3mwZyAakKxQ+3nAPXyiOyl4BPS3GxWEuF6HCvl70OBN7Ru?=
 =?us-ascii?Q?n0k672ZOyGkG9Rz98/+kMKUULKHQcNbyesPBELpIiw4jvtoDNpDs1Ms3gAHg?=
 =?us-ascii?Q?5MG7995falnfMG47neQug2eeYiofrYZseF/mejzVWTbADtvxVuNfeKE220m1?=
 =?us-ascii?Q?VQDPIL97FgsH3TTENWxkfu/idmqSLJCaFq2lsbU2w5f3p3yBEhBzojVCQkV/?=
 =?us-ascii?Q?2HjgEVHf1VXQnxYuSR45tVQoCkPnQh2TKgmoO43wKvbBa7PgD9UvdssoFh/D?=
 =?us-ascii?Q?OMzmB5G+so4tJIeJVSVa1psoSFSW2xouv5iDDpKuzgMQOk70BgKN/MLHBxWY?=
 =?us-ascii?Q?Maea/nlYzz9nJMsvyOBgHAPJsW7K4Y4PbyPdUrrI8Nv6XIDW5XwdUP67qgbL?=
 =?us-ascii?Q?gmie6w3t/8Z9+8W/1dSD7JOMpQnGy8uxBaH7MOAoIXSY+saQZeQFXyF7W4ze?=
 =?us-ascii?Q?Ym+s8FBqZUN1DeUV6CsRqCyqUhZmNu/7XqqrxPfwvuyH04JT1tMvXhxOtKjs?=
 =?us-ascii?Q?AW+81AQA42cjxkf7ijRz7rzZN3hZaoLb+OvspOvEyM47UlgnxURHOxBwYQwg?=
 =?us-ascii?Q?fGhNZldcpzD5lrOaQstTF86/yik1V8DSyS1w4KWCYiR7zxiWZBEneAiUUyhN?=
 =?us-ascii?Q?2aF0qqFth9ikuhfeJwkosYF3fLs0s+skSmZdghZEf74SK3jYND+XoQZUTVG+?=
 =?us-ascii?Q?RZ6cwTlL+z8JBOq5gnMUSr4gyEAxj9Kl/K7dfzw9Wuu4eKYx26SVyRF1mSTe?=
 =?us-ascii?Q?7wsBL8Jys+NAllV/SPJ27Y/z6uNqv6vjVRwK5pmdCVJtUCq+YenR4YgcwZtg?=
 =?us-ascii?Q?CjSQS02nc7CM4z5MREu0/I7DZDqBABdtBMBhWx88BuSkLwvmvb1hiH+4MWdd?=
 =?us-ascii?Q?3Fu5DKFLaKg06nRgFiev4MKTmcMhWLAn5li9pLJISdWzyhZ/se1eUj1DGgiT?=
 =?us-ascii?Q?lSHKphD+fQGz0r1/6Metr4HqwY3yqqJ27WS/3mW8oyLEp/466Q+1cTVJr85n?=
 =?us-ascii?Q?p3lUyDD3SJCTJeT6Q/Uik+m855hLeO0aYIczA5omjeNcf0B+RvXHkPpZy40Y?=
 =?us-ascii?Q?CmX8rVyKlgvhW67reolZ0+eprPeOPf54HBGTQT2C91q32bQy6/KdfhGDwewP?=
 =?us-ascii?Q?oQfThhTYdNRMEMWzUQtQRlxF5ot/Re+1d1CJgxhU3P6Hvtkh?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75c3b66-aae5-473f-cd86-08dea54effd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 17:53:05.0751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9dMoixDDSWJD2jgOD2JlmeoN951/ir1eoTDJrmzTx8WTqqakwrcZcKgfmnXKl0S7nniQaesJuAG3+B7hoFOJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6874
X-Rspamd-Queue-Id: C636748AA24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10443-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

>
> Sashiko points out that mana_ib_cfg_vport_steering() is leaked, the norma=
l
> destroy path cleans it up.
>
> Cc: stable@vger.kernel.org
> Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure
> Network Adapter")
> Link:
> https://sashiko.d/
> ev%2F%23%2Fpatchset%2F0-v1-e911b76a94d1%252B65d95-
> rdma_udata_rep_jgg%2540nvidia.com%3Fpart%3D4&data=3D05%7C02%7Clongli%
> 40microsoft.com%7Cb377464abc954481e9b108dea541b646%7C72f988bf86f141
> af91ab2d7cd011db47%7C1%7C0%7C639129898856785811%7CUnknown%7CT
> WFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DpqtgE8ULS
> pXgq%2BbpubumadArZO9lTvPki2ATvD9TnGI%3D&reserved=3D0
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/infiniband/hw/mana/qp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index 8e1f052d0ec976..0fbcf449c134b5 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -217,13 +217,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp=
,
> struct ib_pd *pd,
>               ibdev_dbg(&mdev->ib_dev,
>                         "Failed to copy to udata create rss-qp, %d\n",
>                         ret);
> -             goto fail;
> +             goto err_disable_vport_rx;
>       }
>
>       kfree(mana_ind_table);
>
>       return 0;
>
> +err_disable_vport_rx:
> +     mana_disable_vport_rx(mpc);
>  fail:
>       while (i-- > 0) {
>               ibwq =3D ind_tbl->ind_tbl[i];
> --
> 2.43.0


