Return-Path: <linux-hyperv+bounces-9329-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBJKEcQHsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9329-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:24:36 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 977DF26B988
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFFAF3064E94
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9325C32C957;
	Thu, 12 Mar 2026 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MarrfT4O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4323832B98A;
	Thu, 12 Mar 2026 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275072; cv=fail; b=B7fzNI6R0AYxlcs8l/xJjlz/L20ep728xzukQaVBZZa/PhcvyoTEySLzlpsSAxtPhc6pVzGfwx6sd51WGgLgd9qr9n0HtPlg2nEUb0NaBE4dCXcd+bG3AH7XZtQLOHJu4AjTkd3gIovV5bVZ9ARAS7wJb50h5VSXi2dKcQNiN2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275072; c=relaxed/simple;
	bh=O4IYweimdvbGjxdLcdznlzSuXgRsj3cZS35EQ0LoJsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZToVGcYLbXHYaiN/42eyQh4DSO2odl/1E0ZBGVGSxFK3aHAfwbvClM9CoV7GPkrpi5kPiYcZXX6R61lUGxUd+tp+0pdkJoggA0Sa699yljiVTU1aPkoHlicrVP2p0Dc7S69ZWWWSqz+qrba1SBZ6UbXxishWf05rnyhHyopUxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MarrfT4O; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nK1sQ+XhBYTNC3A1pWZzpM14BBbbtBpLhgI516S7uPVtMNRlHfxVo3SIGUkfwFUnKD/B1nObiTsUDcCoxObSuGz327iDkgUqRV2YkHrSZH1bEw8tv/20D80ChcFq+XWAQ6Ddh3afMMe+P79OfCLbslpHbjPDB8zlyjPhbkQoIQN0GL07N6qRQ0TtFrgKCrc7qFJr9n48Jj0702/6rkZ9LMQ9H7NqNNKC3DHchL8VinXDOw/ngD4TDfK3t5Ar01E9OIEaJNe4D+n6Uu4TKXtXnJXKl4zWk251J00CVoVBslAs0W5m/q0KQRr0c6ekNJ0Fq8AMajOsbOeKkGJuEwwJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFYnpfU0mEN7oPhoXHIuBIH0S+tfK/CXTYX0Lc5aURY=;
 b=AzyVE/UWbuYOclhngJI3C//fWjTvOzq2+SI2YnWoo2DF4q0ThSmJFRd/3pXIcRXvQvPIrbN1FFGiG3C7JsdS79dwX24OCTyJmkC5lpbXs5b7kBWs4PDwoyGPIAW0sBqCdcI4YJrzAfiWEpQ2HLlMt5JCZL2nQB3yS3PD/dZi0hqGorYqPL6LZKCpJk/a9m3fTVyc0ohAu2Kv5OSUqcRWZjE1an4J8FB87DNik4eEhZiAooPSH6yGc8eNoNnQQZAX5s/T/CugcOXSahoF0fE5+mUv9NlkscdmVjX5iWMUGPlqbkzlQ+72LwkeqDAwL8EXoFWU5Dagd3s7CkrrYWe0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFYnpfU0mEN7oPhoXHIuBIH0S+tfK/CXTYX0Lc5aURY=;
 b=MarrfT4OQhhjSN9eJr/Aq9aSvEJC2c8D8vSmgCa+25HuyFDl/J4Aj92D+pu5Mfj14duBNWpPD0PPs/OtSMaH9Q61BJ6MXuN00q2UCbZm61w5AWWIkVirDH8u689/jN7ZfgzjWKED+rzIuQU4c+3CUeBtmtG41DFVXSx7dWrKAV0I2Rg4xCrbikrSaLn6wsooDodClXdMq3CiwMJB8A1KfIER4oSd64xOJ5IIVO9A6BDlHDs09FsDsgubH4zqGFHG0LoLwblAHPcFjOrvMcgBiqvzTxSP5vnPpu7/9kzVWAgn7hGn3jitegRT14R+vUMLFgkH+PVErhiVK2Qj4unXSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 00:24:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 00:24:24 +0000
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
Subject: [PATCH 02/16] RDMA: Consolidate patterns with offsetof() to ib_copy_validate_udata_in()
Date: Wed, 11 Mar 2026 21:24:09 -0300
Message-ID: <2-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:335::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: b80168b8-24dc-4c7f-62ea-08de7fcdb690
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ccPJ45qAjuAHNSCUD/cLZczVyID+TfGhE0XI69/ukCu2jPbB+2BFpJ+eJldBMUiBEFunsfxJhql3t8A70m38PoYEdw03tFpYtY4XhsvW+QUsEQ7BNS/eEkeM5w4PBdd0muoctVG+yLaerrDAyNnwaHKEimIcHfdljxtGBAPdSWwooKcdusllJkSgoPTuAadoc+T+IFPBcI4Pw/bhRE7dlJCzckUtm/YR6SJ5mFT8rO2WGxJqy2ty0YLVdMmFO60ulWiQrqq+h0rzsECrGyxg8RFWl5nyszoQhf8C+diFr7B8+rLEeKONiavFRnrSVfQZs5epCXd7lqxyehLSdZ39FIQddAHP8wE/D47KLBF1m6DB7clAUFMg3i+5awaRJOM3V6y5ubup0NG+sGZ0X9VmdfF8aRbReMtJevVqnj66KlyDJqXhUyHMPiDVrbmq2l5KJi6a7vCaQYGqMyLFLyO8ilkH15alXu1NQuuFybFL3zqI/OOzB0Hu/OZzEMVcb5IzY1bQalo98ydlIauCtzksEE8+hSFhuPcITREt3b8xZLrzi49ILu7KKxHBRb7RRzPzaWa/a55Bor9k5/4l2hsMwIm9SrpEuVyDV9onvOXkdcoAXTofhM2FePD9lHvVIezLd6v8JS73J1MB8v+bFMc8PB2HbyBeS2LYYmrc2FKFDNtzzEcmHXzGuPlD8lxyarZ3WQSciFv+ysilLAejNJUqmfZ0a+tV1bU7p5ty0AXVkjVJC/wJrgh4c/VyiE5+q29gmTxKkMVp/WiVOS4SyqfRdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q/5mVWoQ1H7SynINGsZkAhUp9OC722hp+KtaxJfTsbSOLwB3Zat4pOu7HAU0?=
 =?us-ascii?Q?8DUqppsiv0/SgbfwpzHC8I8sAQu7OZFDDNKdBFlD6EPIsrVwAe7ZFnO5xvL4?=
 =?us-ascii?Q?YSrgpBCAvEexmz5AAXwiQ9UZw2NyTZp2QOYx8SLUzuhByrjLX3oSwe8b809j?=
 =?us-ascii?Q?XiJqANbVKhVxtPddOZrbJmB7rtS14Fmvv6fcNbeP2+3rNiB04ErWOUKaeWI5?=
 =?us-ascii?Q?cIAJLKobAfx8ji+kNRIFNdvurWbqkhW3jpnBGxwRsGJp0Cf1eGsF7p/3uzYz?=
 =?us-ascii?Q?4ITVRXaCGfDWLsVd/aqimv+5qXS6pMYmYfkB1ZFWht5Dv9ByQnejBw9z3z/v?=
 =?us-ascii?Q?Rb+yuFVC6YEpa2FS9T+n10nVfFUu9Tz0n6Xu0Vmw3hYV7qEO0BqvxSkwxGGf?=
 =?us-ascii?Q?gtweKrQGltwWu/qL/BphXMHKidh3puI0QpJVvubB7Vz8dhL79CMPqoYiQYL8?=
 =?us-ascii?Q?I4U9acDbCdW+CqjlxLAw+x/KWqg0OhNaIo3SWIRhrngN+7D62WB6bYlWRSbv?=
 =?us-ascii?Q?orj1k6Y+DOgT5DYYcWY3TrndO5/uhcZWyqsz4I7JNS7BQxxcMSVov1Ed4bu/?=
 =?us-ascii?Q?M12b7gh5N/EdDK/qkZkIQ4QaYG9DzctzCRZD6kggjowDR6u6sw7r89Mnwf+W?=
 =?us-ascii?Q?2CjnprC5YvGgMIqNv2JKjsk6UrA1S0U/FgZz1Dzt9No3eCtLX9wTHky3h8BR?=
 =?us-ascii?Q?XGevJVJMhrFtDM3Cjd47yEa6LzQ7CiH0/le/2BvuDQvK3UNtgJhjrJfsmOhB?=
 =?us-ascii?Q?UCsBj0U/ACGnIzczp93g+g5JaKBWqD/vY26LuKu6IV43PUNDUSc6DoBjwLEJ?=
 =?us-ascii?Q?dCjoS6Bw42Xy6zirLxq7II3FgEDUOowLIMaaLUFj7ZWicM7DLc6zeNUb3dFw?=
 =?us-ascii?Q?MK4Yr/KBTZvRxN17SfRHXajKBrCoYbCgaZYy27CHVKABaKxbgps2Rug5vefY?=
 =?us-ascii?Q?7Lwi+EzTRb/a7IYDvHOwUwHiOhAWnKsd/7UyPCmd++Rus5rxDBVxYLAC7SD5?=
 =?us-ascii?Q?epVcR5wQeHRIyquVwag3caUQGuHqNk/pLbnQOp8FZhWg08GhmoKCkLXKdgtG?=
 =?us-ascii?Q?tt/bgvtWiMI+TsDCrNFQWfNNXoLE9+Ymta20Dv8A60c3fFDvtiSLHcY3wYqi?=
 =?us-ascii?Q?8eijbE97xHS18R6npUtYlMMF56CXjvCUv/wrK6s2p1mQdcTJo5lbwAdSlmc+?=
 =?us-ascii?Q?Fqr+eYpn2Aarj++DiPGuqM72Mk6COMvI7sXqBrVEzDnYEYYolf3Jf2u6LFML?=
 =?us-ascii?Q?cqDV76jVldDtsRcWEgU3faS3oci4YVBOFv0h4n0CneLJefVmrQcCE3v9fV+L?=
 =?us-ascii?Q?fGHcQM+3GhHxEdY7W3Gyo48T2olYqt1+VpcTYhRu+f5Y1SwHWQknCR2C3iT/?=
 =?us-ascii?Q?hYi+KiE31Blgf4jhB+xWGoIcC8d5YOeroTwd6memeGyngepENVu1UbtO6iLM?=
 =?us-ascii?Q?l16/1E1ykRTjfrNFUAoUJATZg3Cffjqb1Yf+JWPTgUCq5X83Y8VzfNyDMoVl?=
 =?us-ascii?Q?bdjQsg25nn4cUA2AMYgwang1T4KXT/V7m0jE7xLUIo0mqlQl+i0g7xmi6N38?=
 =?us-ascii?Q?a2enNry9XoqIaPZcfM3bF59J0qlamtNwcZc0RX8mCOkKiSZAJsKUOwaLcobp?=
 =?us-ascii?Q?lLpceKcCp6OGz32OeRm+JqiPYZalRleTknL5MrtJrmczjlXuycTn9HP2sgGn?=
 =?us-ascii?Q?+X+IBLsPjG77BtNmbUHkKkWwOy4XN7EyF0p6u8/B6cEAV7xkpMLxgK3igxey?=
 =?us-ascii?Q?oMGonLFeBg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80168b8-24dc-4c7f-62ea-08de7fcdb690
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:24.3574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTSzD0SmG7rNqqBdUaq8qnmhbz4eopVMi8mFxsABX2USejO2mP2DWhM0HaH2IzSG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9329-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 977DF26B988
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to the prior patch, these patterns are open coding an
offsetofend(). The use of offsetof() targets the prior field as the
last field in the struct.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mana/cq.c |  9 ++-------
 drivers/infiniband/hw/mlx5/cq.c | 10 +++-------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index b2749f971cd0af..3f932ef6e5fff6 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -27,14 +27,9 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	is_rnic_cq = mana_ib_is_rnic(mdev);
 
 	if (udata) {
-		if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
-			return -EINVAL;
-
-		err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
-		if (err) {
-			ibdev_dbg(ibdev, "Failed to copy from udata for create cq, %d\n", err);
+		err = ib_copy_validate_udata_in(udata, ucmd, buf_addr);
+		if (err)
 			return err;
-		}
 
 		if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) ||
 		    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 43a7b5ca49dcc9..643b3b7d387834 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -723,7 +723,6 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	struct mlx5_ib_create_cq ucmd = {};
 	unsigned long page_size;
 	unsigned int page_offset_quantized;
-	size_t ucmdlen;
 	__be64 *pas;
 	int ncont;
 	void *cqc;
@@ -731,12 +730,9 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	struct mlx5_ib_ucontext *context = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
 
-	ucmdlen = min(udata->inlen, sizeof(ucmd));
-	if (ucmdlen < offsetof(struct mlx5_ib_create_cq, flags))
-		return -EINVAL;
-
-	if (ib_copy_from_udata(&ucmd, udata, ucmdlen))
-		return -EFAULT;
+	err = ib_copy_validate_udata_in(udata, ucmd, cqe_comp_res_format);
+	if (err)
+		return err;
 
 	if ((ucmd.flags & ~(MLX5_IB_CREATE_CQ_FLAGS_CQE_128B_PAD |
 			    MLX5_IB_CREATE_CQ_FLAGS_UAR_PAGE_INDEX |
-- 
2.43.0


