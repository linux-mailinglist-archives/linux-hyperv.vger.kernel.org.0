Return-Path: <linux-hyperv+bounces-10035-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFFqIlfw02kjoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10035-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB6C3A5CBB
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D7DF300AC9F
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61C03932F5;
	Mon,  6 Apr 2026 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fWwIF118"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CA2393DD1;
	Mon,  6 Apr 2026 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497264; cv=fail; b=cdPb1jttnfVDG/WgCPvY/0zzDsfMk08m2cVmPP+/2QvYawIwuqV7E/yad9yUAoim0FHLYPslnmlYBQEhMkkQeCOUlWu0eS1Hx2S4086Ah5BZo6XvysbFz85ULc4u+1P/w+EMbySO0sd2y+L6jFQmrlfGCJW2v2CwSA3nI1SsAPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497264; c=relaxed/simple;
	bh=xDaTiOBvqxxMswppf/clKp7ZHTLcbwvMSsRfs7cdC6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sORAQnG3avbmmkSj1e1q+GAUS5uDRDojfO6TlpswLG7Og7pM8DnD0kVtbhcV0J7uOEa6DpU2LADpMiKDy+qFCmQExjGeM8AcCc/hQE/qRAa06c8I5dOqjyURMrOiuzsgoYNAAsqgC7YNqcaNDyQWPwiT9xfbMo7lTTFCCWWx++Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fWwIF118; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rr2xTCtVZTHJcVdPNF/g2dcCwAIq5dnvLoZPShFcqmT3gYdA8fZyCjBE/a5WihwXTEwBr7s8pgQbDxAmryv0rU//Y396xjRTLAtnQpfQJODO9URK1/QzFjvhnAf6P0OzrS0ac/U6W36KbW8fhjWmrvlGQkLb4+7QFdMGchvdIzB5nosv4n35LfP8157t7YSl+9TIg4VrSGORi9QKJQMAGBw5bKWZfEabaVdNH+j8M8wZpQfapf52k9RA+eALhOfxYNhLWjzVK+JyxWY3NfHtvvJNXwzAglH3R6iG2LEa+rTHVesiGR3WTAjw3kWi2ZicwaCs40Ty9ZEB819O/WT7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQwyAAvkd39n/2czbjHa0ovkwSSJqmNRST8sxCqm4b0=;
 b=Ssq2nV8oImQCSiTTMWyFFYrgjepWZBrxUbBV24vtOOA0+ZVmtNBUUsFrg9TXCkQfb/DrA/lOtWdE4i5AqSZ5dvOM/RGFW4th4DubBQWuHXwFeXZqi7573FH/kz3V7oGMPaUu6wdQ1+j0gwlSaSpOfImU9BK/ZHFKReEF/cf4EuP9dqqawtZERcSxJz6VJ0VNiieXgLIfCiA6g7hcM9liasitX95/Zbv/yWqAF+eAhGQqRKyRh3f9cZS1robQjiuQz592rq0uFIqVVfwzVUhDADtQt6XJsQKcIlWaoRzTF0XRLFYit2evTyEAbhvoafbX7Mumvt+/qBwWQy9Xu+vgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQwyAAvkd39n/2czbjHa0ovkwSSJqmNRST8sxCqm4b0=;
 b=fWwIF118NyVeipdWNMVTiqhWHE+c8Xmmw7jcLbsAOscBDwWEv5JBzvrSV81Rc0uqJYXfAOeujrWfJktNHzgG6ZC8x7MrLonctJAhneGojq1aWC2X8NFXo4ELhhP1TFOnzEkf3BytavDm9VrY/uJjX8o/jESpPnwtKBnCvYXVgBpK85M+agdXxUL8KFmwkoahnMOSLgshHrjr29Fdlp3freJDa7ssOYLT6g6Dv9wACE2z7r+4/oELY/AtK6CM3oPQEdGRUC+5D508EQqeUxPk/rP4/7whNWVabKhoIUJZTGB2DYV2ZIcib27J/wvK/PRsPG8UrkU1uLLtNPnggPQdlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Mon, 6 Apr 2026 17:40:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:50 +0000
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
Subject: [PATCH v2 11/16] RDMA/cxgb4: Convert to ib_respond_udata()
Date: Mon,  6 Apr 2026 14:40:36 -0300
Message-ID: <11-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 48963142-f36a-4ba8-b8ea-08de9403a2f3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UHvYMN6DZUAsZ9dJ6tGZ1qWlviEe+Ov+6yIdxxpdfe5oIlaEkedbdYxT5I8BFPocjMnflgqVvq9mERglHteMok5IxYgy5X8wWe4KH+lnTqGN/GuGeNh3wh2jHKYpfRSgIh+ESwC6rP64VxpnVH9WCZE76H6k43ducbNCAEeE2nwQghm5dLncClCnbaCm4IjOVX0LB7vqNKAhtOYzQElX2nr9Dhpnv9oKiW+L7qG4SdDC0ZwhleoY19Mz9+PqCMy0jyhjRF/59+db+uOBc7iCaJyljD8nsfpPrUKJ92MNb1gmUATCbHciBPxE+jCnL2wx5YyiE6EvcA3hYlkIoD/KSWCDtDWrw/edRWzcQQlLMA5hdXeU4WyvofuznycvlJjwDwHDBn/ELXQSWu8jbXQzEdolcm3tbq2hm/RSJBv+hkHhk+5tc2fj8cmrCTm8dWtSQHTfn/aqvXPEd6o/KlrJ9g6JrXm3GettAUtnGeNCJVmBv7FmJahwmtxjeltFHoycij4nrJfO1NUYBTLY2GX5YM7zajE2tdSZllnAXK2TRrS3aLCbzDHEAX1+pBdQ2boY9Ao7+wsOGXC6vTKIhB+ijNOsIyu4R4RhaDmwZuT6Yi/QP1pnJCILaCBBe3q9DE5wZQVDUfTNIZOLLkFYVqBVFlWOTe4Df9KSM3qYgxcrspVa4l+S0XcIEVDRvA/3XSnWIJxSzlfcNeEwr89D0s/DvzywOwFYTDNmChyur7ZuNzPbMLuFekJ9SMeOsd5+zGt/PSaIO8QKW2KnygK4PseNKA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NlWznJ114R2gqMQKukIJbvQgskl0dnEu6oAYzVwGRXnsflYTnxJYdExV40tN?=
 =?us-ascii?Q?pSH5jIIEAf0SobttiuWco6+IJwWgO0Z3qCXJUL+sHcIqEvhVJ6zIn7PWXOwB?=
 =?us-ascii?Q?TJZ6IKEbgCFu0yQ0Bj+4aBDOjATO2UmwP3JDJeuA0fA+o+ZTFc/KUVLsgisf?=
 =?us-ascii?Q?ad6M893MrCP1/fY8OTkUodUiEGqur1kDLlR8/cHsdyawAKmGVXPAil5gJ6P1?=
 =?us-ascii?Q?r0kQ730cgGJR3ay3JuXBFyPZYndDgv9dAFcqSGLYUWUFbMpbaAMVJRNvnOh7?=
 =?us-ascii?Q?CwDUN3D0mS6KzstzM/YY2+tm4d2k/oHbT7XY/GFM+G4xQ6R+PH8bs9VbKZGl?=
 =?us-ascii?Q?ja74ZeaT/E/IAk+ltw28kQVTIkuFd7DnO7tshLPHiKAAUEY4XojdF8+FRizE?=
 =?us-ascii?Q?syCby3Ngh0n5Mm1YJBbyWeGxRNJDCvA0tjuIMiQC6dXpbLfUXozLckDFheXr?=
 =?us-ascii?Q?2Ri9Kae5N6XAP2y2C+0bukn7nrOnT9+UQuFcumVqSh5K7MkYZKoTYsRQMB4V?=
 =?us-ascii?Q?yVXt/JS9slRAGfx0tuG59Tq6kBF1KCgtYLOFwipzjtiMJOxKppMDGA8LBtwB?=
 =?us-ascii?Q?pJGHn6NafUDPWn5MPupAXYMgZu3BvWohk/PHOdRR50g27wpUvoByuO89OJPH?=
 =?us-ascii?Q?F1kXzJvH2XFbSOM+Y7q0U/SHdnZN8Oj7PEMTYhqxNuQVlqGKw/x5Pcy5V3PY?=
 =?us-ascii?Q?2xyfD1Jg9fubLvQfv+5vkb68nxwYKB6k7TcIWLvVWh8mFnQR7IcuwFhitKeu?=
 =?us-ascii?Q?A/MvcxBqp9vONnpVHWjKLJYwA/tQxchxfWWUr+5B20XIXcpsyFFwVXNHwtJe?=
 =?us-ascii?Q?QpDrJcDbz/N0yYcRdmbMJU9ZKe8RSJNOhgsM+TrKLthPO+IRAckNzBNGernH?=
 =?us-ascii?Q?7chYg60tLCg1eqqDrXw10RKwgZrzf3eT4NoPdomoXy20f3a49TwU0Jb87Eoi?=
 =?us-ascii?Q?8+lkSYjRUJqpk3p+mJ+Ci1x/7hRUE2r5milmhYlndPgKJfFby4gB30CXqk7O?=
 =?us-ascii?Q?RycjS9VNRt97GKH7VLoe6DN4ytNnD00VttksytlfeM5Fo+7lma7a1p0dloSJ?=
 =?us-ascii?Q?xT4j/Wg7pkG7VcYx1fIFomBFtq1duJoGjRqF3diZCLfQIDkuLhoUIh1XllPN?=
 =?us-ascii?Q?W0edMA5EGVBDk3fqRRoLeCwHC5sjy7o1gVdyVSyr5OBG/nfdAwCXaR0Q9NtE?=
 =?us-ascii?Q?hmSUSqaU6KXmry/ACHH1L+rHEXqgJQlSyL1Y6YvyrNNcxWWnKf5zigyCs7kr?=
 =?us-ascii?Q?SD48mIUDehTGwe/H7KVljlgeVWwzGEfeAVoemWnHAkFhMmbdX19ZwUS9ltxQ?=
 =?us-ascii?Q?5xkZDDKwVKouGhKCb+Q6pU9v2MxZGNWKwmqTiWyosMwCXXxdgDEGZSSt9Rbl?=
 =?us-ascii?Q?jlY8Udtk9EvbAAsm9FxgpZkWcSZ58dIvd1w2OSY6zYd9tnZo76K0z/PrAv4a?=
 =?us-ascii?Q?aUx5pthYdrdKOru8jufpOosyBISeLPGbKqOZVjiGzD55v9WKEZu81QzZPtiy?=
 =?us-ascii?Q?m/4re/3uu58501I+VK0GWuxJXDeYULwagrVxUU48Bjj8TZ5HtclYfwvl0rH9?=
 =?us-ascii?Q?92niKNxdMy6vSRVUJz6YkSOeOKAx28RqX7adtvjx6Ek6/EWZumyTmQf5D0I/?=
 =?us-ascii?Q?6xqW5eDh9YYVZqbqOlfc74VhfHeaYVdS11JJ3kfz6mTo5KOsE9q60l7w2Nr+?=
 =?us-ascii?Q?RAJ4+RB3fJMCFGOGrpDnuXCjXlfF+PHSFllSEZUv+2Ek2Ua0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48963142-f36a-4ba8-b8ea-08de9403a2f3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:47.4486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30LplelHfgEcW4kWEbw+L2ToU5gpageyg3nglWfRkR+r1OB5pCYOE5LKy4+EEq5Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10035-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 6AB6C3A5CBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These cases carefully work around 32-bit unpadded structures, but
the min integrated into ib_respond_udata() handles this
automatically. Zero-initialize data that would not have been copied.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/cq.c       | 8 +++-----
 drivers/infiniband/hw/cxgb4/provider.c | 5 ++---
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index e31fb9134aa818..47508df4cec023 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -1115,13 +1115,11 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		/* communicate to the userspace that
 		 * kernel driver supports 64B CQE
 		 */
-		uresp.flags |= C4IW_64B_CQE;
+		if (!ucontext->is_32b_cqe)
+			uresp.flags |= C4IW_64B_CQE;
 
 		spin_unlock(&ucontext->mmap_lock);
-		ret = ib_copy_to_udata(udata, &uresp,
-				       ucontext->is_32b_cqe ?
-				       sizeof(uresp) - sizeof(uresp.flags) :
-				       sizeof(uresp));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_free_mm2;
 
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index a119e8793aef40..0e3827022c63da 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -80,7 +80,7 @@ static int c4iw_alloc_ucontext(struct ib_ucontext *ucontext,
 	struct ib_device *ibdev = ucontext->device;
 	struct c4iw_ucontext *context = to_c4iw_ucontext(ucontext);
 	struct c4iw_dev *rhp = to_c4iw_dev(ibdev);
-	struct c4iw_alloc_ucontext_resp uresp;
+	struct c4iw_alloc_ucontext_resp uresp = {};
 	int ret = 0;
 	struct c4iw_mm_entry *mm = NULL;
 
@@ -106,8 +106,7 @@ static int c4iw_alloc_ucontext(struct ib_ucontext *ucontext,
 		context->key += PAGE_SIZE;
 		spin_unlock(&context->mmap_lock);
 
-		ret = ib_copy_to_udata(udata, &uresp,
-				       sizeof(uresp) - sizeof(uresp.reserved));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_mm;
 
-- 
2.43.0


