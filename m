Return-Path: <linux-hyperv+bounces-10444-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCZDBrD88GnubgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10444-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 20:30:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3371A48AA66
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 20:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF7E4311F412
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A584D453498;
	Tue, 28 Apr 2026 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Tpcgt/kh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021081.outbound.protection.outlook.com [40.107.208.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1D14508F9;
	Tue, 28 Apr 2026 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398932; cv=fail; b=Ng8Q0N2haBuQrwwVkpqHxY2eMWnIGXiJTbxHufrF0NuDdTgk3+mEB6zb4esJgdL7AwVxijZcMwBVPlwEQX3HKr9k7xNTbtShJc0jfRZn/nV4JT/Ay9j+h1o10gtv0KT794RhPth/1Py4yha/S2MNtMkecmMMb8JNDp60gu0RDGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398932; c=relaxed/simple;
	bh=/6uugVYJQWYKYbuDqsdX7FUY3a6k1u0cv7UIIOSuA90=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lIjooWT8OMVb0AFEXSTWPXQLHcnElzTqW20MjVAL68SJd8C/CP0aMiu8dN4u0zUNu3lSAn7yzOt1Y7kNYmpEzkiFc619gd3jyFkDCBfsfjc2lnapI9NVqF9vETMeuKQkM+i4h4LLuYOclXuZ7QZH2lS2xeou69jruaTRnOdK5tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Tpcgt/kh; arc=fail smtp.client-ip=40.107.208.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwZfKsADkWbweueEgrDdjeEj7CzgaiqjPOJtFNVxVTjXEI0qkAxZZBDIThW2F2uCDiDcv2G5DBeTFiKVE26BOJX9/FhQ9ys/H+FMp50GgzBBiCIdyrKn+n9jTOcLZBp41gT4NE3NCC9mQYBExFxlDR+f02NQW2yjuaKLNGQ3G76FivsomVwKu42PGMQQrWz75qM/P3ckWqoRsPH0W705VqECHFI0l26aNJbVW4TuNte+SFsMKBgCkfvuD4v0/p0/5uvkdQ+wKMCdlp8BCTp/JLYaqR/jI2XRpR1LbOp5wg6DhsolnhJxhhMUUJG1+PpTzW+MWsm6Ks7Vu8uBFEBhhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6e8iCEpmylY7gZ7Uw7/99850Vb1dFQCJR2CgMW7IhA=;
 b=F9qfw/6pfthi9Do6Nrdba7MiapKIl8275JeP5RdEVq42Cz3pTavUb9s30JezMtIgPI/8XxJJATkw4xrWNbuXgedjEX/fHPQwvdu4OVcSKx0TIJNrgbfXAO10IuYGo8zQjrw0BAYvxFVhJPQ/9RCHtzUGbd5+I7k3VvN4jx40qpHefankw/z1K619MMo872xPo7vd02bunLv/4dJj3XY8sHbk7USToPXVZZdla6OzTRsw7RfoqFL3oTdoktTqFG6wi9jPydqXo6X2vwwDlkfegDpxEX8fyN4V4rwiVvrp2jNiJIDOLc/+AKjfwIUpin8z05VC6AmU8Zu+AimBHK2UXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6e8iCEpmylY7gZ7Uw7/99850Vb1dFQCJR2CgMW7IhA=;
 b=Tpcgt/khIUpO+//bDg7mA3uu6lW93RlZMKgxuj7bN/6QwLBbnSIFA3Ak1Ea2+o0OdzO1WaxXfMvhJgmDzFy66jd3saxtDfrFoT+dlujt0Wf38xTTQqLwj4dSUPzcZADbOF4WoBHq3Uj6cZTfLq++d6KxZc8nL1RR/L5nehrkpiI=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6874.namprd21.prod.outlook.com (2603:10b6:806:4a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.3; Tue, 28 Apr
 2026 17:55:25 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 17:55:25 +0000
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
Subject: RE: [EXTERNAL] [PATCH rc 06/15] RDMA/mana: Fix mana_destroy_wq_obj()
 cleanup in mana_ib_create_qp_rss()
Thread-Topic: [EXTERNAL] [PATCH rc 06/15] RDMA/mana: Fix mana_destroy_wq_obj()
 cleanup in mana_ib_create_qp_rss()
Thread-Index: AQHc1yqXt+tCE1mErUioma/r0y9rb7X0wfVw
Date: Tue, 28 Apr 2026 17:55:25 +0000
Message-ID:
 <SA1PR21MB6683F8A67D926FDF24CE1969CE372@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
 <6-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <6-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fc4b9580-3ba7-4646-8b16-0b95fecd40ed;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-28T17:55:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6874:EE_
x-ms-office365-filtering-correlation-id: e62f3930-4dee-4722-9f00-08dea54f5391
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info:
 5I2Xl9d1eezSCUORAyAYxHNlqtlJftpffj7bcRyGydweb2KIx/bbdW0rCqKYoLE7dM/LOBH/tqTwqNVgB/djiZmSqzINHGOk0H4zCzlZXmcfQgU0xECmw3A/5cWjCbmOoZdvsm7DQ6CYrtG1BlxKDBJ4kZndgUjYlK06jU8v1iyLsY07Kx/mqPke1VWBvegz4SeiR3HSYRYQo7gCMPRk9X5uCRyJmXLJFGoV3OAfbJv7I95iXenmWgKW8mdRwp5Uh4gCOjQb3Rp8SshUh6JS/1wfjkUgyX2pfP5sAFnpN8kDkBSyEmlovrjGCHn6wdaQqWsNidrovd2KavH6WpNb5NHpVhz3x8jqbbWvlNsigD7cbYqdXCrXKn8ISv7aWZaGL4f142UQ/W6X49Z3ovpVTQBFb7F3o35S3/GnXK34MUhFvl/+1rVWVmAu52B2yHKX9T70rQA7GrW915j0El8rabrpA63rXVczCO4w1b7FzlT3lCgGw2yvHPAJXfTdN0wyfGIQaF6zLxsi+ZkA4KcVtXe/ZOZbpHAa0zpFwJff+Kj0qIYVDJ6+KqQLTjqMbwT+OTTFhxp4b3jpqwVwZw01noV3ehcVURVgC5I5NEJM8ei9Lq7SoDANvqFCzZCs6G2Yi//n3N5w+AFAvWbx/bWhHjNyaxuzAE/tSuq4Cwho878N8h83mBM8uT/HJJmij4XBb38H9Cdo7LGOWMOHxIn1teDhbZRMT7J5z8YL+sQb6xBxi93sx0auFD8cAn/fbAfl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8GpuCNgdcgxdbH7sOOTW+qGuCOUkSho1fMpExzVlT723BghseMODokJCTBNG?=
 =?us-ascii?Q?i88fl3eYKrPhzW+NKP67sb2nYhAp8hFEL39HCysSey5kr26PpPhUYIwKdZ3T?=
 =?us-ascii?Q?UGvOqkTWXZB311QriJ1EXS6rHOCN6YOjPShOEv646yOzGJcMpdvrT7xebbPN?=
 =?us-ascii?Q?kkjIt57TZG2z3iB3qRxygS08arOLMjC6S6wS40HFjf0z8MtBuj1VOTwgxlV6?=
 =?us-ascii?Q?IfE4d44T/SBRyMcsd3u0DlUTCnip/PleX+aKxbU9nSMg8g5tEXFhlKeKJ9s5?=
 =?us-ascii?Q?X/77OzxS8qTLt4RSVKjRDoMvqCatSgCAsYCaYrnogInQZPV2t1Qh0+VK/UoC?=
 =?us-ascii?Q?WsN93kqxwCDeoJ+5wN/tusZHp6mjeBIT+JW3TADhmiEJTcCRW+KARHkurm5C?=
 =?us-ascii?Q?SaAu5QPPso5miViz0p+/KhH3qlR6nmbChdxLXpC897G0ld8F63qDmP7xq+Du?=
 =?us-ascii?Q?Pwy0DcrtrrcoQcF3m3HCNCzbRsACPhyJykKAOLMYgtdD5L25tIg9mZr8UP/0?=
 =?us-ascii?Q?B5F3+XGxQ3Z/k+w7/gYPf9N4XzOxa9Jh75Nk9FCKAzZXunMV96per/hOL9I+?=
 =?us-ascii?Q?dAv3T8WRuk84d/YT/x/SffBjRWYuXH4x5SyBSTBuv0E04CScW9TPR7RhiPn0?=
 =?us-ascii?Q?lxJ9XukExIO5KukwrSNG58LfJmdkfvZzV1y7F7D78YHZwaIgC1rtFiUqUJrQ?=
 =?us-ascii?Q?3CDhAh6h5T6FdEzSIyiA3Q2K/n5FgWitNQCD8BhieLnkWCmtB4ftRQp43IOe?=
 =?us-ascii?Q?DOLtzRu8j5+jRb/ATMQVxb+L0CbUUgWD9jIlf4RvkJNFEh88Lsq4MPC836jt?=
 =?us-ascii?Q?EmC4XhKdhGOyLmDZSwAiknOYAa9LdcFasex1gdqmxDeu3QjfmM22vJMD5F8W?=
 =?us-ascii?Q?UfMwV/01gS0vj1B1MXJm/8Oq4p4jStu/7hvdOL5gcA3C1qU8ShqNxxQCcM6B?=
 =?us-ascii?Q?Zzs+IQf+9EkGbJt0/3T9m9E5jgQuo2Z0ZukyMQN5irMnIaDOKEw3kvj52cFm?=
 =?us-ascii?Q?zpZfjgSxG6yENpj4pbUfoUOFq9BbEVVKqrS0jd7iTnFK+OHqBRVW9LiA6Ria?=
 =?us-ascii?Q?p5jpptmSI3IsMjgLJrboCVX13i3Q9KMuuY+iIArX9WIwgJDbx6WT7gYQrqHa?=
 =?us-ascii?Q?YzGzdQFRmt/yhhkMhsW/sAC/TnnLv7ZxtglMYn2yv73f1mxussareFlnkgBS?=
 =?us-ascii?Q?Zru76zBCF7YcNRZHw0Z/fkdUzrS/14UeaDcchx9dO7r2dTSJTyOIeJY7APEz?=
 =?us-ascii?Q?jvcheQEzuFq3u0C4BqJ2gcqIahsbDiZU7gqcrHmRHl7Zj+cS39Q5z71sRiqw?=
 =?us-ascii?Q?9GIV8OuUnV8PGBcf5/eBrF8zusX4Pk4U6eb3JhSS2X91A8fbPp+A/gGL8ofz?=
 =?us-ascii?Q?A1tvugUNa+wMODzHUVxC/jF5uBk6nL5YADL5Qut6d3sBairywiq+digZgPNG?=
 =?us-ascii?Q?oyfhOLfj6aYwUGHmwijM2uNMWLRBiyg0Jw3OhwiF+qsvfk8uB8AwzoYkcz4d?=
 =?us-ascii?Q?vuQxLCKBQ7GbnsUxxdI1ZQWq43S5rdX36MU8uYSCyeCDrkCaAkZ4oXZANC/F?=
 =?us-ascii?Q?a4xZs/SJlGGUEL+g9BkusVQpCq64728s5+nUsHlbhD6+bDgaM3HJKVOo3FIV?=
 =?us-ascii?Q?/+eYaqq2PTXM5legDFxlH3sgw5IsWIkp4XKBuiHU/rULOTv6szXdn1P0vxLH?=
 =?us-ascii?Q?Pua37e3OS8pM5e3yOzZlNAtcsuNhxwgRxtnr65wdTfYbN3Nq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e62f3930-4dee-4722-9f00-08dea54f5391
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 17:55:25.6031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7gu2zaJtokpdiYsnsaTWfK8TLJ+cW08QzlnRZ2sKFYSaG0kgfiyadXFzYZPnVIMLkeBk1yUW5tfmQKaMUG7vRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6874
X-Rspamd-Queue-Id: 3371A48AA66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10444-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

>
> Sashiko points out there are two bugs here in the error unwind flow, both=
 related
> to how the WQ table is unwound.
>
> First there is a double i-- on the first failure path due to the while lo=
op having a i--,
> remove it.
>
> Second if mana_ib_install_cq_cb() fails then mana_create_wq_obj() is not =
undone
> due to the above i--.
>
> Cc: stable@vger.kernel.org
> Fixes: c15d7802a424 ("RDMA/mana_ib: Add CQ interrupt support for RAW QP")
> Link:
> https://sashiko.d/
> ev%2F%23%2Fpatchset%2F0-v2-1c49eeb88c48%252B91-
> rdma_udata_rep_jgg%2540nvidia.com%3Fpart%3D1&data=3D05%7C02%7Clongli%
> 40microsoft.com%7Cd4d57c89064d4cc1781e08dea541b72a%7C72f988bf86f141
> af91ab2d7cd011db47%7C1%7C0%7C639129898849523924%7CUnknown%7CT
> WFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DhbczVL%2F
> QTqw5zawJJPpSNkjtDrBOJNkV5Qn9vGGYbhE%3D&reserved=3D0
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/infiniband/hw/mana/qp.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index f7bb0d1f0f8034..8e1f052d0ec976 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -176,11 +176,8 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp,
> struct ib_pd *pd,
>
>               ret =3D mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
>                                        &wq_spec, &cq_spec, &wq-
> >rx_object);
> -             if (ret) {
> -                     /* Do cleanup starting with index i-1 */
> -                     i--;
> +             if (ret)
>                       goto fail;
> -             }
>
>               /* The GDMA regions are now owned by the WQ object */
>               wq->queue.gdma_region =3D GDMA_INVALID_DMA_REGION; @@
> -200,8 +197,10 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, st=
ruct
> ib_pd *pd,
>
>               /* Create CQ table entry */
>               ret =3D mana_ib_install_cq_cb(mdev, cq);
> -             if (ret)
> +             if (ret) {
> +                     mana_destroy_wq_obj(mpc, GDMA_RQ, wq-
> >rx_object);
>                       goto fail;
> +             }
>       }
>       resp.num_entries =3D i;
>
> --
> 2.43.0


