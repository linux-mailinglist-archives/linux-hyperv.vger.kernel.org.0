Return-Path: <linux-hyperv+bounces-9345-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ch3FtsHsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9345-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:24:59 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4178226B9F3
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44CA930351EC
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F328332ECB;
	Thu, 12 Mar 2026 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZIM5gfhW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAC333291F;
	Thu, 12 Mar 2026 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275089; cv=fail; b=rWcbLAmGYPgiQ5xzgCObXYxPYKeSo4ac6kQHfsOk6UYy37IqOz/mb6El+bRZtuVSYrLmquMuQ5uB/Q9PeKJLBI0Arwh7k2wfFHhesAUaDPBcHqPP44jxNAgRvsuIA8wh7+XI5lv7lRrLQYp6RirIAoaiBzsu3AnJo6mFzVfAZlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275089; c=relaxed/simple;
	bh=aW1l3AoPkHHr7W8R4P9rM2i5FdkurTyCndMQhLclY3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GLOoUW4CqWllTsvYwlhCrwrncgFMUtOYHCLMfnprvsDAIuOsFRoyJbO1IqfenkqdZYThKijjEknOEcJPxSmvv94AEQzoirO1ggEIG3I7NIqJ4CPLDGkaHAeGUTviotJP7SskWVhVy3PxS9S0TMT7GGGaUt/CvvzltFw1kmVQNts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZIM5gfhW; arc=fail smtp.client-ip=52.101.48.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6EFENxoO6uE3PvBsZPee51ZzcYAQVKUlT3TYMthwvQsVOLnQHHVgADGZcbkI2+vObXCisi/q/Yq3yjMAg7nPAfS1DaouKLFUqrTT71vCzJvRfG0a07Tb4rYScBl9Ofnmtkd3E3zwo74CivoJUtFLkI1KZeYkcV2/PxQmSDpSIdWhQlbzFBAdtfsF+3DHtJ0oreo0tSBucDE+KcMBX8yGX5AuRATJWjnhecTacaIARzZhKh+K+jPEvi9TWJL7CQNU0NFmWXzF6LYRXZx2HqwIRndBedBaIHl3TkZo+8HxuJ8arVhtTSHEsd8Bv0FhBfHzuz6jARf/732kaCU0b53WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1FLRKdSbYd/shJrDz2LDGpWVoJMdHe/vfyImvEcREQ=;
 b=iqk6/rTCzQhcJvJzul4nSEeorQr92yIaTrGFn3Ifo3+jktCTIns1dGcw+i9TEMCCjB7tf0bf6SkzkFSIKWp0XAW5oXc5LJDmGZGRsB1s9uwiuk3ze0Se9LbfwsQ6uqWLpjoZJD/hXELX1ACfh+6kFKSLxtHRMrowlUBdpFnfXQkY/UwWVB9fNTacEcmFzGzuin3JgzyIUgbIk7Ps13LOenQLRc17Yt7iK3T2vzbwoA7ft8Yjuz3By9y7/CLtNT94TIorq2UQ/mryuCvcEwEFxF068IcpMPkZ108yrR1A6hhaBlWqSE58+gIpy2Qjyb2oMnJ90ltsNlfpRQIXTEx85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1FLRKdSbYd/shJrDz2LDGpWVoJMdHe/vfyImvEcREQ=;
 b=ZIM5gfhWlMORCaj5CBzRMCe4Zzj3gCgne62eT4I6t1Vbw6bDNxogCVOl/+U/As8Np55/MIjZN+9H5mRfVaR6zdEd4fOSJFJLJ1agTwF7rtDYqgRelPjRReB/pR6uy8ieEP9xwns3cncTm+EUZeA83lNSJgxIkWO/oPuDIdyk7ih7xvcfZm5tsUCsMTBrCZAXapbxI14nm4tBQQ/BfTyWMmsJrJsl6HdSuJDpR+B5U9Dlkb/v3DryRMr9TvAgcE6dZxkDeUw1Iu09B4CNngxwnzszPPeph4/ixNEoz3uvGq7CWxpkNRa3zix12uR+HV2eb5VLJfxtqBAdKDhyNuUxng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 00:24:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 00:24:34 +0000
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
Subject: [PATCH 15/16] RDMA: Remove redundant = {} for udata req structs
Date: Wed, 11 Mar 2026 21:24:22 -0300
Message-ID: <15-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:208:32e::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ae0b4b-0b4a-449b-5ee2-08de7fcdb86a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KcfIeNVRRwqxuVWucet/tPH9td4d9zZ0TpyvUrgv7hm77ZptyrXs0O6MPBa+8Q0/dAZvgY/6ltFlthFM+nGTOzxYa+x9+52VqL1wLZ/3U1UgXVbpDxEf3T6/w8WUjey8uqKPnID8d3isUepF1RJmUcgMTpGJbSsLTZs+joNr53icJXO1HT2OpzVwgDOzk6G+TrG2ejFWXXgSQjp2nX90L+dZ3x0RTdDAt/EEeqC+LenEIZYIQNUeJjgMJpFOmSvynj9NB+17G4Gk/an2J1jK0szl6Rsn1GsX/SMo35ay1SVKphzr+C1D6N61FQmwJPFlG9BMhgXM/T3rvNOoTdTTIAlpZ6R4redKzREsD4vs4cOR7/dN8mrjY+0qqcsnJnwl9wwRdq2rBfGSl37PPuYy5bOPEvXaO1oCfMVV8qOGYPmzLeMI7lzGpNi3v+BLGE1a0xfQ7Nj+dVMapAnZInZa/L4O9CqddorMFNIURncx5at5QMHxiAsF8ZTIKxEo/Z/0t6Ie/4xuL4iPZkpDg+TBfTbTbjQS7jfvvlkRixUXbAKLxti2cnpPUUdiQF3KZ01pBaI35uoZr5cfBrHuo09vB1oUDlkXva6WZMnWxnEdoIlZ+q+btQmjvzFYiPhHyKVgOBHqUIdkQ/Mshc8u0eiNgJ2a4mTZ4dTIiIm+If/3Cl4ttcJYbioEvRQ7BtbJ3yItD6N8KkYAjNF3OHhVD0y0RkKpiapIh91bTgoRQxDQ7HUGNSgU4KQJ1483GlXcXfR2/6p+AoWYg86MtS7pwadhvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bn0tcmD3udJmjMXqHJ9qA27gt6uZnp3ZTBG9zAFcxLZ5IfCYt5UTSG14uZj3?=
 =?us-ascii?Q?Q5QUaIoJS3uhsgts4MfchL4WZVJEPffv4Od7IhiFuTow5k3EOVkHoYxp3GqX?=
 =?us-ascii?Q?VdphSepsadEAWS+8j34apCb48aktQv7D5f7md6u+ht/pm9QaA1hzWzFJlf98?=
 =?us-ascii?Q?efaFGAV7BwVZEVSgw2kaKqmWUCER9zACWoSfWxO/5VlZQrP6AP/LfqqOpj2i?=
 =?us-ascii?Q?8Y6bjRLEY4cTPx4gRYlls8dHdUJS7TmVG20OApMzT9e+QBpyhnzhWMUe9cwn?=
 =?us-ascii?Q?BU+tx/UBJKJ0mYT9RjoqPVQqYeNksQpRm+hqr528gwSdPpjqd0MjiCftncAp?=
 =?us-ascii?Q?1RiHPekKmP/HzHN1XRkpbeouTzp4mXDB8EBkjvkH7r+Z+m8oOv4JKNizAMsH?=
 =?us-ascii?Q?BbiTMzj+ejxu57kg/za4bb7hL1OYH18v0rJvLWqYAtngwfKdxqh75Id35nYw?=
 =?us-ascii?Q?h/rr9zHI0Mc2Q1g5DTjIDFa4LKQUwB0QWY0jlbCPujiK60aX7/+uP8RtsW5O?=
 =?us-ascii?Q?S+Y6tgl/5oAT2uar7hqvXUAvAkoWV1Pi+Ho59GknhlDLblGz5O/r2Gy33CMM?=
 =?us-ascii?Q?iASLMgobtu0wdi29Q9InaPrRYJv1l8JaHXrx4kKmvB+/fEYWITEkWN4GxMzG?=
 =?us-ascii?Q?Xc5y9a9ybYe8kP85IyFDnmyU6z7iT9z6yeqhyBIgg4TymNADN2C45Uog/0Kv?=
 =?us-ascii?Q?RG63C7wx8nnhGq/aN20Q7f88Q04ar+jG1F8cSn7otYcdCGCdSBXzvXvdVglg?=
 =?us-ascii?Q?EYEzuZMjNqwdGi9driNrrNj0ufk2J5++UwrNL0XhmfEszZXNkbPz35FIcaDK?=
 =?us-ascii?Q?ic8Kb0A1OwHlXD+1ZJM9qaY9i2mYxd3l4S5IJWCI9wDlJX1wE3TzNvNoPsiU?=
 =?us-ascii?Q?eCE+C+7IaZf6UHJX5azzi4CRo5xaAgjEX4fRpUQbICXV8KZrge73LTBqh4Z2?=
 =?us-ascii?Q?xl/3cIYF212mFqi9Tm3MEh7Lg1q508LcxbM/5kgDjDT4M1HESiiuRqVQ2Qty?=
 =?us-ascii?Q?P8QZ+pqOW3a2ys+QyHtE9Pl4aXS9P0TwQIRtZ6roTvqZ5lwS0ctI8ND5Gz+N?=
 =?us-ascii?Q?U7hAKnW0wqyRsbbsD768Xo2avVp7Ricafbl9bP2snmkn6ZmIfjWSiErpZl0S?=
 =?us-ascii?Q?3ASi0yIgTJ64946Ta0nRiUuYgT2Iv/yArpvSm4wtNI+JXuyygccLOhvkIf9y?=
 =?us-ascii?Q?+B6izlIrDpihywhu1YyZvKNCfSWaCEwZfY7IJ04ds1WkCSCSKhTv5Ef4FhaK?=
 =?us-ascii?Q?/Wg5uUOYLDBStMuskf35ApWuFA5a4Bky9Z0Hi9k3OsJABQC8f/T7xEN7j+6o?=
 =?us-ascii?Q?N9E2s0d1E30njykqMNEJZnNPXzt9LP95W9iwQKXKN6agdhPs0zN3y+vS48Q1?=
 =?us-ascii?Q?pM4mjW35HU1NVNwKfQrCV3pEZ2bJpr2yVgcBx4VNb62MQqDJlNVammabHHrf?=
 =?us-ascii?Q?Kw3s0LzulMVdVn8GKlkZQZdy6W6z8a9baM0K8uKxP7Qbx9wJKHQqqBM67HTK?=
 =?us-ascii?Q?oPdCmQ2SkecwX/rMKJ79kCthDNN6huDeoAWNbuqYgbizpdEoUqVdwDfne+i0?=
 =?us-ascii?Q?hUmjM3yjlx4JitINKLLCkRxVgjSxHP1WOa7ug+GDeI4YaHoGVlquyYWC1C7e?=
 =?us-ascii?Q?d7ju+VxV5o1lp/bY44rDU1R2cT+awAQbx+SM3n1G/TpiPB7ihX94p5V80Bs3?=
 =?us-ascii?Q?KP4sqgakrC6OlxTmGuLHIxdmdlJ/UMy58E5ePT9UVTbBTmZswaREI+0pjK4i?=
 =?us-ascii?Q?/tz0p1Admg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ae0b4b-0b4a-449b-5ee2-08de7fcdb86a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:27.4138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adIdJrzcXYYhQG8EwtOZU2Tv2GcEJBedvnvnKpyU/+sUiGB5qgS3xJ5+f6n0Jvqa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
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
	TAGGED_FROM(0.00)[bounces-9345-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 4178226B9F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all of the udata request structs are loaded with the helpers
the callers should not pre-zero them. The helpers all guarantee that
the entire struct is filled with something.

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
 drivers/infiniband/hw/mlx5/mr.c             | 2 +-
 drivers/infiniband/hw/mlx5/qp.c             | 4 ++--
 drivers/infiniband/hw/mlx5/srq.c            | 2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 4 +++-
 drivers/infiniband/hw/qedr/verbs.c          | 8 ++++----
 14 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index b491bcd886ccb0..f1020921f0e742 100644
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
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 49dcc39836c047..37f3d19bd374ee 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1768,7 +1768,7 @@ int mlx5_ib_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	u32 *in = NULL;
 	void *mkc;
 	int err;
-	struct mlx5_ib_alloc_mw req = {};
+	struct mlx5_ib_alloc_mw req;
 	struct {
 		__u32	comp_mask;
 		__u32	response_length;
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


