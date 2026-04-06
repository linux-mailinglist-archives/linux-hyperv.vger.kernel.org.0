Return-Path: <linux-hyperv+bounces-10010-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFOBBw6j02mMjwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10010-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8143A33A1
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A63CD301AF76
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 12:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A4C3358CA;
	Mon,  6 Apr 2026 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T5scUjmY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1BF3358BB;
	Mon,  6 Apr 2026 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477501; cv=fail; b=aGlfHAX7qTJgrqPiyQzO+WRTXLwSO1yvdSiBAwmvazzo0RsW19iOOltPfHZkUsSdjGlWOvNjqAA0nA3q+jhQ9ns3V/WAenDe4baFeLDw6bo5nyaNDXVoZDURUBOxhz07FjdNBI+FBWuaBN5yzjkhn0MpKg7TjVEaiaXi14n7UC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477501; c=relaxed/simple;
	bh=vHeyt9nlSv8t2jNF/dasyRe2k606t7K/KN4jInFcDG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oxW0rXCuJ5m4++MKBc+h+FmCeq92/S4GxjLKwZhtL4VtKX647Gslrj6V5enJK6uS688MZ0Xj9Aq3ijIXh6erKpiSXTmIHCHAGiL0ahLyHBhN4wswUllHiiCxPM1fFeDEw1S4rlENlTLjbgwijHecbIgOHn1frtDnOfgys7UPpVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T5scUjmY; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pS1iBBFhp+cWI8A0yvZI2U0FLBe6+s4C6kzjhxU/1IOqq1vThwMYRgdLbYuNHLJSkg6rOdXPgHmE2WaNW1nQyGAWxV1Kyq+l/gAg4WO40itDn7NlIwb58WKofg9OtlDoIktq6ZgbOSK2AgFP4GGne+dEhy8o4T4XRao62LsrCXkl7QSUXzPZUcWvs8FjZ4SmB9mnE8cj5iCv1g832E/KNZQRyBWby6BqnpV/F2FW2XuUjoHJdVfjRqcZSEhY2QGoFz416VLirhXIzvaaAHz0hGyanC7bly/f+hwVg2lTsx/SjQe8+E95XQC2PKhJpV2CBzPa+VJ/AQSmDpTNxfzjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67AjGWsCVdch5J1tJFnDs7yJ/HNyH/lvUfDlLUHLh60=;
 b=yDkkwy21JS8xY5iGVffayPc6ZOIwe8NmP7FOZedY4vICZm3VcbnZFUFFPRqjspjN2Rv6YjUbEblkidJB7W20RAqh9CgonXMdvEw80GRAXPOOgaLb+ygfQNXg9XvT1krj/f8qJOgY2B7O+2pPQaEJpxS3lbGEhOv8bBY+ml7sS/Ww6WLDdnXQPdvnsMRiPFobFliCo74mRqKPbyqUfBWNdrNdUpCZaGyhELy6SJjUWDaqrHmpCFNczgLJJXX8R736gmHfzlCUARe4roO9T5lsJ7tH2lTmbnBlFFmhJARBky+BZ6ceVdCYpaD3uClf6UEbcSigelnXp1HaLVe1ntYing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67AjGWsCVdch5J1tJFnDs7yJ/HNyH/lvUfDlLUHLh60=;
 b=T5scUjmYg8FcJS6OpmzxtPizwYKHe98NUKB5A/yLKfuXcgtgU5HQ3eseqU5BMJYyEmceIUw3avdl6eraGs4b6yatOGxXil/fFnx+kkKvlTM8CyoJ0oYU8kgBwB5IjjbROcbXzoUnXV8bmysBoX4QQfP1J0I6c1C3ysKKcxt3caebOeNHJKzcTaCp0UixUo0qlzQU9b3ygxq2sIU8lnZB8lUGAGq+3fgSNvUdIKZhbmBbN1QFieI79mPsUBN9FAx9TPzJhkbnNx/WHa6uH57woFPVFW24R0hlWmNpjOHkZwHtTGwArO01ESplosBlhzHczz6843RSR5bJAXbM49svmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 12:11:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 12:11:30 +0000
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
Subject: [PATCH 10/10] RDMA: Replace memset with = {} pattern for ib_respond_udata()
Date: Mon,  6 Apr 2026 09:11:24 -0300
Message-ID: <10-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0013.prod.exchangelabs.com (2603:10b6:208:71::26)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: c0779be3-cd8d-4e50-179e-08de93d5a0d4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	fgsk0mAsHharR5wRV4ZRoAAgxJzoUUfQ2TZsUYjrPDYQ8IT+g2zPM4wHeQqYfsKL7+g2b9MMq3xxH5S5BGpnWC4k0G4uKekooT8DYPJBxlhCERmimYCRrNate62r3obO650uDpWEb85CGp6QvDD2ndl1wU9eZx38VIR6AXnLcq+Y9MsZyNIm3T/N4n3z5u10Ebej/rZR6WV9igRSuYHU2gilHTuWn7ejPk9Ni8+ELPVCcqLy4SyjQopqhmw68QUZQD2mT8Aus1PiqfTTRWEEwCc6fLFqS87i5UymjD0Lsw4hfbG+EfcAnFDUmDDPMvsJggWSuN0UgSgztPyb+hQvf4Mh9yX+6VHtCbylhTihR72xkj9Nm70qGah02kuAKaaK/huokvnnDBJQSgfzuDAfmp5ZjLDZev2EWKMm8X2cIWkXzU4VK5bwQW/vPgx3F/9zCcejxKvfnGDJ1FLrkQ/RLDVvOXLG1rychiADCjHQgpFe4QafIsyIdOJLp/ztmYxgtIwmMk6ikUZFd4wTYQNpBE5uPrsn8ee0IeQnIZYOta+vE97sztN81w/fKtNoWKO7HIoXINQ1N4GnNHIc3PfELKSeTcLHGdok3/LN10Ou84AhpU3yAsw8LrMzFK8zp6XY0jMNPRkYgX2d99oZYBLCpQ1w5nmOHrvLV47CLkCTxDJv/C4X8OU9ytgZ8v1OwbnD8qE+rqy3elrKR6lKvyARao9ZLPS8ceMzbJ5jSn536Lh+i5u3oSAg23nRk9cSxpMVUmvzWV4+01/X3K6B89wSRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mhgqVIotgRc53OV5H9ooMCdemHCbqclBPRbVfZWulQX9GoZ+nwprCJDBbhzr?=
 =?us-ascii?Q?X2nDuxN3ghR4/IJ1uWEHIqgmsL4LLP3lOJLerfBJBOvtRGELHV9wALDZeY47?=
 =?us-ascii?Q?jPHH0VW6pJrj3THq7uZQPFaBr4/mUPSgHQU8aarReq+cGfMPm+9xwhTJxRGe?=
 =?us-ascii?Q?ysA2G9DNyEwXuye24AY8w5J4RZc0Qe0hKYohQ49/iJi0I8nY7K3FR5njrVKF?=
 =?us-ascii?Q?EAqgbNCTgavTpDPUSeJd+E4bneSC0hDBej79z79uhvbRHHqKFQN4plcBBFD4?=
 =?us-ascii?Q?uCoRy4wBQ7yxg01AjVFrSGwG+XeePyFhtfOfxaac0w+HWo5XpmjwMTuUwxSB?=
 =?us-ascii?Q?+VfJ6xhOZYnVrW8qy2H8iqcnXQDtYxXhvBDHY9+fcegjuGWgztCzmbn5xh5T?=
 =?us-ascii?Q?sYABXrLxYlAG8EZM1HR1BnR1wiMm029eVd6jMHhLqTQRjVSVn+AW8Av/qi83?=
 =?us-ascii?Q?bgI/sc5WJHma3ZJOyQfu1V/seXoMAIXr8xb0RYbFkPtZBpUc7Gs29iyFTSwB?=
 =?us-ascii?Q?jn0DFEop0FGQUcsY/vvJkFqH5VsP9saVMdt98h225yRK3RDXvzC+7tuwaX2A?=
 =?us-ascii?Q?gSgYdJkXDmr1AaRR7cFEZ5VEhsEvtrJrsrhnv7x/93f4XJ2P1fsMVw0zKhus?=
 =?us-ascii?Q?3RA8+kfZkEQyFqu251R2tvqkcZmBUfgQh1eqFnFPWi9+9lS/K0KQRxYsIRMv?=
 =?us-ascii?Q?bkcs7XMDRtkhkB11S7D7IxE9ab3rCRU2RJPDQ3SOzf/6ja0Sncg3FpR0rMAh?=
 =?us-ascii?Q?v7uolNHA56mNtR6ND0UlOJHNN/zHZXat/Qe2Jr15ZAlb3bH4ie9sNyAgszRb?=
 =?us-ascii?Q?MpdVl2cKPpzHiHf5VfKtXgg0VheudAYnnWXv6z85njmX5PP2F/OnVZrX2ylq?=
 =?us-ascii?Q?1+VfuHuqBHiadiJtzGASyM61xU8DRoYK5r9atV9e2qKtPj8ojfY1jQqJsD+q?=
 =?us-ascii?Q?AxqtyADpe6z9uOU/BchMRfAUdxIjvk3MyMXA0PuxC/szrjTHw91MQfo1oG0M?=
 =?us-ascii?Q?5QtzraPzj0zXMgbyuH1m2R/edSfDaBSdhBJKKKOE7F1tWB8d6S0RR9NMCcuP?=
 =?us-ascii?Q?Yn8EtlCggU1r88BzM+u6d1RDeiPLjA/x/LJC41d87FXqUBdftWsRNxuzBnJ6?=
 =?us-ascii?Q?zpiP2dlgfEicenX3wIvGzAPxDmfcylxyij73EKcult8NLZfdtObe8Zzy+V4r?=
 =?us-ascii?Q?0yuvBZqBfbG587740NFJlGw4YTca8ewuOFfhRjok9PIwap1BycmUCdBy3hjq?=
 =?us-ascii?Q?pDbctM5PaPPkrJZiewT+GAkTS4P1IQfE9SSLvx03z5wX/vGlRKBN6HgfNZmp?=
 =?us-ascii?Q?fKaxZUeknhNNae+tCa7jJsXaSqejlbgIW6erry2QiEkJxVtqUxLe99Mfr4AH?=
 =?us-ascii?Q?PkBfmrQxK2PFUL3EaWGyzTMtg+5s6i3TNtINyFSJMmc8jNclqz3qUajCGGSZ?=
 =?us-ascii?Q?pbqrJ7SrqbAAHxw+4P5UWQFWZ43pQ6WKH0Pk+AhIZDyKb+bp85+PB5eX0Btt?=
 =?us-ascii?Q?vkO4CFrdt3I4gVRunQwpxTmff+OYS/VZ/9qRgXUZKZ+FAHFDYD7MRNIbGhY+?=
 =?us-ascii?Q?k8eNyO0ukqPfDNTJ/esxZ2cpQ+2fCDPnyDrFuGQ9Ep0Ibl8mtbn+DtomCa/m?=
 =?us-ascii?Q?XSq9jM4CK29cNIbjlB2SYphN0ALkEHuEE37zcGpHunR+nlFjqd/nIz25PK6p?=
 =?us-ascii?Q?bhXAduk4hKfNEOSv/zDIEKEvtgI2R1UAiP9eEutGe37BKYMc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0779be3-cd8d-4e50-179e-08de93d5a0d4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:11:27.1800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMaT6LImDLlMtiVqbhOop8b4r4RfCaA49fDu9Sr3GWHrjUpmTDwzFsn8mHv5Fssf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-10010-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BA8143A33A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Most drivers do this already, but some open-code a memset. Switch
all instances found. qedr_copy_qp_uresp() is already called with
zeroed memory so that memset is redundant.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/cq.c             |  3 +--
 drivers/infiniband/hw/cxgb4/qp.c             |  6 ++----
 drivers/infiniband/hw/erdma/erdma_verbs.c    |  4 +---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  | 12 ++++--------
 drivers/infiniband/hw/qedr/verbs.c           |  6 +-----
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  4 +---
 6 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 47508df4cec023..d1517f2560b981 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -1004,7 +1004,7 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct c4iw_dev *rhp = to_c4iw_dev(ibcq->device);
 	struct c4iw_cq *chp = to_c4iw_cq(ibcq);
 	struct c4iw_create_cq ucmd;
-	struct c4iw_create_cq_resp uresp;
+	struct c4iw_create_cq_resp uresp = {};
 	int ret, wr_len;
 	size_t memsize, hwentries;
 	struct c4iw_mm_entry *mm, *mm2;
@@ -1102,7 +1102,6 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		if (!mm2)
 			goto err_free_mm;
 
-		memset(&uresp, 0, sizeof(uresp));
 		uresp.qid_mask = rhp->rdev.cqmask;
 		uresp.cqid = chp->cq.cqid;
 		uresp.size = chp->cq.size;
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index f9c7030ac6bfd0..e295f79e0cd3e5 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2120,7 +2120,7 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
 	struct c4iw_pd *php;
 	struct c4iw_cq *schp;
 	struct c4iw_cq *rchp;
-	struct c4iw_create_qp_resp uresp;
+	struct c4iw_create_qp_resp uresp = {};
 	unsigned int sqsize, rqsize = 0;
 	struct c4iw_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct c4iw_ucontext, ibucontext);
@@ -2242,7 +2242,6 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
 				goto err_free_sq_db_key;
 			}
 		}
-		memset(&uresp, 0, sizeof(uresp));
 		if (t4_sq_onchip(&qhp->wq.sq)) {
 			ma_sync_key_mm = kmalloc_obj(*ma_sync_key_mm);
 			if (!ma_sync_key_mm) {
@@ -2686,7 +2685,7 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
 	struct c4iw_dev *rhp;
 	struct c4iw_srq *srq = to_c4iw_srq(ib_srq);
 	struct c4iw_pd *php;
-	struct c4iw_create_srq_resp uresp;
+	struct c4iw_create_srq_resp uresp = {};
 	struct c4iw_ucontext *ucontext;
 	struct c4iw_mm_entry *srq_key_mm, *srq_db_key_mm;
 	int rqsize;
@@ -2764,7 +2763,6 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
 			ret = -ENOMEM;
 			goto err_free_srq_key_mm;
 		}
-		memset(&uresp, 0, sizeof(uresp));
 		uresp.flags = srq->flags;
 		uresp.qid_mask = rhp->rdev.qpmask;
 		uresp.srqid = srq->wq.qid;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index c8a35337ba51e8..b59c2e3a5306d1 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -996,7 +996,7 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	struct erdma_ucontext *uctx = rdma_udata_to_drv_context(
 		udata, struct erdma_ucontext, ibucontext);
 	struct erdma_ureq_create_qp ureq;
-	struct erdma_uresp_create_qp uresp;
+	struct erdma_uresp_create_qp uresp = {};
 	void *old_entry;
 	int ret = 0;
 
@@ -1048,8 +1048,6 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 		if (ret)
 			goto err_out_xa;
 
-		memset(&uresp, 0, sizeof(uresp));
-
 		uresp.num_sqe = qp->attrs.sq_size;
 		uresp.num_rqe = qp->attrs.rq_size;
 		uresp.qp_id = QP_ID(qp);
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 083f23fc687b31..d5fdbd7c8dea26 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -586,11 +586,10 @@ static int ocrdma_copy_pd_uresp(struct ocrdma_dev *dev, struct ocrdma_pd *pd,
 	u64 db_page_addr;
 	u64 dpp_page_addr = 0;
 	u32 db_page_size;
-	struct ocrdma_alloc_pd_uresp rsp;
+	struct ocrdma_alloc_pd_uresp rsp = {};
 	struct ocrdma_ucontext *uctx = rdma_udata_to_drv_context(
 		udata, struct ocrdma_ucontext, ibucontext);
 
-	memset(&rsp, 0, sizeof(rsp));
 	rsp.id = pd->id;
 	rsp.dpp_enabled = pd->dpp_enabled;
 	db_page_addr = ocrdma_get_db_addr(dev, pd->id);
@@ -930,13 +929,12 @@ static int ocrdma_copy_cq_uresp(struct ocrdma_dev *dev, struct ocrdma_cq *cq,
 	int status;
 	struct ocrdma_ucontext *uctx = rdma_udata_to_drv_context(
 		udata, struct ocrdma_ucontext, ibucontext);
-	struct ocrdma_create_cq_uresp uresp;
+	struct ocrdma_create_cq_uresp uresp = {};
 
 	/* this must be user flow! */
 	if (!udata)
 		return -EINVAL;
 
-	memset(&uresp, 0, sizeof(uresp));
 	uresp.cq_id = cq->id;
 	uresp.page_size = PAGE_ALIGN(cq->len);
 	uresp.num_pages = 1;
@@ -1173,11 +1171,10 @@ static int ocrdma_copy_qp_uresp(struct ocrdma_qp *qp,
 {
 	int status;
 	u64 usr_db;
-	struct ocrdma_create_qp_uresp uresp;
+	struct ocrdma_create_qp_uresp uresp = {};
 	struct ocrdma_pd *pd = qp->pd;
 	struct ocrdma_dev *dev = get_ocrdma_dev(pd->ibpd.device);
 
-	memset(&uresp, 0, sizeof(uresp));
 	usr_db = dev->nic_info.unmapped_db +
 			(pd->id * dev->nic_info.db_page_size);
 	uresp.qp_id = qp->id;
@@ -1730,9 +1727,8 @@ static int ocrdma_copy_srq_uresp(struct ocrdma_dev *dev, struct ocrdma_srq *srq,
 				struct ib_udata *udata)
 {
 	int status;
-	struct ocrdma_create_srq_uresp uresp;
+	struct ocrdma_create_srq_uresp uresp = {};
 
-	memset(&uresp, 0, sizeof(uresp));
 	uresp.rq_dbid = srq->rq.dbid;
 	uresp.num_rq_pages = 1;
 	uresp.rq_page_addr[0] = virt_to_phys(srq->rq.va);
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 72ee57dc85687e..c020f882d1875c 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -691,9 +691,7 @@ static int qedr_copy_cq_uresp(struct qedr_dev *dev,
 			      struct qedr_cq *cq, struct ib_udata *udata,
 			      u32 db_offset)
 {
-	struct qedr_create_cq_uresp uresp;
-
-	memset(&uresp, 0, sizeof(uresp));
+	struct qedr_create_cq_uresp uresp = {};
 
 	uresp.db_offset = db_offset;
 	uresp.icid = cq->icid;
@@ -1284,8 +1282,6 @@ static int qedr_copy_qp_uresp(struct qedr_dev *dev,
 			      struct qedr_qp *qp, struct ib_udata *udata,
 			      struct qedr_create_qp_uresp *uresp)
 {
-	memset(uresp, 0, sizeof(*uresp));
-
 	if (qedr_qp_has_sq(qp))
 		qedr_copy_sq_uresp(dev, uresp, qp);
 
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index e887f03a84d063..261f18a8368543 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -82,15 +82,13 @@ static void usnic_ib_fw_string_to_u64(char *fw_ver_str, u64 *fw_ver)
 static int usnic_ib_fill_create_qp_resp(struct usnic_ib_qp_grp *qp_grp,
 					struct ib_udata *udata)
 {
-	struct usnic_ib_create_qp_resp resp;
+	struct usnic_ib_create_qp_resp resp = {};
 	struct pci_dev *pdev;
 	struct vnic_dev_bar *bar;
 	struct usnic_vnic_res_chunk *chunk;
 	struct usnic_ib_qp_grp_flow *default_flow;
 	int i, err;
 
-	memset(&resp, 0, sizeof(resp));
-
 	pdev = usnic_vnic_get_pdev(qp_grp->vf->vnic);
 	if (!pdev) {
 		usnic_err("Failed to get pdev of qp_grp %d\n",
-- 
2.43.0


