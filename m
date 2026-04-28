Return-Path: <linux-hyperv+bounces-10422-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHwnL2nk8GmoagEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10422-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:46:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F60489417
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39218305AC4F
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F06D337B81;
	Tue, 28 Apr 2026 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bNthUkAy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86244329367;
	Tue, 28 Apr 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393078; cv=fail; b=mOhNVx1InuVG7bNREAkn6dB3phuEs8VPhfATs1zBeFnr2RYrhEj0xZk+ayltgXNGpzhB3TrGRjyUan7CzC9u0ZL8wasPe65+lPuh3Aplmu82HFv7UkoRjPoTjZZpDbPI11N63s0HT+ChQK4q+RkvctWRzplMBxogOdLvlXF9SrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393078; c=relaxed/simple;
	bh=tpUQkmnwgzPgB6+9URi0B6gdxSCnWeftpRuM4ihxPZM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GqUiMM+wAP4qGT546M60KfpOZig2Z8pjjVhYbaHE3GL/595i/5pe/rysuhjgC34Pxe+U8A8UyajMu9BziHHd1i+CO82KAkZYvXO1YrluXIWT/LOksfQqbheHrqUMJDuRLxAyKOYXYwPN5LSJCJSbN5AjGMPDCfSPOoIDqIv+Tzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bNthUkAy; arc=fail smtp.client-ip=52.101.46.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yzrkbn7RJXcu9xvEvsC8t8tQ8ilhopw+8Z9pov+dZIfnKXgFYS2DLMK0tLxjrpvkgdT83QGxBJsr1Q3cjo2dKQXpjYtVmLGqup+IXCfTG+Qc+eW2bHxEODswfmniiajl2nZCsY0XHl7A1pj0eyyrx/Mb2W5oG53jAtu6pLwA9fU1AEr3gDWcNHxFdb0fUcmk+1dJc58PexXPp7fgBLmXUL7E7CMbV5HyVN+FIPEURZ3iyXKrqngAWfpwDYC8KiFCpxU4P2OREx0WtQtTzKFF6tX9KLD6PiXrlUx7TtVDkzQuyGCC0PyYRvTgbvJmVTjTHh2af5gv6OQJnCvUEmKIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugfYHsRCqIACxYKW7ODhyonvibaH8LW6j7H3xc+O2Yw=;
 b=IQQZ7jJv3Zjy1o6E3OkGPPgssdGgpdJLm3oxK6ZlPM4yPXiU+wNGHJivWvk54RxBytY13zJJh3wa49TEJ6TW025iuZF5iHty/Zb5+UGnNOlgERLQfZl9L33I191LQIOgkvZBYGNGHUo3nRnC3NYdbsdjpmNX7Lu6TdZ7IkEybFxlYSP0yqjVaVDBb7onHNNY2qJPDOIkqDkqj2HzFiy09+A6n1nkscnOui6NSImpwY5rNC0vl/f++fKLZrQHSCwyBIXxv+NMGhjKuZM1c3UHYIYiAqi7n14Jw+4IIZsj+G+yFrojAopefjf4/zMouUW43ACwwvmOM1pzif3EnDixEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugfYHsRCqIACxYKW7ODhyonvibaH8LW6j7H3xc+O2Yw=;
 b=bNthUkAyNbsi3MPpfjhKt6EZF8lSSBlV5SViIm7QDG4HDIKALhsvk4SUvBFCa1u4Y6lgeMIeGkWkOuFc/grKopJNH20Ywk2duZlr5t8qdjL5J81rwiKAEeww1H7jlIqxj/eiV/9+RNbS8QAlEghigxtAbbKvIeEfSeR2saa4rh3EZDKVO8yWeXSlJnRqidWI+GjPZm5GORC/mRlzIQaaLkBwPTA4E0tQaLw18u+DeQlZ7KMXIcgDYeS/jkE9rwqg5sAKW3QH7h4C7/7YksWiKai9gN5h+th3koQD/ZitSzhjVfaH3AIp0CiNFZ02aGD1LCeAMK3u4Bv6z9rof0vmPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 16:17:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:17:50 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Eric Dumazet <edumazet@google.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Adit Ranadive <aditr@vmware.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Andrew Boyer <andrew.boyer@amd.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Brad Spengler <brad.spengler@opensrcsec.com>,
	Bryan Tan <bryantan@vmware.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Kai Aizen <kai.aizen.dev@gmail.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Yixian Liu <liuyixian@huawei.com>,
	Long Li <longli@microsoft.com>,
	Lijun Ou <oulijun@huawei.com>,
	Parav Pandit <parav.pandit@emulex.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	stable@vger.kernel.org,
	Tariq Toukan <tariqt@mellanox.com>,
	"Wei Hu (Xavier)" <xavier.huwei@huawei.com>,
	Shaobo Xu <xushaobo2@huawei.com>,
	Nenglong Zhao <zhaonenglong@hisilicon.com>
Subject: [PATCH rc 00/15] Various bug fixes for RDMA drivers in the uapi functions
Date: Tue, 28 Apr 2026 13:17:33 -0300
Message-ID: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:208:32a::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7b2121-bf58-46a6-e678-08dea541b124
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v/KAg3ea10zpZ0FdZPUAa1Uybo+31RSSPrVatDJnN+XfNA6BkbFOl5n9NNB7k8iYQ8Jo2Lv3AnwX+zlXP8/MT0OR3BfMgMb5yqqMbsZkF5B2n2wAudUQE7NTeN23onUDdb5g5TbgjUBn9qWBmWrPZRc+1sTnVwQYtDc5cTowdH4z+hudHz/6kPui4TNvFjYj8KWnPOjGm7AZu0EhCykQWybK3wU3cHskVqGJ9LN37aZD2cp0e2k5lFGI6XDzQlPOA358Ljj1d4Dq3+f5lklDB+vZlGnwq8OZED+Qj45AvEJcScyjKRNZ2PELTjJaPOkwvU5Db1p25xKo8SX24KFiMjQ6vJzddKZjpUXfzTM/5g3SePDDvsjDvvQpI0nj2SiUNNyiat91/u09L8Z/lqIEnQ5yL+/9Y04xwvc2UZuXh9aKvzypKu0LbFAzQn5RlhgSs03+c2S0rpCBR6JprXZlycRMfMoDMOMg/XeMO7vH9uN51i/nwSiQiPWFGZlOJ5T51XKTVu5KnpnEUePXzqejauLWvO4j+72JuSN5G0v/urgATFP/vm/gZ+xdNDVLjtrvO6FQxF06AU7wA/hNby3+pI96BjrT/Iqa+8pfnOayFkMcwvecacVizbC45yBguiS56cbk9tSrTbpZmUOmfzmu4ZekTAX5ROjxz0jvpTRcsVXg82XVm3ysvwUvOlNma6/lSZ0h/C89XOmYbSLp6J/CKV4SeQ5tivLlep7usaydv2iDn48LUnfRIL55Y47KP7W6Oy+uJNgasa+y72j0Nf/RjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SGECQPO3VYCqh3ZLrnn30YItYPz5zrEvOO0+dLtfQQ6XzKc3+yYSic+GdPfH?=
 =?us-ascii?Q?GYCICA0+QLqLQC3BVjKzWSJ6+07x4PwD5IHeznpi7Zffy6txxg77iyMnMdEm?=
 =?us-ascii?Q?VO2Bjc/l7nzvb7Pq9mVZR3koZPph20E+f9rD5+QZ/S3z7GI1FfcbHqNLG4Jw?=
 =?us-ascii?Q?naDCH4KE0k8r2G6iKU9c5Y0wqtRDObAMhYu3B+QKSRdxOpihP3M3DaKJFo/M?=
 =?us-ascii?Q?n5U/3tjimnuPF/Vn/KID/bQFIWoK9VgbXp7tCD1B/o1/0Iy5KVoHZDsP6iQL?=
 =?us-ascii?Q?4tZFo/T4fNeWDzakrK2nLfdpX9HlXwU5iI5d+fpENk3Pi24V0fVOWAxVVWcR?=
 =?us-ascii?Q?DKaH3N/D3O1snV9i4gVPMn2qQq8hQ52iFkXg46+svVrkmmmCmzxoXxK4cLbg?=
 =?us-ascii?Q?/QhclgNkfYkCyzo30JrZq40Yi8yqPIiIOfRLZal389rSJvuKuSkGAB47sTKr?=
 =?us-ascii?Q?0H01vUiq9mpqlAj9baCdDUBNNq8J30766SyIp5aJJAxgaPSCl4Jd/uTEbfmZ?=
 =?us-ascii?Q?2V8o65DuZQIOdjFo1nnADFo4K8I7kXh08BxMDzHaxLbteqWBAgpnb1ApWnfq?=
 =?us-ascii?Q?cq7f1R7aF9tBherxgplX/Dcl4BnZl9goqPCbhPy2BvY/IjXCMM27mHjwH8Op?=
 =?us-ascii?Q?6XGC1gcMUseKdvA7QM9bPWSBaj3Zgxowb6E/W3e2xOYFCfVRQpLqh200U+DA?=
 =?us-ascii?Q?ApwVwCKD09nN4EIArbqI28tvXLaRUOuKRBDi9TqonkSO5942VwfNI2nCGHK0?=
 =?us-ascii?Q?O+Me6U1iJjaEb6EAM4Zu3TbG9UhozWwHHecyAB6p/TnRXl/4erYuxVgMFxEP?=
 =?us-ascii?Q?bKLvhba+2K5+V4rtJfcHtyaJ3naAg3hqK4hTIn65JetporaxW4WnPrnPjPN6?=
 =?us-ascii?Q?XuwQzGLwR/N5Fq22OjIGQmArl+xeGR2hnRyph5wdkH5jDnElo95+tAXmhhE0?=
 =?us-ascii?Q?v0Rox0hpnh4pnp36xw3mQD+TJmXGwxosBrHvtl0VSGn1NW6c/IuWvG3vkdoy?=
 =?us-ascii?Q?iLo9/OdG96qUA4mq4DCsqIlzSSOfdcTVB9Aqrzy/vY4aIffv06amy5rYM6tQ?=
 =?us-ascii?Q?xDG2THg0i3Mp++eJy8dHo/CskqXkvRdyT+3gO1e+tbGnrI7yLgv6F1rqdLso?=
 =?us-ascii?Q?gslZ20vxZ+PGOoQcNRapR62LRIkcLwRYRHcOl8lnvnulA7kNgctcNgkcbU3N?=
 =?us-ascii?Q?6Lk2fc8QeZ2HZn5FDn08DuBOsSRiK2qSxN5aiF2ICB0kCTPWGezZ1umv52ld?=
 =?us-ascii?Q?BirBsndV9T4PoNPI+pghmUJ2Cyw1kSZCUydhiJXh4FE10xAyyHUjl8hEyLIF?=
 =?us-ascii?Q?v5mtHT9rhaMM2PAU0lJU+/52hozDpCGqhv4vqgdEvj6qp3EDGzWnpxOO28xw?=
 =?us-ascii?Q?iLy5RWEhrLA19Wm7oLPKZShirSNVXqHSLr7KllxT1GhQaJ7PvmqFltZehzN2?=
 =?us-ascii?Q?138WwbogdrQ32LlQ4OtLg0tOxi68A3UDLSktTSfhmY9sdbGhEIq1ymIGPVdY?=
 =?us-ascii?Q?7m3T+i546lU/YdAxlTGAm+TRMiTo6dpNVr4DURN4qnpzpzsdf87+sQNLv1A6?=
 =?us-ascii?Q?6a6EHIPcUqxDDPCdYYCPGmGOGNcd7rse8F0ORYn8lijjLd3tBggxA8/8KpaE?=
 =?us-ascii?Q?y2NrtTdnHExu5E/AtNegrMXjh6WNDTHBya+p8U/AIOdBYjU3s+hQ78W4MZIu?=
 =?us-ascii?Q?TVa3K3amd1k/BWcdRKaBvXrKgeNS0C2MH14pR9Gpq97xqBea?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7b2121-bf58-46a6-e678-08dea541b124
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:49.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pViqiT/8kQsFr97FnEqMxCQGrBqe+HO1v7kV95d097O8GoklglnBQdN/6r/iv+Q/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
X-Rspamd-Queue-Id: 63F60489417
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10422-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid]

All were found by Sashiko or Claude AI tools. They vary in severity, but
are all things that shouldn't be present.

Jason Gunthorpe (15):
  RDMA/ionic: Fix typo in format string
  RDMA/mlx5: Restore zero-init to mlx5_ib_modify_qp() ucmd
  RDMA/mlx5: Add missing store/release for lock elision pattern
  RDMA/mana: Validate rx_hash_key_len
  RDMA/mana: Remove user triggerable WARN_ON() in
    mana_ib_create_qp_rss()
  RDMA/mana: Fix mana_destroy_wq_obj() cleanup in
    mana_ib_create_qp_rss()
  RDMA/mana: Fix error unwind in mana_ib_create_qp_rss()
  RDMA/ocrdma: Clarify the mm_head searching
  RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdma_copy_pd_uresp()
  RDMA/vmw_pvrdma: Fix double free on pvrdma_alloc_ucontext() error path
  RDMA/mlx4: Fix resource leak on error in mlx4_ib_create_srq()
  RDMA/mlx4: Fix mis-use of RCU in mlx4_srq_event()
  RDMA/hns: Fix xarray race in hns_roce_create_srq()
  RDMA/hns: Fix xarray race in hns_roce_create_qp_common()
  RDMA/hns: Fix unlocked call to hns_roce_qp_remove()

 drivers/infiniband/hw/hns/hns_roce_qp.c         | 13 ++++++++++---
 drivers/infiniband/hw/hns/hns_roce_srq.c        | 12 ++++++------
 drivers/infiniband/hw/ionic/ionic_ibdev.c       |  2 +-
 drivers/infiniband/hw/mana/cq.c                 |  5 +++--
 drivers/infiniband/hw/mana/qp.c                 | 16 ++++++++++------
 drivers/infiniband/hw/mlx4/srq.c                |  4 +++-
 drivers/infiniband/hw/mlx5/main.c               |  8 ++++----
 drivers/infiniband/hw/mlx5/qp.c                 |  2 +-
 drivers/infiniband/hw/mlx5/umr.c                |  4 ++--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  8 ++++----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  2 +-
 drivers/net/ethernet/mellanox/mlx4/srq.c        | 13 +++++++------
 12 files changed, 52 insertions(+), 37 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.43.0


