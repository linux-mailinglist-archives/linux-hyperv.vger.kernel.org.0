Return-Path: <linux-hyperv+bounces-9790-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHuJElRTxGljyAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9790-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F188032C709
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CCD3302A7C5
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3782A390200;
	Wed, 25 Mar 2026 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X11vU8Xs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8738F925;
	Wed, 25 Mar 2026 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474047; cv=fail; b=nYwbVBhov8qZDxlQB145+g6Vnv+MZx+TFNdKaFud7aVeHQPXzaWGsNwV4BMwaiTk4O8i2CEI8w6Bve+gOmi+BIcekgHJjyPd1mw93wOBIFLrWS2izTqjGVQ2N9jAVDAjjbxM7E3T15akDx5Qe1iLh743h1Ocoe9FwYARYVqiPiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474047; c=relaxed/simple;
	bh=vAa4YCAv0jPT86qjQispAt2OfSHr4rtRCeODmy0QOgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N74Hx8NSVbs0prUhpzGBC/gGMrlQaLzIfKlm6YD3f7nNDoqqMkCbrDtSGvM0YWC+82/L5Zs0KzZT3RDmqHmgTZxp6rRbkystElcTauF+9HQApkYHiZM6qanOMrI/+uNGMa4eWSP+FuoUZVxg8xjI2ABzydFWmYT7ohDO221TiB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X11vU8Xs; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIqRhcxQ7NY5riVrvFNgYaRguL+q52axbUYO+WFEThF0/gQM4tE5dbgtMrd+/LdT6QKFY2toCIvQeXOR+4ie5tBH9YstCtqUZxECxnwQRW8aJsgwp1S7JLgoaf6tVoBVrKN/v7HfbAuCwL6lHTzkc8dllgSPZPkStD8h9zkzCL2Mhvt9AoMrJbjMl7l+hJpGuzNqdVXXolrjK7qaCKlBlGVvm+q/WTVj7tbts4snnkFacOLzaF5Fqa8bepoY9aXfUxSlJv6++m6Pzd3eTvaiZtwoh5BtuKawR34ypWiFLLau5yCDHe3tZmGlWZaFrW8o/YcqO4z2PZDmKmcEn6DJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r73lYW4sfarEwLgJsZGyLPkalWJLQiWotZg8fhy1TP4=;
 b=DpOd3J9qE3OPmhUUalXUXeEkPsQ/NqAh0zTxcAJMoReAds0C0HOEjivgGBjur10bchC50EpLxRztDoQOfCFVPywZlZgOI+Ln8+1ehdbT+TqXs5S/lPTcOyYot97mZ7JcZkOe2m8h3OVIgnS6tfctMya4jicn8tHRXgYNYh0rDjyIQ5h3adAbhotDRRekPeAYIFgjuGAzkySaUdx9K3pfut/By7Voyw/s6pFW0AESVqccaTOuv7jlkIX4Dk+2t05wnHUKOlseY0M4aYcfA43gs1TZJsMmp6tOOT2uha50im1ZTu8g0cAK2NfyZy7qccwt0sG08FSnGGhSqw00424SdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r73lYW4sfarEwLgJsZGyLPkalWJLQiWotZg8fhy1TP4=;
 b=X11vU8XsbFwumBHPl5wLl/z+zNshgPxlsdBPZGafYiFXeYVoWt/Knx3cAeKMmJndlkO0n99R+ZcM+QAhnxazd/pazs9ufviZaJAiZLpBi/Ccu1QOouHf+GbaSeVZIFTxzEMGFkGJ2NJWzlbNnRkc57i23AYq/BJFip5ZgQUug+/q5PZNbkWaFk6csxSyvfTekQc/IXkFRN5wwAnwcWVHH388DOKSMrkG0IiF0mpT0LpMd2aQO5q9FAhm29qV6uXFiu6eqbOjewBGU7cG3zuOwn4riVUt9AShGIHn8Ah1NiIBxSh8uTy+Lv6d2DOvKg/Cttyz7yQzjcsGfplBOmZerQ==
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
Subject: [PATCH v2 11/16] RDMA: Use ib_copy_validate_udata_in_cm() for zero comp_mask
Date: Wed, 25 Mar 2026 18:26:57 -0300
Message-ID: <11-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: b90d9b81-5580-4cce-15c6-08de8ab5435d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	35JyvauJjvzZOF5MHzpBDm6tpQeABgjRx9Lqtu1XHnMSi0GFeM8FiF+0L21LotlRfMFSxaaEvo2+IjQwHX44coBpSZPImAXczb0zmA6NJFDTWfz1rdgGPWm+kW8m2m7ldvzR7OJv14P9fJvAA+E3fNriyeydAnRrstkX3z5pyf2sjtMBtNQQrNb6S0seQuVu+WoLFFCKWgbJEMFOEQAlisPq6sItXZgIIO9QDN9DUm6k4sZ239UTPpUOmQdP0qBoShjSfBIbNqPrRURtKFkgCtI7YykTg9uWm5yZ3pfJ4q1EX9KROxT8elNUFly4jjOv5oqsQJSSNGrBHHfG7qgYQwVpu9XGcU0UEuXPmTdLBcqY8mspH4BX9e5tlA0ClW2JUR0FqJDd3o6D4SKzNeXhF+Xz0OE/eaiGG3HdroPDydOB8WH40X5vhKPcol26bPwYXk3re6bDV1nbyIOtlXCI7l9lZCI6ik8GoOJ+GwEyC/skxBFDTNGyQAFOmUiU8Dt7tQ+hzx1tMmbo9pcZJR0b5B4HVPNmQLQHHySEdYJO4PfAYhd1KMYOUiklubnfzD20aiMg8AJXFlwobNKcd82TusYQ2efCCC4hhWpVva2aGDBl/mK4PCucXKAxoc5ilqUREaNAwXW63bHvNrdKBsq9xoUv5vJn6d6cIoyMS6XwFvsHc4Kl/cJi4D0TbJdakt904nKDktxvOivHuw9aTHTbAahx++2C94UAP9l81kQigClppvxy+VFj6QlRaRc3odHJrzGDX8Xg29voI3uJwhA+SA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rjiFtypn38jRfY8FMLqPOmwDCtTGwOi/0KIS3+i8Lghl4odbK1bzEGjjbgiO?=
 =?us-ascii?Q?w8J3ClmsG5sReqLpFw/3vqtCQBp4pwvKWlmPQIzQvh9CGhlc90fpwMAHRTaH?=
 =?us-ascii?Q?d6zHUqvVvBofdcjuMRl64nBavN8i+0okcoOlOftHShtqWMBI5KGiEH1nLqVZ?=
 =?us-ascii?Q?8lp40jk+ezpC+9TJzHJrndtYmf3yAMw3QNE5Y/fayeMBREwza5BqTjWXV3xd?=
 =?us-ascii?Q?+Z4U2Eryd/+Hvx4v4f2Ocr50pCRdnI9zJZDpiCeddDamd0n8C7qM7Ueoh5ss?=
 =?us-ascii?Q?xnlaIbqbDwp57IgKF9ulXtndRi6pqgVMCKO392K2t3rWnFtbHMj8X+XiNPpn?=
 =?us-ascii?Q?z+gvUxGLxNbhg4UIye8G80KCa3U+vnRtU0fsPWMQtgAOW5TtPj9VL3qPiaHh?=
 =?us-ascii?Q?gOTnbnA7t8uksCN82LnY7X2NbkxksRoXhmc9qIYYyMpuK4HAJpz7AGYYtym8?=
 =?us-ascii?Q?TPAc6pa/HYpTDRM+K8aPZNohQHQVmn+bcj28QVHrfHdz2exos7g8bMvddoVf?=
 =?us-ascii?Q?C2j+ZTVkUthvuRM4KrgXnXTfSlif8zdHuUz9EugX2umpKusXmw4m/CB0BOxU?=
 =?us-ascii?Q?BX4GwOcwuEYLYG9v3UWM0r+POSq+dZeRd18mxN6shpMMUtjVtK96hWlZAYrO?=
 =?us-ascii?Q?4vfAm1s2btuE5+k5ToUPi+/4uzF1bg6PtsbQY5Fwb5jUXYkTjttbGISeVOQ1?=
 =?us-ascii?Q?16y7e+qNxvc+77UBcNcCQiw5yQDJQU9cs1boZ1j+vRJrtONIm7O0qHLWNmBm?=
 =?us-ascii?Q?WZu99ksNyI7hJ9fFcT/H6iX2p6lhG5gH95ETis56FBvOaN9Su34B+A7qtGST?=
 =?us-ascii?Q?HAl4Iw0B8KiKlsmtEqTAVI6eMvvQyiSHGS26NztdFlKit1vwwy2O9KvgCTE2?=
 =?us-ascii?Q?A3wMi5PdJUiZGo90i5/kWNtuTFTmUfJn/2GD79SnAbFF6mAa/8pJRjyiGL0D?=
 =?us-ascii?Q?2owSuUxbW44p56KS/KkGhqDp/zaibryIcG1lE1XeEc/6kQqqHch9mSHrQ7DC?=
 =?us-ascii?Q?JhAk1Pldy5kVdEYh4oL9P/7SQApPaRpivjslWxl2XIHB4dPYTheZBh5ydB9j?=
 =?us-ascii?Q?BnaHL6KkTL2otiTBpilPkQs2Rmuh6rBriPzJUykhHSjhlJhDLe7qxo4vuozy?=
 =?us-ascii?Q?pvBR2i35cwVmNbmCRW9PCuFk46fcs+HvyA0K5JHUAzv8gYY+8YZFRLpR4Ra9?=
 =?us-ascii?Q?RTlKg9fw/SnzyaAjXXUCXy6s5uQidYtDaOtoZ1HJSQR125EoT4/J33KalH06?=
 =?us-ascii?Q?SF9nKoX8+24ciiDuBOH54NLOBUD4FfLh2yV+nDDYfq7pWYABsPHISVBmw3RZ?=
 =?us-ascii?Q?1Ppq03Jrn/x8S/PVXH2Re+NJB9jThU88apa8wy9Yns/ZN+Ca2bE26OUu+EPp?=
 =?us-ascii?Q?IKV1p4wT6aebQQpe9ScI80cCaYWL+ko3ZqmRtAKb61H6OJFd/Kp4rNw9y4z5?=
 =?us-ascii?Q?61Y22IyxDvTWQ25ej9J7S5/R9MyvC2Kz7ygoNynazK1SdzW6nBWp+wzCEGjB?=
 =?us-ascii?Q?pKjDT3+T5WozkvRhGiqJWBr1/K/mX1yi0APktvB3pxdBSNjB1cr/04pWZalz?=
 =?us-ascii?Q?697Q/e4R7Ls2paQpYiHex1VwT0NY//+ACoBxw/G5bBs7iaTlsH/1upyNEZIS?=
 =?us-ascii?Q?odU+tNpeqgDP75dbt96ZdUpnxWSaqbzRVwjcpsDniF09ttpGGLymM6IfYV1p?=
 =?us-ascii?Q?V4bpiPWlQWE06FDmMXjCv00F6uZavl1m96AbuUaDOyhqsDF0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90d9b81-5580-4cce-15c6-08de8ab5435d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:05.9057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hc9HdSA4h+BG1x0n7FBrGrfYXFKCGc6XpdRUqf35NpKEwWE3Br73NEFoxGZ3hYeu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9790-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: F188032C709
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All of these cases require a 0 comp_mask. Consolidate these into
using ib_copy_validate_udata_in_cm() and remove the open coded
comp_mask test.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c |  8 ++++----
 drivers/infiniband/hw/mlx4/main.c     |  5 +----
 drivers/infiniband/hw/mlx4/qp.c       | 13 ++++++-------
 drivers/infiniband/hw/mlx5/qp.c       |  4 ++--
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 8d9357e2d513bb..064d5136ba405d 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -699,11 +699,11 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	if (err)
 		goto err_out;
 
-	err = ib_copy_validate_udata_in(udata, cmd, driver_qp_type);
+	err = ib_copy_validate_udata_in_cm(udata, cmd, driver_qp_type, 0);
 	if (err)
 		goto err_out;
 
-	if (cmd.comp_mask || !is_reserved_cleared(cmd.reserved_98)) {
+	if (!is_reserved_cleared(cmd.reserved_98)) {
 		ibdev_dbg(&dev->ibdev,
 			  "Incompatible ABI params, unknown fields in udata\n");
 		err = -EINVAL;
@@ -1140,11 +1140,11 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		goto err_out;
 	}
 
-	err = ib_copy_validate_udata_in(udata, cmd, num_sub_cqs);
+	err = ib_copy_validate_udata_in_cm(udata, cmd, num_sub_cqs, 0);
 	if (err)
 		goto err_out;
 
-	if (cmd.comp_mask || !is_reserved_cleared(cmd.reserved_58)) {
+	if (!is_reserved_cleared(cmd.reserved_58)) {
 		ibdev_dbg(ibdev,
 			  "Incompatible ABI params, unknown fields in udata\n");
 		err = -EINVAL;
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 16e4cffbd7a84d..037f02b5f28fb5 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -446,13 +446,10 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 	struct mlx4_clock_params clock_params;
 
 	if (uhw->inlen) {
-		err = ib_copy_validate_udata_in(uhw, cmd, reserved);
+		err = ib_copy_validate_udata_in_cm(uhw, cmd, reserved, 0);
 		if (err)
 			return err;
 
-		if (cmd.comp_mask)
-			return -EINVAL;
-
 		if (cmd.reserved)
 			return -EINVAL;
 	}
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 40ddd723d7b549..cfb54ffcaac22c 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -720,7 +720,7 @@ static int _mlx4_ib_create_qp_rss(struct ib_pd *pd, struct mlx4_ib_qp *qp,
 	if (udata->outlen)
 		return -EOPNOTSUPP;
 
-	err = ib_copy_validate_udata_in(udata, ucmd, reserved1);
+	err = ib_copy_validate_udata_in_cm(udata, ucmd, reserved1, 0);
 	if (err) {
 		pr_debug("copy failed\n");
 		return err;
@@ -729,7 +729,7 @@ static int _mlx4_ib_create_qp_rss(struct ib_pd *pd, struct mlx4_ib_qp *qp,
 	if (memchr_inv(ucmd.reserved, 0, sizeof(ucmd.reserved)))
 		return -EOPNOTSUPP;
 
-	if (ucmd.comp_mask || ucmd.reserved1)
+	if (ucmd.reserved1)
 		return -EOPNOTSUPP;
 
 	if (init_attr->qp_type != IB_QPT_RAW_PACKET) {
@@ -866,12 +866,11 @@ static int create_rq(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 
 	qp->state = IB_QPS_RESET;
 
-	err = ib_copy_validate_udata_in(udata, wq, comp_mask);
+	err = ib_copy_validate_udata_in_cm(udata, wq, comp_mask, 0);
 	if (err)
 		goto err;
 
-	if (wq.comp_mask || wq.reserved[0] || wq.reserved[1] ||
-	    wq.reserved[2]) {
+	if (wq.reserved[0] || wq.reserved[1] || wq.reserved[2]) {
 		pr_debug("user command isn't supported\n");
 		err = -EOPNOTSUPP;
 		goto err;
@@ -4235,11 +4234,11 @@ int mlx4_ib_modify_wq(struct ib_wq *ibwq, struct ib_wq_attr *wq_attr,
 	enum ib_wq_state cur_state, new_state;
 	int err;
 
-	err = ib_copy_validate_udata_in(udata, ucmd, reserved);
+	err = ib_copy_validate_udata_in_cm(udata, ucmd, reserved, 0);
 	if (err)
 		return err;
 
-	if (ucmd.comp_mask || ucmd.reserved)
+	if (ucmd.reserved)
 		return -EOPNOTSUPP;
 
 	if (wq_attr_mask & IB_WQ_FLAGS)
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index d4d5e0d457a0b5..68c6e107747693 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5611,11 +5611,11 @@ int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 	void *rqc;
 	void *in;
 
-	err = ib_copy_validate_udata_in(udata, ucmd, reserved);
+	err = ib_copy_validate_udata_in_cm(udata, ucmd, reserved, 0);
 	if (err)
 		return err;
 
-	if (ucmd.comp_mask || ucmd.reserved)
+	if (ucmd.reserved)
 		return -EOPNOTSUPP;
 
 	inlen = MLX5_ST_SZ_BYTES(modify_rq_in);
-- 
2.43.0


