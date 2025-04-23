Return-Path: <linux-hyperv+bounces-5069-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F4FA99728
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 19:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56174A170D
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9519529008D;
	Wed, 23 Apr 2025 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sQ39TYqr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAA2289361;
	Wed, 23 Apr 2025 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430661; cv=none; b=N525c/bXIrd/IwD0+Zqy/dZ0Ab6AFjQzBOpRp84NbgCqesw94j4YkVr3tSpZqurvPoLPGVODoU20sEI1L7ruYBOaYl8rukG8KWpjCU+XtQ2cJfpsxQ28VsUTZn2CaVmBQO+kEqdGAnDM2d9a9dn8Eeb7GStHEg+QZMCoa15bp/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430661; c=relaxed/simple;
	bh=H6tBuwWjiTa3b3mLuTFDXVmLQC0Vman+596WG65RK38=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lryLr/pEcTThbW12QtgkOkFhOnvNRSIXV9ZsLTisQ7Ke91JFSc2Etf2dwCIjWsAC2Zla3iV+q7OzlXvFTlDKI78uePgfotoeEg7zYvEhKWz3u4/8d4y0Q4NYYluLw/cZ1vMyBEN7HJ0WuDaFZ2RSbGdypyIbKEkkQMn/4G3dAF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sQ39TYqr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.161.193] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id BECB4203B87E;
	Wed, 23 Apr 2025 10:50:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BECB4203B87E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745430659;
	bh=f8CH2rF6M32Fr1wA/Z2C1KBnMC6UpjyuKfRuhJo6RnQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=sQ39TYqro8mNxCzgFzTVoLBiOwe6FBjtFYnXnVOYwR+TxOSmN6DKe6bwlGNxehSFK
	 jCUvM4ljgfl3+2bLu20terHXNlptGszeQPOD5W64MZcXi21BueuM3apNfzpBrTEp0W
	 EzZCarIaNhY1Q+dNMRyM61qeYLNebVuuQqazqQgM=
Message-ID: <495d5444-b82e-4ec7-9095-d34f0ac8d40c@linux.microsoft.com>
Date: Wed, 23 Apr 2025 10:50:27 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Drivers: hv: Fix bad ref to hv_synic_eventring_tail
 when CPU goes offline
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, kys@microsoft.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20250421163134.2024-1-mhklinux@outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250421163134.2024-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/2025 9:31 AM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> When a CPU goes offline, hv_common_cpu_die() frees the
> hv_synic_eventring_tail memory for the CPU. But in a normal VM (i.e., not
> running in the root partition) the per-CPU memory has not been allocated,
> resulting in a bad memory reference and oops when computing the argument
> to kfree().
> 
> Fix this by freeing the memory only when running in the root partition.
> 
> Fixes: 04df7ac39943 ("Drivers: hv: Introduce per-cpu event ring tail")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/hv/hv_common.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index b3b11be11650..8967010db86a 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -566,9 +566,11 @@ int hv_common_cpu_die(unsigned int cpu)
>  	 * originally allocated memory is reused in hv_common_cpu_init().
>  	 */
>  
> -	synic_eventring_tail = this_cpu_ptr(hv_synic_eventring_tail);
> -	kfree(*synic_eventring_tail);
> -	*synic_eventring_tail = NULL;
> +	if (hv_root_partition()) {
> +		synic_eventring_tail = this_cpu_ptr(hv_synic_eventring_tail);
> +		kfree(*synic_eventring_tail);
> +		*synic_eventring_tail = NULL;
> +	}
>  
>  	return 0;
>  }

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

