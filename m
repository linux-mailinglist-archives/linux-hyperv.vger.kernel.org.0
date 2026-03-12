Return-Path: <linux-hyperv+bounces-9343-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEnrIiAIsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9343-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:26:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2821F26BA7A
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7ACE3181838
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95432334C2B;
	Thu, 12 Mar 2026 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h5nxtq2z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378C733B6DC;
	Thu, 12 Mar 2026 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275087; cv=fail; b=o7CkKFq9Drg+YnhT7S2tjtwjqdZidzp6zCA3BjeZtloiD5s2BbRyA01lKXIr1AZVe8Q/IpTqyyTPrq6q3J8KP89ZcDBtAGeBPa3v0FDRbsbz+PWsYZx/VWTwGc0diOmzwVowSIYEv5nK6EY4uR3F6GULlNhEAfasLlarSFctQ70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275087; c=relaxed/simple;
	bh=tOlh0ImsQFY9TmtLf3XUnWJhx0MaBVPVpxOktqzn5xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=leoXuWVo7viViboV/0GSXqIRD8bAOenlE5aAi2RPMfn05xMhuikGQp75PIWiD1XMfm7zg3srYW+AJomn062/dWcDmtofDbf77T6pVJ2jr8/cE09p4WmMc9tG5gurQM3G2OJIaFmfyqGV++wI9QAINwpdNYpqI82S0ls+94LzDrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h5nxtq2z; arc=fail smtp.client-ip=52.101.48.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9HXBv+0oa7qWVUy3/A+7mPJ6KSpidTIp9u0nP4qRJgo4iFmaV6oh19iArd2KoMINGx35wnl9hNbxAVrAh98MXBoag5O3GqL8CsggM3hLeC00qm/27X/JU43Q2OdPFfafoqOAX20mV3GlyE3xLJs0gNY1fwbKiz6EgV3pnqO5Kw6DBNkx+KpIBgO435yNFijcet7uSwVjTJi1msFA9pQk6A+iXb+qq5iD3YOcstXssYUWU3uCB9nbKFAJoEGROCTXDNYnF+vVWbxJ2WWTXI4/5lIgFkKVyaFPmdSFXwziyuvcE9s7PEkNUJKu/xqCYy3DWPqRi23HE24yiHLo7VOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA43njR0wTImGwqtH9boZFTCeWqoGzCpPFPlMLdLx2I=;
 b=qRYLjX2fpoxs1MvWCMl5GMpdSmjVDOn1D9orz41X6/gt9hSM0hqUZ9VnpkszNcNAijPQqWz6BI4e2HtsoQN0h17Ofv/3rp1uL/3gFVMjb/yNogd8dpTXI9PSdgmPpqi5HdaPl4nDRIsYRkJfG/nw1LYp4wSVyjEGzgzfTM99X0Mmdt9KkphTYONekNJmZSwCRgzv9BMogL5Vlam7/8TPdZnnXj0WVBpsLGJSYxBtFMkQR8Gc6f1oWZnkHYeaSC69mUwivNBhjqLd8ZXrZOKM3FYYIf2pNY0JEhAv9t+hMWsjOSFyitZWpwws6fIs3SExyWNJbGrX5XRa8woxl4cb/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA43njR0wTImGwqtH9boZFTCeWqoGzCpPFPlMLdLx2I=;
 b=h5nxtq2zKw40zT0TbMzwL49o9Pd8F64RiqIwcx0SE06lZGcVtmdPxNmLDG3k0aVmY8FLuXfqTixZ54H7S0vC2Ed7UPUo+bd2WJBUfMUX550ITbseNSQM2/cDX2lX1AqwnEGc1AGsVQXrg3zK2bmdU232p2L9WMeLPH96s0SwcwefTrzb5UlVwCdhiudok0rnWcjmtKKA7/yt3RE5t+dFuKM0XVMo3s79SKi2sqLKnrQYBhuIB65W4T81ptYxLJxxdSKR0mhPenCKcC6vqxiXvNFDry833FHlvi0W/A44sC+mIIMb4Mr6srJujFCynlwTT2TOgOiK2M25cUV1YVE7/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 00:24:31 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 00:24:31 +0000
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
Subject: [PATCH 01/16] RDMA: Consolidate patterns with offsetofend() to ib_copy_validate_udata_in()
Date: Wed, 11 Mar 2026 21:24:08 -0300
Message-ID: <1-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:208:32e::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 8566b84a-65d3-4874-dcb4-08de7fcdb7a7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WoE5Q3+XRMEWFBbIBqlgma6QQF2CA5qioLM8w9nvZkEBDnEaug9UF0sxnsCHWc0+BVG99d1SA7hJfrKeq2C1zdMoqL/sqoEJ/FxtUyZgHR/GKWjmjVqSGudg/d//Jt2p/m1I+lJND9WMs8Zvrs4N3teyAtKysKO2ZxYZkv/xJfk144+Znj7DZHWLaljKPdONxA9oxeADrM1/Ak3d9T3M3YM7RsdLhyUTRLQwonoXNDj5E4zOFMe47dg5jS1I00BMAj01PSQdr0hzI+w8DIBh/6UOtpHfT0SWcrUQUjCJ5sIZOQeoUe5lqw4xbb9Z2avbOlqLEyr6mMO/WCg/JPhJunSfbwwfp/mHItfQC1B/PmfiSpaltDuvvCKiHK+xi5mlwmEh/nCtzq7d8ock+WA8cSfG+vV2ATO9YLPGJpBJp5N4x7VxDA27RcNi7Ghnqz18jg37LArkmA5gBHIEI+hULr7db0ChxwZ7gRQHS+QDoRdgIG/E5D1B7ySSOsIcqBrJqOkxSqeV27d1L8BiFIVmthlfv5meQOlGKZoCkjtd2nRk0MJhvo/2PmT3skH0D/E5DX8ASEzkr08XjGdT0az+aWKDjSHhTR01k43TkFcPHJrzv/hSVjS9qtqmUs+J6dTieELGeRD2S+NmaFq7p+164BA2pd058MPr42Fi/n9uGDTIM/yRK8ddZF5qfsfbasnElxgBVzZndH5FvshBoSy+3dRwAeJqyNRTz13X6o+ktTFGZQgG1x6irKG+9jI1MnMJEe06YY2I7GPjLnyrbHbgug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wzCmCIbPfRUFz63U+M2cx5lFjzA0chEq/VHl8KNx+xxUi9O9Iinl2cWeN6Sa?=
 =?us-ascii?Q?iM/nknwEqGugshDqPKJ52CmpMBZ+hcyaykQh+sHBaBpLqhFGGG+xB05t7dkq?=
 =?us-ascii?Q?5FIVkXa/C0HH8nzfn8uCGoV/jTHi+fRNV/ZyazxAZdmNfqOhaBPFVjLAQ9bU?=
 =?us-ascii?Q?gR/aGVnJ2W695zR7F/9eugcMoChDLKw9/Il7GOr/rpKoEc4LYSOBmQ63YuwU?=
 =?us-ascii?Q?T2czJ1gFLbK9dCV47dwm9B3WYWn6Rnvar5COfHc770JsbnXeVk4tjXwScOIA?=
 =?us-ascii?Q?3Q0YHxHz/JoNOYPkcPZyjeiSR7XEYQbRxQ9dE6i80fJkaMbbTMW2w4unEHSF?=
 =?us-ascii?Q?G1/j+eojtNvc2l9H+P4CB0Wjo8WCsnHVGgYdaXsbox7RTyWPlJbu9nmXIpDq?=
 =?us-ascii?Q?4ByO3w3xlag/5y5CXWQPUiFc8yWBoOLLtk5BYR7il37DAsYQkg5Yxpayxgew?=
 =?us-ascii?Q?aDQOo//IolzdzoLBGWbPZeqngHnF9ljgLSKXz6jkbYbD8z0RsTBqmYxOlXWi?=
 =?us-ascii?Q?JBCNhw1s5YZHNKpxvko4jYYpEiaIup1NMFutBiI87qqMDZX3qy/iDruqMzmb?=
 =?us-ascii?Q?nU9zFXQqu1/jSNps3aDtIJC/WACDJl/dXB6tlYEXysOJm2PKJ2oys1qxLQ9l?=
 =?us-ascii?Q?X8Yg3e0rpo7IwR35Gws293TKS/ZotfGJXTJsRQztR/N8pQK4vd3Zi0h6dgi9?=
 =?us-ascii?Q?8pFa3Jzn9OyGLkSGvwF8YFOxSlQYWh784MwtSFTqGJYoUaOBoSUtz2+erqfy?=
 =?us-ascii?Q?UPL7Lsq1lHQ3bZTUxwJPYhakrf95fGOzfYSa1Lfcplg0/cH8bmR1i+dABa7u?=
 =?us-ascii?Q?LftKjFPkfyJshybNRFF6wKUIhJENW2/RiPGPLTEcb9VpZgU14/z1dW4CU3uN?=
 =?us-ascii?Q?u13zMLeluzesscdn6nQGZNq4N593Il7Un3JU1i/9LFmOX2Lq3082ln8WDPOd?=
 =?us-ascii?Q?GWsDyXmhP1qfaYHGyKNC88Thy6UVRRJrmweFevEHBGBZNwhoI5zFU0elipk6?=
 =?us-ascii?Q?oPNjNhxizuSgl3zHKc0Jgoz0ATDFODiEUR1uo8Ra0grzGpF7r5aJrIEZJoFH?=
 =?us-ascii?Q?rKyqXbopmhLLcOi2TEawQnqzluZOAwn+wdDpQuXGm0qCbG2m/2VrfNj6lT5I?=
 =?us-ascii?Q?g+Ek9qfNkaHz0kusoj+nmDuK/ejtLIjlIVAT+TGGq56/Hk8HMlA3QOCCG6BV?=
 =?us-ascii?Q?gYguh8kEL7JcmZ8RKQRBRAh/2JYHVJwe1qA527xAOqTPOGFtobGcj8VUMf+n?=
 =?us-ascii?Q?sn5NDHs0MP1q56hAF1Sp8WU1eeuchNrmw0ZmA18xQJem5WIc1KNA0GJpLKyC?=
 =?us-ascii?Q?8cqXuj5/t5DzVJfAIZTKfEHsOKEomNlOdK7gbXOihPOhxHFSixGy1xdiXdWQ?=
 =?us-ascii?Q?xAEXYzCT0Vx0EEQv81Q0GSkQR89FhCJfqqLFiCN5S5tJMd+VdOVy8ckFdZEl?=
 =?us-ascii?Q?uS6eABUHM9DZAzOomkhiWEV9isAMqqslwKbghYvyBMfmRungV7Dz8WuBXtcX?=
 =?us-ascii?Q?t92FWJoM9/EHNmjFuhAEhPg9IM75ihaq87Xo/TtVtwXDJcedKwVQcCmChMu5?=
 =?us-ascii?Q?x3kS45Qil/Z4izHA02F9ewg5a/5rpwZLp0F5XXqbqP159e6MTlBGnpF/mUIE?=
 =?us-ascii?Q?ACwwaDOMtED4h6gdp/nClHxh2wUxcD1ijKcRx8sXXKLV/lDWIRN2NyTZ2XqE?=
 =?us-ascii?Q?ozczaoAicTmDBs4jgtG+45hksi+TLYatvoAg6QE211Icj3pobQweLmAV0Ou/?=
 =?us-ascii?Q?pAUPAo/tdg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8566b84a-65d3-4874-dcb4-08de7fcdb7a7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:26.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xn2V/BuWuXcMvFfvU/D/B8CG7ESQ3MziCvb9IjAweFkWtkxwHMYuwJiwGn3gTW9Z
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
	TAGGED_FROM(0.00)[bounces-9343-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 2821F26BA7A
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


