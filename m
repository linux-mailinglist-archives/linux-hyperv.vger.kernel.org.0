Return-Path: <linux-hyperv+bounces-9337-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AwPKAQIsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9337-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4272026BA3E
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94594314DF3D
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B89233C532;
	Thu, 12 Mar 2026 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eagd1vkQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC53375C3;
	Thu, 12 Mar 2026 00:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275083; cv=fail; b=tzt6yl5qUqUu0zUDxjqHLTks+RvrwszbAy/Bojyyd6louy+F2OQG8zrVCs3tYctJaLh7xDUorfz6xiV6Jc1iVDnQ/4Nw1lh385McBCNboeyJ9jIMj64z2um8kOsH1IxEWpFaAh+OYSGJL2d2rUzsm9/bQNcwTOHqVWTTwFGBJOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275083; c=relaxed/simple;
	bh=4Ys3LHBfjvrdIE6IXfUMeUD3hXzt5T/+HChpe0/L1P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u7gm/bzUd6WLxVVnOgtJb59ANzOisQR3kxlM4yRAKQKO6YduqqqQKRUHm983VS18/8ASkNT9FbM3R9d1i+kkGD7fEfAGAk8hvXfnB5EAOUsFdO/DlIEgyYisBqDyEotoHNYnjVY7u263CNQOtHuNcAabN+dqGziG6Rx5xPV6qMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eagd1vkQ; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8KTSjDWIE4rBN0t5FXWgUEqWXity502oJEQOc93rzfZqc/9H1n89kRwGiDygTUw6y0KYGhVl1jgvUNOPpWgLoTUP4qgjnxN3Sjkld08GpHjllmNtFrOIWJ5qrfpw3iePDuTzPLJ8LYFfrKWSy7f7vbStBkQWYd4FuDiLhWXfgYBG2bWkQ3EmkkLClLl5F8hoU4VhrJLZz/3zaJX/I6EI+Pu/FO9jbPnJ89Nj+t2+o6ErOSt8HkyqYNy7SyV/I/tzNjPKKKwFzPThr6xwz/Oatql5UcpCd0jLt64HMH5We1f/WA8ichqNEox93lby/IVGgvE6AXZfqsLxgtyuOreyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/eYpyT76X5Fm4J9jFv+CQVPWZbj5wWrMQL3BtYuAfw=;
 b=TmfMFFL+G4DVeAe2zsqMojYSCpy3sd2GJ9Veen0dJbJeHstuo6JoMd9Zu085yndsvR4PVuWLK8EAGSepUZIEjI2t+/FA2JBqgUEWfZLo+xamSYepuri85bziSnQ3ZL00gPSWNEh5yTtLi6JyEz9H8pYJGAX2vUEAeczbOl3d0yo2oITrpJNKE9GZEurhz41223ZeiXhls08E03E/pg1gKdMQVkWo9dMvRi45RQnyLSCI5kHRqBHswclHRd8TArhox4tbyM0Venl12PNjipwUQU7n57nxYsbXPKfINETNW9RymoXvSe5lR73Bd2Niw8CgC/mExOb8OOysUwZQRqB09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/eYpyT76X5Fm4J9jFv+CQVPWZbj5wWrMQL3BtYuAfw=;
 b=eagd1vkQknpn6dO+AY6qmK70UNl9LhZW19oGnYyQlR41LurrqDyz1NRlgy+nQFtNQknqDutje6h36Lto6sUhcxtCS3OkYHSH98YsCXEaW3BX60ZwTtnXCshSHA4JTqKmWENJI8ieW+q0Uk51iSD2cHOzuYiwSZTOms/jj1Nq/jXJfHz9A5l64krrPVWFuVCz1C1OEh8z0J3pQRcvYahJQgrnnlHg5aJoLLdZQVCZ3HWVwxqtw88aaT7ONw75dFIJ5adCTrCYkHisMF2jZ7ZWxHBjqs3bW0JWebs5O7h1q+oUis+/0dHBDWD6D0sQTTx4VLukgZ99xDLc5OW9/o3YYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 00:24:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 00:24:27 +0000
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
Subject: [PATCH 13/16] RDMA/hns: Add missing comp_mask check in create_qp
Date: Wed, 11 Mar 2026 21:24:20 -0300
Message-ID: <13-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: 338f05ee-0f04-4b57-b8dc-08de7fcdb75c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GBLBnW6hIxb/+NLxeLwJsPIFGJTe9AbXr7NuVACRDlp4UuwGNUPN3iwCQSm2TpaKiAhbATGZ+rw5OYoVsD5X/UZO0JyCcRqD2wSw4sv/Vs8tpU83CshzZujM37pID/JhUbzXhk4GjWH50TQ0ZFvRtjHCub97mKaF1cYDVANYim7ycTjPzMf+zbeTSuU0balHTnmZntfIxC/Swt6Io3u0zn2tVuQ9wPNg6AVJXhGVTvOdyBKBsiZCsC/GbKG6GRXWcymscfuoaiVH5C0iToVGlgzoOJWv8ylVvmgiM/N42ON81IE7GpmboIts19P7wiMhW4g/HYGyHWrqMOZ5mTfapyEqrdoeKwmrsrlSAAAyb569Z6sgPNFm4WGNYMkdPr7y9khCB6kzMa1TdI03RsoRt5+eSm+NF8JOJXB1MYXFzp/lSo8gwVmnRQdnqTrQxlQA1fvXDrvKfXsGAFwtg77ZqSQJTQMdsuEqG4tESWI+drAlHkhXPT8/ghtbsjdVZzvnR2w9+UsIP3w3m1IhGV3x86Dk2ltvNmPlEmJ0ia9KSwRKt357Bb77sx/PdhWd0ijvMH1TtnISgkriiz8i5GPc7Wh/ILm2ACtBAlK/vnJWI2Oh+pIOxj0L9QHYPaEPj3jSvv5uErCke6bl1R8Iqo1ifgSO8RsTOB4XSBVKMcWftAlAqC8Q5NaUM9aXIkXOlGV/fKDNZzTEDqNYLH5xICUK2zC/A0xxoeAZXVKqBhDMW7oqfk1jO0/+jNZu9DmRMK3i3Rx4fzEJJ3UKnCvJC/+q9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2stuV7ZgCzbrDG6oW4UsfnAIbtz4TE8ve8YITuzR2vx017JL9ggrKOTqDit?=
 =?us-ascii?Q?XRAW9Fc7T8XIGldpPtELHag2ki3xAnI8xp0Wl5Obb7XC/k+sMKDDrlAkm0qf?=
 =?us-ascii?Q?rZUdxzob6K2SfeoLzQ98KQ0UQujGjaOFR8P/FQ1QR63akr1OVrPXFfY3MLsn?=
 =?us-ascii?Q?hVymPTADDpl0u+n1v9/5a4bTwOlMcppB0O6UtXmuKoEnhd2B1zqk5ZdiHiS+?=
 =?us-ascii?Q?DMDNJXMiz70cQcaBiZ2IcKH2nS9VkGvZehqrzAT/k3UX1enA7o4nUohRLvsq?=
 =?us-ascii?Q?2FMNI9UWQJPLWNTZOpXF6oCfA0Oh9b9EiZJwucLf0wUgqcU8nktb7wbuJ9kK?=
 =?us-ascii?Q?4TrQRNKW3zRwHgANz+EnGiY/7eTjJyP+6VgcBtsSFtcg1IkSPLsVzs+hJFki?=
 =?us-ascii?Q?aKraZdRCES2BxCLVc5Gc4f2V5ggc1H5G3B2REND0Bhf0FfzHfE/cRR/rgiiK?=
 =?us-ascii?Q?ghBqKeMGPWg6X2Tfc05vUbt8bKUZ2OPfv9zzqUHC3MoXNzx46aU74KeJ/myh?=
 =?us-ascii?Q?LmBKqgowfV2NbJiePJqKpF/HPbpJfYqZrmjWbwJQ+ONTM5aF6VpFHi58ZRL7?=
 =?us-ascii?Q?8j+E9L5LOwqcpAtM6fsOC0YCPaz/XmZapoY3cMXZaQnwloTVN2cCfDi0o37R?=
 =?us-ascii?Q?md6sROyQFh6oSokwJve+B8el415RZN/bG2CnZElp1bCP+t+KPN/px8ztUjtR?=
 =?us-ascii?Q?5n+gIi0qEPFyZ8h50nm8mRT95keF5lN33bhA1kgoTczc9VDh2Psh6+ni9XzN?=
 =?us-ascii?Q?EzuVZX2nntrSUSHfuMMFtvCI61LEJOFjD7w/dZCh7T9n+1C7d8BwVFHz675c?=
 =?us-ascii?Q?DclziTFQ+mfkGAn3sCLxiiNQ6HY/kHhnZJ0+E9c9Zf+XMeQWI+XWzh2Ea3hx?=
 =?us-ascii?Q?HdUmDlZ6aPxyPlotAUi+iIvDGg/XHbekPO3mHCjmESFGmteOBqEF2+him2yz?=
 =?us-ascii?Q?szFNSSjOu8N+LSRsNdtzy4uDmGRK1FS563g/ReM+ZwWWLm3twL9CvS7IBGkE?=
 =?us-ascii?Q?u21o3MSxbSltnKC/CS5GOEgWoad2CdvvEvBb9xKtgXXwROVQRn+JQtO1FO18?=
 =?us-ascii?Q?CztmiUc3k6S64+fzE2yOy5fOCAjwCBpSYIjH8kMXxua0QTAAJ/dmn0t0jEsS?=
 =?us-ascii?Q?SeBlILa6iOLU5dkZeyvhMgkx+oj2Y08HWkSjZ+ZD4/xqEYhyXs0MGWLfZhek?=
 =?us-ascii?Q?fQfffe4B0JxhoJBxCf59MHWgfxdlCYexuckBsu93nkoOdb7EAep63mbThTTy?=
 =?us-ascii?Q?u4sWoS41n8jk4hcdSiR3G/oCqOgP3YvDsUSwpdX4SwWbDseEqnXHAovTDl+X?=
 =?us-ascii?Q?6AQefOVlkqptumdr74UQSunJmZdljkhYqaB1nt6opXcOhLuBJRajnCXdiOcz?=
 =?us-ascii?Q?/oCxfUqdeEO507Gjijd06XmEG2TU1QWJ8SSt3wUz26B8c9wR3hcZ2harfdH+?=
 =?us-ascii?Q?oniaePlstQmAQdZaWK8RRsTd3/oTm0rKas/FaaWNhWCzWvmFg/c/7ZhngMd+?=
 =?us-ascii?Q?BPljgN3eJPgaACbjlGcc+ojI6ZzGD44eBEigDe74fe9HUjxP6xFCsF1b8rw1?=
 =?us-ascii?Q?SmfVSE2h3YlL2ANQ0MM5xtbhPMqhjXoNFotf+lkFD57lnrioYUd2eO7DDIeJ?=
 =?us-ascii?Q?hBqEjPpxK6IPcBbvevIcAsLHCZBZgkg7g6RvOLXp0xTMhOnGH+uS44G7gt+D?=
 =?us-ascii?Q?WjbzocLeSe+w2tLBls8U+2ceyclEa8VZTdAgx49VhsKcvRfHLIrpnOO7MRCR?=
 =?us-ascii?Q?Hz01zmd3lQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338f05ee-0f04-4b57-b8dc-08de7fcdb75c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:25.6662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqiEYNLgFLqdidEVN2aS5ZtoAxEamA0QnCWWSGof3eg8QkX+oy+Ns8FJ9Iq0m/K8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550
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
	TAGGED_FROM(0.00)[bounces-9337-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 4272026BA3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hns has a comp_mask field that was never checked for validity, check
it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 3d6eb22cbcd940..a27ea85bb06323 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1130,7 +1130,9 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	}
 
 	if (udata) {
-		ret = ib_copy_validate_udata_in(udata, *ucmd, reserved);
+		ret = ib_copy_validate_udata_in_cm(
+			udata, *ucmd, reserved,
+			HNS_ROCE_CREATE_QP_MASK_CONGEST_TYPE);
 		if (ret)
 			return ret;
 
-- 
2.43.0


