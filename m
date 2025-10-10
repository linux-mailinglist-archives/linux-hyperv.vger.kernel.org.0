Return-Path: <linux-hyperv+bounces-7187-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45A5BCEB84
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Oct 2025 00:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C2C19A2123
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 22:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9007F2741DA;
	Fri, 10 Oct 2025 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SU6NncJY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322FD1A9FAE;
	Fri, 10 Oct 2025 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136560; cv=none; b=nwA7js6DiIrUNYKcMkhq03tHZQnx5RgKKwzci3PL0QNZh+uqiXDHMW2MiyqV/+mmQjfyf7btVsF9CHMITTKuXp1xC/9BlYy6/4JpDLgHOOoq/JREPy3gCk+/APxiKDHtwUuwcx+UMrtfvBkYX/AuBa9+gj1lRDnPxnDH5i5697s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136560; c=relaxed/simple;
	bh=KozNHQmcVtSIEx78QGhSVjYy5z6nU4lTLrUBt1tKWAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+lwy16WBnieLmzEOy92ZizcWCKJ2wdH4vwBtierBx8FuJyTBWuJD9ETcMN0E+bPiLwooEIOp4tawr7wppjowNRvxOdqt+9osEzdjZe61QQjOZHxJQyywUr5ngTy7lkNAIr4GBs09RyYdS4wYIw2/7hU6KXNT2rcFpXTuUXSRJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SU6NncJY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.97.55] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5DE0C2016017;
	Fri, 10 Oct 2025 15:49:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5DE0C2016017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760136558;
	bh=Lr94m1t+PlhRmS7fSVeu+YEHZpe7zKNJpQBqn2CbDP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SU6NncJYDl+WHm71P0Bj0UawabwaRRQgT7jSvDi/0rgE+EHWr/4lSa9Zq2HtDVdOR
	 zyXmLcIRNZLwDLDyWHJaCDYgu+LDMxGCQUqjdeHfqQ95zVPxRuQoRXPls9BeikEGs6
	 g8M0Oc+CCa+px8OEhaokA6d9OEQFoEYF3qO3lwrc=
Message-ID: <fa14e8f8-fe92-4636-9565-a6174edcea71@linux.microsoft.com>
Date: Fri, 10 Oct 2025 15:49:17 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Drivers: hv: Resolve ambiguity in hypervisor version
 log
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <175996340003.108050.17652201410306711595.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <175996340003.108050.17652201410306711595.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/2025 3:43 PM, Stanislav Kinsburskii wrote:
> Update the log message in hv_common_init to explicitly state that the
> reported version is for the Microsoft Hypervisor, not the host OS.
> 
> Previously, this message was accurate for guests running on Windows
> hosts, where the host and hypervisor versions matched. With support for
> Linux hosts running the Hyper-V hypervisor, the host OS and hypervisor
> versions may differ.
> 
> This change avoids confusion by making it clear that the version refers to
> the Microsoft Hypervisor regardless of the host operating system.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index e109a620c83fc..0289ee4ed5ebf 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -315,9 +315,9 @@ int __init hv_common_init(void)
>  	int i;
>  	union hv_hypervisor_version_info version;
>  
> -	/* Get information about the Hyper-V host version */
> +	/* Get information about the Microsoft Hypervisor version */
>  	if (!hv_get_hypervisor_version(&version))
> -		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> +		pr_info("Hyper-V: Hypervisor Build %d.%d.%d.%d-%d-%d\n",
>  			version.major_version, version.minor_version,
>  			version.build_number, version.service_number,
>  			version.service_pack, version.service_branch);
> 
> 

Looks like a good idea.

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

