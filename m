Return-Path: <linux-hyperv+bounces-10005-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNy9K/qi02mOjwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10005-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 596EE3A3333
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E77301410A
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 12:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623613358B9;
	Mon,  6 Apr 2026 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WbvY1kUi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F43333509B;
	Mon,  6 Apr 2026 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477493; cv=fail; b=tqTo4K2gtwurxnA/htfZm5f9XDnfSWX695LzlEeVI4yIlZejg8AsxTYbt2eZgt5DMgacCO6rUEd++cTyt3XUSTtoODzw8Y5NdG7QcsGOIMQ9WiqB5DoouwhCuN+cY+v6KCFsRorj1by/u7XiguuF9EAmCuM7Y3LBBqxFf9gvZZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477493; c=relaxed/simple;
	bh=xDaTiOBvqxxMswppf/clKp7ZHTLcbwvMSsRfs7cdC6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qFCuXfTimTqu4jbwiOnPEFKtkWs+eh80A3g60+aFG7oY9mZYeknOJix7q1MuoZrUuTsmyq2gCSXfWX9+HVXikngBWEGVWmKC7EoJyWhuXVz5LB4Ibk/aaVyLblaV58boKBsmVT6I4TnlxSGV5Eu81D5Zgm6WkBPJvpmrHOkVhhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WbvY1kUi; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSqyeQf01l1uKPUYK36JVAZosQnB1Fgfy7fF5DmC4Etl313AwEREGqDT8xXDZQN0PUbQX3O9ELsZFkB7ZSDrmrV5JtoNgDeTVbVm8YlFzZVYLdf6t6rUiieXsGAV5rX3WzN9aUx47d1pRvsUti16afLIzcGiyO/2y+7EIouHZS0olwBbJA+b/QwnwWCaAI0F0y5XGsYJYuO5YRV9xLypE+4blgYzWlhgYneaxpI5aXsinMXT9kHqkB0da+FAObk9AvpTGz5ffqHUpefiOlp/wSZ2uPZdftjSssCRUn+VQ/nCUaHJtdrEe4zGM+7uqz0+is1XCfPUjxb4FLzOj7yuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQwyAAvkd39n/2czbjHa0ovkwSSJqmNRST8sxCqm4b0=;
 b=PLDewhBKPrV5W94Jj8RMYTB/VU1hAjTdor6HbZLT+Mx2Uia33VmQDS/ZAmr9NQFsnBRpr1lENVOa+VfOQfwiZ9Nmum0UqD3bi2gOpokUKTewRdPPFcd9KpDG2uVQo6wv64YQhTl1VghgylcbN9iCwZrTVNDmRV63EM7dRp1VxmzTrljHxqRRa7ZG4YKhWO7mfCRo3M+TaaIAKu/0okT3PFKiHGdD2g0BOLxgbfmwVw36sjIZvNGqTU6wjjfS83Ojn71nz7Ti7NKkG5iezbPXJHeYR39g3suZhDrLnyM3jcwSixBww1AclHySit3O2uYDJmISFE0W+DRDfyIscBN8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQwyAAvkd39n/2czbjHa0ovkwSSJqmNRST8sxCqm4b0=;
 b=WbvY1kUiCa/2F7COkop1WnHuEywbKk2b5UYnG82H4QbTzxrHbiBn7q+q6QmeJOPZi42FipOsRqBZzh1yEHkLwR00l4JteVGn6ghsRnxXheHUPZ0GLYVVFPl5Slsgu/Bn0zcYTU90ifJ8IISKLi8/jI94LjCnluUQxBZ+H7YUREDPGsXecTHw33QJRWIYGA1NC4x1gyjua7fOvdnDo9ykGy71DBGBVz2g6bx51INT9pVkOkLVH+gAjDig2iDvvPre4fKPTJ/pds/3o0AKlEvzTFhfPQbo0g2EwvJ5xNkvY5sLqyStgyVOoLQH0RzBDeHNn7Lxgb7JZS1GeDVVrf6OHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 12:11:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 12:11:26 +0000
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
Subject: [PATCH 05/10] RDMA/cxgb4: Convert to ib_respond_udata()
Date: Mon,  6 Apr 2026 09:11:19 -0300
Message-ID: <5-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:52c::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3ebf95-4569-471a-ae6a-08de93d59fea
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	aP4QCRyTYHOHY53RmHwrffoPi5iTWe81sShJqWpekP+Xi0hPOT1s6kZAIJfAYQdZz44XnNfqTrkR0od26LF6UyWxIoDzd60ajuWpvQ1v6LpGLuwvS9c3EA7fOjtmwcygbr6yteiPoF3+DZuz/7xWx+34cSORlxUl84kxr6/c/KD2IUI4bIyBPy1VuUYsYmToAs6hNrERhuRJNY6hrejNEYaZ5p7LBBtaUwa04jfYlsH/o3ouDgX7JvzAmhbnyZnaBycVA8K/Vc5P7GDdJUSwjGxdnBfn+3D0KT7/SwyB+6PppbOXwjkbh+LbJzBzKrf7f5E/7mGmS3lqhbGQS7fpM8UnybB2kJgqLVs7wMLVS8iQCZ4Ct9Rs0NZiFVehchmCmZZBkbzFOwo40f5asIh1W3sd6S8n1BKSkoN+hzNAUC0CA2ZnIuuCgf7XARdDqd/dNw0X9Z4/rVj6OVGLb2X29/WddvHX5vxlEbRk4QWWGSfsD+AT5wAQVcJj95berSY/ScjlA0i1fUvkVJAQteipoLcMqZU8fk6pK8avEfwwyOkC3VCPwYSlTtlYEgdilhdAyO1mVJWiC2oX4/2nH3Md5Fh77Ly38mKR014s7tZZw579wkNS9i7e2dA76gQzWmEMz7gQZmsucVk40LyRkpZagFo3hiCSBixPz3ZDkrQkksbIPFaPTytrNhsHJeacgvYwF5Z3STFgzOdjSbEm06B3k334X4s60VUWNWMgLlvP7AFVikHwag/aXw4vhDltVDddREet+Le3FJwv9fEfsLOjPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n9Qn09SKgfE9ZrGNtdJKsIoXdZnsL2rEpVlKTxTiN0zClSRHHxn5Ag9RAItg?=
 =?us-ascii?Q?n7/QiSv0pxUzrTGtaPCawqyhM6parIC5J/fOfUGqm3AdDNuDZlWNJ8MRM+Pp?=
 =?us-ascii?Q?gyULwabCllTxf4DsaTG5WzvWgn5kbaED+qBQM8hxEFD1hJlT+wk7McUdZk5L?=
 =?us-ascii?Q?mMhPq9FmRsOzMdMY3govyiw1jSVpVr9vb74nPaMkA6eJGSEMbl2Fl/8LdVt9?=
 =?us-ascii?Q?RsEXtEKjyH/0tlhPIs6oSeRi7y71zTA7aJRt5YYkZHLU1bT2KB1POuLhqD3X?=
 =?us-ascii?Q?oH7F5+bZcGxfJdfn3U7JQyEMSicIja9RTH8VU4pc1aap79QYg2JGBT2/Keoh?=
 =?us-ascii?Q?Selwrax4FE7AWdXFTEESTnvYupdyfrAOGSPdRQNaUrzd6pvzjILAnvEGfdGc?=
 =?us-ascii?Q?gcFhG94Y4Vs1TyIVdrhUj46tK6kW+M/oEcAyQYuPJA+kytrik9OatnVCsiNs?=
 =?us-ascii?Q?/wfFuqCVIZ+3OxkvreNvTyqhjJd7p3YFIPJUCcQ1l76Md770kFxnM1VKXUSo?=
 =?us-ascii?Q?c+AxrhpEcB8BdQyAshydw1jAlKkrWsJ2WzcNvEv2o14NCHSYCNBQBHvK5TJ1?=
 =?us-ascii?Q?C4pobzLboKspY5tDlBDZPbXjnz2pLI9f6hOgG9pkQaO+oE3ITFNPhyXvdnHB?=
 =?us-ascii?Q?NRmjcaXAxlMZts6RoFhzijuJ1K6owlHhX9WJBuPBMjsL3MPisVnk04U8XJDN?=
 =?us-ascii?Q?1hB0GNLX9D/QkoTXhhoed1H4GAlua5dlwU76GC8DlmTlIxzNEAWXdO8c3n29?=
 =?us-ascii?Q?ZpXdaIus31ZpHg+UMm7bjFIzvky3308kDW4qzwYr7d5FkwZY4Jsubzzfl/uL?=
 =?us-ascii?Q?J7QkBnxzIQWdTytlNj9/kgVyw7tkCutflVyL3J0MvigoSqV4bacP6t24iVOi?=
 =?us-ascii?Q?gAGJym1WU0FU8kVuhZMq1136eN9MRIac9zVUv9Dzjlzt1TF4RTDjUnL1Ozcj?=
 =?us-ascii?Q?T32EFfeWbjhh7qFEmpplPzpi196ZCyCwDz4/zUJilgXT0zPSCZ9TsgrvN05R?=
 =?us-ascii?Q?ylY+Rs5PLiVcIXoKuak3STJLX9Nq6gfwheyo69IZuEaVgI7j06bVN8FN3op9?=
 =?us-ascii?Q?nPPNdsKDQNPtWml9ARUM6jfcxi6L14oVZSfUo83Z0ub3PJ/DyfT0OwG/ISiR?=
 =?us-ascii?Q?mNn9dguA+epLS+EPBvq7j0pZCIyR7Gu8+7jv08pGhWsFz9U+QHGGR1tHAB5P?=
 =?us-ascii?Q?CnON2q7VW7+bMKSgW0maFmjpRTdGTwJx9jR4ElevAOwORate2C8aKq7ptWqK?=
 =?us-ascii?Q?Z0gByDwnnqNP3tb1IR+z5/kEKTOeN8//p8U7jzE1vYRrootyzZ9y+dztvCF6?=
 =?us-ascii?Q?sOTD9bV+Dqmn3XLqYFY5Cqm8vVmHS5ktSRDaUvr+1m2mJDuNSXZ/Tjwd6nh8?=
 =?us-ascii?Q?oordJR2V8ACKhjjaj3F04SLTF1SO2K8EFnqFrYln/TAqukkeJSyo/asqY31L?=
 =?us-ascii?Q?uPSVpgHdDDUxx09kUZklJsaKjFUh7EuCJJqcYyrVYG1ceSagH0cxOaKibuq7?=
 =?us-ascii?Q?wcH92Zx1gadeEmkdRP7fYNSiYVluX1vx+GlCL5mzmpxeLQlC8BESoofBcETm?=
 =?us-ascii?Q?L7FoUcv3JwqTpYcx7EqNxp1hmeLwTjZ9knxR3/k0GF3WpFOskLg3E4qVerO0?=
 =?us-ascii?Q?RUiGorYwcjxDkxD/9G6a+KSo47KOSo7v/q5Z3T5M8RrLGaDuTp29StywGcvY?=
 =?us-ascii?Q?HakMRNVHDQzAPaEpa7Kb8zMQp3BPiMjA36+kid0uDQSfK2HA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3ebf95-4569-471a-ae6a-08de93d59fea
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:11:25.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3riSy+flz0FUYQX1JUfAjCa5/K4rWW++ySBWYez65H27qPEZhLR1NgnVU+OkId4g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-10005-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 596EE3A3333
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These cases carefully work around 32-bit unpadded structures, but
the min integrated into ib_respond_udata() handles this
automatically. Zero-initialize data that would not have been copied.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/cq.c       | 8 +++-----
 drivers/infiniband/hw/cxgb4/provider.c | 5 ++---
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index e31fb9134aa818..47508df4cec023 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -1115,13 +1115,11 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		/* communicate to the userspace that
 		 * kernel driver supports 64B CQE
 		 */
-		uresp.flags |= C4IW_64B_CQE;
+		if (!ucontext->is_32b_cqe)
+			uresp.flags |= C4IW_64B_CQE;
 
 		spin_unlock(&ucontext->mmap_lock);
-		ret = ib_copy_to_udata(udata, &uresp,
-				       ucontext->is_32b_cqe ?
-				       sizeof(uresp) - sizeof(uresp.flags) :
-				       sizeof(uresp));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_free_mm2;
 
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index a119e8793aef40..0e3827022c63da 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -80,7 +80,7 @@ static int c4iw_alloc_ucontext(struct ib_ucontext *ucontext,
 	struct ib_device *ibdev = ucontext->device;
 	struct c4iw_ucontext *context = to_c4iw_ucontext(ucontext);
 	struct c4iw_dev *rhp = to_c4iw_dev(ibdev);
-	struct c4iw_alloc_ucontext_resp uresp;
+	struct c4iw_alloc_ucontext_resp uresp = {};
 	int ret = 0;
 	struct c4iw_mm_entry *mm = NULL;
 
@@ -106,8 +106,7 @@ static int c4iw_alloc_ucontext(struct ib_ucontext *ucontext,
 		context->key += PAGE_SIZE;
 		spin_unlock(&context->mmap_lock);
 
-		ret = ib_copy_to_udata(udata, &uresp,
-				       sizeof(uresp) - sizeof(uresp.reserved));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_mm;
 
-- 
2.43.0


