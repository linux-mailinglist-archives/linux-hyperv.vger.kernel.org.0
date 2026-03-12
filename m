Return-Path: <linux-hyperv+bounces-9338-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJvZNwgIsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9338-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 765B526BA45
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24C2315D241
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA78336897;
	Thu, 12 Mar 2026 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rmJdIEnP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663D632FA3D;
	Thu, 12 Mar 2026 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275084; cv=fail; b=SYO/HeKmSsIBrbkD8Hcsw+RZ+N3TlVHLN0gpBpQd0lNXgK+jnKVM2164vJ4hYrzTziUpJHXHfIf7TmFqD5e8CHyGuooVfJDxnCCz6m5ikLAEmQS6OOeZs9rkJpdNUfYXHS1V22YkMd4KHmomxKaMBFUDIShIiWv9zS77UG+Jr/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275084; c=relaxed/simple;
	bh=QA+odo3Us7oPWpjaJZU1boH/N4I+vnC+yOPD3Tm3gLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pxx6WTgLUfQ09tglMpqqOwRnh3x6Ww0BDBVF0/ELeD0x8ZNxFMBNV1UHjGPxngqRP+rkJROQnEKdHL0Yz840eWsgpGFDQBMxKakkXPQJrUJwQsKJUAIUBgX2V0LTuuEJe4ElzA7GSeSVrBBboDBQxH8AwwVdCIIYAvo2LFIdj7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rmJdIEnP; arc=fail smtp.client-ip=52.101.61.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugNrFyVDstrqR0OaVDUT2apms1z886WpewFeZ5Lwos3U3o8ueFcmbzbEbB6IgPehW6WTZdBE76dP+k6nJOqZu631yyha5B2Oq0CiXyzOIHNFGxBl/0Rv9IUrjCIDsIrcuKjraBoKPz04eVQRS6AdYDAkAOsvKeyuEdsD5FTxqQqkiQEfjbAtXcFV1sFz8g384Mv3pLR7F7bubz3KOLwrAohzD42yTOeX/kXwylD4ccxSxHhEs4R5Ec06jfkkKVnHxwI0F684B0+eUxvwo85y0O2rt85ksyuRDi+T5rdpbvGC2a7m61HZC4EpsYlIbpXaz8MY9KW2+5TUQ+4A0839pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DjQdBO21HWe9R+m0Wsk5Usf2DtfKANgArh0rmZ3CAg=;
 b=YniK3nE2CyjkDgYCmkbVfeSvlfpQbDVe9BdWnTqb6CzTQ3UpdN6IRLbqLjpxEkZvjakVVYwFd8uEGp3zrQ5YX2PcWeJ8RmW4GhikzjEBaNS5oOVQkZY1Q7rafyHPKOFD9NabBU/qviPi0FhSR17fAWKiIsMuRYGMRK+l5d0Nej56Jr/pe9IcG2JiB/SQGocqQklBM53QYsUyXHaefV5s4UFLcVlO605+khxDRZV0kt50VEfH3ZkPaXNGKNUYT9mlgenbdJtRZKH+UhGEAII6wDxOTqRG3y4t135L/qkOnIhuJsqIxGx9TXIwAhf+RMWGjPvJrXpC29ryZtW8mtfraA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DjQdBO21HWe9R+m0Wsk5Usf2DtfKANgArh0rmZ3CAg=;
 b=rmJdIEnPN4S0iGuCooU4Y0E9iQ3JXFevym6cqTjhDnxVmQ+SjrswGk7hWoTTsTaKyyB4yCwbrlMIGik8llq7ps1wLKI7jlaBu8MdEshb33tdpsF/CFS3zS6TfdEnFuBUSId+nhcz9HMufvpckAuKvqyRLkZqoz+NWxbrWf3B3Hrx1FFm7sT2dEIV1GcY5jbVWduC91P/WCQuq2UFvYhFTODIduYVDuf21aYl8eTfq+qrpNBLixU+UTLLeP4SeGzLok6ZKFN7o7IYpwUxcgd0P+doRjrLit6SYdyxVF3AX3fct0uaA3PSnkdbG4zgCxwatxQXTt/kB1OKtgPX32JxmA==
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
Subject: [PATCH 05/16] RDMA/pvrdma: Use ib_copy_validate_udata_in() for srq
Date: Wed, 11 Mar 2026 21:24:12 -0300
Message-ID: <5-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:52f::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 10938232-909c-4848-1a10-08de7fcdb7df
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8JVjrwmil6OxQlPCEAPYyL4f6yefBXPoNhFo8G4khVXCMDT16VCiKCYu41mOjELsgVuA+oUJHr8c7Nn7vxcMDR5VNvqNBZKoaX17enIvvIEcm+4Jguaxrsk/h7wsq5z07UB7ME1iWEVfgOi5JscI+xiNlppG9JH+frrsDuWSuznan8ubPAchUup5ali7zJrEVkrjfOpYOAXYuH9Dbft7b8LEUmMlkSGcbb/WTExiIuA/S48+ZZ+9MhRWP2cFUvdqtrnQ2bhVnGn3xlLgXL/Q/DlLx/crLDSMM74nSFO1WkIelC/6fYbjhvbSGpi/x48PhTmupsyKLdMXKtdV+cV0bGFUA5LbMlBVX/7nY+yUYhSDfG2eQi0ahcamx/hsNQQn/VnqsFATQVXMxNNxUYr+PegGccfpiL0GBV9zlBFNpTqjD0rkei3fAePImG6qs8kC2pLCuX+hFDnHIA9F5tlfGL20tS9SN9JsKGABbdSxfHkKngNAh1zqEMGEe2UdeCALYiw5F7O2IauwHWkFCNOl2TbRAkqUI6RpwFUT/wI+CWSlQLJMC0ce/bqRt9qKufZ81v/ZhO4ZxZVbQvcJLpKwrL1zTfYb9V8pJpJk1S2ZwyC3KUEKNvWnThhzw1iH6OA9yL2zulIMr9kQ3s/OKv9wcPbR0XmPaPUPIJzXuy92kcsBKrRefDrBAzPEf+u3UimD7YT1yxa8KuJ2daL/10Dm3rw6qlCNBZg2j+mZ+xMkDSNKuG5A1F5THsLKkCVuCLagvvQ7KmHfAafFfqyjFkks/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yqpApXaH0gmJdqzP9pz0pfTZ/fLQKO6lzbO/ss9O01j05tnKmPFBVPo0G7hA?=
 =?us-ascii?Q?mE0ix+XftfoxicUXHRlngV17e5A6SyYk5pMKi/6z3oyTteQHJ6DQjOUZf6NS?=
 =?us-ascii?Q?yR0lwBU63axYTV+l9tAQ0OrCPXBsCnKhmANkCjnR6UB67JcvoY+cBGhCNbgy?=
 =?us-ascii?Q?Xmri+RPbNgunFwBhz0MuA7kzc75CTe+/d/Piple6RuGTfCdQmcNX1ZOBJXb9?=
 =?us-ascii?Q?kP0neUfvGczVEryOp0dVrIY6LpV3EjeqHOu74KvafBH3iPmIB7SUhtJBpBw9?=
 =?us-ascii?Q?mrSa3pJQpxpXaT0unwQp95rCD/33mJyw54y0siF78DdKBiQbtbtyRRcOALku?=
 =?us-ascii?Q?FF18T6gS/HN86bQxWwwiHUClJpGhwE5hg0apEnENh0KH7fchiS/t5Rq5XcGG?=
 =?us-ascii?Q?3CTlAdg/8Ld0AB/zZCOG4DeCdfmBv5tx/MhLDGA6Sc+NQKBqdI35i4ROLVR+?=
 =?us-ascii?Q?547nohQbRSvp3aCws8ncEcV3QRqr2nTYzYS/hRbJ0v8e/qkdn0DdhCEi6z2B?=
 =?us-ascii?Q?L/LmLjIcvRscaJ3790WflvBTqs0e7BmGaKzawOedlpk8F9+2gWv58lf9Pd2u?=
 =?us-ascii?Q?g1wAo0vfDpEXH33i7CqgVSGuqEo4E2Un6fx6hkW4xu2af53QT3lUnNEc7td4?=
 =?us-ascii?Q?dHYjYnnkCtUlh2HQvkug8V9u6YZQDlKwwIFDHGjJUHFQS6CmSXEQbl4qBCEE?=
 =?us-ascii?Q?pclgpriYoujBupkFpHg/UoRj1E5udeRfPemelVl6fLLYvN0W8a5eXl1BhpPk?=
 =?us-ascii?Q?xdJ46Jkmp8q389P6CzeoQcOQZHCkJOLXXgoyJuCNNZ/CvKhOmH4JXTE9oEk5?=
 =?us-ascii?Q?cO147wteaGrVU9dWaDZ46wcv5V5HgzeNeMZ7GDzayCfKbP7IMEMr0IHPyNRc?=
 =?us-ascii?Q?Do0/1V/HqdX7SwCuXWBCGJ3DCWwW/4bs7nCfaL4ZjQ3hbXPw0mzKiBuLIN+b?=
 =?us-ascii?Q?mJG4Xzrw6NaUyaKY19/sGJ9bcajxoCQ2tZnDY1PSuNUE57yWuoNVqpgB655F?=
 =?us-ascii?Q?drFh206//lFnGkNCj8JITshs/nwwq3LDrse8hsbDVGZqaUN90D/aHDIbJWUC?=
 =?us-ascii?Q?nrtDuBwZsXtrkWbaEUxKc00VWQ+TW8eklMAOvrOnRRHCpk35Ed4ZM9QkQErS?=
 =?us-ascii?Q?+P/ALH6B0IcVaVUzc9jGGh1vaRRN8aTp00LSd+A1h6e7aoJ4sy1sZXyo/p9i?=
 =?us-ascii?Q?SJVDohklfDwcPZxybPb7YSMZswIVo+IukZAel35s4ztUohGA3kRHsFMl72Fl?=
 =?us-ascii?Q?QG2KuubS+n9TqAQreYztFvo1V8kSy6G/z2iG8H++sTE6jhCDNPM0Hs7x33SF?=
 =?us-ascii?Q?kZfvveMwBXbC5Wx1DIYwnEmmM9W00ua8rjSH1l/S9OuLD7BtvOrdAyrzsrCV?=
 =?us-ascii?Q?/LouwPhb2xyzR2mgoShZ2MXzeaowylmBRQuYWzFOuJnmpSLuQize1zusGiu3?=
 =?us-ascii?Q?YJqW0QUUYcrjXRvknD5Dpb+AnXGzTgK/R4BNqV6CBdOPKar0R26D7ogcTb2t?=
 =?us-ascii?Q?tPLO2FlQcS9Txr4MJicENQn+yTnmiDJF0okyFh0uRa9HtFYkLHj+UWZRhHmz?=
 =?us-ascii?Q?3+VhZmOrp/Q7IX42I7xloOi6tS4XZFlgbcb8gxV+ec2ClBCz+zeAFgaJY2KN?=
 =?us-ascii?Q?UfSOHfTeXH6p6P61upvtiDI3SBtS0WVeRvdvmDT89Lae6NJOw7P8nOpE7iks?=
 =?us-ascii?Q?7Pm11HYxmG4IbQJR1lAhGjnXHK4SKSjc1gJHAWuBA2i2EbqLiomRSxAu2tg8?=
 =?us-ascii?Q?SflP0AGIUg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10938232-909c-4848-1a10-08de7fcdb7df
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:26.5134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AYn03eKdKaYcRU9k2CR/YCO8QVWCLKgau/Ej1L833DQizp2CzghuFLukjGqcbay
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9338-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 765B526BA45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

struct pvrdma_create_srq was introduced when the driver was first
merged but was never used. At that point it had only buf_addr. Later
when SRQ was introduced the struct was expanded. So unlike the other
cases that grab the first struct member based on git blame this
uses the entire struct.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
index b3df6eb9b8eff6..bc3adcc1ae67c2 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -134,10 +134,9 @@ int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->is_kernel = !udata;
 
 	if (!cq->is_kernel) {
-		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
-			ret = -EFAULT;
+		ret = ib_copy_validate_udata_in(udata, ucmd, reserved);
+		if (ret)
 			goto err_cq;
-		}
 
 		cq->umem = ib_umem_get(ibdev, ucmd.buf_addr, ucmd.buf_size,
 				       IB_ACCESS_LOCAL_WRITE);
-- 
2.43.0


