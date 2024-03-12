Return-Path: <linux-hyperv+bounces-1734-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7326C87974F
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 16:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCC91F248CE
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 15:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4816D7C0A5;
	Tue, 12 Mar 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jD/t1tsl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD656997A;
	Tue, 12 Mar 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256624; cv=none; b=cz4nKSdU5ADsebKf3MP1aNgXBDuWy8CJ4g8mvav6jg+l4PU2OOf3kz42PIv5g1zrG/2Qx7DnaF3UptoVMqFgFd7G3Rva4kRjJ8dem/LIKeNIBVm+h75NqmTOkGaG2Cw74j8U10w0upYfU5kESTT29un0NZ+id+qRZoLFOFqy0hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256624; c=relaxed/simple;
	bh=6txQ1P2wd4DV5K0sKlxOiWp76aMl9VmgADyzuBdTpUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwzvQINCwNw8HfZVwXrEeANgVRmgQNRqSir+aIV49UKdDPCmM5kruGIHAxQHCL3v2YKR9y95WwMYTI/HqXqZGZAqgrDSxGbP3PDCMPYjXgyXOFxe4bIABxM2Qjll8w82Nt3OkveUlMv3uhx9hApDeTGyUgPS9QfrWIsIe5s8hKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jD/t1tsl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710256622; x=1741792622;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6txQ1P2wd4DV5K0sKlxOiWp76aMl9VmgADyzuBdTpUA=;
  b=jD/t1tslw9jdxfNpv57YEbpII/ZWWrS2MwacnvEJCdyuXmVSocwLHavP
   pooR6DykpFqCF+8J30+8Q77Y8VglUtUQHGzVpICDU9KeTbYUAdPfFE87X
   N8gHzSKs9HHeGeUg+1gpHX4V781TL0PlwO/bAziN1/E2mohBVBmR63YVK
   SVlfyWBsufOHWcvX1TMdX80fpCxeGyASRlhyyrNiszXLe7482XBkwd9Dh
   hoS9JxmG3sca93aAoaKV6rYueqY26BYj4Pex5xKVixuCOMmsAboW8kzwl
   HxHpY+ohGkuVmX5ZhhHRKrEswsR+H0h3DBKnkxMBEt7yxGyRTLP+1xMoU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4824002"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4824002"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="34742937"
Received: from hhutton-mobl1.amr.corp.intel.com (HELO [10.209.25.241]) ([10.209.25.241])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:17:00 -0700
Message-ID: <f287cb95-5e48-4672-976f-bea7f4a3b257@linux.intel.com>
Date: Tue, 12 Mar 2024 08:16:59 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] Drivers: hv: vmbus: Don't free ring buffers that
 couldn't be re-encrypted
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
 <20240311161558.1310-6-mhklinux@outlook.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240311161558.1310-6-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/11/24 9:15 AM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
>
> In CoCo VMs it is possible for the untrusted host to cause
> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to
> take care to handle these errors to avoid returning decrypted (shared)
> memory to the page allocator, which could lead to functional or security
> issues.
>
> The VMBus ring buffer code could free decrypted/shared pages if
> set_memory_decrypted() fails. Check the decrypted field in the struct
> vmbus_gpadl for the ring buffers to decide whether to free the memory.
>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>  drivers/hv/channel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index bb5abdcda18f..47e1bd8de9fc 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -153,7 +153,9 @@ void vmbus_free_ring(struct vmbus_channel *channel)
>  	hv_ringbuffer_cleanup(&channel->inbound);
>  
>  	if (channel->ringbuffer_page) {
> -		__free_pages(channel->ringbuffer_page,
> +		/* In a CoCo VM leak the memory if it didn't get re-encrypted */
> +		if (!channel->ringbuffer_gpadlhandle.decrypted)
> +			__free_pages(channel->ringbuffer_page,
>  			     get_order(channel->ringbuffer_pagecount
>  				       << PAGE_SHIFT));
>  		channel->ringbuffer_page = NULL;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


