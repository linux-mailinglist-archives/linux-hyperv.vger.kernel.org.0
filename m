Return-Path: <linux-hyperv+bounces-9334-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN09OtAHsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9334-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:24:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE7A26B9A6
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 712963025E1B
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA6E337BA3;
	Thu, 12 Mar 2026 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lfEsC/Ae"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63545335081;
	Thu, 12 Mar 2026 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275080; cv=fail; b=c13hCLUioPpecZKswSSL+9o0puL8F/Ju7ZXAG3XZfFwjeRNQhkA2in4T/02DLIQpsI0ow8SIxfmstN66c8HwMyU4lfn42dRKSDOYJ0Vcc7z2NE5pwBY+V55tHzQIm+0YgePBMj53FxjJjhN7pNMHa7ia1n/GsxusheMLRxP2aUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275080; c=relaxed/simple;
	bh=xX9V/bj1KzEPVc6F0E7MGQ0aQLGAxfKhmiXeLEFkCi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TZAxf1x+D93ndpC5ApNcau1zXg5cQI/cd/+TKAodprAv6VW1449lNLBhYwuLj+wHipCQQsG0fPIHZmuXqKQd3GA+n/9VUYG+Cg7QHPOxocruYlSnoVjIRxyPGwxvgL7PrUKxY/mI6DRFwgkBjuvgTfRl1HxRgcVx1+Dgeozuwuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lfEsC/Ae; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/5Qwd7vvwwBPpV4U+7nMFXqQfPS52tPNHuAaqUTW0JEiHR6UKH3aNEQD3C3MOUpLPNiOmW1ZgIXEM8lhpWG4/en1YdroT53uqvYOg4J0WidD3mcLJdC5JvET2q4eNAYlpW1bBxNvMbU7d3ISQVyUb9VcMtXIxbtGbjDZT+IH/0ucDTV5On0/45sV7AjgZ4PFSR9gHQTVZ+NbwipmmPyoScyIX3wyXK1GVJykpk3voD+dSGX00h2MHZHpxs+8UIprTHqNAo6ZLQVmBYF2LIiPYrFNpnS1eB+xBnoH14bEEqBIEN7E+gcAGP+NKuBqMNNI+MFjMMJ8Zm9dYlW3mEwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvUTCXpjEoQoPZ00V++Iy8iJ/JU9irwT5q/zdXhfQYc=;
 b=c5Eyaeeyvrrb2eO3kSghOotR/O81J5q+PESmNhSSZAEqhay9dtqyECJ01YfKYKnpfSvRk6sWtUG/0/b/XJza8pDSrgp2ZhpNuz+tPqqyMWBY+W6j7rlasIdoZ5kPdMAPhAibhOIvhpvgN7jJ7A+pAeDHO5N9iTX+lo9K2xVULW78mD+IRnk/rhoDaYmnPoAmLMRpaTK8dmPKAwLMqhWknUCDFshCliMw1EaXkVrtvuDVDSLB36KQkSlyhQir2YxBZZUU98jJSMLBO13wIQ59TMQbUAdAbQoToa25Kq+5pWiBYNWZ26RZA+dH2dnWv9o1OOvOUijTqvI62QZj5yIC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvUTCXpjEoQoPZ00V++Iy8iJ/JU9irwT5q/zdXhfQYc=;
 b=lfEsC/AeVAnOou3QyaquqC06JOq/xfMzOtjwo4NknU3EHa1LnlnJjpphXlCGBjie9xNcQi1TpetDyqFm9c5t6e0XpZoOx3oYUHQO9Zsj2vfb1+9Jdwh4I2e5wJ86F+cAzE2LhKZ3TMbA5DUp7JX003HMPogEJlvJ26rTXqbEdiOIzbCcAkmlnp2c+gxxX1JR0lNrQFVzn0QO4ZiXdiUVeFffvY5kXPTK/ZkCj4PpmqzeBoZ7EnD5ot0NmuH1mOvzlFfORCgRLDSSUnH1aqOrIbDKRUxalVQDJ1trXVacTsktSjfrIUUqaNKBmSTYZGye01BsenGYa1pB7fqaeWz2yQ==
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
Subject: [PATCH 11/16] RDMA: Use ib_copy_validate_udata_in_cm() for zero comp_mask
Date: Wed, 11 Mar 2026 21:24:18 -0300
Message-ID: <11-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:52f::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ea12c1-f30e-437d-41a1-08de7fcdb70a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SP4eGwqHuxa39PvkGe+ogQyP3HoG/lLyznoUZb0FZ/0boLoAq5xPKvLYd/MFWm+iTNqQSz6vZ5aCPKyWT+awsMNl04A9msi7IZ+NQhpRSmqzxlsyCuSv2HU7bxuK2T35TBxRrcxPXnxQ5CLg3Lk9/JDmZYQlNKjT2iRivXf5rHG676a0sTS2Sr+z8xcVK0WA+YebwmNT7mTeW7QsHMfZ3l1lJZwdAm6HSyM9A7K1l6RjJkb4po79y2x42vgFauSlpf1EaXAdNxYPhpejr5bK/2GyAHbSSc/uYuLrBF2Fx3sJT2be2Vzo4PjYiNMmuGxHXFEDazds2VebadGI10qbTFsvnZYu9qM38gxFgn04SErtWB9GcXIF9MEkbrb26Zep5tcYmMAgwZz/orCsQc5koj6Z+t+7cRaRpcpwp0YyiL4n4uQn9ERUSkhL/nakFmir7QHKpuPVapsw/zl+E8lIgCpJpp1SHRNb+4HOyriujQFTLwkSDh5ZzN3i4OkD7h8+1Bb/siEMJ9Qi+5bsy2K05nSs9k5WSYo86UdpOo5L+Tsp9g33CaHpJJ7GylsFoE4Ly0PBxKdTfFpVMjddXaod1lvCJtNmMudCnBOQrHwa+D/NJLssKVo9fzqzaGU8GLmlRO1skZ+U4O6lopaWD4T3Y7KyK7mTWiEFM+oyj1EZOH3ZJQO4oCJGMLPUEECkY90FPD+OM6KP6lht4jHvB8qKfIDzQr4YaX+XjTCybu+m3b+jCtztMmvKcZmLemYz8H7KBo8Vdvy+BefrdT4TwSNwrA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dt9G5bucDVVJc0gUvgthfQdLV8S34DEhSplmATDKgbqdc5NnRTHQkBv9XUdB?=
 =?us-ascii?Q?utR2rvJ5WVNRYIu8n3LFOahIf5aUP4uL7OxbV5hsd/lFRZ4tX9PSbTyFPQZd?=
 =?us-ascii?Q?f3aDo/tdFloZJ/uRGjphDHefHhhnsbXYZCaX7MMX+w4mPPzwoZgflV5V4LFq?=
 =?us-ascii?Q?jf6ZqOLNNEjJ1uJGND2m2G5MiJe/O35PUif2Ye0el/YtKfuKpODRNv+ZcR98?=
 =?us-ascii?Q?ljtBTgR2bzYhRFmmJFDOCvvH86zHgcJ0sTQlxdBefSRkEsLScJqWv7Awo+6b?=
 =?us-ascii?Q?gVjxbxoBnMreRzhQYM8d4/f3QWhGv4LeSNUB8qnbwaX572biuf/hYugxWNvf?=
 =?us-ascii?Q?OuHfksB2A+jytfZNaTSwHEQU3/mw1CnZ6XjqNSDFu2CbEGWglYZKcvqwM73b?=
 =?us-ascii?Q?z3BXs3Y0VzIvJqdbyjcCgQtXzHjLO8JIZr2cIbKxJZXaahQgAcasxJzI+ZnN?=
 =?us-ascii?Q?r/2gAI1SO2x1bIATis0M6N1P5Q2Wp9pIg9IP1Tet6de1Nmt/WonFQJenW10c?=
 =?us-ascii?Q?4DI5IERCNalTGSDu5NsWVA2LPQYWtZUY9sPbMaIO85TT0fUo972gDZ6jJWyR?=
 =?us-ascii?Q?/28hWBQwuPJ7lFhn1pH2K+gggosOU8YJL+h6YEyikHIM/5O45MNevhqw118J?=
 =?us-ascii?Q?SoqFJU3NauRhgguVyZkkK/bxW+Or2nSN7ZNkwLSnNh5fvz/jMFiUrnaUPzR+?=
 =?us-ascii?Q?A39nJ3j0pESA2ZLHvU8mFbN63a8rSQ/JiuF0XlsaaPhcbjBcbmSLM9zZtuP1?=
 =?us-ascii?Q?7/xmtzwTWyn3Fw7WMIgqQYmzjaUre/0T8Raepk8VRRl2/SpdxVA1ZzqIlyY3?=
 =?us-ascii?Q?jhnAjkjkj/Fk7rmBVs+ry+i89FLZXP445Cy0WVe8lSgb4GbLf7eFWafJRkJ3?=
 =?us-ascii?Q?sYYAEGzegAHsjidlnPooAOSO2obuUfsWPTjE/mGq6++c2RpEMftoopGo6cD2?=
 =?us-ascii?Q?SysFtNsZ5rQzeG49V4IeZcxKwCROxY8hzrVH2fN0W5OjDfR/gOXvTMZbKcSw?=
 =?us-ascii?Q?yng4MvcO/BHwHohkgfmjPx4v4s5krwR07F0UuicUKmuYXfruiuCY7KxhMStW?=
 =?us-ascii?Q?toRgeese/GJ3KmiZYqf8uxx4Z60VSie7HetaXKzO/QWLpXomWnf/Lpas0eOc?=
 =?us-ascii?Q?76czUSUIFd6G7KEe3+cgKVh+rX2a4K+eJ4MEt0y7ufZj+ZF0RXsXqN0cx42a?=
 =?us-ascii?Q?DjemfESWxBwvu5djQ9r61Xv/DlMKtbC4fwNJJOHziQ4HL0KgC8VN/qdTuaam?=
 =?us-ascii?Q?B1EbJgta2lXOR9Ca3bCAKRYoBSjJy9/ufIO/ZS7hqCOKql6EV/jhPBxQ2OSr?=
 =?us-ascii?Q?g/B0jz7n+YkojlsbSA1qcgsw8D41/C9MKZ7r0VqtLx9xSbRftcDBsjO7+0h1?=
 =?us-ascii?Q?/xD6QvBBzF9SP7MHBTd5qakWmd7KK5yELipyMFB5eHHcItdAX2EG4b7gkO+w?=
 =?us-ascii?Q?4LxcalCjQUu5hmWg3ayTkGoQoVM6RESqkBn3oA4JdNQu9SIEQtFUEPz0m0Oj?=
 =?us-ascii?Q?wsIHTJpyZGP0br8cG51mdiHw0uSBOXez5OPX20I5XZbIgamfvWBqwp+I48RJ?=
 =?us-ascii?Q?4dHAn+88AaB3KpeYKP0AjHy0meojp9RAJeJM1ld8cZEW8HYBRnT7Z7tF0iPz?=
 =?us-ascii?Q?80yCC7+1VRgx4TWcSX8qBcF6swaDST4F3Wihp+gggSydE7MZLg+dnqq8idnz?=
 =?us-ascii?Q?hWygo8KqolYhZKt3eCOaVItsrrkCzs+C5980eeHc8nb4f2o0MAIp81YO6Lo9?=
 =?us-ascii?Q?HBYYD0PzIw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ea12c1-f30e-437d-41a1-08de7fcdb70a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:25.1780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FS+ystLk6+FIuciK4XW4iVOst2j52Upb2MQdglXxEJfDbWy8z956sklDbkE85U1/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9334-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FE7A26B9A6
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
 drivers/infiniband/hw/mlx5/mr.c       |  4 ++--
 drivers/infiniband/hw/mlx5/qp.c       |  4 ++--
 5 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 22993273028433..b491bcd886ccb0 100644
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
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index fce519b87633ef..49dcc39836c047 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1774,11 +1774,11 @@ int mlx5_ib_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 		__u32	response_length;
 	} resp = {};
 
-	err = ib_copy_validate_udata_in(udata, req, reserved2);
+	err = ib_copy_validate_udata_in_cm(udata, req, reserved2, 0);
 	if (err)
 		return err;
 
-	if (req.comp_mask || req.reserved1 || req.reserved2)
+	if (req.reserved1 || req.reserved2)
 		return -EOPNOTSUPP;
 
 	ndescs = req.num_klms ? roundup(req.num_klms, 4) : roundup(1, 4);
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


