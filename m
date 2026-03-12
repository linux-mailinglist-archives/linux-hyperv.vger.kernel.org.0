Return-Path: <linux-hyperv+bounces-9342-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FRkERwIsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9342-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:26:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF4026BA68
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7121F3177B6E
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB9732D0F5;
	Thu, 12 Mar 2026 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LwHqXR4a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B13330330;
	Thu, 12 Mar 2026 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275087; cv=fail; b=fa9sRIiG/8xd3vikhCYfWzPoqR6A1WiCFmqA9xtlj1SpmqGi8IvBrEMDbuWNzfV9RJDhjGNltmEn5B2KIXKza4/LOac0zlmSXpcE6/ukly1ocoJG7uX//MeppSprk0hV6hNiAm2459Xe6RNSP1pXUpWE2/zzgml6ZVRlCIuT42A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275087; c=relaxed/simple;
	bh=FsC/3xlrXlpJCkHPlVd0TAHaioJEZgIDrnSXbSV1Q34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TkmlvLrc2VtfL7RBXDz/P/Hz5P3wK8jgez9c1e6b1fJlPWDQLvIcWVD616aZpA0689vuuu8+01v4oTp244C9ahdoiU6CPs7NrGGuJwbFz3T7HbdjESi17fCjbjQ7aF5FXndYi0ZZ/0CMulM7p4S2H3ZRjvfWFEpNWIbQOphsTTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LwHqXR4a; arc=fail smtp.client-ip=52.101.61.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ru5vfL++U0rxqadaxr0IjUEsofl0a9iq9IzXeTJ5rqCq7RXqhjsI98fQhg2FzUVwFKkR5jZyt98/69tyjK/kfSfG98/w1ZW4JzETgCHEcq/XA8c3xw+aMv9Xxo7kmVy1I6KopTKV/ZsY+EmATtOlSzplU6lraD63s8O+iqVUEJLuBLbcU+jK9MeR3iXoDU8gzY3J/CsVkbYVbFL6WOzcZ0KPDAHOX/p86YEGigX6BU2+pdoQ8UO4Xdp3pxtKI07n2h2JDttDZtOMGMUjBMMhTE7yI3JuXSPRP/pcPfXL6GfuRT8f0/Bfo5tUUs+Iaar1PFg6VyyKxrf6dm+9xwJoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln+D5rseKCOr8V88d0UNviUHqx7Px9FSTuDZZBgofBo=;
 b=YcE2jDO+XU78LvwAn1Z5cnl+uelpGYCSBZATeZCMO5a++z7MRaIeVCCFz2NgoLhzcyB5KFtw8V+2wG12MMSH54ot7gg99bMhDJtAYeRp6LP2wlE1Is0dn6cZKhJsHlJBUQsLNYmHAOkjmpImdmmRR+TFnQ7AbXvdYmdA9ywKOR88Gnf02UxUJ1W4Qw0mXqylOdV0Wvir7Ctl5XzAmGQvO56sfC3CNv4LNgD+gkgw+a3YaAT2rwXmj0sjslMWUlucmgJQNay02HLRb7PWxkLUClHsEyaMLT/f0kCHijxWAgBIep0oQEPMqjoxYNEF+DtFkl9YBDXug5mRvTarNCRB1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln+D5rseKCOr8V88d0UNviUHqx7Px9FSTuDZZBgofBo=;
 b=LwHqXR4aIc5DtvLb6IvZWbdAIpFS/zp6YdtUK6ISre8AjVu9QqAAJJKH3KMxsqeRuhEIUeHFEnJg0IYhFJ4OP+rEcKLxc7/r2ia7IlD45RZvmjIIxOAfSGvRWY9rQeNTtnEhNL/NeQY2iLdlEMu7HVPG1bxuD7zYdlMVupcBqpek+iBnoBXctzbWRfRsJv8W2gL34a/CVhKeaYiTHDkXMqJShdB1Km2IuOoipTg7Fta0ntp4KaI80RI1s7z8EvOVgHwf6GR3VYxtrzuwCa+W0wW2V87GIzEFcrPasPpzeiQFDOANRYIoAHSVlZrMnPZQDUlzJ9LJMyXEbeylEOXgGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 00:24:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 00:24:33 +0000
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
Subject: [PATCH 09/16] RDMA/hns: Use ib_copy_validate_udata_in()
Date: Wed, 11 Mar 2026 21:24:16 -0300
Message-ID: <9-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:208:32e::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fe694b-33ed-4a17-e1a9-08de7fcdb829
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wv8+xeHK8flgvX+aRpizUAcvCp+WFZnk67C1dnd7sNSXnTO6PSrRE1ibRLwnL5hXeYlk++jmwUkcmU6M+jKOK2Xv5tVMUMISFKEi93W3zV65euBEYiJMmREdPSGm0QwJQ5ToQWk1ZzRPyGu9XG6ZjMNiRotpehGAwyHGWmdi7oDretWqP9viDVI/+mjPYFCei4fDW9nyScDmL3aHlGLsp8bePgakQ93zz1q3YVxcfG/gOQjRvo0C4dTa5ZlKh7gMcn91WpUZ+sSS6iMRksAL4s3uOHm57zj2ZDCU/kIvZAngZOWplbzBMbVv0VN3tvtQgL4pYK7JpD4G/g1K8v+bKs2bYgaAU4+ceY2T2P9jQo4O3J4VKEbZV0s6t1fWsi5JDzoUUJmAlQpkIbHtrwFBghMJUfChteNS4AWxM+8Dww7YJXefyOQjWuLWxsMGohTzzYGQuAg+vfUe3ufyYEkRSB7myqsqAKF3GJt9JIvGa2cAR0OMD8zXMq1rKS5dqIDur6i4fVEgrEBNOmsYvO/9pT1wfCVBdnJfkGE41qD2bb/Fed1NGb8Pkb7pmjsAUIMsIP3l/RQrnFePl0Cq3Zcfd8tV5WCwam4MIdCRi4WMoh3RXw7JCxq2X1aupJEC70BTtLBZlDEomzUNfbZQS/IxkbS20Sfzm1RP0sqWtiAe3ghcCaPKq8zK04mK+8p5YBSyz/83RcoJZaAj6j4JRNyPe34995lvS/Yz0g6o4DCwB3n6D8W2p/9MXDVTUPn2fOKDs6fNt0hvEbSqriq7xzl20Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TdAQ4XZM3rAmkEmM2ywzrlE3EFJKp70+M2fCRGSumsPrgY7NsPsQ5TucDw/S?=
 =?us-ascii?Q?JuucgpmcmzTNheNilAzG4Pw49vB3ACEE4nai1EUyeqn1cykewdOAkVINJceD?=
 =?us-ascii?Q?ACtEcMBPIXQL1iQpTGtvwGCAuSKUEMa8j8494x2S/jElkU5Xlpz7TEWbUCBS?=
 =?us-ascii?Q?WZHGDVKjxFkTxI7uNcLDyHVgkxlGlLKej605klqudlVCHwWLBAhJm86xPDez?=
 =?us-ascii?Q?Nv5ry9vgpbFAXMM+vUSswSMMXBTFzldREBmAsjZjL0RSNHyGtguCDsZ76y1S?=
 =?us-ascii?Q?gQLMEM/5FksUmfD1CrqzVmsBYsKfGmCumrJlbeSCptVH5HbD9zbblbQc2F2c?=
 =?us-ascii?Q?jvvU4awqmA2JsadmC6HsELou8qZrkWQmKOYEmonhpWfgDoIMLtBKxgeuGKnc?=
 =?us-ascii?Q?5UUKHyt1e9/XUYoUNIiAsBLJfPJ0asjSL1RtpQu/3MZtjE53RSA4hich86+i?=
 =?us-ascii?Q?8vvPsNdmu48A1edjQmcTCKGH36w1TEsgl3hQj63AJ8sqTa1BCD+3Tx9YjDhO?=
 =?us-ascii?Q?vcyCqwRD1RPmaQ+BqGsLcg3irymhgVxTgrl0J5ymyGFninL4oWPNpGaa8ROP?=
 =?us-ascii?Q?Kelm31d6bUbpFtOqvz6eAWD+2vhl2FCs8XMjDb921NKxBspB/T/NZH6Yb4Vi?=
 =?us-ascii?Q?BgrVnrhJIwbGOoEZ28Its27Wavn0CXzKG++KZe7AGS/x9JyP0rsWp+uJ08kO?=
 =?us-ascii?Q?7f4urvh8AdSV5oM+4q+wqFI3MDlYmA7ScUegpb4ch+wOYCBOxJ106IZR7k2h?=
 =?us-ascii?Q?+YSnx7jFdyCknCDHmasfUCn8sHck9VLq/gorg20fYw5kT0YqddU2bmKAdhUV?=
 =?us-ascii?Q?ZKLIJMAjzB61Iw1ocs1ghHp2r4njS55pUfDUbhsQk1jI6ivcXBrkC35HKfhP?=
 =?us-ascii?Q?P6vHO5lIQYx6SaQttO7BDl3W2i8thZ+lh39cvOXxActQqymVHxlLLb+yT+Fh?=
 =?us-ascii?Q?tua+pg2nntBTqnp8t4mXL/BULRml+/rN7vQwP1zoF0ijTpJRuWO8GecyT3DL?=
 =?us-ascii?Q?mrps0oQmj389/sDHL0CEUp5asuFxfMQ4gJRmQpgFfa8TP7sjrgb3Wl+w0dFF?=
 =?us-ascii?Q?m/e2WR5/4Pp+A0EAT6QQ+f6MuHnGI4R+cHszhiF/Adga/FSw/Hc0YrFPMPQF?=
 =?us-ascii?Q?W7zk8F04TgBRyQZvnZIeKTRNnJ1bhD2s0rtiOHcQVgnhnS0mpaPayX0LYPiC?=
 =?us-ascii?Q?/2j/XomL5RnkeRJpAbDK+kPRypkuWftwo41oV6E+xUoa70yGaVjuz2OF8RGU?=
 =?us-ascii?Q?JehnegEBWu3AbPCwQ3kTdal+enQJofn1PneQJ2gO+J5uVUpAeIKYkPtzzbn6?=
 =?us-ascii?Q?FvBk72kaZgYsoU0kEu904eyvUtC4HXU1L9XO30RtWnRyuHOt3jCyLpflLAaI?=
 =?us-ascii?Q?gN6OujbbVQSmiSbLAFp4wCWbHdF4t9ueewpojRDGv/bDBs/ZURQRvsqIc3Vd?=
 =?us-ascii?Q?m5jTpiO5IWbDuWGBDD/G/FHAbEE3gX7+MiEUhNV61Lsolqx+5xDIWdoT75G9?=
 =?us-ascii?Q?7awSDD3Ua1Yq5ytNXkQWzjsG9elKtjZmr5dPf4vw3PTZ9rMJmJeo25cXZ8N/?=
 =?us-ascii?Q?R9gwQaY46ej4NAKNcCTGBpJKS5HFov1o/EqLfuozeqYyCs9YQOvVFVOj9y0U?=
 =?us-ascii?Q?cRq8UVzYtNpdLoF9Y1DouktKlwH/M3u0xXI/cgGgW4pSL+zPAfGgR2ZAVdzL?=
 =?us-ascii?Q?BFghe/tgEOfad/diBbtYZIi9NBTHM7qOn3TxX97AUIgt1Mkzh5his70bKWs5?=
 =?us-ascii?Q?wZF2E5O/tA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fe694b-33ed-4a17-e1a9-08de7fcdb829
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:27.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6LpCXZjrP3V/qXCkTNH2Wp6+UC22tnNo0ZLvokTSQrG/t2/tvccz3xjjLA1GI+j
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
	TAGGED_FROM(0.00)[bounces-9342-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: DBF4026BA68
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


