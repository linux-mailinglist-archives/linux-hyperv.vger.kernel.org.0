Return-Path: <linux-hyperv+bounces-9789-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJgfC1VTxGljyAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9789-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F80632C710
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3DF53014F68
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C749A38F64E;
	Wed, 25 Mar 2026 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nnZL4Vhd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E350839021B;
	Wed, 25 Mar 2026 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474046; cv=fail; b=en0M+84o6FRtDmjRBj96myT9UUGiEbpv36N3qq+Ms2BHcanKDCYKY7pwh0giaEDa2ojS+eTEpd8TOzFdfU/2MUkzzdXBeMM8oN8bX35mZM5QjM1Ahf3LrkgqbfRWpalj/oWOWtQPKJ71lyUUPCWczcpdy1gw+yxrAra7RFyT/LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474046; c=relaxed/simple;
	bh=6fxNcDixwt/IzQRkQQsGP5ye0d1nVxyd3T+mvEj1Vvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FBKyTgkcAPE9/TGkiL5nIy14t4ZXigg1qBtY36bUuLhvw6kB9AzVMtvODEFnCn2Ac/QWUdhQSTydpPdwtYT3ErfncUUgJrn5Kn4su4YwivTROXncJGaVTklYTjYSxcqs6aRnAfSTFylT9iw3C4gxex0RYWc68F0udXQVoBwMMeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nnZL4Vhd; arc=fail smtp.client-ip=52.101.193.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcansSvvzVmsyqPSXWwWwFcP/E2KnKEg37ZuG6d6lzKxXaoTxoMwdbFRejQjM+6J89SZHyUcp8H+N2hLy+Ahnmd9489Bhtq1w56fNoY6JTx9+RCwomoYBJOPEADJtfqFWyeXDQk6NFpCt/LC9Ocq4Pf3vdXRhv5tPxBAFkisT7+j1IkEbNsimP31JTaPKCNOWf85ZNhRf9L53qWQEi8RXFbrnAXyFMy8tgMjCyGPpPXn5p/IKj/CvgmtdSSRJe/JpdsW72sDHbC7Z4D+OlTuGfiMw/lpxd3jKazk2fZ7QpxCtlzHSmMogCr1MajAdt0j65AVMEm7llpOI69NfmRohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iy3omertMQFd+V9AAPUeOFV/AxZccwq1KPGvq4/3rPM=;
 b=npCIXOOZWEUpCFgp0tk2KJOh7oVg6tmeo+KGM0w5d27pt0njXQ3ZjqQaewYPbfFlHdBwWcNwmFCNrWAdqDMQmGghzQvIMJrmG6uONpt+gZaaoTgODvAFsuw6cqEqN3uwmmtsbbZQRBWzznY51r8NOdYvNkJe84mx9B1xLrd+HsJZUh9Y7w5/8/oxLmK8+vx8mifiK6C0V/xTz9NDFBY3KoMGK/Ai9WTfCjXX4/Q+UXQUbEp4SC1+ch1rEXUl6kOJ0C4LPjk87b1LT7ouC10g0ZFO6ETPHG1zCxGohQib9K+aI04rmbE84rLEGWs85zXvDxA2Qg2xPYNOb0/QeC8n1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iy3omertMQFd+V9AAPUeOFV/AxZccwq1KPGvq4/3rPM=;
 b=nnZL4VhdcZRi7Rc0/oAJBnEAvBDh2/H4Ln0APmSaDG0tBOsYpr8rjEO+ymgm1bxmpm2mpzLEo1ZErZPJvXaMwR5rTm3z5U7wXBMnmt5LnUTTgjW1f5EL7H+fGhu99h/G+j2lU6U+Yl6Yz0Y9UnB3dy4+8FrHTvA1TWvbN4Dz0PsZPZpzd8s6pU88xCfPvbrvPy6WRLMRVH9HLXbajGZBpDAn/m/tTgADE8hT3Vzme1RhMr9Jsr9XN8v2q6F2GNchjZlEStdzyTd257mXk1L2WvzYazPzWo6wfqUpSr4kqih1RYVugIVyn6Z58+UW/J+3OQnS/0Q/jma6HsccIb9P8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:27:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:08 +0000
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
Cc: Long Li <longli@microsoft.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 15/16] RDMA: Remove redundant = {} for udata req structs
Date: Wed, 25 Mar 2026 18:27:01 -0300
Message-ID: <15-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0421.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: ba485cbc-d91c-467c-5e85-08de8ab542ef
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	sgtq0VaSxrHaSZ73yMBK+jlHaVPEwLz4vrBKNEBpNmEqng2F8QV2UY5d8jP3cFjGQ82vf3nWvAQnzZ8wAbbTz5XEhGyRJ2wNX1Nadx40cqnLjrPeKHKgjYeNPLufsw721gMGCg4TQBiVuebbhE3C0zRfqB7myGxgwQuTWW710aNDuFoak55ajqWtJFnyyw10aL+WmDPLhNhgXHx+XTiP0Kzi461csVi0yT2Ahh7lP4mnFzR4xH1wEmxRsGed0FwKe2HlTAz0gC0gczVrG5RyTTn3a1QnF/Mqcmwza8Dssdd+PhDZOVuzS3kc8h1l2Q/iryfseS0pbncmu4zUrbSwrSRDcENmk/OsNm+zWFsM0f5TlNRfU+AncKMRGRAUY2TzYxeZDHEC7Q6oMf+hv74khSRzq5WKphP6ph1476IXCYbZiMxGjKhSlkH+uvsSoRBalcup/qHTuKeaJPN9GhaOdhXNNtqBu9CgcWeP/Ip0OXBEjM7dQhV0I8DGvMqWROI6Yra52tE8YC368bQZYwxHK/fQfl6Cp8MXJ7UQ/HBo1tBhHOygSCGeokloYijh0eGqIKNQwoC6CgOLawEoRs7gqdK9x39fJJ2kPPVG+Ez8hnSWONn+P1kqT3u6xZOSV2nlYrPWvf9Z2A4fW5Cs1R65AitpZBqBizPpGJ7Uo9iSmxgabxrctH/wm5NUPOJ/jIp+pHuOha9iy6R4I8pYHQosJv5IpEGWDdp5vlgl0oWyPBnIaAWQt39A1uWkAxLAmoJN6/tey4L0NffJwks42WqOXg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Iw6qYxhKo+83PP9KDhFQichQQ9+uRs6ed+xbCaw3PJXtJ9ovVlfQz0iXZFR?=
 =?us-ascii?Q?RmUZ628K4u4hfO4vg4Jx6kwe1wjbu9alKx2lPVAW3gWRNKPygysvx397traE?=
 =?us-ascii?Q?u7595YLmuZ5joUV0/KewtwF7YbGapYNBsKeR5iTvj9uq9ZpI+2Z8+6757CMM?=
 =?us-ascii?Q?+XlFsndeF8mXjbYd0IxKSRi5onXKhcuCeems1rq3bP84gWjCeUsPh7tnXNUq?=
 =?us-ascii?Q?t3QPocFkNUxOip1CM767RkaeESr50508a6z7R/QQX/v2U7EgIYVmOLt96b7Z?=
 =?us-ascii?Q?gRq7i/+aUA11QxURYdxrxOjilRM6mLcx6o1YA/0he3mVPPtswLPPMEatVFUV?=
 =?us-ascii?Q?KfD+l8G8D45mEVsTawNsX3xQo2vSeVAewPeyfaGDQv9udZbtwORY3Xls4wRM?=
 =?us-ascii?Q?z2ouufdw7/Vu6iqFV5+/Fg3ah88L02ew3TQ5C2VK+9A8k/cHFkNutvr+d4xG?=
 =?us-ascii?Q?gcNGo1qbVOqh+lWTNFxzewvHRoFzW/P/1BojBlY9sEfTcY84uRc0SbeRRELx?=
 =?us-ascii?Q?o9ktssR97fCnYB9qOiNgGNP+TPMFVda09UnuDOn2ayTLhFLqqiZvk9N3s5F9?=
 =?us-ascii?Q?Iyc3RezDtGxQCBNwhujLQjroEZWR2WHvMJkfg6GKdAyGt6kH3kKKcqlm7SFw?=
 =?us-ascii?Q?NyxDm4SUWY/Dm4eTHVdGzZmqLUpd7vaTjOB7WKw7u+x/fNi971fPTXIZbJbP?=
 =?us-ascii?Q?ctyO1+T8Y27B2ZSknWwhAMp/wZJx51b8GbK8rreRBLhw3FDNG0KDqZTnVexs?=
 =?us-ascii?Q?+Mf1T7Pfns66ymILyD5KZ8RPlfyJlvLxUWVogbqbZseauidE79Am6wvvcGVF?=
 =?us-ascii?Q?cxoD9P7ELIcS0rODVQU3t/77zkXhbigeKVikZSG58CQYWFzO7jYHfNdXcn9U?=
 =?us-ascii?Q?113lYixJve+o15WTncXoinli+ZDfPkeMBRkYg8ymVXxBRkiupfGEyKkeVBo1?=
 =?us-ascii?Q?oxsKxGzdUd49luMwAAW7QybAlSHRizh0Epx7g44FAsDAvu8bV3Kb4ptE/zcG?=
 =?us-ascii?Q?PIAYBut9N3Rx8Ryer+vgMyywW1MZrnako78CZEHYA6a2IaPvD47eiQStVqUY?=
 =?us-ascii?Q?YR3IJnuASHThh0CMT4w/63bGkzr/RFWsYPVbVesSE1pTMm9VklD/pQe1daDD?=
 =?us-ascii?Q?rZPm6tqbm1/pYKLACnBFtD45yTBBBQ7I6k0j9qMuq3qH0H522kK2uoVxD33w?=
 =?us-ascii?Q?zaoa42KKqXS8g4vn5uJQA3a6eFrHlmVCqJFUs6vVPyLW3N4p8LIM8JwvebDP?=
 =?us-ascii?Q?Ro3nS3kGx/qIEx63Z28BFPEynS1j+3jDzKOgUhe6X9GYZPENcHu0sA/rQrEA?=
 =?us-ascii?Q?9DKNHrgpd8ApoKkPW/eAzBqe5ZO73QEV9PLvDXKo+p5CdCSzdCQS0jcIfQiw?=
 =?us-ascii?Q?W3Dvs6IlOFPDzQ8+leubMPDx5XHR2DtRp7YVUaUMOAfR9msTJXilDAFy+8Vn?=
 =?us-ascii?Q?RG9obWIAdsEob3ET1jerBAgOsfLqThAkqnTMl9INDPNsVBbV3Q4wfU738iCE?=
 =?us-ascii?Q?8NlRkvWY3mK9kv2cBD4PAXP8YJOKME7pOtoiRSVJ5mjb0qlq5uavlZgVcgww?=
 =?us-ascii?Q?+a49PsVRB4rY0bpezhfxgH5z6wjRmBzGj6yGYg+8dvnQ1POhjX6e8XTBj/Ox?=
 =?us-ascii?Q?osAKk/konViDVJyI3+8giSZ0jpWx55gHnnz46ohc4/A3DQGtteaLICA1fcky?=
 =?us-ascii?Q?atxAAfRgxkrkz2II/uxHkbsLCmnaKkv/1vutlSc2efmI0Q4j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba485cbc-d91c-467c-5e85-08de8ab542ef
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:05.2570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlcPIBt/CpUyVYF/dq0EG5aCAMHiOOUcFkWLg0EvwDLWjhHkueG253mV2tusDJCq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9789-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 6F80632C710
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all of the udata request structs are loaded with the helpers
the callers should not pre-zero them. The helpers all guarantee that
the entire struct is filled with something.

Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c       | 4 ++--
 drivers/infiniband/hw/hns/hns_roce_main.c   | 2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 2 +-
 drivers/infiniband/hw/mana/cq.c             | 2 +-
 drivers/infiniband/hw/mana/qp.c             | 2 +-
 drivers/infiniband/hw/mana/wq.c             | 2 +-
 drivers/infiniband/hw/mlx4/qp.c             | 4 ++--
 drivers/infiniband/hw/mlx5/cq.c             | 2 +-
 drivers/infiniband/hw/mlx5/main.c           | 2 +-
 drivers/infiniband/hw/mlx5/qp.c             | 4 ++--
 drivers/infiniband/hw/mlx5/srq.c            | 2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 4 +++-
 drivers/infiniband/hw/qedr/verbs.c          | 8 ++++----
 13 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 064d5136ba405d..69a8f373262c6b 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -682,7 +682,7 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	struct efa_com_create_qp_result create_qp_resp;
 	struct efa_dev *dev = to_edev(ibqp->device);
 	struct efa_ibv_create_qp_resp resp = {};
-	struct efa_ibv_create_qp cmd = {};
+	struct efa_ibv_create_qp cmd;
 	struct efa_qp *qp = to_eqp(ibqp);
 	struct efa_ucontext *ucontext;
 	u16 supported_efa_flags = 0;
@@ -1121,7 +1121,7 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct efa_com_create_cq_result result;
 	struct ib_device *ibdev = ibcq->device;
 	struct efa_dev *dev = to_edev(ibdev);
-	struct efa_ibv_create_cq cmd = {};
+	struct efa_ibv_create_cq cmd;
 	struct efa_cq *cq = to_ecq(ibcq);
 	int entries = attr->cqe;
 	bool set_src_addr;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index ec6fb3f1177941..0dbe99aab6ad21 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -425,7 +425,7 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
 	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
 	struct hns_roce_ib_alloc_ucontext_resp resp = {};
-	struct hns_roce_ib_alloc_ucontext ucmd = {};
+	struct hns_roce_ib_alloc_ucontext ucmd;
 	int ret = -EAGAIN;
 
 	if (!hr_dev->active)
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index b37a76587aa868..601f8cdfce96a3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -406,7 +406,7 @@ static int alloc_srq_db(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 			struct ib_udata *udata,
 			struct hns_roce_ib_create_srq_resp *resp)
 {
-	struct hns_roce_ib_create_srq ucmd = {};
+	struct hns_roce_ib_create_srq ucmd;
 	struct hns_roce_ucontext *uctx;
 	int ret;
 
diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 3f932ef6e5fff6..f4cbe21763bf11 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -13,7 +13,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct mana_ib_create_cq_resp resp = {};
 	struct mana_ib_ucontext *mana_ucontext;
 	struct ib_device *ibdev = ibcq->device;
-	struct mana_ib_create_cq ucmd = {};
+	struct mana_ib_create_cq ucmd;
 	struct mana_ib_dev *mdev;
 	bool is_rnic_cq;
 	u32 doorbell;
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 69c8d4f7a1f46b..ddc30d37d715f6 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -97,7 +97,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		container_of(pd->device, struct mana_ib_dev, ib_dev);
 	struct ib_rwq_ind_table *ind_tbl = attr->rwq_ind_tbl;
 	struct mana_ib_create_qp_rss_resp resp = {};
-	struct mana_ib_create_qp_rss ucmd = {};
+	struct mana_ib_create_qp_rss ucmd;
 	mana_handle_t *mana_ind_table;
 	struct mana_port_context *mpc;
 	unsigned int ind_tbl_size;
diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
index aceeea7f17b339..5c2134a0b1a196 100644
--- a/drivers/infiniband/hw/mana/wq.c
+++ b/drivers/infiniband/hw/mana/wq.c
@@ -11,7 +11,7 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 {
 	struct mana_ib_dev *mdev =
 		container_of(pd->device, struct mana_ib_dev, ib_dev);
-	struct mana_ib_create_wq ucmd = {};
+	struct mana_ib_create_wq ucmd;
 	struct mana_ib_wq *wq;
 	int err;
 
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index cfb54ffcaac22c..790be09d985a1a 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -709,7 +709,7 @@ static int _mlx4_ib_create_qp_rss(struct ib_pd *pd, struct mlx4_ib_qp *qp,
 				  struct ib_qp_init_attr *init_attr,
 				  struct ib_udata *udata)
 {
-	struct mlx4_ib_create_qp_rss ucmd = {};
+	struct mlx4_ib_create_qp_rss ucmd;
 	int err;
 
 	if (!udata) {
@@ -4230,7 +4230,7 @@ int mlx4_ib_modify_wq(struct ib_wq *ibwq, struct ib_wq_attr *wq_attr,
 		      u32 wq_attr_mask, struct ib_udata *udata)
 {
 	struct mlx4_ib_qp *qp = to_mqp((struct ib_qp *)ibwq);
-	struct mlx4_ib_modify_wq ucmd = {};
+	struct mlx4_ib_modify_wq ucmd;
 	enum ib_wq_state cur_state, new_state;
 	int err;
 
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index f5e75e51c6763f..1f94863e755cc7 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -720,7 +720,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 			  int *cqe_size, int *index, int *inlen,
 			  struct uverbs_attr_bundle *attrs)
 {
-	struct mlx5_ib_create_cq ucmd = {};
+	struct mlx5_ib_create_cq ucmd;
 	unsigned long page_size;
 	unsigned int page_offset_quantized;
 	__be64 *pas;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index ff2c02c85625ce..fe3de414bfcad5 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2178,7 +2178,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 {
 	struct ib_device *ibdev = uctx->device;
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-	struct mlx5_ib_alloc_ucontext_req_v2 req = {};
+	struct mlx5_ib_alloc_ucontext_req_v2 req;
 	struct mlx5_ib_alloc_ucontext_resp resp = {};
 	struct mlx5_ib_ucontext *context = to_mucontext(uctx);
 	struct mlx5_bfreg_info *bfregi;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 3b602ed0a2dafc..8f50e7342a7694 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4692,7 +4692,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
 	struct mlx5_ib_modify_qp_resp resp = {};
 	struct mlx5_ib_qp *qp = to_mqp(ibqp);
-	struct mlx5_ib_modify_qp ucmd = {};
+	struct mlx5_ib_modify_qp ucmd;
 	enum ib_qp_type qp_type;
 	enum ib_qp_state cur_state, new_state;
 	int err = -EINVAL;
@@ -5379,7 +5379,7 @@ static int prepare_user_rq(struct ib_pd *pd,
 			   struct mlx5_ib_rwq *rwq)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-	struct mlx5_ib_create_wq ucmd = {};
+	struct mlx5_ib_create_wq ucmd;
 	int err;
 
 	err = ib_copy_validate_udata_in_cm(udata, ucmd,
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 6d89c0242cab61..852f6f502d14d0 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -45,7 +45,7 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 			   struct ib_udata *udata, int buf_size)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-	struct mlx5_ib_create_srq ucmd = {};
+	struct mlx5_ib_create_srq ucmd;
 	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
 	int err;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 8b285fcc638701..eed149f7a942b8 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1311,12 +1311,14 @@ int ocrdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	if (status)
 		goto gen_err;
 
-	memset(&ureq, 0, sizeof(ureq));
 	if (udata) {
 		status = ib_copy_validate_udata_in(udata, ureq, rsvd1);
 		if (status)
 			return status;
+	} else {
+		memset(&ureq, 0, sizeof(ureq));
 	}
+
 	ocrdma_set_qp_init_params(qp, pd, attrs);
 	if (udata == NULL)
 		qp->cap_flags |= (OCRDMA_QP_MW_BIND | OCRDMA_QP_LKEY0 |
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 42d20b35ff3fe0..679aa6f3a63bc5 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -264,7 +264,7 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	int rc;
 	struct qedr_ucontext *ctx = get_qedr_ucontext(uctx);
 	struct qedr_alloc_ucontext_resp uresp = {};
-	struct qedr_alloc_ucontext_req ureq = {};
+	struct qedr_alloc_ucontext_req ureq;
 	struct qedr_dev *dev = get_qedr_dev(ibdev);
 	struct qed_rdma_add_user_out_params oparams;
 	struct qedr_user_mmap_entry *entry;
@@ -913,7 +913,7 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	};
 	struct qedr_dev *dev = get_qedr_dev(ibdev);
 	struct qed_rdma_create_cq_in_params params;
-	struct qedr_create_cq_ureq ureq = {};
+	struct qedr_create_cq_ureq ureq;
 	int vector = attr->comp_vector;
 	int entries = attr->cqe;
 	struct qedr_cq *cq = get_qedr_cq(ibcq);
@@ -1541,7 +1541,7 @@ int qedr_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 	struct qedr_dev *dev = get_qedr_dev(ibsrq->device);
 	struct qed_rdma_create_srq_out_params out_params;
 	struct qedr_pd *pd = get_qedr_pd(ibsrq->pd);
-	struct qedr_create_srq_ureq ureq = {};
+	struct qedr_create_srq_ureq ureq;
 	u64 pbl_base_addr, phy_prod_pair_addr;
 	struct qedr_srq_hwq_info *hw_srq;
 	u32 page_cnt, page_size;
@@ -1837,7 +1837,7 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 	struct qed_rdma_create_qp_in_params in_params;
 	struct qed_rdma_create_qp_out_params out_params;
 	struct qedr_create_qp_uresp uresp = {};
-	struct qedr_create_qp_ureq ureq = {};
+	struct qedr_create_qp_ureq ureq;
 	int alloc_and_init = rdma_protocol_roce(&dev->ibdev, 1);
 	struct qedr_ucontext *ctx = NULL;
 	struct qedr_pd *pd = NULL;
-- 
2.43.0


