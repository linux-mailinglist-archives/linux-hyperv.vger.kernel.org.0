Return-Path: <linux-hyperv+bounces-6750-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26078B45CC5
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 17:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D031A3B5024
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F06B302141;
	Fri,  5 Sep 2025 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kP8CJ997"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491031B833;
	Fri,  5 Sep 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087045; cv=none; b=dpCkup0QjecTPGVEL8dx/KjOYEgaf8HPsI7rdreShMrIGHiOA2x52YTDiufJSF7EUYZtgil58chdh4CBeo3KweQQPPWTUezAiK2AhBZU3LSLaPRb+o7Mj/rnNOw7G551uCEKiaJfu/jo/9nj9PMiNa5mUa3K91rfNIZEmlqI80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087045; c=relaxed/simple;
	bh=jQ6wRH+vPe3IDPH5gDvEWz6iLi0di+IZLYpz3tvhhKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/Mqry5FAgKDiDqaKt7Erbw50sfsXwtHvE6Obzf8AVTFpLbrpt+MnKT0so6RmF8pQZuTB1GI4CZ8xHakQdktCLXnoj6yEeSJmQ0Es4D/Z9cPHKBqeXkT4YNIM544hrHeVbq+5cPUyinZtD4dOwRk4lrMyRMatN6KNOi+5qKbZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kP8CJ997; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7459fa1ef2aso2356405a34.1;
        Fri, 05 Sep 2025 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757087042; x=1757691842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2ag447guJJ+5SXVnrwNqP+lUfwxcxZXABgH6xXWAjI=;
        b=kP8CJ997zPOG8NV//kxz7Pv34MblpbCVNFp/HuyBczTwLf+GVdTIIFBWjhkVQHPOSP
         G/PlBIR2rD39BSq5Y/RGFLPJg3wZIAmSj8u2fDrVeUz7t8M0Pl3yVr5750jdsqCh3iuI
         r2ZA8MmMlSDHGdGqXRBcgSywoHytMTNcCDPf14UFLT1mk2joBbYshrtneY1wgP1TtB4y
         9n0yYTIcE8mLvUoLtMLifCjPpPXdG1c0jHekWuqgYJWyEFDSuKyx11yFQUn6XsfmeEYR
         X5SyYuG3rttXJ1GVOqMQSd6C/6kRN7to7z72oGgpoEChG+Mc1EpWcmdSS+04kRQYVCaS
         1qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087042; x=1757691842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2ag447guJJ+5SXVnrwNqP+lUfwxcxZXABgH6xXWAjI=;
        b=s2dAyyGGjdtYjGXpEDFsWJpKR6df0VkEIUPJ2UXwZLfwwRlVGnYbp2l7YVEJXWtj45
         mVkiVo1KdDkJ5PfHJK3xLSqPwniGHMExnKqdCxWxdKo+Qt47pCzk/EsijVxf0/pVSOWk
         57YGR8jd9kHSQxMPkkR5iYgsIcizL7R3XbrnxJXaGQvd4ujlo+QabEUod0KSmO+mpdBZ
         DpvrWd4kUqXga45Y76H9lNRpyXhCwgupuaRHcUPqCY5ec9f0gn13mukyu68HSujRwqOv
         y4A9KdGk55jYQWEWKgVggN2rEzbHxCKksyJ2FwJFI+PDMzpT0AT6HMfihu8DD9TVUpR0
         qncQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxEd5kvGOdbXn7ZBTHXe5pMjBgrxBu9IuyigkiKZXf3uDNP8v4gpXX25dNiXmR/dkB8eSd7ojGAcZuBBu5@vger.kernel.org, AJvYcCVzJu42U43OxbGOhUt9cJpuRyQOUf5Cd2TLeMqZc4tEhLHYj4mZKolwyrHjsdyiOcFVbCIpdCQ0VOiu1r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzF0a4TjRrmyBnqToR92w2Em4CLSAh7fiH5AFxIROmr+FNt/r8
	tLY9/p1kJ6PY8LU+/t0r46wMiJBLg9JpRwbUcO8x9dOaeKYFZQ0Fa3Zi
X-Gm-Gg: ASbGnct7Qzm+RMgTbSiz5iOt8WvToTjy7g4C89g//PdynxHx8/zvInsUYQLkt3JLQQA
	uhoVIldAM3XezIMAgaRAy2ViBhEOTQWvDcq0q8Ie+YHXg2d1Y6h5yqkdHv3U0weE23oxGsiBk2K
	SsJKHosY6BIoMLeKk207GdwktDCvCGA/f6St8yIClX/PFuDjWqT4m8cYFIzD5UgnZegsEJV8VuR
	fBYjJoJ4/p4xioPgCRilI5JtZhJ/LW8t+FLm2S9fmvBwkNdIdlzlvgMeDPIFK2VZTk10H+6ZVK5
	lqdKp6MufUD/di6PpxpIi9Sz6wn0m8E3QxjnQHDIvKZHiw23O5YOrDeo7Gjc0HQD4LoRLR3KZhI
	Z9UOb13STil+TCpQN+5ogU7jywMo6M8R1MxnPVJCjsg==
X-Google-Smtp-Source: AGHT+IESoaKFNwvJ2zmh3m5L9WabCBNHQw5n+iPtShwEM3j+ZEPGJykW8vK3WMjwFC0559P80frv3g==
X-Received: by 2002:a05:6830:3898:b0:743:968b:3440 with SMTP id 46e09a7af769-74569e8b89emr10587473a34.20.1757087042507;
        Fri, 05 Sep 2025 08:44:02 -0700 (PDT)
Received: from ?IPV6:2603:8081:c640:1::1007? ([2603:8081:c640:1::1007])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61e6feb11a7sm1347327eaf.10.2025.09.05.08.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:44:01 -0700 (PDT)
Message-ID: <64adc508-d18b-4075-835d-97ce5b68c4eb@gmail.com>
Date: Fri, 5 Sep 2025 10:43:59 -0500
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mshv: Get the vmm capabilities offered by the
 hypervisor
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-5-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Praveen K Paladugu <praveenkpaladugu@gmail.com>
In-Reply-To: <1756428230-3599-5-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/28/2025 7:43 PM, Nuno Das Neves wrote:
> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> 
> Some newer hypervisor APIs are gated by feature bits in the so-called
> "vmm capabilities" partition property. Store the capabilities on
nit: s/xx/Some hypervisor APIs are gated by feature bits exposed in
"vmm capabilities" partition property./g> mshv_root module init, using 
HVCALL_GET_PARTITION_PROPERTY_EX.
> 
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>   drivers/hv/mshv_root.h      |  1 +
>   drivers/hv/mshv_root_main.c | 28 ++++++++++++++++++++++++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 4aeb03bea6b6..0cb1e2589fe1 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -178,6 +178,7 @@ struct mshv_root {
>   	struct hv_synic_pages __percpu *synic_pages;
>   	spinlock_t pt_ht_lock;
>   	DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
> +	struct hv_partition_property_vmm_capabilities vmm_caps;
>   };
>   
>   /*
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 56ababab57ce..29f61ecc9771 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2327,6 +2327,28 @@ static int __init mshv_root_partition_init(struct device *dev)
>   	return err;
>   }
>   
> +static int mshv_init_vmm_caps(struct device *dev)
> +{
> +	int ret;
> +
> +	memset(&mshv_root.vmm_caps, 0, sizeof(mshv_root.vmm_caps));
> +	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> +						HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> +						0, &mshv_root.vmm_caps,
> +						sizeof(mshv_root.vmm_caps));
> +
> +	/*
> +	 * HV_PARTITION_PROPERTY_VMM_CAPABILITIES is not supported in
> +	 * older hyperv. Ignore the -EIO error code.
> +	 */
> +	if (ret && ret != -EIO)
> +		return ret;
> +
> +	dev_dbg(dev, "vmm_caps=0x%llx\n", mshv_root.vmm_caps.as_uint64[0]);
> +
> +	return 0;
> +}
> +
>   static int __init mshv_parent_partition_init(void)
>   {
>   	int ret;
> @@ -2377,6 +2399,12 @@ static int __init mshv_parent_partition_init(void)
>   	if (ret)
>   		goto remove_cpu_state;
>   
> +	ret = mshv_init_vmm_caps(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to get VMM capabilities\n");
> +		goto exit_partition;
> +	}
> +
>   	ret = mshv_irqfd_wq_init();
>   	if (ret)
>   		goto exit_partition;

Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
-- 
Regards,
Praveen K Paladugu


