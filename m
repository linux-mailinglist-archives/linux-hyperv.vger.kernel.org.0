Return-Path: <linux-hyperv+bounces-6748-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6596CB45C9E
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCD0A04F38
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858622F7AC6;
	Fri,  5 Sep 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgziJwA8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1A22F7AA3;
	Fri,  5 Sep 2025 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086288; cv=none; b=ZpmfqcZ3DibvIb7oJVX+3sw2e82E4ps7JOHFOftdzYUZtp9bgZDYuEV/njtoKkUyN4xTKv12S6RoB9WXJqazpxrVcahb1pEUpYkRpeElj8JrDhUSVfHgMdOLF4ESeaWpb4XqoD2jH5ocv2BstAEfrRzNshufYswe6bhacmbfFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086288; c=relaxed/simple;
	bh=8ms1d9Vg7jwuzgSpvzREZ+LF+iaiBlwiLlIb00axx9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUIGhXjtMukhK9J2K73SeCz4qBQq3NARkkp3p9o804B3cIJhWgHAjSP5ZJHUT6gsgl434nBEU7Y1ZzOYRYntbsFiKNXWh0FHBIU6zAH6hP9BtZRXhz75Z8bNpYv3d02rr4WdTFFgKBJLff98ugAH6QCvxavUkfi92wffSXRDOD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgziJwA8; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74381df387fso976960a34.0;
        Fri, 05 Sep 2025 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757086286; x=1757691086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dqFxb/2bKobkfbDbds8z6V/6zpNwI0zDXWRf77DMUQw=;
        b=lgziJwA8ehhc4y1d9JBO8q08sBtX8J9fOZkHjt4+VJWy+etU38yTJi1Z2x7kNjpr6j
         /lnAOqXyt7/pvEhFASV57idHAZMJ3nRq8ISYf2++gnyrwvsyHs6u2P5K7u4KBRDFF5te
         6Kh1ksdk78s0mtDupGrudtWEZ9w7+P+wo9n9cI0mnmLo3stOdtMPLbZgk+REf1EPJ5wK
         f2NFuZvrEE0nK276V21Gyui37ysmO72Yl6e4fapGZPyTRXOdqnB+QTHs+plLTdi6BINB
         yankLqZ+w9FOOrLCK6H8FBDATUwKGs9mHwVcTKC5SjDgsofywdMrpwHIXtNEFSEFYF1F
         TR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757086286; x=1757691086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqFxb/2bKobkfbDbds8z6V/6zpNwI0zDXWRf77DMUQw=;
        b=ZpbDoG69fTx5vNx0OU6LvbezKQO4S06UdYxe6MCZtB/TMfu9Y8wypEc/cpmgtjco9b
         Y8olLC2bhNg69/xgc55GQce1uzl0zQhOSupLk6flxzua/AEW5VUxNM6vAxG6ZF++PJMS
         WuvHEsowg9j5NDG5FK57OUWs6IrHpJXGgds+OVFOUDgs6HlBY7fnDdONTx9zkXircllO
         heikulr97kB0X+vrZ2oQVP0Wja1FMYshhNgITXMM8073jyxS5xf9qdlgrHTcYdZcpx5T
         APwC7EZne3ljL6yijzAkp38HxnK0Ca2XPh2am/H+vR+Z30hy9erxU95cNmhPOdXjMl/2
         AVQg==
X-Forwarded-Encrypted: i=1; AJvYcCUJQtRkNpB+OvkNCx7olafVE9MCRzgwlCFEOad4H/U7RwvUD2UH76q1w3pmrnHSQt9hgLU3ZY2J0THqIFs=@vger.kernel.org, AJvYcCVTci6mCLd7bMky4IIQT5ZFw5hpovUgoiUFfCwkGtNZ1qYX18MLxa8JxBQjaOoOeqmKUf9w57GK4hujuF0y@vger.kernel.org
X-Gm-Message-State: AOJu0YyaxIgMB6yYz1JWqlUf7z1+AAsmkw6CKR1dycvOiDzfzor9C7Ed
	HlsojhUepfIqSDN/1xxjeOpJ0heazlJqn7St/qGmCU6lXqXeJDlxsrf5
X-Gm-Gg: ASbGncsUvMCvbQJgZWdJngorjD3N5iKVBnoQ1o1TiW4wL5KQwxBfGhIXaDC0dfxCzzA
	DQksKpP+e7M/W6D24IGPhr2CI4+sJh4CSvY0rLFSLWoNpk2QJ0yukAiNKAK1bscwFpkNIAD/P+w
	GjUjKmbAdKBo/LFdSRh3fNiyXZTPR72xwFQMtclpjRG1tHuzKqcf4RW2dJtDq+/dMnNcjv7DAFy
	C+sqSm1rADNOgJ76cgp5NJDfBKM7O47tlGCIX7T8pJ6J4kAwMIqK6VDZ52zFPh8FjzYiZi9yY1I
	/e23Co9T4hglDU82OX4Uk7B+NRyFT7hRrfFTeG6xWk/zIGgxffYXXOHb+7m3MooDX6uYBRYu9Js
	0XHgJEPq8HNn2r8B1x8yXZMQ1Sp/BfSD6hPqX9vB2UA==
X-Google-Smtp-Source: AGHT+IFTyiHCKjvnrH5SDgWBVlLUoi6IFbmlSm+rVdwh4zLkj59MaVAd2eJCS8Zeo1lwwC9KPWoUug==
X-Received: by 2002:a05:6830:4708:b0:742:f9b1:ee7d with SMTP id 46e09a7af769-74569e08887mr11473916a34.16.1757086284374;
        Fri, 05 Sep 2025 08:31:24 -0700 (PDT)
Received: from ?IPV6:2603:8081:c640:1::1007? ([2603:8081:c640:1::1007])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74abb1a9845sm156037a34.13.2025.09.05.08.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:31:23 -0700 (PDT)
Message-ID: <644647df-64d5-44eb-b7ac-13bd4b81d422@gmail.com>
Date: Fri, 5 Sep 2025 10:31:21 -0500
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mshv: Ignore second stats page map result failure
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-3-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Praveen K Paladugu <praveenkpaladugu@gmail.com>
In-Reply-To: <1756428230-3599-3-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/28/2025 7:43 PM, Nuno Das Neves wrote:
> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> 
> Some versions of the hypervisor do not support HV_STATUS_AREA_PARENT and
> return HV_STATUS_INVALID_PARAMETER for the second stats page mapping
> request.
>
Is this behavior limited to VP stats? Or does it extend to other
stats (hypervisor, partition, etc) as well?

> This results a failure in module init. Instead of failing, gracefully
nit: s/This results in a failure during module init/> fall back to 
populating stats_pages[HV_STATS_AREA_PARENT] with the
> already-mapped stats_pages[HV_STATS_AREA_SELF].
> 
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>   drivers/hv/mshv_root_hv_call.c | 43 ++++++++++++++++++++++++++++++----
>   drivers/hv/mshv_root_main.c    |  3 +++
>   2 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index c9c274f29c3c..1c38576a673c 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -724,6 +724,24 @@ hv_call_notify_port_ring_empty(u32 sint_index)
>   	return hv_result_to_errno(status);
>   }
>   
> +static int
> +hv_stats_get_area_type(enum hv_stats_object_type type,
> +		       const union hv_stats_object_identity *identity)
> +{
> +	switch (type) {
> +	case HV_STATS_OBJECT_HYPERVISOR:
> +		return identity->hv.stats_area_type;
> +	case HV_STATS_OBJECT_LOGICAL_PROCESSOR:
> +		return identity->lp.stats_area_type;
> +	case HV_STATS_OBJECT_PARTITION:
> +		return identity->partition.stats_area_type;
> +	case HV_STATS_OBJECT_VP:
> +		return identity->vp.stats_area_type;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>   int hv_call_map_stat_page(enum hv_stats_object_type type,
>   			  const union hv_stats_object_identity *identity,
>   			  void **addr)
> @@ -732,7 +750,7 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
>   	struct hv_input_map_stats_page *input;
>   	struct hv_output_map_stats_page *output;
>   	u64 status, pfn;
> -	int ret = 0;
> +	int hv_status, ret = 0;
>   
>   	do {
>   		local_irq_save(flags);
> @@ -747,11 +765,28 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
>   		pfn = output->map_location;
>   
>   		local_irq_restore(flags);
> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> -			ret = hv_result_to_errno(status);
> +
> +		hv_status = hv_result(status);
> +		if (hv_status != HV_STATUS_INSUFFICIENT_MEMORY) {
>   			if (hv_result_success(status))
>   				break;
> -			return ret;
> +
> +			/*
> +			 * Some versions of the hypervisor do not support the
> +			 * PARENT stats area. In this case return "success" but
> +			 * set the page to NULL. The caller checks for this
> +			 * case instead just uses the SELF area.
> +			 */
> +			if (hv_stats_get_area_type(type, identity) == HV_STATS_AREA_PARENT &&
> +			    hv_status == HV_STATUS_INVALID_PARAMETER) {
> +				pr_debug_once("%s: PARENT area type is unsupported\n",
> +					      __func__);
> +				*addr = NULL;
> +				return 0;
> +			}
> +
> +			hv_status_debug(status, "\n");
> +			return hv_result_to_errno(status);
>   		}
>   
>   		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index bbdefe8a2e9c..56ababab57ce 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -929,6 +929,9 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
>   	if (err)
>   		goto unmap_self;
>   
> +	if (!stats_pages[HV_STATS_AREA_PARENT])
> +		stats_pages[HV_STATS_AREA_PARENT] = stats_pages[HV_STATS_AREA_SELF];
> +
>   	return 0;
>   
>   unmap_self:

-- 
Regards,
Praveen K Paladugu


