Return-Path: <linux-hyperv+bounces-10007-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOYFC/ui02mMjwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10007-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDD23A333A
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D541A300E3FF
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 12:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96786335571;
	Mon,  6 Apr 2026 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bGgOKNOK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD133509E;
	Mon,  6 Apr 2026 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477496; cv=fail; b=P6FBUeQPM6FXWuEpqSdE7vDBLkQSqS2MtXGMEnn/iubzZu1ijL4BxNas8guRZRid0tiD8G8KKO+z42qRkZLscte1A4i0C6cvFvXcpk3XcvVzrCh6eQeis5exkSoxJwHIpm6T+vVKZAudcrVd8RAFFbKrCEX01F8wb3A10LI9fGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477496; c=relaxed/simple;
	bh=Wxx/Hacxx/mTqEyGamd8QF5UwwQbLtqQhG+aHiDHCgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RMzmNtR/zy5l5FCCNcOP5JmtsLbgDqcej2R+oZmupGNN1LSap3oRuPPYa2JKBQuzYM4M0NB6Rqatk9hX0Zy1E9O/CxSuKh6jUOvbO//3/aN1esd0uvaAZnhWI6X1o/tfPZBcHgh2bY16i06CvYx7FgUYtzvDvMCzeqcb4GjgHgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bGgOKNOK; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaieZJ4kcDu/IzRj9o+lWn/O2G/jJt0FPlcJTlnJpRXNIMjnQIdPWEHPDsOm1R+xPhCAQiQHfTDKxJyx0f1BXXEKo+vR5RExymnkCl/BIZPtONa0RG14baz91A2k67wF10/a+rywdH9wa547m1s9tXqqkic2RhT5utOL+GV7bYjqQBjhrsLfIY9+2nnOatKwT6Lw1twnPZoW319n3GpGpUEw0+XiIp67Th1wrDxBIGNdBtxEKp6Bf1GTWZoBCg610BZ7mkW5GIXh/Q+j+J9VlH0pK1Y6qNaDyf2THcGxAyidftQ+/ntFDr9/6MGwn6RnkypNoiCVH1coBhit7wMvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXvdJUEvzoSeJDBIFfwBpuhRoQhUvbdHUaBrjQ7zBkA=;
 b=WfVePjpz0YHYPno9QzDuJVv2x3Bx3qeQjuHug+WAyWYeBuOa+OWmaI14bLv/8CPZDZGBvy2+BIopQHx8qN04xQIL/tzychOGqw21/cp7k9NqLIXGgg3JMHw4W61Nh6yZG/VTAWUAk85UGrwUxWKKyd1clWBK64x3Fb4rYPg/w5/kdonVYeyxczNsV5wuwX8ACr4cJjKrGqH1WI/VwsGk0WLv+LXkstdSQtIkxwc6kYpMuoDN7WpWvISMk86xZEgmxGE7hNrimnXm2l6DgAzbPgocssD2e8h46g0U+coDcCnUODwYr+ZNlW6+Bw+xXtxeLFpT8NrzBvh0jLfpqLfL3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXvdJUEvzoSeJDBIFfwBpuhRoQhUvbdHUaBrjQ7zBkA=;
 b=bGgOKNOKWCp9BfUg+Zq2ENeHOD6IqvB37LXZcCGjnYgfc0UpKsotMu1YNP81rHENP7padKkxNHClJQq2sduIPd2NlF5I6o+clc96A4R5tOFbHpUISqSNlQCsQfD1G6tw5rKEIpcM3Z/4UVCeIj0/2RczEzwqXfJJkfLu/rNnbEidsjFn4cz1d/Cv6MSLk8/qenNvw4a0e6u1kLZ90ozXCU1/xuHvIqwVS0OYQgSx/TSSxbcbBvzGP2eGqKKiYZmfEiGjEvEsVgi4CWOb6kVg6KsEtptaTOT9njzcLpjmQg95sNFckcUONn/N1gHw3p3Ra3p860MywB2f/6gSqrzyEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 12:11:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 12:11:28 +0000
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
Cc: patches@lists.linux.dev
Subject: [PATCH 09/10] RDMA: Add missed = {} initialization to uresp structs
Date: Mon,  6 Apr 2026 09:11:23 -0300
Message-ID: <9-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0021.prod.exchangelabs.com (2603:10b6:208:71::34)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb27534-3b9b-487a-f452-08de93d5a0a3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	qYHnGBWEleMPNm/OZv5YnTXliVBqiSsBo5LsZiNcFuRthANwi1yJraKSnyKH1+cifiA9dSjsp2XY57OTKrsS1ZRZt6jATHUnNkgnWD27uqHFn7+dB/A9LGsFKcGquMO/2pi/SSIiwiIzHTJojQ5UoB1dXYOtZx+5MZcrpaZyJPZf3/0jJPgTkYe5c1Qd01CdxSjLy5WrW+HSsbkD4phYCG2HZVO7SWQCudg0NU+vKxC5SM5PSeskz9ux5spn+rFUpHOLJ6jLfhP//NZriRQ9g2+TM9qXS7YzkADMWMQQDxfP7DUZ4LOAKsr/aj1J4y71Fk1K/Vee5/PVoBUomXAcDOpPKK/xT82caXRfcKlJxSCYrD/86p/lQwGyhYFdB0kQcjVBFzvH3S38zylyZBaVGYOP/H/QAxaEhZzIGQHTHAYRu4YVfUVi5BChHxQR4U7WVMhBdtVsZSkqBSi7js6OgnjMEVWinzeocb1Shr9Wb1QC2bEq+bTDVI+4RE1RY08Ss8YPuNhSN8QR/fxy0XIpW0ROdHjFVWz2hHK4E4skXPKXkHFc4+FLSkWdCB7xv4chx1Jkzj09A9xlFnwUYiR4jH8XR4uF1lcbC0j/9c+KWpsLTd7HK43g8s1fjjrsPv74Id/GN07lJf+mGIPrGK83wNWGD4kEMbDQGAANhgYqkFwtwzNf4TbCgrdnGpkyjlVHZ2o2M7DkgNp0OWq31auqcHrV0JVrbv33lS6cmKiSYNF0NqIw1ExpdoP5QQynq7qW+30ageo5OcDfiMXLmpJmpg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KLG62xC8dOR8A+p34HvoLrzGFR83KfExx6IrSJfuX51bmLUw3vz2jKT87oHU?=
 =?us-ascii?Q?8tsbNKnM42YuOoj2L6oICjQ/nT/FK9SbN1lvAqzuj0k456A6fiLA3pfZHaBM?=
 =?us-ascii?Q?reW1yB8o2rdOK2oattz03fljfGjF5y+IszLEgirM0Hhk+GRXPMwHyaIP4cdE?=
 =?us-ascii?Q?TET97E+1pivyOy+AggXB125o7i/+jvso5G0AfwwHlMsxNu/32ECkprYQRldr?=
 =?us-ascii?Q?QEsd1Tg40XWJVERE87ZsNGIOGu6AcCLpHQB52rz+w72/FynqxGJj8jD9pwJC?=
 =?us-ascii?Q?TFtG7FZHVppznr42Y34J9Eec66gM0L3efA0NlzitxMgHfIfm0k2UKdKrYhKM?=
 =?us-ascii?Q?0i3oS1Zha8KYXXfvtHYAYOychoaQ1lx8msiLPmS5V6DwDBT67jZCGgZ5qTpa?=
 =?us-ascii?Q?jzt74wykKA5uLDO9Y/ugv6QAPQBUkx+fsuSh1F7pLAozW5BLUWH2kmrNZOpf?=
 =?us-ascii?Q?closF2QpxIjEWjq23qLCSGQSiFxf/IfkZmvfG/svC1uVgSJWcZHRp7tFkIxw?=
 =?us-ascii?Q?+r4VfL+g3llsgr3QFSqF1VLUfIYbYakS8Kd3SMghihOcot+5PJvWUbgouz8b?=
 =?us-ascii?Q?8ux5KU0HCsa1sLkB2YUUCy7AHZIjc/7lUqwbgpDESlcCc4dLfV5W6KsxdgbA?=
 =?us-ascii?Q?1ypWzhtHcVsYmHcUjB5zHMmCZN0cdiAWAIn7NsDrKS+uwOqDOb1+4U9+VJXL?=
 =?us-ascii?Q?nfDAzCJvaq1oiT9WFlhwe+Szw860oj8nh5KWOBmwLBEvhJQ7IXu0E4OC2Ieh?=
 =?us-ascii?Q?um5dFhVZmCrA5IXw7m4BbuqTTWhYjoovFQCKn2uPaoZL9pd302bHWF045KOz?=
 =?us-ascii?Q?81hDTFm1J34cEr2fIkX7M27LB/gwLDkCecQlh7extWm4Px7d2ZWH8FdUwAwp?=
 =?us-ascii?Q?D12oyMLpLA+O7i69qKEQpSzCN9tKBD9aCBKHzbzWzY/1/EdWmRO6ShTKgY6A?=
 =?us-ascii?Q?8TPItGzs7NdJ94Q2cNov5oJlRuvq57LgWy7GR7eq8lcz1+W3mbCt/9NnkuUQ?=
 =?us-ascii?Q?627jXLqR0/nVo+eshZYxmzydGcQQ2h1QID3xDm6zIQQ3iJamyihqTzbXYU5A?=
 =?us-ascii?Q?k94jcosL/V/djB6rhjDSP0KE53jGs5Ak4kv8Y5mK584gHN93ZzMvWdIIZA5F?=
 =?us-ascii?Q?CpeD0JpOhXwU+tcGAPWbhNjLSELn12JRWuxTdxQR+SOtOx29Yt2KZTOeoxJY?=
 =?us-ascii?Q?jjGN4A3wyYnMle0/ousNaknSRDOwfJl3ivCqaP6VaP/n4qJyJ2FZDwHiNTD/?=
 =?us-ascii?Q?jMjA+AvDzIvtk67dsDct7Xb45yqu/FEFeAmyiEK6vK/HAQ3oHLdsb2m7BPp5?=
 =?us-ascii?Q?xmSSL7Iyp3/1SnNAJKM+wQKM42mAPotVwly5kbUQsIYoVVwWhimfclVtvrA5?=
 =?us-ascii?Q?uGb+90LqLhASSNPiV59JYGlE0VKn/BOaIPpv7SW5StPmbOKK6Z4jeEga8Nyq?=
 =?us-ascii?Q?/qivSPOg1K3ToDALuC5RGOaOfihCPIy1Bwd6HcWgh35F3sLelmUHDRCRuhTo?=
 =?us-ascii?Q?AIxCzf9lL06i0gycOmHpQ+t66QxkxD3ZC9hXKNQECq4ONTiuD6pq66OvPJBe?=
 =?us-ascii?Q?axGExalxiv/YPBE+B/PSPT7gxtKTkuWEmgIy0E3TFK0Wj6uPM9TUBOLyNva5?=
 =?us-ascii?Q?xmwWHTQuTw/q8EWGxvdVapRIshuBrgYE8GiCbK2659dYsV70e98BFcwfloC2?=
 =?us-ascii?Q?AYCHw6hNP1GCD5FTKlI/ybI0uBgNcynyNt53bLnJ7Qs5+Cpl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb27534-3b9b-487a-f452-08de93d5a0a3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:11:26.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFv/01pUXQMmtQyTHxUmiAuB9cmcRBQ+Xet/CNMFJhqMjgASG1Tdb/zGBCbeIW9l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-10007-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DDDD23A333A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All of these are fully initialized so no bugs are being fixed. Add
the missing initializer as a precaution against future changes.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 2 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c | 2 +-
 drivers/infiniband/hw/mlx4/main.c         | 4 ++--
 drivers/infiniband/hw/mlx5/main.c         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 7ed294516b7edb..ccb362d6d2e669 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1884,7 +1884,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		}
 
 		if (udata) {
-			struct bnxt_re_qp_resp resp;
+			struct bnxt_re_qp_resp resp = {};
 
 			resp.qpid = qp->qplib_qp.id;
 			resp.rsvd = 0;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 92a65970ab6fa1..c8a35337ba51e8 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1977,7 +1977,7 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	if (!rdma_is_kernel_res(&ibcq->res)) {
 		struct erdma_ureq_create_cq ureq;
-		struct erdma_uresp_create_cq uresp;
+		struct erdma_uresp_create_cq uresp = {};
 
 		ret = ib_copy_validate_udata_in(udata, ureq, rsvd0);
 		if (ret)
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 25f9738bd77223..d50743f090bf21 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1090,8 +1090,8 @@ static int mlx4_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	struct ib_device *ibdev = uctx->device;
 	struct mlx4_ib_dev *dev = to_mdev(ibdev);
 	struct mlx4_ib_ucontext *context = to_mucontext(uctx);
-	struct mlx4_ib_alloc_ucontext_resp_v3 resp_v3;
-	struct mlx4_ib_alloc_ucontext_resp resp;
+	struct mlx4_ib_alloc_ucontext_resp_v3 resp_v3 = {};
+	struct mlx4_ib_alloc_ucontext_resp resp = {};
 	int err;
 
 	if (!dev->ib_active)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 84dddaded6fdef..a6a696864f9e0a 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2772,7 +2772,7 @@ static int mlx5_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct mlx5_ib_pd *pd = to_mpd(ibpd);
 	struct ib_device *ibdev = ibpd->device;
-	struct mlx5_ib_alloc_pd_resp resp;
+	struct mlx5_ib_alloc_pd_resp resp = {};
 	int err;
 	u32 out[MLX5_ST_SZ_DW(alloc_pd_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(alloc_pd_in)] = {};
-- 
2.43.0


