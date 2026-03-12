Return-Path: <linux-hyperv+bounces-9341-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB25HdcHsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9341-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:24:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 607C326B9E3
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64AB030313AD
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D1632AAA7;
	Thu, 12 Mar 2026 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NCbDrjqf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAD033B6EF;
	Thu, 12 Mar 2026 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275087; cv=fail; b=oDG39QLBU+nvTwTh8STXYfTxnnja++SOlE+6kQjQqFRTigWUV6gFq1q14DJx/QsDy9JbCLf4rIkY3ViLDANbpMXdQHU91fiJjWIO5rmWVcPeDSiuP30WooJJ6+TNa21PCyFPa+Az1wbVcEXQzno94ZGErgndLEaX7uR9BaRaKR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275087; c=relaxed/simple;
	bh=QMJBhuM6mkp34x4SFO8PTgix829+nJ2nA9Jrkm5XzEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V+gyh6VIk7fpiuEMh0c6UpjbAfX5eGw7EcQgHuzdCMFKk1RiiUKh5jyunYgHV1B8lmMeIlJAajXlwGZR4oaj1wkqDD1NKWySFVkh9K5pxCAQTegIlef2SXVpGXyREJFq9xz+Kbg/OcfcB3Y+6ICZ50knfM72fD5hQ/HkfROWoT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NCbDrjqf; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0lBfLYRasq9qhmBM76UdAV/+0wSueebSjCdf9i9fdK44/yqwkdsfM5lvM48wXppNCDmPl8Qo3GKsj2JlTzn+HGJmePI6/DHSODHi1n1XZxGcqrvSR/ao9wGVq8Zf6Uv1YciS0hEgBLtu1y5UbIkEeMmisX9b5hAEmdgVn9Krt9v3NapDdkJEeM4YPuiSSEsmkEFWvTVGLtGIF1C1n/MAsJT8vy68nAemYytazdOyBMciYw0aWABWKLIcxAqfiaZ+aywNUxnR5O+hSqzLlKyFivY3Y1JKOAb0hTmkxA88N/XlZFEm4S/PIJPq7k25GnHlAaArqFnlw3h5wJN5HR0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1GPij6KCN+sNkf0WMiJM2OwbtSarBjwjfJxfDcFxSg=;
 b=dHeHamPVCpm5+dZ/q4VqqcVCK3L1PtFGyax9wpp9H4UGQRatXLRfImWvGF6UO+iPvUMVAZ5xSM7KhC+adcX3uXa326aHHzBriS4fEB/G2n97qeEh/VkZYsF0f/KwDSWA7IeB1TTolcfESlvi0Ue92bkMMoEoaphACXV0w8dbepIAFQh5VE5diJD1n6BTnhGBq+Odzbyd+DtTtVQH72Jo8DtIzeBiWvRFgDt2Utp2qVngebBKBxWK8OJiK3SjgYBMGzcpTD9+MXZUN0rHl4bRmM6VyhN4T8I95pN5A5Tigq4WbLexHko82qFItD3XLVDPHKsx/ZSlBkRV0uQzGjvovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1GPij6KCN+sNkf0WMiJM2OwbtSarBjwjfJxfDcFxSg=;
 b=NCbDrjqfTZO8bbfpctV5FewUZAhnGi9lPlQP1LzYNqb1RwbmFVli3FiQ8863kKXvmexcz5j4ubEHT5ljZNEfhlk63cq8tQkF37aCZbmQHQIjdh1En7CeBN5veG/fGIbPr7R1jnP2wFWHyn7RFRrxthOyMNpfhUqgzhRaLnFs/gNVbaVRlphL/JcTzmRS3o78AuQpN3prbIabcumuBNaUbCH5ZG3X2EQunnQcG7VBRaYw1zR2L7yIrAcl3rzZ6HfyL1DS3Cl6Q7sesYWaprLdOBEVJgS6x8OMFD7NzKdoGY4GQ+uTqzgbnhy0pRiu99JGUP6D7wYAKAEKr38iE7eRhA==
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
 00:24:29 +0000
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
Subject: [PATCH 04/16] RDMA: Use ib_copy_validate_udata_in() for implicit full structs
Date: Wed, 11 Mar 2026 21:24:11 -0300
Message-ID: <4-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:208:335::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb5efe8-0a68-4a7f-40b6-08de7fcdb756
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C7EBn7ockBZ6FJIrMADiI/dNPJYIcRXXO6GZ5Spl9qHwdeI2AEnbA87JsiE61UyH5rsU7dGmaCZc0IW56ln47Ym5CQB8pgOPplCDP90CoAmcrgAty1fACW6apHPvaK2bdk43gADdBYZPrblrRwPshGaJ2mDJ/pcfV78kgV90VgY0TGBrCac4SODI0YFoVKZzOqE0tXO7C+XXiErCtROdWjJ8H733pFtJtj519XkdMEZp4JFXMcgKhtGZ/ixK7bc9OwxMn373ygA4/XywNXvB/XD2d+YyCbxlfh8AhzcGuMGJ0TysZfh92GfIwEX7GDqKfupMrZXbMBNkRzK93Qb1+AqLMUR87Lw9HnkwGd+xWmmvzi8hKD3qW385vpJpopYy0/tMQb0RQSW+ZkWcRnsVdmYhyhc/fRfI2foyvgSv1WROTo6js6PRCGXVRGTs8SFZ4jkQbEv0F8Ibvfhp7WtbJrTyxnbI4WtTQSUL9xGWr0yzcGX3NnltN8NLpYUly8A+qWjfYHZNuUvPx0rA7qse+2SHjUlXgKQkL+sJBQELp1MhQR6kVcaVcrP8/320DQCWn0GkFsHJ1puAaBNUmKLFyEioMWetELg3LDR72DEP5Wf/8A3QNqF+FBBFtdFQbkK9ssTJnSHDXVBFem96Ax2O5HT+U3AXPBtCKudoDm8d7SsORWhLfyy/vRq2RoDT5bnh1wMM2cqBn08SAa7zqd61zl4D4NCkV0gFpZgQwOQi2/BRJcdJu0kHjh4h4y1f9OfUzW6VmJXphUkqyNKdUzAoVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PBPSgIVGKbjVKvpd0d/NboF9aIwy3l5QRDyObwbya/xJgK8Pxpb+aHJfYq22?=
 =?us-ascii?Q?tfY8i6Ll0Jrk2rOCuVMOH+G+gAmdFd9wZC6uB55JC1EuBgKqFEsfxObgUBL5?=
 =?us-ascii?Q?hpxagsAelkcEyiZZppk2cQL1Uu8RP+uBzvmSKztAS3astw+xUQRfwqgjDdOi?=
 =?us-ascii?Q?uYwb8K4dSZlpXldtyr5aIUXPfXPm6mS/F8eTP+A3Wb9AtnjuENNgG3vwjco7?=
 =?us-ascii?Q?IQqAo/kaCyFLriI09z6FthUzUEhDto4NBmW1dW2mNfi7vvwkLdyKkyIhOi7C?=
 =?us-ascii?Q?nVjcw0l3pKGBK9D4n81k9fSLpQjaMlHIZuCm4gZ5vnEl654YSjprzNwIV+ZQ?=
 =?us-ascii?Q?eDQZB6AZD7lpIbnAV75dL3uc8F98pERpOxbzCBJP1m1NoC0m10G9aR6bNK42?=
 =?us-ascii?Q?WpnmfaXw5Eaytow0NQzOyywlHCJyYYSYtKea/xPcvvIF/bj9za3kmMcTfu/r?=
 =?us-ascii?Q?Th9vVHXPtIinRxiQqwe4X2C4rjgW0k7TWw2P+6ED6O+tf/z7zRPW6tZ7uG96?=
 =?us-ascii?Q?sZfLVjwiI812cVB5vLQPBJjASIsq4/QnJ1146Iz0j8iWWIOPVNkXZezmhY+r?=
 =?us-ascii?Q?3yqxZcGx90pkBSDOYUmXrcz0c+UDzjfWYtm14V/fU2XddYNVAP+ryIuRt533?=
 =?us-ascii?Q?9Hwzj3d6rcJtvcJ4bwBcq2+zX1eJ/DK61AD2C8DONksz3nFgysXrz++YbKdg?=
 =?us-ascii?Q?85pmIWI4dUfkCxb1SGXqLwyeON4V3fT/f+DK5qfUpLpBX/bgCWgjFOE6g5WS?=
 =?us-ascii?Q?3WF7PF09HpljAhjHzb1Umj4V+1dswholE1BfJfZi5DjFLU0xP23cKN/ii3YR?=
 =?us-ascii?Q?FyF4T4TNS+Xcwii2yeqoFu4qcyxxMbdmiHbb/DIQwdJzRZgGL/lBVKMNoMNn?=
 =?us-ascii?Q?KSSpT5XEWTbZCe3HgmTaAp4faPJqm9wGqkm9IMrIN+YhN6mOVVTH0o8y1UIV?=
 =?us-ascii?Q?40eEhoLPgXmMHQl/q2O0KXH+hkatKg5MuBjhFHikLaqWj7qpBYDFO7igLJrx?=
 =?us-ascii?Q?niR5qz3OmyCdn9BC2I50DVdRAxRooat+obeua22zco/KjcoWvsDDFe7DXV3N?=
 =?us-ascii?Q?y/SX8iYaQo0K6FrofM99U3Sk28hHMl9Uto3Kzi3JfH1kgF3bkYotjK9l7y2P?=
 =?us-ascii?Q?jYEJWD18lwZQVg3xr1ct9ZQ8XDLGKoveKC8ofDBFQxcF4xl0n5FweMOGlhBM?=
 =?us-ascii?Q?8OkLG2vraRhYpGZ8trHc/s7aRCuVoGKxQHxN6LXK7iM2OoWTmTYnKl5Fmvdg?=
 =?us-ascii?Q?N0hCIni6p2VVktI9oN7mNw17Jc+VqwnHtlvk91m/LGmvWAAqvYjis50ml0oz?=
 =?us-ascii?Q?W7kFeLhzZ0Ha72ovo90hoDFh4iEuQG0m4xEjM5gwpGzYdu1TLfaQVHPJjAGS?=
 =?us-ascii?Q?FlKCGQS5ROCD3GJZ2ouNDff/7IRA2zm1wwkcZMwpwNLLIIs0Q+yf9LPkhS4f?=
 =?us-ascii?Q?GdCllwfxwmO/X1k9e5d+km5QdMOoOkLoWy9JUpP0rVHNU6dUjk72Z81NY7gP?=
 =?us-ascii?Q?3iLrAWIicGHyIcEwkTkBHRPUJ2jdtcZDhBvE2CMhc21ZgUis/ebMUtZ8IIbi?=
 =?us-ascii?Q?IyQSC2nuALQdtdbdtbXn7/AJHVbul0sIhf1C55ijdjiFNbiTPSgZrWLKdZkk?=
 =?us-ascii?Q?Xvppa9vUPuFFppTNrkpI624P2NRbemax3vuoY8SaQJmzEXfT9WS7hdI3e0IE?=
 =?us-ascii?Q?rD7LLbWFuSLNhFAJjwf2uauRKcMgkN3HV4FBAf384fnFt8cB8zp6d4p56JdH?=
 =?us-ascii?Q?c2MTepFIwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb5efe8-0a68-4a7f-40b6-08de7fcdb756
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:25.7068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HJ9BL9wcCGDXGlMXsTwr1luBbjz77Zc2Q+335AKTddKmHLLxavPQUzblgob0Tw3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9341-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 607C326B9E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All of these cases have git blames that say the entire current struct
was introduced at once, so the last member is the right choice.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c     |  6 ++--
 .../infiniband/hw/ionic/ionic_controlpath.c   |  6 ++--
 drivers/infiniband/hw/mthca/mthca_provider.c  | 27 +++++++++------
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 10 +++---
 drivers/infiniband/hw/qedr/verbs.c            | 34 ++++++-------------
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |  6 ++--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  6 ++--
 8 files changed, 45 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 04136a0281aa4c..5523b4e151e1ff 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1039,8 +1039,7 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	qp->attrs.rq_size = roundup_pow_of_two(attrs->cap.max_recv_wr);
 
 	if (uctx) {
-		ret = ib_copy_from_udata(&ureq, udata,
-					 min(sizeof(ureq), udata->inlen));
+		ret = ib_copy_validate_udata_in(udata, ureq, rsvd0);
 		if (ret)
 			goto err_out_xa;
 
@@ -1980,8 +1979,7 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		struct erdma_ureq_create_cq ureq;
 		struct erdma_uresp_create_cq uresp;
 
-		ret = ib_copy_from_udata(&ureq, udata,
-					 min(udata->inlen, sizeof(ureq)));
+		ret = ib_copy_validate_udata_in(udata, ureq, rsvd0);
 		if (ret)
 			goto err_out_xa;
 
diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 4842931f5316ee..cbdb0ea7782a49 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -373,7 +373,7 @@ int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 	phys_addr_t db_phys = 0;
 	int rc;
 
-	rc = ib_copy_from_udata(&req, udata, sizeof(req));
+	rc = ib_copy_validate_udata_in(udata, req, rsvd);
 	if (rc)
 		return rc;
 
@@ -1223,7 +1223,7 @@ int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	int udma_idx = 0, rc;
 
 	if (udata) {
-		rc = ib_copy_from_udata(&req, udata, sizeof(req));
+		rc = ib_copy_validate_udata_in(udata, req, rsvd);
 		if (rc)
 			return rc;
 	}
@@ -2152,7 +2152,7 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 	int rc;
 
 	if (udata) {
-		rc = ib_copy_from_udata(&req, udata, sizeof(req));
+		rc = ib_copy_validate_udata_in(udata, req, rsvd);
 		if (rc)
 			return rc;
 	} else {
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 6a0795332616dc..7467e3dff7ebb8 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -402,8 +402,9 @@ static int mthca_create_srq(struct ib_srq *ibsrq,
 		return -EOPNOTSUPP;
 
 	if (udata) {
-		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
-			return -EFAULT;
+		err = ib_copy_validate_udata_in(udata, ucmd, db_page);
+		if (err)
+			return err;
 
 		err = mthca_map_user_db(to_mdev(ibsrq->device), &context->uar,
 					context->db_tab, ucmd.db_index,
@@ -472,8 +473,9 @@ static int mthca_create_qp(struct ib_qp *ibqp,
 	case IB_QPT_UD:
 	{
 		if (udata) {
-			if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
-				return -EFAULT;
+			err = ib_copy_validate_udata_in(udata, ucmd, rq_db_index);
+			if (err)
+				return err;
 
 			err = mthca_map_user_db(dev, &context->uar,
 						context->db_tab,
@@ -594,8 +596,9 @@ static int mthca_create_cq(struct ib_cq *ibcq,
 		return -EINVAL;
 
 	if (udata) {
-		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
-			return -EFAULT;
+		err = ib_copy_validate_udata_in(udata, ucmd, set_db_index);
+		if (err)
+			return err;
 
 		err = mthca_map_user_db(to_mdev(ibdev), &context->uar,
 					context->db_tab, ucmd.set_db_index,
@@ -720,10 +723,9 @@ static int mthca_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *uda
 			goto out;
 		lkey = cq->resize_buf->buf.mr.ibmr.lkey;
 	} else {
-		if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd)) {
-			ret = -EFAULT;
+		ret = ib_copy_validate_udata_in(udata, ucmd, reserved);
+		if (ret)
 			goto out;
-		}
 		lkey = ucmd.lkey;
 	}
 
@@ -851,8 +853,11 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		}
 		++context->reg_mr_warned;
 		ucmd.mr_attrs = 0;
-	} else if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd))
-		return ERR_PTR(-EFAULT);
+	} else {
+		err = ib_copy_validate_udata_in(udata, ucmd, reserved);
+		if (err)
+			return ERR_PTR(err);
+	}
 
 	mr = kmalloc_obj(*mr);
 	if (!mr)
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 7383b67e172312..8b285fcc638701 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -983,8 +983,9 @@ int ocrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		return -EOPNOTSUPP;
 
 	if (udata) {
-		if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
-			return -EFAULT;
+		status = ib_copy_validate_udata_in(udata, ureq, rsvd);
+		if (status)
+			return status;
 	} else
 		ureq.dpp_cq = 0;
 
@@ -1312,8 +1313,9 @@ int ocrdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 
 	memset(&ureq, 0, sizeof(ureq));
 	if (udata) {
-		if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
-			return -EFAULT;
+		status = ib_copy_validate_udata_in(udata, ureq, rsvd1);
+		if (status)
+			return status;
 	}
 	ocrdma_set_qp_init_params(qp, pd, attrs);
 	if (udata == NULL)
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 2fa9e07710d31f..42d20b35ff3fe0 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -273,12 +273,9 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 		return -EFAULT;
 
 	if (udata->inlen) {
-		rc = ib_copy_from_udata(&ureq, udata,
-					min(sizeof(ureq), udata->inlen));
-		if (rc) {
-			DP_ERR(dev, "Problem copying data from user space\n");
-			return -EFAULT;
-		}
+		rc = ib_copy_validate_udata_in(udata, ureq, reserved);
+		if (rc)
+			return rc;
 		ctx->edpm_mode = !!(ureq.context_flags &
 				    QEDR_ALLOC_UCTX_EDPM_MODE);
 		ctx->db_rec = !!(ureq.context_flags & QEDR_ALLOC_UCTX_DB_REC);
@@ -949,12 +946,9 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	db_offset = DB_ADDR_SHIFT(DQ_PWM_OFFSET_UCM_RDMA_CQ_CONS_32BIT);
 
 	if (udata) {
-		if (ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
-							 udata->inlen))) {
-			DP_ERR(dev,
-			       "create cq: problem copying data from user space\n");
-			goto err0;
-		}
+		rc = ib_copy_validate_udata_in(udata, ureq, len);
+		if (rc)
+			return rc;
 
 		if (!ureq.len) {
 			DP_ERR(dev,
@@ -1575,12 +1569,9 @@ int qedr_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 	hw_srq->max_sges = init_attr->attr.max_sge;
 
 	if (udata) {
-		if (ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
-							 udata->inlen))) {
-			DP_ERR(dev,
-			       "create srq: problem copying data from user space\n");
-			goto err0;
-		}
+		rc = ib_copy_validate_udata_in(udata, ureq, srq_len);
+		if (rc)
+			return rc;
 
 		rc = qedr_init_srq_user_params(udata, srq, &ureq, 0);
 		if (rc)
@@ -1860,12 +1851,9 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 	}
 
 	if (udata) {
-		rc = ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
-					udata->inlen));
-		if (rc) {
-			DP_ERR(dev, "Problem copying data from user space\n");
+		rc = ib_copy_validate_udata_in(udata, ureq, rq_len);
+		if (rc)
 			return rc;
-		}
 	}
 
 	if (qedr_qp_has_sq(qp)) {
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 16b269128f52d3..615de9c4209bf1 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -476,7 +476,7 @@ int usnic_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	if (init_attr->create_flags)
 		return -EOPNOTSUPP;
 
-	err = ib_copy_from_udata(&cmd, udata, sizeof(cmd));
+	err = ib_copy_validate_udata_in(udata, cmd, spec);
 	if (err) {
 		usnic_err("%s: cannot copy udata for create_qp\n",
 			  dev_name(&us_ibdev->ib_dev.dev));
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
index 98b2a0090bf2a1..16aab967a20308 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -49,6 +49,7 @@
 #include <rdma/ib_addr.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/uverbs_ioctl.h>
 
 #include "pvrdma.h"
 
@@ -252,10 +253,9 @@ int pvrdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 			dev_dbg(&dev->pdev->dev,
 				"create queuepair from user space\n");
 
-			if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
-				ret = -EFAULT;
+			ret = ib_copy_validate_udata_in(udata, ucmd, qp_addr);
+			if (ret)
 				goto err_qp;
-			}
 
 			/* Userspace supports qpn and qp handles? */
 			if (dev->dsr_version >= PVRDMA_QPHANDLE_VERSION &&
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
index bdc2703532c6cc..d31fb692fcaafb 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
@@ -49,6 +49,7 @@
 #include <rdma/ib_addr.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/uverbs_ioctl.h>
 
 #include "pvrdma.h"
 
@@ -141,10 +142,9 @@ int pvrdma_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 	dev_dbg(&dev->pdev->dev,
 		"create shared receive queue from user space\n");
 
-	if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
-		ret = -EFAULT;
+	ret = ib_copy_validate_udata_in(udata, ucmd, reserved);
+	if (ret)
 		goto err_srq;
-	}
 
 	srq->umem = ib_umem_get(ibsrq->device, ucmd.buf_addr, ucmd.buf_size, 0);
 	if (IS_ERR(srq->umem)) {
-- 
2.43.0


