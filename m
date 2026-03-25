Return-Path: <linux-hyperv+bounces-9779-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id O8UIDWBTxGm3yQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9779-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:28:00 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E39032C73E
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46596303715E
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4193845A6;
	Wed, 25 Mar 2026 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b3bnmfRB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FDD39021A;
	Wed, 25 Mar 2026 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474035; cv=fail; b=nFnoLOfHNLTqjtvu6L9MhJfzkHqfBze8jfzIh08Kfu1ZuP5pOrX7aHEClexpHFWCPnjY77nhcMdWA4O5/KJ6H46XCflu8vUkVRwFEKGpbwF8VStfVXpnH81Zm1WDiLDuY1eq+0V25hPuk2Nrb0a5jPPW8nVtw0lBujYbE6rFC5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474035; c=relaxed/simple;
	bh=FsC/3xlrXlpJCkHPlVd0TAHaioJEZgIDrnSXbSV1Q34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RQcDMJeZtGGmV9F/zPGNGUDoRFlYV6CkgOq+tNqEgD3zkGFQ5IQBsgo6RhE+TfN4rz+P2L5HLMW9hSeInz6g8LLMlb2aB+lOMo4/Onp9LRZVhK6M3B7FpuOncdIQaDjRvBk+nEWqRTDCODS/hCDPjPR2atJf3bTQJrap9442IHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b3bnmfRB; arc=fail smtp.client-ip=52.101.193.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPSGuy0EhZvXwbR+RdCRPHGXqlMW3OPWXCR8qRMZosuQg099hs/yrYXrVpcJSMgv4Zy4s6cBzTedIrHORGEj7GmMQNVLnFVMRSO1HV3m/jcoeT5zVYvDdzytlEjZrh34PXtOmGbGTNGXzhEPVN7ad6O3f9+qzcqWazDByBkdBMyGYhsGK5CheQ50c4U+FnB67VEwpUR0pQrFG9n+OF3lkEO0NhViRfhPbMRducZ78K2QrH7Hm6yqbC5ox+72oQL6ctf8NG+Lu5Z94dDpA2p2PMSC/ufqroAYL8Qld0ywNgM1Xx4coZUM+qv+opkAJELE0bqXpfFtbW6R4Q/1nUVbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln+D5rseKCOr8V88d0UNviUHqx7Px9FSTuDZZBgofBo=;
 b=Qgiuwy6MuW3K7JB3802xrH11CODopFzTE/PFFAaoHkz6KTDzZiPBwBzuI8zD5zi7hMlhDKvVAL+bxhlA12jJzCP5VW7wFkOdG2P80two4iBUz0XstvQfL+6NkiFHqivEJbl0VCysMw7czaEwacM04ZzubpszTvRfkcioPKrcH8vGLl2qPFmbtb6BlpZK9JDKum4wqGi0HIzfqVHHI6+pyQZkZXA3jKSGYZrgbgKMN3uVQOPKh70QUuDN8KRt3xZ9kIHpcd9aLbdVCUDAOl3OGpMv0MR0umCn3mMlgh6PJWZKTLQTqGUVkaBfZGVEAwRfdcZb3GagPwoUtWLVxYNNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln+D5rseKCOr8V88d0UNviUHqx7Px9FSTuDZZBgofBo=;
 b=b3bnmfRBepWEj9SfXTVDcg9NekXbH6g7FfOErnGO4Xmh4bnMg7wGAjZndRT1BlG+WbRXcckWuVmAIWZrAFjDXYjh0l07Ktqhp9NelsH9/ek3HGxiGDMYRI/86OPPGLftGBl49uuOYqXEZ+yxOgA8y03vWM3zIvP2Utl5rDrGveRK9VnAiJtvXOiLo6hp25ibW4H2CLQ2WCYwQkale9eJbkqE0XS3N39Gd0/aTNuS1szCNvxFLO74CdmwiLnT7Ep1tjsjQhBx66JPFBrHRCc5CCe1p1dksZeTH+KELWbaaiw4FCM/BHJni00eNHDkF2VKIees/3lljhgothbanXk9qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:27:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:04 +0000
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
Subject: [PATCH v2 10/16] RDMA/hns: Use ib_copy_validate_udata_in()
Date: Wed, 25 Mar 2026 18:26:56 -0300
Message-ID: <10-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0028.namprd18.prod.outlook.com
 (2603:10b6:208:23c::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0ec7a0-1023-4961-7847-08de8ab54205
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vN+tJvFgvnJDvrsR8yphQZ9g8wSszkX2TuDnK1X/LjQgY8ClKaLC8qMLJzyuyzgcghw2shkV7FVzMWzgP+2pyDyS8sTukH4TEjMQuO1Wn5t2bG/YqNf0ZXQseDyR2YECDFFy+2RbnFRVfJPTvkTbgYUswUxCZQJsjLv7Z7Ctcq7TLNIBBUL3vUDeZVfNS1EeB45G7dUfiw2Pii/n3zqXsJvpkAPmz9mNb0dvQiWwhtV548Fj2f7fbN54yDAUXHgV2OhIGv5rRG773w51EAJAbPhIOSfTPx9O2GgBHM1FnZ1ZtTbIWlraDD36+mwcYcOAV7Ju3QFc2pFSnQgpULKBl/wawxB0NfP3YKfSbqo+a5y0izlCs1gAfngU7zSNmIzgobhMPDLwVlWkCQuXhye+TNDCU4RYfOt9pfyZHK8CEK3huyUe1/kROuraTZkTrRKWF4sTz3/yKJrO+SV9taXiYXVdzz3l8g0yydhaAJZEGw1Hc5GmZxp+1FXxfl30neyjdMr5tim3SKnXonPzGpMvN6DAC5RqWkr5BXnf2xTTjW95fd9kiooMP3dGEJ2CzUMl9gIT7+66Mhtc8zLT96ODi8Tqkgjflohc9tcjSK2+clZPmhFhS3JLOSp6mSVRj1d7woAgqAq8DslZKMMEoweaV/My0asJiVQXubga7Qjn7fWoCGMFFDpmA36eayNSvNn2zzC7onjDfQ09EUZCq/KMG5hXIu7cFKjKt8jkYnGa0B3Jjy74rhheJpv5PtPUmy2Jqqn1Rs2iy4VNDEQQl3yDVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fmzw/AfbInSgn+l0e+MLa530ivO6pyzKE4hbSwtPna6/RbAfKyReWgWKR73S?=
 =?us-ascii?Q?QkNiuezQv/uOyV90U9XxBLRwCsoEQpY2DCvucMEpIR5Xt3PU+97+xIG6HBfK?=
 =?us-ascii?Q?YGaGA9dCox4pukK0NWZWP24kltw5DY3zRp0pzhfeaIk/TC3GSRYGnBkn8WFH?=
 =?us-ascii?Q?ohdez3x+lRqEKWIBkH3qpa6D2gvgALyCdFsnGvR6oDY7n+gzwYKgvehrNfBD?=
 =?us-ascii?Q?CHjvUHRDFaAID4+0BLYYybHQfGWhP7IpJQO1zccy+VI8xU6H0J8pBwoqjTIo?=
 =?us-ascii?Q?Jso5HSjA7IDqi3m+RjCUYnjwIxE/Y89IMD6UtWCybfqa9sMqZN/06S7t5nSn?=
 =?us-ascii?Q?XV1ui3/Sm/gg40uFH+e94z+PLEiyPbjA9ImHxHQtZfsoZWag+ou2umpmNA0P?=
 =?us-ascii?Q?KR2+TO7qNTVlvO/eLPAGSBuq1vVQ5mu1Njia2N06weazmq3M9wxXNIO1bEe+?=
 =?us-ascii?Q?tz6/s9tlTx+ROJ1GJAeufx3u0AD/kYwmOGxIKKZAwkUG+4pBEK7zfWHmU3md?=
 =?us-ascii?Q?DPQHbN5TaWB/tU/jWvU1d23D0dZ9KclWH50BnYimcv5YRdCYGKERJJJ0K9Vo?=
 =?us-ascii?Q?mJuOfl0uynRc/VxIE6/+E1znSzaY9IBqmTn29DNrDgUKMCNbB7l0p2bVMatZ?=
 =?us-ascii?Q?NBAgEF1aYkIb7lzERxskIcx6VCUAh1yhm587f70QxsAxYaVX3QMgV7pCz9+L?=
 =?us-ascii?Q?gMXSWEXBIQquQEn1XJTWOd7+hqmT4R8Mx6CE/WGk/bEdYGFtTMyfV1pUvulh?=
 =?us-ascii?Q?vnlFwbIyDk6MNVdD9/4rGYjIfCvaLW7eH41hmAVdECy+E9szKf2YF5akjVHZ?=
 =?us-ascii?Q?5yU+aZvW752dfydhzm+oNKhKQvmnzj9nc98lxxBJOnyaUO1popK4rtBm5iH0?=
 =?us-ascii?Q?aH2iijnIYz5QfqRZPzjkDYrVSPCMVgRk8votvIE8U5qP1qOZ7fdY8ZhZ+aLW?=
 =?us-ascii?Q?N0IQXwu0OKRKcP0vsTfA/oSr56ffYn6g+yMAbc7csQBj3AUy4pnh5Z2KmH37?=
 =?us-ascii?Q?RIpU5ygDcmP6KIMdH9g74oFmOL7pcm6Yq8rTUY/2uufB5zxb6wDWBKvJq5xo?=
 =?us-ascii?Q?1pUI8FPfkGJiVbz7yfzstgcHQxCp/PLGL1tP+xUEYYfXm22oYEJrOk09dm/v?=
 =?us-ascii?Q?ZxMap+69IoWelaXD6T9WilJJ9oePaNx2JMR53nCOpQMjjPTfP9FejhB5hJQW?=
 =?us-ascii?Q?RBP4jLWRjLJ+BJ1EzbFnNJZcKohFffv6OO6j10aWX3zlgYQwUGBy6WMCjafe?=
 =?us-ascii?Q?utn1Q3Q31iZdwZyU/Qs4DpXmbcrUgZPpXOQhLY/I2uiIiAMIsEjV4lQzJ41o?=
 =?us-ascii?Q?vJXADj41yR8WEv5EvbtQZI1GUIAXVaVR3Dz6C8yyekcXSkhRgKA/Ta1INCr0?=
 =?us-ascii?Q?CzATpeSxiQi5GZAq0ZkMriQrJGSrUtQPUFiG5RV6XVc0nGU/UrS/KAf2vXnb?=
 =?us-ascii?Q?1ykA/tEUz0jpIRS2X7jEzZ4OST86hbsxhZzIgDTU3srCaTMWuuc7p5eb8Aln?=
 =?us-ascii?Q?V8oyab6V2F1ex1nkm1LYDP9uZ5ElriO/XEPBIyFxS4q+YwgkkwROrKAcgQb2?=
 =?us-ascii?Q?Oss2f7pbT5mfZpfgGnA3Y8/hj6Tsg5PHmVVYeREC0s30GzpyHc9Gtk2FFlH2?=
 =?us-ascii?Q?9JyMiksatcO0Jg2SVh/05v4ZZf5AEgdpQzlVJODbLzJG4Y4AnHKw4LVBRUjN?=
 =?us-ascii?Q?bA587NKmYrjHfH5ysWHWfEwAVTMm6hHXlr8+D/IPZPWi563y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0ec7a0-1023-4961-7847-08de8ab54205
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:03.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lMYr2bu7DagLRv70l9UHehro2WKE7DCwzZcDlRnNxDiksLfcipgxcBKVXWCUovt
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
	TAGGED_FROM(0.00)[bounces-9779-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 8E39032C73E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Follow the last struct member from the commit when the struct was
added to the kernel.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c   | 16 +--------------
 drivers/infiniband/hw/hns/hns_roce_main.c |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_qp.c   |  8 ++------
 drivers/infiniband/hw/hns/hns_roce_srq.c  | 25 +++--------------------
 4 files changed, 8 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 857a913326cd88..621568e114054b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -350,20 +350,6 @@ static int verify_cq_create_attr(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
-static int get_cq_ucmd(struct hns_roce_cq *hr_cq, struct ib_udata *udata,
-		       struct hns_roce_ib_create_cq *ucmd)
-{
-	struct ib_device *ibdev = hr_cq->ib_cq.device;
-	int ret;
-
-	ret = ib_copy_from_udata(ucmd, udata, min(udata->inlen, sizeof(*ucmd)));
-	if (ret) {
-		ibdev_err(ibdev, "failed to copy CQ udata, ret = %d.\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
 
 static void set_cq_param(struct hns_roce_cq *hr_cq, u32 cq_entries, int vector,
 			 struct hns_roce_ib_create_cq *ucmd)
@@ -428,7 +414,7 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 		goto err_out;
 
 	if (udata) {
-		ret = get_cq_ucmd(hr_cq, udata, &ucmd);
+		ret = ib_copy_validate_udata_in(udata, ucmd, db_addr);
 		if (ret)
 			goto err_out;
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1148d732f94fbf..ec6fb3f1177941 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -36,6 +36,7 @@
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_cache.h>
+#include <rdma/uverbs_ioctl.h>
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
@@ -433,8 +434,7 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	resp.qp_tab_size = hr_dev->caps.num_qps;
 	resp.srq_tab_size = hr_dev->caps.num_srqs;
 
-	ret = ib_copy_from_udata(&ucmd, udata,
-				 min(udata->inlen, sizeof(ucmd)));
+	ret = ib_copy_validate_udata_in(udata, ucmd, reserved);
 	if (ret)
 		goto error_out;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 6a2dff4bd2d0fc..3d6eb22cbcd940 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1130,13 +1130,9 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	}
 
 	if (udata) {
-		ret = ib_copy_from_udata(ucmd, udata,
-					 min(udata->inlen, sizeof(*ucmd)));
-		if (ret) {
-			ibdev_err(ibdev,
-				  "failed to copy QP ucmd, ret = %d\n", ret);
+		ret = ib_copy_validate_udata_in(udata, *ucmd, reserved);
+		if (ret)
 			return ret;
-		}
 
 		uctx = rdma_udata_to_drv_context(udata, struct hns_roce_ucontext,
 						 ibucontext);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 8a6efb6b9c9eba..b37a76587aa868 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -346,14 +346,9 @@ static int alloc_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 	int ret;
 
 	if (udata) {
-		ret = ib_copy_from_udata(&ucmd, udata,
-					 min(udata->inlen, sizeof(ucmd)));
-		if (ret) {
-			ibdev_err(&hr_dev->ib_dev,
-				  "failed to copy SRQ udata, ret = %d.\n",
-				  ret);
+		ret = ib_copy_validate_udata_in(udata, ucmd, que_addr);
+		if (ret)
 			return ret;
-		}
 	}
 
 	ret = alloc_srq_idx(hr_dev, srq, udata, ucmd.que_addr);
@@ -387,20 +382,6 @@ static void free_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	free_srq_idx(hr_dev, srq);
 }
 
-static int get_srq_ucmd(struct hns_roce_srq *srq, struct ib_udata *udata,
-			struct hns_roce_ib_create_srq *ucmd)
-{
-	struct ib_device *ibdev = srq->ibsrq.device;
-	int ret;
-
-	ret = ib_copy_from_udata(ucmd, udata, min(udata->inlen, sizeof(*ucmd)));
-	if (ret) {
-		ibdev_err(ibdev, "failed to copy SRQ udata, ret = %d.\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
 
 static void free_srq_db(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 			struct ib_udata *udata)
@@ -430,7 +411,7 @@ static int alloc_srq_db(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 	int ret;
 
 	if (udata) {
-		ret = get_srq_ucmd(srq, udata, &ucmd);
+		ret = ib_copy_validate_udata_in(udata, ucmd, que_addr);
 		if (ret)
 			return ret;
 
-- 
2.43.0


