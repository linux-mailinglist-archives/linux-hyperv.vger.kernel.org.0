Return-Path: <linux-hyperv+bounces-10004-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD3vGPei02mOjwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10004-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF053A3311
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C6E7300E632
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 12:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA217334C27;
	Mon,  6 Apr 2026 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tyGby41k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C9E3128A2;
	Mon,  6 Apr 2026 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477491; cv=fail; b=gPd/LyAimUAFQyV3H1FxRWEF1vGISGQz75Z08lbOzp1sdgpZ53OUe4c1rsb2NSY/joXXjf7kS+FPFhm5Wa/QC62X/OLefbRqja/4VomAAYstVQNyneW5O12PH4+ZrOGRVXkpTHRNqlLESQsw+DPwRzdfS3UQLDy95qcNzBCZcvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477491; c=relaxed/simple;
	bh=YPN6FQD1Pic+P+KhZkeEfp5RHnbg2GHEDMzoAk8GKmU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P28R8l+huHrhEcKYWILuK0xNEv8KbV3QGRyzGWfNnRCyzzeoBiEKKwU0v+gELwkmYwxSWEM1LOXvGR8a+5zasC5YUe0br5DtDBsL9HFLgr1M+0TtzAjIBGzrlvH4JonPKxRhJFiMOWr6XkKg++naKLno2C+4FoJz/9BJdMXoCHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tyGby41k; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFY2743N0J3zH2lAJMYSqv0P9CYR9vFHLxO0L48/ogriBTGstGxqULTt/xahZh94FMEZ/PlyQT/V/MTqxG1DJorzZ+PgFCIPHPX7La6Fiw/4J7h9JST9feelDQaYqPjxp97OjDjoZWRtD/9mANmtgjXye9AzPE7xzY3+DGX+ZcvfxXbdL6ZUzwv+huMUgww9BC9nAkAKi2hw+QP9LXPQ0LU3IM9MibQ18jfmvcSWuT2CTYOlCTH5oZg9rmwCs5Lmh15sI07wXPc6SvfsN2vCZCqq4BfP79QVp9RU7cEoG6fYPnH1zlIThLQxx1Sw3Tl9PD2JH0/u51viP8m8SmMohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXcytSsDwB4yt51MfH3JGUjY4EkU7RVdSaVchYMasPg=;
 b=v5T0JXHjDC+kQ6ID8/7usmXTTbWWBcVTPJb1DbCjc+CrgbY/yFLviu4Z9sxKPiut7bGKFiOdDCbLGCSTg+S8Zc88oQVnSvY2ozYqmyzVh3pyGl4VLrPWqCwSeMCkNzgDGzzOl7cL9SmTqM/7jG+zkrdqBKfRbD/xGj/nRRYzfUW5KwqUM+lAyR0jaXesVvMZDfox3YkQwfG64KkzqSt3RaZ7VwFhRWW72r106PsKPl8hlrC0z64j81CS3sZQfNDNfzpua5gG5V8B46uFinP3Op26VT/CAQA0G2H6RFhLGGfaB+01n/t9iWJASq/WfAzg9CRAcTZim4MzCH4/qenOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXcytSsDwB4yt51MfH3JGUjY4EkU7RVdSaVchYMasPg=;
 b=tyGby41kshXPDNzsPJLg12QFVEJKKpMOWFdZWnV3IpuN9nKfCAaOjd+2aXyHNaCxMhIvG1zrZzj2qk674wWL3ruzQFO3bPG59zw3j5DdER62ebL00PZ+4QaVUokRoWGp/SzrhCRHMDlm3K9C1+oDPLKBAs6nv5tKy6Ld4IeLxB1EpQVIYJg4K/vMX9pfRIVE88U+dTqwt8KOrdIu5tg7QDsGeyUhjinncabwoGAknfgFOeuS59NzVxTHQvOR4AmTDmC3WL1JKxxOJgbD+Rf2FrwZ3ebLoN9EP7BMT1l2CNaRsV1737dgrg1+YrU5lCGNDuJyXDpvFdWEeQBaRJhDWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 12:11:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 12:11:25 +0000
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
Subject: [PATCH 00/10] Convert all drivers to the new udata response flow
Date: Mon,  6 Apr 2026 09:11:14 -0300
Message-ID: <0-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:52c::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d4ac4d-893c-4df3-937d-08de93d59fe9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	/UQhOYO/87428d8l6tEQk5cYKwIG7fUwTFRw1A8aaNe2vaqN3o+aVZkEfJtAojZuQIZd+oUwQ2mSYI6P+JZ08jOBwumuV4jcUObKrL46KEmvAPgw3ici6Ak4KiTJTGI+tuSpbvQtFJiCl2ZtKrJv86hMc50ie0ACT58WRW8/MJDuadnWwrrbFRNZOuf/6osH3jUkd5yDvHPSBUDKXYVDT8/o/+hK5hmI3VI/WxzZ8BCRKrVGiIQ71aXOGgLTMjCHd0GaXiCxeb2YCCYYenu2eiU+3ib/5s5P74JlxczPxwWJxYi0LejIeTR0w5u67rh/+bdmLfDJJNd+LDhuJe7HM72dQathA1G4vcTYWzmj5p/fpSsUkRljxGCPLy+h5S9WL3P4JWUzM6mi8VL3TwW3H46ob8PJupTiWDvRLUyHWpxeeZPohMpUBQNIVnVHJ69NQBTo+UbuUKh5e1kKJOAzrw5+A/nPkdRPDl7Wh6vxBmfUfBi+/jB/2SLx/vtKthSrLQky6fZPu3fPwndJj9FiRLpJlo53bB+379aNYO0v3NIo37SHlHRnPJ3zyEQx5cJANGBi4YyylTP8YeZM726aSOgni6qju2UFWe1NyPmf3+8INq4dlV6XKUqHCTgryaGcvDRfKdJRs1w0ixSWwV2+zzdMxf2cDIQfZkX6TUZipa0z2FAKxVAAZuMsfsiWEL1Qk6QKlyrWU1IlSJVtg8pSDgtKyNVxWvXhDWFGJH4EqK1dyi4/VqugUfLEVbwarkMDLeK2whwgQkmYcttKAqxRxA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3zmPIP3McKIR9RejUnssfEVCMgUr3TFiqm9+LwmOs7l9vUTrMiWUj5gZzxMH?=
 =?us-ascii?Q?1BIw532JbssrrXrWz0cF2QS89d6MR9rwH7udeX+3/6PoLbaWQgyKT2asz01O?=
 =?us-ascii?Q?VIcMcphiE2RB2K48imi2hVgX2A3767mE6e0NL17a/6O7WQ+vhYUuU7EOR1eL?=
 =?us-ascii?Q?7Nflq/TBQ+jZeg1VzikNGtiYbCnkg1g15rrn+H0JTeer9PTZHt3hiEn4H5+k?=
 =?us-ascii?Q?VL/S8Tn6yNZVPkX79yrgPeankjhhYpLsOicAvjs50Ucp8kam2mj+ek0dFmu/?=
 =?us-ascii?Q?LbUuymzkD4TD4gaHYvugFITNVh9gARGSp+IKjnhzfymqhNmjLEYRfrfz+dHR?=
 =?us-ascii?Q?2Q7DT2K4V/rUP6HUVsSx3tZWv0XBGVyHDoYy4I9YPk2/FxCoIMWgQNITT+CA?=
 =?us-ascii?Q?Y5UwO+WT4/PfabHZ9Mj1NJOE9/ox7qAkGOTiwiVaaD7BqoNPgD95tr6KJfls?=
 =?us-ascii?Q?GVLJftVMllq5/6GIQZjGLM7BTbUNgzvFWCJV9pT8FENGc3C0LKN1GHxRzFU5?=
 =?us-ascii?Q?F91xTQJdxxCpI7iN9FwWj3Ewz6U6R2VWApU7mK3t9fQRTwJJ0i51A1d6K+fp?=
 =?us-ascii?Q?TNWjvJ55uyHekeU3wTYB/XbVVSFirBhGhGjqsfRcyFa8tOdXMcQUltxc8fMs?=
 =?us-ascii?Q?jFc2CgowiSQmZ7a0WlxG1Zo4ReGkly6Bif7O0e5Q9qBgDLMgt26Y/XmLbR/6?=
 =?us-ascii?Q?Yw2GbFhYfzdRtWYiVF+Q6t2mTEqDauivenCf8elZ4mmQobI4KlrVcHbSKV3y?=
 =?us-ascii?Q?+B3RS/G5k+8QDMnSji35uL4yuVZKATODw7W9zzL8922DHpLCnU1OcGhXYOE2?=
 =?us-ascii?Q?2wrGpF+JZM+PH6/0N+EElGqLvG9+XNVSXiHvwC2lkVYpVRsgGIcO3lA2hF2e?=
 =?us-ascii?Q?txTXk1CTGZUBBbUKXWsjKss+7tzptzs+ieMwsnBtU7X5YZnQo9pxddvdfbWg?=
 =?us-ascii?Q?4owULVIGYu2gPPh6/UWLK7vzyjYtSCu8MM6V0lbSusSDEultpz/KLkFtWZoS?=
 =?us-ascii?Q?nDPtPbobbUytoCdboVcJZ+zvwwLEFzXuWeGMgGL0qkrq1+yqjIYOsVENlw8H?=
 =?us-ascii?Q?A+31ooVhuWTMDjXXPVrEq1vqgw9U3zeRExUB1Ev8ri3VyfOWSkCBQb9Uf57H?=
 =?us-ascii?Q?IENUIdoFVqD02zYqDc1p5Gn6o0Mul/ZdcKOZjbNXxUXlta3MXuqTprzEK0lV?=
 =?us-ascii?Q?3OR6YP0l1qJTX1cJhpjkeCK7f2pmaV8ws65pIcsVt/zPMxdtUuYMIypvElK+?=
 =?us-ascii?Q?yv/V0j+/rvXOiAWu8yTiNnh3HFK7N5gnRztwXGpAtw7mgNPnfzaQ/QHIwdyK?=
 =?us-ascii?Q?VZEE/06HRhjlEnYwMOgo7ydEoRYstRzu+KogoiNS3gAhRj3aR4eU8kgyOI8p?=
 =?us-ascii?Q?iRbzkFsLSLqhL8YzKYl8MNHbdPwJyQmoxswG4Gz1a5O23mF8icc2JdapZdFk?=
 =?us-ascii?Q?DDcylS2OlgvBN+eDOvko2oDgM5OZhuu7cSqKjzKucB5fQQRxY4gCC6xGoIgt?=
 =?us-ascii?Q?ZFl+Jrn5QgfGfqnS7Acw/E52No/2X23XuJPmQlRr9cf9kWIuvdeSWFKt/VTa?=
 =?us-ascii?Q?4cUluQeJva+zcaTWH1B0yaBU+ccFHqndJ+E0tze4LCb7Hn6NjQI178UthQwh?=
 =?us-ascii?Q?wJjgKuj7TotDOK/2EVFcvNF6ZUDMaqZVpTR7xO2AKO/buZXRQRl12UQW7GZf?=
 =?us-ascii?Q?m14ADw8fRtLEWeqTry9x5IwiVv8/htZ+5iCGsoy6RhbfkJ2l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d4ac4d-893c-4df3-937d-08de93d59fe9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:11:25.6963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXrDFd4Mi8zH7Gmhr2W5JPfkL3RDg7lG94II6HWf1TWgNLWfahR9FkkRKlxwXclX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-10004-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: CDF053A3311
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Go through the drivers and migrate them to use
ib_respond_udata(). Remove debugging prints on failure paths.
Ensure the error propagates from ib_respond_udata(). Use the = {}
pattern to initialize the uresp.

There are a couple of oddball cases which are fixed up in their own
commits, but otherwise this is fairly straightforward.

Jason Gunthorpe (10):
  RDMA: Use ib_is_udata_in_empty() for places calling
    ib_is_udata_cleared()
  IB/rdmavt: Don't abuse udata and ib_respond_udata()
  RDMA: Convert drivers using min to ib_respond_udata()
  RDMA: Convert drivers using sizeof() to ib_respond_udata()
  RDMA/cxgb4: Convert to ib_respond_udata()
  RDMA/qedr: Replace qedr_ib_copy_to_udata() with ib_respond_udata()
  RDMA/mlx: Replace response_len with ib_respond_udata()
  RDMA: Use proper driver data response structs instead of open coding
  RDMA: Add missed = {} initialization to uresp structs
  RDMA: Replace memset with = {} pattern for ib_respond_udata()

 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  2 +-
 drivers/infiniband/hw/cxgb4/cq.c              | 11 +--
 drivers/infiniband/hw/cxgb4/provider.c        | 14 +--
 drivers/infiniband/hw/cxgb4/qp.c              | 10 +--
 drivers/infiniband/hw/efa/efa_verbs.c         | 87 ++++++-------------
 drivers/infiniband/hw/erdma/erdma_verbs.c     | 13 ++-
 drivers/infiniband/hw/hns/hns_roce_ah.c       |  4 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c       |  3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c     |  3 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c       |  8 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c       | 13 +--
 drivers/infiniband/hw/hns/hns_roce_srq.c      |  6 +-
 .../infiniband/hw/ionic/ionic_controlpath.c   |  8 +-
 drivers/infiniband/hw/irdma/verbs.c           | 48 ++++------
 drivers/infiniband/hw/mana/cq.c               |  6 +-
 drivers/infiniband/hw/mana/qp.c               | 22 ++---
 drivers/infiniband/hw/mlx4/cq.c               |  7 +-
 drivers/infiniband/hw/mlx4/main.c             | 31 ++++---
 drivers/infiniband/hw/mlx4/qp.c               |  9 +-
 drivers/infiniband/hw/mlx4/srq.c              | 12 ++-
 drivers/infiniband/hw/mlx5/ah.c               |  2 +-
 drivers/infiniband/hw/mlx5/cq.c               |  7 +-
 drivers/infiniband/hw/mlx5/main.c             | 16 ++--
 drivers/infiniband/hw/mlx5/mr.c               |  2 +-
 drivers/infiniband/hw/mlx5/qp.c               | 17 ++--
 drivers/infiniband/hw/mlx5/srq.c              |  7 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  | 40 ++++++---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 31 +++----
 drivers/infiniband/hw/qedr/verbs.c            | 43 ++-------
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  | 13 +--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  7 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |  8 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  6 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 11 ++-
 drivers/infiniband/sw/rdmavt/cq.c             |  2 +-
 drivers/infiniband/sw/rdmavt/qp.c             |  3 +-
 drivers/infiniband/sw/rdmavt/srq.c            | 19 ++--
 drivers/infiniband/sw/siw/siw_verbs.c         | 10 +--
 38 files changed, 223 insertions(+), 338 deletions(-)


base-commit: 69db255d5fafb5651013c79e54c1d535fc5015fb
-- 
2.43.0


