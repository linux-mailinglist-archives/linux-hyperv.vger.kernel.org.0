Return-Path: <linux-hyperv+bounces-1715-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E9878D35
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 03:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18451C21864
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 02:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7879F0;
	Tue, 12 Mar 2024 02:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TI6RKdtH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E6A79C3;
	Tue, 12 Mar 2024 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710212175; cv=none; b=TJ0rKAAx3NldJFWjBGM4udEr2/n5m0GkU7HChYjrCNGPlZF7FeM0iyrmVspFU00sIgsH71t5J3UHIh8Qi3CPWmJ+lreu/Xpna2XNZFHWnPBsijkPUUD8IORhlE6JR1yinVmxeZCK/f70QqfFg49DDpeooMt+Ky+Rxy+7c29uN/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710212175; c=relaxed/simple;
	bh=Byby3dPab9clHdBpqGNxzWvALlnFyqoIXHFndqlr3zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UuNzHOhItCO6TRO7DPrk2NGnfbpirGOLb4NxAXTPhvK9/nN2g012GKjazwmNa9d1P+Jw0al3CXFutj5gnElcnKIAzUtnGsibOc2jjmpMU5TeZuY0+rvkoi5QGVgBzaVEAPMRtLm9D+e+BGSlLTGZbLKTDpA5GYWNHQlJvRWM7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TI6RKdtH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710212173; x=1741748173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Byby3dPab9clHdBpqGNxzWvALlnFyqoIXHFndqlr3zc=;
  b=TI6RKdtHYFAADlZ20p78s6EnKUM1JO1Kdp3ORiB7yW+OCEVBX8CXfey3
   zQ5h5g3nPreCzW6i3VCTGPnzYTHPStdF8M99r1L9V9Ts1qhHSRL7+cwBm
   g6WfLqjvzqDHi92IyKWJNQxJhYWsNSrmU/eyiECLDpB9upN5zYUDA/nqI
   33XYKRhy14ttWWq2kV4gPQOq2HKx7nPghxDaCg6Csf7XXAiZlRcNIlPZJ
   TBl1xAGsX4/LdOEVAZLODzQ9eMi5B1ROzNdRBuPTNyrUE+8/M49lmTCIb
   DldAwBqLg/e0d8b7sAoDT0Lq6Tb6OTKYkVvBnCnrR42ItXjlRq5xuqV/S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4762026"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="4762026"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 19:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="11478107"
Received: from sbrowne-mobl.amr.corp.intel.com (HELO [10.209.68.239]) ([10.209.68.239])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 19:56:11 -0700
Message-ID: <d861ff54-e3db-4beb-999b-05e60c99945d@linux.intel.com>
Date: Mon, 11 Mar 2024 19:56:10 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] Drivers: hv: vmbus: Leak pages if
 set_memory_encrypted() fails
Content-Language: en-US
To: mhklinux@outlook.com, rick.p.edgecombe@intel.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 gregkh@linuxfoundation.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kirill.shutemov@linux.intel.com,
 dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-coco@lists.linux.dev
Cc: elena.reshetova@intel.com
References: <20240311161558.1310-1-mhklinux@outlook.com>
 <20240311161558.1310-2-mhklinux@outlook.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240311161558.1310-2-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/11/24 9:15 AM, mhkelley58@gmail.com wrote:
> From: Rick Edgecombe <rick.p.edgecombe@intel.com>
>
> In CoCo VMs it is possible for the untrusted host to cause
> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to
> take care to handle these errors to avoid returning decrypted (shared)
> memory to the page allocator, which could lead to functional or security
> issues.
>
> VMBus code could free decrypted pages if set_memory_encrypted()/decrypted()
> fails. Leak the pages if this happens.
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
LGTM

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>  drivers/hv/connection.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 3cabeeabb1ca..f001ae880e1d 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -237,8 +237,17 @@ int vmbus_connect(void)
>  				vmbus_connection.monitor_pages[0], 1);
>  	ret |= set_memory_decrypted((unsigned long)
>  				vmbus_connection.monitor_pages[1], 1);
> -	if (ret)
> +	if (ret) {
> +		/*
> +		 * If set_memory_decrypted() fails, the encryption state
> +		 * of the memory is unknown. So leak the memory instead
> +		 * of risking returning decrypted memory to the free list.
> +		 * For simplicity, always handle both pages the same.
> +		 */
> +		vmbus_connection.monitor_pages[0] = NULL;
> +		vmbus_connection.monitor_pages[1] = NULL;
>  		goto cleanup;
> +	}
>  
>  	/*
>  	 * Set_memory_decrypted() will change the memory contents if
> @@ -337,13 +346,19 @@ void vmbus_disconnect(void)
>  		vmbus_connection.int_page = NULL;
>  	}
>  
> -	set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[0], 1);
> -	set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[1], 1);
> +	if (vmbus_connection.monitor_pages[0]) {
> +		if (!set_memory_encrypted(
> +			(unsigned long)vmbus_connection.monitor_pages[0], 1))
> +			hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
> +		vmbus_connection.monitor_pages[0] = NULL;
> +	}
>  
> -	hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
> -	hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
> -	vmbus_connection.monitor_pages[0] = NULL;
> -	vmbus_connection.monitor_pages[1] = NULL;
> +	if (vmbus_connection.monitor_pages[1]) {
> +		if (!set_memory_encrypted(
> +			(unsigned long)vmbus_connection.monitor_pages[1], 1))
> +			hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
> +		vmbus_connection.monitor_pages[1] = NULL;
> +	}
>  }
>  
>  /*

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


