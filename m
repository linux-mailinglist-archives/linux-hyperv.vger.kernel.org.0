Return-Path: <linux-hyperv+bounces-10432-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLMVJN7h8GmoagEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10432-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:35:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6554890B2
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E34C630F2B33
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF76B44DB9C;
	Tue, 28 Apr 2026 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nDTp/b70"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44F743D4ED;
	Tue, 28 Apr 2026 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393088; cv=fail; b=GfPO0XFkXDbCjsAfYWnn7gsXPjxdHn9j/vdqiTotyVya6U2S06YM0hGwqNwHKrFXyFIHCf7F4YRiu0FH9csDUqBNf4kLZKO9Qk+yAB9g3hUEvs+AAhRLF9sXMBHTSpLfZvA6uVwzS12IKNHVKqvrUdNVC/Ljux7NJByFqDz7nT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393088; c=relaxed/simple;
	bh=3fgPNs8Z0vB3A5jkBPH1O8rQlzZffGeBPZj0/Vvupag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rl6TnXgi26LLnlUU8ns2ZhRlZcT2R20ZhGoJS7y3qSKi3bjuLd0HIm2NsCoD1R8jJYsdq82SjY+B9Fc7uKuBbWm2/eVr/pTANPxIeMOU7cXOjVtw1tBBGlK8Ogzvk+N3xocsEjFHAnzYtNeocGeMN5SgGJXPFKe1RofSckiVmOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nDTp/b70; arc=fail smtp.client-ip=52.101.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCaav+iWZFgSj29lCwP2Qf1eMVu8o7InIgBpLCMdxEuPzzqJmkjJ5n3IQr81CIvyd1/Au4WpEW2IUXsX1CW0Kyyab1G5J+gJKLHdBoGg1QRSbCCJg1L0WsqB5GXPFWTcp4Ul6cD9/nWzTJV/uGHPYWCpAsfPgadMowYvuE1+8Zkj7OdcHsEAScWNC3bUNtm6hp7Biu+G7RhuhtB4C3f1/ymLG7hE/ILqO+ymXB1SStoSrnIkY0W/c9MnVecL1M3e4M04VZlyLefnoANSYT9UpexehtYnyQ5S8iX9L+2ZkepO0do7N25VHxFtw74G+sWp4Gvb4p05TTP7VzoqNb0SyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDF7pkD5nCHjPCZ8+6Mr0nkByhs/pJU38RFN1mcr4E0=;
 b=dYaxV2tZ3r2NyRnY3I2EYH+OviL/Un48tjGcJomXmsfc1YMn0M0pxN5nzKinVL/UR6Jca98V0Y0rcvVBkTD8a43VWoA6vhQFFW7E2z40QCmfYvU90w1vCumlWgOr2jVJ2J2JyKnInHhKaVO0uMwSWE8zRV+bJpvzdXVTTLzpdw9JN0GcEm50p/BmsfZb2b05W9B9J5Cbr6buD+MF4o9Zqr6qDbwSkB+UomcrNHooJ1xvPeKMH/DOMJZShQeLhYKZ9jKoxkmwmLWbWVnONsWnkeLdVV6ezm+4AdYVK8q0bOdWRxHvrqE9BahTbyAYtNcUvOprkAG04vc52b5hpH7fGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDF7pkD5nCHjPCZ8+6Mr0nkByhs/pJU38RFN1mcr4E0=;
 b=nDTp/b706JPZKsbtbO3bzFJSJmSMEBKfeTT5bU7Y8fpM5eAFqziiSqFRBxRfnwFIsZExzP7nM1G21oGEN2KYEWyD4U9cpZ63l5hO2L/ztLjao23LgcfKBfxSyn6UZKDlkgJ7jgpeKOH1wLpkbYntBlUNziV+Zx6LxjEFzykQa9SCboptMwnTh4VivEFDsMES+YCc9smsTWrjwDffNOwUwfXJBN0YIWw0Z41lyuUrN+mSxdDc9gsSJ+B4zye41BfH7IGwBT7f6e1YUs9yQ253rP6vWZ7wYbNpG3iUGgh06IhGy7Yl2EPUTIU65jzvblC4hwfDqzuG1qqQvz4ur3xOdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:17:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:17:57 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Eric Dumazet <edumazet@google.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Adit Ranadive <aditr@vmware.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Andrew Boyer <andrew.boyer@amd.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Brad Spengler <brad.spengler@opensrcsec.com>,
	Bryan Tan <bryantan@vmware.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Kai Aizen <kai.aizen.dev@gmail.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Yixian Liu <liuyixian@huawei.com>,
	Long Li <longli@microsoft.com>,
	Lijun Ou <oulijun@huawei.com>,
	Parav Pandit <parav.pandit@emulex.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	stable@vger.kernel.org,
	Tariq Toukan <tariqt@mellanox.com>,
	"Wei Hu (Xavier)" <xavier.huwei@huawei.com>,
	Shaobo Xu <xushaobo2@huawei.com>,
	Nenglong Zhao <zhaonenglong@hisilicon.com>
Subject: [PATCH rc 10/15] RDMA/vmw_pvrdma: Fix double free on pvrdma_alloc_ucontext() error path
Date: Tue, 28 Apr 2026 13:17:43 -0300
Message-ID: <10-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: beb0d872-1929-4039-8fa1-08dea541b2fe
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	K/iTPcF8eMkRcKuq3Y1dn11ObVo0N2hGsG6BGb09dkSKK+B9Ib/KqJlY2IPQ0lnjIzZjD93IDy4zem+xK4TK7SYEQMnqRHH0p18A1ReTCxNM5yZ0AW1Gx/ZcJCB0oE5MhLp+shEcnvLWKQFDHbbaRqL+J2FKfunJ+j6g4umi3yV6ePj7Sgm4CESaxDgCgjbDt0AcnMEPgwPCB2hxNNzYihhvItIlGIMMdJJeNIek398V6DIHnSiiKXIQHGme9L/o+uOvLVAawDwFRLeL9rH0vcYBvtck6vNUwfACF7esDFNLA1qYeX5Gx4yfODHKWQ1aEBAti4q9OYhuOS8N93CdW9zCDwz5wJ9x/6fm0rrnYzoI0RVE+tfXcTgpdo5R6rx0l5iW+MRyTnfy6RarJBwHqCT3odj4w2wkhW/kaTZyfExzlIgl1AWr9Nmw7GAtOANw5JwBiBi07vVP2tqKp37W6FSVQU2izNp2x3KUVKicpXycUHG1oK8ke+1U9pY3hGO+KsosK1tml2Hjk23dp3Yg2kOwrM1YzfxEXI5zaMPaEw6hlpiVrjcwKpxQOv2agmoz+x2KWfNVRGvxNJ+0MHJnErB/kjZWXVcoXZxyQNem+zPaI5DOCErLzl7tIKy1VTIblNJo/Vd1Gp5jdKdBD1YFvRDK5nuTRq4ygOkqjS79BgrXmlkUkeb0f21IbTXxAnnogwWm7Y5q+waxNP9Tk9aNQLfVSURVZMRTK5FgddhrLMTb9eNCu3LJrtnbvv8XBTJA9kDIIt2+z2+9BiWeEGas0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rzTT3UX436FPpHOqyD04dOZdobYpJYlJz2ILCB5qpkyRyHpiMQlI3PllEEDf?=
 =?us-ascii?Q?x9SLYur1DyCvg2f5WDWWjOIv5YwtCeQfPSN+F9Q2f8cw22pvTkkqXO7oXOhw?=
 =?us-ascii?Q?nmtMnMFkEJ7j5a1lC7+TD2DeST88u6P3mR1a+/UHaH6Fu0/0ZjBCXCgKGZDt?=
 =?us-ascii?Q?6UPZaw675GXWqlJwq/OXLQ8qr+R1j5DUNBd5iy6NFPPK3AXxCRr5boR8r0Az?=
 =?us-ascii?Q?ZipHRMvQSgnBEiKQM71bpUwC8NqkZB+sNfwnq2duN/H8/Xj4qhIXe9mTI/rs?=
 =?us-ascii?Q?uk2qaDTWq1g5AHSb2FUClQYBlQkvsqRkPBzefE8NTjpYXFKWDfuwZdRkWvy9?=
 =?us-ascii?Q?pk2AMLBUWd1d/0c7PJeplsvXQryQmn0DeJPOY5DvOQbhu03TWEt/bxSz8SRk?=
 =?us-ascii?Q?nXea5biVs+PShKyiRQvEwoqWQ666CHqAffTh6IJ2cQPZJxny9EMWi5Pkfx+W?=
 =?us-ascii?Q?dw4531CqiM8471iIHXYNtM8LeeEh47kK5cO65t+8RGT4RSPLZIi9x+J1gaOR?=
 =?us-ascii?Q?0aIsgpptB/hrrXb1eaYV1+BmGc0wWTU0xD75FRNFTQ94ifla3CkJfw2Kgyr5?=
 =?us-ascii?Q?PUYbTYHREQID1Q2OiKI+MFEWVKAht0E04C3/jrIzi5JUejBIHPhyCmA2+xZV?=
 =?us-ascii?Q?whXXOq8tEwjGTg2KuubBQurlWRfCu/SYfWpRgJ1FMvh/6HQuoi+kLs5Tq3gF?=
 =?us-ascii?Q?qV+RRZEXT84SBJQX0/kgsPUibnGQ4ugjANHXtoZ3E5ctoMRwMSrjSEPRVVLM?=
 =?us-ascii?Q?fEYUmmxcNbo+lhbghVUkHpV8Jdf2zGpc2Sf/kDUcIMkwcY2rF4GGP9Z8X7ug?=
 =?us-ascii?Q?ZVK2FJ5WOx0TkasS6dL89QZ5pekHqbM1o2eBt0dPBMI/djuWJRT2ED3lR6C9?=
 =?us-ascii?Q?M3z+8mnWQnqSrMmhUapiBFP7jSqlgcPKH4cIOK8LfGB3+kJ2R1hDwOJ74tsv?=
 =?us-ascii?Q?PdDFdbziZOjJu76EIIDdClUStGazP0b2k1tkAsOIwlrD3fTd7m7vkZ/X8kRP?=
 =?us-ascii?Q?YAc6LaMRgNG00xmfrMvszMGBT/yy3Kx/jfgtI3zzQUj+/UBVNJy7VvQU+XVw?=
 =?us-ascii?Q?AOy8siB6kIYj6TZ8NCH38VnqeVqxnqaqTfnn/Fx7HM95I4YvN/jeLvyLZGOL?=
 =?us-ascii?Q?uhHoMVSC1A4N91GHlLr63B7D6/QnrFptTPZY4oqrDcvDqDDhu7JsVLBgicdx?=
 =?us-ascii?Q?m96rQn2cyg4hl+XilUl8p3WCgGcUn9h8+kzEI95Aac660da0r2IqgkmA9pth?=
 =?us-ascii?Q?xTZ9BeBYnXu57nbUdN5smNPe3kc+4sZYWT7/CYMSEJW8i4NMQ3oH34rlmA7G?=
 =?us-ascii?Q?jF+tDz/uLWdy5wU/ggR1CoyCbpTM41h7pBQeX/RvQXfDLc/Mv2SMha+qOIo2?=
 =?us-ascii?Q?aQDCuGKeFQ0No2voYPZ2TjaZ2DTAmHWh9S4866MUAo2zykDrl3OZpgx2WXla?=
 =?us-ascii?Q?NeqTJKieD1m3KDlv+51WOcH5yFl1Qbs3tVT2FOVCOfX8id64ULgW2x9aCTdI?=
 =?us-ascii?Q?NrDFx59ey2iq5SSIP355MpeZl0r84Z2d6WZOiXe9W9D9dxmFh7Fs2YqGQII6?=
 =?us-ascii?Q?wZzZtsmsVrX6yDujMljxpR6tlY/CbYDsDSpNBzz3r/FiIh/F7NouPy9JcMTj?=
 =?us-ascii?Q?CcTfKJT1TPwjVK0zHSzDWg+z4es/+yb82/S9urySruCmwjWuCUaYHK5BKeZC?=
 =?us-ascii?Q?WO+z2VYSECvnLcyVB8nA5t3WWUOTNtA4czKyGpepOMc1L/bP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb0d872-1929-4039-8fa1-08dea541b2fe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:53.0368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAXwrG3e8f3fmGCxejiQJxeMaoaBZQXE9j5r0cDjDEqu0BFHKS1gxOFJY05GNFH1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
X-Rspamd-Queue-Id: EA6554890B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10432-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sashiko.dev:url,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Sashiko points out that pvrdma_uar_free() is already called within
pvrdma_dealloc_ucontext(), so calling it before triggers a double free.

Cc: stable@vger.kernel.org
Fixes: 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=4
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index bcd43dc30e21c6..c7c2b41060e526 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -322,7 +322,7 @@ int pvrdma_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	uresp.qp_tab_size = vdev->dsr->caps.max_qp;
 	ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
 	if (ret) {
-		pvrdma_uar_free(vdev, &context->uar);
+		/* pvrdma_dealloc_ucontext() also frees the UAR */
 		pvrdma_dealloc_ucontext(&context->ibucontext);
 		return -EFAULT;
 	}
-- 
2.43.0


