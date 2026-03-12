Return-Path: <linux-hyperv+bounces-9339-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JDzEQsIsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9339-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:47 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B1626BA4C
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B4D531606AF
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AAB33C502;
	Thu, 12 Mar 2026 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E5kqpuZl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010FA338939;
	Thu, 12 Mar 2026 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275084; cv=fail; b=VU5XDmMgA3LU05BJ6C7OO1wWwxJWIW+COpSO5y6twCTj5psUBhuyNAgyoSylzhaXpb7ee838xOnwfJ36cKDTrj6adFTDTD7zE9In7zJKitt5GvVIkERdfTxz+Ck33hCMCIfEhMxIpm75QC63V5Q92V45O5XViMf4mckjVzW/Oi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275084; c=relaxed/simple;
	bh=IVRc9h+FICIkNFjPRnKxACcdH6Ix/NdUvE8m6MpWm4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H3g9T/iLBOut8/tzGne8oVB4wOsGUa8vCjwkVLiauOyZZzC8jRZjGBrAa99q3p775VqMhIaUc75GscPI3QfVVzktXfNRvWa8K2g3JK3/7FExyrCdov7bqp0I45KyfYl4/dOYfx5q8yny7O1I5xsAjVGWMTvjKZA64viGimkmPSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E5kqpuZl; arc=fail smtp.client-ip=52.101.48.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tagRJ2VVN38nMMrlYnddV9H29FVFmd3yktmworTpp8tubSWo4uKrzYvWs8wH+At3YBcBR1KVk6HNyP6i9AmeMiLD6Ditxl613cQVGkpvquaEMfgLlwtrgBcSPg9kNsb1DMGKf0qN2n0jlaqTpCjzNs0fjmm8aC5HIBfvMC9TP01vusigNt+BnqKVEXmC3OLytLeMkCT5JUpmWOu+vn5UUdLArH3OC+HfzDjDXGqyVvgBQ6+cqiL7CKRmu9AAqKJLYb0LvYRdAlQFg1T2pfEnUFdQsHykR/iUH7eMtRhMxLN14/Ymlf+iiQrLK6vYpJZQDoBVEAms4xzhJEiYCR+00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zs6CvqdoIWSd94L7ikxnrKC+zXNWpmRWSYadb0OwrTk=;
 b=RnK3mjNxong8VqZLg7IyJG5wfjg0MU24bW6bqXVBJx2zr5Kn2LY9Gu2XO5PCheAeeNTTBOgGZS+vGiONrkp6IwGFUeOgG84CFknu3QSV1H3lYvniEeLHg8a5VLusg0R3mPOEhNs68nFFewiZf/m0PBSRDHNJLlba8itxihR1GVT1px7SiU414WCzZEZgvOIPEqoAdYGv2/G0NVAOz8vTThTqfoZ8d1C0RhaoZCWTHq/JtK0It9jAimPegywqlbK7hwKgXgtg8XCoXgNhui+1HepD2eHUegu+wSnuxh9UkAp/3Zqxw3rqwXE/OJ9wEeTp56unvkwzZE5e+HNF7rWTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zs6CvqdoIWSd94L7ikxnrKC+zXNWpmRWSYadb0OwrTk=;
 b=E5kqpuZlj9rkmUzFgg9DFpz8Msrt8mrlsAaLY5hseCRBxqZx1QNeGdKWOiAJeUEmMvslELKLnOfP8kNnjJ8xInK74q3mGJvoZ+SAlAPzGnmf52intYeMvqrimmqqVXj8/X387nYGyjlGj1HXy/TFebr6IBK2rRcNpdnCsFPcaXpl9hbm64WKarpqPmIa2X/LwnfpVwxW7wjmQ4O9gKUSI3IjFlVSdQpAmUSCLumqtepiuTbOlscwrX31fPa0yT/NUHAhRuVRFiVIi2vC1lJMEgkcnZtUmNiDf/Qth7qNtpiJCPPsSn8VZdeSIaYxGocgy6PD0UtrIxAtQkQXThLskw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 00:24:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 00:24:32 +0000
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
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 16/16] RDMA/hns: Remove the duplicate calls to ib_copy_validate_udata_in()
Date: Wed, 11 Mar 2026 21:24:23 -0300
Message-ID: <16-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:52f::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 76bba51d-83aa-4588-2726-08de7fcdb81c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bgR67cj2M3qTWjZ9p8vbvBwuj1QvISyoxU56v2N5PkLv2FCHUTrKgKbmhcoskPOms4KvDeC0CO19oa4A4jlKb6Tdcr8SxHJrR5ADKaVWE2Y9YflHG2BoJXeDZwj68J6Emka53vYZVw9wDwfrOw6C0GGGOVu5JWVlWiW8G5XEm/EMK1uBE6Qs1qEmdeXgp6YfYm5OTOhnudNK8HEJfFLlCneA6v0iDT0PoyzjM1Hfb4jyaGfj6eboAMDzs15wqkxl8F6Qo6owym5VZ3dkVEd00UBzHbPdIoWbSWPdMKdXWfvvZCosU2dutbzQ6aEOODSr2PM6DxBTZMSTpuoWHT97eOhCyG8a47erDTAw5ZLQp6XMB8qX15CrcHwHSbM7nGFnoXbw09mA3Punp7a0kUP43Ni1bTpZWO9CvE/urQKAnAcTOVypfKs425vGrOeVPZ4ZuoaD3z9AZz27fWrqweyHS34SmaCu8C1M9NOGCelb97Gbog2z4shRF9cxH5mp/0bo7tIidaENp+YjBno1KvFM2/VN2e600+5PqQEv1F5DV9tvvmk3dNFXsqv6N0QZwr6hUvNMEryItHG0AXdGhahQBZa4m8Vt3Er8WRN1vd+pVboeqWuGTMHfrrefn8uPPg3ZLUWf7/4SG+GwMTRbFts+ymFYcRMOO4N1gDvJLg8I9zg02tDVIDcpDZQ+DSLxT5MskoU/HQ9SIm475xyxuUAf7xUnKZntA5mNLRIxYjC1ZK+LAgFE4ykBop5bgUfekjl7EX3+lpEaZjWZcFS2/XNhCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FZ2BcIyZUQEn0PgbPedpwn+PSd3wixbD+hVnLqPKG4n6cEs+/HFTGoBU7KpH?=
 =?us-ascii?Q?Fui34hDYbsbNUu5NGrxhdxAfAGstibmrV6HnodT+yv9qiC3ihvQRyQODDorL?=
 =?us-ascii?Q?3bgamx07hBlvoOk/Gp3eVYXT+BrIqR8FVYerlvLAZXpvAjciSWQnlNZvzvWB?=
 =?us-ascii?Q?MZxxldNapxr6NqfDWTC51Or4Pn2czaJ1mEO5+atvIWW8cGvP6WEKjPawMg9X?=
 =?us-ascii?Q?lJdJXRcvyxBb/no3OkUTqqVe5zvHsDsG2o5l3hcojIDclpK8EYlsVx+URdPp?=
 =?us-ascii?Q?zAiymuR8HnfvnimYJBA3qCABZ+ZJhFsF+Uanax5bMd7eYM1hpyIF8eFDRJia?=
 =?us-ascii?Q?gqo+H1Jso66YTcwYwDBH8OhQNTDOZR/zmWx0UAaSzC+kw6izdUZaWXltugsQ?=
 =?us-ascii?Q?kUm+mp/cZC1ZmVk8UJ14z7tjKo4Cvpl1SbKB2yXZ9J20fdQPmQn9j/JbD4Y3?=
 =?us-ascii?Q?Acxm46sszLOZurI2D+SzHovqaK2dRQtdLeUWcpNDHtbc+SpXLQWf5SDsWfHE?=
 =?us-ascii?Q?+tjR3RoDd6vL0hZvcHCBsNMSw4uXSFnm4VhH5lm0wCn+dM3bzZo0LR/QuttH?=
 =?us-ascii?Q?Psihsb9Dw5LAyLTKWT4CS8Epa1IjCAfu1cGQ8cAIKcaia7Aemb+dOSNovMOH?=
 =?us-ascii?Q?UMx1+J2OwsL7TV2qGy3xwZx89vtgzU+t1b9cVtlvP6Fd3SZIupmKOy+RuANb?=
 =?us-ascii?Q?ta4je5icaddPeU8ReByNwdb2yAs5bwhVVycrT69g0kXvTcadUROra4AlwnrY?=
 =?us-ascii?Q?tPzUYJi3I7AZL1BGwwJv2GhYyyw2MwgveDHTibWVq0OOhYUZ9BUnpPV6XZVM?=
 =?us-ascii?Q?1hsVyI+BQxxTbkVL6rX9jlLnoDndP1QxX+V+buDgMisxFeoe3GQE/VW29zb2?=
 =?us-ascii?Q?xjBJKCAagc1HTBIiPuzFarobHHUl+Ig7kfXVk9SVOJlxqIrklPIb8No+FwBr?=
 =?us-ascii?Q?YnAXgIgQJQrxiFFkD6pwq2zUCX9jdQktX5vp8BZGw831S5qwBZ25X8SPjO2n?=
 =?us-ascii?Q?tG9FxT4c8Xa5gv/wCYQCm3NjEYXYVifii0ZhLJnr1t3xlyy6tMvbxOuseGan?=
 =?us-ascii?Q?6W3rjbAJx/WWiPBxgZgyodnqvuA9YmmyIRkeuS02QYCES9yslsmfR3V012bw?=
 =?us-ascii?Q?wyoRZAHcx3BaTcYKh/y+zzG2sGi3rA4eEjK15y39mxPpu7vjlvCiaTA/umBZ?=
 =?us-ascii?Q?6X4Bg+Zj8TRMuzNg+3LOGT5mExqRki0LDuSOUL8I2gQIss7nMWxVNz1oMQsZ?=
 =?us-ascii?Q?ezS1hykI6jo2Bb9FJrx2uMvAgSc0YaXQhtRAX04on/a/P0xQgHkfowucY5J0?=
 =?us-ascii?Q?6EzWA9vLg6BQ9oMiyXausbHbbWhsOIdSMkoyOVkZA5Q30Z7CSELgJlnzxB8Z?=
 =?us-ascii?Q?C2zQE0rMhtvDtM552Ip0U4K3jdkvv9YVSqO/GoPDTHgTCNmOglycZAQy8W0P?=
 =?us-ascii?Q?bGomL4ARCLyOl2T5fpr4p3//RjIVRZLDskGUzYBxorLlncnuHO65nAA6KBoJ?=
 =?us-ascii?Q?p6iiNc2Wdhx22+15kG2fGxXtN5HbWl6Ax7yPZrGsqucqylGOjlrqGI+YAkQM?=
 =?us-ascii?Q?WwKYtUuIl3DvfByY9aEqZfrT6WSDslC20Pqbxf6dWxSivK/5I/XLcsg4wrzj?=
 =?us-ascii?Q?EdcGyDOtVYagynjYlGxUtNL9bqQoVkarC94Xr90J/02iqThngcJaCi+Q1DVS?=
 =?us-ascii?Q?rWcbwaI0IkRWkx9PRQbiTSXPOT+DtNOrGDnJnFXBRn5oUkkDJv8SzNRaCIK1?=
 =?us-ascii?Q?KdaeCiArOg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bba51d-83aa-4588-2726-08de7fcdb81c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:26.9171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/DaX9iUf0LqTxq9vYBNK2/F8LfNuV6wdTdmpeNSgi1jE5qtI8tQS/GU1j7aIDte
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9339-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: A5B1626BA4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A udata should be read only once per ioctl, not multiple times.
Multiple reads make it unclear what the content is since userspace can
change it between the reads.

Lift the ib_copy_validate_udata_in() out of
alloc_srq_buf()/alloc_srq_db() and into hns_roce_create_srq().

Found by AI.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_srq.c | 35 +++++++++++-------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 601f8cdfce96a3..cb848e8e6bbd76 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -340,22 +340,16 @@ static int set_srq_param(struct hns_roce_srq *srq,
 }
 
 static int alloc_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
-			 struct ib_udata *udata)
+			 struct ib_udata *udata,
+			 struct hns_roce_ib_create_srq *ucmd)
 {
-	struct hns_roce_ib_create_srq ucmd = {};
 	int ret;
 
-	if (udata) {
-		ret = ib_copy_validate_udata_in(udata, ucmd, que_addr);
-		if (ret)
-			return ret;
-	}
-
-	ret = alloc_srq_idx(hr_dev, srq, udata, ucmd.que_addr);
+	ret = alloc_srq_idx(hr_dev, srq, udata, ucmd->que_addr);
 	if (ret)
 		return ret;
 
-	ret = alloc_srq_wqe_buf(hr_dev, srq, udata, ucmd.buf_addr);
+	ret = alloc_srq_wqe_buf(hr_dev, srq, udata, ucmd->buf_addr);
 	if (ret)
 		goto err_idx;
 
@@ -404,22 +398,18 @@ static void free_srq_db(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 
 static int alloc_srq_db(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 			struct ib_udata *udata,
+			struct hns_roce_ib_create_srq *ucmd,
 			struct hns_roce_ib_create_srq_resp *resp)
 {
-	struct hns_roce_ib_create_srq ucmd;
 	struct hns_roce_ucontext *uctx;
 	int ret;
 
 	if (udata) {
-		ret = ib_copy_validate_udata_in(udata, ucmd, que_addr);
-		if (ret)
-			return ret;
-
 		if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ_RECORD_DB) &&
-		    (ucmd.req_cap_flags & HNS_ROCE_SRQ_CAP_RECORD_DB)) {
+		    (ucmd->req_cap_flags & HNS_ROCE_SRQ_CAP_RECORD_DB)) {
 			uctx = rdma_udata_to_drv_context(udata,
 					struct hns_roce_ucontext, ibucontext);
-			ret = hns_roce_db_map_user(uctx, ucmd.db_addr,
+			ret = hns_roce_db_map_user(uctx, ucmd->db_addr,
 						   &srq->rdb);
 			if (ret)
 				return ret;
@@ -448,6 +438,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_srq->device);
 	struct hns_roce_ib_create_srq_resp resp = {};
 	struct hns_roce_srq *srq = to_hr_srq(ib_srq);
+	struct hns_roce_ib_create_srq ucmd = {};
 	int ret;
 
 	mutex_init(&srq->mutex);
@@ -457,11 +448,17 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	if (ret)
 		goto err_out;
 
-	ret = alloc_srq_buf(hr_dev, srq, udata);
+	if (udata) {
+		ret = ib_copy_validate_udata_in(udata, ucmd, que_addr);
+		if (ret)
+			goto err_out;
+	}
+
+	ret = alloc_srq_buf(hr_dev, srq, udata, &ucmd);
 	if (ret)
 		goto err_out;
 
-	ret = alloc_srq_db(hr_dev, srq, udata, &resp);
+	ret = alloc_srq_db(hr_dev, srq, udata, &ucmd, &resp);
 	if (ret)
 		goto err_srq_buf;
 
-- 
2.43.0


