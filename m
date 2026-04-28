Return-Path: <linux-hyperv+bounces-10426-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EJPOpHk8GmoagEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10426-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:47:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98262489444
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8D62325862B
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DD033EB1B;
	Tue, 28 Apr 2026 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FDIfk+Ie"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99D33B6DA;
	Tue, 28 Apr 2026 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393082; cv=fail; b=MUdJLB5TuU1bmzGkyaCzMvsp6VpJ6eaeSEvKQ3fBrZaP/5NijM6+WFP2CjAqH8EOWc83yxLhP3B1TN6bDHVFpxYpxu59XDhyJzHnX4Y870tPqgVvTByMRPcMEHp0nWDj0K9ABIPT5nGsXOvFvGsRx4X6PW7cE4+9fXuRecH5owI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393082; c=relaxed/simple;
	bh=s6gbFwzeHugatV/EqGZHh3qq2V/J+CyM72NLVWsxkfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rCOp3C7vOxYuqiOO1PrbeQ/bU1w6qITMGBInmLwHOPMtJU8CSumcrbZgViTyVMEqqyE4RQKCO9PlpZRi8bt+yvEYSzia/48wiRvFquzOvLODqvwB+4UmXosC/SVXrxd2R7RCSweYttkqORhLP0W+n/wLFgf+pR2KlicHehMzAd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FDIfk+Ie; arc=fail smtp.client-ip=52.101.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxqZnoiZdoNoAZBlXBn+wsun545Lkicz8OMxfahWA3hqmF2SB/oG0Kc7otlS2HVoxbK7f5B59L4kuuYnmzpla1puSPvNHQny426JsL637dZBtrO62CyMDKOBmmeI+t6N5SlXZgOBF7lPMn3dgUdDrMqFO+y7BkhBF/jwJ6PXkEpwxECJ4b0RUL0JMwKikV6U6kVHzRL4xbOOPwCMjDpFl8CxVpQjfLaHTc3tdHyoTKYXCNPig/3FjFubtUhoJPGgQwdjah532wif0rnrPH1Z//fs7/MR8D8LUglTpVrxoTW4qr6LIYxxJZNMRbH5+MNkhSnz80zokk5cWfXTBJX92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlyRNv7KuiW7iD3MWRPSSAyOIi7kUhxWafXm12Pqk5M=;
 b=gwNdWDQQa/vGqK6IDVI2MDxJBLcE6+TKDbYPFkHBkcD2YSDXn/iQx5ZWCTK/z7oavOwJMpATdkWxhcMlvi03QnociVgyW8qD9RfaZ02SazEq64hahPWKmXRfNCOTfZ6qlhuC5hN/l2PZangS20LHbPSWEvjRpDfi++H1573aWVvBhsHFHZraJtSe55fmUc6oOTAwk5mYgt5FkZhYP+0bxdVgo76aEMtdl9VM6DvTuwewJLEKfhtjD8PHrJuOuxcEISZgXnqGMnMWQI3JQnAXNJFyYKqqb0pnGNommWgWxe7CIaJ/GesuuA6ZrwCnQm3ujHaOKrhEiFz/lL6zrfRrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlyRNv7KuiW7iD3MWRPSSAyOIi7kUhxWafXm12Pqk5M=;
 b=FDIfk+IeipyaMcLxmdJGIGMQ8dUyLo+NtjDtFmuKVdj5HJzlGazt7JucbPjZ0HZB12vQ7F3DdO9tU6Z4hCmOAiCkxGmAss6skF2oJkpdm3oi1Io33SPodOKYCLbEfPPCoCFVkGcgB5RWbDbbsyoiSfbaKMfCDcG5OGOgtKDZX9oSQX7tCYt/5skNGS9jyIH0kp4tAndMh75+L3nXtUCm8If/4hu0gONGBIVBZWqrjyL29XgP/35/ZvH67OzPU00By8WMy5bItVCvLQUIFQacVdPFjEMHugi+jSOggv/5QvM8hNYcfWSjyTRn9loRl3vOp3bD/mjjBtoWFp3WhSqHfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:17:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:17:54 +0000
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
Subject: [PATCH rc 04/15] RDMA/mana: Validate rx_hash_key_len
Date: Tue, 28 Apr 2026 13:17:37 -0300
Message-ID: <4-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:208:32a::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 4272f850-cd4b-4775-9097-08dea541b214
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	Npip1SfP0hxc+Kuh4Wtom+8u2A/HZHaM4BHBU/0Lfb89UybY4FJhkQ2RYk/IvgNByWiyj4znpigpy7FY8m3gH9UsojMeB/6l+v2RGnQbdjxRLqAb2LVvuGbtp4B6OK+o67s/LLisamFBbjpvZc8bmrmQIOZp4qSSwhqsPPJUtcLXzjdgovsP23DW7AH3+XItMMnLs4eC8t2Ajf4wwLu42h3nIxYgUqYdjBcsPnmZlF8N1dqtt7oX5YeZ42+MM5y1LNWzkcTThLr/lOTT3pGFNFeXZugvKLSkrT4VW48LZcy5/KHAAXYrDUIoEdRPr8216UD/zkBzRQRi6oVRdxDrIjJ5zhqmthx4rNfWfVNEjS3t2WxRoYuvEsVgqB470tN/vsEd0x2jBs8iBMDRpZFz0YnHyAnSN4xDp8jItyIFBNXL3zf9QgHbhzilkOBPUdUlphUfO+uT6PDqNJalikSDoGT/SazjExTqM551teEPz3QB7qtRqfCjM6END3qrHVRV0fguOrdA1rKqk68FswIBsdtWuGieIeD+GkJCc4nCxT46iG9n6/WVmcCu4oIAs7yRwXTG1atfwY514QPW6iy305WoYW6HCilXTpHxB2FzRDXpOEbkYOFJxErmNpPOBmeOMzWqIPQ6Nek04P23HoqgfUIMHImWALSrcYagbAFHRxSeRmkTYFcIDNYXkx65kcvsoolz0htLKNGQj6d3gxVOo+Vb8XgZug8NHq4SgDGl6kuhQk02wD2vpRIjAJgVKCjalVMpM3fN0VM/CtbfQ8hmng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W3s2NH94z8OuJKEyD0VYV3+KyZDuuCP3yjMXvWtQmOLImmAJaI/bOncRXPBy?=
 =?us-ascii?Q?62yX53Wm2ykuJRs6APF8XscoW5JGrVbU5iRaem6UvJSNo98iblzOBtYodBBS?=
 =?us-ascii?Q?GdSt3H/YbOe+ZsCzHrWo4syRsBEA1nMMddaPhxS41yzX1XjPFD9IC9JAm7/O?=
 =?us-ascii?Q?Z7TSwDhf1hj2+7IB2Wi/4HmvKD9+7gfrjJgxOxtN3P2RCvoymfIm+G9aNy/e?=
 =?us-ascii?Q?9frp2D5xmNfMO5Wb75C3WB0bsbra2P5NFP/KNZ9+M0dVkqspUNPK16mMNCqg?=
 =?us-ascii?Q?Feh9DBCF1xoPB6O/kLiTgfIeoEswdyn6XXhQZH5NYgSRoEFTos0BHerh50LF?=
 =?us-ascii?Q?C06jx10WtGKpW7/+DN7NSamcoUdp+7fUaohGEIomJWwgiIKglj/XzDWGuWCC?=
 =?us-ascii?Q?1eOTLy0XiNhANrzmIoPMFWDBtGF1ldhFjAe8+aeXxxO48HHB5/jiSdD4xNqI?=
 =?us-ascii?Q?+XqoZMFKgs08q6xJpPYD6USUi8mMG6dk5RlDEmnx1JiPJtYZxLWjJeb2XS56?=
 =?us-ascii?Q?079mPMiKYbubrJ3OCuQHbx/0u4PwPdtQXFP5nqdiyagX7tTcTWQpAlybk/MU?=
 =?us-ascii?Q?hrgZC4/s3dtlNaVq08QDx2taTw3oX3899rJm9jIid/GhbUjl/S3Tlq0Encqb?=
 =?us-ascii?Q?WN59qxXHNnuOBIJjM8J3IqJRjPtUzLeQaTHnAec/3ef/z7Mk53yrpMzxbH6i?=
 =?us-ascii?Q?i0YJT+iOavr5J8YIJtQjXSQ5AY7mlIoQm3LR6V9RvuIKDGXbkq4PcLyYTJV+?=
 =?us-ascii?Q?MGQ9QtnuZ4iT8cIHzkGFvwRARhdQo0JKXpwWMDAydyLLMimtG95IP/7GUzYJ?=
 =?us-ascii?Q?tBZ/OrHjIS8LWgvXymF/Wf53UZ+P4SGCLHhj5iIOYia+uBa6QM/lgeh0RntX?=
 =?us-ascii?Q?mAH+49OaAZOyl75WxucCDeQa8Q3wlp23pliDikMtcacMOVpDRCssl7OCUKYP?=
 =?us-ascii?Q?dV5hAMeQXXzULFIUILuW+gqZhTrPCdETBgb3AijVA7NQCqpVCOi4IGQw5aYB?=
 =?us-ascii?Q?/ivS+W0B6Q8vNkSj2stWmt/Lxcjy0wrHLcMM6XTJOudq3bYLZsIuHQ7LaT1U?=
 =?us-ascii?Q?COptyHzZ4tuUKng8wcdWd3PN3X8E+jf3JehWk9AGfaZbruQ2MGmlTwz/BTxz?=
 =?us-ascii?Q?9AlhHzJP8c9AqSPUHSwvg4+NQVmIH3TTBxWL1uTG7xcaLo9oNwkpdJnJjyj8?=
 =?us-ascii?Q?V0hj/9bzdITbv1pcSQx+wJwPJJZvu3bho8IzMjNtEq4ueXV+RvZ1gtTbfHWW?=
 =?us-ascii?Q?zAKKHu1tZZChUr2oKaZs9WxtTNy+k9cV64IPT/mMyxD/x+fJTi1buRFUN7fP?=
 =?us-ascii?Q?AxRkFCs4dTCuLJqcfE3PGWjKXIrQZKA4qdGef/jBmk9gbvPluVPc93mz2vcN?=
 =?us-ascii?Q?DIgiLAjdyOBaSt8g8euQFsajDp2Lu4apf+219vSLQs3G0EBK+2S5clBqW0b1?=
 =?us-ascii?Q?GYGY0TUKIij4MKvqVd4R0s+eaSxaCPLf4Z+VucV1vuK8g+r9cLYmdJc0CeK9?=
 =?us-ascii?Q?07PUZWnihrDrcnSwx2y2cd6SJLC81IAg3wh4qj+alTDxvIRF5sLbJ2VZlwH4?=
 =?us-ascii?Q?Jtm9WwKEEJS4a8lI2LEBW1T5sTRRt3vdPWT0/PEF0TZcSVQD62IaPGykyZm5?=
 =?us-ascii?Q?+rMFXle958vEjHpyo+t8aRtg2UoIFS7zPp8OEZcHQKdOfzFtnAhTvghbWCGQ?=
 =?us-ascii?Q?QEl9f1l/loa1TFfMbgcOGNoYp4nlZnqBOFu7T0bq8cEt3FoA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4272f850-cd4b-4775-9097-08dea541b214
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:51.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8au1W2zmSvhLT0tevEHb6AZw6Pfe+RjZfjtBeQ42PhJcUJAmTiBB94xYMLsEffI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
X-Rspamd-Queue-Id: 98262489444
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
	TAGGED_FROM(0.00)[bounces-10426-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]

Sashiko points out that rx_hash_key_len comes from a uAPI structure and is
blindly passed to memcpy, allowing the userspace to trash kernel
memory. Bounds check it so the memcpy cannot overflow.

Cc: stable@vger.kernel.org
Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Link: https://sashiko.dev/#/patchset/0-v2-1c49eeb88c48%2B91-rdma_udata_rep_jgg%40nvidia.com?part=1
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mana/qp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 645581359cee0b..f7bb0d1f0f8034 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -21,6 +21,9 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 
 	gc = mdev_to_gc(dev);
 
+	if (rx_hash_key_len > sizeof(req->hashkey))
+		return -EINVAL;
+
 	req_buf_size = struct_size(req, indir_tab, MANA_INDIRECT_TABLE_DEF_SIZE);
 	req = kzalloc(req_buf_size, GFP_KERNEL);
 	if (!req)
-- 
2.43.0


