Return-Path: <linux-hyperv+bounces-11201-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAGQCw3IFWqMbAcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11201-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 18:19:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFE65D98B9
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 18:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A7593040DB7
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 16:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4A3B0AC6;
	Tue, 26 May 2026 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JCWN4V/p"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB127BF7C;
	Tue, 26 May 2026 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812114; cv=fail; b=gX/AjJD8Xj6s5A8AlSLwzJS2ZzThc0I0C3t2q+aLkR7mhJtQv349eMUp3wI0zkL8oQssiL+UmMv90NjjFyBtc/KKycDKFv1o+p/ZwvmpKBmsus+OK72VvVUACzXP0qQA4ooFo4NiALv0z8dzHR3y2wCSRQ8goLt3m5wkXozJ91Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812114; c=relaxed/simple;
	bh=CMJLTLxtDDcbyG5cHH6tHalOtzTG01O5N7jfAUfA8Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ikx9eeC3m7gGC9mFrAhpdJpEHIdb8C9ZQ9grjwdSzZyUbhfX1KPG06TYGDHz2FzDFe72wtTlNcqtCPRp42LN0vTa9sk9O2EFYnAneLypn69S+K++E695l+dk8pkm0zdykRZCJuMN1RNIGeEvMykXLwmyg79bPLQE+1nFN7H5ryY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JCWN4V/p; arc=fail smtp.client-ip=40.93.198.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQaKQsqJFrE4yyo49dhQt19sc7HU+v2380fw3TB69fQx9iXTdxquJuHsCApD4MKib3YS0IuiMY10XgQ2gVP185D4qmKskN9T56C/lY6DXBeGzC5XgUVdatNhpwrz8ILp1aYdBcMwwfuSe0iqQEuOq6wUfhiJ9KovW+rYxarJ6f3GfZpRDLYyMFlNG1ihDSMb308db5qxnoyrGHx6bMUwPnySBQft/EppK/Te/tmkE9Gn0wri1AGcTVYS9HT68njSTv3oMjPOA1YJ7Yu+CEebBV6Yw9YU1Ba+nLIavRdKmTC0h5jhn5rpYNo91Ya3HzwhNOqrkUUguMVEVZanbhHJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=he6ApBcCXqTcwiHP83igeVPT6TpWtcImW5+YaAqvA1Q=;
 b=nWB7Xyfj+eLvgWugEfnl1zpV6FlcMi+SvKMm1AKCXp0NiC6/adxs0Zuw7nQSRt2dAZjW15CO+ClAfkji0tqhrc9nD7rM0s+qA8CIq0jVeACwQj/YINqLgkksu4JDZRMHvjbz/G01rcXKt0RDTNuPU2lIYmzKbT65xbzNt7KtUGXr74LRnw6PkAYhxe8aorbk7DZO0Bi4MeujLqmuiZsso78vM2WM7wKlH4kllqRqlQ4fgN94uamfHTgINgLTWEijkF9risDEEQVGMHNo/+meBHkquVZqlVEnPHdBdl6NG4Nbtq2j/jSzGLODmBh61aAr3yl3HwT0b2O1vfN4QP29uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=he6ApBcCXqTcwiHP83igeVPT6TpWtcImW5+YaAqvA1Q=;
 b=JCWN4V/p0DOnSjnB8SY0TeZ1DmLXsnMqFd91Y1HPpDkYFn/f8NS5DpKMWsGMVPEk9fvgJ6x18o4u0NWOC5ZNoQPCeKI5DY5pGwrbscZZL3vmTHBqRd6Svipqu7dofNmY+jmI8VZ1B1KDKwfEbY088mXvc9A8StHSS9accOQkbqhddJgYB0GbYohkvFH6HTkSlWeKKOUiPOVT7HYrxWpgfLF7e4uNCFtr3U3FHu3PgBqGuTCKYEboXk+iEBfffUOJWnZxA+KqJaBzpQbe1o/wHfIgGKeXjWYi/KyVjcJ0Xd9y30MgX6GkT4ISjJWKtcuq9n9pR6jAPRraORqkAYp2/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 16:15:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 16:15:09 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
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
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	patches@lists.linux.dev
Subject: [PATCH 0/2] Remove stack ib_udata's
Date: Tue, 26 May 2026 13:15:04 -0300
Message-ID: <0-v1-922fa8e828ba+f7-ib_udata_stack_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: bf047053-8c55-4665-f3b0-08debb41f484
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099006|921020|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	p94B4tqzfyIkeWyYhzwLPkL9254lpgQVL63DoGCvUU4pn6Y57bzn602AUxE92NnP8pTttTvXpTFebiEhNyw/bjawqLQqiB6qvXeg6eZ8P3Z1Hu6dKabPxl5i7aQAYvgTVu06OTaLp+Lp9iHL+amdEYsklz55aNm9oA5PAq8rW45DMw2gpXjrLcYggnIJ6j0O18vgaytvZzHDSobRk8RUrppdTvkC+zGnlndmDyIRwldWuzrC52j20mjPwqrEgWQKb8DOJcvSytGBLADdYm6hEzBEtmGWEz63daH0qT+kCVn6pbA8tSrh4Bhhg2nwswrjKrt9bemca5lSB3q+JPZouvN0PfIb6yDQ4ih9WDXK5SCcJJB4xCrlYQeFoJvCxCG6SUt3WUOUsTpY7RaFBKSfbRQHTg+LwFJGD7p1oGxW1bLVcHuHRD/FYCWTKgRuI9fTEmovL6Xmmc7ojvlQYvr0SQ6iIjs5I2tWNHmzX9mISZdQigS5wBNIxhIvSaSk1huLz+lQMfu9mMXlsienVzgsxR9TfLwq9lQyzRoyLX/hg3UX/u+MxIupcARQJGAYFSigTr1i6bfbAKOHZxnDY9Q/WowA9lQhl8mnGQAAjQ2L501NSKjHVzdpf44jL9SHxbGRfpQGevEZ7SccgG3zdNtS/MrLMJIHIt7Sn4A+WZjNHa/5wTV+U3Plg1Zn8Qjz+73oymndpLMXijKKb9T9sP9hfnmrBimbwCOPq0sO284g1h4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099006)(921020)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SbOYMfKDXgyL4+i+c7t7ZgQ8bIAuBCnnqfbhaYoLLCrsyKpEbLT+hImPykx7?=
 =?us-ascii?Q?T7euDn0BaEPQ8SNpaN/zi3h15XI22togq9+TnOtacRCShvyLjOHRG8BMVn+U?=
 =?us-ascii?Q?3IwcBtUToRexjEcQyVkmYD74si7QUDolYSnF25gaHRVw60evW7/+VfoxkdgO?=
 =?us-ascii?Q?tDX0Q725qWtltmsDvfH/sAJCdlzFOfuelcRMb4nT543nhpYPkzFWbWHq+Al2?=
 =?us-ascii?Q?DmLDyBWpn02A/n3dVfu67jNAufD/xQ2l5lRJasmoEnmGGkCi1HTglNEj4ySj?=
 =?us-ascii?Q?Z/KBHX7ik25Oyx0um7AKNxoJtgekW7fIYpfQLkXXmB/ftP7iwzgJmN/98AOH?=
 =?us-ascii?Q?TisqO5ULuZvO4GwPW0WKYmuXqp+n3GbmuExATN7NFFMBBoaQtv6+UvxdpYFf?=
 =?us-ascii?Q?/sIlMK3EXGqUkcEnN/UVII2g//OLIzWlBq0yxxG3huyKPOjkfbaYoFJqXt84?=
 =?us-ascii?Q?Er9bLpmhbnjUwkZ8lAYZguWhaSdIypkn+i6x3k8bg5FtcEHBHT28/SMt4ifg?=
 =?us-ascii?Q?dm4rBEyO5lmLkiluy0zsEPAr99jQSabZOd6mQkx1o0qIAUvl8CSaw+XuGeOG?=
 =?us-ascii?Q?u+pBvmfyU6ED7n8jIFrka2NQnizsm6X5j2mJE92eUoW6XJrI4momlZR2ehrU?=
 =?us-ascii?Q?Gliq5+Dgu0+I0s6v6RzEOpUTiwmt1dyqKGIQdg+WzuN+I6T+rCIJztdgZkUG?=
 =?us-ascii?Q?DFwGrvxAZ5yIC3757xC5p92RbF/X1LVkHUTLgEUpk8icMSSNzIOMPKGgtTeC?=
 =?us-ascii?Q?aoMICs3e5+STwp0UZxL95pICZAXb6yw+DCNQ2LiP84uU/4bPp0Rmt37vbO74?=
 =?us-ascii?Q?UY4QmIHnJjUQNVaIrpeuiWmhvY30apgxQgaZNfQwOHXWSKiA1mTILfx/SYw0?=
 =?us-ascii?Q?kCahb5P7Z3rM+2H63aaLWb+cQDeye1SHQPwBWugNHFqfIcpWuUe9qk1NId0j?=
 =?us-ascii?Q?WhOPquFPJhmD/31HVqYlsS/x+3miAV8Ks/c0MrwIvk9ax0KoLT8J9a7xL7GO?=
 =?us-ascii?Q?5lzsSzTpPEhNBPzMLvpdAwBtQKsf9VONz+3J/8esj0VueBx20UF2dNRsWbeL?=
 =?us-ascii?Q?Ez3w+X7x5bR0gTh+eb1CLg4ZGDyQQ7g2d3lEdsx0zAStlHTFbtbmyUS3qbqW?=
 =?us-ascii?Q?3svkuqS1tWpNpqMWxIxmwR5Z5YwtjWIBeNFQ60+XZLdK5NDSFPNGH3gPT0jt?=
 =?us-ascii?Q?igHg8iHJGhkBETTl0+P9KMP7yMfCwDSGJf24SIpRbIt+p0Wt/qS4fl0s3Yuo?=
 =?us-ascii?Q?TaSn/vAja53cR5NEj2tw5EeM/ED6JXrdmZdNclupF6XrKRiAvzH9ZBsQSmEX?=
 =?us-ascii?Q?tSLcPVGO4xT4aw54TK+AJ0rtv/bb+yBUONXjXB9kaKNveUpUzroq7TSPjFyD?=
 =?us-ascii?Q?pBP8/gRMKJ+EJfz5eBPrRLxFNYj79T6k25bgTJ958A11QCTOj80Ii4vfgDj+?=
 =?us-ascii?Q?vxSM++lcjWIRTKuUgqfw8NZqH7Xz/NWxNzocwUxGpL+CVhssa+MaLfQRQulX?=
 =?us-ascii?Q?U5HXXuYvumzR6yPgZVZ132j3g/sllbRvqTTn59Ij9h6tztN/rOuOp4CgFyYK?=
 =?us-ascii?Q?6x4vw1MNMcPRIS1AtK42eeaxQ999vgYUSB43rKEKVWmSqXnABYe2wDPscbtB?=
 =?us-ascii?Q?WCNesfWnzHrNM9XUj1rL7ygP3SdwqMBE3DO23ZEJzKGjwdh4gKXr1/KSkgt4?=
 =?us-ascii?Q?f/SWCoFxMo2oxjJqyqUqyo4jDV7t5e9yEMoLdHomxGm4C/n2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf047053-8c55-4665-f3b0-08debb41f484
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 16:15:08.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFH98A/HJsrX66QL89sn9RrX7EA17Rz9ITyDyP/+qzhmC6LBa++DnC3lLP1W0AfP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11201-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[amd.com,broadcom.com,linux.dev,chelsio.com,linux.alibaba.com,cornelisnetworks.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,cisco.com,huawei.com,nvidia.com,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Queue-Id: 9AFE65D98B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko pointed out these are dangerous, and the create_qp() one is in
fact a bug. The query_device is just ugly old code.

Remove the stack ib_udata's from both places.

Jason Gunthorpe (2):
  RDMA/core: Don't make a dummy ib_udata on the stack in create_qp
  RDMA: Update the query_device() op

 drivers/infiniband/core/core_priv.h           |  2 +-
 drivers/infiniband/core/device.c              |  3 +--
 drivers/infiniband/core/ib_core_uverbs.c      | 12 +++++++++++
 drivers/infiniband/core/rdma_core.h           |  7 +++++++
 drivers/infiniband/core/uverbs_cmd.c          | 14 +------------
 drivers/infiniband/core/uverbs_std_types_qp.c |  3 +--
 drivers/infiniband/core/verbs.c               | 20 ++++++++++---------
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  5 ++++-
 drivers/infiniband/hw/cxgb4/provider.c        |  8 +++++---
 drivers/infiniband/hw/erdma/erdma_verbs.c     |  9 +++++++--
 drivers/infiniband/hw/hns/hns_roce_main.c     |  7 ++++++-
 drivers/infiniband/hw/ionic/ionic_ibdev.c     |  7 ++++++-
 drivers/infiniband/hw/irdma/verbs.c           |  8 +++++---
 drivers/infiniband/hw/mana/main.c             |  7 ++++++-
 drivers/infiniband/hw/mlx4/main.c             | 13 ++++++------
 drivers/infiniband/hw/mthca/mthca_provider.c  | 13 +++++++-----
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  8 +++++---
 drivers/infiniband/hw/qedr/verbs.c            |  7 ++++++-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  8 +++++---
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   |  8 +++++---
 drivers/infiniband/sw/rdmavt/vt.c             |  9 ++++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c         | 14 ++++---------
 drivers/infiniband/sw/siw/siw_verbs.c         |  8 +++++---
 23 files changed, 124 insertions(+), 76 deletions(-)


base-commit: fd9482545e37fb6b7e04b588ad2bd80a2779776c
-- 
2.43.0


