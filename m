Return-Path: <linux-hyperv+bounces-9354-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD/wL+mssmkjOwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9354-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 13:09:13 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C431E271713
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 13:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E699C3008633
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309163A6B91;
	Thu, 12 Mar 2026 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HO+VHMqh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECCE3A6B99;
	Thu, 12 Mar 2026 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317346; cv=fail; b=OnlPEbF8S7iVmfTx+z9NWKt6crYuhVNC6SIukqYCjurLCjt/rrcq65m6cbOzi2r0kbczia/iZfE3/JfdZG0O5pLyWX/V2hD//0H/EoH8jo3L1TYGnHbcZknE+KhQ6JNAb/tPU6v3p21O2bRXR8hB2cx8IumO8T5Lll5VWgm09dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317346; c=relaxed/simple;
	bh=MAAhCm8sJlPjG7ncaS/FXA5l3+2BIfbULoFMX//G3Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gQC+B1EZ1PN76drzbQLO8JCrmEsrnKYOc/E9HdYms0oIk6mwMlRlscmYzWhps0c/Oro9rP+OmZUB4WbM9Ry78GKTFM2l9Sf2eTkHtR/tZ3rZ8JuixggnG34imFR7DWpQMv6TsUtyKc3uCeqDTslc47IZ77yX05AeMGiDYka4FcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HO+VHMqh; arc=fail smtp.client-ip=52.101.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+xb3VaUQysI9v+bypdmrPP80OmVUrFdCCAnPH7PUkmdYdYgBMLhuyOfrrsDdXMbYml29L30dukbBA8rq9waUwHeRhUCw+iCCBEGP8yZwCcMBbfKUjqXyA+HgoxCyqBmcgcFAJPa8uGIExkkbZK4A/zT7YGMWc748G4j9odGdYgW9Shh8QFczwVi5R22TGBqHkCWUX5TfLyTMahNMo7UmZsRQ3hYPRankqbzJL/17/6fym+4bz7rq8PhfX41t97BSFHNpigaRsa6sPmGDL8SWvrpsQg59Zt9JYovbvM37KrYPb70+8sbPNpwVzAZaD6ZDxlCF6ifABOBd+bDhDIcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDpjVhvvhswi2jUxage4aMTI6jcS4mfsK+MVDTdktkI=;
 b=Aw+ftQb9zHL2VSuiDE/HO7bXLRV4rvP2H770mSJ9xIcSq1ugt85yjLvTdiBNwd5FmZRqPuEA0S6S5DW54cNyS3hOV8qXVZ/1x0VP1JpHg69zzy/kMKVzAPUKtBEVVC8wW90GecYPFM5yOB1XTmedEvXGehNc2VZ55W4pi4sEZ7hDuhxPVHqZHWBxIJJd6bmIWAuRU2DmApjWXL7Gd1+iYiCC0wpDnnUQBRnOgRDXMgsk/4wgYmwcFoM22QBPrgKAt0WRHeZHJOznnxTozwgZl/iHZ95ttQ0bwOxCOYMEFfVg+YanlRtBM+U53Oi5wOtWid/Aoc64oaPUBdbLZBLmjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDpjVhvvhswi2jUxage4aMTI6jcS4mfsK+MVDTdktkI=;
 b=HO+VHMqhiLO1mhjC8kMCOp6ltO0uxdmyt9p0BxzAQ8Gzfu5qW1LjCjps9ENBPClEzwzHHlXOdTw0rPNd9aUy+pseNWFwsTu+FV8CpHY5Mjons25dMAlLOE0EL9rsfvUq5hvToKg3spJJiznkwFo5dy2Y9oKln/MJ+B56GfLbJxzBsmjhwlCzcIlTcu/lDj1+K7IUZ0UonDkY5cDXQF1XVR2tAT2mfL3Wv96OQBQw2JlH/e6oPlfekqkFuX8TWaYcTGMkr7mfgKLyVV1HqRBeePMUjNI7vxSqQ1wPMO6SNo4ELEoEnobhDCtIRFUAQatez0fBydFlW2Pg7iKXzWjMtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Thu, 12 Mar
 2026 12:08:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 12:08:59 +0000
Date: Thu, 12 Mar 2026 09:08:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Gal Pressman <gal.pressman@linux.dev>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>,
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
	Zhu Yanjun <zyjzyj2000@gmail.com>, patches@lists.linux.dev
Subject: Re: [PATCH 10/16] RDMA/efa: Use ib_copy_validate_udata_in_cm()
Message-ID: <20260312120858.GH1448102@nvidia.com>
References: <10-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
 <cf3bbf89-0bb1-4c58-b78f-37afdb2ff99c@linux.dev>
 <20260312112020.GE1448102@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312112020.GE1448102@nvidia.com>
X-ClientProxiedBy: MN2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e85926c-e842-4389-25aa-08de80302481
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wTNtHmcKqzjLW4ePszew/wz0AHUmkN4OGlTDrmDIA6MuHfCZSpxSrAUrfKRbx16MIW9LPlkQZmy0e1smuSJYYaRjX24gnB30qO/0EJOZJ26WQkeL8XgdLDMlZIofV/iU7uNdgyLYvvQFd7k1y6bEsVTsKPdcTas5DhjPK0Wj6NWefXThT2T18zPu5nZJ7xr0gaZd4bdWFb0pfzre50+O+kgK0qPTSm5ghqwNgssDA3YNY/e1Hik3mwOL1+xIOkWM5bZJAixKabeI5Z4C9gWpwoVYpYFcaM3jk1CuT7kzl2JLXpLRuBab0qpq3GxWRbDxeNR9lfSf+IM8CopZIA9xR43fplYt7mo3lTMSsrblh0cUYYi42VdcJCn+G+zj6qyGwcOAftCaUNct+NZ9fNBcoVHJnx7mEbdxy7p6iI8IYbqGHjpHLxzHdVmBgxRkbeaXAtAf9xrAXAT8RIqOB7OgqoEtU0bFo5hHcZlTn+78RUj48NxJhg4raOlrEwSB7NYuqZbDkkMU07flKLdlcPQWJ2yX3d6POEFyFWh47EZQQmAkK1z+8U83iq8YnM3V93vn8NDWE63FF7FA33Dg1qqtrriPbP6YF6DpmkoG8ISiP7jybKrh4xdmakjfQGcqfjtAHFSJcTfL9lmxbq6KN3+ehXA6X2lKigVWty7xqQnypXKBAfjcJVTuw5p8vEuDr/OFFtsqMvWzVaqk6FvdlXI1BN1EUBjQ/yq+lVHenHScKK8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fDEcD0br0fbkyUgu68kQGJmB+ubv/5NHfCzieDtIAwYHCD5EL7J5t7UDl14N?=
 =?us-ascii?Q?Ht9eMeGigSYDcTdL6svTzlI9vBEkNpLWjxFolPeTACFlxjvX0kUbpTiuHYjv?=
 =?us-ascii?Q?vU8GPr5jnzKxQXuUGTFp6DM/FcB9iJYNqpvvMYcCC7jcUguYDAoZMEkSrzBB?=
 =?us-ascii?Q?/DW4VpouAonDHfAThxdfIlTiY6e4q2FeekK6Ub2rYxhu0NOlVL2+ZyDbWdHw?=
 =?us-ascii?Q?wKEMs4pAXWBT5N4Zb251N3f6+wZS9VpW7piSdWN9fXnaytyf87WaqDnvr37h?=
 =?us-ascii?Q?vP9Dc35idTMptX3PrWQ6QP8jGCFKrZwBKFLiFjjl6na7qiF0JRXj62hBZ3dR?=
 =?us-ascii?Q?ftmqHB2ORphSsCgk1HJ2a5Wbri5R5V3ojbaPMB4K3b0BN/ysndYlNb/j6TeV?=
 =?us-ascii?Q?bFBeix/l+ysxizj8FQSMccKR8PwvfZf40uKwP4aDmX2x4SMvlOAsQvEXL0ZJ?=
 =?us-ascii?Q?QIz0wsjsgcE0AFiOjCz3eGBpk5DmsvqF+FKIMMpuf5HHCptHHTuKXgsC6AK+?=
 =?us-ascii?Q?2KxzyzFPNHxCHEAavXSkS9arqqZOFwDw0HEGJ4e8UYH21acIrGZDzcKBmJDi?=
 =?us-ascii?Q?/YTfzCinF01vM6863c+66VImIOkttGbcRTvCopmMB7bERa0zABfGkFt3vR1j?=
 =?us-ascii?Q?NY2LwehqWOzrbc53xy+MNfYl8e9iz2dh/nzNrcrzSJ4YkBgc862CJFi5hIft?=
 =?us-ascii?Q?2xxKb6/AKQT33R9ZhXUh1ULFAdvoWhhSZJP2zMxkAhBCm8t/PXXK/EVDXpYe?=
 =?us-ascii?Q?98xhihwI71JQH5CNCTr6dsfPzA7ejuP1SAnt3Zd0Gq3hgazMal/hwhJse1FJ?=
 =?us-ascii?Q?gUbeEOkggW/Ncpd2dPWlQif1osB6k7VnRTZE3NcsPbUTW/GblBVswaQKsf6Q?=
 =?us-ascii?Q?AHgBoSnRU5nHR9VSQb3f+Z9eHysMPOj0Z6UPmjrx5SlVMeiz+l1pXq5x6N++?=
 =?us-ascii?Q?KD2sQsuHEg34QySRGeD5ecgN5UKX1D+0Uy6Dw8pQXX1IlqwELCRzP+zBjaSK?=
 =?us-ascii?Q?lNbYuS3L/NiWtOWU3ahntA6OxtsWerH9jkON969UMjttETWzeYgSB4gc+HRo?=
 =?us-ascii?Q?KEHVFgNuRr4KbjKfd0oCoeXyn9x79OTQOuTmiqmXa5pdWZ2hPVmPErJ0umVT?=
 =?us-ascii?Q?8eaRvG8sjSBdF0NfyDxQgSV+9g5QZmLm+CH0wrHwsqDUJINw7J3EQQRSKJZx?=
 =?us-ascii?Q?3+1x5jDOzK2p8cMtYMU3WUlrg027V5elIamQr5zyOTmTf7KYmQTVY2ViqstQ?=
 =?us-ascii?Q?/bcvZLTQ1fiEB7AXf8Ai8GgrFhjqyGtvzsYj7vWz73c/IT9NLU753Ol8k2BI?=
 =?us-ascii?Q?3KN8wUUTJ8FHDqLXWo9gO72buC0VjEaBesTmlTaMeaerV74bsJC5rjwmbb25?=
 =?us-ascii?Q?qgUcq5APLrdqQ6X/Duk1BLmNIp4hiZjTjpox5Aox6Z1pLt7O61LDHCxhUy8S?=
 =?us-ascii?Q?qNYQhm8HzpCvqFUZ/t6VGNfQM9QYvBEZQfU8H3JRTGAfL/s92uUnFne5H+6I?=
 =?us-ascii?Q?6OlDTnKTto78amyh7Y77jKH2DndVdfGBQ6d4o0/3MQpk1YvyFHOBJLXINjUu?=
 =?us-ascii?Q?MKAr5q3KB9xxWKyDH9ao6LNTCHdSTj+kSd7tv2Zs1MfYSJaBMYsWyjfN9+HJ?=
 =?us-ascii?Q?BdDXuHDMgalPCWW4FHiYtPVJo0VPHNBBrr4n1yi4cqVOjHTrlIf2Va41JzuQ?=
 =?us-ascii?Q?tPMI2VaL5E/ZgMIhchknnFVefjBc11CHQtAyVtvJMiIdhFyLzBLR/qQ3BXcG?=
 =?us-ascii?Q?ZuRrPTliNw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e85926c-e842-4389-25aa-08de80302481
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 12:08:59.4147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pl8Mzt0KFmookClIiCQfXTFGXJg+MxKa6dLA7HKzLZzaT/Ys6SOZ3/5QcchSa0FM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,broadcom.com,linux.dev,linux.alibaba.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,amazon.com,cisco.com,huawei.com,nvidia.com,gmail.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-9354-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C431E271713
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 08:20:20AM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 12, 2026 at 01:03:59PM +0200, Gal Pressman wrote:
> > On 12/03/2026 2:24, Jason Gunthorpe wrote:
> > > Add the missed check for unsupported comp_mask bits.
> > 
> > Is it really missed? IIRC, it's intended.
> > 
> > See the comment above your hunk, and efa_user_comp_handshake()?
> 
> No, that is an illegal way to use a field called comp_mask.
> 
> If the driver wants that it needs a new field "suggested feature flags
> to enable"
> 
> comp_mask is strictly to say that new fields are present and must be
> processed by the kernel, and nothing else.

We could also rename the struct field away from comp_mask ? It is
easier to add a comp_mask later..

Jason

