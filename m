Return-Path: <linux-hyperv+bounces-10441-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EIuD83x8Gn9bAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10441-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:43:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BA748A238
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F9A4301A398
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F4F44D696;
	Tue, 28 Apr 2026 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PN4aHDwA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023107.outbound.protection.outlook.com [40.93.201.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5264283FCE;
	Tue, 28 Apr 2026 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398218; cv=fail; b=XvmQFRJZp/3UL+jGiWV6lYueR10nZb3ODqZVIeQuNGLcmyM12juCd7TVUSv/SwFlpvYHatmVSIe2jWPm3A+sq+Oc05FrB0DRIa0lcgCLZ4+SpBPInVHqn7E10ZcAS6Fu3uFt7Jl6ysY8W8BS6J7fv7vNqIDKeQBadTMO7h2jk+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398218; c=relaxed/simple;
	bh=vsWs5UPl6yQv3ubiJz0DPaJePo79+94ZG6L1+9RMS2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KpfdvqQS0lmPG1Oee6ZDCXGdDT51C0imvq4Q1VSyjNDwojptvs5SPbKqKBLr7uFTA/Qw8IwX2rO86IEfDuKtNeTTjQPXuIBCZWJaHtxrwjhWvp7JaVJje+3apcybjARTAKm2VNgNSpybhNee82AjFdByIRo1sWE9v+u+ly6zlsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PN4aHDwA; arc=fail smtp.client-ip=40.93.201.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuXG191I6qBgPdowXiEOWHNp4KxZWEF4EplwQP78YnjR6uKITK1AIV87h05EvFDluTWgzp+2A5QbvjVKarGVgs20jF8fNbJPl/HKfVoO26Yz74Dg54UfQj9QyheKYRcbQkkRpe3lJpRADdaoGz0YpFIdNMeOFAZgxPBnMn2OoOmtcUdNjaKUDtONjpv8GTTGsIYNQJrhG7cKZBiauF8w/yXbwSgbx0iPtPiHf/nCh/WAr7qnz+KYPhvUFFB3UT9FNXT75V4JW1kqt7oENanBhkQyaVKnq8n4lQmBbiq41/HaZmmt5jed3rPUPBqedtKBVpXySk8WJBTO9mEt2QuAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6bgM8HmMZyklI6fI+tWTXRjroTgFy5LHFwh1BRw9KM=;
 b=B+KQcuRHkSW7PUMgmKifyXBdeL5dnVUe7rIATT5pi6SS4rhAKn+Gj/GoWbkI3MjcCIwiF7Bc9Qy/D02500H5FzY6fJWNPWl7g+3ksk6omSfUJxjx7OV8gd8xqiS+5h3MwbZz0Tmz2V0yDrwWMMMBAsej7MGUkLGLm3JaKPDesb/5vTFcxDqlvVuCHaDbprKa/uRjSU/kJB+jiJFq/K5BAIYFlqXKk0uxW1L2CjM3rg75SlEhPJVoh+n2lRxpYNJudYb+lEGB/ya7+1q3XX5qtA7j2tJkAM9ILcAZnVYLeOvo1uheenTyPYBn5PaXft54dbf2NGPSe06fMU54DCDMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6bgM8HmMZyklI6fI+tWTXRjroTgFy5LHFwh1BRw9KM=;
 b=PN4aHDwAGTnFBKZS7urC2G52lskqIjWHbNRvaQV1Rt9a4mWZ8H9gRx6ALjYvMYh0LCNtqTLZj6e8jSL/I3cowI1ZyXT6KxGOCfl7vbtsJYckjhtgxyr2sGCUwRWq+ORocnZsNg5ipl3PmXKDHwemR1ttPQe3FPT0GwL6qlGV94c=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6899.namprd21.prod.outlook.com (2603:10b6:806:4a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 17:43:31 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 17:43:31 +0000
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
Subject: RE: [EXTERNAL] [PATCH rc 05/15] RDMA/mana: Remove user triggerable
 WARN_ON() in mana_ib_create_qp_rss()
Thread-Topic: [EXTERNAL] [PATCH rc 05/15] RDMA/mana: Remove user triggerable
 WARN_ON() in mana_ib_create_qp_rss()
Thread-Index: AQHc1yqbeO1ssbpJ7k+oTRTlj/Z8CLX0vqCw
Date: Tue, 28 Apr 2026 17:43:31 +0000
Message-ID:
 <SA1PR21MB6683B5E7D7E58A36B0DF2E31CE372@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
 <5-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <5-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f8739b82-f4a5-4fe6-9807-21c3fc679a54;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-28T17:43:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6899:EE_
x-ms-office365-filtering-correlation-id: 2100640b-0fa4-41cf-8f40-08dea54daa1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 J9lS4UTJm3loKKOm7TahH26ThOQKe2gDVcP12vOmTf6gB4TzWoxEnlJ1Ell8/6o0rURhV0G70nQ+1glAJEneWMvgKuntxHU9db9SyoSppwpOFsA1QHOJDfy7dy2Or6mf3BtWQ8vF7Hg1I3+tzl6caJhXVPkW4NS5QZL9EPGqiUto9ECMi0ZHNcAXKqalHnv5BGtAK8hYRwOyOHfeaA+qvKz3CTApNns/ZKRzfbZdee83lzwjoPocuNIdA1hvpy72ETlRvKaNyqnbN2t2XV0TTamuaVrfBCnCMfM0MCb8ScDSjZ84ducXTXs+PSLUghnK/t2h3owdD3qCeRHFdiY9aWhdH5SzmqOb+e/9iSOEAgyXWOSwcFcQOxdWjoa0bTLozbCoqOYemI7aISIVH0Hj8fCWYWbMdePxgL8avaS2Xl7Mu7Q5uROP2SC5/zeXacqFYKOhu3zrhthgvckZIqVfhOb3VkeisSd6pbZpUnA6t/A5j8P3xQIMKPoeotsiD34qd4GwejifavKKSKJe4AfB7M7q+8hXLRgqcAep5wDZgemGWMuoHBRQW7pyD/d/IWocnkdlLW4dj4I+CY1FO5TpRX25NQe/5y61un8sIgeqEZw3V0uGRXTWFmrr0UwHd4diCbbNnPcJs/ToFjwnfU4rHIRpsVs2eIJmSMMxMeyYpdeWbzcgMzLMVAH/HqkoOQbXkkPrLxiU261yoUANfE9oGFiglS/PlD7gcmH/d2T50dnDN+1QUUvpt/ZeBSg6rn77
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LNUqbGBNmtueMRW16ULhxCK7RrGOlI1gHZgOOwLI3E5UyVyINy8RHV8hUREi?=
 =?us-ascii?Q?mNqP2O9oii3pNk3SJ5gKR59CLd+WReNC+az3j6AH4u8idpoHE+6WMVF6bk2S?=
 =?us-ascii?Q?Zr+vNOQV0obW0o1jL6rfgDe/+4TNYjlseMlBtFobJsqzmtCv5notg/2BTQ/L?=
 =?us-ascii?Q?++/aqREDwI4EXkgJpnfAo2PpwTCHwffXW4mS150OPz+9/RuJEoNt+DIQhAI9?=
 =?us-ascii?Q?mX/s4Y9xkAauyiGP2xVv8glJxt3soFOhbbXEsn6Jp9VDkq3zVe+lr9cr640I?=
 =?us-ascii?Q?E3ydaqoXwUYfsQHFIGqn3Jnj0tGjqsJKf7KGmMFXjei8g9lY3p4QK36zb3ld?=
 =?us-ascii?Q?2H6p/gUfiISnVVx6jbzmikjLoAFOWXCVw6RrpSmB+vXdKL0Gd1Z4hQ1SMBml?=
 =?us-ascii?Q?ObsVobqBbfU6eh6tpVFPSYhWg16c7ZPQ7TtEDD06czwD6k9UQJyAx3MmEftY?=
 =?us-ascii?Q?WbeMPerNvhdXchednqWX3a6AxnVYVYP7uAVaXdPm3U0FQ0VJO5Wq6IUUJPny?=
 =?us-ascii?Q?eOCJkmJ9WEeaqBmwEf0qm1PGqTA48AqGvEf/uBQeLHxgU5CoY7IzjxLrIoLN?=
 =?us-ascii?Q?VzYRm3s9p6fZWyLQcebGKr/9Bn2wJ/rrRovTc6/VgZ5cDHzOps4rYkhXOqZ/?=
 =?us-ascii?Q?r2YkDtbUfVfFI3Ilyv2Yv87m+k7rt27c8Vyq69vqzL841u95IVV/HZTrjsOW?=
 =?us-ascii?Q?wqQJsulVSPYg+fzu0jmRzeRS2sJU/u8bvFbeb1BvDapmafyUikpaEiOafVlU?=
 =?us-ascii?Q?I30kCnK2ZsNKlUS/ui6eLCDEtaHPkIev1vnkzh0gzjdJ9ctipmO/rs3hbl/j?=
 =?us-ascii?Q?x9iFtPlDDx0D37NIRuJiRJ86YPnQRrwk6IbbMMXXfDgZNqKcBIyAJu18DX2a?=
 =?us-ascii?Q?e0FBYtluiZicsnYMTWKcNGHb2Darlp6qYTv3AlFPOrfXo0Eo83kqTGzLll4o?=
 =?us-ascii?Q?Wttx+isJOei+frSu36mjKS0JeT3Xc6NJ6TY1YYB17gbxi7GjksPTknvI8I/J?=
 =?us-ascii?Q?NXktifBNBrlqk/qSdse5apI2IZgXGYyNVNbSlDqDPzXx19y7adme/f3HTE1g?=
 =?us-ascii?Q?3VVi2FBUTT2H5FUF2UaeqdJH08aTPBDGoiS0fbPGcLiv7YJDN9RBHTVXaOFa?=
 =?us-ascii?Q?joU2/0q75DwsNDHURQIQ26aXIwrL2sbtynALvMleaipgXKDDPB1559pGflkj?=
 =?us-ascii?Q?cdJl/G0ydSAbP5YDH5YFJLvOEz02DjbCc1Xiif0KxzzXecs2p+5Lrcc6aJOc?=
 =?us-ascii?Q?PQUqcRFeU4t7Xfxr4QE8s1qW/sfPcLyPZfjFIkTDmNAvh3c8RBiOFfK32/D6?=
 =?us-ascii?Q?n6Z8Xdq6LCQpMMB18/qUYZAm9xczWmyz0PHJglGHkFZ8rM0Tj3CBGKfmMAqn?=
 =?us-ascii?Q?jjY9P3mNQGO8JlQe1/WdOLe30og8wXKir8xHqNekkQI+bB+M75RWBLtEuFya?=
 =?us-ascii?Q?HnhMTZqHqPi9j+Y7GPLC8RrD5jA4Wapua/2SPy9rPL2YMsvTexCJHOFo4LCK?=
 =?us-ascii?Q?A44mtO881Xvo4sx4rju2nhx25v2sxFATVwG59Jfm4PZ4MSoaT88xwMOWMtqM?=
 =?us-ascii?Q?O/0im3WVOSUU5PmqyG3C/7kUTYmOQPjVgWH6Qu7HPoak9lGE9w4jQoriTqZT?=
 =?us-ascii?Q?NEfgSgs70N9LjsI3dXe/flCdFPUtluNu6e1Nx4fCYGJE0j8Y4WJLxrvlucEu?=
 =?us-ascii?Q?0Z5fI8/2w0nGISvsKClf3xStN4vwG2HFOAjGaHHhk5jCsgkQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2100640b-0fa4-41cf-8f40-08dea54daa1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 17:43:31.8215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sUwIkS5LLaN+rWC+JaGyEI76vDuMgFegFJy8mC9Zb6AHp/JUIvTFkVVItFRtaEWIhb7xt2CMkefTQCJIGcFl6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6899
X-Rspamd-Queue-Id: 98BA748A238
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10441-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR21MB6683.namprd21.prod.outlook.com:mid]

>
> Sashiko points out that the user can specify WQs sharing the same CQ as a=
 part of
> the uAPI and this will trigger the WARN_ON() then go on to corrupt the ke=
rnel.
>
> Just reject it outright and fail the QP creation.
>
> Cc: stable@vger.kernel.org
> Fixes: c15d7802a424 ("RDMA/mana_ib: Add CQ interrupt support for RAW QP")
> Link:
> https://sashiko.d/
> ev%2F%23%2Fpatchset%2F0-v2-1c49eeb88c48%252B91-
> rdma_udata_rep_jgg%2540nvidia.com%3Fpart%3D1&data=3D05%7C02%7Clongli%
> 40microsoft.com%7C05b55740f97741c63c8408dea541ba1a%7C72f988bf86f141
> af91ab2d7cd011db47%7C1%7C0%7C639129898905286592%7CUnknown%7CT
> WFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D045NsQ2efi
> m0Mmc8EGeKWQ3pyFbs63%2B2023OvD3%2B8IM%3D&reserved=3D0
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/cq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index f4cbe21763bf11..2d682428ef202a 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -137,8 +137,9 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev,
> struct mana_ib_cq *cq)
>
>       if (cq->queue.id >=3D gc->max_num_cqs)
>               return -EINVAL;
> -     /* Create CQ table entry */
> -     WARN_ON(gc->cq_table[cq->queue.id]);
> +     /* Create CQ table entry, sharing a CQ between WQs is not supported=
 */
> +     if (gc->cq_table[cq->queue.id])
> +             return -EINVAL;
>       if (cq->queue.kmem)
>               gdma_cq =3D cq->queue.kmem;
>       else
> --
> 2.43.0


