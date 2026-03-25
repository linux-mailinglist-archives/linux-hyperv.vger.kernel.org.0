Return-Path: <linux-hyperv+bounces-9784-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDohOYZTxGm3yQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9784-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:28:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 900C632C76A
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D180D3055968
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F74C39021B;
	Wed, 25 Mar 2026 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qAHTSprh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB5390200;
	Wed, 25 Mar 2026 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474039; cv=fail; b=fhQNZmTUBRwgf/nhIhnAjsLt3Izidu2+hSKRp7PkIAmQjOmkwcHGb/jGAQorIpRVfz85TbsJCKUHp6JnhD6/+OiTL8M0u7uOgzbCM6MWCrweKraaNBmWz7rqg9ks488n1OYE2GUJbvd+xXvqEa+/fRM2soh4dOOAiyZIFSzrIKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474039; c=relaxed/simple;
	bh=QA+odo3Us7oPWpjaJZU1boH/N4I+vnC+yOPD3Tm3gLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tEnegHWB/lhCi0uwv0/aTiJ9V++i+iN8rtf655mukNem8dCjYoU6o8AJb4+T98NyNkL6mja6jgjlfZIRAzSnpdaubPxGRb0gDKrHctn9EfZlwNODSsGlEAs1vxFV8x9+OaUtjmgKcrqZITqsr5nBw3S/HwM8ldcCnk4tUtcTSjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qAHTSprh; arc=fail smtp.client-ip=52.101.193.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVRMNDfkuWytuGTcX+8Y4hB2IojGPyVv3gO3RVqC8dMpkVLoWaDxVFZy6E/OEUdB5WOBSrsIywY4FR+mQXXbvc8P6PPVk9uAevIc9QYbNnGRfdt21KMLx1U7WvBYZZutt25DkEvpsIIxoSIAtyaBgXTBhrxoJHoWqVsLWtqci1DgKVaEZtJYsUF94pwFs3AjmQBV0koS5rmth0ZqaT0bpPeHi47oeJm4USP0ljTYGzm8n4AggiUZdIA+UE6eN4BeL4eZx0JEclN2QrwgYcQlE688Hd8ReQIHJXl0EosPInjNag+KhOmQ60LmWPASJ7HRK0TUqtgocjF+uyFCN9RU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DjQdBO21HWe9R+m0Wsk5Usf2DtfKANgArh0rmZ3CAg=;
 b=tOuYC+Rm0WI6SnR74O3PMyXtF6G/j7InUY6bXJVqbE3LHl0HOyzj+1HNYQowdlS7QjbXZ+ydZLXl+XX7nzwZVI1D2YtLEGW2BlFtn1MIjwElBf3+SPLe0T7ceMZ0/JaMqt9WOQAzqYeKjgr+ZOhYOil6u0nDxs4/vg2L/Q8nBPaGuCFEoiTfK8PzWOj+dWMwmJ9m+JqELCJBn93EucqnPehVxaU4H52QbtLMgjLhVdsK7SodMS2UJ5fd21IqBn1OgNTN7S4ZISmD135i38DQNiwj+WwUFzn6ov/LXGFKC9rCv7JoVEZsyXbj1XvKZmCbrODNSSw3s6pcd+pAFpOjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DjQdBO21HWe9R+m0Wsk5Usf2DtfKANgArh0rmZ3CAg=;
 b=qAHTSprh9UL/Ju5O/ywhutdrTJ83ndH8ymm2AoDKDfULbkZzXoN5O7TD5hPttIEMp3wHGl9mlSQWl86VM/0t67h2du+7W68iVANvofkvZ/rxPCky6HoF9Go8l1pu8ML1lHSc3SVxjaj82DOCarS17se7lMZOvzycG3+ShLAP0FtbkNHePGUGoxcOxIWtTWGUcfGDKc1bqePKEPUbWiFtFDmERpnm5v1SqRnzfekhDFZX+gVg1os3dl8tm+YzJr22tpmF8PbRn15ckZbXEV6/Tuz3QMuf4S2wYcvBS/yBrTY6a5nkLeoXN97DBDeiilTK8R5EC55uudnGiG3Deq1mPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:27:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:06 +0000
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
Subject: [PATCH v2 05/16] RDMA/pvrdma: Use ib_copy_validate_udata_in() for srq
Date: Wed, 25 Mar 2026 18:26:51 -0300
Message-ID: <5-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0450.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ff3776-062a-4599-9116-08de8ab54297
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xXYFCoJWLzS9xaHS9J+WPK1vr3cLTVmB24OdoKC8/J+pvHFURzG+quFKqmXsdwh078j/A5VklAnaP6dKy8/IQJg1Qbvfx7ZCWeZMZwLqysGheZvnoLJhcfcfCS6qFJMQL0rneI/TfozS7C1NUO21cZw3AmpTvFiIkv4Gb54uAIxpoxWA84NIsIsXN2VL5jCXw0bJlSxL8lB/uKMTRS3Ne1rK7a+rIjW0W3A/yLOcGL278Ol5ZF5NbWDLAc7OVUNm7bhpLiFHb5PfOjPAUMYD/zgV0fky9bFtJkupnlYGjSsnR0CUR1J2ahchLhay2BQqajR4P9WRpyc+1G3nRDc9+xKLZ93kfhOzq6ZaCONaf4aPeBdrgcJCyPrjXVyI5FnjMRL1yut+yFL++Ype27xnDiHDgKL5oLxTMca6X+8cxqh0v6/iqMCVEUeqmCfr3ca0QgnkSTjPflh6qenLqAt49oqnrXdGNdWUcWkDfHia1/7nviGkc6avSiR6k8zL2LmZlZrCG7em+ItYoNnRrK/dfDHV0nylwQJDihY99d50bB8XCDSiiscgi9Y7tigg1NHdZAbs2xfQCHcbSev8iFar6hlNPUMZbAuEupPshV2ARZTBmJRwWZkOij/9X0r9hwK3yUrA5fWNMv8OpuhWSdKj66I2yyIMs4vaqSRrip1v7KDPWKHB/KJx3beHM50E13PY1S+Hk4Q1G74m1AQL+L7yO+QjnS20/Z1VomCisC5VLJ4XV8ktyf3SAIdKyD3O0ZDL/c8PykTg5FYHWLJO8NSo+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NLWUpOzmCOpBHmkcJh/TKyA4Rmlw4up4nUu58h6IO9UA/dlIKZzrWsoEInA3?=
 =?us-ascii?Q?HoCqhKNq/fjutHA2pfK89TJFXIvn31u4Qj3HLjqKqP1ll5B6g6YS93BQX4I6?=
 =?us-ascii?Q?p6TiG5wMts/WkRNC58YmzyNfg26nq6PHwLbNyKKz0un8oXAXFzRyKAiVF32X?=
 =?us-ascii?Q?f+HieaHB9QlNjLy+C/eM++hPNUjLjNzJhbFPgHSiuJUpAXet/87aaJrirAhP?=
 =?us-ascii?Q?ChWE7hpJuEr98l3tTfgLcdXStuP4c2k/y1UY/dtDJUXntKb7Ki5nOzHWuLgG?=
 =?us-ascii?Q?xsSkIFKu3eCvhLWIs6hGk1BrR9Ye66tCDUGKH6itFwrgqdn+XuHZOSuhYxfA?=
 =?us-ascii?Q?2QGQ0N6ulJTCdHF4hvODI/8lCr7Jb5Wm7C3Tig9sY9fWoiXWJHnir7pXIHy/?=
 =?us-ascii?Q?DdG8udsV+YeYbyHebiKUkHB0yKuY31rDbWr5DIpdGRce+IyjiFAmsQAuAb5r?=
 =?us-ascii?Q?1UH1zy3aADuejTfYhjgLwelSn738hhz47abxnZmb0OsN0dLPP47/kTg8Z1Ho?=
 =?us-ascii?Q?e+N2HEtFFR47nUPAQAdxoPEqQIco508E1nmD+so0REn4ApAj2nVOQ6GW3hHa?=
 =?us-ascii?Q?NmRBP2fQc7clooKUGZ8gWHETdfr5L5pCw2u526BqVBRK5Xtq5D3wi2HyppNb?=
 =?us-ascii?Q?5oOBJbMzRrc4CYueaiNrFN/NPCs1kTTBuQEWLPX3lec16xOpvFq4BzNGBT9O?=
 =?us-ascii?Q?RUof6K2DZ2PNpeRAUeDH6bLtfzu44eM+PLZZTpiXzfjSDk19eWH2fzSGA6Kb?=
 =?us-ascii?Q?vpnvcJo3zwxy5IsVGZI06aNbDCuDW7bMtfc8K1UK64V1aHpa1ZSheDsj8qsL?=
 =?us-ascii?Q?wpA8880XT5p1syFwCdpVfvGS0qMp+xtTaU9b7rMQRkZU/F0nlcZms7k3pg9K?=
 =?us-ascii?Q?9LMIK7it4Ky+Ymm2c9nwQC4c8O/gJgXZP0Yfa0C9iTofc2yYzr8t+dCl4PBX?=
 =?us-ascii?Q?t+YWvIXCo+5NwMWGE1HrFTkvvD/6uJ9OcmwOw3fdKnq/PiXwJWhdZUTZJJNg?=
 =?us-ascii?Q?CtCG4EQjOyA7WyN25xgu8dzjoaQuz9UoTyV8eHeVYmztwYJVAd7rOwI1s8QN?=
 =?us-ascii?Q?Rvz8+ek6ahMF96uJ8uVMTDlD1WkYu8frwE/Dm4gfprxtH8vZQdgkh/m+p6f8?=
 =?us-ascii?Q?nmUzJXiwP0yFKrxjA0TBbm/ym8Gkk17Be4ObdjPCINXc+xP4JgMnP5K69MpM?=
 =?us-ascii?Q?zqTYIFkNkOCoyszE3UpCdd/Z4lvY20swDWCCBeLZiEFysWi3QOPMDXf5m1e5?=
 =?us-ascii?Q?AEEQ08NqHW1SlmQ2NHyBGx7wYQYkRA4RyeltAtYIg8oQCewEKnQM5DqhAfGz?=
 =?us-ascii?Q?D8I5gbNrwQb5jqfdO9/fMnQUl7BNz4ERQwEUaYVDlRvUhBp0kDdIOaoLSkND?=
 =?us-ascii?Q?T/iDBg8r+oASlDjNLuk5BRoWVSsykpSFfeOvMvmckvRB4naxPdbV4HVyJUvq?=
 =?us-ascii?Q?d0xCuGqDdBopzBWxzKMzbxwPnCZthyviPVO6aflvhQ03ACRSIK+X/jWjZJOc?=
 =?us-ascii?Q?PD4XjSJP5MjOJRvWrKbCt2EUkhcXuUUr09nEirFsGXNMYMO2R3xePIEU/ADT?=
 =?us-ascii?Q?LuTSp22kNHtOYAyWADjNprWzw8JTZObvVi2FK+etLbXog5Kef9h+l706FDRT?=
 =?us-ascii?Q?gvsr7WB/LTeG1FAs3F5Q3kZKTCbWYFwk6pDHF0I5gZfltqhpTKQNg/h1r1Es?=
 =?us-ascii?Q?JNHWm0WisCSVEV24kKV7+QqLBJcehSThj8J1NOfSFe3Pzasj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ff3776-062a-4599-9116-08de8ab54297
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:04.7249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nklXalI5M4QTQywNpjJ08eGi10u71s4I8Iv1i3f4oQ/026rQ07tdG5CbfMkbIsh3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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
	TAGGED_FROM(0.00)[bounces-9784-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 900C632C76A
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


