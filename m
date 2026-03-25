Return-Path: <linux-hyperv+bounces-9785-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D13MEhTxGljyAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9785-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:36 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8208B32C6DD
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 067DF304246C
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC4B38F951;
	Wed, 25 Mar 2026 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qVh2tQet"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42829390982;
	Wed, 25 Mar 2026 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474040; cv=fail; b=NXup5H6m3JzRIfPUGcpiwFFcWXD5crNqmyF2BGSbSneyllxK3ghS6VS2uWA6QvLP+MQuQcysAZFjqccwN3jKsLP3CZZkb8VgxNg85E+Exc9pFmsFVIhqM0F4PrWr6ufN3u49T0dGmXDA/afgOgX1no/NCaOaMkakSs0ocNIvJl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474040; c=relaxed/simple;
	bh=UvZ+nSgal1mcum2pVOvH1pXfkeVHF/KzzWhpM94wpAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YHqIYvg70hfv7vIAWMvD/DJmHvQGA4LhMbIxWHp1Pyjfl++Wvg9AE13q0TveS9NMtQDksRztnTMo1lRNRmT5gjuTxPox8Nbn20dvZslrn3WdC/8PEHVf0KOl5zdsfv8e/46lPj8Q9NzCNKP/f+cCk+YLJV+GijUFqzbRLjXWzJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qVh2tQet; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umSlIBpXLnt+R5s+OJeG+GSEqSAC1eYmq6iL6aqp5mAeC9bib/vwJgOSpO7eEojc/5qVSJ05spO9SPw/d93vctDdvidSdz5Wr8VbkMmXNRuDth3ylZsK1kdfRbiDMqxaU1Lb3HmiPVNXJc/ZMBM/ff7yvXOpQTgmXQbwcZGYghrAi4XJNJ+7axNAYkSObb2IU/+29snIzR3x7lXyjojZEvMNnxNRvljX31ww7fVxO0BS7yKjmYs6oNmnAAQFWOkdtwgPYXdIBeojif7kae+BuL7tFsSf1AjXpi8l+jGbmqE3vBi3CyJIq+27j5pJUABHlxxP9+K/i0UoOoIsqjHzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMbMWFQU0xDcDrvZohhShv1eXaBFW3/Ka0zE/8jlEKc=;
 b=v9ez6+ETKV+TUR42x12iuAAD/isNQRdre7bTeIHfRr7c/w4FcSBgt1z4WKHyGDXLtAOdTuMbqx9dBKHJcZ2jKsTD/b/97XVoQAkrZ4+/OQLYpmMTs2WylzSDNsLTNyDi25eRl/lqVwgAxVhMpVJpBXJjs1xNlmZVOyWO3iVICWe0pOUTozuPBjx3fmbr+qjvhBgpoMbw+JU3+ezLrwn2xh2O+2p0AmCJZzz3nh25pHFjcXEcDCKoiBCMEjF4V6R6L1NviHSLo48FzBdEu7J0Mgs0BCbgMBle98hMqTDEtm0RBkV9VqNTGo8PKv2nbFW38C5ybLXH0BPMgktvHHfL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMbMWFQU0xDcDrvZohhShv1eXaBFW3/Ka0zE/8jlEKc=;
 b=qVh2tQetZj490yNqyUY/lE9vQ7zA9CehJbUBTaXX+CswR41tANrNeJZHs6LZCGmPr7yH/Fx4spn+MZh7c+qbnalURBjgya2TZ3eVYet8gpJhcL3Kce9wcdDulNzjudVORVJjfECyTWGzh3P7MGFPeGi3FYwgCSReP4A58gAlyfRHPGBSAPGCBX1WJ5pg6IMhE4Na++nwCS3Hx59ao+ofaC/QerYXpkV+K7zPG+f9bsbZve++hF7T1zQjjdFj0U1pTVH5Tw4lgYD/9o7Mw93HZb1h6ZD6k8vlLxHhWTxWKSDIIFe3DvX79c18OTLmI7pmcHPATevkNr42+f+A6hekjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:27:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:06 +0000
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
Subject: [PATCH v2 14/16] RDMA/irdma: Add missing comp_mask check in alloc_ucontext
Date: Wed, 25 Mar 2026 18:27:00 -0300
Message-ID: <14-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0013.namprd19.prod.outlook.com
 (2603:10b6:208:178::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: c89470d5-b29b-4668-f149-08de8ab542a2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 lx+S9gznAV3vfs1wwudTyui4ZdZWQxEL9zbwRTUGAPLsERKCPW3dZGpUSaNdpoTMgiOayhIMUBEOkNHyDze/lAD2Ti6U3/ZM+WEX7+2Hl+gc9bY+TZcWErmLzxqUajj05zQsORM3VJqJxT8IUDsyIERdgCmIG5RqAXEWDs0qmrhNaLcstR7Yw3dO+2kYKpfE6F99c8GZgxF7vBE0HJLJ3Sh9A5YT1jgvjJyCVWk/Lo8xDHrlY8o1nwLDPvYAuym/3ZdmNYjZ7e4prz6oCMo5V354KJEqsBOhlpRN/9DA+YZgdqZN3F2znz8U8WCgw/Jkg0YB2r422dhW0lrUk/yaHiT56qcIjwjgXJXd8wdp8abcMuhhfQc4isNeboPaIreX/MVOZD+Tqk8g2iQp4jv0fH31Wq8a4vHuZrn/lx+u69Gkz4gDeWgczTLK+qh3vSvpxX7VeYvJ7MULtmjIzbEegJglrgCOp7n9V1eGa6ao5XnnW3YMpTGZ1zZpbnojej0S3Dz0dqrMWG+6tIvOWjDPXyvOL9HDRXmczfdCbfkcmAGvqa7xBYJOzAdU8CR8f3AFMY5DGXsYfvsiovdNmr+GqLz+XTL2ZCNGczPsoWtsMMgK9d0IWjlmUEB7U0fldx/2dIKuHpx83CSp4Y29M7eAsP7GeRjSBMw/HNKw5nlPB2zYWW88pdUWUO3UkVNXm4cFktZWIY3p02cSlmljMKBMTtOUsMIlGr+nU7XQ3a52PFFZG/252px2qiY+qJpTa/pd7Oc5lxX9kWNj/C7ay7Fo/w==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?xtVP5eJ9Ywa3gRk1rOLKxHqizKxSBN9/fZ4TRDU7jTKQL7I3XaZiavIn9FFq?=
 =?us-ascii?Q?riVbnXlKMCPsarocwy6cNbb13Yq5PsVb2CTT/D3IXUBEK2Pb40i2kCovUUGY?=
 =?us-ascii?Q?SEUQurTFefm8cCIlOASQ9geiHPYGjX5torZWRoCuDpdfSjB5pVDxTAIZAo5F?=
 =?us-ascii?Q?gOdFvtWXcnGYAdR2jiSf88dYeMXXbB4Egbr+/oDT82uVOqW5WZO3t9IvrqY1?=
 =?us-ascii?Q?7lQuDFiALKY4Yd8lmtmpVVCZ57AQ1wBtiHlEwaajwRhQXxoVr/KWFBlMSxFB?=
 =?us-ascii?Q?c+EZBBukoM1jcm+Ro9/iKF1Rpk335aEBxb9j3DbA83UlLutxbx0oGS7oXQxs?=
 =?us-ascii?Q?G4GSsUIKnlVP9HHrZkMndCH0NS2U5t/XFxtxE7YfI2PmjbqGeobtIS0inRxG?=
 =?us-ascii?Q?t8wqF85rVkKA8mFqV1jDtEoxXlDeAcAHRuLCoUJkC0/Z0CIRs4pyZ6HRFPAQ?=
 =?us-ascii?Q?RCW1AKzBcT4pB96DTxy1TXd9Czsz/dFCVelGZDXuXHolbqQWLhwEPSflvxxN?=
 =?us-ascii?Q?zdvjzuw/SeS5iKSfwyTEqgL+66H8ObnpC70JS5nMI4J6tXFOKWMxsOMQVGh4?=
 =?us-ascii?Q?eRMYbGiAM2rxHv+NTYdFFRom+XGxsuRY2Y5Uv4uXgRGLhJn3De0tFsRU0Fp1?=
 =?us-ascii?Q?BTUM9g+9xObMCmsSsw6bNqzyOEi69BX3YbWGr+1tGmqg6o4nrxPJp6WEemS1?=
 =?us-ascii?Q?BtZh0nFSFxYgGuqEzHNwsOkVXZMDnI7a1L67IugX7JaytjbueizEbg99Gc9e?=
 =?us-ascii?Q?hO8iKIM7Xfqime8j+obMZvRkYbVijbHLU7hfbcIIUMcl83HdLEFUP/26iWA6?=
 =?us-ascii?Q?RguIBlC20UGEj3GCCOL7pyLiaZ1LK2k4kysC2GtPbRPWzSVHG50042wNNaqB?=
 =?us-ascii?Q?/7BpBC8ElE/yb/gMtHkXict0IZNJ2XcTd94cmN14mtk4wlX3mcyhwNZmzwpx?=
 =?us-ascii?Q?3wxdNo98xU4j+E9kFJhlULgeaJdGCGHWoAoPwhgvPK0N9EnmdNYHVO2V1A87?=
 =?us-ascii?Q?g8G8KhwJmzmGIRPzCflI6ajfEK7cGq3xDeoPKLw27UKCOwGnR+AEIPw3BVTJ?=
 =?us-ascii?Q?Qp/58T4XfegfdgfVxMmvOWLnNckBfJWthoMv4wbjr8rE8aDWRz+X6Sh4zKNS?=
 =?us-ascii?Q?OPGIbRfc2wh6t0U30XfOT24n/oFgZ9RshimcMastyyGTet4DypQ7F7Gq//+w?=
 =?us-ascii?Q?5TrSvOx6EEwyvE/MZkua5xw2wJ6tUV0WxDx86qtX+s09TGkb9z4GwA4zWoxY?=
 =?us-ascii?Q?FhpSCQ1M8Ketubstq5yZfp9KX8LehdNrNiBcM6+yi2tVXfuajL1r0DaPrUzv?=
 =?us-ascii?Q?IGUYEPAdzqwFS80k4sywMySOjPPKbH2hnUEZAea+HnG5U/KpF3dXP3P295mb?=
 =?us-ascii?Q?43fBX+GKm+ONmp9lc6rmvZMhqm2LQnRMnVA4dMx2Urg/k1n3F9KFNqwtkln9?=
 =?us-ascii?Q?ImnVLoBHOfCAgyu8v2o84lhJ209LTBKlhzH3XMMfMwBykmZE2DqkjPhcvQS1?=
 =?us-ascii?Q?QedETul663uaI1ivT8vIE61nVP8g5ckNeUqTQfihvzWhJPsgq/0JI7D4O2pa?=
 =?us-ascii?Q?ckjt8kLaMGajyj/yBksUFCyyccHzEEU6AYRy/sL9g2oC2GulMHqfEd+BV3VJ?=
 =?us-ascii?Q?rO+hKuZcIVDI63qGqpMT97pddfYyaSsRn+5nzBlL9/LxizBU8+HmxccaMNMp?=
 =?us-ascii?Q?+QJ14WH0udOlrZz6ytH8Wk2qO17aMaEgpVp/FDjeHU6oWFMA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89470d5-b29b-4668-f149-08de8ab542a2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:04.8079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UlDGKJgtRpKcxocTIDmXg1corLv8QFc+JItJSbuD1xAGVlOlunOwydunWC3csZn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9785-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 8208B32C6DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

irdma has a comp_mask field that was never checked for validity, check
it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index b2978632241900..d695130b187bdd 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -296,7 +296,9 @@ static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 	if (udata->outlen < IRDMA_ALLOC_UCTX_MIN_RESP_LEN)
 		return -EINVAL;
 
-	ret = ib_copy_validate_udata_in(udata, req, rsvd8);
+	ret = ib_copy_validate_udata_in_cm(udata, req, rsvd8,
+					   IRDMA_ALLOC_UCTX_USE_RAW_ATTR |
+						   IRDMA_SUPPORT_WQE_FORMAT_V2);
 	if (ret)
 		return ret;
 
-- 
2.43.0


