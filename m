Return-Path: <linux-hyperv+bounces-9793-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBdVJ5tUxGljyAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9793-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:33:15 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0597632C804
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A92C3016EEA
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A64389106;
	Wed, 25 Mar 2026 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HMh5qzCr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4BA325727;
	Wed, 25 Mar 2026 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474112; cv=fail; b=UOrTRIRn4NfbgM7ybyFlACbw810wjyx3X+fEiG0K+zgAWn4QDIKgzhilPV3+H2CD21Uvl9c3vXIVWUarQVaqAPDYIM0n/V55eu3JmUDPVMZAMJMLxGPnSgXjOC9JT0DVknOIFpiAV1I9yH33Nco5tq2xS4n8zTaDY0FSGEAMkLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474112; c=relaxed/simple;
	bh=tOlh0ImsQFY9TmtLf3XUnWJhx0MaBVPVpxOktqzn5xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FS8LJAW7GKGtgOHtdWEkrBOgsWmB2ICFTqnwelp/1vRE9lTejsrznODwtgkICVL7WLC2msD+mq67VueNi4Oj4JaVb8rPJGsgPz4ICVdaibV+wSeWcncHfKzOPBBjKviRk4vKZIoKnsFWAWTrEPSCkEeSagIcGNTlkvWELqeKNGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HMh5qzCr; arc=fail smtp.client-ip=52.101.53.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EF2KNPLnyeoBOxbp1Ys3hZ+616V5UtAWQmcAWbv/WubNNBs++K+UjwRc+vgIuPTfE/iL3e2gUcvK28qQtCegc7F9FI0Pg4xMllZUcM0PM3mTx9pKnvhyaIloP4LeeGKTTNbml81VRqg9ckPdNIqy30TOJsNrRFB1m8jvv/Rae9qxdcWXIxZGkfYhA0X/GZubHWUhLgIk2e8REQXzA4EhocdUI/MRLnFYrlez9nhiYdcGHuVDPO7oEpTuFaU/Dd/z3yos1LYkJyme0aNwP2yYxKPURSciqN7SMmyNOZ9i8VQxUUrzpa5427mRqlNNACe0csLII4pDcuHGaoh3LKLTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA43njR0wTImGwqtH9boZFTCeWqoGzCpPFPlMLdLx2I=;
 b=XNMyFy24aSy9JG56X/flM9tyz5IyzprycETsNhA6YLmjrXf+yWSiXCHn7lXykKFEwSbrUnC74Krc8IHLsOoAar9IFiGFzoJDdkbWsqdfPRiRvPMiGmjIOE6qyxdY29LvVy1RBUdiVTPEgGkEN+KLxc5fZQkK6BFVQK/KRJ6fPgZlMVwNSEnoao5MMix9kCTSlpw7mDF7t7Ip1abG9x6QH9gSySrDt3/ANTRuZU8OgHPoSAIGblanrZlAw5wjKyGmK6NWoRNbzy8Ym3uUHvs9Djw5eFi5oEIwAWXKuMujd+6/CgsJdDttpuyvkjg0Pfh9BGz9EciTCu+kNHei7Qr3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA43njR0wTImGwqtH9boZFTCeWqoGzCpPFPlMLdLx2I=;
 b=HMh5qzCrtBbDcNtdNfF+LimbPZtqK0ZEPHjYhG2H4QWQYPA4UPTTn3DBdRkN6QW0Tar6fxtpfnSYMD0NjxxJiBQi/wXlEHuwD04Ypih3WhRVAN+eGy7XwOvRaC/i8C0mkOwY+x/N39Nlc3FbI+kDGosTqVZTeh1bkjKjZB/bsTWKPPfgCmF8+VH1DK3Blz8TWQd64slZLUx7XvwQWuNEG4rRyuQuwq7JukYAgcNCFxEF097W4UnyHJTzRFcK3DKCtFCl+G+XfG3XQJc3Wva4/rRm5EC/Eestp4p05yU88td66eAjA4zNNorUrMpHpYgOYbcEPjduzbGipAQ6VjJSKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 25 Mar
 2026 21:27:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:11 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Michal Kalderon <mkalderon@marvell.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Yossi Leybovich <sleybo@amazon.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Long Li <longli@microsoft.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 01/16] RDMA: Consolidate patterns with offsetofend() to ib_copy_validate_udata_in()
Date: Wed, 25 Mar 2026 18:26:47 -0300
Message-ID: <1-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b8d533-ca4f-4768-b35c-08de8ab54491
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PJzWsn/T8tG3ir24z8tMNsNE+oWJNg00ECo0z3WU4HUQ+SVHIXPVcr7n+VbIN9zkPHtRNLu+/oniocQjJgiK3y1GoWr2MnYVBoMoi6nsuW3a6VKsHAXif5uHgqFVSOqoVNJvV3ws2stj22KCADmo1zDetDmSAcgVbMgKulU4rFWe6CehrPFCg3AxnfVhkDaaaE545zLAmbm725zkNzpiw+pSMwT5H+2kxoW416JLCC7jFU+4N4WynCRK0aqaufbjJdEcZ9SimYXrdocYeqRjeNG9RgzEVDpV/7lT82n5L1MRnYX4cKAYHHMT4J0FtnU87AdokWwBefhXImWpmlaRMcsa7A9436zDSn9+0R587P3TiA98GqGqxWZGmFf9OUdSKW1PdP4rCIX33NHJLtFxWdLjc98jJ+y/rPUQxpqoa50EIrgl6dNFG0zFZ8nF4cIC6d2+7qICqI3sPhAPnUfJQdjAswdhLmG//2hOxfcPdqgmGV+x2dV/MhrR8qcEbLPfHTJB3esTDuVgDrie7Dx96fPRvsVQfipiQalWCAFjHTLWiRMtQZBeguikzAL4uI0ueRrtDmFJwCUURR+mOiO7xnvVXluANFbnLNfn0mGHdlg1quoYfjDzgkZkwB5RV/X43jKHcAXW+OwLJPZJtEcXWA+xOet5hwFYryz6IfoTD+m30OWwh+1hgM/1ZxbmGZD5+9OwIn56Yvo42eA5tC7I1nzzvVC6oqQOk1dfKwU7z3QAe0Z+zPSvk/9B6/rRAoh2DaWDYj4zDy3pD6EkhIVG5Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MWIo9zvI8lWIdGt0uogvdLFr4sHl8NmcsOcjBxbVs3uUXpGwGVuVXjywqani?=
 =?us-ascii?Q?HHDCql2zC02J94NYqsR+PYtuyv6rV+3Iv27Qem8AC94XE2aQEAZ4SEeRYxzg?=
 =?us-ascii?Q?OUi3WG43wPoDyInZ7O5uI00Gbp/qOzudFUAiSmHN7/+Zb6tL8fwGT70C0vd+?=
 =?us-ascii?Q?FFEHbyHhwLQn0amS74brFJOnbfOLw4s88PnBSY6G8I2nBiLph9evYbyY3wxC?=
 =?us-ascii?Q?qOu7X4mhrpuWLP7c2CdMILeZ/gYJKDIDBT9UONtIVDDScqDumFtn2ab1TeZM?=
 =?us-ascii?Q?s4TBmAa+vVTyINi+9Rpe+96YeuZJrtLb10dut+tirMqi2oz5VsbPVwuMleav?=
 =?us-ascii?Q?Ivw6TyMYxQaKJYijAXM49/BZpbDZnXab9i2/nhudOmRoWZv/cl7jjVINfJH0?=
 =?us-ascii?Q?C6v5Gcicz7+ybB4HdoS++mp2mXjzqXkXmi9t8S6naebA2nPDJWXBqVTgkvwa?=
 =?us-ascii?Q?wd2bog/CcvNXyX93gFyMiJgmU6dcDwzTsEMwtMLzPcnQBc9nanCnhTUTZlUo?=
 =?us-ascii?Q?Qnzd26l0g30TE+MsuPsCv8Mq9YXqNlVDITUsHbz48FVIfqh07jzluUuqGxWD?=
 =?us-ascii?Q?hyDyza55SItdrNGYQUuGKyuCdkISbtsFzaxSrc0vOsUHjHYDwb26I4qCC7C2?=
 =?us-ascii?Q?qZ+HK73jNigJzEZsprAQL7Zti3LZxoj1ESNBoKmLk9ggK/GyRgkn0icSQ5wv?=
 =?us-ascii?Q?bRnHEQ3BKJlACt0SbXbctsei1lX/DC/mX+TUXI0hdo8k1U+63hG2wcsQ23ZP?=
 =?us-ascii?Q?65kiOI0yDsQgphjleM6erT3iN7msjr7FGbGbd4j4NQZ3PfBp9Ept9rhhMxCl?=
 =?us-ascii?Q?DjA9uURDMcUIIGEsGuvV9JL+bPIort5peL2m5AFE3BaRrOPW/uTcvYPXibQD?=
 =?us-ascii?Q?aep8+4qwhpzm4rdr0ehukio9JZZkYn+H3AQ0LuV6EPrrFk5SuKQI5Uo7uifG?=
 =?us-ascii?Q?yb6CrJV4feFYa4skC6CWKeOBtsQf0kjYJ9kg68F7R6/9mOlncweXH8l0e7by?=
 =?us-ascii?Q?o0krIJio3T3w878EuQq+Xqza8j0Q9MWTk1GkE5DPPfSq2enkxMmk6kI5vTdT?=
 =?us-ascii?Q?SQ03SBgtiDmFKSENT9TTZD5DyB3XzfpGtut6nTkqsUq5ARZUenzbBdK1O0Kd?=
 =?us-ascii?Q?4g+SMpahbe7IFZ0wYz5fQxpz937mXWoR6iPaxdufo1YHZ9FPdNC4lXvwVF3y?=
 =?us-ascii?Q?zKkLruBoxZnMkc30Zls1EcSeBph4e0oZ3vXjtSjoD9QsayZEKnXjsaI8GoDI?=
 =?us-ascii?Q?ac3iRjq1ZLRnnrKSKU34SgnR0HE24k38R57ACNelczBqwLlCNCqoS6/jU/Ee?=
 =?us-ascii?Q?9sYDmN20UF4wqkR3/I4zr6sSJXbugU+WhLIvvtzgrrIB31bnY/QmR6evN/Pr?=
 =?us-ascii?Q?kxFzxtnAn9T55q03IShKjMxsFIaYaCknKr6OPGhjZ4p3ysdnvOt0i3Df3ihl?=
 =?us-ascii?Q?JKvnxp4OjQZIogGXUpETESMNlpDrHBT/lh90qHVrQqsYDeSYX3e88X2TVoQo?=
 =?us-ascii?Q?BUiOKVvolE4U97BXGUxjfg3VI2D5XELP1XhdkyQ0Gg9aM3eTPj2JfAxdkZ4r?=
 =?us-ascii?Q?fyeAaWY2Gr7W2s/8dO7/dHDfUmtaXXzkXehhigJMkF8OsQh5h1ZvOmSB0uyn?=
 =?us-ascii?Q?2f55buNwu3eZ6eOjuNgHrL3q34ieIE2UR2Ix4VAg57c72yheYCHLbUzUCE1Z?=
 =?us-ascii?Q?jkE680NB/OkLvFhiwZerGQ96fo7fvwoMa+/S19pcnHD3sCf7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b8d533-ca4f-4768-b35c-08de8ab54491
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:07.9600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knxGCHyi6YpmLXMbJ72MI9N9Im+DTC+QZ9tbbsdvRJLZLFWQ0O7OKvWYUWxu4MYJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9793-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[amd.com,broadcom.com,linux.dev,linux.alibaba.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,amazon.com,cisco.com,huawei.com,nvidia.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 0597632C804
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Go treewide and consolidate all existing patterns using:

* offsetofend() and variations
* ib_is_udata_cleared()
* ib_copy_from_udata()

into a direct call to the new ib_copy_validate_udata_in().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 47 +++---------------------
 drivers/infiniband/hw/irdma/verbs.c   | 10 +++---
 drivers/infiniband/hw/mlx4/qp.c       | 38 ++++----------------
 drivers/infiniband/hw/mlx5/qp.c       | 51 ++++++---------------------
 4 files changed, 26 insertions(+), 120 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index fc498663cd372f..8d9357e2d513bb 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -699,29 +699,9 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	if (err)
 		goto err_out;
 
-	if (offsetofend(typeof(cmd), driver_qp_type) > udata->inlen) {
-		ibdev_dbg(&dev->ibdev,
-			  "Incompatible ABI params, no input udata\n");
-		err = -EINVAL;
+	err = ib_copy_validate_udata_in(udata, cmd, driver_qp_type);
+	if (err)
 		goto err_out;
-	}
-
-	if (udata->inlen > sizeof(cmd) &&
-	    !ib_is_udata_cleared(udata, sizeof(cmd),
-				 udata->inlen - sizeof(cmd))) {
-		ibdev_dbg(&dev->ibdev,
-			  "Incompatible ABI params, unknown fields in udata\n");
-		err = -EINVAL;
-		goto err_out;
-	}
-
-	err = ib_copy_from_udata(&cmd, udata,
-				 min(sizeof(cmd), udata->inlen));
-	if (err) {
-		ibdev_dbg(&dev->ibdev,
-			  "Cannot copy udata for create_qp\n");
-		goto err_out;
-	}
 
 	if (cmd.comp_mask || !is_reserved_cleared(cmd.reserved_98)) {
 		ibdev_dbg(&dev->ibdev,
@@ -1160,28 +1140,9 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		goto err_out;
 	}
 
-	if (offsetofend(typeof(cmd), num_sub_cqs) > udata->inlen) {
-		ibdev_dbg(ibdev,
-			  "Incompatible ABI params, no input udata\n");
-		err = -EINVAL;
+	err = ib_copy_validate_udata_in(udata, cmd, num_sub_cqs);
+	if (err)
 		goto err_out;
-	}
-
-	if (udata->inlen > sizeof(cmd) &&
-	    !ib_is_udata_cleared(udata, sizeof(cmd),
-				 udata->inlen - sizeof(cmd))) {
-		ibdev_dbg(ibdev,
-			  "Incompatible ABI params, unknown fields in udata\n");
-		err = -EINVAL;
-		goto err_out;
-	}
-
-	err = ib_copy_from_udata(&cmd, udata,
-				 min(sizeof(cmd), udata->inlen));
-	if (err) {
-		ibdev_dbg(ibdev, "Cannot copy udata for create_cq\n");
-		goto err_out;
-	}
 
 	if (cmd.comp_mask || !is_reserved_cleared(cmd.reserved_58)) {
 		ibdev_dbg(ibdev,
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 7251cd7a21471e..b2978632241900 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -284,7 +284,6 @@ static void irdma_alloc_push_page(struct irdma_qp *iwqp)
 static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 				struct ib_udata *udata)
 {
-#define IRDMA_ALLOC_UCTX_MIN_REQ_LEN offsetofend(struct irdma_alloc_ucontext_req, rsvd8)
 #define IRDMA_ALLOC_UCTX_MIN_RESP_LEN offsetofend(struct irdma_alloc_ucontext_resp, rsvd)
 	struct ib_device *ibdev = uctx->device;
 	struct irdma_device *iwdev = to_iwdev(ibdev);
@@ -292,13 +291,14 @@ static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 	struct irdma_alloc_ucontext_resp uresp = {};
 	struct irdma_ucontext *ucontext = to_ucontext(uctx);
 	struct irdma_uk_attrs *uk_attrs = &iwdev->rf->sc_dev.hw_attrs.uk_attrs;
+	int ret;
 
-	if (udata->inlen < IRDMA_ALLOC_UCTX_MIN_REQ_LEN ||
-	    udata->outlen < IRDMA_ALLOC_UCTX_MIN_RESP_LEN)
+	if (udata->outlen < IRDMA_ALLOC_UCTX_MIN_RESP_LEN)
 		return -EINVAL;
 
-	if (ib_copy_from_udata(&req, udata, min(sizeof(req), udata->inlen)))
-		return -EINVAL;
+	ret = ib_copy_validate_udata_in(udata, req, rsvd8);
+	if (ret)
+		return ret;
 
 	if (req.userspace_ver < 4 || req.userspace_ver > IRDMA_ABI_VER)
 		goto ver_error;
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 1cb890d3d93cea..b87a4b7949a3a0 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -710,7 +710,6 @@ static int _mlx4_ib_create_qp_rss(struct ib_pd *pd, struct mlx4_ib_qp *qp,
 				  struct ib_udata *udata)
 {
 	struct mlx4_ib_create_qp_rss ucmd = {};
-	size_t required_cmd_sz;
 	int err;
 
 	if (!udata) {
@@ -721,16 +720,10 @@ static int _mlx4_ib_create_qp_rss(struct ib_pd *pd, struct mlx4_ib_qp *qp,
 	if (udata->outlen)
 		return -EOPNOTSUPP;
 
-	required_cmd_sz = offsetof(typeof(ucmd), reserved1) +
-					sizeof(ucmd.reserved1);
-	if (udata->inlen < required_cmd_sz) {
-		pr_debug("invalid inlen\n");
-		return -EINVAL;
-	}
-
-	if (ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen))) {
+	err = ib_copy_validate_udata_in(udata, ucmd, reserved1);
+	if (err) {
 		pr_debug("copy failed\n");
-		return -EFAULT;
+		return err;
 	}
 
 	if (memchr_inv(ucmd.reserved, 0, sizeof(ucmd.reserved)))
@@ -739,13 +732,6 @@ static int _mlx4_ib_create_qp_rss(struct ib_pd *pd, struct mlx4_ib_qp *qp,
 	if (ucmd.comp_mask || ucmd.reserved1)
 		return -EOPNOTSUPP;
 
-	if (udata->inlen > sizeof(ucmd) &&
-	    !ib_is_udata_cleared(udata, sizeof(ucmd),
-				 udata->inlen - sizeof(ucmd))) {
-		pr_debug("inlen is not supported\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (init_attr->qp_type != IB_QPT_RAW_PACKET) {
 		pr_debug("RSS QP with unsupported QP type %d\n",
 			 init_attr->qp_type);
@@ -4269,22 +4255,12 @@ int mlx4_ib_modify_wq(struct ib_wq *ibwq, struct ib_wq_attr *wq_attr,
 {
 	struct mlx4_ib_qp *qp = to_mqp((struct ib_qp *)ibwq);
 	struct mlx4_ib_modify_wq ucmd = {};
-	size_t required_cmd_sz;
 	enum ib_wq_state cur_state, new_state;
-	int err = 0;
+	int err;
 
-	required_cmd_sz = offsetof(typeof(ucmd), reserved) +
-				   sizeof(ucmd.reserved);
-	if (udata->inlen < required_cmd_sz)
-		return -EINVAL;
-
-	if (udata->inlen > sizeof(ucmd) &&
-	    !ib_is_udata_cleared(udata, sizeof(ucmd),
-				 udata->inlen - sizeof(ucmd)))
-		return -EOPNOTSUPP;
-
-	if (ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen)))
-		return -EFAULT;
+	err = ib_copy_validate_udata_in(udata, ucmd, reserved);
+	if (err)
+		return err;
 
 	if (ucmd.comp_mask || ucmd.reserved)
 		return -EOPNOTSUPP;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 59f9ddb35d4620..d4d5e0d457a0b5 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4707,17 +4707,9 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		return -ENOSYS;
 
 	if (udata && udata->inlen) {
-		if (udata->inlen < offsetofend(typeof(ucmd), ece_options))
-			return -EINVAL;
-
-		if (udata->inlen > sizeof(ucmd) &&
-		    !ib_is_udata_cleared(udata, sizeof(ucmd),
-					 udata->inlen - sizeof(ucmd)))
-			return -EOPNOTSUPP;
-
-		if (ib_copy_from_udata(&ucmd, udata,
-				       min(udata->inlen, sizeof(ucmd))))
-			return -EFAULT;
+		err = ib_copy_validate_udata_in(udata, ucmd, ece_options);
+		if (err)
+			return err;
 
 		if (ucmd.comp_mask & ~MLX5_IB_MODIFY_QP_OOO_DP ||
 		    memchr_inv(&ucmd.burst_info.reserved, 0,
@@ -5389,25 +5381,11 @@ static int prepare_user_rq(struct ib_pd *pd,
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_create_wq ucmd = {};
 	int err;
-	size_t required_cmd_sz;
-
-	required_cmd_sz = offsetofend(struct mlx5_ib_create_wq,
-				      single_stride_log_num_of_bytes);
-	if (udata->inlen < required_cmd_sz) {
-		mlx5_ib_dbg(dev, "invalid inlen\n");
-		return -EINVAL;
-	}
-
-	if (udata->inlen > sizeof(ucmd) &&
-	    !ib_is_udata_cleared(udata, sizeof(ucmd),
-				 udata->inlen - sizeof(ucmd))) {
-		mlx5_ib_dbg(dev, "inlen is not supported\n");
-		return -EOPNOTSUPP;
-	}
-
-	if (ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen))) {
+	err = ib_copy_validate_udata_in(udata, ucmd,
+					single_stride_log_num_of_bytes);
+	if (err) {
 		mlx5_ib_dbg(dev, "copy failed\n");
-		return -EFAULT;
+		return err;
 	}
 
 	if (ucmd.comp_mask & (~MLX5_IB_CREATE_WQ_STRIDING_RQ)) {
@@ -5626,7 +5604,6 @@ int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 	struct mlx5_ib_dev *dev = to_mdev(wq->device);
 	struct mlx5_ib_rwq *rwq = to_mrwq(wq);
 	struct mlx5_ib_modify_wq ucmd = {};
-	size_t required_cmd_sz;
 	int curr_wq_state;
 	int wq_state;
 	int inlen;
@@ -5634,17 +5611,9 @@ int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 	void *rqc;
 	void *in;
 
-	required_cmd_sz = offsetofend(struct mlx5_ib_modify_wq, reserved);
-	if (udata->inlen < required_cmd_sz)
-		return -EINVAL;
-
-	if (udata->inlen > sizeof(ucmd) &&
-	    !ib_is_udata_cleared(udata, sizeof(ucmd),
-				 udata->inlen - sizeof(ucmd)))
-		return -EOPNOTSUPP;
-
-	if (ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen)))
-		return -EFAULT;
+	err = ib_copy_validate_udata_in(udata, ucmd, reserved);
+	if (err)
+		return err;
 
 	if (ucmd.comp_mask || ucmd.reserved)
 		return -EOPNOTSUPP;
-- 
2.43.0


