Return-Path: <linux-hyperv+bounces-6756-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E25DB4637D
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 21:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C891566A9B
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 19:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11C51FF1AD;
	Fri,  5 Sep 2025 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qwkrnSnb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C25315D2E;
	Fri,  5 Sep 2025 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100101; cv=none; b=qYqLDBiXnPyRbeIKKo0c7sGrbVoiAx25tBrNI81gov4ueUfqfJNjmI5R1IhEACrYgU4TTdr3VSeHUeVC6LF2XLhJQvHB8UH9QbcPQYjO/vPzsMpS9Ml6G8QRjR27bz4Cx7WqFUoFUV0QT9pLvQBIq3ml9cb0hwxa7+fB9sm9Fc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100101; c=relaxed/simple;
	bh=HFExsZAjt04o91q55okXg46Lg6g/Gcza/Z0hZ0hCIas=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D6Tuas7jBevfxAKyhkHWMPV7pao8VNtq+vhEHMwAKw3f1MRacIO6EPJdQV3RDtu3W0cjqKYROSiZh7xokwfuQidtpR/kCsZ15sSNwuNblANftvmjAWIfeUH+cmoLzD+IsEfys6PYKXjeGgoSAc3sO4n4tOu8cCzFtI+5lIYE0xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qwkrnSnb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.233.45] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8CF8B20171D4;
	Fri,  5 Sep 2025 12:21:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8CF8B20171D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757100099;
	bh=nRs4iS9p7PuLIEnIetsWg9TgJBFkyB36QaPF2H1O4eI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qwkrnSnbTda7tWd7PI9lZhrh37nyF8CmtmmXvOT/m/N0LmgxWk4k4jnNf7x9jFwB2
	 RU4g9tNWXzkKwrohgYjH2d1C794XeYBOE7ziP5+60vxdy/vvtKgdzNxh4F92Gt2tWZ
	 YYr+Poxw1W9BBrOfYsgjfp9kd1ssA5xE5y/m6HzA=
Message-ID: <efc78065-3556-410a-866f-961a7f1fc1ac@linux.microsoft.com>
Date: Fri, 5 Sep 2025 12:21:30 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
 decui@microsoft.com, paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH 2/6] mshv: Ignore second stats page map result failure
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-3-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1756428230-3599-3-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/2025 5:43 PM, Nuno Das Neves wrote:
> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> 
> Some versions of the hypervisor do not support HV_STATUS_AREA_PARENT and
> return HV_STATUS_INVALID_PARAMETER for the second stats page mapping
> request.
> 
> This results a failure in module init. Instead of failing, gracefully
> fall back to populating stats_pages[HV_STATS_AREA_PARENT] with the
> already-mapped stats_pages[HV_STATS_AREA_SELF].

What's the impact of this graceful fallback? It occurs to me that if a stats
accumulator, in userspace perhaps, expected to get stats from the 2 pages,
it'd get incorrect values.

> 
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_hv_call.c | 43 ++++++++++++++++++++++++++++++----
>  drivers/hv/mshv_root_main.c    |  3 +++
>  2 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index c9c274f29c3c..1c38576a673c 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -724,6 +724,24 @@ hv_call_notify_port_ring_empty(u32 sint_index)
>  	return hv_result_to_errno(status);
>  }
>  
> +static int
> +hv_stats_get_area_type(enum hv_stats_object_type type,

One line please, i.e.

static int hv_stats_get_area_type(...)

<snip>

Thanks,
Easwar (he/him)


