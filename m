Return-Path: <linux-hyperv+bounces-1724-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFE5878E18
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 06:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3C3283590
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 05:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A8DC8DD;
	Tue, 12 Mar 2024 05:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEJyRgPE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826C53D3A7;
	Tue, 12 Mar 2024 05:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710219900; cv=none; b=rquSy9lQs2LQa2/r1woBlsCDJ5geo0csy4Ct8nBolxICqGWO+FVwU3CMHLoyU7L+BS5IflgO/GXGbHhES259IEdpYRCvHXMfte4AZLdfM4AbjNq9gTSw4tSELtKT3lX+g3dh3hypfelsUoyG991bmoPZOKArskv2v2p9/QccsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710219900; c=relaxed/simple;
	bh=eQU3kCbvM08ie4DjCq5niL2RgRQnsAcgKnVlS+myw9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9wEYy/5mVMMdZ+Di+eNH1cGoZDTJT2oCRV8MY2zA9Bi10ciyJQr6NHiKVqJIQUxnpRastkxi9hylbWkw107CLZkpQ93arEoMaLMcsrAXUi9LA5sfesVdS+yHtwFB+JRskc7rNGYxanEvMTTvzgoAtSEuS0Wn+UWjVCRfOQYPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEJyRgPE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710219897; x=1741755897;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eQU3kCbvM08ie4DjCq5niL2RgRQnsAcgKnVlS+myw9w=;
  b=eEJyRgPERD0Jm+YMkHZeOf1So2Z731FhmecmYpgM3dxYbi2muh0xnJ7v
   zhWCEXVCZY7dVEAFqPhftibpFtuNh6ro0X2i9a/ejizyo4nwdrhItOAzY
   nVF/9NT/BFQaci6TwULT6H/iN44F6M5+co72q0c91qAatsh3nTC7+EfjR
   CbJBv+IL/cLRH1I00PwKnQwoQNhYt5UjotsOK3eJx9zeRghllKeV/AYX8
   eVEcHKeyKENpeTTvcnOyYkI8LTe0dmzpy5famtZG+3I78eDgq5ljWuWcf
   5p1wrpRqhA4PMyarQ5xMW2IVEQVANrBI+RRVByDjdWktw5y444bzqInfK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="15639762"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="15639762"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 22:04:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="11835232"
Received: from sbrowne-mobl.amr.corp.intel.com (HELO [10.209.68.239]) ([10.209.68.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 22:04:56 -0700
Message-ID: <722d2c0f-e3a8-4fad-a09d-19fc0c9dbe38@linux.intel.com>
Date: Mon, 11 Mar 2024 22:04:56 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] uio_hv_generic: Don't free decrypted memory
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
 <20240311161558.1310-5-mhklinux@outlook.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240311161558.1310-5-mhklinux@outlook.com>
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
> The VMBus device UIO driver could free decrypted/shared pages if
> set_memory_decrypted() fails. Check the decrypted field in the gpadl
> to decide whether to free the memory.
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>  drivers/uio/uio_hv_generic.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 20d9762331bd..6be3462b109f 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -181,12 +181,14 @@ hv_uio_cleanup(struct hv_device *dev, struct hv_uio_private_data *pdata)
>  {
>  	if (pdata->send_gpadl.gpadl_handle) {
>  		vmbus_teardown_gpadl(dev->channel, &pdata->send_gpadl);
> -		vfree(pdata->send_buf);
> +		if (!pdata->send_gpadl.decrypted)
> +			vfree(pdata->send_buf);
>  	}
>  
>  	if (pdata->recv_gpadl.gpadl_handle) {
>  		vmbus_teardown_gpadl(dev->channel, &pdata->recv_gpadl);
> -		vfree(pdata->recv_buf);
> +		if (!pdata->recv_gpadl.decrypted)
> +			vfree(pdata->recv_buf);
>  	}
>  }
>  
> @@ -295,7 +297,8 @@ hv_uio_probe(struct hv_device *dev,
>  	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
>  				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
>  	if (ret) {
> -		vfree(pdata->recv_buf);
> +		if (!pdata->recv_gpadl.decrypted)
> +			vfree(pdata->recv_buf);
>  		goto fail_close;
>  	}
>  
> @@ -317,7 +320,8 @@ hv_uio_probe(struct hv_device *dev,
>  	ret = vmbus_establish_gpadl(channel, pdata->send_buf,
>  				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
>  	if (ret) {
> -		vfree(pdata->send_buf);
> +		if (!pdata->send_gpadl.decrypted)
> +			vfree(pdata->send_buf);
>  		goto fail_close;
>  	}
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


