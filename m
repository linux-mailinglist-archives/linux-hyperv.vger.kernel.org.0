Return-Path: <linux-hyperv+bounces-6830-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7B4B53955
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Sep 2025 18:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9557C1CC1390
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Sep 2025 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C5034F476;
	Thu, 11 Sep 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QApgHUqG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEC52206A9;
	Thu, 11 Sep 2025 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608344; cv=none; b=aTFf+44tnZhYGcTkvLqCWqyuBDPTNwboL5ZAqqsEFMSxKRW66E0Nyi6tNV7mT9EnFIABSv7xLYSxnd6b8+PnBXBey1QSGAC2lIWV7c2alRdyfRSTx1J3eBgUyBpb8YVHXdPMMBg+7bFeB5CqS6bEmFZKVMb/ohfWj859DFgXsFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608344; c=relaxed/simple;
	bh=dZHgZET/8GdGlN2B9SdbZ+XTZei61ON+Bqa3rdyCJvU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jtnmn6FvKR96rkc5UFMQE2CElvh2zQO8mtYj2HEwU046wN7kW+HX68Onuqui4RJurd6N+0J2yIobLelQr9MecxRZc2npC+xG0bR2aU6Up/K27cnXdNoihj3n0iOQEimp+ndZoApeivBVLb+3zIX/1O1/UmywqcIGRcBSJUV5/YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QApgHUqG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.208.243] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 68ED3211AD2D;
	Thu, 11 Sep 2025 09:32:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68ED3211AD2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757608341;
	bh=qvUkHzkabadC/5qk4RNeeGt/v4rSfmg7bosK1CGdTPk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QApgHUqGfbY0OZnmlKMEfjs19MoqxbR7RgDRdQmhn6e9kOvvf6wlJgwI/DfYAmZYC
	 zEAVp+hTlnV0C+tbzK3DFl1kxb73/oKgixWA9EhaDSuYQqrmknGSULrQwGe+4s2PLT
	 JN0wWI1Z4uFuvJr0ox2jI0AEk8u+n8Y5Ya76rEt0=
Message-ID: <949318ba-7623-42d2-90fd-0664915d994c@linux.microsoft.com>
Date: Thu, 11 Sep 2025 09:32:20 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 prapal@linux.microsoft.com, tiala@microsoft.com, anirudh@anirudhrb.com,
 paekkaladevi@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, Jinank Jain <jinankjain@linux.microsoft.com>
Subject: Re: [PATCH v2 5/5] mshv: Introduce new hypercall to map stats page
 for L1VH partitions
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1757546089-2002-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1757546089-2002-6-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1757546089-2002-6-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/2025 4:14 PM, Nuno Das Neves wrote:
> From: Jinank Jain <jinankjain@linux.microsoft.com>
> 
> Introduce HVCALL_MAP_STATS_PAGE2 which provides a map location (GPFN)
> to map the stats to. This hypercall is required for L1VH partitions,
> depending on the hypervisor version. This uses the same check as the
> state page map location; mshv_use_overlay_gpfn().
> 
> Add mshv_map_vp_state_page() helpers to use this new hypercall or the
> old one depending on availability.
> 
> For unmapping, the original HVCALL_UNMAP_STATS_PAGE works for both
> cases.
> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         | 10 ++--
>  drivers/hv/mshv_root_hv_call.c | 89 ++++++++++++++++++++++++++++++++--
>  drivers/hv/mshv_root_main.c    | 25 ++++++----
>  include/hyperv/hvgdk_mini.h    |  1 +
>  include/hyperv/hvhdk_mini.h    |  7 +++
>  5 files changed, 112 insertions(+), 20 deletions(-)
> 
<snip>

> @@ -849,10 +850,13 @@ static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
>  	};
>  
>  	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
> +
> +	if (stats_pages[HV_STATS_AREA_PARENT] == stats_pages[HV_STATS_AREA_SELF])
> +		return;

Nit, without patch 2, this hunk is a no-op. Despite that, looks good to me.

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

>  
>  	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
>  }

<snip>

