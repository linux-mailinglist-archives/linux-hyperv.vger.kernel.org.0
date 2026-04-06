Return-Path: <linux-hyperv+bounces-10011-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPnCNASj02mMjwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10011-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0593A335E
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 813D13012CFC
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB473358BB;
	Mon,  6 Apr 2026 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sjTV2dXW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADF23358D3;
	Mon,  6 Apr 2026 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477502; cv=fail; b=ZCG2kG7sGIo5mdzaUq9KA8KsRutzvulrRdTsYYckUd5cTxokWkXALV2Yf6BV1GE6aN9JpDCIejUaLU3j2dfu2j9eRRgSigKdHiN1yrxxdrCNyyIU5nTU4mtXot7IaA+S+iZXQfgd/cP/fe/eAdGof246bj3/8Ss6GygCUqVJhMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477502; c=relaxed/simple;
	bh=JOPmDwBzKvTICHIpjHUWCYaQt6Qasx9dliVclKos/0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pS4kU3BeNLByCrR1p2MD1xKoOEp6b/Kyb+jyWUqoDkfI8V4QDoo2MgltHsH4MDCcuFNea6j7TKItoUqw9moHO/xyN6EC1eNjTiGgs1M9vdwYTKAz0PobX6Yjlpo/9M45qrF5nT/MVU+i8FL22HuYt2+5bK7zG9V3TEFc4lSa+dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sjTV2dXW; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEqnYbcLJ2sOOhGuf7OG7MEG9RCCvXz8i2tlmoktb/RBtP22NsG8HaWi7r0bZIrN71M1d/jb6/UhrDktsbEd4Zf/9nnhZ9D0XwobU4+IR8/oOrk1EDLv4hEkb+FyTPD4kLMkPuNkFzi2CGc9yheeb6rrGh9lYNX/aHH93fBgB81TuggOfepDUnTq5+Y0Ol8Bm3b9GCYsq7W40x+mIF2SZMJD+PLm2BO1kevcCTf8/343tpREMEhJj2Mkn07xEBwuuBwwKRnD4Zd3SZtC6zwHu3SaTcMUzfDj/bv8pBz06XwER7vlqe+ygF+LwNXcIIvyKJPTOl2m2iqjrNtVK29XIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqYDwQgD0XqbzmsCzcs4P0cOSOTcM1QPPSnNwmer2UQ=;
 b=mAwCmBSR7BG7M4eHx44JrBhzlG83KD99Vca2c9paS0RI7RB2oaFf1bwk6QJQP1jqbZ+ufxcRzVua9Q69+9o0qE1pf4uOr54ILM1W8Kl67O+l+U8JT8aZL/nX3WwzLlEe1GCextEZJPpE2Bw3B7t/ktP7rBkY6Liz2zAxrevCMKEAzgal3vjF8G+HbYqGWioRigHj+pqp/mvJQC19Td3YC9ScVAvScF23QJ5Ri2WTMExUBY/+HwRoL95UXS6RVtKbl8z5G1Tde0TuofWvuoeXRLnXkpgeOi6GTKV15yzgQfB1uIUCxHXoeZ+1mA+6Z2VfL0SUPVJWBWG6AQPV1YcipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqYDwQgD0XqbzmsCzcs4P0cOSOTcM1QPPSnNwmer2UQ=;
 b=sjTV2dXWZPdcAg2jnEDfqxfNj+cKjRPyqdkCnz0o5x6VXEAMvWAIN/gLQ+vQh1bOdCvSuQU+lMFtUpGyHzuoxlkkz+cwedRGyAnollLfwGp38zlBJFJtQrtPeVG9r/VJBdrhi6Yb8pWwMlZ/JEy6kvbfoPS1TSklmwztw0556zkq8qkfJb5+AjndPENihuVlO3cNrf3hp54AbFrqjmAvncnJu8QevgyRyar63+PjSYVnkU5xopNx4BdGTkLRWH5qWaH9sgFtdtOQTZOKcdrrblgUibGBzpGMc9TdwfFis6INha61PmiHQt0H+ZMLMmINoCAGu/dA31/Akn7UKxW/Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 12:11:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 12:11:32 +0000
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
Subject: [PATCH 02/10] IB/rdmavt: Don't abuse udata and ib_respond_udata()
Date: Mon,  6 Apr 2026 09:11:16 -0300
Message-ID: <2-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 81581816-c159-4100-ddf0-08de93d5a168
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	kSokSkmnSwgVh63IFmPWVmCcel2egIEHCMHVIHpjt7vtK5t1ASXGmYTYuhRC+hyPyvwTa0b36lRDvCnBjmLNNeB8sM22uIPTQIhgaTnLkUVPIO1a5rDUX+IfX6nsRO7T0htVrwzricoYrz2w2FtVsi6rwsHdA7lAGQN6DRuk6XmEPL7/zrFRKDebgJe4G1+V7PeJUqquRbZWFSH0p+Mzg+tirDJpcBV5Q06fKbX0cXhIoJoGFyEkoYw5oZ8Pq1WtPlbU9WTlOk6OnswGRLGwPl3TfH5Px+g5qOiW2DNLJEmZU58RswROkb+Vw1eh22DeBOPvqe9cQHJKm+vddgPF1tJLJASgry5XrO+5l8R19xW2qTbIMRO+pOgo0tvIDicec8bJ4j+K8e84Ilf18V7vuJrKDaSNEPj/fSfRscI50b5HCFJSRuSIFKMobkb/LRHTeA2DvL1i36kFYa6ba+zOYR8wHl+JiQUpT5rII3AVYYFVm0XqoEg0hQ4bQfL1u2sKvKFb4Hm56BqQse4yEDc5wgSasO6In+VMho/WMza+lOPlmyDRfD6tHT9v81AKd2znwMbQWC+RbvV1zeli6jnqgq2nFXIeKWjROM/u3yNlg1y2IQQ1USL8YmbQ+oF0NCGfH7NoBfaSutA84gORSfC8eT8I74Kqkjoqtv4z7EOSfRLUEL3G47ZsMdSkQ5LJXqHUv3cF0aVCNmVUlqvKbCrFy3YY0qZA/A33c/FiMe4GDL72L2juGrkF9CIH+bsycYWQ3oiuEaaNfPK3rDd+OR1eXw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WVspClFlawd1a00hwpW0nkMBUaJXIPoalWPegFJzFKF+YqSNhMnsvgCO7/Qy?=
 =?us-ascii?Q?q65Hjr/uYwe9raW8n6iEjxK8XKMDl0SATtiW5jtsSvFirvOXLjAN0LK0mt8C?=
 =?us-ascii?Q?RNboM3JQmnQVqhz7CAKCfOFW8tnsQ9kCzqUNX9IjWrrPgRtvDZI1o10gqsoE?=
 =?us-ascii?Q?kKdkFPqC58nKI33x3PT3kM544hIaOdAS+6nkb9rvnztC0OAnq+Ml9Ywh7mm9?=
 =?us-ascii?Q?hKdbpaZpDjnELmyvkaEl8upfK4Qjd5oqciTvaHMXaJIQKhjUiwDdpfZGjubF?=
 =?us-ascii?Q?DKxd1NFKOc76I68suJ74/IwCxE9lKgR1TY6snY6OAKeKdKAnyJcoJuJJZEK7?=
 =?us-ascii?Q?U6aBkMqIrmIli+kazsPo6IUqDOWF6DdeuKNtvWymufMmeoKkVq4LTgRB57KJ?=
 =?us-ascii?Q?SGd5cAX+1Mc+SxLpJ/eVpTwzwM3mrb5NgxHwnPDwTL8jrql37v6q8cq4IW7c?=
 =?us-ascii?Q?sXixCUg1p2zS/7ua/+0BgRHrltgrgjvhAg8fNyAQdlGxYv5bsi/RcpGOYEOw?=
 =?us-ascii?Q?rbVVtUMRnNVG58diCcFaqcz0Jbm3vdzeXDVdfsi8Z1ehBZLU8+r4e9W/ZgiT?=
 =?us-ascii?Q?qM3++RNwSOBQh6sjgKRheZMpu4v2kwN51OhaLkWkea9jfTQJvWvY3vayE85t?=
 =?us-ascii?Q?H1i8bcerwfRVa/fRaUExWFqe+z0IxiyyNxLt+ID8U6D/VELQyE54lSnzz0cZ?=
 =?us-ascii?Q?zfUQ4SVtB1dGcYEUWVEAfWUyMC9cwuGFzg9eIRX0t3LkLshZBHhekED4j8zK?=
 =?us-ascii?Q?c8RCNLron2kAlYRVJNRd5UgHR1ZNExigCls6R02L9SgCqkGHJSi8Y5FyY+EE?=
 =?us-ascii?Q?CRjaadI+z6KRoHisXVoGnKYj2Th+LOk/shmNQlc/TxMK/coozKrbVIqqe6b7?=
 =?us-ascii?Q?QbH/90c+YdgUXtlyfR8ASvMd+9HCxHcCHOBfWqp7wxGE1q/tmdDSnrsCFYc8?=
 =?us-ascii?Q?AFInNdaolKUJqeUckL3gaOareDohNtSv0VeekkonXlgkUPbqffcj04n746vh?=
 =?us-ascii?Q?JFBhwqCa16cyOSqrVciMnQ4bW1Qmf8g5xqYF3LaMX6TvVx540ks+2B76nmIG?=
 =?us-ascii?Q?pSlT2kZkcF9kttAwnz6n93sy1DDyEmjRzttLe0g1dBudv5Rzi35XS/ABvJiy?=
 =?us-ascii?Q?UkvlMiExg9WtUxQl+pj7Vz/yFbRpEaAusHRz0WMRdLmY/bOFERsmTAIwDqmg?=
 =?us-ascii?Q?W3Od/7SsjzS+pXvUHDqV1gmskTPG6wGob5XQbzhuYdIcjXTcvJvGdN2GHLSF?=
 =?us-ascii?Q?CEf6R+YJyTQfhTayAjGdvjUEqsQMfoNc2ILQQuwByMbrkR7O0oFa/eR3QP5p?=
 =?us-ascii?Q?55TIbzk25To4d25ZOlB7w2quj1kVI2WARigUJGeSXOxL9Ww52SGj193k9FhD?=
 =?us-ascii?Q?YLzsAy5LJBSnO3Gl0ePJDJxlqQYMaiR1P5dQUZKNIWtZjVivyHn1YSYGosT0?=
 =?us-ascii?Q?d9kgtQ1dR4ZieKoufNl8Xx//rYfNLtbmtOTIA0lPOk4IuKQcoGVSMblEmduV?=
 =?us-ascii?Q?xzFK2WnYyI5UZVhhD4av77NZBdDl93sq16CMv+dP95qpsDGV8tVzQzW9XVFE?=
 =?us-ascii?Q?ZMkVUuwcSDAcpk71cfjyAGuJZ45yVuHxXF+d72879rKkDFZgfOng2/hQOxEo?=
 =?us-ascii?Q?iQIyYNI5XMj4O9ADy1Dw10cyZqTqQAZNhN/DylZ3Hem2B5NysTwe7e5UcS0o?=
 =?us-ascii?Q?rf4ER3/3p/M8PmRbVDLboXErKmiSv7FGGPe2SvUDQ64kJWMo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81581816-c159-4100-ddf0-08de93d5a168
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:11:28.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cozU990vVrt/LytfYJ6C3dopE6TCSda9a8A+fZUMYSE5uhkC2tvvvWttdYaqFaHm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-10011-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7E0593A335E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use copy_to_user() directly since the data is not being placed in the
udata response memory.

It is unclear why this is trying to do two copies, but leave it alone.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/sw/rdmavt/srq.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/srq.c b/drivers/infiniband/sw/rdmavt/srq.c
index fe125bf85b2726..d022aa56c5bfd5 100644
--- a/drivers/infiniband/sw/rdmavt/srq.c
+++ b/drivers/infiniband/sw/rdmavt/srq.c
@@ -128,6 +128,7 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 	struct rvt_srq *srq = ibsrq_to_rvtsrq(ibsrq);
 	struct rvt_dev_info *dev = ib_to_rvt(ibsrq->device);
 	struct rvt_rq tmp_rq = {};
+	__u64 offset_addr;
 	int ret = 0;
 
 	if (attr_mask & IB_SRQ_MAX_WR) {
@@ -149,19 +150,17 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 			return -ENOMEM;
 		/* Check that we can write the offset to mmap. */
 		if (udata && udata->inlen >= sizeof(__u64)) {
-			__u64 offset_addr;
 			__u64 offset = 0;
 
 			ret = ib_copy_from_udata(&offset_addr, udata,
 						 sizeof(offset_addr));
 			if (ret)
 				goto bail_free;
-			udata->outbuf = (void __user *)
-					(unsigned long)offset_addr;
-			ret = ib_copy_to_udata(udata, &offset,
-					       sizeof(offset));
-			if (ret)
+			if (copy_to_user(u64_to_user_ptr(offset_addr), &offset,
+					 sizeof(offset))) {
+				ret = -EFAULT;
 				goto bail_free;
+			}
 		}
 
 		spin_lock_irq(&srq->rq.kwq->c_lock);
@@ -236,10 +235,10 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 			 * See rvt_mmap() for details.
 			 */
 			if (udata && udata->inlen >= sizeof(__u64)) {
-				ret = ib_copy_to_udata(udata, &ip->offset,
-						       sizeof(ip->offset));
-				if (ret)
-					return ret;
+				if (copy_to_user(u64_to_user_ptr(offset_addr),
+						 &ip->offset,
+						 sizeof(ip->offset)))
+					return -EFAULT;
 			}
 
 			/*
-- 
2.43.0


