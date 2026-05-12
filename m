Return-Path: <linux-hyperv+bounces-10763-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C4UK9JvAmrkswEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10763-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:09:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AC9517BF6
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BF02301CA7B
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 00:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADCA495E5;
	Tue, 12 May 2026 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gLcXJhYa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8243D994;
	Tue, 12 May 2026 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544589; cv=fail; b=VkbwpUJ+VEPphv00J82UaWzB2SIHAZ6tvzgQ8RNCVE2cvWoh3Si2rGEDWKXfqGVDTLLyCBfFGYaLFcAH2+wkKZ/zpL6lBX4ykSa0rshJR7I6QCENaoackLBGxgs9vasH3mKfAcNnPwX/lGQ5+N6YaNxgoocMdpN9woNFuaQwSho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544589; c=relaxed/simple;
	bh=gT1QW5AUv7RQ+6/VVs6ArpfjkHnAMoV8eXIznvtohuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BKIqaXRw/QLcrjVKCCLLNnkAcNtdhiSsL7Ss4johRXqjEvtImLmvdYqY1LUiezMLOrXxgTKiPUU6JJDDX2lgAmbAuhkSoockD2yp1wmseG4Gl0yoHBABKTXx4Yvd/vjs00RUHsgWS2QznTdFrCgeZ2ZhI8VnSzRJ0MZGieNbJR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gLcXJhYa; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2khukCdmCW8HfrE+JVpXMfrr1S2Gb2u5TLvY/JIdLWK0qjEcp2hZixFPNcG/N5HTAgJI0os+V7uVZ4BNniwCHZmDMPaxyCOaMoCFnhSORO7suT/tRQ0OOkFZTVpomPzN5Vmc1D8P/xdSTNAFfQO5J4ZEScy0VfeqpSEcO7T4nkEnhXdtobQtgyQIC2XPGNj8HFJMub4fp/A9hhwxxLj9ecFshYdj86xw0xkB9CRj5PuBK/GkF6F600il56vjz2PHPxB5xWtLIeuaalPSPHeeO32cvcWKm54W1OEDhQ6S0CMOnW7E5rGgH+zyGyp/iAyJKDW2QYgjAoaFRduMw5MaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUic/PP8Dc1ziSMSpKqyjSQRAQYRno6FBPBt4IvYQcI=;
 b=OXI+Lf9fjTOYXwMwDwUrKD9CSYz0UZ3/94Rcdpz1j4cbwxWR3YvLWLCpsmFXcAa5Rph+15BnPVu5FjLo8We7pfyDWwK61/EIOBND+Z45vOVP4WccLqQN9mbHLLiVFCgK2U4Y4fxUXaN6X7EVa/YVs4nbkdDEbQ65XZhbHb/cBHnGl2T9+wioC1hfvfXqq3dlOu0swfekaRCmrqx6jI3Vp+eJTx/j+OX5Ah7NvRT3yAfk4XteQsQdTRmH+QY6DOng7M68sdDH/N/uOIFxs0ksaKj5TvRYTEO06fbr6fDe8C+d/SPeD2CwOWR6ul7mvf+5nhsnqifrQcSyrue2DThkSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUic/PP8Dc1ziSMSpKqyjSQRAQYRno6FBPBt4IvYQcI=;
 b=gLcXJhYaWPjCRnsNSmXblfraQapyDZjAXeY9o4JkJi31yQvjIWWKeayduRrl++V6aW1fgE24RrhEPHTaj5xDqbJT2k+cJftayNg79Qq1lbLUGnM+ZRdW8xgQsOW455An/5SaauIOjXToqQB6KXamkFpVtiG1VPSx9zsUYC08f3XRpoQGscPiQ1f+YOYwtpIexg61wtOL/ckT8ekB5D9pWsrHlmxMOb8Asalfj7R1VBszHlgoyIrsSGg926r21dx4OdYaGIji5jY3Ur5Zy+Ke9Ofhgt6cWM1OymcdISEWytzZsSYccbpjpkUmwB8mZgjwkN1BqRnSOB6WTUcNk8i1qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 00:09:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 00:09:42 +0000
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
Subject: [PATCH v3 08/10] RDMA: Use proper driver data response structs instead of open coding
Date: Mon, 11 May 2026 21:09:37 -0300
Message-ID: <8-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 308a4480-7fdb-459d-cc68-08deafbac3f1
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	d2HX51lPZ6zgy3ttcjL2GQaXZMH37e5+gWNcGtubJNZJn5H6DwLReZK5Gy4SSpWhIkrgN5LtljJLEMVpBbV0eZoN7Ok9da1jJ1IGtZzjnfgLko8z8Dev6+aOx64synFPm6wrHR4UResqW2vKaDvhC/BVRCNEwQ9L0IDMDx5IBnXRbpqQICQwvq6Gh2WvfNOzNcYryxn/pGpHEnqo4zCcT9ZxN+m3s9MLA2EzegI+1o60cRgz10ktUCuw77pKv0xdBfL77G+LU1Y2UulLymOkvNcPOHhArH8XxME01Bf/Hk7mqC2bp1ainqz7Eh0zNumAz2SF+Vk17J97cNcVuTq8drS1PUoY2WzTw8mluexPdypuTc6lKksRo/fP+xO+1wR/h7SfzCmRY3+RUmydJcGGkLQuF/cdMwCFh6JZC1qZQpUvuqdSg1AhdzYkD7feJb2vpp3fAQ9X15u2WYQQVNwyX/+lcJygFG3kFAqcnCCViL/1IEX4zXjU967mhB/TNcf1cx05ZtAuhgWgVLaQGtbk4E28C7zVzL7dhr27yXESJtVKjNnjtRChN7wR5S0ALuhNiYa8xFlEuk2VXcVgSnqnxuwj1WQMUamO+V0r4zsc9fv/gYWnnoCQ/1/52DG0IWRJteeWWoVSj5Zt+Fk+MIu7Y1FELzJvf55zCfVkQIGsOdvhIofGk+Pv5ugfWiW7duSI2wlW+duMHMCKKGU1mFjH90oQq+LQrAZlZI9BiGLNIo4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ImPLuekD6LezUU4uxSTJGzASj8/n5QvVIMux5t8Kt99CLeStOs6CUgOC2gR?=
 =?us-ascii?Q?PcYQzuv0YET5B9rHm6RvUHv8GWCO1VYkP9ixeK4tLDIz2M0PKuiScqIEpuvJ?=
 =?us-ascii?Q?yXQ1aO5wnvfbfQiVIkDwN9qUGmatw9oYlZSF2QuWyImwQriTKG4RvBG7mAnp?=
 =?us-ascii?Q?kD+4E/wXb3K1gHUWt/cGRIzPCSnPbAklOPlD8wybWkEwsD5zYooW7rb7yQ3L?=
 =?us-ascii?Q?pi4g//fGIMKQaDyLZ8OiMeVMHZlLufnSXwJV0F/XD+mwn01eVsr7ZnQ8LJyt?=
 =?us-ascii?Q?CeFOCU+b+aZQYI/rReIQw4NNS2TqSggPVkPgEsYnsWWBYYt8O3yhWxpsF4kn?=
 =?us-ascii?Q?hlrH0o8x7OOxTK2P/88gR+juX23Ba7OefJf1P1rYJK2MB045HyBO8Y6hAg9a?=
 =?us-ascii?Q?M8SKYTCG+oJoZOpgO8wcbiDtU+sgN+FFLyqiPRj3Ch+7adetEs5Z64azVfPi?=
 =?us-ascii?Q?r03uOEnGjoxbkqDeIHnleEnqV1rsvdHb0DXT432p1tZ400W6xkihjizGp+6H?=
 =?us-ascii?Q?7aWvBeHJeP0bp8+I3pN8UkWt3kd0IaDcfbMBc7CluZ0kbqb8JyFTCM0MEErH?=
 =?us-ascii?Q?GE6iFIRXTf8zn25gjz1D9XFSv53QZseFfD8DBpTQ4Aagwdz8/sv4lbCkvia0?=
 =?us-ascii?Q?4Z/SsQVnx/fJNrncXIvkidarc6TKsuxdM5bW8yrzLDMIaZgtTTq0ze/ayxHD?=
 =?us-ascii?Q?i0JHF6eXD1xkn2ZN8XEGtJK0SQx6vHDnpzDhgyC3OfDMN9yyG1gkjp6Qtpd1?=
 =?us-ascii?Q?Czf6BjwShIy7cDKr+u4NwS0vakWaZxssduHqBBvcyxlFOn81toe5cv6F0lCI?=
 =?us-ascii?Q?j22UJK/V8HCrfhLDqgQjAdbjaD7PzFHXZQ/hcps87IkBZuSzXD9TeB1BuZZu?=
 =?us-ascii?Q?ug9L/lJvjQsvcl+IHx+NwRgLw5UUcKvPtZ64/utTP4ZImTCZfJjcddae7bYH?=
 =?us-ascii?Q?u7H7Aq7bT0f6fLFjh7bwp4lTm4o+7N9ta2KW1F2O9MsyxS22AndL3Z/zTzBZ?=
 =?us-ascii?Q?9xOfkoaQwyf+o2x6f/TotTggLqAWtc1fvRtv00iPjSx93L5D3av38m/zaR4Q?=
 =?us-ascii?Q?2aUe+K4o5KgT9HPHiR5dVpPEiHgp2vyYxfs304dvF8jtwJSE87v/OOoMH5r+?=
 =?us-ascii?Q?mUR/ot/40qOknbkPedCMQYKdKJRf5oOVrbFRWA6yXAwPE0do8ANRZW9zysvq?=
 =?us-ascii?Q?wG2WuK3s74DHbISm7hQif3e+2xDxAPE5SmEssURP/3iViICM/nVVjgsEasMk?=
 =?us-ascii?Q?lF2Y6XRGmKKxGbRW85cB9acuXEqufXzX+6DkvqqyRePs1Bb9H8j1CZEFsvMC?=
 =?us-ascii?Q?DR+nad25FX4wyYZYp/a3LM7T7ItWvNbw7O6qZIZXcKlTu2a9xZi1tA+oJCCi?=
 =?us-ascii?Q?0xn/+quCeR55Ax092UT3dSJTFnDB/U04xhEq4/d8Txsxl9rmxwVYGB4xIEAM?=
 =?us-ascii?Q?m8gCbPcE5ITfxxWeq4aQyHaH5ilaxOxZfyYqHgIO0DPhdbWZ73o4xKmMkiVZ?=
 =?us-ascii?Q?7xY6CGEb6acdxEuXKmuwc5u6Tikq0JJIPK+iUV2Q4ele3i82qJ75yru+M9pr?=
 =?us-ascii?Q?ndBadi743ZCdEr+XGfdoFb0P1242nZnsSUU9DUDo22xQF+J+PZofXxvQAeeZ?=
 =?us-ascii?Q?RkochmGqPDkTkVZFfCvm/D7+mvGva8oNHKIXYMFipO0RBYfsmpc9IitoVZ9p?=
 =?us-ascii?Q?7XU7l/uqAevrEV3+mY0WmNdAB0Cc1Luw6t1gcTwdzwwsV/zh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308a4480-7fdb-459d-cc68-08deafbac3f1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:09:42.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkB3YLLW0VgbhoulMXuGnSMVYtKIQl9WS6vXsC5yVbYRgCjBFSY/QyKmDLuflgeD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698
X-Rspamd-Queue-Id: 36AC9517BF6
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-10763-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
index 767840736d583b..dd868f9b893d70 100644
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
 			goto err_srq;
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


