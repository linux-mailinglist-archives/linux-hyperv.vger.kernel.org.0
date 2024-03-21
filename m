Return-Path: <linux-hyperv+bounces-1805-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F18856F1
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 10:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A072843D8
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57D456763;
	Thu, 21 Mar 2024 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GerhZQyR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBE056751;
	Thu, 21 Mar 2024 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711015030; cv=none; b=jEdBvjx3PGIVHUUdoJnFTRWUDR7EgqXjWShWCqDpWMKOFg06STfjuaRZ9gvOjrqJlr7BIZytvNWgwmhF73TqzzBrLkdjk0euzk5P/xR/525zuHiWUYgTUifkmCDcCoSg9fRZwH8zDtXb4b7046oOQFbHKoFdJuyHz9SPp12yJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711015030; c=relaxed/simple;
	bh=pr4bu4hrum6QzMyB5aq8RzvHZL2lVn3VJToFXS9K5Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arOTiO7yM2CqJbsMHcy04NonAk2ZhnQWm4o2DScyTsF3sMRJ57jw4Y0HU8T+nAhnSftcgOz4qa23KgIoPNzMIuIzHN68dPBh/E7RdwK00pgq+mdb8dGOE4Ygq5b6+kERIlYpd5c98xN0B3KppGS4zmip5lIeT/s/xo0I/uOYlnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GerhZQyR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id C046820B74C1; Thu, 21 Mar 2024 02:57:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C046820B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711015028;
	bh=+WDM6PdXkiphjTLhxt0w3wHZT5FGTdefYnnu6riCUJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GerhZQyRjAYddxCqS09I5RFx62L/Tvx/ooLGmqSrQYuERI9HnU71UgwsNmH9c6wFD
	 9v+jQgMUwAZq2DWMSi+JtaRUJHrZSxjIy1TqPxu/18r4JahMyRItgsXVm4BMFyGm1r
	 L7gLruWZdXwJWIoUSLrby1BwxAKJJwSpe6+2DFLI=
Date: Thu, 21 Mar 2024 02:57:08 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	x86@kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ernis@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Cosmetic changes for hv_apic.c
Message-ID: <20240321095708.GA7962@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1711009325-21894-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711009325-21894-1-git-send-email-ernis@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Mar 21, 2024 at 01:22:05AM -0700, Erni Sri Satya Vennela wrote:
> Fix issues reported by checkpatch.pl script for hv_apic.c file
> - Alignment should match open parenthesis
> - Remove unnecessary parenthesis
> 
> No functional changes intended.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> I'm resending this patch because I have missed some email aliases in my
> previous mail.
> 
>  arch/x86/hyperv/hv_apic.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 5fc45543e955..0569f579338b 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -105,7 +105,7 @@ static bool cpu_is_self(int cpu)
>   * IPI implementation on Hyper-V.
>   */
>  static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
> -		bool exclude_self)
> +			       bool exclude_self)
>  {
>  	struct hv_send_ipi_ex *ipi_arg;
>  	unsigned long flags;
> @@ -132,8 +132,8 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
>  	if (!cpumask_equal(mask, cpu_present_mask) || exclude_self) {
>  		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
>  
> -		nr_bank = cpumask_to_vpset_skip(&(ipi_arg->vp_set), mask,
> -				exclude_self ? cpu_is_self : NULL);
> +		nr_bank = cpumask_to_vpset_skip(&ipi_arg->vp_set, mask,
> +						exclude_self ? cpu_is_self : NULL);
>  
>  		/*
>  		 * 'nr_bank <= 0' means some CPUs in cpumask can't be
> @@ -147,7 +147,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
>  	}
>  
>  	status = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
> -			      ipi_arg, NULL);
> +				     ipi_arg, NULL);
>  
>  ipi_mask_ex_done:
>  	local_irq_restore(flags);
> @@ -155,7 +155,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
>  }
>  
>  static bool __send_ipi_mask(const struct cpumask *mask, int vector,
> -		bool exclude_self)
> +			    bool exclude_self)
>  {
>  	int cur_cpu, vcpu, this_cpu = smp_processor_id();
>  	struct hv_send_ipi ipi_arg;
> @@ -181,7 +181,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
>  			return false;
>  	}
>  
> -	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
> +	if (vector < HV_IPI_LOW_VECTOR || vector > HV_IPI_HIGH_VECTOR)
>  		return false;
>  
>  	/*
> @@ -218,7 +218,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
>  	}
>  
>  	status = hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
> -				     ipi_arg.cpu_mask);
> +					ipi_arg.cpu_mask);
>  	return hv_result_success(status);
>  
>  do_ex_hypercall:
> @@ -241,7 +241,7 @@ static bool __send_ipi_one(int cpu, int vector)
>  			return false;
>  	}
>  
> -	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
> +	if (vector < HV_IPI_LOW_VECTOR || vector > HV_IPI_HIGH_VECTOR)
>  		return false;
>  
>  	if (vp >= 64)
> -- 
> 2.34.1
> 

Thanks for cleaning it up,
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

