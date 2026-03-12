Return-Path: <linux-hyperv+bounces-9336-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DcPNv0HsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9336-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 674B226BA30
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E52223138EA1
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA3E33A702;
	Thu, 12 Mar 2026 00:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gMyUeGgr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D977C331A41;
	Thu, 12 Mar 2026 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275081; cv=fail; b=lW2wkltowK9VZnXWLnRb6FZvY4+s+lpp97F6ZeiGifsXlJzheoVjqlNhxi7g5BNCAX8qKvpTc9n4IRT8WFgKypARaRgvRZb4R5bEkFAlwdGR/ymSYgrB/vgn6cVZgNy4rC1YX7bbA8wZPdm1wVyb8WRv9AwlhslDQ+vKICk6d0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275081; c=relaxed/simple;
	bh=TAjdROnD20uyOVSxEzSfgG30zCj8Wk4eiBKsbs2+enI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c9jbxsgf4PUaw8bjlWEeGdut+j+d/2Q+P4RI4obAkbqtwHT+jpIcndEUU8GF+qiHt9c7Y8oFVzSdIZMi5as3eQesBa9nWZC+SnAszR9oRME4nlxO5IIUtg44i1sKcmEMLMIu+8GJGpkUP61k+4/rXs/onPU8DzGLriS9hAakBRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gMyUeGgr; arc=fail smtp.client-ip=52.101.48.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbNNsHNIJaw/6Fy2HIAfzPwX2uCFlfRYRWRMZ1JtDtxnQr8tA0BtfIdnjQZHl6g+ODB83pE/NtYndd9nR8Ps3tr6GEnOFGO9oxFJ1WSax0eA47vrn6Im9sntPX3BOWFt0BEVD7yB5nUFo5PoJqrWNVQpvcS726vt3axHlKMGxMjXULN5FR01i9rYlEmEFqrmQ9is6sOdSXCFVU41ooyvbaqBSW9OYi4YpT7QDidqJj+kMvi5hzOVi6l5+7VTSdzh/UNudX53pZz1Za5bCEonSBtZ9VCiwuL66iIx51xeSgCq8vbkaV8ZnJbP84oa5HM0BeRQqqv6nfRwbbmeWW0rYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuyDCtZNaHNCmkxA3RuQZa+xbeAvSFsDi3leyBDJb+k=;
 b=wM4Fs2Q8Dyg9qB0h+Z/oQ2VZLNrarG9WOvWJn7J9l1C9rVUMzrEHUWYh5xU3fRC5h6zLdvcRn3Q4J+5iq0gdYz7iUWY3uNnnIBlnubi9imeLJP2FgaCuA7iPNY/2B/ReiHxI13Fb+TxgKaTLjC5NZC7jyZhaCmCcx2GZ8c0ylw+XuFDoq7qj8iOXs0wHhyOAHvrtpy6FTeGx3DUZ15s11hhlIffj0g8dv/MNYe4ZRPqgtS2E/gDIXK6p7x3xu59tgz9S4bBbrqoIkaxCe4uo44VehMtBwBDzHUc/RlQtYofaAjpIPrGgWIkY6smblcE7T+omOgMtByLbzeP+En9X6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuyDCtZNaHNCmkxA3RuQZa+xbeAvSFsDi3leyBDJb+k=;
 b=gMyUeGgrVYU8EFiXYzM83vks2WIEsy1syDNeJSghuRZL53muP/oBHNmulV6oO0Rpsd6pJivhub+9h0fsCyH9EbsQfDg0BGctCq7vfVYwEbyFXhpK05uY5PpRLRZilK7TP7fVKE23NSMONZ2mcX+p0i7XSxvjcnyquszK7Gctqg80Z6rp5jpzQaF+xXZdcVCwNMkKe/N4zY4mMhDxkly8JeptK8b4F5XUsNgrxMPl1qvYCpm7tQ6GbempazYtU57P1qMZHZkBXqh0Cq2IGER9iDGreHtX9GOmjmuq+uTsiGs+caxa4yTnfH0XUwr0W/TmuI9SUprwEXnHDQH+9Ucncw==
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
 00:24:30 +0000
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
Subject: [PATCH 06/16] RDMA/mlx5: Use ib_copy_validate_udata_in()
Date: Wed, 11 Mar 2026 21:24:13 -0300
Message-ID: <6-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: bdcfbc91-a677-4291-11a4-08de7fcdb7aa
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/Ywg4NWDVIOayY9rpO1PqN9i5PImurdKRuUgBgV/RfMR9BcvCw3ArwemOTu2srTkZ3lbwwHayjaHmaYnwJ6mwEtsNN/Kw5pzIabHBZVkMLy5dXAFOsLnSQFKwCoRt7sE7e96LLdy1GEPYU5gg0e3Pl0/plOU2mOI73MSw1N+5VsUW68Sgb5QkDIpluIL+PbkVaL/fWz9eQ8RJZ2kf0efs2lc4MTYiowXhzHpFuVmTpDIddXhS//Cec9+InAO0tnJpTycwUgfv3eAA/pqJA1TOQZnUhDWCN+ifpF8hFCmfTHPNdR9vF7M5cr+zFxFfHMgTa8mlncfN7ymdplPIlrGaT+xexa/d80Y9JuixKg8xYl6AOIVuMeJC5aSJ94+8O9wsnK79X9MbPZryOedDCJAswbJ8W0XqVtrS/gPj2pFu8JDl5BCXUZSnLE7WozjvCY/bTUtIFPnY7RSITGHO5zy5m7eRqcsy9HcsoPmDIwxGqfAysttvyvXw6cNfyTojUMfWGss/f8ApiCmQcp5cNDod+ze5cC81+w8SZSnUCguAa27o0Lz+APL8K0c/BNKhXE0e/S17zDP//BN3Xz52YG6tD2Gl+nOzWA5JdGhbi346ZqBCsGhQ8WDvc+7fBitRdmDZauQiTl93Q9PuAcnxt7OQBQd1l/+HE95kDolzbQZUR2eHeVGafi8k2/i3CzzYR6nUf+TutsEOVfQNAvF+hwUic8/8TOIJPc8xjOOiSby+ODjUVDZvmHnEPv8kqrfAsbdmOq4Psyhx6IWfPBCItcluQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yN8P81EaLLDM1AQ7Fg03Nths17TNKiLDTY4N1FxpcGdxdutWtjuOByaOKLp8?=
 =?us-ascii?Q?xre93/8HbulaXQln4bHWLFEms+FL3xQmNbiY8ykmRgmrwYjF1mB+gDsGpYg+?=
 =?us-ascii?Q?5SmcNWdwPrbjfsG1MMe/YFrqqcbTa2Xw2Jw7dpgWeRKyHvZjG9fUf2ndHl+c?=
 =?us-ascii?Q?TIhjYS3uxjyaaV1LtB1K3rv8umgd5KAKbbd8EPaUOXPlyUFHBw71+EL+E2hO?=
 =?us-ascii?Q?AE2bYeTsMlWW+2yerwArHQBakZJIuJnz9CAKn58f4AJzYxbZ92M07TYneZOZ?=
 =?us-ascii?Q?Eth8VpRPgxt/yS69N6Z45qPRoW8SorSzzaNo8lhxPJQizCUCGmkSk1D0K1j6?=
 =?us-ascii?Q?SN0vzykoDDZV4Cj0unjQZBfxZuRA4K4duMHaGeLVejfbKp87S4OdOoYXSL5J?=
 =?us-ascii?Q?ljC8GviCG4AZ2VI0DXI4fG0afGE4VLR5PJRXKH9k2H0Wvqrpa5SdzVS/fa5B?=
 =?us-ascii?Q?Qj74ONhyRHpewJOKPyDGibcvntuHNPMx5fYbnxBARKrLFs7vx72RyRh5Y9Y9?=
 =?us-ascii?Q?JYgw2/p+dIGSQ1iO9a0ff9LuGu18tYy7fwg7bQxWz+hQJK6nfaBkb1Q+BPe2?=
 =?us-ascii?Q?cCbYgnLCCIfVhf2i8Qd/jHfaS3btI/QwBY4z64/ANheDxhs34rqY47TLW7xy?=
 =?us-ascii?Q?pXUit7wuuE5Hj/27jyWddNiY8N+rQei+x+DlRi7zSelyxM2L4mem6k+FoF09?=
 =?us-ascii?Q?0/JOXuIQ9ZUoZ8eOq164qP1ZmsfzUKOspZ5tsBlX7xRs+EE1ncfJ3/n7w7cL?=
 =?us-ascii?Q?jxW8g6ByB78nQ2iQWA1cU8/UswvqECnLgersYkl9hqNZ9I4iBUR4EeyWpDOJ?=
 =?us-ascii?Q?oixdalLn0A7NZLM0lgScboYchruAKo2tkM1MDKDKSOIpFj0PMNFsiEeeFWh9?=
 =?us-ascii?Q?Dh+fv8PZ5MhzxY7CxPmREOpwseRJbycFJhAz58LpGzIQCQc6y9MQYs2+MtbH?=
 =?us-ascii?Q?nkOosd/IQHqnF7rq2dGO0kzExkOLoj3r860brsAtRuAeQCQ+mQFmeyMXmPYs?=
 =?us-ascii?Q?nqf9nB6dS0u9Qg3wF/svPVAqWxbqXzXtKjSuKXx+2wYUwFdWA9U00EEf5XTJ?=
 =?us-ascii?Q?MjwLqff/Xy/NiXl5zaKyxD1SLK5GmnGlQDtowYKDpobQDcggOdMCJWEb66QC?=
 =?us-ascii?Q?XaWZeh8wtoyv4I2fSkFCLZK8Qg7gujTuWW16be48WUKzixDCQNHrB7EkkBEV?=
 =?us-ascii?Q?lCY3U8WjlJ7tqto392vKc3L8R13I5RgJfgp3EHG43FYpiS1YnIaU4x+Faq6z?=
 =?us-ascii?Q?rn5AQ1yFZAt04rC4AsiO1Jg715/RT5xqc3tL/IAHAx3Mbqm2753x/Cot5tJS?=
 =?us-ascii?Q?rG1p9403tFhrgYwKa8BJ0PZs9UNwzTeifWQL7ynMbqJtPbd89z9nwR8uEU9M?=
 =?us-ascii?Q?QwGI6T7hA7NwUkXexRMzCGWPg1SFU2kJsomaEY8WkHYO36XRUBudzRCG0KEl?=
 =?us-ascii?Q?Q6cSthko62TP8sjz6z3QJftPlsp8S+12XKbKm3OgggkqN744SyxKiTrFcrX6?=
 =?us-ascii?Q?1deJJchE23iauV2yweBAJyXXHxVH7vNsZATXzrr/WCg9HVZG6E8GRNXRNFfg?=
 =?us-ascii?Q?hypb4NFoTDe447yNmHXLwipW0fZY1PPzdJ/jSFfkJcZVPJqo6k3u/r1KJx8J?=
 =?us-ascii?Q?azGQ9bWzJLRXadwAfVKAstKYM5haB+YL3RTC0TMUmdAlRxmmbflEwOPGEEQW?=
 =?us-ascii?Q?N4HtMTgSCc9A0HTbbMtEU7+vTHhlpmv6tbyuZ/iXe5vkjLo5phTdjk31vtkO?=
 =?us-ascii?Q?OX/dboCu1A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcfbc91-a677-4291-11a4-08de7fcdb7aa
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:26.2010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxd4zEh6U6mZrRBgm8mDIZuN7y9dpeV0txm1mQICl/5RQPhUDfRivVPkisoplvdD
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
	TAGGED_FROM(0.00)[bounces-9336-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 674B226BA30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix up the remaining different patterns in mlx5 to use the helper.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c  |  7 +------
 drivers/infiniband/hw/mlx5/srq.c | 15 +++------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index cbe34251e340b9..fce519b87633ef 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1774,18 +1774,13 @@ int mlx5_ib_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 		__u32	response_length;
 	} resp = {};
 
-	err = ib_copy_from_udata(&req, udata, min(udata->inlen, sizeof(req)));
+	err = ib_copy_validate_udata_in(udata, req, reserved2);
 	if (err)
 		return err;
 
 	if (req.comp_mask || req.reserved1 || req.reserved2)
 		return -EOPNOTSUPP;
 
-	if (udata->inlen > sizeof(req) &&
-	    !ib_is_udata_cleared(udata, sizeof(req),
-				 udata->inlen - sizeof(req)))
-		return -EOPNOTSUPP;
-
 	ndescs = req.num_klms ? roundup(req.num_klms, 4) : roundup(1, 4);
 
 	in = kzalloc(inlen, GFP_KERNEL);
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 17e018554d81d5..6d89c0242cab61 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -48,25 +48,16 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 	struct mlx5_ib_create_srq ucmd = {};
 	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
-	size_t ucmdlen;
 	int err;
 	u32 uidx = MLX5_IB_DEFAULT_UIDX;
 
-	ucmdlen = min(udata->inlen, sizeof(ucmd));
-
-	if (ib_copy_from_udata(&ucmd, udata, ucmdlen)) {
-		mlx5_ib_dbg(dev, "failed copy udata\n");
-		return -EFAULT;
-	}
+	err = ib_copy_validate_udata_in(udata, ucmd, flags);
+	if (err)
+		return err;
 
 	if (ucmd.reserved0 || ucmd.reserved1)
 		return -EINVAL;
 
-	if (udata->inlen > sizeof(ucmd) &&
-	    !ib_is_udata_cleared(udata, sizeof(ucmd),
-				 udata->inlen - sizeof(ucmd)))
-		return -EINVAL;
-
 	if (in->type != IB_SRQT_BASIC) {
 		err = get_srq_user_index(ucontext, &ucmd, udata->inlen, &uidx);
 		if (err)
-- 
2.43.0


