Return-Path: <linux-hyperv+bounces-9780-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDNqOD1TxGljyAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9780-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:25 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3808732C6AF
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3338F3010904
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68863845A6;
	Wed, 25 Mar 2026 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fe+2jibi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E691389106;
	Wed, 25 Mar 2026 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474037; cv=fail; b=TZOmLUBM4zeb+2wBZDXdbIj/q4VuqqOaNw0jU2eQbTe4lXPqvOxhbir7IkrPneMXHa9szu70aJfGRkdwJ2kEWR1sT/yUTtKQEvEm78O2ara7N9R83r7P73kGGll0Z9g/jIFPwMDsrO8z1mqQI1RHTVTHHyyc34xVLFupw+pT6ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474037; c=relaxed/simple;
	bh=IVRc9h+FICIkNFjPRnKxACcdH6Ix/NdUvE8m6MpWm4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JDv1TwcmSvI8WFDV4SXpGbHVWu852JQ6n50jzwgxOIvugagkx92xjVpcwD1uAkpGNUF8y0/AOpN+8Hs5zmf/Mr40CEADavC3r4/7WQU877ORQNEmVgPKOojMWSlLh+SZmZgGTGAqA4CAod31rtjc/g2xUJqrfFJskqZyKQ/x53A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fe+2jibi; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnUXMrrQlRez2fbZeA9qyEpOkVasDt1R0n/uxGVdwHXeAoDmts646ZjF/wwZHsx010F4OI4FFDPwNJJ9MbYvjAWxbtDz5gtilcJnVntzygGCRaeSrHOZXlfeO+w7e5KJ6TTMgnCf3X4A+LQmz0gQpo4XTMQFZmF5fH59QJYWYlho1lHtC89nlzVGTfopYDb8xb3Y72qBS1SJO8egSaKidr5Md090J7P7YyhEI3v6EB3mWxuNKfrjApWODBiVUvQqUrZRWHaaS+MI8z4MrWYEv0WBJW3pwl0v3oMU7FXE5nIrKQy8ICSSkG7UVpRyXktHHa35+jPj1Y/G2BAHTRtwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zs6CvqdoIWSd94L7ikxnrKC+zXNWpmRWSYadb0OwrTk=;
 b=JAdJpMWcOinyhP/eduRmln/xY7VbSUDZbTJdaMwvsjsz5kKrFxfh52yujyVOwRu1b/WJWMukFpZKlI/35w/0/pFXAIaDySTsOLf6g6xBos9e0zJ9I+mapGH9xHbMxymTeMun4cYuQLAX2OlYRABdQJ63zVv3m2Qp58y4sonh0HPYpyvUZrFxJw8L/KpVDfLjX+gL142/il23qONkJBurQY9LjToAFN0D4moNH9JDshrzNqsmWUkvCi8W1knSpehgI+OOR2f5D66vkPmfmM4bD1gSTzfRfwt4uTA0OYqhOlrMm01qn9ZCar/7g5BusouXwXqnOEo+Zd1nMHu/TJbGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zs6CvqdoIWSd94L7ikxnrKC+zXNWpmRWSYadb0OwrTk=;
 b=fe+2jibizflJNvrJ/hRhcho/Rm/LB2F4CuA0nN7eOFT2/aPAJmHB8A+gm+vYcYxhvVdStv0MoZCgGQNk32ZQIzW0V0CjqbW8SFWYp1ZAHQJRuHdGDkW/q5SYuz9AEEeobvxOhDIcpTHptP8w8+0ZQXzMOA8fdx7bGH8D/bgKjn+JZi7okJ04joyfVpsd08ww9h9y0ShY2HvdPFeMRWgQ9/xhSFCAsEmtj5M8S0dgKpmubKpjt617cZi2ejwxM/evTOCEv/OcVAZM1/BV39FV2FGsVHW4CkJuOZ5ilPtEU/UDTlejEqcbAum79abIgq9BE0FZe8yrqh3mjzu597RPyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:27:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:05 +0000
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
Subject: [PATCH v2 16/16] RDMA/hns: Remove the duplicate calls to ib_copy_validate_udata_in()
Date: Wed, 25 Mar 2026 18:27:02 -0300
Message-ID: <16-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7f556e-0f74-47bd-0e83-08de8ab5424f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mKKB3b2Cfc0sbvuWXVDZdIBi8bSDTg1+c0kax42tuwlpIxVpmw/AJK3uxm8DSg7z91HOFWk07boxIpoEfY0linV23MJ/KQ2PetpACpJj+MN07QbCBBqdHA/OHSsgunHdCvKZ8Qv4fFv4xMS1OO/L6cMGoj8SbxLNwWf95karY54eMdRz3SajfBd2p3lmN0RNG7iJCzBB8KnreDyDej1uta531NhPTyBUnhEywEL1aYSUVb6HNbftJ4oLj2NDXYggOmfv61jR0UfbemGFuWeEdeI3vtivg/DwaZ+tbj7JwLAUwEdb94BInzG8HI6+PlPRHwLfi/wAcZsa4t9jMAyQ4127ODZYqf3/w2ELTfsBFOxZATS6jzJwGC14kJ06E8qIkJZtF7DxlKCKtQerhzJ1yXjufQkTw1plOjH6jkcwipdoqbHyBPZWrjKl0oKMoguRET2vXDN1TQrqaf5kQR2ZHk+vxmzwN30s8AaZWcA2RL3awcHatzgp9zPB897T7884NUbxc2uMTy03GR6dy0VcX+lBZjNHyD3pKdUzbiof0yoc3MaRiOe6wn58UyEMd65mJTiCvwqG9IJD6GJ4P9mOPil3afm1Px6GkMf10fZU8Y2YIKgX8G9INgsWM/XLV1bBHN7Qvaws0cZ8gff6Vofdn+5W9Rgiy+PU6AMtgcHlnkmeUdRiNtaJ3QRByixmJ0k9/bZ0H5kEycsYyr6wHVFtLskKfICqbCVeR5NQ0xlw+CTCjFddZEQFtKTmXNo9QGU9R9JYvp8MMNBHU+MGu6SzRA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zcGILAeCTi4nX5G0k4UB5wWrsQGxT9GcQybpn1wShu+QqrN+gjCNu6E5kfg8?=
 =?us-ascii?Q?IqWDZXp3Dx4/83NVYX2QzM2cGe3EVq49gueFOd1ZA4Hxm4yk6GGFthaLRvMS?=
 =?us-ascii?Q?EbRxYe6SPtBHako9CclanTn9TDuu5nFFTgFD9VVwiDY4YCsqSFYv5x/GYWQX?=
 =?us-ascii?Q?yc+kYGLpl3iyGbyCmmzSZ/luANNC00Z4sXixPsds6NWj5qGDhFS5J4IoOAtX?=
 =?us-ascii?Q?WDr2zO1Dh7gG0yoO/cfViVd9qA592ZqoTwARdTFGMSFYpT2b8UcdfMg6cuKO?=
 =?us-ascii?Q?LNyOv7dBiFGxiovyka25ykt24KSHG2NhBFmFYs+DWzL1LOO9vg22wuyVKWDW?=
 =?us-ascii?Q?RkkRZb3nizkIY+XxumVP4Ku8WV46EMvfAZcxfTcgzd1lR1WTJPyDnVXdlkvV?=
 =?us-ascii?Q?2ORIWdGZXMCf9dNRtKEF2cZ8fpcdsO0BOgbHJ8/IXcS7+bVfQPuBqo6z0uEw?=
 =?us-ascii?Q?ry7kwAJ/1B9L1Bjs7a3MgxFVRXhTyYzmunPcvZMkDoYk9EjYSv1kaszwSmJu?=
 =?us-ascii?Q?g5p0CAgIGXhYqr33ZwVam/mDr3kkay0jhb9+ZHNYV6XCC2rA+YuEboL6F2Mb?=
 =?us-ascii?Q?w59hHhP8JUATYpvxsiPjrXQa42DS5VUiQa4W5lqQxW3Tcx+saIBZxN/7+Zgh?=
 =?us-ascii?Q?TJnzZoVgEOxxoTZh64ACg6jAzlnjGWjzYH0VaLiyZBtyGowMQnYrsd+FM3Js?=
 =?us-ascii?Q?qjPFDvUL89u6M3YajrvIhrGTAnkK5XlaHRKQYM8o076vvoSw2O3ST8CW63AF?=
 =?us-ascii?Q?DK7WJlTJXZUpu8KdWAPvtutR7exXZRuZ3Mlkb1G58EoirhFcWXt0g1eCRaSo?=
 =?us-ascii?Q?aM+QPBfZ/xUcSepZYgE34NOXYid2MSAZ5IB3kaZ8T+CkohemsGjPcEUpdySN?=
 =?us-ascii?Q?pLIcjmGZYualuoFVRZqDjufK9sIzuv+HAtm4nsrjGomDx3HPum7NjpEk/3SX?=
 =?us-ascii?Q?3CevI2yol34/OoWaPxk3nXbTt8qbUOi1ZRnUtCrHWnhnOmOf72HQn6HiAHBj?=
 =?us-ascii?Q?0LfAwxHL2+5gTXRZglgZAbJKDifEeblVHcIm8p6r8Jeow1IHNeCbcyeoqfJf?=
 =?us-ascii?Q?D/LgVZNQMM0PzaH3TZuadnoY5bVZ+8A0ln503YePc4y3pjoaztGsebBTwZwZ?=
 =?us-ascii?Q?7MMijFHMbQ3Ikps0YpbMI7e3fSqUvCnD5xZL981Yq81VfkwT7YuPOLbZhAbI?=
 =?us-ascii?Q?3CWpvAHrgRRFbknsyOityFOq5wLZaB9y1Uw8MN7utB+SSOIM9OLd0UhrLC5+?=
 =?us-ascii?Q?ZG9dg/yolo9BG4FwVPwx5Gz6nUEUrqU9JQwzlrWwYkTfx02hABGLG0+ektq0?=
 =?us-ascii?Q?yR1EghvykHksJ8iZX+8RyHZtHdeSBhFtnZ/3w1EG0q4gnv6J5b2wZv18Y0ps?=
 =?us-ascii?Q?NVKjY+WAexXF0rlT90eqwUPz5w0vAhQXGk8CD3K4+7PPvq5mJ0cLUiPUs0qB?=
 =?us-ascii?Q?g59UYrYlIGpe9Nzq7SRQOorrfiE2JDIoAc0GI7rFrHLUnhnF4j7Xi5jdXMtd?=
 =?us-ascii?Q?MJ+9w0GvYjfsgBy2EGyIpxQcrHyNOhoHvgGIDoyqLDuIQNXMxLBNwg8fhuKl?=
 =?us-ascii?Q?cOQ4UGEJCD1zPeQVwSv44S3MC0tWvVhL2nRxw2FoM4VuT3WS06XpTpBdiq6j?=
 =?us-ascii?Q?dQGPXtENK15jBiUN3oVIRAeAvI4JVhlETHiZrGaZ+jp1AZ1E6wm9uux6RGtg?=
 =?us-ascii?Q?dk7JZzldoXUHCzkwBrUIwsac6RdOs7u0e8NhpxSY1A08NHcL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7f556e-0f74-47bd-0e83-08de8ab5424f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:04.1209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHhUPpkb0ieiQN2mv3jZzUgARkQWAatqnkDLwnjIAR8lMqaN06/3LN16/DwK+0Zr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9780-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 3808732C6AF
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


