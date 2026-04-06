Return-Path: <linux-hyperv+bounces-10033-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLHnLXzw02lEoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10033-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:42:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A43A5D34
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92729302B800
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5625D38AC7A;
	Mon,  6 Apr 2026 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hfxucfu7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B503939D2;
	Mon,  6 Apr 2026 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497263; cv=fail; b=LcTNjFzw99fogGkKH9GsSGXJjYij5+PQnpphXjkxnfv1G10uDTnHkK4ZmwQtw3j0E2dHSJxXSHKMXKf8yLuBf8//AnkLwXXn946GK9s+ZuLbBro1NL6aI6FPb8a79ncGC8TfJN9lOfV6IHgGs2Pi/zC0ZYqmZPd0Kw+IDFkyaC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497263; c=relaxed/simple;
	bh=ru3P1XMYzJtDQSKakzjqOWZLRKVR0Mv+EeERDdXulnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n7ZgRQHVPbc64hAKf6XokDGIW4XSTh2KM+FvqLgK95zqK9XjYbBVhDkiEvk2ts5scXLmUZLCLfDRqJr2cvje6tZ9mfJhqn1cQfXij76kbDW5y3hDLgt8D7ylNmRc9TFu2/QNE4WLFYkZSenwowKI9NlE1PftJCTG9VkiVjTWoYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hfxucfu7; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGLAx0BmOwk9jRiAn9eMEs+E8pbtxJHTZ65zGwfuiH7KH4Ux+pYOGzXiUAtFnrKYI+Ex4MYKhVYqW6AUG4ipl0qHMpb3/OAXk90ZA6FY5LzKciNCnDYzo1T8oNM6XSHPwI8RGRxNRlvwCHWfkzvDhjFB3iZdwIVvOhg0ZicUtVZeJ8zN1jFa0uCcE6q2KPRBJQtczPyd6jOy31MppJAgLtp655bNRgWW2j36GKemzvuHh99cE/E8bqHJDjRQp7vVO91NGRThr1/FS3DRd4ZoIAf569D0HnKygbyNTYfYowh3fvivDcQLi0+8aEHTqydcHbZ+C6cp2gMRLxKsiDEfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Tb9vdmjfx/f5fKI/XBQlEIy0GLsW68GCat828cFIV8=;
 b=B/zv3+vZm7x7r4EiZzP5dKz1mx8F/VqAzh4vIGOnuUi3p87TuddGZoVCIVp8DF4n3zuL1NrVd1ZLSJE4p5+ayC/E/fQCBnWk1saPCvAFSktqy16ykcATyKiyiN9VnQDMix0p2Pd5IdUOZrt2Ja2uihnRxg293wWTPASlsA3prrFAZ/zws/n3KLIkW2WLNc6Ll85kGR4X9VN+SSkVVq5smcaGEogGNd+Hdc5OpZWRRXM1NUaBwdy1phaowiYPANR2Lb8Urn3O5uroxCG5J7lFfGQdiP13T2s8zojeqDPzWBrplBc8C1Fm+/i2lI2s49HrstRlAQ3H9DQcsmSV0r4EBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Tb9vdmjfx/f5fKI/XBQlEIy0GLsW68GCat828cFIV8=;
 b=Hfxucfu7ei3GqESN01RvjNhXvfyzWwEe5l5q/F5Pn6RKqGC/HzQlDcPbDXG2BPJt/hlHrqaaoR+j48CBp7d1/UPukI0ZYka2LMUy94KseIEH9BL/MNiN8AvEoHAYqtiP86K49qI0RJnEUr2mmvxPhhuUEDp0oeetQg59q7++CAvivKm6QYBrpjnveRMAFHA+zU8rrQyXYE2AmJYjLFNeQf798Yg1sdGCsXrKvBGD4d8Nb3mvfhGCdHqVa6k9/Y1Qd6A6BNCCI3c7P7w9ErZqpActhxcOWJ7o8ioQYjkdeENLmgNqcYltSalesabEc6K7GI+udtxK4njhVA2advrMUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 17:40:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:46 +0000
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
Subject: [PATCH v2 10/16] RDMA: Convert drivers using sizeof() to ib_respond_udata()
Date: Mon,  6 Apr 2026 14:40:35 -0300
Message-ID: <10-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: c970df79-145b-4e6d-294f-08de9403a104
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	kMCrpuHG3CvGavpMVnyONGHPJhID28hwYtuxO4AFFkmdvI39tAhG4BjZNqVjHtdzylBIngs7fuPj0VTSc6ky8joUPBWlxsAO8k4QF4YSa01BUY1wKh18eHwPHXe7TqZUUxwmj3f717eZzNDiAHTrWr/kNzEXHZEpcaMXwCzJnjQROuQUD/XrUw58UOJNoGlQ1VVtzWG/Ueej/KSnkixo/ImHw9mLiWeqn0+HswFOduU73i+5KPuYQ1pUtBBjV5u0VvMV3Xl5/8Dpc+ccts2vmmQ8m7LbfvqaqF62o2qAeHC0Pxyv/0X4Bco6783Irwl/edhzYsU3iqEcgZenxb5sRL9AiphyWCqzqR5+dyd2dS3zr9fJBzpdCNE4q0LzHLR+R8T1ysLKC6qbQtBbXN2ydo2V7/7fxJaCzBD2mcW/t2OYmZJ2Gy8lJ4GAn34R84QPww3yiG1EIDZ2KMtgZNYpBcMwHDmg4nvWxf196xJGZS/ImgG1OMM/8STrBpQH0O4mJnpH9FPdtOkiIpxUJnFWwCDBCQwtK2r/65jW7TaB6HbbpLr4IoJQNh8CshnvKlz5seza1kbn5A73EWjDVS4CSXuYWs2G6I3IONnl3ima55q/uKqEiQfksURpZap5RYx6SzcG2FEtyjMHbJkLRtPs21VziZ8Dl3DFukbhst2bCStW/qryCkdFFqzBsDm0rTbzxzKh6r3rU1Ps5qEUAtkEz4v58pwp4S/TBPqhvA6UmgbE03U/trt7/7Qe46S8L4O9GK3bjCqIBqWb4Hrf2dYxOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?glbs1+2NYwy5DhNuMGBn18WNSY7UCOjMyavCJr6AsiYJeW7QRS0BRB1Oqfdj?=
 =?us-ascii?Q?knpZ8r5kq5nmPhotfkhkj0wgi6qzcWUaH2ACHTTScnRi9AAc20NlmcGZblYw?=
 =?us-ascii?Q?HJyt/wEHmx6Jv+y1BgXxZUknJ2zq4KcjmcQMrOsh6/ikwZNxQ/8TAuOcqaC6?=
 =?us-ascii?Q?H+dtJpG4rtZFx2rHkZDvP4Ak/LYW1itgHP3uXaxx86Itoj0jBNBvxqCWvqNg?=
 =?us-ascii?Q?DEzADWfsjzhDMSEl7vVQLXQItNMTuiC3hEPKIUbtT8Ul+o41NNi644fMcOT8?=
 =?us-ascii?Q?WYgEPy5Ps4IsGwoZnrUoMikH8mFfydPa/7PWalQsUf0DM89CN+4hrmK9Ey8c?=
 =?us-ascii?Q?4COhZTAPUlr/+tKx6yVfX8oa/CSTvX2ynqxHdBgDmSxtHOC5jpJO+sCVp7sM?=
 =?us-ascii?Q?utoBt+2xiiIkHWKgbmsqbK0NmqIF75AwCpyiq/fppMSKJ3WVniT9TnsjY/kv?=
 =?us-ascii?Q?BD1fpl3qfpQt83gsGkBLl9A4IbB8ns3UXk7/iw2i0bx1NzIl3sIhn4oLIH8f?=
 =?us-ascii?Q?MXspKiTbWd/9eBtSxSIdpcXUGBJJ9pJbuPl6lLPTVlvwDhqhAdPj+toyY8qf?=
 =?us-ascii?Q?CERE0l8H8LzXFnD2gB1f7XgOUv3MArX5d4cgvkcxJhkLvp8/WrU/YgzMcep5?=
 =?us-ascii?Q?Bkm3lDbg8dACq/vy0+uygUwK0XXQ8N6WRanYVrEIkZtWDufGqpEaXfxf1FTq?=
 =?us-ascii?Q?JthnWoFDqsPWA4k+Es/301FOkSKQeclMV5xQM6VuGcrAwpLlNZHagryOmzqN?=
 =?us-ascii?Q?E2hAsPrv1cMlaTtwT4HmsGe4zqJMHkZba0ZNEFgv9hXqWkSKwKvUi/twx4gB?=
 =?us-ascii?Q?1hEcDtPhlVGCeUQD1C5ijp6rl9OHOGd3edHJQxXal3iXOqFzXCYxIjv40uO8?=
 =?us-ascii?Q?4O/kVIlkDlIQsmADy+HCw2wQCYzcgI04Yrb+qB7ja3lZmABmwN/fplWKyZef?=
 =?us-ascii?Q?/0eysz4ua8e0PRJxmVWQHDVi0kG20D27YH6k8Dd2sat6xgNEV/XismIbGCvz?=
 =?us-ascii?Q?lK7I/caF02J6IA0ooscrZVuKFqFOvF5W3vXrI0d4FRLvjTzowGMfYue+Mmff?=
 =?us-ascii?Q?gMgOEl5cxgU3IbkWjcRh93ah1J5BAdTxdxfNz9wxtfzZ+fk26pwUAIwOsxV5?=
 =?us-ascii?Q?Sa+MrH5qvoBugEbgVhwLyPbadOyJMeaL+07azKLRf1bjvCCfTeFe2N8g5js5?=
 =?us-ascii?Q?tRd4ZM3LD6w9MJMgqfUNiky6cRt7XFhW5ttyBXNRWaVFC8ZuUBLeCELd/A2N?=
 =?us-ascii?Q?ewQzvRfZk0uXmASRoQCWVPtmU/8VRVmv3ylz/olQFTC/+pXLXibo3s8ovQmh?=
 =?us-ascii?Q?2H4majVf7qfRcUrVi+YbRSlAL6vlT0NGa6oYJKcjTtIuPnD308J7YAGa7mgp?=
 =?us-ascii?Q?p5eIXtsbv+TeCK3yXLuTlo4gLWt6PrnOFQSm6Qpt+ocE29DmB64rriOFDKRd?=
 =?us-ascii?Q?Zp06+VIqOpply/I7NUNTYGO0es+ZFMwa+qxBODEer2hsfnoNtlotkyGywMzi?=
 =?us-ascii?Q?qf15OME7SjEgfu6AJlyMCdpJJS0UE+Pgp8j5mq7M5VBWPE0Ws8zZq9WR5YNk?=
 =?us-ascii?Q?huXnw/AUSowEX/yo7gKRCrQJhWNOKFjfXEI+VEijE1s6dCPDaaj6Pgtd7Hm+?=
 =?us-ascii?Q?yyqFr0UtB3Sm9dg3WyvjTI6g5RV7hdlLaGQZcmccKKAZGUaHERx1piZ7YBHA?=
 =?us-ascii?Q?Em9cwjym2SOpmkHsv5sfe0iUHXKCuQdeg9iwUIndArs1Qfuh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c970df79-145b-4e6d-294f-08de9403a104
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:44.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MgHMk3lG3V49xWJnJMJ7vK2ipxNPkXnB2v6tN7HKpCV3yZHzKYI5+LeLaHPPmUz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10033-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 777A43A5D34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the pattern:

    ib_copy_to_udata(udata, &resp, sizeof(resp));

Using Coccinelle:

@@
identifier resp;
expression udata;
@@

- ib_copy_to_udata(udata, &resp, sizeof(resp))
+ ib_respond_udata(udata, resp)

Run another pass with AI to propagate the return code correctly and
remove redundant prints.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/provider.c        |  9 ++++++---
 drivers/infiniband/hw/cxgb4/qp.c              |  4 ++--
 drivers/infiniband/hw/erdma/erdma_verbs.c     |  4 ++--
 .../infiniband/hw/ionic/ionic_controlpath.c   |  8 ++++----
 drivers/infiniband/hw/mana/qp.c               | 16 ++++------------
 drivers/infiniband/hw/mlx4/main.c             |  8 ++++----
 drivers/infiniband/hw/mlx5/main.c             |  5 +++--
 drivers/infiniband/hw/mthca/mthca_provider.c  |  5 +++--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 19 +++++++------------
 drivers/infiniband/hw/qedr/verbs.c            |  7 +------
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  9 ++-------
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  7 +++----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  6 +++---
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 11 +++++------
 drivers/infiniband/sw/rdmavt/cq.c             |  2 +-
 drivers/infiniband/sw/rdmavt/qp.c             |  3 +--
 drivers/infiniband/sw/siw/siw_verbs.c         | 10 +++++-----
 17 files changed, 56 insertions(+), 77 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 616019ac1da501..a119e8793aef40 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -52,6 +52,7 @@
 #include <rdma/ib_smi.h>
 #include <rdma/ib_umem.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/uverbs_ioctl.h>
 
 #include "iw_cxgb4.h"
 
@@ -209,8 +210,9 @@ static int c4iw_allocate_pd(struct ib_pd *pd, struct ib_udata *udata)
 {
 	struct c4iw_pd *php = to_c4iw_pd(pd);
 	struct ib_device *ibdev = pd->device;
-	u32 pdid;
 	struct c4iw_dev *rhp;
+	u32 pdid;
+	int ret;
 
 	pr_debug("ibdev %p\n", ibdev);
 	rhp = (struct c4iw_dev *) ibdev;
@@ -223,9 +225,10 @@ static int c4iw_allocate_pd(struct ib_pd *pd, struct ib_udata *udata)
 	if (udata) {
 		struct c4iw_alloc_pd_resp uresp = {.pdid = php->pdid};
 
-		if (ib_copy_to_udata(udata, &uresp, sizeof(uresp))) {
+		ret = ib_respond_udata(udata, uresp);
+		if (ret) {
 			c4iw_deallocate_pd(&php->ibpd, udata);
-			return -EFAULT;
+			return ret;
 		}
 	}
 	mutex_lock(&rhp->rdev.stats.lock);
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index d9a86e4c546189..f9c7030ac6bfd0 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2280,7 +2280,7 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
 			ucontext->key += PAGE_SIZE;
 		}
 		spin_unlock(&ucontext->mmap_lock);
-		ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_free_ma_sync_key;
 		sq_key_mm->key = uresp.sq_key;
@@ -2777,7 +2777,7 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
 		uresp.srq_db_gts_key = ucontext->key;
 		ucontext->key += PAGE_SIZE;
 		spin_unlock(&ucontext->mmap_lock);
-		ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_free_srq_db_key_mm;
 		srq_key_mm->key = uresp.srq_key;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 9bba470c6e3257..92a65970ab6fa1 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1055,7 +1055,7 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 		uresp.qp_id = QP_ID(qp);
 		uresp.rq_offset = qp->user_qp.rq_offset;
 
-		ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_out_cmd;
 	} else {
@@ -1571,7 +1571,7 @@ int erdma_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 
 	uresp.dev_id = dev->pdev->device;
 
-	ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	ret = ib_respond_udata(udata, uresp);
 	if (ret)
 		goto err_put_mmap_entries;
 
diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 7051a81cca9420..2b01345848ddb7 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -414,7 +414,7 @@ int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 	if (dev->lif_cfg.rq_expdb)
 		resp.expdb_qtypes |= IONIC_EXPDB_RQ;
 
-	rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+	rc = ib_respond_udata(udata, resp);
 	if (rc)
 		goto err_resp;
 
@@ -752,7 +752,7 @@ int ionic_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	if (udata) {
 		resp.ahid = ah->ahid;
 
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		rc = ib_respond_udata(udata, resp);
 		if (rc)
 			goto err_resp;
 	}
@@ -1263,7 +1263,7 @@ int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (udata) {
 		resp.udma_mask = vcq->udma_mask;
 
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		rc = ib_respond_udata(udata, resp);
 		if (rc)
 			goto err_resp;
 	}
@@ -2315,7 +2315,7 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 			resp.rq_cmb = qp->rq_cmb;
 		}
 
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		rc = ib_respond_udata(udata, resp);
 		if (rc)
 			goto err_resp;
 	}
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index afc1d0e299aaf4..9758bb8533f155 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -210,13 +210,9 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	if (ret)
 		goto fail;
 
-	ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
-	if (ret) {
-		ibdev_dbg(&mdev->ib_dev,
-			  "Failed to copy to udata create rss-qp, %d\n",
-			  ret);
+	ret = ib_respond_udata(udata, resp);
+	if (ret)
 		goto err_disable_vport_rx;
-	}
 
 	kfree(mana_ind_table);
 
@@ -351,13 +347,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	resp.cqid = send_cq->queue.id;
 	resp.tx_vp_offset = pd->tx_vp_offset;
 
-	err = ib_copy_to_udata(udata, &resp, sizeof(resp));
-	if (err) {
-		ibdev_dbg(&mdev->ib_dev,
-			  "Failed copy udata for create qp-raw, %d\n",
-			  err);
+	err = ib_respond_udata(udata, resp);
+	if (err)
 		goto err_remove_cq_cb;
-	}
 
 	return 0;
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 16e9ce8138cb30..ce77e893065c92 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1121,16 +1121,16 @@ static int mlx4_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	mutex_init(&context->wqn_ranges_mutex);
 
 	if (ibdev->ops.uverbs_abi_ver == MLX4_IB_UVERBS_NO_DEV_CAPS_ABI_VERSION)
-		err = ib_copy_to_udata(udata, &resp_v3, sizeof(resp_v3));
+		err = ib_respond_udata(udata, resp_v3);
 	else
-		err = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		err = ib_respond_udata(udata, resp);
 
 	if (err) {
 		mlx4_uar_free(to_mdev(ibdev)->dev, &context->uar);
-		return -EFAULT;
+		return err;
 	}
 
-	return err;
+	return 0;
 }
 
 static void mlx4_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 7d435cf5a2fdae..57d3b80e7550b6 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2791,9 +2791,10 @@ static int mlx5_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	pd->uid = uid;
 	if (udata) {
 		resp.pdn = pd->pdn;
-		if (ib_copy_to_udata(udata, &resp, sizeof(resp))) {
+		err = ib_respond_udata(udata, resp);
+		if (err) {
 			mlx5_cmd_dealloc_pd(to_mdev(ibdev)->mdev, pd->pdn, uid);
-			return -EFAULT;
+			return err;
 		}
 	}
 
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index e8d5d865c1f1f7..07c60797c86091 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -311,10 +311,11 @@ static int mthca_alloc_ucontext(struct ib_ucontext *uctx,
 		return err;
 	}
 
-	if (ib_copy_to_udata(udata, &uresp, sizeof(uresp))) {
+	err = ib_respond_udata(udata, uresp);
+	if (err) {
 		mthca_cleanup_user_db_tab(to_mdev(ibdev), &context->uar, context->db_tab);
 		mthca_uar_free(to_mdev(ibdev), &context->uar);
-		return -EFAULT;
+		return err;
 	}
 
 	context->reg_mr_warned = 0;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index a88cc5d84af828..2a174d0fe6ca1e 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -502,7 +502,7 @@ int ocrdma_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	resp.dpp_wqe_size = dev->attr.wqe_size;
 
 	memcpy(resp.fw_ver, dev->attr.fw_ver, sizeof(resp.fw_ver));
-	status = ib_copy_to_udata(udata, &resp, sizeof(resp));
+	status = ib_respond_udata(udata, resp);
 	if (status)
 		goto cpy_err;
 	return 0;
@@ -611,7 +611,7 @@ static int ocrdma_copy_pd_uresp(struct ocrdma_dev *dev, struct ocrdma_pd *pd,
 		rsp.dpp_page_addr_lo = dpp_page_addr;
 	}
 
-	status = ib_copy_to_udata(udata, &rsp, sizeof(rsp));
+	status = ib_respond_udata(udata, rsp);
 	if (status)
 		goto ucopy_err;
 
@@ -945,12 +945,9 @@ static int ocrdma_copy_cq_uresp(struct ocrdma_dev *dev, struct ocrdma_cq *cq,
 	uresp.db_page_addr =  ocrdma_get_db_addr(dev, uctx->cntxt_pd->id);
 	uresp.db_page_size = dev->nic_info.db_page_size;
 	uresp.phase_change = cq->phase_change ? 1 : 0;
-	status = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
-	if (status) {
-		pr_err("%s(%d) copy error cqid=0x%x.\n",
-		       __func__, dev->id, cq->id);
+	status = ib_respond_udata(udata, uresp);
+	if (status)
 		goto err;
-	}
 	status = ocrdma_add_mmap(uctx, uresp.db_page_addr, uresp.db_page_size);
 	if (status)
 		goto err;
@@ -1206,11 +1203,9 @@ static int ocrdma_copy_qp_uresp(struct ocrdma_qp *qp,
 		uresp.dpp_credit = dpp_credit_lmt;
 		uresp.dpp_offset = dpp_offset;
 	}
-	status = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
-	if (status) {
-		pr_err("%s(%d) user copy error.\n", __func__, dev->id);
+	status = ib_respond_udata(udata, uresp);
+	if (status)
 		goto err;
-	}
 	status = ocrdma_add_mmap(pd->uctx, uresp.sq_page_addr[0],
 				 uresp.sq_page_size);
 	if (status)
@@ -1754,7 +1749,7 @@ static int ocrdma_copy_srq_uresp(struct ocrdma_dev *dev, struct ocrdma_srq *srq,
 		uresp.db_shift = 16;
 	}
 
-	status = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	status = ib_respond_udata(udata, uresp);
 	if (status)
 		return status;
 	status = ocrdma_add_mmap(srq->pd->uctx, uresp.rq_page_addr[0],
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 679aa6f3a63bc5..3b86ea1cf88883 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1251,15 +1251,10 @@ static int qedr_copy_srq_uresp(struct qedr_dev *dev,
 			       struct qedr_srq *srq, struct ib_udata *udata)
 {
 	struct qedr_create_srq_uresp uresp = {};
-	int rc;
 
 	uresp.srq_id = srq->srq_id;
 
-	rc = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
-	if (rc)
-		DP_ERR(dev, "create srq: problem copying data to user space\n");
-
-	return rc;
+	return ib_respond_udata(udata, uresp);
 }
 
 static void qedr_copy_rq_uresp(struct qedr_dev *dev,
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 615de9c4209bf1..e887f03a84d063 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -82,7 +82,6 @@ static void usnic_ib_fw_string_to_u64(char *fw_ver_str, u64 *fw_ver)
 static int usnic_ib_fill_create_qp_resp(struct usnic_ib_qp_grp *qp_grp,
 					struct ib_udata *udata)
 {
-	struct usnic_ib_dev *us_ibdev;
 	struct usnic_ib_create_qp_resp resp;
 	struct pci_dev *pdev;
 	struct vnic_dev_bar *bar;
@@ -92,7 +91,6 @@ static int usnic_ib_fill_create_qp_resp(struct usnic_ib_qp_grp *qp_grp,
 
 	memset(&resp, 0, sizeof(resp));
 
-	us_ibdev = qp_grp->vf->pf;
 	pdev = usnic_vnic_get_pdev(qp_grp->vf->vnic);
 	if (!pdev) {
 		usnic_err("Failed to get pdev of qp_grp %d\n",
@@ -157,12 +155,9 @@ static int usnic_ib_fill_create_qp_resp(struct usnic_ib_qp_grp *qp_grp,
 					struct usnic_ib_qp_grp_flow, link);
 	resp.transport = default_flow->trans_type;
 
-	err = ib_copy_to_udata(udata, &resp, sizeof(resp));
-	if (err) {
-		usnic_err("Failed to copy udata for %s",
-			  dev_name(&us_ibdev->ib_dev.dev));
+	err = ib_respond_udata(udata, resp);
+	if (err)
 		return err;
-	}
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
index bc3adcc1ae67c2..d5bfdbfe1376d1 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -203,11 +203,10 @@ int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		cq->uar = &context->uar;
 
 		/* Copy udata back. */
-		if (ib_copy_to_udata(udata, &cq_resp, sizeof(cq_resp))) {
-			dev_warn(&dev->pdev->dev,
-				 "failed to copy back udata\n");
+		ret = ib_respond_udata(udata, cq_resp);
+		if (ret) {
 			pvrdma_destroy_cq(&cq->ibcq, udata);
-			return -EINVAL;
+			return ret;
 		}
 	}
 
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
index d31fb692fcaafb..e69eadde6c26e9 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
@@ -195,10 +195,10 @@ int pvrdma_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 	spin_unlock_irqrestore(&dev->srq_tbl_lock, flags);
 
 	/* Copy udata back. */
-	if (ib_copy_to_udata(udata, &srq_resp, sizeof(srq_resp))) {
-		dev_warn(&dev->pdev->dev, "failed to copy back udata\n");
+	ret = ib_respond_udata(udata, srq_resp);
+	if (ret) {
 		pvrdma_destroy_srq(&srq->ibsrq, udata);
-		return -EINVAL;
+		return ret;
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index c7c2b41060e526..b9c3202b9545e3 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -320,11 +320,11 @@ int pvrdma_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 
 	/* copy back to user */
 	uresp.qp_tab_size = vdev->dsr->caps.max_qp;
-	ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	ret = ib_respond_udata(udata, uresp);
 	if (ret) {
 		/* pvrdma_dealloc_ucontext() also frees the UAR */
 		pvrdma_dealloc_ucontext(&context->ibucontext);
-		return -EFAULT;
+		return ret;
 	}
 
 	return 0;
@@ -430,11 +430,10 @@ int pvrdma_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	pd_resp.pdn = resp->pd_handle;
 
 	if (udata) {
-		if (ib_copy_to_udata(udata, &pd_resp, sizeof(pd_resp))) {
-			dev_warn(&dev->pdev->dev,
-				 "failed to copy back protection domain\n");
+		ret = ib_respond_udata(udata, pd_resp);
+		if (ret) {
 			pvrdma_dealloc_pd(&pd->ibpd, udata);
-			return -EFAULT;
+			return ret;
 		}
 	}
 
diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index 30904c6ae852db..45404611c9ce56 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -372,7 +372,7 @@ int rvt_resize_cq(struct ib_cq *ibcq, unsigned int cqe, struct ib_udata *udata)
 	if (udata && udata->outlen >= sizeof(__u64)) {
 		__u64 offset = 0;
 
-		ret = ib_copy_to_udata(udata, &offset, sizeof(offset));
+		ret = ib_respond_udata(udata, offset);
 		if (ret)
 			goto bail_free;
 	}
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index b519d9d0e42913..5fdc37bd64e834 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1194,8 +1194,7 @@ int rvt_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 		if (!qp->r_rq.wq) {
 			__u64 offset = 0;
 
-			ret = ib_copy_to_udata(udata, &offset,
-					       sizeof(offset));
+			ret = ib_respond_udata(udata, offset);
 			if (ret)
 				goto bail_qpn;
 		} else {
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 1e1d262a4ae2db..b34f3d6547ffc7 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -102,7 +102,7 @@ int siw_alloc_ucontext(struct ib_ucontext *base_ctx, struct ib_udata *udata)
 		rv = -EINVAL;
 		goto err_out;
 	}
-	rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	rv = ib_respond_udata(udata, uresp);
 	if (rv)
 		goto err_out;
 
@@ -472,7 +472,7 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 			rv = -EINVAL;
 			goto err_out_xa;
 		}
-		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rv = ib_respond_udata(udata, uresp);
 		if (rv)
 			goto err_out_xa;
 	}
@@ -1205,7 +1205,7 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 			rv = -EINVAL;
 			goto err_out;
 		}
-		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rv = ib_respond_udata(udata, uresp);
 		if (rv)
 			goto err_out;
 	}
@@ -1386,7 +1386,7 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 			rv = -EINVAL;
 			goto err_out;
 		}
-		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rv = ib_respond_udata(udata, uresp);
 		if (rv)
 			goto err_out;
 	}
@@ -1646,7 +1646,7 @@ int siw_create_srq(struct ib_srq *base_srq,
 			rv = -EINVAL;
 			goto err_out;
 		}
-		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rv = ib_respond_udata(udata, uresp);
 		if (rv)
 			goto err_out;
 	}
-- 
2.43.0


