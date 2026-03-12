Return-Path: <linux-hyperv+bounces-9340-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPKZDg0IsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9340-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D818026BA53
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 523CF3165AED
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6990033C536;
	Thu, 12 Mar 2026 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LbsmyR/Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A8336890;
	Thu, 12 Mar 2026 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275085; cv=fail; b=hbDsn6am7EK4qRPBwi5zBBa63mFTi8WHeEgcoU0dew/lYpYrK2Og/usB9QQMFM1eMwRTcrgZ6Rqae3TXxDGldGdG07sgSaODcfXEkoMjGGcyM88ndXFbLsYSU4Llf1vQz0FJPsGQkbyqcWTTVBGaCpetYcfop3rkojmU6FI7+Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275085; c=relaxed/simple;
	bh=kvK+plAYCR3/o2EkNn6vT7OzSvlAF2zKEIktTZuaNLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OtQAlJCd9iKDJBntRN4FWd66p5gDArm7tmqHV3TU/2o1Bkuk1zNd5ENBMiLG+UyS/MHnyH16xtVoIA6Wbd0heOT2zewxgblP2c2f+nFJnXoToXb/78eYAPrlffKTCPSrmFUnq7EXd0qvNm/vfpAlm7zzjKPyxNLK9GGD72eztOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LbsmyR/Y; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL8pz3HYHIJlckqLo1DwC7SftJ0XZ1ipOxP9AUtCqr3S59qmC8DhnNJLDD8kM/o3Qvv+P78+EZRGyVEnOZ076kOX9AsPTEfVU/jE5XJGnJouHiWDApHNAoMXuyF0gtraufBEE5EsSJ7PVF18IG1Yc9iUGk9vm1Uh+8gp2uZ0G3KGEhGSGwJK1sqHWRYfgfsYHtiJlSKFn3avbLXMb2y/dAowOeNRhpyF94ZIvSdwgtVmZ5e2EfcmVEe6Uvq35wq7iP2baCmluPu0C5Oy0y2V7X7ldG3ZVsmWm+fz4PBJNJ1fcI+yaP82ADrqX85NMpl+zZpGrk7Q7J55GfNmH7udFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpdQ6P5Enn5lOhmO0gnGLiiVu1ndnr99OuEOQXJJhOg=;
 b=K6lhUSp0opj+1WWIbat1guN15mK7rtjClWYBrbSKQWfbqZjyxdnhkpcsXZkjrpb3C5kvKLWsadNIWkPBEnF9hsSjobvQ8sWBB3NMflZJjCUU1DIQqI88qI59v0WqBl+fq1WYs/0GflefynOsQ07+sEhYWa+NYd00btC448NzUffF5Gm0zaHtaxPsYIRO4z3rXfn1+4XALIFH3B5JsCcORU1uifQz9A3zR5Zo9FfZETt0uwAzAbzdRptAbPIL2l1jK1+Z7WQ34la8PEZEyr3h29ugb3ZKIdHWRRamR/ztjOQ6ksf3duwvMYvuti7Fp9tTYM7q/whcHGxa1EbKM92ltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpdQ6P5Enn5lOhmO0gnGLiiVu1ndnr99OuEOQXJJhOg=;
 b=LbsmyR/YQt3fzLevSbSHs7b97JFYPEAREE0xIlL8HtxL9Zpzr0hvTJ7OlaxV8iM+QHBpRgRBX2d3sSS9ifz82tZRRnZ83kEyEY4H3qQX3yJvH94k5vyIQ5NkGZr2GyUefMfdhBMD3Gum2PQoLRjiund24LVpjyFtt370fyvMC+oTI/pr7zhjiS3Vz1IPYEOQr3pzTtV8dztu0rFwlIR0ZZ/UZ1DoCsLEgGr3ijgqnfUg/MEUp5a+Ja/hZQjxtz4a1HEqwNlrOA9vsGz1u/Y5nlwhC7WayiIFOlNFQVZl3Ky3FfUx6JEIEalS1FdilDETLw3iDNXbgcTPlk1E1mEy0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 00:24:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 00:24:30 +0000
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
Subject: [PATCH 10/16] RDMA/efa: Use ib_copy_validate_udata_in_cm()
Date: Wed, 11 Mar 2026 21:24:17 -0300
Message-ID: <10-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:208:335::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: b440abc8-c3de-48bc-a630-08de7fcdb789
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KVj4XqxBu31BVYDvftUc1b9ScYEDUd7GTEVa2uurfEVruveHVwL4+yije3lnbbVm5Fmk5Vxxo+PVuXhvTYywBHi1yNl7ZZulF7YcM/KpQeRtzrMjlkuScosQuvg40CyPVTPS9g1HtPAviTlL/WI6763bByvWDduRgTR21rdhb8YXgVMp5zsA9KKcSc6s1NsDbswaBDPsdvfx9KSdnuQX0uBS8CMxtpLCOb8/vqFK+a6X/1c1VWs0otGsuncuVAuZAPdoqKErTlG+ybZfdd4XRDmeNi1L3UcTIMzQlxwowTwI6R/5ntFWTQJiP3eAC0s4OVag620E7nIp8hUKfLdm7yzLNjyCeusjRUps4dzj3XnDh8qFZps9eT37BH60Wuip2vQ98QlWxwfO6hn8/ifA2fR/vuutuZU2GMLftowHUGWB9vU+OYw+imDT/2jSGf1oZXdqlZ5icWF128/04HyTdqs5rDO11p+QPyxqSDVTUHxo3CSs+pwEc18ocKN5Z4Ypx/0RZuHdxfmz9oBlcIW5JJTECK0Q5HndNE9GFbCBd1QH8Y+5EtvL4DeAZdQBNEedwlQtDi6hBrz+7ZgRvvReQg96tNuj8KaxkL13P2gSiHqvYDPMwbFXDN5yvXpwk0pQ15Lp8kUzKdkWeFuVcj5YojZ75LWdF8UZnsfXHHHtsxmAum8SI1903cpuoLkkJLpx7AsAzgraG83gMylXoyWV7WxHX+av6qEvqB26/jyYhBpDG3lP0W0+0LkkXG+iAvRU6KvK+v5bT4enj8ldVZqhOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?huoMh6X8yk2jDZvByGuYomUYB38pHUX+16MACND0DNYHuES0oARMbWnmxHkU?=
 =?us-ascii?Q?KM4dIZwSxcd8EIgtAAO7uYjoTeTJ2rLBkNjQxbbeTYdN+3vwGqK+Q8qq5exp?=
 =?us-ascii?Q?x7NBZoNGMbGtN86SlKRekzYy1v9n7rhCWKBDWpnftVuqcPkNcqI8BicZnI30?=
 =?us-ascii?Q?ff/WAFXooFSUG2zu8pf1s+w4WlZ6Zt9X3/9MGn5bhmBvbRxm7r56v2TtSAMC?=
 =?us-ascii?Q?NqmUPZ51n6dWQU4oDaoC45+rdSIdfIoAq0gcH6ejeDlqGLYdtCV7KkvuCFzz?=
 =?us-ascii?Q?R/lfFy+++Oeq6K/wVrQ6u78L1LMX+dt5xFpRWYrA62ShYyRPvbe9++wJ+AF0?=
 =?us-ascii?Q?MrSplBMNesidk/LIcp4V56BU1XI7TQ3enZZcascYIthQnbxxnyjTrA54kIDD?=
 =?us-ascii?Q?zaduFEINVkGiyrdplehd6bldBye81JvnwR/JMPYDipZT+3MOOTOt0Rf5cUhq?=
 =?us-ascii?Q?jVWaU5Q+L7BwX6V3CJXt1WXKZdJIdlZcvaAnCnYOzqGJpJQCPLd3UHbpgmNL?=
 =?us-ascii?Q?BgAMtXB3UIJhITvDuj3aiU+9jvDXOZ+t4LK5/vTAM3+ADJlL7RztiPQ3VxyJ?=
 =?us-ascii?Q?VvsWASO/HcF6BTpbBa0jf7C6lnW9rlqGpzuxKf3UvUHkmeKrO9l3KQryMa30?=
 =?us-ascii?Q?ccj6DnsGlvbjrW5GtuAM4oc7zE1VAG3oV0G7nhvElohyCsvps0qMsG+Lt6I4?=
 =?us-ascii?Q?C9T6SAFnSDt2ELtIZRpjvX6JdNkGbjHlxIQUDC0txDG6nvbjILJC02/RFlEV?=
 =?us-ascii?Q?MFAumnqANiCOmYb9gAdQjcfshMnzlT+2iIpeVm4nJa4J5/VrxkFm7uxiXAGG?=
 =?us-ascii?Q?gfC8FA/8mV+ReHLXAowNHEtJBfLtrfcdqRplaMZDP9CIt0FqS2hCsFpD9H1I?=
 =?us-ascii?Q?vZpOov3YkREkEtf/8nQCAOyPw+c4dOZLBT8pOGEAZR+5VpGjVqbZgJMQ7A9j?=
 =?us-ascii?Q?rurVM0R01IBBTVA960B/9ByalC9W4UvUUO5aQJ7wZBHext7K4DAg2Kdtnk23?=
 =?us-ascii?Q?vYPJpWPsKajjNbgLkq0GXbpfZ+MriongZBpmjCJj+rGw04fRLQcJvyPYQ0rW?=
 =?us-ascii?Q?sbDGFwuGCLbmGozGefFqp0ElKeCUXH4/7HEuHC4GCpHcfOJvMgWYqDozsvQt?=
 =?us-ascii?Q?Brwy9pVdczrxSMFWshzSZdd3elATD+Z/Sncd7FA2AN+g1yoQKnnHIekSFn+2?=
 =?us-ascii?Q?35XDqtYQ9n+5wnaOR8b8n6JyN/MFzuxNMXRFSGWzhYMv4nOLLW5MjW/1WISs?=
 =?us-ascii?Q?XQqNZ2F4xRLccucZPmwTnV/ExSrMZU+SxrrOZxCBf+0U7KKch0Mk1wnNu59t?=
 =?us-ascii?Q?0ZE7ZGgC7uh8kH0tbxvaw7WEqgq5NeOoEAmJv19kGAFZeURDJ0MjzXLOO+sC?=
 =?us-ascii?Q?5ZabWl5S+EnNghx4Wtj6Eci2LSfgwiIPKvZ9O8U84iWHy1Kkm7vbU6gfNiv7?=
 =?us-ascii?Q?chyQAAzwSHKlvVebRLpzZ5KbYvGiWY4N5qAUmL7ZxWCzDGzWGp7IiqvtvV6z?=
 =?us-ascii?Q?+PNxpLy0aoYMqVns1uw7rrCiDab5rx2Z7OQJVvqQz8PV3Ap5zWS0rBH9pP5L?=
 =?us-ascii?Q?ur8L8A36jwqy42FGnQVTfVqsOF2M8Eez5kw4pwQ7bTmQ8f/AZyEbx+3nj8az?=
 =?us-ascii?Q?VkT9mA7BbQ8nj6BBvtOANTUeaaABLM8O7beNKaurIMrsN2VpZo9+s06W41vP?=
 =?us-ascii?Q?1ZxLM+L6yMgK2gAMudTE1HgLu9LOv1lOG+GRWfulLTONYiylCv4xy6f5oJtl?=
 =?us-ascii?Q?0wP8txPubA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b440abc8-c3de-48bc-a630-08de7fcdb789
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:26.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRcdh5GO13nWCzE8H9LPmAXGFlKBdAugNYWsH810Yq912KeGSmWriid12Tg/4GmS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550
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
	TAGGED_FROM(0.00)[bounces-9340-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: D818026BA53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the missed check for unsupported comp_mask bits.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 8d9357e2d513bb..22993273028433 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1918,13 +1918,13 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 	 * it's fine if the driver does not know all request fields,
 	 * we will ack input fields in our response.
 	 */
-
-	err = ib_copy_from_udata(&cmd, udata,
-				 min(sizeof(cmd), udata->inlen));
-	if (err) {
-		ibdev_dbg(&dev->ibdev,
-			  "Cannot copy udata for alloc_ucontext\n");
-		goto err_out;
+	if (udata->inlen) {
+		err = ib_copy_validate_udata_in_cm(
+			udata, cmd, comp_mask,
+			EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH |
+				EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR);
+		if (err)
+			goto err_out;
 	}
 
 	err = efa_user_comp_handshake(ibucontext, &cmd);
-- 
2.43.0


