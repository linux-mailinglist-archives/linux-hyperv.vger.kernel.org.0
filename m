Return-Path: <linux-hyperv+bounces-10012-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF3mKQaj02mMjwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10012-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6599F3A336C
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9FFE3014518
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816C8335571;
	Mon,  6 Apr 2026 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XS91CSTk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F953358C4;
	Mon,  6 Apr 2026 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477504; cv=fail; b=rGAXfY/kzPRYbAje0B1BX6MS0o3yx7oWUX5lL0yoaTImkTQcp/tw9iDK/Y7Po+IE4R9H9dd6pYTKU+jkqEE5FdKXJuLHiDitVN6Vh+eKc4hQkcyIg/hkLS8LfEwAYnN/8wdMvs3thulJEc4LHetYXUBGIZ6x8+1iDZXBFh6RHGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477504; c=relaxed/simple;
	bh=JkdK4NXVml51wrexonHswQLfUpStVQ5DUVFzHJ/XDAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P8wqfGZkBX6IrosxFs3htAPPbWFWZGco1Nwa+ZRKHBLaCRSNxk/GMZXImyXTEVGPNgbpJ+LMjZnT1ToOAoBCLu/7+BgfOWhPlPCSNM06++labgvullIuiXXuV/6tnkXUIQ2g8m9iRlfO+vgDwoY66puvT2Kw0OcsyMOUdeq55gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XS91CSTk; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iha2qy8FlMzPRjcpTlGUyPGI1lLkI224ECZ835WZIRnlcDO/rwfWrB6VUfRp8k23pCsVx+uBUyxqETL3EPjjjy0lHXP7x3Dyq0Rm3DH54Z2eEnxd8iduwtMFqDMLlEcMj06OcwRBDSOUONIIHYzRxRCFhzCgaCozmCaglMVzCTPNxcS5ev7FwmeCvV+o9NxD/Tiz8gN3Aw2OhAc4veQSk9YzA2p+257N6XN/U4xzWwbuLOxMSQniY9iZJW4eRZ7/hBoVWue4Yg2VuUcSynIr7jFQhNNgdIsFB5SGGal2/0yBpZn+f152DEuosmP8Sn7yA+P0/IBTiJvgOuOCkVNfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtrIZBpdNdH4r0lfYf3MA0rg2g/3P1fAUG1bh0KLGAc=;
 b=E9qI4adnwkZFGyd5aHlq5KDZEb1mrlThp9GNn/3vfq5yRJ4M/1m2wwZKziIvofUH/ByPZLvb+FwiaC0WxD/24+GebbCglUOHY+sfbsIM/AdXWCiS4V7Z8kKvJ21zZuanXpDbf8fb8oqxcu8h7/GRP5jDleI5sUnj1HxfJU1BInozLLZaUYMo61j7sLk4BFSXZ59p7xmrKEjTMEqSUnS7f/D7GwdDQOA1Hth1OI0B5lHTwMTZpbZFZ02S0AzQOnboKVUMw+vyAUEGrsG6TibCoNoA4xrFLjx/14jJSR1r4DOD9+NdH+wTB/wYAKtOcK3o6ZWRSgh8kOJs56+8S5H27Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtrIZBpdNdH4r0lfYf3MA0rg2g/3P1fAUG1bh0KLGAc=;
 b=XS91CSTkZncTuGhh8mRLqUU004DGVtzDBTuGqDYCCrwFtpMS0FhP2EG774V1s5fmGp4fHtnlusZHXwvGp4G3K2g17Vwrck9Upbh73O4qkRPDsNpfpvKjnuB/kIeCiFGDWdHuJCd4ioTfo7a3By0W3EcbVQRMThI579TZf1m5yieVPFI3l9u0BooJVZjZAtJ7OXGZrHHX7F/udotDhQxwTCpdD+HxM3b5QaZob5U3xOUooQfpUWLt7CDX4DWJT8HO6N4+Fd3wB7e0rRsV/O289Jrxl9rt8zkPfHDuC0TVo175lZ0N/Iz63irGzAPrEujAavBT4LjOXoT8TBtbltNilQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 12:11:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 12:11:34 +0000
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
Subject: [PATCH 08/10] RDMA: Use proper driver data response structs instead of open coding
Date: Mon,  6 Apr 2026 09:11:22 -0300
Message-ID: <8-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0012.prod.exchangelabs.com (2603:10b6:208:71::25)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d50b09-eea9-4924-506e-08de93d5a22a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	hlqSEdYy21XOAQjYjf0sK6ov5fN4iNd2NNNWUL6Gg5+a/5y/muR2fK4/RCptr2twqI/JpbateAlNl4ceSkuYOgyGN9E4J9eIeC42EVO5l1qQAZP5iuM1GSfb2GiI8r/AYjShmzO4ipc5H9aLDcaF4K+rlJ5Lqur2wlmojZS/Q2/1uNZ3QN3G7U0tEbR33jiEA8OV9z0KxVv0RMBRrKLu/v/IVykhroBD64sP0N1AgfbifhahMnGrxWWmogX2DeWewXH8rBP5fFffjp7CVyRmiEnvJStIXi33sXNPmoI12dyBLkdHq0zM1pEmc6lFCXrR81k2WrlQh7slox4qymJOknRVg2fRnmPfOvi1TXWsnZcpGoUYrOOfKMIYgAZne7POIHZzFuYNSCZi0/ONz3REUU+5aJh68GD8k8ZKwp9iDLf+ZolHWRGcMU7mr6iAunPf7EMEYqWdtdKn+9THeaoBzgrO0fEZignzM3oUJ+Unrs5N89Ab8N66Xo899kyZ/yUkbmlJAPHl2qNCc0e9Y1u3L9y/gd7xnLhClFihSZuZMvIHLCM4WXsK+zr7wLLPAa4dRa4aD97yrJF7B7dBLJ0FI81pkFwGttmsMiFgnm7Mz9XRfoaXYpg+uj/Ge6M0743nlQW0mAidbAEqbgyMm5C0I5BKscq4PnEualwyG2PhNosHy4nf0maYOeSzL14D+jy8WZhIXSZnxZZMMlx0SNDdAoGiNLGCIOe5khIjCqVtYGLscZt9YD5bTEBxbVi4ynG5VmvTuui9fGfKH8escgjMeg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ESB2xJp6Is0CvR7LXdI+kDDGJDI6Ne8e/yAqhPx810IcmbR38eq7vUoVj/ll?=
 =?us-ascii?Q?LtOosTnaxFcyGOfDu/or1vigx3n0500rFBxBvppi2lP5UEW4qrQaMpACBH5T?=
 =?us-ascii?Q?k+N0AcWBJ1WBVaeTSNDTiTB49uc3GIgPPCOqpKRXebH5jY2u/McFH1gAqiLw?=
 =?us-ascii?Q?LUFWG6nlKhWI2w4d+Ep26LyJbYA9kkJAzHIMQQWdKZiZflqWfRjxlfO5ANta?=
 =?us-ascii?Q?6jyo3f2WppDQGeUXUQn/2b9JmfeJEfUBqOmAznoMkeVmriyYQ8F+9UmN11LS?=
 =?us-ascii?Q?ah3FmnL5RKUe7lttdigxtnlHkAiv0bCOFU1s9e/0Zx+LroYBf5DqvMK9Z/tz?=
 =?us-ascii?Q?nBs/gq6SZbU08uB4nci5FTWxUiaCTOrO6KY1sOUBqK6tD629MBjVIyuY9QGT?=
 =?us-ascii?Q?TcIPMhWwD72qQYOLqane0gEBTSvl/RFZTTqGxvwgV9MvbpcYmsxFJpqFP43A?=
 =?us-ascii?Q?PRKjI3o1WYHSKDWpEEyQPb+takeqse0cFryqQA0PT9FQs9UtxxIo3+0IcKDh?=
 =?us-ascii?Q?Ivyp0UK4QqaZoPbnRxIzl1weUi9ZvDVG2wSd5H2+vI2fgH8ARKFyNtOwSny2?=
 =?us-ascii?Q?qRDbOVAEh62gOpnNg0VkRikaWNg72t2/IMtF75Q3EVEYwH8fXWlfvg4qeVDV?=
 =?us-ascii?Q?Az9FZ2rcZdT9Typ2r0wvGw8eqjXU+24r01molZbx7l1T8tNdczDPfZqaKuaa?=
 =?us-ascii?Q?+pV966a3JW9z84ZsxA3YXejWWb9ZyjmloQsFpj0rghKzDNLqRK8OrCO7Estl?=
 =?us-ascii?Q?WVL4jPPdAaAvsT3kXAjn3j3WcJhuFHOvwKIoGk2ZSO/G5hEeBMpFjVF8rOu6?=
 =?us-ascii?Q?jLs3XFr9SMSWrU2w6G3PmH9Kt6voDGOKff/6Ur2E55O6P2H7jd94s0EdFybh?=
 =?us-ascii?Q?9yYkXzmVrvS/tZLd6JH9bhBhSdMv7Wki6xEk4X0BXIQiQCHLglenp9il9t8x?=
 =?us-ascii?Q?zYyfAiygwu+aMOXquXYf6NYixxRPzZnlaqv7l6Toz8La4tAshnO1oLLjDcxp?=
 =?us-ascii?Q?FkZPobKVMRri8JYgCrZ2nonuAgvfPxehsArBG1PNfJPHRzjEz4HNu03c4pe1?=
 =?us-ascii?Q?0JYvGVMcfHwzqNXWJpuP0qodA4zNHPkd1SFIMXAU1RfmtJ03p4oB79mLA6DG?=
 =?us-ascii?Q?vLGqWBLcNpqC2k8FCMKsgdtZDYgzs8W1186y9HSXRyY1fDRqAL9u5KuAym1H?=
 =?us-ascii?Q?8nUZrkM12sMui9pVjkTFHAyTNqu2Xd63vCkUIuqT3OyiRnafKLls8utqf412?=
 =?us-ascii?Q?8WXsyYXK9Wi9MpHgFEXANaeiGsOHrfwVtr4F/ARyARhF+sfMiq7zsveXvX+a?=
 =?us-ascii?Q?Rj4H7qUetcAESOzwNwL8Yk8pZ9kmooAYbyQrAWRpbNhBOwFF0efrejVK6uPN?=
 =?us-ascii?Q?rA9ZHrmSEFRUx9ogGvr2ZoSKv7sC2SbZXNdbroeKp2wPT4sEuguZd7VJKO8W?=
 =?us-ascii?Q?0FEnBRXZuYSW2CjbqyYzDI+wuuhor+AcxPTLGqenFws12aM8R43SKwQirptt?=
 =?us-ascii?Q?L03VA+EOpdx2YE1iZbscIVFmMG6QpjPishgAqQA0Mko/l5l66ddiOL4PH4zN?=
 =?us-ascii?Q?AZ+ELLTx4mApX3QnsbWmcjjw9ZAGeiEA8qEsQVw+6/MUCeLLC+rz3VpJvFwU?=
 =?us-ascii?Q?cqWyirHHxaU1LTnwJYo/J9asASPdRqofSd3vt4wVU77ohYDD4JIQf2GPyGoJ?=
 =?us-ascii?Q?kYtLr8l7Ox5y7mZSaPOPvQPs4wPVv3hVE83cQkhCUUxDdp7Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d50b09-eea9-4924-506e-08de93d5a22a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:11:29.3494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWcwiJx4Q7frg97sxavNVwi47IgvUCAzY93WCnBqkCimwHNmn+btUIzms2+wAL46
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
	TAGGED_FROM(0.00)[bounces-10012-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 6599F3A336C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

At some point the response structs were added and rdma-core is using
them, but the kernel was not changed to use them as well. Replace
the open-coded copy with the right struct and ib_respond_udata().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx4/cq.c              |  7 ++--
 drivers/infiniband/hw/mlx4/main.c            | 11 ++++--
 drivers/infiniband/hw/mlx4/srq.c             | 12 ++++---
 drivers/infiniband/hw/mlx5/cq.c              |  7 ++--
 drivers/infiniband/hw/mthca/mthca_provider.c | 35 ++++++++++++++------
 5 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 7a6eb602d4a6de..7e4505f6c78b30 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -142,6 +142,7 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
+	struct mlx4_ib_create_cq_resp uresp = {};
 	int entries = attr->cqe;
 	int vector = attr->comp_vector;
 	struct mlx4_ib_dev *dev = to_mdev(ibdev);
@@ -219,10 +220,10 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 	cq->mcq.event = mlx4_ib_cq_event;
 	cq->mcq.usage = MLX4_RES_USAGE_USER_VERBS;
 
-	if (ib_copy_to_udata(udata, &cq->mcq.cqn, sizeof(__u32))) {
-		err = -EFAULT;
+	uresp.cqn = cq->mcq.cqn;
+	err = ib_respond_udata(udata, uresp);
+	if (err)
 		goto err_cq_free;
-	}
 
 	return 0;
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 4b187ec9e01738..25f9738bd77223 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1199,9 +1199,14 @@ static int mlx4_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	if (err)
 		return err;
 
-	if (udata && ib_copy_to_udata(udata, &pd->pdn, sizeof(__u32))) {
-		mlx4_pd_free(to_mdev(ibdev)->dev, pd->pdn);
-		return -EFAULT;
+	if (udata) {
+		struct mlx4_ib_alloc_pd_resp uresp = { .pdn = pd->pdn };
+
+		err = ib_respond_udata(udata, uresp);
+		if (err) {
+			mlx4_pd_free(to_mdev(ibdev)->dev, pd->pdn);
+			return err;
+		}
 	}
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/srq.c
index 5b23e5f8b84aca..0b4df4f48ca14f 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -191,11 +191,15 @@ int mlx4_ib_create_srq(struct ib_srq *ib_srq,
 	srq->msrq.event = mlx4_ib_srq_event;
 	srq->ibsrq.ext.xrc.srq_num = srq->msrq.srqn;
 
-	if (udata)
-		if (ib_copy_to_udata(udata, &srq->msrq.srqn, sizeof (__u32))) {
-			err = -EFAULT;
+	if (udata) {
+		struct mlx4_ib_create_srq_resp uresp = {
+			.srqn = srq->msrq.srqn
+		};
+
+		err = ib_respond_udata(udata, uresp);
+		if (err)
 			goto err_wrid;
-		}
+	}
 
 	init_attr->attr.max_wr = srq->msrq.max - 1;
 
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index a76b7a36087d98..c548d4dfbbc96a 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -949,6 +949,7 @@ int mlx5_ib_create_user_cq(struct ib_cq *ibcq,
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
+	struct mlx5_ib_create_cq_resp uresp = {};
 	int entries = attr->cqe;
 	int vector = attr->comp_vector;
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
@@ -1015,10 +1016,10 @@ int mlx5_ib_create_user_cq(struct ib_cq *ibcq,
 
 	INIT_LIST_HEAD(&cq->wc_list);
 
-	if (ib_copy_to_udata(udata, &cq->mcq.cqn, sizeof(__u32))) {
-		err = -EFAULT;
+	uresp.cqn = cq->mcq.cqn;
+	err = ib_respond_udata(udata, uresp);
+	if (err)
 		goto err_cmd;
-	}
 
 	kvfree(cqb);
 	return 0;
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 07c60797c86091..afa97d3801f783 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -357,9 +357,12 @@ static int mthca_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 		return err;
 
 	if (udata) {
-		if (ib_copy_to_udata(udata, &pd->pd_num, sizeof (__u32))) {
+		struct mthca_alloc_pd_resp uresp = { .pdn = pd->pd_num };
+
+		err = ib_respond_udata(udata, uresp);
+		if (err) {
 			mthca_pd_free(to_mdev(ibdev), pd);
-			return -EFAULT;
+			return err;
 		}
 	}
 
@@ -428,11 +431,17 @@ static int mthca_create_srq(struct ib_srq *ibsrq,
 	if (err)
 		return err;
 
-	if (context && ib_copy_to_udata(udata, &srq->srqn, sizeof(__u32))) {
-		mthca_free_srq(to_mdev(ibsrq->device), srq);
-		mthca_unmap_user_db(to_mdev(ibsrq->device), &context->uar,
-				    context->db_tab, ucmd.db_index);
-		return -EFAULT;
+	if (context) {
+		struct mthca_create_srq_resp uresp = { .srqn = srq->srqn };
+
+		err = ib_respond_udata(udata, uresp);
+		if (err) {
+			mthca_free_srq(to_mdev(ibsrq->device), srq);
+			mthca_unmap_user_db(to_mdev(ibsrq->device),
+					    &context->uar, context->db_tab,
+					    ucmd.db_index);
+			return err;
+		}
 	}
 
 	return 0;
@@ -631,10 +640,14 @@ static int mthca_create_cq(struct ib_cq *ibcq,
 	if (err)
 		goto err_unmap_arm;
 
-	if (udata && ib_copy_to_udata(udata, &cq->cqn, sizeof(__u32))) {
-		mthca_free_cq(to_mdev(ibdev), cq);
-		err = -EFAULT;
-		goto err_unmap_arm;
+	if (udata) {
+		struct mthca_create_cq_resp uresp = { .cqn = cq->cqn };
+
+		err = ib_respond_udata(udata, uresp);
+		if (err) {
+			mthca_free_cq(to_mdev(ibdev), cq);
+			goto err_unmap_arm;
+		}
 	}
 
 	cq->resize_buf = NULL;
-- 
2.43.0


