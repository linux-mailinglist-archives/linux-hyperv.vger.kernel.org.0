Return-Path: <linux-hyperv+bounces-9783-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELXQCoJTxGm3yQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9783-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:28:34 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD62132C75C
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A9F130530BE
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5EE39023B;
	Wed, 25 Mar 2026 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ALEcG5IW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB17A38F928;
	Wed, 25 Mar 2026 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474039; cv=fail; b=XZl32FJ5lITpAwHK+khym8MbHZYleFRri7CGpeh78vkBwM/cQD1348qI7hCEPeKwRyIlb3NfqN5WhlWCW1S0ZKMTTCPmjJ5cCgQnfjKsqWGksp6ckyJ2R0a3Z/8ab0Srf67VaqkS5cLP+NP97zuTOZH0XpQJYprOxVAMwgl7k2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474039; c=relaxed/simple;
	bh=XCW8Es0YQaAcmwPyPoedyJGAqZQFZuMVCrtx1LUimTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s8tdNYX+WibStyNcszylWiDaSWNHrZIGmYt9xH4czRbgWI9Uun4VQnR0WHj+XNmTZIxXCWcRUgQuoO21J163WUjAJqQDojHibHm6l55tmpPkGCXip930Smm1rtjQZ5c/VQrDJXGalEHbaJSyqUr3R4Zw+4qIBknFFnlXD2LUE24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ALEcG5IW; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxkqhmTDbOcRS/C1wzMr6Uq4Fs3/88sbFVF+bBkFmFa1AXNEUBo99wTB9uwUeNw98Wl4lx93MWQtrGDgxQ/a1dSbaPprSTterknuLZVLNxhtkMsqtnXYiItx7it1Obe6e3BsV1GSAbj+KOGhIWLOh96E6Jaw6AK0dk94ahY1Bok/AZkqHB0gdoCUN7/CMUt80nPDHif6yeOb2oYRmazAEh8lrJTzZhZ/4dtf5iflqSZBUmd5HhP6CBXHWUBCE8cSay6Im5MnEDy+5RmWyc35GKyE64aMpsPbiZv/Sb3/rQgRs74tekrzFj45736fOnmDiJMNXSIg8BzEwnB0UYr4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGDtxyGmC24lVPFRdHFLAd3vVimg6ASRxy27gKrvISc=;
 b=qk8k8QWHMzx9+rWTO9vBqwuy4xyrq0x+iladeirI+lyTo8qKLRNFr4fXTCmelLfPrbBR2/wpl4dFebAL8FY+dflk8ZPE5saffO7UtwpKle71OMuRopHdWfxn7Kz6+mxTT7JzyH4f5zm+vqnMb50agOJIx15tye0gQpnk2TAGi9NPUPtacV3X1slicj1yEkr8O9vnHN+W1ZCo0+QOEFvkW3205AaI2xrBJEv9EYEoRqyCf67WLphH+8HefMr5vgIFMCv33+8TyiQTXa/3HkS5d16afLLv5KWaGgnlJHU97EcESowGLOIFZE2fBgSbVM22C5dG5LaBKW9T3bTFn2uXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGDtxyGmC24lVPFRdHFLAd3vVimg6ASRxy27gKrvISc=;
 b=ALEcG5IWwXYt3Fq9Ht0UAMcGfQiNP7s4aDKOb1BC+64zfCCO4qJ0WFSzi4LdZJNJRQ6XDyu6I8mZPStlLjkyYrovj70Fz2/8jVbLRnZoOLfjCkkelxU1Ts+iaXf5oplVRFbCcC6I/XyMZkoHt1sZqIq+tU9SVd970FM3vb5ntJ2kd6Q6pC4JKdmzkwjcsy2ELt1CXYVisXwBJZBpJYf2HNHkaClI/7bF6Nycsrsx8E38zJ6RuNLqZjVsutYhH8gsvmu09GA8gnXKgl2nIXqRnhLgaxKyXhDU+PuBcFB0qGo/MAFwuWx4jDlxfCFOOPQlrvTUVGDHFAYglcoz4yvdyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:27:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:05 +0000
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
Subject: [PATCH v2 07/16] RDMA/mlx5: Use ib_copy_validate_udata_in() for MW
Date: Wed, 25 Mar 2026 18:26:53 -0300
Message-ID: <7-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0443.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: c832d725-fb43-4bec-f92d-08de8ab54293
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xfLtiA9VmGkLUFbGnELzour1W/+8BVP5grH2WFk7Rwhx7pAV7sTO0vWIMT2XTMessVzLAWNylah36Ch9Q9TQwA+6EnSkhtEUWEdqntjdePkUHd5bQ7NonGDjVJjY3fiB0HppPW8tqXCVmjloT38l7n7JeNmLzmLCY8noWIlWHok0eCEwQqpEYBRbfyqZCwYziuAzfb8nmQwrkkbaWPhdc2/1cJhGQFMFmAr+K8QnEK5gvhjI0JGiRpRQXI7/fanyP8fEVGiLHlcVsahmR1KNTEl8qGX/491o7OHI4w9ALoi3mYeBpU8ohbcL32KZy8dVze/7GdAQkWXUTPtXRsmiu/g0D+0NDPTarXc7NQSch6/3DdNUOm4gSdI3f+taLeDKo56/gIt6ScSlzB+qyTTc6cVrjnSADtuxJDc0M0caNeXYJk5LNhgMMzfUhvMtedOp0EgVM60w4UOcANATuAu6K3dNQ+nrFmZo+Y7/FqMMMgscAtlJXerA3KnwgwUr3xGI6aNlC/VMwAk0QYxYp6sNvzfdRNP+EgLBt5ArsXgr4e14XpYPjrG51u1IsOyM1rrENGTWOVbfRB6jo8s7PCk9VWc179su9SYrLBtFAn3/uf5gWXyYY9Q17DkFKLd19QeXPT1tjeJuV+h40GwRGPKpjGhbQ+usVggKu8X/044MHlQoJciOWMvgdUO1oYj0QpQ/rTbTr5UnbEHknDKYIVK+CJHIk3/D2wlemAKNLZ+hRwj4pYJ4EeWda34S2/Ku1Q7wwHZ8AGtqO/fsY8i08gZ2mQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5loexmFd1+5FrEsTbSfQxjDQPuVUyZyZHa03ONdL4lBi1hpJplJx53riCfDh?=
 =?us-ascii?Q?9xmU5GmBUat0DmU3XlJYlwn+ji+GLlw+SlqFeiVHDHV7MYkerRhG6UbjkIKw?=
 =?us-ascii?Q?24ENijYE5K0EtSw8LTelhG/kxlCKmHv5fSsFvJfxvQDy8Tq80KX0eimgGDk2?=
 =?us-ascii?Q?jrgmzZUKUVPIF3a8L80zMkqaxli+UttGWNoXuwUJnzODE0xVW/cGb7O6ege+?=
 =?us-ascii?Q?G0svtc6rym2dqJ0eRsD3ECTJ5ULnA8NcVV7soF6qdbhjo/07YYoaJX6VEj1T?=
 =?us-ascii?Q?/aLRThULD05eALjYVAp5blFvbMBlKS5FHJ1uTr8UEfel60JankhY4gL6TCw/?=
 =?us-ascii?Q?tK51+eG6B4VHW9aWgVW5lc1ehg1wM5kNEBCDh2RG1dB5DA1rCKoMRb1L3Awv?=
 =?us-ascii?Q?A3GUKcvbHOveJI9KwOOaXphcQs4e7xtxhhrVic8BZw8vPoi2kgkV4VA/zPdE?=
 =?us-ascii?Q?YV/g636AEDF79EyZn5KcIMle1E316/lGfDTvdjSHLWk7ZjZr4a9jBorhfFsC?=
 =?us-ascii?Q?kDfxTM4nYtswwdtR8EaVv1a+3jaM7dVbJYHPRnzWHjJh3yafTFDdqHGX/vxN?=
 =?us-ascii?Q?S/gNPtvOhPAp12RNws+k8OXH1e0AIJUH2tu99hZQ+SAndM37wAYiJUtJ+Thm?=
 =?us-ascii?Q?vtARpTT8ZTDady2C8AWYcLa7//GJHN2lmU/bnZkJ+1Mx2Cl5rSRpn0sbXro1?=
 =?us-ascii?Q?u297yKxq4L7hiq3ub6bQefRhExEsmuISdlJ8BVhQ7CwVgM/OuTHZNula6xzT?=
 =?us-ascii?Q?pL+ui4aMnyIXFaDvMEIAKR5rj0EhPwXiGl8glTJhuBiHislIOHxbmrr2x327?=
 =?us-ascii?Q?4Jn1IFYeRl2fBmBc54Km4nwLHTf8Oq9GRL0x0HL3Ev6W6lGfME/d8T1kiz/1?=
 =?us-ascii?Q?pC2lMrBbsQ5658FS4W8fcEHydUnoU3JiZjjF/Zr8FtiapLI+MLdSLUk8Azaw?=
 =?us-ascii?Q?dVO0bDN0T5Aw1352QunJ0L7/6Z7NGqJxy8V2gKLNYecWIBDRl9ME0rlJMj6J?=
 =?us-ascii?Q?KR/ESi/69dfeq6HgcAgX7wEJUKxcGSm2cc2Yi30WMWEnKj20GQBWrgG8LveE?=
 =?us-ascii?Q?CrcwtAIzonS/CYXKFHOrlx7R+o6YW+LDCXVJC2Iaelp5PjIIilcwhM8EyXEQ?=
 =?us-ascii?Q?j56YmAS0wEmbGXooZT44QeOpPCUjcQqAK8tYB+l/jwFfXrJPN2gxQlFJwqb8?=
 =?us-ascii?Q?6LGozGq6+wGVwtWB4eS1tKj4ULCmjazpLMor8zthMUxQGQKXPTa7odVo5WkQ?=
 =?us-ascii?Q?QY7UUKQQDZCuDxJm23/4CikseRijtf0E4+QteFt4vL1bXnlzupdZKlfLaT/d?=
 =?us-ascii?Q?ikCXmHYoBuNP6Nxyb5+j93COimDt23kd2f9hp1htoqYqXRrram2PrqT1IPNA?=
 =?us-ascii?Q?TzT0txy5pltpFWXnA75jIgG6cq8oRhqJe2BtJ7cbjf0dmIJKs0IR2Q3uHfrY?=
 =?us-ascii?Q?Wg3wk+R/U2wMHUfgWYd3BWkSaw6/RhobbNsokJMZR1dyxyzU7Wo+iVHrbDpr?=
 =?us-ascii?Q?8UNd3o4/817dkHBnqKBUouts+CN8JP0ze3V3s8Lg2CtKqPAzWhY80jS1VuQs?=
 =?us-ascii?Q?URGqRmqoG/QGWFItXH5Or6gNQSm0iktOA7Eay+3YAuxYKihB10gObhcevkKX?=
 =?us-ascii?Q?FWWpQmk+UWiDES7SdnRacJehokNzlE8Kdx5omsLaNRxXaqnZOwVQrz8jiEUa?=
 =?us-ascii?Q?8saEoBz21XW6L0CzR7jOvG6Rm+poR8gc1ycn3utQBROCwI84?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c832d725-fb43-4bec-f92d-08de8ab54293
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:04.6388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsWPMp2eaM3h39LFCaQKobTTRuayk73jfppG1BNSfjx4zrnR4ZWI7OBssudF/VIi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9783-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD62132C75C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The userspace side on MW made a mistake and never actually used the udata
driver structure that was defined so it always passes 0 length. Keep the
kernel structure but this conversion has to permit 0 length as well.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index cbe34251e340b9..3ef467ac9e3d15 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1774,16 +1774,13 @@ int mlx5_ib_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 		__u32	response_length;
 	} resp = {};
 
-	err = ib_copy_from_udata(&req, udata, min(udata->inlen, sizeof(req)));
-	if (err)
-		return err;
+	if (udata->inlen) {
+		err = ib_copy_validate_udata_in_cm(udata, req, reserved2, 0);
+		if (err)
+			return err;
+	}
 
-	if (req.comp_mask || req.reserved1 || req.reserved2)
-		return -EOPNOTSUPP;
-
-	if (udata->inlen > sizeof(req) &&
-	    !ib_is_udata_cleared(udata, sizeof(req),
-				 udata->inlen - sizeof(req)))
+	if (req.reserved1 || req.reserved2)
 		return -EOPNOTSUPP;
 
 	ndescs = req.num_klms ? roundup(req.num_klms, 4) : roundup(1, 4);
-- 
2.43.0


