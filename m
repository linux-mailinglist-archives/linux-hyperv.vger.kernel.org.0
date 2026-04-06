Return-Path: <linux-hyperv+bounces-10031-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sISpNV/w02lBoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10031-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D8E3A5CD8
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD046300AD6D
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E103932E0;
	Mon,  6 Apr 2026 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HtN3zXLD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34DB3939AB;
	Mon,  6 Apr 2026 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497261; cv=fail; b=j5XYKqsH5UYUzejAV2Vqe/DyaIoveDvAkBTb5Kf3fRQQhjxCzxYtPXAz1Ws7gJqHAyO+yMSnqkO6s0AfSoDrP2i87KlMKuM1Pm0WRvEIzGCgIItxl7Ki/8hPBdMfNlyoZFOKQGrEru1B7JDImx+DyNSnW1BJoNpnLQXGb/hMP8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497261; c=relaxed/simple;
	bh=z69yoz+VZ31mTAsC9Wji9aqDhsgmVFGg4uUqnoRBXK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kA7u3/FcGxThq+U8YKU1bJqaHOHUgyj24BIBsNmM+vpM+FFzLxAmpVtwpLvcdZvUNZC8NpAj4wtIRVvN8v5yosApUEOBEcmLRcuBNF0t0IJxjhKPZqAJ4mJ9fhXNKJeTUTX+M0wfE4iZHytB338hdKrAgzUzI5w62HLdXy+aYbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HtN3zXLD; arc=fail smtp.client-ip=52.101.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgYzqnxwfnXkAGupokJGCY4F7kUS42bVuPJBvm+10k0MbneDv/uMguNfLk5xy3Gp0oHKMQd49g+wGRdp9yowLLQv278mNYbPSE0uwstNFwzP/ECVv+HExwmDmVQpdz0dFiJZj+Ak8KqfeWIU5MelTBEjneoxfOAk4awk2KZVPAAG+qWVQ3g4HkhBH9RlXzs3ofg5BfMLoRWHaCTNGtzNAhJqn9KvaDGXR6/LRYmkow05Px+IG9KTq8tQoZgD0KD8dVc7uzHm1Jn+cXxIjWmj3thiw+EBdd2JrBcjh39rp9t11OM/1abOUisFoRLeECivJS5ZtycXeR+2NeYaWBAstg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSy8w2iUlpulbsi56BfAYFsGBG7o0sG/0tk0K84qBmM=;
 b=rHrH/qa8vgunwt+hTvCSPdEw71FyTOS0xiu6JOQcHvjyiPdcwwvZ0XzvdGVs+ZKEY4HMZ5cW0/GafbGo+hsyNSLFmfzQI+ARqEI78W5+msfj6OokBtqpMWY3zBcuAN6K9Kz9a5+yye4V8wjuYcF7aDYkZnfmpJC3KZY9SeM2nqKSIvLCWr7KWlrjAQXrFQ9c1qgpG+9oZ1e2l0BC6IX89qppR1yMGbNhcnWQ0hBrwZYMpqMubXlmXyT+hGD1QA3SHJfuaTOUWJ2W4CzRMIXDIv0Ud8sRvml0a36uf6YrwJBQ6pf+sE0Z5/2yfixtzYjJiXolFt3Dry4q2MfrGNLTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSy8w2iUlpulbsi56BfAYFsGBG7o0sG/0tk0K84qBmM=;
 b=HtN3zXLDqx0xUwiik14LAmC/o/XPXkeqDRiJqcoTmrxgBGwsKNRTmD2o82n4YYMUcXKhHbYAGfQAK76sC5F1eAmDQJV54MHSAUemmU/CMRVZZ+mio0WHyLRgD3VRWTe7BwplFxXYpIZWqG1fiq+jBRs19lWmcMaOoqFAWKKzV1qaga14vPZeoh+ezYGZoMj9ZahbEu0Iew8YRrU1fGPO3rdy8iCAV0Eb+fRZQdD78p2dYtSxC5zHQY2q5l2ha4e7v8eid0LapiNQYtRWA/R+Yn0ZFW+pilZsx7R3TGl5xlZzHtTfysZZDDIi5wSuiusw527xbk5OHxO2oqxCn+SL4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 17:40:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Yossi Leybovich <sleybo@amazon.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: Adit Ranadive <aditr@vmware.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Bryan Tan <bryantan@vmware.com>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Parav Pandit <parav.pandit@emulex.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 12/16] RDMA/qedr: Replace qedr_ib_copy_to_udata() with ib_respond_udata()
Date: Mon,  6 Apr 2026 14:40:37 -0300
Message-ID: <12-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0252.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddc219a-b9fd-4196-728c-08de9403a1bf
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	I4CXVo8/8lQHZrhK6wYXprLdk8cwUYWmZqZyWANa6Ra2KXloRRebci3BKtVexYrRo4OQ6YmPYZPI4V+8GulNXs7QNO5gMSX3lIvS23vaQCqoUFdT9BmFfUO2h24H3QRGRvUcJz6qGLKBWZbZ3TIiXE6ujD81P+TuC46H9deRJC3RK4JgoCD8mlQ10HiosyYX/o5Uux4wqkXVzd0oMr0bg4luPeTIB7RIR0jeA/HxZkFS6OFxCkch/6how6mEn3Mazty/6tXnbmyXSDdhaTVLSPNLv/hGsjkteTpHPRmVzVEmmudleQKunh/bONEC7nScxfbHD6O/TSy3boerbdXsBVPe4lzCKy/8EERH6OS9Ty+jTmwdBCfJcEQGtLu4lU7f01CFwL8RzyVQ4BdS2TrLJGDjRBk2wZqroYFc+6oW/6jGutW7beqJHTFrg8/mWGtCywE4h/AC/0fvHCpYeLSy2RLBPUgNeWbD3XsD1hCINk4GkvUy7eMSQ1qC09sgnEUTxi2DAq4yHTE6QP5e0BxODoFCBNNBYPw71RwgNK/QE79OBlsxCgpcczu5b7EoNTkLc7GFPKIfOOucnWH/t/5p5tD2FUystFg/lysuougps46rLMeR1P70fSptHULuiY9IxiQPBAHVhxK86Q1wSuBYauA6geF+ajL9uFhIZLS1DI2MWqKfSPFB4hpUxM33f40DE+2buBuyU2H1xSUFGijkjQJyalsdsGC9D8oN44/5a3oNuTj3H+mAxBo0XzBdSJOcbAAXRcLgcoxjNaiJemvExw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vSUWxeMPjzhiQesBl1wSWq5JXHPzwvXdbOXfE1sehv3PMW9rul/QsGi7RadT?=
 =?us-ascii?Q?DVD6IunvT5zc7P7uHLnNLKPmaSaISSeOE2MfN821Dz5XGMQ012ILRamRp5CW?=
 =?us-ascii?Q?qZA+Z5BEA5MBE0leeLOPwhbeDjedjR0myx6YOkpWk+h1Nt4nEp+Fn3DQKkNd?=
 =?us-ascii?Q?bIeRXcLXEdlUxWInCpuMfV6tDp3g1xTzRwy1Dw2osy+B2pghvhrLOCaxx3zQ?=
 =?us-ascii?Q?bmzeFRdhYqXTC3z+tFotGriQWcwh7mC6BlAhy9pW7qC7x+J3GSwkTqUOzsMN?=
 =?us-ascii?Q?MxauvDpzxzqt1G0tM8kScBw+8/nPdykSPmiqxgIMfdP7p1oTYIta8yrJMkZs?=
 =?us-ascii?Q?egqGWnBZdorsw0bp4F+n2ECsmU9aKGu3p6B0TKhx5X35rC95YwoSIRH0dgFq?=
 =?us-ascii?Q?jufUaxFx3oHWTCJDM1Val3d84hW46Mv3pdK3rRzTLBhVPuCxLbFegs6zCZl0?=
 =?us-ascii?Q?XuXca+OeuPjuF+FWnwzSrJVQkz7QYQX6mvb3LDth3tmM2mCBiaDheoh/g9Ip?=
 =?us-ascii?Q?Oyau9EC5OCU5V4JT1Mp0mD6EFoF825JqzMyOplJa9v2O8T32VR9QN9WQzZVQ?=
 =?us-ascii?Q?iFMm22CtpNp5N+uzdjhJ9AgJ+2UMZSpAY+01QSL412kJdrNkQ+N//qE0Jxwj?=
 =?us-ascii?Q?plQ/yo3aE50ULsSqR63GcK/43P94PSUxQ+xZsqo3bxmpW2GFhu+eZ87ZW8Al?=
 =?us-ascii?Q?3IkxMJy3IT8pw461WqsTCxh6llavqO5LDWztf8xvVi30TcHVE0KHebq4/SO+?=
 =?us-ascii?Q?+5nss6A18Ipoqv34TFgq/OjQO2MnMMRiWPtJDcATdE3dbCCVeAf/t4pZTHdK?=
 =?us-ascii?Q?k0B6ZF0/rm8CbZQC1Apbsx97ZIF6agHqAojTW59tqzod9cthK3M2PX86Y1/1?=
 =?us-ascii?Q?Pfvwr7LOoULJ7JXLGPT693FK6BJg6XWzGRS+cymDKC6RmqsQdv7AeNkDQCL0?=
 =?us-ascii?Q?go0lOECNgWe5DVvBHVwVbg/ZJBC0m1eQ1i36DIYQisMk19YSPTL0YWwYzv/f?=
 =?us-ascii?Q?L+/41Bo1ykQKM5mVrdpXNbXxEhsePW4o7LujtuKzvsu1dzyPmRdPegTgU1NE?=
 =?us-ascii?Q?puil3gVKjw/T2K9JdBfvI7ikaz69CwQdJXbbauCKJBiJ+FjK1p9zmgl31JI1?=
 =?us-ascii?Q?wRvRTHqibyhm8iWSil/cxizfuIpYc2KdHAcwSJvYWkCfdqnhlpGJv4kRsA69?=
 =?us-ascii?Q?FCJijnFBxMnYUeXuaqkcK5S24QLHVqQ0M+EioB0R9mfWWBUo7B+dr+B1TtdN?=
 =?us-ascii?Q?x8XN7MX5+VEXGSQ6yvROgYHDJZkz1H/Pc4P+dw+RjlPEHnfAJ4WU8D58VWhU?=
 =?us-ascii?Q?cEFso/emPqM+dfpjlJ6MrL5QTiwrafq9S5S/94hvwJ3PQ0FgLr282A+mEhTG?=
 =?us-ascii?Q?5WeQpNLtgxhNvch8h1GYr7D0CZEmQ8q4dYIlQe2J7Ke/kArwF+zejzFTCgfC?=
 =?us-ascii?Q?oOEerg1LicIqDUBFGkEV+Fz4eVkEkExoJkwi9QqAzYAeooH9ACTS7BqABN0P?=
 =?us-ascii?Q?lLYK54icrhx6nwGlhrxbcAIhH2GSIEQinxxdGqGYidQyebx6pPY17sCDNA0F?=
 =?us-ascii?Q?GpZrClExJweaBH5rI8gWxIEH1oOKNEXvqj4iWLLtEooG3OO44XL6jwjhxZRz?=
 =?us-ascii?Q?G7PQC8cKJI+XJyuUANuwsjnVKraGsQ8kBN99nHjbOiP43eHvcI5QTcSFE63H?=
 =?us-ascii?Q?01E+EyW+nvTNRljUvtHxubdosMdSVjc3VF+Q0K3fY3VD+9Sj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddc219a-b9fd-4196-728c-08de9403a1bf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:45.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NoKgWCSxCrROoBDx/A+h0S9r8TCVf8T/i7syKt/gU0gN+xw+kG1GJON1slHMdcw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10031-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2D8E3A5CD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is another instance of the min() pattern.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 35 +++++-------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 3b86ea1cf88883..79190c5b8b50b0 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -64,14 +64,6 @@ enum {
 	QEDR_USER_MMAP_PHYS_PAGE,
 };
 
-static inline int qedr_ib_copy_to_udata(struct ib_udata *udata, void *src,
-					size_t len)
-{
-	size_t min_len = min_t(size_t, len, udata->outlen);
-
-	return ib_copy_to_udata(udata, src, min_len);
-}
-
 int qedr_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey)
 {
 	if (index >= QEDR_ROCE_PKEY_TABLE_LEN)
@@ -340,7 +332,7 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	uresp.sges_per_srq_wr = dev->attr.max_srq_sge;
 	uresp.max_cqes = QEDR_MAX_CQES;
 
-	rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	rc = ib_respond_udata(udata, uresp);
 	if (rc)
 		goto err;
 
@@ -459,9 +451,8 @@ int qedr_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 		struct qedr_ucontext *context = rdma_udata_to_drv_context(
 			udata, struct qedr_ucontext, ibucontext);
 
-		rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rc = ib_respond_udata(udata, uresp);
 		if (rc) {
-			DP_ERR(dev, "copy error pd_id=0x%x.\n", pd_id);
 			dev->ops->rdma_dealloc_pd(dev->rdma_ctx, pd_id);
 			return rc;
 		}
@@ -696,12 +687,10 @@ static void qedr_db_recovery_del(struct qedr_dev *dev,
 	dev->ops->common->db_recovery_del(dev->cdev, db_addr, db_data);
 }
 
-static int qedr_copy_cq_uresp(struct qedr_dev *dev,
-			      struct qedr_cq *cq, struct ib_udata *udata,
+static int qedr_copy_cq_uresp(struct qedr_cq *cq, struct ib_udata *udata,
 			      u32 db_offset)
 {
 	struct qedr_create_cq_uresp uresp;
-	int rc;
 
 	memset(&uresp, 0, sizeof(uresp));
 
@@ -711,11 +700,7 @@ static int qedr_copy_cq_uresp(struct qedr_dev *dev,
 		uresp.db_rec_addr =
 			rdma_user_mmap_get_offset(cq->q.db_mmap_entry);
 
-	rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
-	if (rc)
-		DP_ERR(dev, "copy error cqid=0x%x.\n", cq->icid);
-
-	return rc;
+	return ib_respond_udata(udata, uresp);
 }
 
 static void consume_cqe(struct qedr_cq *cq)
@@ -994,7 +979,7 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	spin_lock_init(&cq->cq_lock);
 
 	if (udata) {
-		rc = qedr_copy_cq_uresp(dev, cq, udata, db_offset);
+		rc = qedr_copy_cq_uresp(cq, udata, db_offset);
 		if (rc)
 			goto err2;
 
@@ -1298,8 +1283,6 @@ static int qedr_copy_qp_uresp(struct qedr_dev *dev,
 			      struct qedr_qp *qp, struct ib_udata *udata,
 			      struct qedr_create_qp_uresp *uresp)
 {
-	int rc;
-
 	memset(uresp, 0, sizeof(*uresp));
 
 	if (qedr_qp_has_sq(qp))
@@ -1311,13 +1294,7 @@ static int qedr_copy_qp_uresp(struct qedr_dev *dev,
 	uresp->atomic_supported = dev->atomic_cap != IB_ATOMIC_NONE;
 	uresp->qp_id = qp->qp_id;
 
-	rc = qedr_ib_copy_to_udata(udata, uresp, sizeof(*uresp));
-	if (rc)
-		DP_ERR(dev,
-		       "create qp: failed a copy to user space with qp icid=0x%x.\n",
-		       qp->icid);
-
-	return rc;
+	return ib_respond_udata(udata, *uresp);
 }
 
 static void qedr_reset_qp_hwq_info(struct qedr_qp_hwq_info *qph)
-- 
2.43.0


