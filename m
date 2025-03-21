Return-Path: <linux-hyperv+bounces-4664-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D67A6C094
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Mar 2025 17:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503883A4668
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Mar 2025 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDFA1E7C0B;
	Fri, 21 Mar 2025 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cfI+AAAz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AEE1D5AC0;
	Fri, 21 Mar 2025 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575833; cv=none; b=rgwjh1KK2lRaUprrHJcGX9qLiv8xWzihwg6E8pi/YrR+on/kzR4mc2RB9Uxe1lsJGO8rXhWJwiOKyVj28+7clgiS7Zy6+h3bkY+8nz4KR0Y1oF8tQy0FKBOvHk0VL/wYzDxmipsV4EcXJDDHJlECtbQkmY76MVCACOTh+Gkba9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575833; c=relaxed/simple;
	bh=qumRD7jXvlnR3yPJSSiuvtPmDNmvQ+Bwubs3LO5xZtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOLQ0CCgILs5u5MaBt2/7iosd39bBR5LEtedaS7UdzZzAny01oD6UGDFi43cRGhvkyqiSE6fQwA8Ya2vCDtv7Cfj4b8/ZuoC0FkCAJtat/gbpMleYn7FvzwKO7QNK1O7qFoFdTuZDe/Tvz+mBYwxyecSiH1Y5+mvGvKr0UqeQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cfI+AAAz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id E3C1B202538B;
	Fri, 21 Mar 2025 09:50:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3C1B202538B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742575832;
	bh=+D1vaNuaigNQlu4KkjWR/UVOCsyHPtoUYlIfMGu0MSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cfI+AAAzbkW/FvRc1IdINlxpttIWHtJqKaWgyeRslaHgHy+vIQfeAQE8jI4IICghE
	 KTErmATimBYke65R2XcvgGL+x9/B/CYIYqK+k/xVHvbAhyw8jCENJH5e6D16sICSAf
	 Lw7r5UGJH/xTYHvjr0vWPIsOthKq2AF4WEpNjnEM=
Message-ID: <b5219734-c1c1-4d3c-953c-92b3c8c23988@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:50:26 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: mshv: Fix uninitialized variable in
 hv_call_map_stat_page()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <fac96458-fdb9-4166-94bd-f1d135abc6ba@stanley.mountain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <fac96458-fdb9-4166-94bd-f1d135abc6ba@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/2025 7:35 AM, Dan Carpenter wrote:
> If the hv_do_hypercall() succeeds on the first iteration then "ret" is
> not initialized.  I re-arranged this code to make the loop clearer and
> to make it more clear that we return zero on the last line.
> 
> Fixes: f5288d14069b ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/hv/mshv_root_hv_call.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index b72b59a5068b..a74e13a32183 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -733,7 +733,7 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
>  	u64 status, pfn;
>  	int ret;
>  
> -	do {
> +	while (1) {
>  		local_irq_save(flags);
>  		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>  		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> @@ -756,11 +756,11 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
>  					    hv_current_partition_id, 1);
>  		if (ret)
>  			return ret;
> -	} while (!ret);
> +	}
>  
>  	*addr = page_address(pfn_to_page(pfn));
>  
> -	return ret;
> +	return 0;
>  }
>  
>  int hv_call_unmap_stat_page(enum hv_stats_object_type type,

Thanks Dan, I already sent a fixup for this:
https://lore.kernel.org/linux-hyperv/1742492693-21960-1-git-send-email-nunodasneves@linux.microsoft.com/

