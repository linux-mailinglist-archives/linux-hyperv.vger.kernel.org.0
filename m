Return-Path: <linux-hyperv+bounces-10761-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA4RIc1vAmqZswEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10761-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:09:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE91517BCB
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F5843019535
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 00:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F8F3D994;
	Tue, 12 May 2026 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H85PGppy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E693B1B4;
	Tue, 12 May 2026 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544586; cv=fail; b=aDwuyAaaGXRLzpYzoW8vDu9iYQqTwopZxjwux1mpJlt2BMVOci+2UGGdmETBAwL8XjevAKNL7ldmTtNYraP0yuTCwznYez6opt0q3mjyxPYn5vV6fX+r8mR6MvbD172eK6lmSqUmlBtCeSjzJOSgGw1sk/S089r7yMPMgeyYITQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544586; c=relaxed/simple;
	bh=sXt9+qUw7LSfrEqi9BRuOjCkRtE3w17Mxk8gWtAECoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fWRTOgfYo+zNpr25g5RKvb/O1ODOt1ff8UkXqK2FnsKeeLqA5AnFZKMuwwzotz9NozMnEW2HeFcetIegYtJHuPJb/92AcGu2rYdaIJiGYKjC5ezDcVPd4oqq3TQLDnTESbW3XDVLa/sptB6KN4IpIa31kYGKFODRqwWRyWVsCBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H85PGppy; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXfmYLaWRsl2BT+k2nDjT9fS7FUZqbPcyhS8urA278ucTxk023upW+4X5vCLdrYX3NkX8cKW++4o6rf/dpoziQ/fXNXYnZ6OIWyBuHteUtzatje8ApGGv4XEKhUSYmjk7g3AWt/2hFe+TVJNBrt+YdrypHPafEmjiJ6RPZPXzw9ynV7XLskehrx/N0/rcFog0dzVdSRmlrsUT6TsDuQENPPWMIH+agkCJkusPdYf0UxR+Law8Y9GxNg5sB3WaDSNqfYrohPFBBIOm5YWlrN0vQu5OOHRbHj5QzwVDLPJHUNL0k6TWzCcVjvsL0UkjEZfTnE+HNFLCWXyN6eMrOxYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2K+pv6KtvMlL6rr2EMkR/EbbeJShE9f5f+8LkltoxI=;
 b=Irbl/FoWmbvEf+TZnPNO+mOj41eZGY6oazen066qeamsk6hWwmG6ra8zd6CiylHc4a8KlKJxDrhmIWdhJ+LxkdngDQVFGm3G08S/KBa8BxvrkmmXmEsmU8dmsK5ZMacIafN9tOeXcGFlOb1FQ//ipaPxkWeXg+eR7a8O78hpg8DkH1BUPI1FImRBKr3hDxLVObEn1h0QVf7RoCiDXNEjg/Va43BWxPZKI2Tg1CclmDVADeDqDkNTVf0n8R4IxO6b5tVMRhgZEfEyLuGOFLaxcAqvxQnyFTNLSboSKFu+W7pfToI2W37BfxGKMoh35oWd2kepzquyt3PJxyHjZjLFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2K+pv6KtvMlL6rr2EMkR/EbbeJShE9f5f+8LkltoxI=;
 b=H85PGppyuLkJAEnAXwXYyW/6FV21PZC87rODEDB7ViCIxTTTl8A9iMDGchQFctyU5Vsxcd2PayzfpFQy7TD8NAKBMTZXzicIuBthQs9APE9e5HHMNvvLekxItTmXVk1Ke2aNxZ13+VtiiMNw5GhclBkAfeVM/p9DiPVRSSkBMV1jZjyni65wh0FjYrQbVN759e+7qyPe15eeKZyUUz/fOciBZFjJc2qX+rNl1m5/UZUiRIs1QI5rKdAmXUpkLqjoZ+GiVzt5m0w95pAYVryZNR/Nx33RWKVdhJRDpEgBAOxPDCABz1eLosg7EPJ6KiIBOyZk2UjJ7y9MtqAYoKZSXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 00:09:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 00:09:41 +0000
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
Cc: patches@lists.linux.dev
Subject: [PATCH v3 01/10] RDMA: Use ib_is_udata_in_empty() for places calling ib_is_udata_cleared()
Date: Mon, 11 May 2026 21:09:30 -0300
Message-ID: <1-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: c11d55dd-4c1d-44c0-1bf7-08deafbac34e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	svVmW1H3o6NiuvO6KDQdZ/ZzOruu8NzSv5dZW/3F0EgaYsakl474ZXtD3BsXMg/kq4cEWjAd6rP75CoM91cMMiwxM3Y7Q49GmxeouoAXmMguppLlNEMuh+An19K/zpteMDew1h3AwTe7oqwLa09opOLypyU/88kgCbTOi0RluGTT++I7I1LL4eayYuPo4WrpM8PJF73XHOygvkKRN+18C0rZaDdB4AWpDsoFMwF/qSGuSVzYMo8+DmynMNIpPFSHY3MI1sVrGCIUAmB3g1XeYQdDQMZuHOpoufhzA0/GwfP6LtwO+1/tOCAAkcee7jZ5OKFXBdz11jOGbtuEi9dhRGRwrteM6ZDgaf/HEMXCjxres04PsvHilgH0z4LaOpTi7IUBMFZcNmvGtZ1Et4dVvjOSZeveBrmImYOR4dlt1LAsXQVcVBwBzNHtadxU0lZAQkKvdZLcnPLiHSlYu9rDlKFN8eOVUUB5prPAY2FjMMl58hsuP84rIF3yLQXDU/ct8vdTS5JTHMsgeDvadUrNo9/YuLsvlcunSVG5DyB5Kfz7yFC8Um5E9tGsf3iM4Sovbm+MuQRwkIDTlCWI4mdcMdCCcY7g03zMIJFi4gjTYVkiuIsj5B1gHgoPdaUicQAdjK9AXdXoKOMDHar3ccvyKiJMt9bJV4gPNn5fTydMgyTGE8ukxFHcFJQi+QJV8jcy+FLxhCRczr1iW6F8s+wRV/E5s5RMzU7cAcWzWuhPb4U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ce4cifKlm2jgJaLFQQWWjohSs4hMEKTldac5iJOT+YygrdVv6y7++Ao1wm6h?=
 =?us-ascii?Q?RsvCZ0Gum2pZ96tpdpfwjmOzH7AarU2wW2/peWZB///4IOmOnlslJo5Q8jat?=
 =?us-ascii?Q?nVPN408kGs9laUBnvRTAKLUrBLys/nW/zy5i8TtnZvZQ+k8WcTjin/FLMD0+?=
 =?us-ascii?Q?QKVsj2oIsxkRelS2iP9vBrFzG3ADyduz//bNiHAA1S4A+ZY7fXmpQXHl9Mx5?=
 =?us-ascii?Q?kuYrrwPjuMmMIiW64m2SvT7tTBdyRAxyR0ot3woU/HgMI8m37lKFx8Y/IhUs?=
 =?us-ascii?Q?lWEjhyJhEodR4TBgOTWU8GDXuXToUABcwV4Mkb6j6ksTv2HeLsmXHlDNZjGq?=
 =?us-ascii?Q?qLLMmg4QgZLlkVHhp4wOc4pfh75soJbGqBb5gj2Fry72KssuMDpriiRvtMbW?=
 =?us-ascii?Q?PVLugHQ2zXnqFXUG+num8T3vTgxtJhFKrVhfiaoNef+F3mCnIliitSov7xBR?=
 =?us-ascii?Q?156DhBVZSJWHVtt5LQTrTjiKomv+yw+tMapBBeT5rnCMtVzsDjULLmyP0AcV?=
 =?us-ascii?Q?1Hw7Nx+Or6b0RLjLfHVxS9Xk6+bGtZuQ9A93Uwxq//OWRmXD+sOocvp6Zj80?=
 =?us-ascii?Q?N5ZE0Lt9L2VsQJMGHqRCfjPesBhD71p4dRRfalQwTm5oL2jy+yIP7UoPzBAZ?=
 =?us-ascii?Q?g1bjyjTkS+W1WS1r5mbbWUv0P3hIInT6vK8E+PARYEB/rl3EGY3DlwnBdO+r?=
 =?us-ascii?Q?l3b3VkzrYepeMiCtA4rX0e2U8oY4lhLyCARj9Xm9O4NoM7hmBHKwCGgLUUFt?=
 =?us-ascii?Q?4smF0qMSrajl+7HKPFRd0TTvmIXRWqXy8K3CMteMJHDHoGYROOT8k/Ve6PwI?=
 =?us-ascii?Q?K/RvITO67xyAUY9Sldr+1kDFUImOu4T3EDJ5gTJqoTMlGAH/r7YevKHYqPc2?=
 =?us-ascii?Q?pR+20u/aKCGJ5ZUfbidxiqXKUaQxGh9Hoi680PuzjuqJyYYfe6ZvlRlvpDMT?=
 =?us-ascii?Q?5R6u5lP88sxriNrTmEt7YU3MoyZNOdFarhqBlxnlgqNPWuypxoRIdJRpakDk?=
 =?us-ascii?Q?mUlKE46DksAGrEv76tifofISkXJ5CkEXAIGcOUB2HwxnBfzzfcjR1yru97C+?=
 =?us-ascii?Q?KYFuJ6wGQLtO4tPuZVEJLiD2rhgI7rmixhhpdB1zlqD8b30qyPQCFqPhxgUp?=
 =?us-ascii?Q?2iiYW0Zv37L667UwAL/s1fczZL7262qai+VtB2ak55/1ctzYt5bK4++q89OB?=
 =?us-ascii?Q?8PK7dEe5cHPb2XHHlNg4CmJR0bF3fsCC4Ntp/Swh6sakabp/OfNT+Ao03yqx?=
 =?us-ascii?Q?CT6O4/zodjQa5B9GMawDDD2f4AjlVrU3rjWY04EgJkX9WkJwms1uTAlAsFgz?=
 =?us-ascii?Q?1GWSUM4qT4rlR7GbukT4PpNj8BWAT/jytfeP4jwgr0zylRmW4/IHn0SqmfWm?=
 =?us-ascii?Q?s+a/PoZdsFjPO7RsqL13F5qDptRJbZqOjfGNOSUUkL0G8uBe9fDlWyzQHrOj?=
 =?us-ascii?Q?OLZZTjM0zFzFMpBQ1iO0qdQ++e5icktEaVl42+eh+t6ORSpJMIgtqenrnre5?=
 =?us-ascii?Q?8M1ITqygCRhrESAb1qv4hBwBXmt3tEfx9l1AMM2fqTN4lr/GYWcUvkbmxCj5?=
 =?us-ascii?Q?h5KsG2ri8AOG2zAoA+cor68hyUHMUo0gtQn84+7c2t4uEqNwmeq1MBu9JekZ?=
 =?us-ascii?Q?mpQnMk8uUh+8XxPyyhYUxh63xD3b7BuV+j8IWIyT10epeqTbA9bBYh0PSV8V?=
 =?us-ascii?Q?OIu7IOPEKD0JD0NdQUcJGpmR/lnBaxb/CYPNn1RAxl1Ccv7K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11d55dd-4c1d-44c0-1bf7-08deafbac34e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:09:41.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lF+BmfiiFBi+mQCoSEA9qMNDJx3gM1zJqri84Dpc9dSJ5E0xWs+Nj6nfJvUIKMmA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698
X-Rspamd-Queue-Id: CEE91517BCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10761-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

Convert the pattern:

  if (udata->inlen && !ib_is_udata_cleared(udata, 0, udata->inlen))

Using Coccinelle:

virtual patch
virtual context
virtual report

@@
expression udata;
@@
(
- udata->inlen && !ib_is_udata_cleared(udata, 0, udata->inlen)
+ !ib_is_udata_in_empty(udata)
|
- udata->inlen > 0 && !ib_is_udata_cleared(udata, 0, udata->inlen)
+ !ib_is_udata_in_empty(udata)
)

@@
expression udata;
@@
- udata && udata->inlen && !ib_is_udata_cleared(udata, 0, udata->inlen)
+ !ib_is_udata_in_empty(udata)

These cases are already checking for zeroed data that the kernel does
not understand.

Run another pass with AI to propagate the return code correctly and
remove redundant prints.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 43 +++++++++------------------
 drivers/infiniband/hw/mlx4/main.c     |  6 ++--
 drivers/infiniband/hw/mlx4/qp.c       |  7 ++---
 drivers/infiniband/hw/mlx5/main.c     |  5 ++--
 drivers/infiniband/hw/mlx5/qp.c       |  7 ++---
 5 files changed, 26 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 7bd0838ebc99e4..3ad5d6e27b1590 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -218,12 +218,9 @@ int efa_query_device(struct ib_device *ibdev,
 	struct efa_dev *dev = to_edev(ibdev);
 	int err;
 
-	if (udata && udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(ibdev,
-			  "Incompatible ABI params, udata not cleared\n");
-		return -EINVAL;
-	}
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	dev_attr = &dev->dev_attr;
 
@@ -433,13 +430,9 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct efa_pd *pd = to_epd(ibpd);
 	int err;
 
-	if (udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev,
-			  "Incompatible ABI params, udata not cleared\n");
-		err = -EINVAL;
+	err = ib_is_udata_in_empty(udata);
+	if (err)
 		goto err_out;
-	}
 
 	err = efa_com_alloc_pd(&dev->edev, &result);
 	if (err)
@@ -982,12 +975,9 @@ int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	if (qp_attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
 		return -EOPNOTSUPP;
 
-	if (udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev,
-			  "Incompatible ABI params, udata not cleared\n");
-		return -EINVAL;
-	}
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	cur_state = qp_attr_mask & IB_QP_CUR_STATE ? qp_attr->cur_qp_state :
 						     qp->state;
@@ -1612,13 +1602,11 @@ static struct efa_mr *efa_alloc_mr(struct ib_pd *ibpd, int access_flags,
 	struct efa_dev *dev = to_edev(ibpd->device);
 	int supp_access_flags;
 	struct efa_mr *mr;
+	int ret;
 
-	if (udata && udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev,
-			  "Incompatible ABI params, udata not cleared\n");
-		return ERR_PTR(-EINVAL);
-	}
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ERR_PTR(ret);
 
 	supp_access_flags =
 		IB_ACCESS_LOCAL_WRITE |
@@ -2082,12 +2070,9 @@ int efa_create_ah(struct ib_ah *ibah,
 		goto err_out;
 	}
 
-	if (udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
-		err = -EINVAL;
+	err = ib_is_udata_in_empty(udata);
+	if (err)
 		goto err_out;
-	}
 
 	memcpy(params.dest_addr, ah_attr->grh.dgid.raw,
 	       sizeof(params.dest_addr));
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 464c9ab4251636..16e9ce8138cb30 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1696,9 +1696,9 @@ static struct ib_flow *mlx4_ib_create_flow(struct ib_qp *qp,
 	    (flow_attr->type != IB_FLOW_ATTR_NORMAL))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	if (udata &&
-	    udata->inlen && !ib_is_udata_cleared(udata, 0, udata->inlen))
-		return ERR_PTR(-EOPNOTSUPP);
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return ERR_PTR(err);
 
 	memset(type, 0, sizeof(type));
 
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 790be09d985a1a..aca8a985ce33cd 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4297,10 +4297,9 @@ int mlx4_ib_create_rwq_ind_table(struct ib_rwq_ind_table *rwq_ind_table,
 	size_t min_resp_len;
 	int i, err = 0;
 
-	if (udata->inlen > 0 &&
-	    !ib_is_udata_cleared(udata, 0,
-				 udata->inlen))
-		return -EOPNOTSUPP;
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	min_resp_len = offsetof(typeof(resp), reserved) + sizeof(resp.reserved);
 	if (udata->outlen && udata->outlen < min_resp_len)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 61078281953d6c..2bb5caf5a89266 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -965,8 +965,9 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 
 	resp.response_length = resp_len;
 
-	if (uhw && uhw->inlen && !ib_is_udata_cleared(uhw, 0, uhw->inlen))
-		return -EINVAL;
+	err = ib_is_udata_in_empty(uhw);
+	if (err)
+		return err;
 
 	memset(props, 0, sizeof(*props));
 	err = mlx5_query_system_image_guid(ibdev,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 8fd05532c09cc7..23abea36cf71cf 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5538,10 +5538,9 @@ int mlx5_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_table,
 	u32 *in;
 	void *rqtc;
 
-	if (udata->inlen > 0 &&
-	    !ib_is_udata_cleared(udata, 0,
-				 udata->inlen))
-		return -EOPNOTSUPP;
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	if (init_attr->log_ind_tbl_size >
 	    MLX5_CAP_GEN(dev->mdev, log_max_rqt_size)) {
-- 
2.43.0


