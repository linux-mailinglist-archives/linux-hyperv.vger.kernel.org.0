Return-Path: <linux-hyperv+bounces-9781-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HIhID1TxGljyAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9781-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:25 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC97832C6AE
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2A8230234CD
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D226B38F63C;
	Wed, 25 Mar 2026 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W0GmCL22"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B83C38F654;
	Wed, 25 Mar 2026 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474037; cv=fail; b=or9d4C8dxz5BAgls4QRNZxKKGRbs11gEDGLc8kmCaDwTeX7NobL26I5ExdKQQswXK6tEXM9R+a7g+EayR99EBMHebXPBScEM+nEkJD9fZMxjf7+FVRu+SU24cRa352sY5Lh0pAEC4uREtSUaiWWT5yAmySfB2pOQidF6p4fW2yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474037; c=relaxed/simple;
	bh=kxa9WPYb4nSPMXvTr8peY+f0VcSlqQzLQzrrSnxhhcY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LiQm2Y+fppSYIc5NXeTr9YYs07WreG9OlhLqDY86Bxvin/o+ywvWkaz1HrtyJMZZG4xi5rKuzA63P2T34JzNBZdKCG6iGkv/PA+i4AmgrCdhK423tfeTO5BqC/f1J6kCoZW2PN+QTR67W9ionp+jtjkbfIsVs4TascvwcR3vgro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W0GmCL22; arc=fail smtp.client-ip=52.101.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5qc3qgyxiSd01LAajebItsPJVc3NIqo38UUuTVePeFMwXH6SHEPFNuDF6tEmTqRCizqkxGcDgPWTYPFXLzv61Q5BSwW/H7CFNge20rY+Rvp5R/ECx0+FEp+h1ePnYRyuiMRh8ruVEdqoca8W6bo+A5I9YZ7WyavHY7SxRP46vrImA2IaWACdrTGVxhafMUbUJn/IeZQqlt3RO9BRbqF4QvMjVw85r4B+HQQrAqBl2yVZvUiGu0q6sgpdqrAg143hcsYB6hL4aTPTzMPkjjsANNtXKKRzS3sKo+BqdZ96iBW4m19uUBgP/jeEILRWXsc1iiJ2oBLqaASICJ8msD3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvMTGjFlwLEnrd6Z5ah84NiSbKV0N/WgZPXhIYUaNjw=;
 b=Ju3dXaZSQ1Z8pya2ryp8UFgE4tqM1zqHZdJ0JbrguCNMvNXzZsAvQW6wu7kdvKa8FJ697a0kdDNDX6HHWNrhHS++Ux8+VQ+GgGS6yM5mvafQuONbrrZPBLlZ5z7yClOcmby39DmaRwMJ3/tPbJ26pUB93yFrY1F22ue/UHJ5rJ1JjPSSWbzauo3N66NK9Y4Ttf2nVd7zngraeosYYhBPPaxUOLvt/0otgAKU5Fy6/qY4stYnM8pIRsIGXAjVLIaJIhJ1BWo1cpGXLI6Cxl1QxHoPb7CdF3akoG8SNgMMymCqgpXqJUkwrhys504jci1OFAJMWu3y2JOCLW/BWZLT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvMTGjFlwLEnrd6Z5ah84NiSbKV0N/WgZPXhIYUaNjw=;
 b=W0GmCL22jYGutX9vwF1VDcZx5J0b0Z5hIb5QCCfd/DhRoSttys39oVKdoQy3+zKRd/VJlDEZiady5EqnaSwQp5xlAjtdY0WpwrZnfHlmcrEsyulUlWYn2BjJyjIQj1mJU5eaZ5kTOLqLoX0jfRsaVBNfL+TBu2Z0mQEesNU5a8ZwUoJAeTbmY1HNMtMB6iy7HejgCVtS8s87q2hGgIcuq+nVdCQN94syNY09hA9Hj+qhlG1vF4a30d33pEzsC0LZ4UmOtV8r/loRPnaKwBWxfb8w5xQ1kHs7iBOoPY2JffwUXR82Sm73GXeIHpBzpGsw6+XOZ2tVZBC/r9ByDn0NRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 25 Mar
 2026 21:27:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:10 +0000
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
Subject: [PATCH v2 00/16] Update drivers to use ib_copy_validate_udata_in()
Date: Wed, 25 Mar 2026 18:26:46 -0300
Message-ID: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:c0::41) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 4093b371-d12b-4d14-e4a4-08de8ab5440d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lrHG7Vub5/7tqq/Od+H4pn/WH509vZ9W9tHWlstelMN8CHoqvcB+zyqGqbbRbQitJag2FvjnKVHEiXSlDPQ1GiCFfmPEjuql9tJ9a5TtAnrebCmjAfeFqHBdYkJiPq5nFpLIUOL+wHBnGmQ724PYl8mLDemLYsHrfbbQKdkVFCcRHYp8763lisKLwoZhxRoBl8XSrOkRv4G8+UNRcaEkKr24hYIeQBb8HV9AzT1VST1w0mmz1ziZvJboLzX/wUwLCLnRJTZFPA3oKO3e3BmzNq4NjOfLlOdMUYOXbLPNHRv7wdbg3PJm6o2xefvtw/JhZtZiDaAyOxUKy7Z7r3JnvkcD8o3uX7R3efu5QlzrvP/k/9oSyLVPALb/BbK4rwrrs3kIVIl2h0PR4KIfUpru4xyKUDc/IXeO7MY6MPQe4CcKAgDmS4WVD/MUL+hsqrnS5DB5d84arR4y9xt0DCac9kNMRfhKh2KyHSUuVjJ0thF/gSBAECofqySjCYRAC45/N6JDtEThaXyWbMUvVhKl4FU5YcqY5dCdxag56Eg7tQGneko5niYFboJbnBK7C5PPnXuLCuE9B4p4zD54VY5hYxZsC2mcYds/VnMkNL2hhwPMfyv9dQSJYgxLecHKQvKV/0REHrSBulK4jE57VobJUEb5tw39LSK8iCs6/XEEyMYzCUZuvSVhj39e2QfK2dE4rSXgBNl2qi/mfWbrJgeW9T0J5K4OqLeofhLgvlAvNn6hJcnLq1H0kl8RseCmVwGtqlWYUlBd0HZ0xTzc15EgCJgCgzI+PBkx5k4KukGqh+c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CbmqRzkPJ9MjorDpkpasZoGYc9PIq8413WMPC7ABEZ4rKfOZZbTIu8aXScb8?=
 =?us-ascii?Q?+JVcRwz8R8nsZkMQdqPm6wGrQmjrzW7xBebG1bsTrdCrulGHVg9O1/2be69D?=
 =?us-ascii?Q?dbLsIcCgjIfeng0MCSn1DWGo9Tz06ILETjIyG86z5B7hFMwe0w22XEpmTQNS?=
 =?us-ascii?Q?Le98b57oscF66S3+DxShB0V9BaramrkTlmHGdRqgiUOgPSCwZGwSsR+VJSnM?=
 =?us-ascii?Q?vCgsedDKZYHZiwbst6Ph4oWj5LheoK4b0xCMZmB591qjq9PmtsYiHw+jycxx?=
 =?us-ascii?Q?UVa0NiQpdQGrbkx900N+PYCUPqhMBV06uxgaZgxsgCzrLO5yLj2v3C6UO2xz?=
 =?us-ascii?Q?RCKv4CnNKxfGyOo8TtFdgYU7+3fgVh5yE+37XWCXJVvQB/mOfcLzrICmPF7h?=
 =?us-ascii?Q?+Dx86TqH8gKvx9kRHHUJ/gVpOom1Bxn5I0ZC6QXCtNujikbYErE8Rfxvvuwj?=
 =?us-ascii?Q?TLbrZeyFEdaRlbC+8DNFsFbbcn05uuqll6LGoKH1MFD68rlJ9RBkiOtfAEpJ?=
 =?us-ascii?Q?NHF8s7oY2cokFkqtDZDorniyh4Y/S0MUngct03qsdYDTeP4u/7Lx76wCxHME?=
 =?us-ascii?Q?bx3OOFdiZ8vaKhYt+raxIhP/zYkGElrz/E7n6mVszPTROlk2IzoNQfqIfuWX?=
 =?us-ascii?Q?eTacFgim9u/hln+onIJXzbJ1Lo2NHs1jNxCA2JpuN9HoA7GIfkSJcGDeX0Pg?=
 =?us-ascii?Q?dA6OwhVDqEgo8vSAnJO9IcoYYBAC3Q4xlJdPgG1vSNilaP+BxnH3A23Y5jzg?=
 =?us-ascii?Q?JUnSylQFw546hTD3QL0/7nARjd0cRkxp7irvuTzPTAMauYImVt27Puzn/SjP?=
 =?us-ascii?Q?Z/WOVDGuQ0b6ZZ8IDs9deqkpEA0QNkz+yfTCWdij3d0X7gKLugLtlIEBVUcO?=
 =?us-ascii?Q?Cs+RetZac1WMIHJ7bl3bpCQLBr0k3yAHiQ0ZbL+I9tZ4tek03ebVd5UNaaHf?=
 =?us-ascii?Q?EBLjHHI3gYxVJhCGjE9f3sRTlYTnRe0G9/mLilkuz6rmRDNN4p1pt7XCASwM?=
 =?us-ascii?Q?V0ZvjAKAAEHyybrwLzfXCGzKmFia3R0Zv4N1B4CoR/dzdM10bQbhUz9+gh9a?=
 =?us-ascii?Q?P37a3ISoKKobCv0Z6eb1NXo5Tqwa9H5udddtB0gJg/U3D5cH5kSA2d7lGUn4?=
 =?us-ascii?Q?nc8DcyuVWLa0BIV92coBn+eeZIfW3h9YT7sjJczKAVH0JR5eJgKJHftMO/RK?=
 =?us-ascii?Q?heddtzB95etE4OLEJ/syJVOyAEZfzwITO1IntUAQrWZMBYd9PhXZvcjUWQKf?=
 =?us-ascii?Q?abNOfXyO4ar2mZsX9CA4OyIea4YASpJqFgSTAysTYfY45MmTNysQshRVA76a?=
 =?us-ascii?Q?cK4zowW9VdRygn0YqwMqFk/5uqPZDN1nALpCCA7X0qgxCDUt14l/ODWMw6y1?=
 =?us-ascii?Q?X6QIbCmOU4bB/FZEGOKw+ghBaoDuVmgUfwG8VOCM41FFDhe+E+9L0nhNnmph?=
 =?us-ascii?Q?lYSey0AKzQyB/pDdGYwgWGgGDR1rf0ZF27z8qwTt4g/19F/Lx8BoEPsiW5Pl?=
 =?us-ascii?Q?9O21BbBbAJ2fHhT9xMHis9dWkGOI1mkZhWiHhuC7uNhQSSQfS20FOexm/rud?=
 =?us-ascii?Q?8ju2XJ/+R6rRpg4Q/+WyL0Buc9iOowMyy+/ABmagkh/uL5i1odEAF2Pp9IhE?=
 =?us-ascii?Q?8k0lDfun7QaTQbgtqrfO2hNvVPRA5WTeYoRuFnu8F06r7fUWMNPezl/fpOpm?=
 =?us-ascii?Q?En0xDAXqjMzs3lY16PDA86odOK1XcnOySr7pFlDXa8uDPxwt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4093b371-d12b-4d14-e4a4-08de8ab5440d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:07.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXQXOsCz3lo+Fyko3hd0+qpJO45oiPGKH+tbzBlxnR+zX2GXpAzbmjEaFBxU5Hp7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
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
	TAGGED_FROM(0.00)[bounces-9781-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: EC97832C6AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Progress the uAPI work by shifting nearly all drivers to use
ib_copy_validate_udata_in() and its variations.

These helpers are easier to use and enforce a tighter uAPI protocol
for the udata.

v2:
 - Drop EFA patch, rename the field instead
 - Fix the mlx5 mw change, userspace doesn't use the udata struct at all
v1: https://patch.msgid.link/r/0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com

Jason Gunthorpe (16):
  RDMA: Consolidate patterns with offsetofend() to
    ib_copy_validate_udata_in()
  RDMA: Consolidate patterns with offsetof() to
    ib_copy_validate_udata_in()
  RDMA: Consolidate patterns with sizeof() to
    ib_copy_validate_udata_in()
  RDMA: Use ib_copy_validate_udata_in() for implicit full structs
  RDMA/pvrdma: Use ib_copy_validate_udata_in() for srq
  RDMA/mlx5: Use ib_copy_validate_udata_in() for SRQ
  RDMA/mlx5: Use ib_copy_validate_udata_in() for MW
  RDMA/mlx4: Use ib_copy_validate_udata_in()
  RDMA/mlx4: Use ib_copy_validate_udata_in() for QP
  RDMA/hns: Use ib_copy_validate_udata_in()
  RDMA: Use ib_copy_validate_udata_in_cm() for zero comp_mask
  RDMA/mlx5: Pull comp_mask validation into
    ib_copy_validate_udata_in_cm()
  RDMA/hns: Add missing comp_mask check in create_qp
  RDMA/irdma: Add missing comp_mask check in alloc_ucontext
  RDMA: Remove redundant = {} for udata req structs
  RDMA/hns: Remove the duplicate calls to ib_copy_validate_udata_in()

 drivers/infiniband/hw/efa/efa_verbs.c         | 55 ++-----------
 drivers/infiniband/hw/erdma/erdma_verbs.c     |  6 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c       | 16 +---
 drivers/infiniband/hw/hns/hns_roce_main.c     |  6 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c       | 10 +--
 drivers/infiniband/hw/hns/hns_roce_srq.c      | 54 ++++--------
 .../infiniband/hw/ionic/ionic_controlpath.c   |  6 +-
 drivers/infiniband/hw/irdma/verbs.c           | 12 +--
 drivers/infiniband/hw/mana/cq.c               | 11 +--
 drivers/infiniband/hw/mana/qp.c               | 29 +++----
 drivers/infiniband/hw/mana/wq.c               | 12 +--
 drivers/infiniband/hw/mlx4/cq.c               | 10 +--
 drivers/infiniband/hw/mlx4/main.c             |  9 +-
 drivers/infiniband/hw/mlx4/qp.c               | 82 ++++---------------
 drivers/infiniband/hw/mlx4/srq.c              |  5 +-
 drivers/infiniband/hw/mlx5/cq.c               | 14 ++--
 drivers/infiniband/hw/mlx5/main.c             |  2 +-
 drivers/infiniband/hw/mlx5/mr.c               | 15 ++--
 drivers/infiniband/hw/mlx5/qp.c               | 66 ++++-----------
 drivers/infiniband/hw/mlx5/srq.c              | 17 +---
 drivers/infiniband/hw/mthca/mthca_provider.c  | 27 +++---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 14 ++--
 drivers/infiniband/hw/qedr/verbs.c            | 42 ++++------
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  5 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |  6 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         | 13 +--
 drivers/infiniband/sw/siw/siw_verbs.c         |  6 +-
 29 files changed, 172 insertions(+), 386 deletions(-)


base-commit: eb15cffa15201bd53d1ac296645aa2bc5f726841
-- 
2.43.0


