Return-Path: <linux-hyperv+bounces-10770-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O0MNu5vAmrkswEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10770-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:10:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66607517C5C
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 192FE301F993
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 00:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F6D57C9F;
	Tue, 12 May 2026 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UfAqkWeP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A55A72618;
	Tue, 12 May 2026 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544596; cv=fail; b=dZhfjwRgUP5JAMA4Lq+C+eqXMgMBQsAH0BRAtPJju23TYAxuZ7bsNb4CNhnrQtke65RHoNMTG9gBUYLrBNy0V8npJxIWEtEazcZUSqt/SZBOTBLS+syWL1rlX8dKplQ6Ga2NOfsIPV4YEfFQ6BBRipIYAg1tTUgBnc0V1gVnXtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544596; c=relaxed/simple;
	bh=VOgT7+8DRN0PzMpPW5E9blWQVipV7zIaaCuVi5PYaEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=awU42s+hkmG/47T7UHlWcjIQAH6Wl97xiGDKvJEhDrmX/1lYiNBPxUtP5q/qwCVb2VOpr5RjjN5gSqfjIh+AmOCfxF5yLkuaiq9wJevIzqKIkKmMYijvYLmlPbvrv9k9KrLTwn+zY44owrI35pKlxf5V6wxJCHTbCQqvdOUVp24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UfAqkWeP; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8azu+pZww0tzz7cMDrnVIJZ9eTVRe3TvGEhlw1VYVUjDdaBbjr019kLQ8Q2Oa32uNcUOdcsSLl35U0H3MlR/FrET/bJJfrORCRuvTqVoSUzrNja1Hud5Y2F0tR9gjsRKuhCF1QjoGr1dVC21HB/VS90h4OtStPF2ZkwcmImpbipMEYLM52PHc51DiF24QnbM7Pp2RnjOKe456+2p0Bpm2jgIAMw7/qlZMf4Xba+oj4/5iCdjNAG3vHz2rYBXp15+5+Fu9/iy1YBGM4bf/curGSFKuW8/1IWMhWHM2amtqCS/noDNLeXEod5zuoNgt7qinjU6A9EJkX+kjkEmeRd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idG8mTPOEPJr8kaqffGfUYRbEj8Ls6JuK8kodc7kjBo=;
 b=NeL08611hgzc8o0PicDg4CdTeKOP3bStBSkwQNPB/5d45UxqADM0a3PpfX6DvYcE70xN17HqTxlt2X2bMPyEBMLJhz9OOpNlSQWDH6DrLAC+I5ZiPtPGP9iZOf1m95+GICu7iDh4nSA2zT4XgX7GmjlDXRHMT2t78z7OJlBW5fdSb5TnRrYZXBFGCr9rnJL8eFUZ97ZJi24MJzs+CxkMIArJZ0urTx2miYeGHfFRTef3QOuahtIveG2sQcmI1VPuw8+Bn5zrHrrv6qmQ2VutWaRPuq8wrcdNT6hkhvd2Nwp/5h5AcRBPUtXdNttmLCRQuUnlJsS9ykkL4WXFaww74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idG8mTPOEPJr8kaqffGfUYRbEj8Ls6JuK8kodc7kjBo=;
 b=UfAqkWeP4PzJ5RGibJxqGTi+iiBgMHWhoRmjrj2nG2Wd/pKDv7isUz+aAwEm2MRjh027KRpDOlXKCpWxVY9Ild/HmG5YmkxhCQlsUwfy/Z/yK3wTV/1Aa/ApbCMz4l07uQYXjD/vFmFN8Qu2r0cQY5XcZbiUF5s6Gsua2rT4ZGRFB9jZiV297BVJ+PaLG8+nLXAYgPRmTg+BFHaKDAB2IvK9j/Ms4WxU02XKS83laRHpbd0m6qQzZV93+fHg9RwDAs01Yxqy+864sodjuhs9vOyOBUwO5UkrSCB4+fv05Hg9FDAPZzaixxCk2vjGnYtjFxdrRGoPE7JN8nLxnw9Irw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 00:09:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 00:09:45 +0000
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
Subject: [PATCH v3 09/10] RDMA: Add missed = {} initialization to uresp structs
Date: Mon, 11 May 2026 21:09:38 -0300
Message-ID: <9-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: c44ad7b1-dd24-4380-d369-08deafbac4c1
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	IgdMAE2wawRMCzy/+a7GMFSKFWDdCzv+6rdEk1TqpuwPCxqNaUQu0lxEfLVyX/NtiA2MM5QexSetsomQNDjzNouQp6+x96mwnAIPk+MkwwEcxDowF4N29FGLdYkHhkDs5N0sLMmtwhiMrINEpyiMZyA9BX0wfVPQx5fbXxFJRMlVI+c4sqa7LIKMyf3dZWJeBHxV+3/Ldets4RGgwegaRm3geErb/tcdSRd4umNU+fzshkH12tc+yRpaVO8HgVdyVRxepkR3PYDVUby0McOTFDFFLglnPAUgdOXCMO7UlwURYVftPPIkeBReA3FGbrdvc3DIlFI2IAch6z7iHEjuQC7UZHoGUbRBT3CchhNge+0B2IGdTGk37txrk8m23ov1ugmlhYJukeRR+x54l7hjxxaPiHeS0/2JWcP9Tq1umyEhmD1d/4GdRqw0pc1bfyz3A63Ymo0lYTi2aDcWtwUnMu6+JwfCqJ5ihZSgUPc+M9ZORaZbDRaUf6723+InoP70h3O7rKF5z6J1B83/03a0S2FnTwXdPQrS6fr3wYs6hcM/VAeVp3Lc9qWg02XoXV/vNNEurXG1kblB69NM7e3kmqjdD3YCA3LHJPTFWPSg2FtQVfRNQLJJrDcoR7aPMsH6X+B2YeFX98jInYMUvyNq4w9UsjAir2OTE2xQrqbBnJf9UbyCBkd+mQ7FqOY3UaHH1Z80+xuz2NiPZqPvIZXqpq4oFTyf+VzR8fetsxDL7V4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7diTXAzCLcDIUbmjv8Kq4Tp4sahBxbqHFVLrYIuNY4F385J701L90nPnp4RC?=
 =?us-ascii?Q?j+8NoeQDQflwamzD8/Z7reUj/3dbiNIr+5YFD+HDi44V0LgQ1myy2NMmeH07?=
 =?us-ascii?Q?99F3e+zBrqyP8VMUOxwf8GK5UAZvJgs/AFF0CF7s4m+GOFELH3zUaLkHDhFu?=
 =?us-ascii?Q?wITkSIZj7YaUfQ47LOvz2PoQ4g0bjv3tOddTIuLMd5BXChRln/uxDzrRoqq5?=
 =?us-ascii?Q?5z7FcLeF30GJ+eBmqu976nZR3DytR5H4CDiAGMXZ9ytGnwXIcQYMtkaYvA26?=
 =?us-ascii?Q?HyDnPerq0HOK0nxG9UHLePbv9W/8/0l+uLKA9UHyI4FA1HT6ZOAJHn/gv/jl?=
 =?us-ascii?Q?/FEJns1YaEyu44e96CaKosclnN9INgcGzsnibq006CNI2+7PKmgXWMSDa/uc?=
 =?us-ascii?Q?Ezq5LhowEhLj1zP+OHV/yZJoxguevDee82WRy9xyBJO/ALsNs8CSbV2LN4Na?=
 =?us-ascii?Q?o7DZVqpk+zyi6Ce8WAGx3Y2fao3/GnyQMI/WySc4nm6TrLJknfjInZt/D3FM?=
 =?us-ascii?Q?FQ/OvIZZwLsNGvpHKBLdXWhvTPtKV51ZjbvWZzVThYW+U/NhrI4qeLRvCuJP?=
 =?us-ascii?Q?GyK3DxWiDIx4goIn2NdH9C478e0ybsgEv8OMF0rFBNRi0eMbXSi6QmVOYgff?=
 =?us-ascii?Q?i1NMc19vlUmxwzIWUKshqdA4akBTYsKRKBRyfoSJDDah77ALp+XHqM/SUQhM?=
 =?us-ascii?Q?3p+HSUgGhMwniJKENICOFdJYBTwtE47MK8IDo90rZgGfObgZ4fFkdmoGtIt7?=
 =?us-ascii?Q?u2xQKrHHGK1UzJHxIYe57FvduKKe+J+3/a1dJxLTGSgik39S3Mxv6fHFHSfE?=
 =?us-ascii?Q?CWdXvnrmR4olqfZJ7q41qkhRC256gGoni8fhBdFWJAc7ppFXE39mDCRQ0ggs?=
 =?us-ascii?Q?Y2y/4t7gX3+L3nr8Id44a3+RnviwWzNbjLz+RONm0eNtpC4B5yhZtwxMv3Qf?=
 =?us-ascii?Q?xcoxivfYgDlOBR+v4vxd3KhNlznhz2u2jBZyb5XKRZY7F42g0wEezAGzeOG5?=
 =?us-ascii?Q?L8v83Q1MGBdxvvRQmZ1vbxdF8/ecz4lALXvCujwnfyCbHzmuSHiVykzT+0fN?=
 =?us-ascii?Q?0A3Q6dQ8rbLOAq3h050G9+bxrGA4bQ9e9emAVNCJc4MkvrD1U0SYXGoaBfX0?=
 =?us-ascii?Q?HfLe4GRvRP49BwO+xpNHs2qulXi05L1v+kpo3i9SLbzPvoxU4WU+9mjVnN6C?=
 =?us-ascii?Q?p18CMkpZeoZSfhUlvnyNCtQlmN2YZfAVE8pRCcpT/a65jqg53ZayAaqNXqJl?=
 =?us-ascii?Q?EG2hLwRZquqXUDQW0rzZbBgsyR1IdjfWHXqSNo4YEFlVs/WUm+/me7Bcd2X9?=
 =?us-ascii?Q?1s6fNPgIovm9H2UuGWmGuCipPyXSMCppB2s8AxrYGI5obusloLTD7JV+W3Lu?=
 =?us-ascii?Q?0q7ueUGlr6PTDVE3H46sZZk1il2A4I5jkeQOS0KaZiUdHhIXdswrYTEWmw7t?=
 =?us-ascii?Q?j9LBnm+eqdqLJFMgKilvgJKpCLgr80vszNYirORXlO9ar7p7TTCybX0bGa8X?=
 =?us-ascii?Q?uJ/MM3fD3wnGkhDGkI9OR/qDD36VjWzu0i8bWjeGs56tmrjCtAP0usNvaWHL?=
 =?us-ascii?Q?OqUu7rxwxlaJxUG+qO9dmxn2NBzAMLcQ+gwsV46BLCdikS2CbsGQZs3CFniP?=
 =?us-ascii?Q?blqJHwuDPAudHC43PXPqhv7Y2388MeylGORGSMh98QLH2wDYiEzRZrO/KyPU?=
 =?us-ascii?Q?kPVEXfnEnkWSnoK6nLd5XueUyyGTrX0p73cMhjjObp706Xsu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44ad7b1-dd24-4380-d369-08deafbac4c1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:09:43.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEWUaXPPKiMl31TM++uOTT0nLAZKTAY6DVAs+UZAW/ppgv5cl83KpCTUUNqkbHxR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698
X-Rspamd-Queue-Id: 66607517C5C
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-10770-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

All of these are fully initialized so no bugs are being fixed. Add
the missing initializer as a precaution against future changes.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 2 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c | 2 +-
 drivers/infiniband/hw/mlx4/main.c         | 4 ++--
 drivers/infiniband/hw/mlx5/main.c         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 7ed294516b7edb..ccb362d6d2e669 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1884,7 +1884,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		}
 
 		if (udata) {
-			struct bnxt_re_qp_resp resp;
+			struct bnxt_re_qp_resp resp = {};
 
 			resp.qpid = qp->qplib_qp.id;
 			resp.rsvd = 0;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 92a65970ab6fa1..c8a35337ba51e8 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1977,7 +1977,7 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	if (!rdma_is_kernel_res(&ibcq->res)) {
 		struct erdma_ureq_create_cq ureq;
-		struct erdma_uresp_create_cq uresp;
+		struct erdma_uresp_create_cq uresp = {};
 
 		ret = ib_copy_validate_udata_in(udata, ureq, rsvd0);
 		if (ret)
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 25f9738bd77223..d50743f090bf21 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1090,8 +1090,8 @@ static int mlx4_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	struct ib_device *ibdev = uctx->device;
 	struct mlx4_ib_dev *dev = to_mdev(ibdev);
 	struct mlx4_ib_ucontext *context = to_mucontext(uctx);
-	struct mlx4_ib_alloc_ucontext_resp_v3 resp_v3;
-	struct mlx4_ib_alloc_ucontext_resp resp;
+	struct mlx4_ib_alloc_ucontext_resp_v3 resp_v3 = {};
+	struct mlx4_ib_alloc_ucontext_resp resp = {};
 	int err;
 
 	if (!dev->ib_active)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index fb9689e453bce4..03550b12ee6d1c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2773,7 +2773,7 @@ static int mlx5_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct mlx5_ib_pd *pd = to_mpd(ibpd);
 	struct ib_device *ibdev = ibpd->device;
-	struct mlx5_ib_alloc_pd_resp resp;
+	struct mlx5_ib_alloc_pd_resp resp = {};
 	int err;
 	u32 out[MLX5_ST_SZ_DW(alloc_pd_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(alloc_pd_in)] = {};
-- 
2.43.0


