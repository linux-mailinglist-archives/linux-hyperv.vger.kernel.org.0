Return-Path: <linux-hyperv+bounces-10442-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCunGYzz8GnUbQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10442-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:51:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D662548A311
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 244653017BC1
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746674508FB;
	Tue, 28 Apr 2026 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RICjasz4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020100.outbound.protection.outlook.com [52.101.201.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE633D4EC;
	Tue, 28 Apr 2026 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398654; cv=fail; b=tp4hbzoEw/nrpAy6JPZjmiuPEBgr2TFZoJ7DwYi5ztJxtgQ7lOnmDIWhMyzpSc7mOclONIooUEU+pTyj4EiuC30z/xpArtWTQnZfHtcx1RCZVm/BMj3Lxv7LP7aFExMMg6b8PBfPl2Ab71gL75D17xtCzxQ4Lx28lnOudJnRGKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398654; c=relaxed/simple;
	bh=LgHXjUDLTwDIgN96BTA3iUO2f9/63JG8IO/b+GYUJMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uj1Gi9SOzMYkn4TLOU9Vx0mXzrzr3KRbDRCyYDjGRr5E3IEg++ZNG8vrns9dgXaBXbelsDPaVbeog5HhU9koq5yLUMkqrE28g1IRMkPJavTAoN3t9ih0ZbUdDAP17qwdIYz/i5h7TLuHfFDACdDQ9tBxbNeGqxLVJdRGfCJPMaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=RICjasz4; arc=fail smtp.client-ip=52.101.201.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7dCKJTHRefYP6ajha/Rse57f6Gjmb32vQNaYR2jrMUs45nQnvYVU0FCylqNGWRUTuSRYvA9l9YMJ5j8nWiFQM3sIM/GR2EnFREeVKFnFuLIKVhhaQcFFlK76wBx4vZG5BIlGp4brIXJ+8jLEKpSetzAYlFG8Pj2WyAtDXf8bnFrRu62LT7tyifAcIYKrklFG6N5XyVGmN8HNeAn02mfKht1V3yMxVG/Te+gcZrAMAPcYeSZEVQyg1aHz0nRWbq8pgPWFH5sBwAdZjUZmTX/xgv1iNdTrSxFNUpS6wCt+tSyp67bZjc57crv/yLWDnbnKyD2oxVIucVyx3Nc9jsg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5hlJ+dHZWU06oWcJfM6YjfZ18tabUNrQO3Ivo9bhls=;
 b=ApzUOshXHg6uJxIj0ASAayu4Ctbo0plg84n9AyOIXpLjDPHz5RcqX7UAuisNJ3mgllGcnkRoHbdXPV/4Of4aR9hchWi+ESKj+6TVrpEzyGVscDZY+Bsa8VZSiUl/WmngLdcbztIW2XitvAcamPfiXUNS/H4P5TMzO4iIUwhKCl79TKh7XAqsASySU7L6NBh4v2hTYpJRwcDskYi7o/BGkxzuPFwCcoTlvM/GDSwp9ZVN7YmP4ciwny2k4oTy53YkOrwxjKYiAn82VkQ3fUTBGU+jq0hOd8d+r0IkQWUU7OQQ+p3Y/9/QCaO4BVCJvDdYw5938SHa+GIgjQc9JIgYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5hlJ+dHZWU06oWcJfM6YjfZ18tabUNrQO3Ivo9bhls=;
 b=RICjasz4iYy24rXzu40sdgSIGuy1x5HJsVBh4gJWkLyEpfd4KrSzOVbZ/M9/ammd3Ojxw+DJaeWVvln30gP/eDVx2qZMOwI3HNLaoApwB3oMIpP1cNnYtmrpamMNuMlRSXqlIE5v+hXdHo9Y7j6OmQetNzdJa+LxQOZSGkeQ2xc=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6874.namprd21.prod.outlook.com (2603:10b6:806:4a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.3; Tue, 28 Apr
 2026 17:50:47 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 17:50:46 +0000
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
Subject: RE: [EXTERNAL] [PATCH rc 04/15] RDMA/mana: Validate rx_hash_key_len
Thread-Topic: [EXTERNAL] [PATCH rc 04/15] RDMA/mana: Validate rx_hash_key_len
Thread-Index: AQHc1yqZbIeto+s8zkOL9g+3b4o0xbX0wCqg
Date: Tue, 28 Apr 2026 17:50:46 +0000
Message-ID:
 <SA1PR21MB6683AABEEE1BD8F8504A110FCE372@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
 <4-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <4-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=71903384-ec74-46dc-a993-3f07a25be251;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-28T17:48:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6874:EE_
x-ms-office365-filtering-correlation-id: 7a5f89c6-e1e6-4426-83a2-08dea54ead54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info:
 sFzNDQWqic4cPB7LD9qmLruXf5ZijrJaZ/D2+RIolt/dqKu56ax9JVz6WFdd35edNiOnOkIZoay2zcmuiP95P+AHWCZI9jDC8V6dURs7vT1TLKSvtn0JhEItW0Gi2IB2wRiKv3HAO0N8yvt+EnW5oXVlluEk3mslu/EgmI9o9UuWnj2tEFjc6dgjN4jicIV84VfpfVWBQoIOGNupzw6SvRvSo/KLaOVPlflaR04N2wpqvvWp+DtzG0k588xq9xVpSzUiQ2ztnUoDCBnf1CmOCEuK6QuFNzmumFfaQG1LlafVfwmXQYAVTzKk5DbSv3FB4bmVkRfGTCXo4yVEAO0y+B6mxBKfnJtA6XyiYbbtLP0A8nGdzVvITGP9EZr/g7dDF4WIONpjsQ9jEYTI64yIRkMxSBy9M2FYd8i/RDa1f7sh/t6Gor1WF3vps/3mvZcOFoqweCEpdZdsno5jXAhvKZByGOFukNjwun81d7lDKSXyJbGtLCEHcnJxG2rvpXuc7Y07V+t5KARAu350za3WP8IEWqgmmswjSeSB0d0DlpIyyzEBxAZmfOvKvsRAFhZPnn2pcSH67Tvcbtsw79I9Xniq7tpE5r4fySab+UjJp5uShZN4qikWJgsZ6l9/XrHkvgUA3xTeZNBUTmRnApvpR+cMiGBxCTVuMopXpGYU2ky5cJ0zEq8A0JO8agNHoVkFU/LZ+Vxa93ZhuIMv4cemj76TYOzwbt5J2uy8AqILvy1oRaQTHy65hYW+EwACgPCm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4B3LGs1CeHcEyi893AGzNxOHjEG6GNnN2aIRz7HJNHyIDurkM8F791DwiNyW?=
 =?us-ascii?Q?rPubHylqY1sXGRDEWnr2DPvfuiM5OUhDDUqj7zhcF0xwLZNvPO+Bue0jsIuQ?=
 =?us-ascii?Q?KHCZvQDh3wT/pZhg/L7lBkCiZVxGNlUP6HpoUZ0upTumpqd1vcdUaaXpEFvf?=
 =?us-ascii?Q?+iAKLjDyU4r7n8JpgkE6/bUhpwCZRLiYBceFtNYP4hdaJTpOZVDavjv9uulf?=
 =?us-ascii?Q?MGYw/ocCDus4lSGfDeeu/+zkemyJg+/lWyRYR4nxSBOiXzNNyHuqceg7AL38?=
 =?us-ascii?Q?044vyDUJoh6cfqvg72rtmBR2gm5VFLXOnwJxLMqNlf8tlWHZ95RsCksw2tmj?=
 =?us-ascii?Q?SZONXF5YNCs/+8PyyYU5U8n2YQoC9wGiFVdd6GELQzXt3WBxA0C6/h+EbqS4?=
 =?us-ascii?Q?CG1b9ca+KLaNphBR1uYh67S0PGwxMg0kDIq/QpUWGKMLvhMGQNcMu/Y/a5Ws?=
 =?us-ascii?Q?MYd3Z7dV+EjgTcfYl3L3OnX3trzBfGfnIFqWc1aQgLYZ+nZapyx562cj2+FG?=
 =?us-ascii?Q?5WM8pOhwfg89x70vssWYu2J5JwlNP43Qbl9zp2ISfc/jAtpWcBwTJ5qBWXjn?=
 =?us-ascii?Q?oAvty3OxYZPIZv0CrWTsA3GFOUtbk7dn8vXBcRzbZe5+Sc59nIh62vzeoJVT?=
 =?us-ascii?Q?IhuaiJqBupKKOsNtLSwIUsCtoQHVg5LrqRiCvEM4isdcKKiWWWYQX3bl9S1R?=
 =?us-ascii?Q?1XUO8AZhe3lgr+MIqsp0snHX/E3fl/iwOev2ESfK338swEGq5FqoTIM+j9AZ?=
 =?us-ascii?Q?fvZ/UKgoerMdPG7S3ceK9YptCnWYRjwFk4lygzOnfFnAnGT5ZWdH8gFFZKp0?=
 =?us-ascii?Q?apO+zkpb4N7vQWJhXcZndtYf1ENIi1H7J5deu6N07aIZAr7MMtlTAxbWl0HU?=
 =?us-ascii?Q?3sHz6qwcsyCHiXACE6bV9hf/nxJ3XMOnwBYavvkZKuUcwBGfvD1IO08NnLvY?=
 =?us-ascii?Q?J2pYcXKrx+zP2kVJloHCFw9Hqkc3ZMGPD8kYKtP/AK07qQR2UoRxq0gwR6nR?=
 =?us-ascii?Q?VTmDr5ztQZl5nwgW9ZZi9dnOA1jX2XcyXshR1o8Hn7Gamikz3XVQffm+vtT3?=
 =?us-ascii?Q?PzdYrt1RdultBURkvZ/0kAGO3vfBXpV0xHxxX+uNJuzXM1P2BCKZ6rkc0Y+3?=
 =?us-ascii?Q?S1ld+Joi3QQEBbi3in5LCqhzBuK6lp2aFgAx55oY7yjIWW58DfCsNsE+p9th?=
 =?us-ascii?Q?3fOlvh5F08DLW7eeonz0wzMWAnDlLkRMk8dGoMwnw95FIddsjEqRG9t7LEK9?=
 =?us-ascii?Q?XnkhcFRggH9en4zZNRGTl0gODBScfdKlevodMWycqdVJ1ilB6ak+8ZUtDyFS?=
 =?us-ascii?Q?bLZKWrRtxs89fwiApzGA9ed8ZjJb51wpyVCtZZpeEniHNiRRykvi4Wc+VBPO?=
 =?us-ascii?Q?uLYQQt30+sC4zarbiqw7KEt8zAQnEOOcGK8b3EbI0UZY419azSJSdYsQksqz?=
 =?us-ascii?Q?6vni7VnoxJg/5oBUVB6YjuEZnrQqcnuoa9IaMEVfB68B0hPQ/7zd4UfNszQ9?=
 =?us-ascii?Q?/GcD6bVmpMvPFZgzt2d1IfgmLiqKF1MaFZO+04BbqHzKO0HyLAc9+EI7Dq38?=
 =?us-ascii?Q?QNdXSxbByiGPXE7ruj6jF3v2MUfVgzTKAxveea13qudFNQI4aA3Q89xn7LrV?=
 =?us-ascii?Q?CkCFkKAbf9bN3TJC1tbZ4ZzMTe/ij/eRDeLOAipJZuHHSuPKe1MDK0VV+r9w?=
 =?us-ascii?Q?UBtESoS6KK7jpzilmLXLZaR+lIovTJdE7kS0yrFRP12mQoZC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5f89c6-e1e6-4426-83a2-08dea54ead54
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 17:50:46.6654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shdMu8Bw2E4OU21E/245kDFYfMEUJqc//hBF/YpDsZPP7l6OKjTEjELnxJPry2h39R2l1zSosLlh/MyWAPvEbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6874
X-Rspamd-Queue-Id: D662548A311
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10442-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,SA1PR21MB6683.namprd21.prod.outlook.com:mid]

>
> Sashiko points out that rx_hash_key_len comes from a uAPI structure and i=
s
> blindly passed to memcpy, allowing the userspace to trash kernel memory.
> Bounds check it so the memcpy cannot overflow.
>
> Cc: stable@vger.kernel.org
> Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure
> Network Adapter")
> Link:
> https://sashiko.d/
> ev%2F%23%2Fpatchset%2F0-v2-1c49eeb88c48%252B91-
> rdma_udata_rep_jgg%2540nvidia.com%3Fpart%3D1&data=3D05%7C02%7Clongli%
> 40microsoft.com%7C12e76b7833a74fb98a8208dea541b8cd%7C72f988bf86f141
> af91ab2d7cd011db47%7C1%7C0%7C639129898875053924%7CUnknown%7CT
> WFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D75tKj32YfU
> uN7KdnsW63AjlwgnSLt2KXz34EUbXp2wI%3D&reserved=3D0
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/qp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index 645581359cee0b..f7bb0d1f0f8034 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -21,6 +21,9 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_de=
v
> *dev,
>
>       gc =3D mdev_to_gc(dev);
>
> +     if (rx_hash_key_len > sizeof(req->hashkey))
> +             return -EINVAL;
> +
>       req_buf_size =3D struct_size(req, indir_tab,
> MANA_INDIRECT_TABLE_DEF_SIZE);
>       req =3D kzalloc(req_buf_size, GFP_KERNEL);
>       if (!req)
> --
> 2.43.0


