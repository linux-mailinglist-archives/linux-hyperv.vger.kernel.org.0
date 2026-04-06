Return-Path: <linux-hyperv+bounces-10021-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFVmCynw02kjoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10021-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:40:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE323A5BFF
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 341E03006999
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F69938D010;
	Mon,  6 Apr 2026 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QtMrhy7J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5E391514;
	Mon,  6 Apr 2026 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497250; cv=fail; b=I4DtcvdH0+wXsiG4MobVBypgGzhVYl/hgFzQd+E6at2JCY6ZM1GtWbaSEO5TSSN0TAm0h+yss3fV/TBYA7RVe3ktPz/j9pndxI786S7NMLuLtOZdBY66OPefIQO2A5wiAvwW3sr86tWTvfksLK25JR+JbnxWDMNUX2ioBlaV7QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497250; c=relaxed/simple;
	bh=cbDH+ATUL9ECrK78nK732YpVoirO/3XYOxcp5HiB9jM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rNdHnkF/mI/fMuZNQZwwScj8j2En7C0Y6O2AwcAPiUL9UZxI0UP/xMzRJYVt1lo7clfLaJ/0ZLZ+UitZ7tk7msZReeRGEUYm3IL5z5ZMy1ahEzXsYiOASFM6edLJDQG2xtYF2kcKJoYVEWqPZf91ct1MjdNKRbmNPyLZM69LA14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QtMrhy7J; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4VcejCKm3762n1m0zGfMiSi3Lr4HOI4BKlKNds6YOCtqfdJ5XRGGbUdnLRRSGw9wmSCJnhNggXyy0hXtzOV5y6hCXkx+SrwUph0NjV1SGokQl4WGE+gWYg9B/N0fagD4f/NCNxWSPeOt84hPPeJvAb9cXjJ4L9tAwcSoGHwbDuxXndlDb45lxhIGr2hpjtwjYBOP+ddweNrU7/RiJGCDvoP2/gPw9xAT3s8JHl1+Ia+MmhIZK4/6LZY87c4dXSvKOgS5cK88hEG+NutBt1E5a1GBeWqPl/Udjd4NBUmTf5JrTNtlHQifetnNHZc4imUk5fX4o/rdLr0WuCwDL983A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VldWHUbFWE+uP1nuM4uyMtRDUWEYIykZdQhXr3OgYMk=;
 b=da0t/MbnRsWXcwnVLFd9bcEmQN3tRttyS8RfOgNMUWLQWECb/9HP8F/ao6o2gJE594yUYURG5AbVIHNCnxKeKg+V4fdPr+IEmdE2EsU1YGAW8qFfgCtHXMUb5eBR9TxNtoah19kSj/Hthc0lVpN+F3jYKNT241DgtjmIxKBjEm1VWPEXPrZm2yGKeDNBd+2W6JID+5lGqdqI6Jj/b1aPPownfjE7LjHE6zHwQBAMvhiZrLWZYBjTAHrzU/fLr72qmyE3Gwn1oHhdl/KVOE1pvl5nTZIbMjd4n0iuHBV0EY5I+bsj37vKSSfSL299BwMOXHF0cQdzxt0Zqk3IooOFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VldWHUbFWE+uP1nuM4uyMtRDUWEYIykZdQhXr3OgYMk=;
 b=QtMrhy7J1NNq5MFJE/SM+1PaQSm4TNoBkokJfp4+RSaBGMoC9s3FF8F3/FBV6yS6/19+66i+NEg5w/r+VYTVIvknY9b+pZHCZ7FgtiKx7gtXUAeF+sMGhyGMLdQTsWfmmp4yxDaE+ec2ZqoUBo+tM1G/j6KVLz0UEDgZBpysU6uSibms5O2BvScPdD1NMqSwl5W20M3Smr2DXp5JOcmFyGNXZ4VR//yp6CPm2bEfi4YGwggaeZrpqmDWWc8PTC7Sq9milVlRUSJSn80S6HW6S/1KU8rP5VZb8lIzWEOTT3iM/tDVhjwwJEQAHS0b1gMEnvDx6CFkXS6OlPbbaEv31Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 17:40:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:43 +0000
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
Cc: Adit Ranadive <aditr@vmware.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Bryan Tan <bryantan@vmware.com>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Parav Pandit <parav.pandit@emulex.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 00/16] Convert all drivers to the new udata response flow
Date: Mon,  6 Apr 2026 14:40:25 -0300
Message-ID: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a5fe27-315d-4d0a-c1ae-08de9403a057
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	B2vlMa7q+yXjnh7QLFuWbWNUoOC4Gi73Z+8lSF/o+8sy43ZqfmWeFVXPknYOHgybyPWtStHwR3Qo6E1I1ZIAMPbjz0DgF5fkEFEABvjOFjIcCaLGPWDsjI6Jqfclh5FI3j1IFMGgQlvT+BG7v+ZivRV+HPaw7cxc1pJERxqO8XOm73zkHFaZAh2eYS451Xi5qxuMA6in2f2wC+USdGlCIpxf24l2pAeyUOs9NBnpsJweUMfaegnJPubUHgXAFJuAlmyjkLxbWg2wgYuI2MXl8hjXFn4sJnnzzFbN7h4AyyDdMCt42snd4OVtk+NRISC3ctRfcw+x5mdRTVCIwF4BPxKjz+hcv3jQdd6WEqIv2ozO2car1XphkhxdhaFkCsQJgM5W9+Q+QZqmPQvirLTQJu2OurP9j+WTkofza+KaEYU1ml7KsQSVHSxEMAPS862leN/cpF0pWBMyFyfTscrC1Ea3UDwIfgGODb9PR/Ur5t6RhnvfLG7dKZvu78LYfCnKjkXiVCABuOAFkodE81UZTbMYtsn+8Cbthjvm4nZnhMaGKr4J4oEMpzzVNL83/l7gTgqfe9IJYf4+HQtjpGkvSl04TKia+sm8RbustkDfaC+Y4l4rjb926Zs44blGdCVxL0HLHw+2RDXFoYLDMQaMEgjP+/TEpuL4QQFGgyz/YYvPYKrhRJBGcDeVRXSmUp6zagXqiSCs13lztpE3o0qucF0Kg+9OscnWreIobn0TNnNpxdC+TqgD8RGmNPa8V45vD+P3ei9K3Qttzyze+vAN8/MuEyRdgMNwrWadbFKutSI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9E/jesrHqOHpgYntvwaVgYWkszAoJ1+5aXmqwqFSBK/LGhupYhwly7kmIL31?=
 =?us-ascii?Q?du5krInpdduhOQsA5feJ7gNikNy7Ht0At3L7ooasJ1epB9GiaUqgxM/mxP5h?=
 =?us-ascii?Q?Qy3oVNLxC40llkexSmg2si5vpYfKRGBSVDe8UzGQj3Hq3ZVyjOhx2VUrDnOA?=
 =?us-ascii?Q?E8ci/N8Kw0X+HSaQy16WcnFcO0CPtL+pVpyktAqouBT2OOSn80+0Eyq6iXTN?=
 =?us-ascii?Q?IG7Kl9v9mcvGpL4uQJ2NiFs8tgJYcc+UFBY/QzOTxTh0aRmB2v20cSS1VqHI?=
 =?us-ascii?Q?h2MmnybWp6rJbw3//vtt7RXx4OrVsZq6/H/I0WWZXuR9fqyRfrRNG5R/VxwO?=
 =?us-ascii?Q?weQI8L0ysr9p7wxMQvasLluGOVjx7gtaB0xlAmnhTBwEdh63a6jTZCi5lkym?=
 =?us-ascii?Q?8lq0y8qLyEsYWZ0Ep1LARkNjjEn1XD0b87YgCJH4NWGGfgPTrlGHz0Imelic?=
 =?us-ascii?Q?kMdqmN4+KntwnwRtgDircI3wFTIByn48X/m+1KlVv8l3IrFGbhHULWgno1kI?=
 =?us-ascii?Q?f8JP9zX0Hnukp27PQUv+ybElgrnByJZqN4yF12BMAhUz6Zt2CRYU5qtSX8wN?=
 =?us-ascii?Q?OHhP4/OmGZXkz2pQDOsNKBikpfh3rzHKHbNdK62T5qhyrg+tr4reA75sSQe8?=
 =?us-ascii?Q?AwntMo9ME1VLB6ZPxp03DxDLSIlbAaaFXxN+ZpoCU++i0DKrdr3SO+8dEHb3?=
 =?us-ascii?Q?ISeUP7uvPRKU0wKMMvobpoLfFK9VfpMicMv4yMhso1IdQ+/oWGNbSaiSCLYd?=
 =?us-ascii?Q?ShMmbzblwTehG6BgY+PWlAxRenssDGQT18sQxN2lxsNDyxNMpZcN1TV1z2gd?=
 =?us-ascii?Q?C1s9iGOEBVxe4LZiJW0XUSRND57oySiMeA9jkuTT2GI9M5TC9FLX8+ox+GgL?=
 =?us-ascii?Q?hYb4s9tfcbUb26vPJDCQ3bZP+BvqZ9fsQ5LmFL98IPXgiaYLeagGziGr5OW9?=
 =?us-ascii?Q?APjnDdv9+qCwzaUat9m8h5VmKOl2bOzLnzS4ef/N7z0wAyIdS3dxommMH6Yu?=
 =?us-ascii?Q?S6Y/eHKtOwCp3Bz8Desp+enrW7xzIdSURT5ele41jfbXvjipZedAY3GJspGw?=
 =?us-ascii?Q?XCfWuBwK0k+VVjF97u0VfUmL2+nte70jcdxj7va2GbPHUxpjhUGulMdRUIcL?=
 =?us-ascii?Q?2K8BL53V+P5A0xTY7Xlr2J3muOa53B/CWOEN5/UObwBNdkAoo5dYIraUZQdC?=
 =?us-ascii?Q?a/4IfRXX4krR9z+1oimTI7wmobWGYX8FT6vchmH7TCXChr8wcah2WPOItwJl?=
 =?us-ascii?Q?YBa/AXqGwV1CEGU3Eqb6M0qbWZn1eAvmVghqh6elSqXw2GUiXUdyt2bWPCBR?=
 =?us-ascii?Q?P53h1/CdEi03djb816dUewjSwZnATKWsfSTK1dEV11yHs2Hf0CsSK3muyMGO?=
 =?us-ascii?Q?aQcY/7/ZEDVaiznHMZp64GCC9JccOsbGGJD+PVvSfKTlq68OXELLEcxU6LQ6?=
 =?us-ascii?Q?6wGAmvjnACAV7Raz0YG0rpIXBl5BVfL1iodoWMAfGsOuwT8zr+ie2evnXqHj?=
 =?us-ascii?Q?nkQP9dvLtu3gEKPzjL9Df3xg6TrtJN/GN+x5q4TeH0K+wpDjsskf7TL64Opw?=
 =?us-ascii?Q?HpPtDHs0QFfySUhuqD3NdZS1+Q0kMX8g+CFI8f5cSk60z8DvF4KUG+c1dC+H?=
 =?us-ascii?Q?1xO+BkHXsMTY2VSaIRYidRMj8j8lTs60dPpeZVbz4XEndZ6DzH0jAjiHA/g3?=
 =?us-ascii?Q?vopSj5w8NxBh4DfukbT4VP3M9sekrpg+TMLzJCPNZjG31Ax2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a5fe27-315d-4d0a-c1ae-08de9403a057
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:43.1158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTAMnPFydahZb2qr9qzWi5TUqeLnZ35P6miLb8v1J/5+rElYTkhWMsndyyDWmZiA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10021-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2DE323A5BFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Go through the drivers and migrate them to use ib_respond_udata(). Remove
debugging prints on failure paths.  Ensure the error propagates from
ib_respond_udata(). Use the = {} pattern to initialize the uresp.

There are a couple of oddball cases which are fixed up in their own
commits, but otherwise this is fairly straightforward.

v2:
 - More patches fixing the pre-existing error flow bugs
   found by Sashiko. I left the rvt issue behind because it was too broken
   and scary.
v1: https://patch.msgid.link/r/0-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com

Jason Gunthorpe (16):
  RDMA/mana: Fix error unwind in mana_ib_create_qp_rss()
  RDMA/ocrdma: Clarify the mm_head searching
  RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdma_copy_pd_uresp()
  RDMA/vmw_pvrdma: Fix double free on pvrdma_alloc_ucontext() error path
  RDMA/mlx4: Fix resource leak on error in mlx4_ib_create_srq()
  RDMA/hns: Fix xarray race in hns_roce_create_srq()
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
 drivers/infiniband/hw/hns/hns_roce_srq.c      | 12 ++-
 .../infiniband/hw/ionic/ionic_controlpath.c   |  8 +-
 drivers/infiniband/hw/irdma/verbs.c           | 48 ++++------
 drivers/infiniband/hw/mana/cq.c               |  6 +-
 drivers/infiniband/hw/mana/qp.c               | 26 ++----
 drivers/infiniband/hw/mlx4/cq.c               |  7 +-
 drivers/infiniband/hw/mlx4/main.c             | 31 ++++---
 drivers/infiniband/hw/mlx4/qp.c               |  9 +-
 drivers/infiniband/hw/mlx4/srq.c              | 16 ++--
 drivers/infiniband/hw/mlx5/ah.c               |  2 +-
 drivers/infiniband/hw/mlx5/cq.c               |  7 +-
 drivers/infiniband/hw/mlx5/main.c             | 16 ++--
 drivers/infiniband/hw/mlx5/mr.c               |  2 +-
 drivers/infiniband/hw/mlx5/qp.c               | 17 ++--
 drivers/infiniband/hw/mlx5/srq.c              |  7 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  | 40 ++++++---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 39 ++++-----
 drivers/infiniband/hw/qedr/verbs.c            | 48 ++--------
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  | 13 +--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  7 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |  8 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  6 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 13 ++-
 drivers/infiniband/sw/rdmavt/cq.c             |  2 +-
 drivers/infiniband/sw/rdmavt/qp.c             |  3 +-
 drivers/infiniband/sw/rdmavt/srq.c            | 19 ++--
 drivers/infiniband/sw/siw/siw_verbs.c         | 10 +--
 38 files changed, 239 insertions(+), 351 deletions(-)


base-commit: 69db255d5fafb5651013c79e54c1d535fc5015fb
-- 
2.43.0


