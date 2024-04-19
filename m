Return-Path: <linux-hyperv+bounces-2005-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAEB8AB169
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 17:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644C8285319
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8B22B2D7;
	Fri, 19 Apr 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a0Ypl7g1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5712F38D;
	Fri, 19 Apr 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539540; cv=fail; b=GeyfoJXLcKTv6o6vUjGiKJ8xCD7uhV3/LMWKpLyJVc5g4o3+/lTKMdMOA1FJ7mO4V7TmtSvky3zD5NWjQ1xhGNyY73DX+S6qxA/Xg9t1HVfQWcfNKKZMeCrBvgcbjy32SF8NSxk1EQ1yOLoN1WmSNW5xw+VFn7LYZY6KSacv7sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539540; c=relaxed/simple;
	bh=ZmAMmuwHqkJa/N3+RfO/Y+gc/w1LSanjyFkGnUspK4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VzqaID8Gs/oJBoF3g4NDhJOWI6/WSkKviTxfYv+r5bqxNNhSsqNAslKbACQILFzBNY9IMvliscVhhy+AqbVbz22Vw5qB+Svkb2cDjN0fy5Bf2AykJYvczOu69+fnxkWee+/VkzJpr5zHOYsFzIsNyefYyntOQbAJAHqJS24A7Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=a0Ypl7g1; arc=fail smtp.client-ip=40.107.7.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3IdMo/n3XLBHRDD6IU01JNv0e2Ske+oXz9VlxAXp/wZ8Nh4bPR56G2A8VrMLQnDMnlxUw4m4o4pCiX4gGnBVrZlvsLkokGoWdy9t1oKFvG4+xi/7CXXlbYWz1MsRgDbSP/RHTcA9H9hMR0xim6ecNtwl21WPDlbMqaU0fkF6q/CxyDoamoe1yhq8uGEgtsxBwHQZKmFsHfPbfkQwqudmAUYmQP0x0U5OJGpXhYKr7nWBuLx+GEyjQYcW9WiFOWz1Pg46hUpsS3QWPqrNdBskVFo6THlG4kOGx/x/1iT9TB94oAhOgz49P/LUe9wGZ+Dds7PNcqlsCSeOTamzFm7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PK+lL+E0BQKSAbqzmXxPO9CqNmmXKuWkBv9uFDTvWEQ=;
 b=kwNnFT7eggwKFxRFojapG7Gjm0s6PpAXYaqI/+f1ik7nu9/hG3Z4SbE/p9EYRLyhHdAK2bxwJHWfRODXMkvpi9yL+BCLn47JLYhnjJ128tXtT7oaWdrHseQXgC3lBAonly4LKl+pLFUITcbhrX7RgxtN8m+mfAglvol5zohJZ2jIKELsZ+y9TN0SrGnZ8e0ZCA+5+HJLnfHWn5dRnoQkEbPCWWRdYuTerpD+En82WoPNLN313DfRv20FlHWDW+VfZ1dcGTDZKONHusKRgSvxeL3SoiGuomoifL/Z+XqKWonVHWjuKTQzKJuMqO7l2K67vJDo4apOK4BiX/To61vs3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PK+lL+E0BQKSAbqzmXxPO9CqNmmXKuWkBv9uFDTvWEQ=;
 b=a0Ypl7g10PjlAdocqWwr6rA3b+40J2LzhqR3wdop3ZbcP1ZUZisEzfFJcE6bW1i71ijt1cNjJ/x9wNqLG9nVtF+1fv9MCuM5PCp4nVcR1I1dknLFqHns1ZbZVU6qEd8jsRCTcpuGnZ/Xea7fTWhsTGAVDfWaY2vwvI3hN7w10cI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8210.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 15:12:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 15:12:16 +0000
Date: Fri, 19 Apr 2024 11:12:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: bhelgaas@google.com, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, Boqun.Feng@microsoft.com,
	sunilmut@microsoft.com, ssengar@microsoft.com
Subject: Re: [PATCH] PCI: Add a mutex to protect the global list
 pci_domain_busn_res_list
Message-ID: <ZiKJxz/vtn5/kBT8@lizhi-Precision-Tower-5810>
References: <20240419015302.13871-1-decui@microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419015302.13871-1-decui@microsoft.com>
X-ClientProxiedBy: BY3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:254::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c72167-0def-4f6c-62d9-08dc60831952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cAkvZp8C59hZXtMHVHrAGKBMPsSx/ctKoeK8gpkg0SJZFlkqOKb5tMtWjGKAzcBt7A5g5u0zdKH62qFubcQXUDF4VJlZfLnT4KQSL6+ebBQ8PLHLVqh+ovAqYRZDF6QXNXcQ0hl3s2znnMj3ypHGezQ166UgJWDE4GSCGxZl+jvGw+ef/bey5hv0FB2NmBP4WiEA/KUbRZTTnVIP5zhNlwub3jR6AqmpFc09+9Pd52Dk2g7QmSbEBwAyh9WL6B/CF/XVseG5I4Stxzgf0H6fTJHVxueIEQ9zaURutgYkEAj3x4B8NHzVjVcsEiPYao5v5gXI2DxCUFgHkCgzgVmjCYU7KY2RuVJ3x8HFXYE1TyNzODsZyAP/Zb18gvlu75/vv5WJwvcYx3HFFDADrz7teTebgnoRLev9hSZsljpzPCDBFe1OR9sgYDjeKN+e7oLWqGoLQzi3joYWrxU8VBeash+iLBKHZWmrd0s9MbgyKf3e+cgI+M+AQTcXies1WKSnqsaHt7bozU/kAKvqrbssIqfMdv/8WEMW4EqVZ3g54Hmpk3ZiSaON8Oj8IaUnef9tbMtLQijfYEL9wjCmARK7IlEUamvWZDB1/Kf2vKY8erCNaJhRbpOyguhZrOWd6LcKesKaml4iQPJZd34dOHuyQjbLZ/lqGDTr0ky2rkovHzUt5Hq7n/H+RWaoMFLOHN2rF468al1KBZb/qZxfdCnCI16mQ9z1nZNZiWVkli4Ny1g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BhhL7iypL8H4Giee47ZlI9BKO8zwhL4TNX0JnHlmIMaJR8npEUm4ZN+60Zvx?=
 =?us-ascii?Q?pr4lVX3i/WVaKtC4N+epHbsrTgZ/RF0n8EzWG//h4jxHbobOEeB6iwahCrPa?=
 =?us-ascii?Q?2Ufl8UYkddm2SPFkQ1g9oh0HllP5QAt3AhTaIBrbQaghtK5shiE3vOOjXZT+?=
 =?us-ascii?Q?+pE25F8F0tlt2VeBmf72N0WPS+m/zWnSNB4EgrdDXzMYAAh4yLA7Z/KB1rls?=
 =?us-ascii?Q?ZYPBNySGgffnvepzhjz2eh4D0PTtzPTD+hchw+S1So7yav3UCZkYeje4GTXr?=
 =?us-ascii?Q?0r6sg2pHyH4CNwQ+t2J63iGqjl4hwcnPi7JSJr9G+1zz542lZvXJuuj365uy?=
 =?us-ascii?Q?mY0IxJbs2ElUMm62BPSxjdAQeLx4anV/Ny+EToku9pO3PSBitJXirkV2u9J9?=
 =?us-ascii?Q?hKu3dGk1wG8kElVxDfmvx6OT93fcvBQKNbcVmBugFNtnbPaC4pIp1YPxRH/L?=
 =?us-ascii?Q?f0tAc8I5RIFmlP1yzTuH5rOJroS9Tg5NBIuhBHR9/qMAevGSyev0dycvZWSA?=
 =?us-ascii?Q?7H8PCfICUhtsrQSC1basdqNQPVfqYQCF/qH/iyDL2e0Tcr6MAROm8wJjMom2?=
 =?us-ascii?Q?kz5mxvKan2+YQ4ftoYn8J2c2SKlIHBXbgFg0QZSjK0G5+6y0U6MdzwL5Owvu?=
 =?us-ascii?Q?Lx1RKpUZx5/gMXnx6guTD0lM860G2Z3g1J99+R6FPkXI81viXXAs/bAxavWY?=
 =?us-ascii?Q?99s/Z3yoMvkJU8/VA8TjsvSdmDhRFuO8s0VL8RAGXvgpdIZpuVSRsxOrW/1d?=
 =?us-ascii?Q?Q5Wfhz3c/RcglNwyYjK4WZBnRLZL4UfYE9/KpWmTluoo1ASVXq7o5wP081a8?=
 =?us-ascii?Q?h8BT2OUhxG9yPZ5ZdvymCIS6kvwwiMffY+CjUjw/BWrRkzxiZWcdVBrshggF?=
 =?us-ascii?Q?KE8NSWLWOW92xOAVTjUPoiW2nx5juTIWXRLCxadfwWEhpzPPGJf1flstfpV7?=
 =?us-ascii?Q?rrOQFIvxEbfeMHT4TOy9q4Nr8l/l3zryI/9rSk3RdQkivH0SLBOvJuCBHdKS?=
 =?us-ascii?Q?juvL5j9IbLlrIv2NqeFH5NbYu2T6YYCgCEOqlj+R5GZX4qlkx5pJUJBRf0eO?=
 =?us-ascii?Q?eBF6HmDV9b6hQDm5yqzDs0KABnevvk1raXnGNe+T586GqzGbfsipxTdDnt6u?=
 =?us-ascii?Q?hrieICubVbmHZfGkbDI17RWrp1k3zB7uDJ4ZrEblKMNdq0xbpgrE9BNWlqYt?=
 =?us-ascii?Q?TCXmSAoYQ+9CuF6eB25xZnNoW1BVCVTCJ+xbpr2582MI64/80EzEx8Scchtd?=
 =?us-ascii?Q?m08asBWZHtiQGe+0DGJ/GGL9ZN5IYxeeZmxs5CLQscbCBPAF7yUTn2U+1abi?=
 =?us-ascii?Q?hQCPZBOquZc953GnMQagNAelsJQZGm5e8WHeUZAetHM5lX6wzpAOYEb2xE0y?=
 =?us-ascii?Q?Rado62R6DTdpg+mkukhqSQ3yvV4x0/ERqPwJhSBeGDMccsogIr7wTbFf/pXj?=
 =?us-ascii?Q?6ys6f89U4a3NFA1gAE3URrk7wGolbWhBZ4zBYg0emRWBIL/A3dvzbeIiUDtw?=
 =?us-ascii?Q?+FLKEwiuX1nHGNuksze9k3yQ7sMV8maaln8+PeOsaxGV9Ki+ilJeSgKODEF/?=
 =?us-ascii?Q?1HKyV+bPQArFSDm6aiBQJRqE8Wi4vyhVVoqJscgN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c72167-0def-4f6c-62d9-08dc60831952
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 15:12:16.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HS4rMV2I2+00g3ErlwdHZ6CmQLZNWyg7Xp+512n+cXEU1ICPCG8ilGepx7ny/BG5P08/SYfoWJYO87dp+C36Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8210

On Thu, Apr 18, 2024 at 06:53:02PM -0700, Dexuan Cui wrote:
> There has been an effort to make the pci-hyperv driver support
> async-probing to reduce the boot time. With async-probing, multiple
> kernel threads can be running hv_pci_probe() -> create_root_hv_pci_bus() ->
> pci_scan_root_bus_bridge() -> pci_bus_insert_busn_res() at the same time to
> update the global list, causing list corruption.
> 
> Add a mutex to protect the list.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/pci/probe.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e19b79821dd6..1327fd820b24 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -37,6 +37,7 @@ LIST_HEAD(pci_root_buses);
>  EXPORT_SYMBOL(pci_root_buses);
>  
>  static LIST_HEAD(pci_domain_busn_res_list);
> +static DEFINE_MUTEX(pci_domain_busn_res_list_lock);
>  
>  struct pci_domain_busn_res {
>  	struct list_head list;
> @@ -47,14 +48,22 @@ struct pci_domain_busn_res {
>  static struct resource *get_pci_domain_busn_res(int domain_nr)
>  {
>  	struct pci_domain_busn_res *r;
> +	struct resource *ret;
>  
> -	list_for_each_entry(r, &pci_domain_busn_res_list, list)
> -		if (r->domain_nr == domain_nr)
> -			return &r->res;
> +	mutex_lock(&pci_domain_busn_res_list_lock);

Using
	guard(mutex)(&pci_domain_busn_res_list_lock);

to simple logic, especially there are goto.

You can avoid goto out, direct return NULL;

Frank

> +
> +	list_for_each_entry(r, &pci_domain_busn_res_list, list) {
> +		if (r->domain_nr == domain_nr) {
> +			ret = &r->res;
> +			goto out;
> +		}
> +	}
>  
>  	r = kzalloc(sizeof(*r), GFP_KERNEL);
> -	if (!r)
> -		return NULL;
> +	if (!r) {
> +		ret = NULL;
> +		goto out;
> +	}
>  
>  	r->domain_nr = domain_nr;
>  	r->res.start = 0;
> @@ -62,8 +71,10 @@ static struct resource *get_pci_domain_busn_res(int domain_nr)
>  	r->res.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED;
>  
>  	list_add_tail(&r->list, &pci_domain_busn_res_list);
> -
> -	return &r->res;
> +	ret = &r->res;
> +out:
> +	mutex_unlock(&pci_domain_busn_res_list_lock);
> +	return ret;
>  }
>  
>  /*
> -- 
> 2.25.1
> 

