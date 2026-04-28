Return-Path: <linux-hyperv+bounces-10424-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNfcN8Do8Gn2awEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10424-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:05:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A7C489907
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B477387069C
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C53A33C1BD;
	Tue, 28 Apr 2026 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rpuvr9Ne"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B9B3382E8;
	Tue, 28 Apr 2026 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393080; cv=fail; b=nQdUQS8oeE/9GNYd2xPUuSWwSJWzlre21V6GdDAYw4piyrlpxHgNbZl/uuoqahLrd6F/BnSEVC9+I/6Tfwa8IeL4IykY338tXEGCOt4GVehAvxYtQESo2vK05DHdUw+qIy0Cp4Nb3GiDKTKrzKnXF0uZxDVWESV2SL1xIAAd8fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393080; c=relaxed/simple;
	bh=dZBcRSJl/XIKSxoZYzq3qVEo9nk/upq2rbIqwhiOjnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cfjdExJFAxtkMJyVehk91vKZ7qMnabgAWTJOve2t0JPPYjc+CHor7gYB0IEmVshNmHjo30SlIlEPb267JvA+fp0YAqBD/Sz9RCYyBUh9xBpfy4gOpRMdyWnVKb0aUdSMvxz+BYF7Aclo0WzvgulTOKu1C6t6BHaG5qF4XycEM0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rpuvr9Ne; arc=fail smtp.client-ip=52.101.46.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8bPstNScNLp2kah1+4rL12XsB9Sh5TcXOfo5IUQE86ZYldeg+WLL3Hhq06bMuvRx2rIKtJiUuUOe+JXBHFQhLYKZk/zeMR0Nrm6l3ZCadqx5bSC/Xf71sQDwa/yXxiiv+b4rlXYgv2Pr3jxNp6DYLEB0sm7TuDatTU17ZYavJIMmzdy/2iFc8RfeyUFaaSn0kWMmUa2XORriVx6B8AawaDoS+H0nvE8mfXiS998teEsuEbE13Ll+AlFMU+zyTIzxx7nfoVev8kl6c3OSf0sTmrGHzgPyKEqQdwBvGujBTh+bZ0M1XltF5Ss0IDKYQ8P7KTo5NL1bjZ9zXQqhF+aXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/9zuhX5ZCzAHRglq862C6oLBStITmDCGuSFmjjFLBU=;
 b=IipQ5AXl/WyZbno5tzwgannmtr05dxyaY3yWAQR9MxON2BueqJv+X+JeVmzoGrMtD5o1bquB08SLd7w35nw7/Ch1p79CvImFk7IIg/qlUqO3WKigHxag5EpbnEeLkQcQ66upTgZU8dSA6HFUaxL7/K6Mtl101tc9pQggJLUcCrj0nDc7okcRzfoSHkP5y1kXH30CFTkPMCpyN157ZwdYE1bWQ4e27+WSKqQ16ehnA2oS3rmAXErvs/v9i9zLhcXRmHxmAJ7F7BaaPqclPNnbAhqP2G3hV3YoEcYLn8Pxqj4QqRVTsZYvt7o4xTO+Kv7MAAJN5Ov85e1nIPG2LesOmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/9zuhX5ZCzAHRglq862C6oLBStITmDCGuSFmjjFLBU=;
 b=rpuvr9NeJh1i4I1L/GbLx18vn/B6kvsu0tL7jB7/hSd2iRMczCS6M09Ggaj/uec7iB3GvWSSnejSIwZZUx6LwPzDEl6tbeWpa/mJ6NIkY+nRJ8G8nzK6xvtXpt0zI9LroTU+G6bpgrRFsr3hH2Zo5rmKTni127URL5+cCvH+adnzU6B7kpnh4ItUVv/uUATCI/O/vD+xr27kjAtUVUboO/RtpCSCWfdWE8nq1T2qnK6jrKh8n/EGE4ULzUVwCb52XolBqJQIq0XbLDC2uj6XcMoRMdxje4YEguVxB4TcsaaDZqhwFJabj7NRDb4wIa8Vds9a/z4f+Vu5H4NvwhEdGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 16:17:51 +0000
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
Subject: [PATCH rc 02/15] RDMA/mlx5: Restore zero-init to mlx5_ib_modify_qp() ucmd
Date: Tue, 28 Apr 2026 13:17:35 -0300
Message-ID: <2-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:208:32e::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 167fec7e-dc99-4903-8128-08dea541b124
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	26R82nRL0021yr3Pju3i64HkH3qXblot7uNr0bgfucSNZnh0oP6QwKn7Rg6CuFGf36MtTzqlyJsaZep9ZDkIYAKCnIY6GdzCkm48fjKzPX3twEgu60OVnLpvR8E112xlBW7AMKz51heqn7Nouk9f62cfmcEQ+L2R0S3VKgPQtcfHgsICfY5arwdhe/6sNMSfcwM7/rSVnwpq3zOFvUBcpdZ0knROeCK2Uw5dY3o2yGpb+7jncpFngi6pWONFw0WUn/Eg9qH9A3DF04abcss7uPVktnc592b7ZALJXAdFwS9PQjMG6f6JGPgpyzffZJ5v1a2QDB2v6ql+arOuJk78msAFAVpA9oLBoUkOBhrwZz0fnE8seKMlAffiy8WqW9gf/FIgLP2VcQJvq2T6HA0z4um/XYRcuGLnz9g5yGRJX8gkpLGJ6MfVSNnkExdNWU38vM7TFUwNIL5BWBDOQfckDdy81EM2au8josHnW9Y+HCkwor7QMGavj7SSwjxuM2rXVTOEZTuT14h55VHlRRnxg38uCAADR/0VAEHIT68T831nxwN+qkhC02dVKqhsBZIa8bv2N93/9Fad0oDRi1VE+ZkAAW+IQaviXH5rUn6QvO3WrUerkZqXJMw6XaffQDHWmgCXNgYPMU30QVTARRi7FIwlw4TUcVdOt+N5g6jMJk5kILRhqqClZ1cNwe27wMY7RwpQf2oCipOwj9jQhs3z+ZylRoIYnFYhPpncpaH8OYexn1Wxj0AKKESaWXNYUXoEaZKSH9M4JRPOov0SfoJOfA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P9z902YiWtusnjvP/egsCULp6djrV+vuPWEVRfQb3O4+u5DSkO2m9/STF3k/?=
 =?us-ascii?Q?yE/O0567NV4tfSzzeJmUmqAVTpKce3ZgkeeWMDlqw76R9IzbERFuPNaBmZze?=
 =?us-ascii?Q?wL5hIjUOtjYy1kMYoUb4IwS0PHlYM5TGSZqN2y/+L+7YjgfrxnDRfeCC0Kma?=
 =?us-ascii?Q?NAUo246Z2EBiQu8B1MXuaPu6lWkPnyz/Y21ERlKS4mFUqSGzKEO3p1G0LE8Q?=
 =?us-ascii?Q?I9my7jpU4nU4uai7u8I7VW1oE4rxAJxcoGI11/a2bhXOea9sunRWoSaPU4Zp?=
 =?us-ascii?Q?mvv3QLyWATihGaGuHENo3dgp80gByz6LNuYHoEYU/Nrzd4PHCzp76C83qMva?=
 =?us-ascii?Q?xDq+aWb6qWcNw1rDmkKs9VUg5JI2JRRHGwBLhZNSqPKBh+0SU/uzywmoFzEF?=
 =?us-ascii?Q?fBW/eqXaGluZbPd6VA/FcYAbYV5Gf+twA4q8PNcVlmmp36nG4vhSxgIltjKq?=
 =?us-ascii?Q?J6WoRWaNiYDgJwCSiQhbDnR4qv8kX4EPfwskBUSPEJImrVPqqgvBwX144XdS?=
 =?us-ascii?Q?dtMjHMfSZMf7qq4js6Ogk4Qt6J25W0NdblYepAueQxbwMLHU0DzAF1ht90CS?=
 =?us-ascii?Q?up/xOQdgxpXue2oe/wm9qlgkqZmkQNXYmNN+8FPaFhqPFMcSfjB5AxPxHasH?=
 =?us-ascii?Q?meDxcRzyA0QJ84mbocdrGvF7c0aUQXsF5VIxRawjKPUeU8l2OI4AvItXNm9B?=
 =?us-ascii?Q?gzbd3lL9dzG6xrbqnb4ZZ9wAcrNDsFD5j7nCVTTt6yEvNYSb89q2AnDe8phQ?=
 =?us-ascii?Q?f5fXxzvsrxKBXvtHbrXpral6xPGzbAkY5SxUYoIPcJH3lASItfDOvdQWfDQt?=
 =?us-ascii?Q?8LhTCVlqhNpnQFqDoJhOhV7EG2T9Ud3YvXhhK0/YbXY3m0p0XUmBaPujTjvi?=
 =?us-ascii?Q?LHgFwv32smUsrue+sMbQ0N5tovQlNuztoVK+gB6OXZ1KB+GGNMQS2PHT62lv?=
 =?us-ascii?Q?NIBjdAmGWxtutxEua8mm3WJ3UddAc9nX3NIMsuZliBUpbkoTaokgsv7/kohg?=
 =?us-ascii?Q?4oA0yWwDykPnrIpmgp0K7jaiUUeqgZfDSVY8kmihRs9SI04NHNaJtrWgUI/e?=
 =?us-ascii?Q?eX4iKh3lTi6Bx+JDZxJ21pJFhDGXn8Vyp5jDljkwWZSTWFVGcJ2JQTTzN3oM?=
 =?us-ascii?Q?VjkV2f9Flg58Od5sY6LE4MGG/lw/1EI6yB33eE33jRLnpJm8gTmpDhy1mWP4?=
 =?us-ascii?Q?WPJG0PDsIXyh0CtwSiiEszrAVbSnujkRQkaGVO8F12nsCFE3NrjOQX5eszo/?=
 =?us-ascii?Q?xCeUmkFwEmjGz2ZkX/prFIDngiojlDqBpF1XokwerRTEPYj4mzZaNpPh1YQz?=
 =?us-ascii?Q?CXL3HJm7GupsX2I6/B6ITXcGgcI1tEIT0NhxFrGZerShYolsogi6CYBO2OYg?=
 =?us-ascii?Q?dSOzUK88fxv2meINcaeCpAWDQw7sQuPyq1SLAaxkYgaQlCiKH725z9h6zNtg?=
 =?us-ascii?Q?Nxp+S9q01nTdhxzQs0fycUIY8ak3dhtVpVfQPCxWGOxmELEtkPLIbhVroHh+?=
 =?us-ascii?Q?qpFtKtCblW2SLkeqVAou9KDAZrG0huOXFDb2NwfEpQhp4nNfkS5+BX4ZFOfu?=
 =?us-ascii?Q?eywtgUXAcjaJZM/Vc8Arrov935KO+NqJy13m8G7UJiMvmSK973CWMEUITaG7?=
 =?us-ascii?Q?+l0ElfGTcieTSfn7wvNPUMVG8rSmKptA3hbPEksNdA04ii3cXxz16Rer3AZQ?=
 =?us-ascii?Q?YiwFqtRrI097QyBANuv1+s82onYMOOsOaQdskNpNuocgvlL6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167fec7e-dc99-4903-8128-08dea541b124
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:50.0234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b268c4CC2UQqthG5HkwBpw/2FMmF81PizY0gXY7kFO5o3thgh6W8yrwYSzH36vy2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
X-Rspamd-Queue-Id: E9A7C489907
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10424-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]

Sashiko points out the check for inlen==0 got missed, the ={} was not
redundant, put it back.

Fixes: a9cd442a5347 ("RDMA: Remove redundant = {} for udata req structs")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 8f50e7342a7694..76d4021475f49b 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4692,7 +4692,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
 	struct mlx5_ib_modify_qp_resp resp = {};
 	struct mlx5_ib_qp *qp = to_mqp(ibqp);
-	struct mlx5_ib_modify_qp ucmd;
+	struct mlx5_ib_modify_qp ucmd = {};
 	enum ib_qp_type qp_type;
 	enum ib_qp_state cur_state, new_state;
 	int err = -EINVAL;
-- 
2.43.0


