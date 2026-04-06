Return-Path: <linux-hyperv+bounces-10009-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN2pJP6i02mOjwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10009-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3946C3A3349
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A156230065F3
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 12:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34F1335556;
	Mon,  6 Apr 2026 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LE86QcyA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54433555F;
	Mon,  6 Apr 2026 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477499; cv=fail; b=D0nT5D+f9IStPdBiFeGwogPbVm+72t7nag4WZLB2NynU7gyzqoIdLgqHg0ISTY/aEzKzmO1PZeVriA+lHxL8GeyjnkfEtfE6ifoHu2mRL5gWZSgyJIELuDtNpvyb004QXvhy+MyClm+Oysg0ndNyWmvkCBJvvCacA6IV/OGZJjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477499; c=relaxed/simple;
	bh=nh2Cpk/qrT8XpVVb625OK5YFn1wWuHBlSzkqrW5haCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FoEhOI0H0M00KgyI5NICewoqpzW8FFWUy6UGtp+GDP2oG1WPA+R3UAXsD/uMzN/r7e5n54Ii6FzkNT8iKyGycUohXM9Hjh71t+CV66LCL86izJ/TF7BE+EOz4Y9FTjbs/dGtp8xkxsh0n6bOTRo9mJUh7ZLO6/kdw6lHPznfBnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LE86QcyA; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wL3vVIhUhTgLt/9cf7lwwQ6xzfQGVdPRpHIn367qe8PL5wd0jrMXWsUXu9P9nxVajhV2bv2sW2qwIGUsozk9UBZs9yAp7ZHTZXseGa5JSmQj6KRmuJwHl7IwMoHRisoaYYwCxyyW6Ul6bZ7U9m5lPtLExiw4220t5wZ6Vu1gYx6IpuHUN9yURkcT5ReLXXb1SVGQD7VyCk3/CslCLsVymm3dDtm/Oq+3TIpcYOx/yqH28zNTzw+09eM5wY85WWjvgxNFLhZzeZBPksr7b3xxX9SlmQTPUqWLdBEZSG4+9KlpuL85DZ8j/VrDOM9O6esRg3otMUc2R9Fq86pWMoX+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI5VDLVBtgvqFV7XVBtl+PQyzb+msH7Rqm2YeeV55/U=;
 b=tbGitfO1zhYMSGmPHLuPUexmSUpy/yhVusDF4qmJpgWHxER5gQ0f8C/gsBwjvbeMAarkxb4YoqxFu6tUmhdlG4S29BJvHS9LTVtKeWKVB7MD8yKV+alyWxYRWTsMGM6BAJSYHSG94CU63cPauOdFHO5fxI+BKBJ/ew8q3PyUh4m+JV/hI1qtR5mfNXQOWfZVfQXclSXNOiCJtTbtbEmmg26MtJZzyNEHd3UtxPI9rMy4xKFXWsS6hXg3uGaosOtqKgkkGTxpPOz4pG70axI8uywk5yKhc60ygcrsUuAnlLdBmc6ewJx0a4obw5wHoMkm+18hPvzgaWmybK1OF41cWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI5VDLVBtgvqFV7XVBtl+PQyzb+msH7Rqm2YeeV55/U=;
 b=LE86QcyACVljjbXyyS3c7k57pEDShjkdzDTAAcz1sS41+a5ZkGb1dBV5i2y83LvSppJH9NNOxpP6uaGSC3JyRRaIdlBzzCjJ/wuGgpQV/mWfFDB9R20P57ADIu9iooX3sH3g8NL5PZgm+9xfUIIEr2IDqxl+l7hxZHB9/hkNnLvz5l9X15ZmcZ/4F7sPZLT2ZKmpCH2inO+wwPDp0juU9buCJERk4maFp/iKZsf+CEkaPkBdlM2D7kY+4TTaT5YgpXg43xnlRnIBXcUOAYhYgg1pWJxW4MZy94x6GE22OwMLriyS60bVNyl1+UBAIt6R1a49d2B23ab48u3i+QbVBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 12:11:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 12:11:29 +0000
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
Subject: [PATCH 01/10] RDMA: Use ib_is_udata_in_empty() for places calling ib_is_udata_cleared()
Date: Mon,  6 Apr 2026 09:11:15 -0300
Message-ID: <1-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:52c::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 520a1103-f611-4bae-f604-08de93d5a0a5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	GIv8QD2gkMMUaLnkvxJ5ULiMOfRDN0+4REIkWYpcWMHhWz38E80OE9XW2kM4cPKRVw2TdlkAx/R38CXoNutg2/M/34ElCY9PeexCkmJ/n+IIUeoEef0JSIGT8OVMP9Fyj+xkhLxxwD7qRkxLIId+ONRCqqvKL7jezD+ZdTUWyXUqO75ULkEC1YENJ9QOCb5zjnsoSjbE7cefRqwG+y5uECirpMM5lozE70lY2UBkRR5gMlAdLARpPVMx5FtTRlZASpmmWt51atQ+V9lwh9hvEATM9BtydGR9zvTY8Yqri7GEzZ00jjSYhH8yv+R7pG5jYO9gGBn46wiByLJT8vXGc6rcW640Az9X//ziAXiSQn4LDC5JCHi1bv6i1JXJs5xW8EIZsB1fERcd6osJMfjfzMSLZ9bWyN5jiWDva4xIaZO/dLKbblDcyndIk1X45NYlPbEYgGpCDB7xTomBLqKGSxfUQJWmz5Vkccwsr0sW6ui2ZeezfepC5ukjrTYykxorVr7cuEsdtbviMnoD5Dw4rCQoFer6pDcHiKZtBcE6NxI9xvRUPL1VQAVYRvPhVOjQje7Ks01uuqb8K4hmMQvjMGHVwbN3z42osqI+kXm0v63OpOMUwYDFAZ1R7v296s+TeTPFg9jJHt8CRVwAnTBaj0P3uDYFPxzbc3cgsZdJWAa8XVEEFE3iSkP8iWp+RBKnansvJtUG/CxpX7Z1JZ+f+zAdWl/3CnINUhwljMmaPCB/mebb3dNg6AQw23vWTWUq9BDXNvzgS2nvqWlUDIAyqw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jBDPYXL1+aGtpQK2kmVClcf3hvdYnPdER+HMxl8vL2AawqE7kCKcphZ08crJ?=
 =?us-ascii?Q?x+XYnLZMgvwbduCDWsn/Mporsjz5eTMRRcLM4pxXISvkWnWTbIh1gtWIHvtg?=
 =?us-ascii?Q?FhPXz1Q1m/e7Y/uoj6SVu1GnnOcG7JVwrnRyk1yOt0/aujM9zp7rkvltbgTC?=
 =?us-ascii?Q?VH0jDLqTVpHdmob44kbtktvL3lfhuxtBJx0aivSvd20WYfEWTGl/DQIDNCHC?=
 =?us-ascii?Q?WYDu+WsmaBFhjIYlPMwXnPw/AwdMKlL1DQEAK0Z+sw4GGEv5eONUCfAf00fO?=
 =?us-ascii?Q?LV2zSJM0J410VMvaZgDCnYCbiLoNtJcAbFlIu3VBgUVuoz04Z1bz0T9YEri0?=
 =?us-ascii?Q?BEWTaZhxqszyf8O/dubs3XaLp8VRbWYHWMZLBemXWybmq+Hqp8dKlYak5uUH?=
 =?us-ascii?Q?dIjJMay2aYuAqoqLJsCJxm/FYgfoCtcdL6L780HtdJ4n9o4r698aMKsOzlQN?=
 =?us-ascii?Q?76k4lzKKwc6UymDj+VUK6CYHZ5Cx6/4X8Tzrt/rkxGdUEQfXIqrIAohvOreG?=
 =?us-ascii?Q?WGAg0idPg/Sxmi4+QZX+Oqivy1aqUR9UMPcOh9lQ6SQ4HAWUwNW5Q3Wqhaoy?=
 =?us-ascii?Q?17E4w4u0mIY9uZCI9GNI9hue51vIy5OG4ql9YNX3RBJZdTT/gBIBNgvy0PpF?=
 =?us-ascii?Q?WURxrggzYjZrprTs6bkQcWz40obqbjONJ/bkBDgDsJpWVdY0Qts/UXOXrhJ4?=
 =?us-ascii?Q?UR3lJ5YvhVfM6egWDxd2J1bSsP8wZGFi5ScXKQ+A3wkQdX3KJiMJLsgY159b?=
 =?us-ascii?Q?Id81GGOqn944BdnxFuJ87biYBZihwajQP3uIxKOK+bNF8O7hha7AXDelVt1Q?=
 =?us-ascii?Q?cjGVQtN/pMAqB8yyjOtgR4M9r3j5Nrt5RvwOx8HXLX22/Z5FIxQ0WrAdgZeC?=
 =?us-ascii?Q?fww5ezUX1cEo8N/GEnkuAWZWa1qGP20QLo0z88XxeOcyJ2OPeWVHood1gfIw?=
 =?us-ascii?Q?6KuIw3hC7NyD3xHf3H4Z6fB4n0NR34dtL/EuU792gjUrU0rbfCa6O20BweHR?=
 =?us-ascii?Q?8EVoDwJdjJnu6mTyXHBxmnIxffNjEcyDfe66INWP3bLVhhS3RcdR5ZGVyXZv?=
 =?us-ascii?Q?sHD8sbMlAun+wx0QjpUiiJ3nU1qmdFUnsd1WTbNF6yYNoZHwXSSVCeVa3em0?=
 =?us-ascii?Q?RekNZ4zmiVDOO0eN1UN01YuNFNmg2vIhlNGiLe8yALhWKTVmR1K62UC1ncDW?=
 =?us-ascii?Q?D3m7aeij4DjT027hZu6KFDBfgtBkgF9ENOHMojFZRcQuiXkLHq9UxFl9YWzf?=
 =?us-ascii?Q?TiXwgnBRXsCEun0vqvX3eatnr0+DBvU6QXSD8dOW4cCXXZrW/n6SiVbwGgrU?=
 =?us-ascii?Q?Cjvo65BpgbwqH/jJujVFMyUE8DczIgx/QHxwdBqnUjDmwYz5Py0igTzO7A9y?=
 =?us-ascii?Q?XBoOadOM/+mAqRYbGL+ssDKNJl0X2WzosHHMwmrWE2elgvAYJ3qzeH6OCYXq?=
 =?us-ascii?Q?0pUjgKsbgftBloWZE94Tq1uaLlL3H4sqYPuksMGYe8c6hIp0R1FBXRvcTv5O?=
 =?us-ascii?Q?r5ecm8R+9TuXChMsV5Y6Wrt31fQGD8eFO2bre1ijmiFzywkVM4j/C1xeE+sv?=
 =?us-ascii?Q?MgYqyE1ME/x8is5GqfPO29Owp/lvrKZK6mD9uYHWQh30n5DorQlNroh5Rd+V?=
 =?us-ascii?Q?NijW+ibXuXdu8/gK7TLA9staZm+XA620vxO33uYszYylq10VbdUQD+BoXfR3?=
 =?us-ascii?Q?d20kaRnKIN4l7gSjSgM0+5jmyT41t+11rcOS91ZVPnmz+kxq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520a1103-f611-4bae-f604-08de93d5a0a5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:11:26.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8EU6qM/CrZVCjE6GcIBfygPM5BJPEcP9H1YLOE8usRi//Ju5+I0mJzMzlnTSyam
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-10009-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3946C3A3349
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the pattern:

  if (udata->inlen && !ib_is_udata_cleared(udata, 0, udata->inlen))

Using Coccinelle:

virtual patch
virtual context
virtual report

@@
expression udata;
@@
(
- udata->inlen && !ib_is_udata_cleared(udata, 0, udata->inlen)
+ !ib_is_udata_in_empty(udata)
|
- udata->inlen > 0 && !ib_is_udata_cleared(udata, 0, udata->inlen)
+ !ib_is_udata_in_empty(udata)
)

@@
expression udata;
@@
- udata && udata->inlen && !ib_is_udata_cleared(udata, 0, udata->inlen)
+ !ib_is_udata_in_empty(udata)

These cases are already checking for zeroed data that the kernel does
not understand.

Run another pass with AI to propagate the return code correctly and
remove redundant prints.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 43 +++++++++------------------
 drivers/infiniband/hw/mlx4/main.c     |  6 ++--
 drivers/infiniband/hw/mlx4/qp.c       |  7 ++---
 drivers/infiniband/hw/mlx5/main.c     |  5 ++--
 drivers/infiniband/hw/mlx5/qp.c       |  7 ++---
 5 files changed, 26 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 7bd0838ebc99e4..3ad5d6e27b1590 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -218,12 +218,9 @@ int efa_query_device(struct ib_device *ibdev,
 	struct efa_dev *dev = to_edev(ibdev);
 	int err;
 
-	if (udata && udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(ibdev,
-			  "Incompatible ABI params, udata not cleared\n");
-		return -EINVAL;
-	}
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	dev_attr = &dev->dev_attr;
 
@@ -433,13 +430,9 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct efa_pd *pd = to_epd(ibpd);
 	int err;
 
-	if (udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev,
-			  "Incompatible ABI params, udata not cleared\n");
-		err = -EINVAL;
+	err = ib_is_udata_in_empty(udata);
+	if (err)
 		goto err_out;
-	}
 
 	err = efa_com_alloc_pd(&dev->edev, &result);
 	if (err)
@@ -982,12 +975,9 @@ int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	if (qp_attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
 		return -EOPNOTSUPP;
 
-	if (udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev,
-			  "Incompatible ABI params, udata not cleared\n");
-		return -EINVAL;
-	}
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	cur_state = qp_attr_mask & IB_QP_CUR_STATE ? qp_attr->cur_qp_state :
 						     qp->state;
@@ -1612,13 +1602,11 @@ static struct efa_mr *efa_alloc_mr(struct ib_pd *ibpd, int access_flags,
 	struct efa_dev *dev = to_edev(ibpd->device);
 	int supp_access_flags;
 	struct efa_mr *mr;
+	int ret;
 
-	if (udata && udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev,
-			  "Incompatible ABI params, udata not cleared\n");
-		return ERR_PTR(-EINVAL);
-	}
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ERR_PTR(ret);
 
 	supp_access_flags =
 		IB_ACCESS_LOCAL_WRITE |
@@ -2082,12 +2070,9 @@ int efa_create_ah(struct ib_ah *ibah,
 		goto err_out;
 	}
 
-	if (udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
-		err = -EINVAL;
+	err = ib_is_udata_in_empty(udata);
+	if (err)
 		goto err_out;
-	}
 
 	memcpy(params.dest_addr, ah_attr->grh.dgid.raw,
 	       sizeof(params.dest_addr));
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 464c9ab4251636..16e9ce8138cb30 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1696,9 +1696,9 @@ static struct ib_flow *mlx4_ib_create_flow(struct ib_qp *qp,
 	    (flow_attr->type != IB_FLOW_ATTR_NORMAL))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	if (udata &&
-	    udata->inlen && !ib_is_udata_cleared(udata, 0, udata->inlen))
-		return ERR_PTR(-EOPNOTSUPP);
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return ERR_PTR(err);
 
 	memset(type, 0, sizeof(type));
 
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 790be09d985a1a..aca8a985ce33cd 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4297,10 +4297,9 @@ int mlx4_ib_create_rwq_ind_table(struct ib_rwq_ind_table *rwq_ind_table,
 	size_t min_resp_len;
 	int i, err = 0;
 
-	if (udata->inlen > 0 &&
-	    !ib_is_udata_cleared(udata, 0,
-				 udata->inlen))
-		return -EOPNOTSUPP;
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	min_resp_len = offsetof(typeof(resp), reserved) + sizeof(resp.reserved);
 	if (udata->outlen && udata->outlen < min_resp_len)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e02bfb1479f5c3..7d435cf5a2fdae 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -964,8 +964,9 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 
 	resp.response_length = resp_len;
 
-	if (uhw && uhw->inlen && !ib_is_udata_cleared(uhw, 0, uhw->inlen))
-		return -EINVAL;
+	err = ib_is_udata_in_empty(uhw);
+	if (err)
+		return err;
 
 	memset(props, 0, sizeof(*props));
 	err = mlx5_query_system_image_guid(ibdev,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 8f50e7342a7694..81d98b5010f1ca 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5533,10 +5533,9 @@ int mlx5_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_table,
 	u32 *in;
 	void *rqtc;
 
-	if (udata->inlen > 0 &&
-	    !ib_is_udata_cleared(udata, 0,
-				 udata->inlen))
-		return -EOPNOTSUPP;
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	if (init_attr->log_ind_tbl_size >
 	    MLX5_CAP_GEN(dev->mdev, log_max_rqt_size)) {
-- 
2.43.0


