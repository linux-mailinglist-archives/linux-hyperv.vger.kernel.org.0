Return-Path: <linux-hyperv+bounces-2536-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D944E926A16
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 23:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B618282EEF
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 21:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741041849FF;
	Wed,  3 Jul 2024 21:16:23 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F177D2BB13;
	Wed,  3 Jul 2024 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720041383; cv=none; b=oZhvVlN7kI1kKNaxL1JqNCsKKf/NmcyumVyUXLM3Peg08ti+r8Mdx6oKCfA6BlUyKlWCgYK7XB+br8zbiNWqtnCMCHI+vuX0TvP45p8Z2LDCJEAO4DLItFhkiQqRwVfUPt5kJU84527GiFoSbfua8nnR/pLuXVcvnEnhK9BD0TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720041383; c=relaxed/simple;
	bh=nlp6bQPRQiMPByVe8me2VhVKRrCqQP34pQBRtMw91TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnRSlGBmfHpUYg86wlK+5PsEpO12yeZ4JT3Fl7kdVu2yrPFIHq2LYvSHsWx/yMgiRhuRMeGpOmy2Q2aSq9VLMvuZ/EA/jbs53sESXUybqg6oJG+/CdlFQf17X0IhWD202KZwJqSJYddR9z++psG/T98O3EvUzCrt3LhDN674t8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70af3d9169bso7790b3a.1;
        Wed, 03 Jul 2024 14:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720041381; x=1720646181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpVtHL8OVuWI1Ty7Lfb5G5fjYyhvJwqeNPLEgGJl6p0=;
        b=jWt8Z0tDbZfYZXSWJz3aw5DtyOyVxe9Ar+r/Iz/L8puu+0VRkSuU07b7xuYCvRMjbm
         ZyFMtDJ/jxauXrqV5JJ407WjAwJJEp3lZrxfuHBlrcrGUYrL7XHcCkyW0ZOVQGUHxHsm
         c65gotgLAQxy7ZhPCJXpjr9sZTEz6IyWet7fiPtXOuiNTEONsNypcMIpkD+/HFY7M7eA
         IzKZtW3NLZpEs67CQAlqAh52PjohCuTfJuv2pviV7w3vX1JIjzaNGAMd9nMLB0mH3EI4
         tnaVTOETS5+zjndp2ZJd/2od8ailj3fETIrpYqlT4VLp7eAjzrGuUayAuYF42ekARLQh
         Mcag==
X-Forwarded-Encrypted: i=1; AJvYcCW++Enf/LiP4uyMJz1mm0rvhPq4ZJZgwd67wI+cI9sRL3AuelCqR/PP0zhxni3deJq4WAzGtEPJjvFLQxB5FbI4osGaXTlUeZE8tXaB7n3RcHlBK2yaRDOiJuJDx5EzAr4K9t66Wv8c4bxA
X-Gm-Message-State: AOJu0YxM3MBdbm1pzEBnv3bx8F4Pa1j3ty8tIwqzqxQ0ZYRx9p80fhsz
	wQNwjmMThJrjuTqT+yc/a2VC3uTyLxNQGooTbIPT5z0ejZh0oR7D
X-Google-Smtp-Source: AGHT+IHEoTQDuUen5I8hKdUHTZwQkTCuoJzPeIQvL+xAOa6ilYi3ffY0/FvMPThrByQcxZPltkkqag==
X-Received: by 2002:a05:6a20:12c1:b0:1bd:22e8:5d00 with SMTP id adf61e73a8af0-1bef610d098mr13010884637.33.1720041381106;
        Wed, 03 Jul 2024 14:16:21 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080256afb5sm10882804b3a.79.2024.07.03.14.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:16:20 -0700 (PDT)
Date: Wed, 3 Jul 2024 21:16:10 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Haoxiang Li <make24@iscas.ac.cn>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, mikelley@microsoft.com, parri.andrea@gmail.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: hv: vmbus: Add missing check for
 dma_set_mask in vmbus_device_register()
Message-ID: <ZoW_mkh-gIhIwWfI@liuwe-devbox-debian-v2>
References: <20240703084221.12057-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703084221.12057-1-make24@iscas.ac.cn>

On Wed, Jul 03, 2024 at 04:42:21PM +0800, Haoxiang Li wrote:
> child_device_obj->device cannot perform DMA properly if dma_set_mask()
> returns non-zero. Add check for dma_set_mask() and return the error if it
> fails. To do the right cleanup, call dma_set_mask() after device_register()
> so that we can use existent error path of vmbus_device_register().
> 
> Fixes: 3a5469582c24 ("Drivers: hv: vmbus: Fix initialization of device object in vmbus_device_register()")
> Signed-off-by: Haoxiang Li <make24@iscas.ac.cn>

The email address doesn't seem to match your name.  Why?

You should use your own email address to sign off the patches you write.

Thanks,
Wei.

> ---
> Changes in v2:
> Thanks for your comments. They help a lot. It is not sufficient to do the
> cleanup just with kfree(). The memory allocated by dev_set_name()
> should also be freed, which is done by put_device() (finally in
> kobject_cleanup() [1]). I think performing a complete cleanup within
> vmbus_device_register() would be verbose and detrimental to code
> maintenance. I suggest calling dma_set_mask() after device_register(),
> so that proper error handling can be achieved using the existent error path
> of vmbus_device_register(), i.e., err_dev_unregister [2]. Moreover,
> I found a similar usage in dmapool_checks() [3], which calls
> dma_set_mask_and_coherent() after device_register(). I believe the
> modification is workable.
> 
> Reference link:
> [1]https://github.com/torvalds/linux/blob/master/lib/kobject.c#L695
> [2]https://github.com/torvalds/linux/blob/master/drivers/hv/vmbus_drv.c#L1933
> [3]https://github.com/torvalds/linux/blob/master/mm/dmapool_test.c#L105
> ---
>  drivers/hv/vmbus_drv.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 12a707ab73f8..f3999d8afd77 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1897,7 +1897,6 @@ int vmbus_device_register(struct hv_device *child_device_obj)
>  
>  	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
>  	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
> -	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
>  
>  	/*
>  	 * Register with the LDM. This will kick off the driver/device
> @@ -1910,6 +1909,12 @@ int vmbus_device_register(struct hv_device *child_device_obj)
>  		return ret;
>  	}
>  
> +	ret = dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> +	if (ret) {
> +		pr_err("64-bit DMA enable failed!\n");
> +		goto err_dev_unregister;
> +	}
> +
>  	child_device_obj->channels_kset = kset_create_and_add("channels",
>  							      NULL, kobj);
>  	if (!child_device_obj->channels_kset) {
> -- 
> 2.25.1
> 
> 

