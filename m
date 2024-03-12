Return-Path: <linux-hyperv+bounces-1722-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B46C878E12
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 06:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6481C2163D
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 05:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840DDC8DD;
	Tue, 12 Mar 2024 05:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PW35itaQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7794AB66F;
	Tue, 12 Mar 2024 05:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710219772; cv=none; b=r0UL5YDm4llyFjD72I//lvBSbs/VYNTSeIqy1v2F/pCcxDE/ntImoiNXhA4wFe7j+o/+QjdBU60Vwj8L9C00QD306D/+5i5rEGAvdHW6KvHNz26mnbb4jHSW274NJ6Qu+KS6k/2LjpBbEbIYkwxZXt2JkagPH1y6ssj80EYht7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710219772; c=relaxed/simple;
	bh=2tsBJwRlZRWmiGzbwBsDlPhhzuZbS4QXjkPuYyC5m20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmbmfXqt1LIyPLNX51ByKTdFl5xExPUY+q6pCEbwQGgvFxXEdko5ryt5PcvYaSSU4RGMfM91gkjRqGaf0cQiVCEHC+YQLTBiuUdoUOda0rnuSSdIkZ05VeyGFTlQBYm+PpRBA/HM2516fQGrlbXs0If4raQNTlnQxS6+7vi/Riw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PW35itaQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710219770; x=1741755770;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2tsBJwRlZRWmiGzbwBsDlPhhzuZbS4QXjkPuYyC5m20=;
  b=PW35itaQA2fRJHSFN7edhv1yNdBNmSwSs/sz4M8H9b1bwHd9OdttFVus
   XTsgJZQT4DrBdEmeFfBLrDWWxubiPgdNR9n1aN3t0Ll0QGmaOJbCtHcBL
   Uy3G/Lqj9np9JgD0LfK7EROUKhQ97cJS3QX3qGvlKCvQfS29f42DvVy+l
   VhmcguSacLLokMb8w9VD/JAdDyty5wTcadFJsqXR/cCP0l6Cr63g34OYG
   PLI6of4grblOrLE0K40+ouzk7wzzCk2wgRlj/mj4KZANq0M9NnS9rCtZ/
   DhA5veamqtzEjNnzwdyLgOSj9F0YbuF1aZ0d7gg0MIHgmUuVtfS3T2StU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="15639605"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="15639605"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 22:02:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="11834601"
Received: from sbrowne-mobl.amr.corp.intel.com (HELO [10.209.68.239]) ([10.209.68.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 22:02:48 -0700
Message-ID: <13581af9-e5f0-41ca-939f-33948b2133e7@linux.intel.com>
Date: Mon, 11 Mar 2024 22:02:48 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] Drivers: hv: vmbus: Track decrypted status in
 vmbus_gpadl
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
 <20240311161558.1310-3-mhklinux@outlook.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240311161558.1310-3-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


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
> In order to make sure callers of vmbus_establish_gpadl() and
> vmbus_teardown_gpadl() don't return decrypted/shared pages to
> allocators, add a field in struct vmbus_gpadl to keep track of the
> decryption status of the buffers. This will allow the callers to
> know if they should free or leak the pages.
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/hv/channel.c   | 25 +++++++++++++++++++++----
>  include/linux/hyperv.h |  1 +
>  2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 56f7e06c673e..bb5abdcda18f 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -472,9 +472,18 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>  		(atomic_inc_return(&vmbus_connection.next_gpadl_handle) - 1);
>  
>  	ret = create_gpadl_header(type, kbuffer, size, send_offset, &msginfo);
> -	if (ret)
> +	if (ret) {
> +		gpadl->decrypted = false;

Why not set it by default at the beginning of the function?

>  		return ret;
> +	}
>  
> +	/*
> +	 * Set the "decrypted" flag to true for the set_memory_decrypted()
> +	 * success case. In the failure case, the encryption state of the
> +	 * memory is unknown. Leave "decrypted" as true to ensure the
> +	 * memory will be leaked instead of going back on the free list.
> +	 */
> +	gpadl->decrypted = true;
>  	ret = set_memory_decrypted((unsigned long)kbuffer,
>  				   PFN_UP(size));
>  	if (ret) {
> @@ -563,9 +572,15 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>  
>  	kfree(msginfo);
>  
> -	if (ret)
> -		set_memory_encrypted((unsigned long)kbuffer,
> -				     PFN_UP(size));
> +	if (ret) {
> +		/*
> +		 * If set_memory_encrypted() fails, the decrypted flag is
> +		 * left as true so the memory is leaked instead of being
> +		 * put back on the free list.
> +		 */
> +		if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
> +			gpadl->decrypted = false;
> +	}
>  
>  	return ret;
>  }
> @@ -886,6 +901,8 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
>  	if (ret)
>  		pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret);

Will this be called only if vmbus_establish_gpad() is successful? If not, you might want to skip
set_memory_encrypted() call for decrypted = false case.

>  
> +	gpadl->decrypted = ret;
> +

IMO, you can set it to false by default. Any way with non zero return, user know about the
decryption failure.

>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(vmbus_teardown_gpadl);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 2b00faf98017..5bac136c268c 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -812,6 +812,7 @@ struct vmbus_gpadl {
>  	u32 gpadl_handle;
>  	u32 size;
>  	void *buffer;
> +	bool decrypted;
>  };
>  
>  struct vmbus_channel {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


