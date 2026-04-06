Return-Path: <linux-hyperv+bounces-10029-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPSXMWPw02lBoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10029-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 432023A5CE9
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20EA930263E2
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601EF22D7B5;
	Mon,  6 Apr 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZnqbEuGC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113AB392835;
	Mon,  6 Apr 2026 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497260; cv=fail; b=UfwLC1X1ldimLodlK/S9ddm2lqnAI66t9KEzIsg8uMbiCZ+t49rBE9x61ZzhOcBuY3+AEUShMpBtJteFaCT7M92lH3SKrJOvfG4xcMK51Tr36EGTT/ATOikA8pqFxJMefXR9M8/D1qlm01RNiX1TWWBMuK89lWCHUPe/c2PsH20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497260; c=relaxed/simple;
	bh=JOPmDwBzKvTICHIpjHUWCYaQt6Qasx9dliVclKos/0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eQ1jZm2A9yhghcnmOBNiJMIFasj/A0lrOVxsLNQ2b4zB18uakttnaQ6Djk1S3oxpechgZafcR06ybUEbB9oNDdRwShRA8jyVwQ0T56AM8Z3M0UFqhjeaItygVVhr3DsH76s0DmVLBbyWlWkQ54dNte4KngkG2eQ5pHZwOOPK+qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZnqbEuGC; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e13yT2O6/EUZjpPkbl8Yfx0XyhZlCsfR0LaI5ZD6trR122594oaFrhJD8yU+z0Y5rZ9cjFk7Pqgzoi2lJ4ub1bR+hWVtlbS1jfBZwPPqGUkT0l0XJlcklmo++4iFhXGNtq+s8gAyXi47CyeL5OLfQroGYothB3mM6vLCUXjr2IhnQAAOOVsPyEQOeS+5I0LkUhxzN0oJCyEItTPDRDo5ICWT3PwPAo9+TyAjtNm7ZCys9Ohh+9WyyE7QqRjvJzo7aRg1N54YQM3OqDk2XYUQ/8p/wGaSLNnhZuTwGVeSUZa1/Fv49b3e8QaQoj6nBgjWp9CF4luDt6ysJ+YUNwTtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqYDwQgD0XqbzmsCzcs4P0cOSOTcM1QPPSnNwmer2UQ=;
 b=OAJICfj0HO77EtdVxuFV4XuFNniwGJMJ4hkk/2pguzrRBbWENdYSZo5NwfGG0Tl8hsDD0ZGQQAz3QurGLY6B/tuZtYBl4bpPrcrOoNIsgsN+Q6mBINj+kWGYFytDcVMHsqxymgzmLz8IWUpjlBfr9+33OU9Vo8Yo27OevQXNS4xVEczXCmL7O5S0F0cqLVufTolMX+ru08oiNadDY5/d0MHddRENwcwcPzToXWa/rs8O83sQjrFpPiyHQMKAsvpgEK4xbVw/DBZHh4SRFSe+do+WfXmGxnxTcwG5ABRf6+1EKBfKg05woZcfL44v1BPgV8jnQY1HsWPHcpG7htGvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqYDwQgD0XqbzmsCzcs4P0cOSOTcM1QPPSnNwmer2UQ=;
 b=ZnqbEuGCSVoXp7HzFdry8yGlwNE4Jje2+W376DiwS0jPY08R6KHyRbVudRmtrEWcAirMIi5JixYBli7VZUWNOUaa3v6zsWGoE6Ay+74GZ1l3VqRcZkOGrOJ5iSY3PKkv++wN1Ef2W6ShS5SNK2VZv/whEXIXdNoCLH6H/wvfhw5uDpoToK4BeL7kSxnjBHpdjjCDu9W4RyHTUQFAv9upNIKnZhmiX49ipuYLN2v9W2jOqyqfWWkYePCqD/hmE3S/yeg2ayGzJ9jMezzJvuxwx0ltmUCVvMGsJzHt0z6r+YLzIQjDaYPxz1EENWVAcUP6rPhIKZn2izRzgw3UCGpclA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Mon, 6 Apr 2026 17:40:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:49 +0000
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
Subject: [PATCH v2 08/16] IB/rdmavt: Don't abuse udata and ib_respond_udata()
Date: Mon,  6 Apr 2026 14:40:33 -0300
Message-ID: <8-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0259.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e6d2b5-4085-437f-8cfa-08de9403a266
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Fv5dsrkMftKzBR5OPdqmflNIMGiQZnkrPQGVuZ7/GYnZH/cOORZ4Te2MuaSCvBrfRnRiBI0qT64LF0ZQq7AZt5MVd4u6AOgV0uL5At67tdRFqnBiCnuwp4vbhI6JgXTKZzH1J6hggwM1gdU1FDN2jXnEbzwnUlnwHD5L7E/+gdWbi1U+oy8HO51wb5RzRlKGKev7Ua5KFbEl0vF7fo7pecVSXnRwU6TebKksnEXyjjZl9EXYQZHlPoY64qKPVn7VvfryYt9h+bLKLoH/YL3VQmqLUrPqiljdymU8eWuzvLyO7KmDvBGPU0LSoaO1EebDMBqMNL3MQkh2tIcxmpjAWXz+Vc76lBHLFA/Rq7XwWqSFSK+92BUvoisyNgami8xVoVO0qxw25L77KdsZ62I9+x69tMbF6h4secX13XDocWWwxlG0MWQ0/MaIuwVVuUZlXKEc3NF9TykbQFb8meD0zq3qISn8Jh1RrZP7kJLJsoP4GySnKV6YaxRYaXGsHFCqg/ZkJdwbcVTx8bix21u7gQKKYeMOlb39KGEDkM8sCgEdZq3yh+c8wupaWHiGEvd5iQ7N+lFZGpu3ms4/W/OAzj1z57SN6FLzNEKRie3qLinm8Oaw11Rj7PlV6vmbLuMQTGFLcrivb0KdNxBK8UFv9OqxY0ZBqy1ID2n9u//+7ile/n70zc7fsaH9cioPyP+Sd/Ik/K2NDaujYEUWXVq8IK28ZwJ1Nwk9PihmBMmHmUSsT32IoKPiG1J7eSsL/ise4rePjUg8ZR+iucXICfmuCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OMtXxLt/ADQc7Y8vLSwEhk3gEoWLCAbiOgtojLDEmwSdp7/S/+JfseueOURb?=
 =?us-ascii?Q?iN+BEPUBTt612ZGSgl8rqC15Q2IG0iHlAwB5/kF4/8eF58jgTGz3qx05KLFh?=
 =?us-ascii?Q?iikZRDUXulm8rvFx1gEo5bB0aTv6Iy0rXYbDAlX3IYyNI95l6Wm0OvBPIL+u?=
 =?us-ascii?Q?8ypARAha//4eMwDfXXX98IURq9ZzWEDY3voWGPB0gM4VxrQFvhohOsDqfzhF?=
 =?us-ascii?Q?zd/GBsASAnitB2CYFjkIG+ld1eqFmIWmR3alMaTQEkVi6Y7OEe3fCdHfqCuI?=
 =?us-ascii?Q?s0/kdDSB7MLub3gZSdnrE2BrLU3+bSWD/D/4MKOPfIGu2vtjrW+QAReddn9v?=
 =?us-ascii?Q?CpHsUiRVE7uWI8yyvj2eXxa3WWgLlKhci1H09oiNGEY8UgRNUjyqwwfcQiOr?=
 =?us-ascii?Q?O+ihmGJsMi6AVaM6RzoToAOxl7b1Ug95Dd2arWQVM4apinoBe0JnjQrwbmMr?=
 =?us-ascii?Q?Dgua6U/3tLDHedp7G+Nnfuj5CyIUwf0jbvpoSWWuRAn6ZK7jHzvdGmuDxSB9?=
 =?us-ascii?Q?yz3n4nwCIaiFv0O+fKHmrFQx3gYSmsRqccoUORlKxI6V0WtF25g8AgEBhVrb?=
 =?us-ascii?Q?gvPqMfsJyU470Udj36UfTZEH3Fw7bzqSptuT/RCgLaL9iRQy3On37T3e6jqG?=
 =?us-ascii?Q?JJTY0SLt4iZ31SGRJ6FCUpStDD8wkLgUJKAtiiKVin3ny4R+9Rl4Wunbc/iy?=
 =?us-ascii?Q?EpvnxNjhuEqg0oDKqe5QTp4UREzl1uZQq2Pf+9noDzUilb1/atND1YfkEGCm?=
 =?us-ascii?Q?m+UKDMEyQRm8qNRgT9txHyuV+k+Z37mIMZfM7LRg1L+sTDZkom8AwU1g7/P4?=
 =?us-ascii?Q?3rKiKTECd6wdUxc35bBCAc45Pxt0ryUll1Y/m3BbFDWnBYZ9rau6wxeoSexH?=
 =?us-ascii?Q?g2ZJy7uiV68RPZqcljHELFYU46hWq2lG+o3YEiap8UMkJ4uOTGNOh68lGZ3z?=
 =?us-ascii?Q?DZmtJuO752IB9n0G/n2SomH5sLcegNh/TR8iRZ4G7GdP9FQNnn3z0EvNVzzD?=
 =?us-ascii?Q?65bVBIKIvSZ9KHgFS67EgsWb7YOeTC0L+QYEksejEeoM8HsrhnIlk2+Y3GEt?=
 =?us-ascii?Q?0UaJZGOksPKDADFMN26pf3Vgaf9iQe8zC3niY53r/MJ+2pwyulu1TBcmX+S/?=
 =?us-ascii?Q?qFQyFmaLCveOdRjtFlHDCSj9TrrjRRSmZlQP5i8ZXEXr+OzfU8JpTAhcWOY5?=
 =?us-ascii?Q?HyPcsyUUEVjdVuzlfIGg/uFhtwngFypllLTKb49SAIaNW3I4IdP4DpdsVuV5?=
 =?us-ascii?Q?7yNQ1Mo4U514qvFgmIqk5HOCcuIHr7RiT5VNNXzM/uEasvRLwzVS1j1Tzsjj?=
 =?us-ascii?Q?9BQ0ajDyf5iafpVuVIN2NSX/zC0yJSKOQwedFhF61W2v96geOMlCLtFYELWm?=
 =?us-ascii?Q?AW1h2tFs8jSyI++xQCCOuApyNlD/KN/DrhmzciqZ2nkQHZjmxekPBIcYXbHo?=
 =?us-ascii?Q?L3BRaEKpeuvavI90d9lDBjwGVHmRzAoh/5KTHkAi+QMVdihd+Jyjs3UzRQdI?=
 =?us-ascii?Q?iJkJge3/hCDFtVlElnE5VPxflq1AwgeESoPVzsqWTQWNFVl8Fkh+aI3SbvW8?=
 =?us-ascii?Q?+3vhMuxuSIwBtuNXKQ+AIgHMm6U5g9v4NrSZEPZXCuCPwDedzzuPxyt8kaG0?=
 =?us-ascii?Q?bXs7ID4Wps+CxE/g1r8+sIYFWlfuJkTfWedUz6roHDEWir9Clfv+v0oqzSh+?=
 =?us-ascii?Q?PKttjBpNZyrtY24/SwdjIUT9NscT8UPS5ZMEWkutszppJxCs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e6d2b5-4085-437f-8cfa-08de9403a266
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:46.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgJgVraR+Xd/nAc1OJpgCAgAwsofOszYiQ2s1/x0S1cieugZe9aH0ZBSyeLwGTux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
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
	TAGGED_FROM(0.00)[bounces-10029-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 432023A5CE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use copy_to_user() directly since the data is not being placed in the
udata response memory.

It is unclear why this is trying to do two copies, but leave it alone.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/sw/rdmavt/srq.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/srq.c b/drivers/infiniband/sw/rdmavt/srq.c
index fe125bf85b2726..d022aa56c5bfd5 100644
--- a/drivers/infiniband/sw/rdmavt/srq.c
+++ b/drivers/infiniband/sw/rdmavt/srq.c
@@ -128,6 +128,7 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 	struct rvt_srq *srq = ibsrq_to_rvtsrq(ibsrq);
 	struct rvt_dev_info *dev = ib_to_rvt(ibsrq->device);
 	struct rvt_rq tmp_rq = {};
+	__u64 offset_addr;
 	int ret = 0;
 
 	if (attr_mask & IB_SRQ_MAX_WR) {
@@ -149,19 +150,17 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 			return -ENOMEM;
 		/* Check that we can write the offset to mmap. */
 		if (udata && udata->inlen >= sizeof(__u64)) {
-			__u64 offset_addr;
 			__u64 offset = 0;
 
 			ret = ib_copy_from_udata(&offset_addr, udata,
 						 sizeof(offset_addr));
 			if (ret)
 				goto bail_free;
-			udata->outbuf = (void __user *)
-					(unsigned long)offset_addr;
-			ret = ib_copy_to_udata(udata, &offset,
-					       sizeof(offset));
-			if (ret)
+			if (copy_to_user(u64_to_user_ptr(offset_addr), &offset,
+					 sizeof(offset))) {
+				ret = -EFAULT;
 				goto bail_free;
+			}
 		}
 
 		spin_lock_irq(&srq->rq.kwq->c_lock);
@@ -236,10 +235,10 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 			 * See rvt_mmap() for details.
 			 */
 			if (udata && udata->inlen >= sizeof(__u64)) {
-				ret = ib_copy_to_udata(udata, &ip->offset,
-						       sizeof(ip->offset));
-				if (ret)
-					return ret;
+				if (copy_to_user(u64_to_user_ptr(offset_addr),
+						 &ip->offset,
+						 sizeof(ip->offset)))
+					return -EFAULT;
 			}
 
 			/*
-- 
2.43.0


