Return-Path: <linux-hyperv+bounces-9791-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O3gHFVTxGljyAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9791-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 326D132C711
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2E1630358BC
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F70C39023E;
	Wed, 25 Mar 2026 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YCU9V44t"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDC438F953;
	Wed, 25 Mar 2026 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474048; cv=fail; b=tkX0w/AcCgcVP4j5sTdNJ27FBi5xECGS0uui+U22YTsRoLSMsikI7vgxlpcYEDlE439Z3vlxa4B4wl+xOa/q3+ndJCHZ3OXtweHjWigo0ODy44dYUAblX00awODvH1dpLmhzPl7Li/YPVz3xH/bWBecwDHfNPNDJVKYqowKXYEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474048; c=relaxed/simple;
	bh=Z3981UpPawLdLRo8q9k5oi4KXtugvs7vb/CHsbWFdeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nl9wWNhsnVEepeiMy52Sz9A05/m8nwf362RzSYygDnQYcISap6Lxpzs59wAtEZcMmBeKovWApsHPZs7Pbckj5t5uU6WMS1iK4n5VyVsieMO74y1G1latYdF4wDfAlB8kyRcGT/hDKko490e/QKdkWXl/0q1ZoQaoS3wydXph0mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YCU9V44t; arc=fail smtp.client-ip=52.101.193.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyMthpgsSGnTEkg2MIn352Ax4Xpc7QVcRN1DgmNgOJzu4ZADIJr+S1pCzNOk3PSrg+RBhL4/fTK8SnEO9YQSdffXGuX9cpsg+uqkmNSwry5xunX4f0Hik1oytajMdNjwIoZtoINyAznPkibdPtTPM/TDhRBhofcThaq7jNE+QQWXDuh3pv/By158dT/668R+6rYSNCdpcE1rTJKidNsDci41+VJn9zJSoBcwYuQfNP0YEJax6u9YjgLyaW8420LBaL0Llsms83lE99nXNyej/GEHgklLyauq0VkVLGSlcsIZpdXtLGejnEeg5cxXqgJE8Iam1esnK+aZWN56Moasnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2RS0JQBqPFdufP0F4P4JpB4bAu2ArGz507iJLQqz14=;
 b=mAkpuITSKz8AymY28Q31N2wziM7Lcyfq8WdZ16kwagjLJOzP3HUbIRRDWQoqT8ykIQGrGKdI+isZCnN4O4wlJ9jar7K2Mmslf0nwhs+Ig2Sqj6rk7HWizVwvIlzrCNTKm72CJtyKojYPiieu/BYmCaCEmFxYRa+KhNTXOTAoN6j0V+OPMFGTmHNOMtIyxlETad5bl4x96eplR6PQVfopqRWYoH8KY/8Yqp5SUK4671cEpomrQ7T8DZ/c8VGssJQFZzkaW/1cXEXSxQB0o8uQ/K6ya+QPbOrBbWSLG3TNY71qkilYzgIs0BqaeRFr6nLZ/nT2hJbwSwk4XBK6VHFu6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2RS0JQBqPFdufP0F4P4JpB4bAu2ArGz507iJLQqz14=;
 b=YCU9V44tBCTZMtL/jYCQappGrpbq05Cn5FQjtJDCEvy2vtikAnmzWeytdBN7+P95V4FdGonG9VPIS/TRAbY0qEpumMRLweAGqvMLkwMi0jiMmWODBAp2W8TK7TyUHilJF+x0gBynWMEa7JcCzFo6mn1w0GEFY6rMduRGrTMMekHh8CqIbKnCM0hybwlIEcxC1d+a2gXPvdd5VhhqOC4FuDA+Os/XBezWXcKpj8MKWm5feKH7xq3YD4vUMzCG5z6mBOV5bcRbQFRco8zkdoAoaHLNJxU5W1AgyQMkgc6Oq27wHmTTZagLaExtecoq3S81oqzebKu5laZ3P1qgbtNa0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:27:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:10 +0000
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
Subject: [PATCH v2 12/16] RDMA/mlx5: Pull comp_mask validation into ib_copy_validate_udata_in_cm()
Date: Wed, 25 Mar 2026 18:26:58 -0300
Message-ID: <12-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0429.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e712c49-40ec-4370-f9a9-08de8ab543fb
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KQ9ThDN7QLSR1dNGzzdvyoJkOwDQFWtCx94LqCkxyAA2ERz2BsuaPyrpiNI0HdjqdHTCwrUZvJyv2fkOL/3XsHZOoPxYPfnjOatjO0VCaS6rx04LBtcRq2uGebhCsiOt4uJiMvWTNtyF+UqDYCH0vQuvnpaiVlqjDlkPkxflAYeJw5WI+CIScJSYjnH2YR3DQqE5aLjpcidc7gBQrTiuFZDCfvFZZ4mXti4lGujg16EriNnYLKb6c3BKS39uidVlnx/rB94oDYOEHcMMf2grJapSkiNy6vi+vKQZd8JWuwHay+/2vY67zS3ZMmZD/U2VJLGz+MMtZrEcuaSYBL7e4ir6eK2v3nPae7loF1FAQaSWcie/NiN3t7Ipn3JKxNcqGeIEJGMgavb1hwngSU0szBxMCM1hLyyZ3hJHYv8pd6PX0/IkZOo/vrLJDoLFE2PrVCSK5VON0rfxMYq9+e0SDHPlYSDh50C+H2hIYUUfMj0spvpdGQbbRw2431veQCvtY3mR2OoTTLoknFJWcztNSmEUphpK6nyrGA/eiOkdI0NNBICDg+CVzEYEeX1sUSbJSIHb/QBIdR2edznAnM1Qb2L5pzqQD42p27p6JVjgvbOduOeRgdf9uqgONhesKoCoCBP7ap8jBsf4j9SIwNYpv+HRfCqllYbnZ915qB9TT3B+xdz+YazS0TWlDdA8HCwA0qEfqlaBcVlqjKG8ibk7iGC+v9Gl1lpPAdLidb5moDS433X+0J8Lsg4N3hQrKeBPeavQSH9b5EUsm66IB7duCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kqLhA/RWzwqa1ps1H60wNIjDpLgGiAwhDU/tPA+04eSovuWCGTq74nQvoTvC?=
 =?us-ascii?Q?lPMlviKzFkildE34eWFxtJ9/Y91ZcjlV8S/cF+q0nKtUDr15HRd22Dg835d4?=
 =?us-ascii?Q?AJaHRJtCIR3a2kXyUi+gkuZMGcOVxQug8MKcIQgdG46NvncpOWFQFXLcpndP?=
 =?us-ascii?Q?FxZ+17Kl9O/MF+EQaZ7actJM4QQqQumwWdDxNfTmGi+0TsFxM6VXe9WasQi6?=
 =?us-ascii?Q?Wpc1uadJRPg3hXzkZKHEAvit63gI9PSL6meEJxsqkIY5AlcgVHU/N3ahEo55?=
 =?us-ascii?Q?fMK0WCm7O3oid0pR6BTLNs5ALHH6e8vpVuMonAaglJcI9DFRVSJKfvEyx4Q9?=
 =?us-ascii?Q?YwohqiJznn3rOSXOOIT6AjAT1uBbeifGYqRsXHaMkFksUXX1F17arjZA44NH?=
 =?us-ascii?Q?R2mV0X/lOcwOvi0fd27VX68q3ArwdEXgqTO+udEZ2qUVn8J0L8yTiKFx/vgY?=
 =?us-ascii?Q?HjErspIMe6HVGObqTBGwMoboSXxkGxqzFihSwJnVgIbhRRzhxZ/hGv+ZSKxX?=
 =?us-ascii?Q?y896AYsESS/aZIHPQIv5jUBy6V8tF+JK3QcZVOw/BOPzERnU81pnyJFfILo+?=
 =?us-ascii?Q?gMv/qM0qnOOdYMzhwk6X0aDElGQhm9wPedk6S7CuyK1Ra0bg1uYHR8Esdz0z?=
 =?us-ascii?Q?gHVm+t3R2tDjpdFyPzQ0bWSNHowQAKUyU6l48A1SLRaHZOYPnLle3g97JkN8?=
 =?us-ascii?Q?OjhW5eqVFqsrYoF4O3plDK0dbJI7VemUZMs902FMSVuOLi8JO+yY1wjsPQml?=
 =?us-ascii?Q?r5jkS6IfEtGlP1b2i4hyP28VgI4JkYPQKxVMKzIa+Dl9dZi+bsqZUPXWpVXp?=
 =?us-ascii?Q?liTVadc1xQBJzSv7Fq4sJVcoT10vmwUKBEXgcy8NBkmVI1lWv6oE5XDWo0c7?=
 =?us-ascii?Q?yY6BkASKu1HQkrcc4t4rOewbC3Ac/HLk4MT1NCCUKL/Xv8oUj9JeCYjc8rYz?=
 =?us-ascii?Q?wNGFco/wtc3okUdaS67hIzwqug+OqIcvymi/uptPga/K5U1jhw3RtlDxcmE/?=
 =?us-ascii?Q?HcCXYmXTA/JgGT6NGBkC9x/Di5Z1OmJqtuGpFKfWjkDES3KRwziwlMqOfZHC?=
 =?us-ascii?Q?nBSMbYAKsuEX9T10aPOX6we9ENu5gkC7hhSeUTV+fAazsFV0iAnCGU6pV4gj?=
 =?us-ascii?Q?EBSokGoJQOFCfp6xuTnE+UKqNslqZlJJFkIwU9ro0NiVz+aeh4JBQPCJffr0?=
 =?us-ascii?Q?tgAWC8Ju7/qrIyOuEQZnxD7eU7aGoKHFLVNfbNlX6CFkBQMQIoHRRMc3DTgQ?=
 =?us-ascii?Q?4yp2Zi5sJkXilDNWeShkQZQ72J9I/t4wfbA0VuDXTczWzXSWOivM9430P+Us?=
 =?us-ascii?Q?U0Toi/taiJmYEmTvIOa2C0xZ4EFrny7S/zCwxZZxGMrpb4RcxVczy6wDEhh6?=
 =?us-ascii?Q?yIHvdqBakesZr2P2DQvXP2oU93tjAlr4QLQRGoBPPI0iQzu2VHuGCHbjSvRo?=
 =?us-ascii?Q?/hTBpDPTurvxv8UzQzdBPScqFomiJwGaucP08R9yk5xAwgyHdpWFs3b47AtN?=
 =?us-ascii?Q?QVSNgexSytAFkVbhCjVmz72pbz7bjtb57EhFQXubSMcE8rzVOj2gYmm86t5p?=
 =?us-ascii?Q?BppVA7SaLKTeZLYc/L3Sx9KwRVH++kQ+nlROm6gNT+fV3wV1MWscfcZcE8pr?=
 =?us-ascii?Q?nRROSC78Dbma4TPBP8aNdsvp1yhXqI2I1Hv245qTVusD0aFdi//Xz3HLTjYy?=
 =?us-ascii?Q?VddyLWIwZTHENhG9rN9lKad51QKVseROXvjQCNfo7udOjpVX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e712c49-40ec-4370-f9a9-08de8ab543fb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:07.0081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIEHc4cFSSn+/P/3qgQcgiMBtrrWVdjX317lg0msEXl86X9NsprkfrCmZ6lhvFck
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
	TAGGED_FROM(0.00)[bounces-9791-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 326D132C711
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Directly check the supported comp_mask bitmap using
ib_copy_validate_udata_in_cm() and remove the open coding.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 68c6e107747693..3b602ed0a2dafc 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4707,12 +4707,12 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		return -ENOSYS;
 
 	if (udata && udata->inlen) {
-		err = ib_copy_validate_udata_in(udata, ucmd, ece_options);
+		err = ib_copy_validate_udata_in_cm(udata, ucmd, ece_options,
+						   MLX5_IB_MODIFY_QP_OOO_DP);
 		if (err)
 			return err;
 
-		if (ucmd.comp_mask & ~MLX5_IB_MODIFY_QP_OOO_DP ||
-		    memchr_inv(&ucmd.burst_info.reserved, 0,
+		if (memchr_inv(&ucmd.burst_info.reserved, 0,
 			       sizeof(ucmd.burst_info.reserved)))
 			return -EOPNOTSUPP;
 
@@ -5381,17 +5381,16 @@ static int prepare_user_rq(struct ib_pd *pd,
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_create_wq ucmd = {};
 	int err;
-	err = ib_copy_validate_udata_in(udata, ucmd,
-					single_stride_log_num_of_bytes);
+
+	err = ib_copy_validate_udata_in_cm(udata, ucmd,
+					   single_stride_log_num_of_bytes,
+					   MLX5_IB_CREATE_WQ_STRIDING_RQ);
 	if (err) {
 		mlx5_ib_dbg(dev, "copy failed\n");
 		return err;
 	}
 
-	if (ucmd.comp_mask & (~MLX5_IB_CREATE_WQ_STRIDING_RQ)) {
-		mlx5_ib_dbg(dev, "invalid comp mask\n");
-		return -EOPNOTSUPP;
-	} else if (ucmd.comp_mask & MLX5_IB_CREATE_WQ_STRIDING_RQ) {
+	if (ucmd.comp_mask & MLX5_IB_CREATE_WQ_STRIDING_RQ) {
 		if (!MLX5_CAP_GEN(dev->mdev, striding_rq)) {
 			mlx5_ib_dbg(dev, "Striding RQ is not supported\n");
 			return -EOPNOTSUPP;
-- 
2.43.0


