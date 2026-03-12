Return-Path: <linux-hyperv+bounces-9344-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD9VNN0HsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9344-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D9826BA02
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB414301AA8D
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C582332C92A;
	Thu, 12 Mar 2026 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T3nPQGuQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7675432FA2E;
	Thu, 12 Mar 2026 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275088; cv=fail; b=D7xVoBkV0dhG+ReaZKQtprZByF1pGVlPdZfW6O3mUmjeosUsltC+ZEIfX0jPO7VouAl8JrIebH4RZpV3oojG76aL48jYzM/7E+pVi6fuQ3OFWWB4vVQ899Ke7tOG6FquOxjJg22ZW2X2fNkRsaozIFB/Ufutq+S5ctqAcCy40dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275088; c=relaxed/simple;
	bh=UvZ+nSgal1mcum2pVOvH1pXfkeVHF/KzzWhpM94wpAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U0oiWWD8kedF16pfwcbXA5LHBZ0uoGtkAoLkap6yCc8B7NV3GBK9ugptvH1H+944dB4X0lvK6NFPwH4+K8IQTbXtxTzAbhJaDBCyx7lzSUZ9H/4ZN+YpuQRnpd0viwuHT+eMtRU8zVaPxVoEZr7EKj7HoX+oE8pHNF6ephaQbdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T3nPQGuQ; arc=fail smtp.client-ip=52.101.61.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6XlUz+rAfScqyYgIu0hp30VkmOZPtLGHixe9NRsp276Bdov0aP1iAnUJ8NJOBnOjsFhPh1bhiCsCD50S9Zf7R96G3T79ah5mMSgscf2iB8XS1GjY25V5Uwo7GtToCxl7/PQjMSN4p+TlmaZEtSqT8uLCZm6Y/gs5og/tAwuNDY/aCFikHPs9AJPNxPUGzyY8IyYSrWn2Fi+62xn2ICRvdB8atJnM4HoQK4x1MP+JbQbYofJdEtjKvwmF4wMXhFOAoa1hxa4Fh/4zOCoUtVvHzEpfP6OclZ+a012Z89jTN7Pwnl2Z/hUhzYoL1o7wvSqeXp1t2CPkoa7F9Cgrm6E/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMbMWFQU0xDcDrvZohhShv1eXaBFW3/Ka0zE/8jlEKc=;
 b=Tnb5aYPAZa0QdP5nI+WSE1BbVRONR/zkkhlkOFDmTTOePt47BQhRBVASOWmqv8NDb+7/A3gvWBdMEJoUlFe0FTBVqRizJor7+ZkpYHIV2IkrnGmxe4iokg6dVWLEvdeYw8Q75fmMXLW8hTDx8K8nilEw/MuU26wgTiXHb0LpYrM0xhybhfiiQOq+p4AEmCENaeSxMd2DG5uInCg3LRB/h8MoxfrV9nongwCk9uCYYKfzVvH4RgykCf3wyMoa2MVYsniJ3cO+KEvkNiAnMS9UWDDCXA6AU4imt7s2b6ax9LP962g35ui1TlE9l4JkiHAWz9OGIvhAnA0UFhkIfeOHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMbMWFQU0xDcDrvZohhShv1eXaBFW3/Ka0zE/8jlEKc=;
 b=T3nPQGuQqIveeozNbeqqSKE8ylgpREG6oekkr0ypVVp30lyHnvU0EBT1rwcXW8fMk7jtfxyqdepIJ9PuuwKT7gytofLiIN1kJ7Xa1qwq5W/OQpmXzrzL3iqVafwylo10P65jgaqEkYzl1OCsyEL7Nolu+9f5WjlFPuL9+7MmracOOe7lES+8Wc+1cllgemeAHPvGd25sW9Th4sKOtgzHU1dMfvQ76OO8Whwfz4VLAy/E/p12iD0RiYSLzgeQsAfMgaJTV91LLGGRznVgglCnlh7Yxfocm652LQD8YUwgM+aLnL/+kRJ+iEdixC9kPz2vCE7v1wdGB8JNXxIE0LJlHw==
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
Subject: [PATCH 14/16] RDMA/irdma: Add missing comp_mask check in alloc_ucontext
Date: Wed, 11 Mar 2026 21:24:21 -0300
Message-ID: <14-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:52f::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 280c58d2-e5e4-4719-7188-08de7fcdb838
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	u/r4JeXZOLNvLmuj+VoFGA/39LsCy4XoQT99+810RyVba0lWda6CtQv5sfjhDspDDpKyqKzQuWOsc+54CUB0DwCwWOH7k17kJ7t9XHnyjGynoRHCEEp1Hm+ms8T8ldCSUw9359ixhG9l5vc4z+7I06/3pcbX7fJWCQtYWREN9wk8IXZah3BVqiw1+ehH9lc1ECrc8NkZwO4BG/HOVV4Vq0K7lYZ5ysy8BnGSQ2egIDter0pVpLVnZcpjk8H04eXjwBKmwVJFS6Z5LpEx4bkt9hlu/jPy4AQI73jjSEyYRJi5WR63jJqoG06uSLLXJ64/pgxGt9qTL/IMyvtvRc9CdQkzS8CcCcs6I96tQkYSSufcDaw8lzWrHyqYLOz09vBv0UVDlmz4p4XrUoViQfveJRVpFwZPcbj+FPd7ezWMMGamHGmRjnbf4sJWfZSgjoGgmLcmcLPlOJ9t9CS5D9wXZ3WfHt+zcVqfYrVsMcoHN6efD4aZm57g2MiYcdQRC5kiAJ7zBWIbjcLtYO2F/xbS/fyLM617Fq1iuE7/lPR6gGVz/yf0yC+zb8cOWv9/U+c+hzYL0cdCD8ga+HOdF6wZ5Lj3Juom6niixGpQ3e4LeGpDCYItpOrf6jknS7OUPmy/mWgnlbMucQyz2+/5F9k3jLaHf9hNhgcc3R8r4BjjUOMd2eUi/csKIOm3c02/0auGs9P6RVq0lnum8LV5Cw+XNrzaQPhmwP1EOGzX+VtdMN5+uTXHfcvompiTqpZ5YfoXpCtIllpNZmTub707GJb5LQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v134YNgno+cW4Oqk7KuvkNuuGATyVTrPcqhLKDknwNDUK9nph+XIBfehCMNl?=
 =?us-ascii?Q?tawY/LJQY93W/Tp082c1suGCEBJFRY6fqs7dUlH5rKjeltmU8vPftUkkoWDn?=
 =?us-ascii?Q?OnKY9BzdWZf1cFKZ9cMzdfP0Jq5g1HaHShRG2Zabj/sJE+9ICj63IQcbyzrA?=
 =?us-ascii?Q?3L+grg/w2UGMUD5RE/xXvMMv6zKhaud7PANwhWvSqHwjZkOynoDv6p591oec?=
 =?us-ascii?Q?qohPeXEGr2laKb9pqBEk+Fgo33i4u2TQ2tsdp1IHjSN7/5XoQCHACBVsBfwD?=
 =?us-ascii?Q?GkFf/dYVMfXsxei3VZ+nOeRTokG0TgkrZQLA6Lsk535Nr5FKaslZsYCCieJo?=
 =?us-ascii?Q?wYwBMwO7AnLYL6wjMP1hmBMMEEnvCp1WZU6N3dmhAjbGEbbUd/0xFmdHfYwL?=
 =?us-ascii?Q?nZC6tPUGAJYylL1UNA7l0jBrtVZjQWSkt2ulDYkpzqZXpiymfosk9HyFOXE3?=
 =?us-ascii?Q?6t6qcVyGROjNTlv39rVNVR54FCMoMo4ioCzzTrBphYmyu0fFO1Q+0dr2Ftwf?=
 =?us-ascii?Q?6DNeK/qSD3uH9qxC2o/7dLgtPCbopPA9RkbNQNwwFscLGA1Gm3cHs7IeIdVU?=
 =?us-ascii?Q?HbFOX8g+Zkd12E07Zk36I0IKu7gxQdWXTSo+1/3ECX5cURaiVmFtnOC6wY3Z?=
 =?us-ascii?Q?Ztr8Hku0xjyo63wIgDQYnr5g8sFPIZBcWZkIXc68wFHgjxkKlIOlLEVO7dIS?=
 =?us-ascii?Q?9LlJfnfywPwnkvWp3QSVvHYgx7lB2cRp7KcGCTB55RrSEHHLZvaAE+7UbR4H?=
 =?us-ascii?Q?9mtFMGQJ2qXRsljTz7FOg48vIT/Zv0exL6V7E1xIQ2/on8MgiY/u7bD8CfbP?=
 =?us-ascii?Q?6ocTT/IdQ+uqLjQXcL0Gy2Dty10SqBhTxfCFcALN1BWYUoHl48K0eJaen739?=
 =?us-ascii?Q?SX8OH6qLUrTYo99pTK46EFRXBuC5xKhdbLAOqjVivhIkZK6Y9uPkeKhj0wti?=
 =?us-ascii?Q?jVhGQX5vL+47aW6N0nbbCCh6b4h4WV2vi37CqVUJFPeyPl9dE4UWw+5Vu7To?=
 =?us-ascii?Q?z/QbYocnVUVte0nvZl1rpiiIGe85X+K2YNHm1ppe9eZx1C/liWzQXJAotgee?=
 =?us-ascii?Q?KrL4Q18QYJNojG9XkM8y4oYUazROWhYtw27mYXP2OXgUcQ++WaYriT0OPF/5?=
 =?us-ascii?Q?11kSHEqbHLEvS17RO0i5hRapbym1r9aaUKULdyfT4HhgmIttOwHlSqHa9hHs?=
 =?us-ascii?Q?PVZMuoa9d/dvkabMbcH6M5wDv33c3bbatZqs2Y//+9ytxfmOYqnhRV+eTtCZ?=
 =?us-ascii?Q?pZozlVe9g0kVQVhLbWUrfC7GfPNldx0kLOR7js+JHXMMHO3LLI2QaClWTyNI?=
 =?us-ascii?Q?ppIqapFDWsW4Wysbc6ngXsvOKPMF4GpewEwRuXl+U7yLUIjkgRcWg1ekSvtb?=
 =?us-ascii?Q?FwHmncCZYlFUBniAO6SgBgsbce+Q31xC61uZxvCKgHwgVGFrgTMWg8R+9wP5?=
 =?us-ascii?Q?KTgMP05F1/DV5NfnCLuNrfYX7olvYUKZlIn+IrwXcMpDhnnddOXOyzJiTKav?=
 =?us-ascii?Q?6f8ztAg6M6zezYQdEBWo29Fa+JeVZBzHe0fXcU/TyMyvBdIjZj+cZ11g8iAZ?=
 =?us-ascii?Q?rW9i40WKHtPAA1dbOp4fX2jG/ZxNff2V+5VGq9eUqJB3RsKoHfSE72Pd/4IU?=
 =?us-ascii?Q?LMDs3JnC2zn7uNORWx9br2fM4Phho0FkjwmKcEmLuMJW8WHAnF2HF7GYJpVo?=
 =?us-ascii?Q?RsHzcvlQAzsukZ3rQZyp6dQrXg1HFaGm1HTvzyBqQnNTqcGKLfjpS4renu5q?=
 =?us-ascii?Q?892YsSsogg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280c58d2-e5e4-4719-7188-08de7fcdb838
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:27.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kijM+GkbZT7McIimhYdnGSQd5IaI6qqLE5BYWbAniGFbOKo16LccGQH3mzZZ1bDt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9344-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 25D9826BA02
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


