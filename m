Return-Path: <linux-hyperv+bounces-9787-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC4iIE9TxGljyAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9787-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:43 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF63D32C6F2
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5314302665B
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3A9390239;
	Wed, 25 Mar 2026 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sOo2RR96"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE638553C;
	Wed, 25 Mar 2026 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474041; cv=fail; b=bSfS7IaFUFUP9iCDjMIUCPbwEDYEA4aYCVi+8tQghmFEjJ3KsDDcZW0MlaRUyQURz1v7CKdGzTTAB9w1P66NQV4dpYfnr0it7tXOzfok/N+lOIUX1kTNgEOltW9Y9ZyNXtPZiDVLrnEyRAeJtJyayGdjLxPbcBrJdn9jn+AmzVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474041; c=relaxed/simple;
	bh=jpLxVCSJgZf88CKOIALlttUTSseeSZY7eDVNNqgDu1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BjJlT0Ec7ajwIf84mncPK07sRqkTiby/sN9nDpf8yrwnqRZhrLzikDtAnHpiyBeeLFnoVTuH7ZFPHTUp6amFsRTQTCe5P8JxqLLASn3xRblh/f1cc6TNXQnlB3LSfN66kn5crUwQiT7zM3KUz2egbaZN/WnBifUU3Hwb8A4yOw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sOo2RR96; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vddXLnvuPIbyME390LDMkwkHrIRg6tTc6YfOpydw6uWQzw22yVoTHehImX0BaEdRdVGEHoDaDBJ6FbA/7asiHqcrfEhtWWc2as5VNZPeO2NFvnCriedIP95akoVgFtwLRVG3o4oVA6cXCAsTYYeJ8c9/oqXszmUhnjcRrFNTg/MJJizRAX5DUV6KXGDcL6bEDTU8/ixCjcXqJbp6k1oPbgtwcA31Ck0wxC0Jeqohq+jFnzLFw6XP5Mg9fur3J9lnu0/+K2KLO+xKYqbcc3yfkFUuhZ9Gg1RlwO8Ccyh76jbhuFodAoDw8yWL2DSi2YTE3HwxH/3xy7pXpybESN8UsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85XqCgGhgnvcohR8DRu1y2jv5Vk8no3T85nVnHmi0wA=;
 b=cxYU4v4vW+XjpancEKoeaRTfqVUyde+DXLN4pUALXM/ec/RwU6LzeqyfR61Tga5YuTZSuWvb91MBd5Jg4xPMEM5qDj8HVwRzc+p7XbITpRiMhWs/aAwN4nHO1MhpHMBN9N8oT3xSKn5fzTVXUUTq7x6NNAJEkE+rsjacmo/dGeyTk5RHWjwaND8+M3iW8aE/gtY4Lbfq8ymc8rUT8SF6oqw+44U6QE3IGJID1/byep8q/40wDIoTsZBJ3rGkI/osaV0lBbhfLtzQoSkluJ2QD2Wc6JCIe4avAHAuVRmWdoRUrqzOrmSV6V+iPvssgw7Pol3HTA3lHdciMS/KPZSyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85XqCgGhgnvcohR8DRu1y2jv5Vk8no3T85nVnHmi0wA=;
 b=sOo2RR96vmM0MWy0kiE0r+4SJY1eM0qCcDZrAheYE+xi/4yI0ah7G2QzkhJPiUm1XIjDvntZY3Fk0UlTfJzxWMsVvvGvC2657bQDj8Y7kr49Jkg3yiDeTNg2unSGPiQ9cU3mVPNs++iOGwRM91RiOSqbaXxzmVEvPR4/jWz+s5J+gPh57DwDa7bOvc4fyzwErEcpg0eD0bFf/DtRt+EWOxyqqRSCF/9B/9ZJQ3QFSIIIscQcJfjZn1SAGVt2AGWY9WwjLBYH3cxHzV3Cw9i856lYkI/Odrh25BOauQnmSx1DV2qzEtOjXXpEfgPZKpd4H7WYba8q0lKhiy+4FzTSwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:27:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:09 +0000
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
Subject: [PATCH v2 02/16] RDMA: Consolidate patterns with offsetof() to ib_copy_validate_udata_in()
Date: Wed, 25 Mar 2026 18:26:48 -0300
Message-ID: <2-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0009.namprd18.prod.outlook.com
 (2603:10b6:208:23c::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b11826-618b-40cb-c1d3-08de8ab54339
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	53ro74jfD/br3Ag0EkTZg6mi7DfjGaroCncOTxGVM8o/vs+d7RG3CQj6r/1lthG1rKgKsGS/JT6xLTMb9HhB9WbmYdcNQ7q4vjaHPlv/3bWVSshYG752x6B7JG3OkV74k6B40vctMiWMhHiw/h/VOBWoxWrrtuBg8LnemEIsDt1JOtl6XZTSmeLJfjusPFvGAWYIC2RE+3yGaiNHqTnli3EUdOtHkaQZoEfVM6hGZikZod3u/qd27tN2zK/E7UE/PC5ltV/PBlRBs3igZPKWUdracUeWQWQ+cQXgipV+nNGzEnvvNNwkDNIxb586CIdaVDRrRUIvO5nHH4cQHyaTYVZDRsxMMrjowf9vDUrxr0TEQPt4Vt/YTKaw5WcBvuvk6PAvnkF5nPYhYGp6/0LBYasA9D/v7BQnYsxgd/2muW5tOdzfu/2JLs3iKdPXMXN3gdew+k/A6kamq2RJRUf7HFhzn3DNcunfiRpg8/aivsYUhJ42zXE0mwkNYrPQji5syOQ1wtAmj1LPumotmBNp8XyAxLXlR1jVu3qAyZP5r7FCFPg1u8N0DJLWv/EwbTtAF+LDswpEbNgjHHl5FiP363jvy6ri0aG/QsQ928hkBcQf/b0/aC3Ojbk7pbtCJy5bdSJIUPJZbOcIiwT1xpIYM4+bxghIqCP2gPmtk+rugVxhDzzAeSIp8D9xxlQYvFuqQLlXw2wjjACKZPKlwLAZ8cqmQxli/4WYrM08lTq2E9UmUENmbwsMQubukL7ngzxuHKuC0pF51I16ifVTeVPidg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZVPL3JdL24DKKb5u2c1N215Ce1boxQRiTxWeopfJnW6Rch45ARrs2HjduhD0?=
 =?us-ascii?Q?Dx2VjCAJTkwwJ+HqrfQ1EYXF6NcEtTwjPkA0ZLGA95W25OXpuhx20WbbfyFF?=
 =?us-ascii?Q?4qRWn0c8VvDF5PyLxO1VqKzlN9i5VM4h9c61jVFMs8j4evK38oNBkVFJWzbj?=
 =?us-ascii?Q?gygpLO+OffZLzoK6robxKI5NPjspHxxTXIrgZhB8y8mxCV0VTpKP3lqgVnPn?=
 =?us-ascii?Q?0EAchTutENRyfC2f9EfsaqhRt7hWe29E6a9eHIZ/3RZd45lwEqMQ5VRf9Kri?=
 =?us-ascii?Q?jXDHMQ2UAhRm/13RPgWKV2b1J26Fbkm3AAC98Nsfv1LbDC+ILRKk78KTNC86?=
 =?us-ascii?Q?mWQnMTf9cSuMqqi8BibeLzn3btI2gH5PbH/2ERg4qBO33y26aP362Cn+ehYQ?=
 =?us-ascii?Q?IMMw+wyUzvhoJsTs2iLR//LBMVZvWXiQWrjP41d2ES6pjANdcseJjO3J3fS0?=
 =?us-ascii?Q?rN58oNRT2n2N2upWcuIuRyx83BlgXbZqQqIu1x3rC63Bb73sRRIJn6H2lpRh?=
 =?us-ascii?Q?QQWTzsoyOEFPSsIK/INfueBtZp7NOlpT3hF9ZtELAvnOjjmoChbAgGDC1pjX?=
 =?us-ascii?Q?4nm4ZGy59izGkHrjdNrPZ0j8dZlvhN+dtD9QfDMtUXuQmD1kgiYIya15dkfl?=
 =?us-ascii?Q?S5dlHloMjy9u2kTM1Hb6ipxO2OsT839To4w4ZYdELQNpVsI7vrM2LpmlqWBf?=
 =?us-ascii?Q?h9/4Lz8QO9UowZu2vhUOdlgKERrXzh4S6TE/VSBgYUhHrDtQzwCphgfbyelh?=
 =?us-ascii?Q?zD16WpxmrtYL7Xb2J6xcsrBYboVQ1RSp1Oy0+RqKdK30RPAdSn2w0+gX5XP/?=
 =?us-ascii?Q?MiNaetG5sjdpsGK30SlMjhN7g/MQ9JLwv5GFpPjFvb+amUC78YLsXhnkiQpq?=
 =?us-ascii?Q?/RW3L86DobHUzf5b2RY8UbokZsVa3h0/2AnQ+XTsvvujeiWu78796TZ+fOPn?=
 =?us-ascii?Q?Q1ZmR/5bmIWZoAWVyNou1OULLmWIL/KymlaYQWBrr59/zgzU+skerf65mGsO?=
 =?us-ascii?Q?+zdXFHsdG3WQkBEWJajiQBPmcx0tAIQOPfPcBTtHaJo7Ru7G0gNZK3fCVJ+f?=
 =?us-ascii?Q?vQG7ARiKzyd6/d+JkHzbZaQAC65nK7hOn5yHR+jvsN40KC1a0XR0qlR/cIEJ?=
 =?us-ascii?Q?Xy75L0lfu5B/pgZ1APqqpiXymv1Q+aq+mmwHB/iXKY55XjMpYa7mDKmzOxZz?=
 =?us-ascii?Q?JKYI4+Rb5/WONxmXYyaWpKb2s9atgUKp0JGSwJMnuXGB8M7BH6bDQxuae9Cg?=
 =?us-ascii?Q?J6MgtM1I7WVplI1NCvtmOJGFHf6zGKKdCf3G7P+kbPrIWBhqABIAWhcPE8Hl?=
 =?us-ascii?Q?+TrZezBMRYn2uy4E/cCT0RBxVHwZj4QO5dmouUpFVnK0pFdW/7yT3n+K2usy?=
 =?us-ascii?Q?11ZsRyibbkMwKzO02cWMWZazQhHOd8DRWOy0piCwZWpKTMC2oof3QDe+mCBn?=
 =?us-ascii?Q?bk+g/oUShSNlBXtTJw5WQ6v3a8FOoYXuBgqJr5i19AiB+kHgcPq2H3JfPI0P?=
 =?us-ascii?Q?HGjiNmpgDckS69oD1sFiG3yNszZDK8RbaxsO3FSaO/7yZkByj854m1W6Uh2a?=
 =?us-ascii?Q?cOzZgvm1ko1HVXCQDd7i8NhDo1ZjfIlXONFa5PfBjDe//P/z3h6jyG/wM/+Q?=
 =?us-ascii?Q?hsQdVhDFDEqSiY3+O4BKlTfRDDRrcwsBKJIrnywUZZ4R3PrNimgR9A7buzGk?=
 =?us-ascii?Q?6+hMYKaJuD6kpBOWetmQ8NzWR4Q5Ddl7X7V+aHB7RCj7xtam?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b11826-618b-40cb-c1d3-08de8ab54339
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:05.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsaCiIbpj5uPpbdkVnXm8f5V6YlVbO/purP1V2BoQq22yqqJ0f3TLGN+RPTQm/is
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
	TAGGED_FROM(0.00)[bounces-9787-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: BF63D32C6F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to the prior patch, these patterns are open coding an
offsetofend(). The use of offsetof() targets the prior field as the
last field in the struct.

Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mana/cq.c |  9 ++-------
 drivers/infiniband/hw/mlx5/cq.c | 10 +++-------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index b2749f971cd0af..3f932ef6e5fff6 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -27,14 +27,9 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	is_rnic_cq = mana_ib_is_rnic(mdev);
 
 	if (udata) {
-		if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
-			return -EINVAL;
-
-		err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
-		if (err) {
-			ibdev_dbg(ibdev, "Failed to copy from udata for create cq, %d\n", err);
+		err = ib_copy_validate_udata_in(udata, ucmd, buf_addr);
+		if (err)
 			return err;
-		}
 
 		if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) ||
 		    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 43a7b5ca49dcc9..643b3b7d387834 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -723,7 +723,6 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	struct mlx5_ib_create_cq ucmd = {};
 	unsigned long page_size;
 	unsigned int page_offset_quantized;
-	size_t ucmdlen;
 	__be64 *pas;
 	int ncont;
 	void *cqc;
@@ -731,12 +730,9 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	struct mlx5_ib_ucontext *context = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
 
-	ucmdlen = min(udata->inlen, sizeof(ucmd));
-	if (ucmdlen < offsetof(struct mlx5_ib_create_cq, flags))
-		return -EINVAL;
-
-	if (ib_copy_from_udata(&ucmd, udata, ucmdlen))
-		return -EFAULT;
+	err = ib_copy_validate_udata_in(udata, ucmd, cqe_comp_res_format);
+	if (err)
+		return err;
 
 	if ((ucmd.flags & ~(MLX5_IB_CREATE_CQ_FLAGS_CQE_128B_PAD |
 			    MLX5_IB_CREATE_CQ_FLAGS_UAR_PAGE_INDEX |
-- 
2.43.0


