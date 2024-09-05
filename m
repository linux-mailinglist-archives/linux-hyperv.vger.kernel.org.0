Return-Path: <linux-hyperv+bounces-2979-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1EF96D078
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 09:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B257BB21BDD
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 07:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBA3194085;
	Thu,  5 Sep 2024 07:33:40 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D3D193422
	for <linux-hyperv@vger.kernel.org>; Thu,  5 Sep 2024 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521620; cv=none; b=AHoTm5xfaEoPoR8YrSgnWL84y4MqjuavciAdpijFT+qiMFniBJAOe7GCffYmCgSzkk2a8aohnDKcBDSToOvdGkLDHZXr1quk/D924sOUsEK85uHdukhG7+5bH4CyARrLtXYCbIFNyX1vP1fLEOB8QBRGLfdERd3iKXQSe5VAoNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521620; c=relaxed/simple;
	bh=T8QiDnlo7nyr6CiOwc3+RcK034TRQ0e0QedWojkjNsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miuwq9R7FbIVcErAzldRuLncFhSIx4/fXSKViMT5vetzZKCfRs/cjhryCCdE79JoUxKN3l+ae9s8/EFqNC1XHn+UQM3QY3CRMaF/bqcdnlKezw0W5ZWHg3dF++DitS2jn7BZlJaGLlrSNC8V76xZllpDwzdBBJdJmHLO4OX8idg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6e7b121be30so395378a12.1
        for <linux-hyperv@vger.kernel.org>; Thu, 05 Sep 2024 00:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725521618; x=1726126418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VR95YvNs6rVAt9jk0oqDhth4peYsB0qrl+3Ji6jn6Rw=;
        b=r4gj//KGVm5xDZQiRE9iWuN3tyVjnVP6sxZKlwiJjor1wNP1I9o3hU8DH0w+y7pXhC
         befhfn8EfD0oybWKi1QQ8aZKBxA5xEbnocRHQiTd+TlEAJdqn1CGjsnlLXrI/fPaReyV
         1XcxKM63+c2lQT9nE3nMcCnLq/BifK30mouttg5TTiLxeEYVYApSYZl6mhntAZkqs0zw
         VR4NnWrqHyMIyw0ZxMC/XolKFiZYUBtcb0fvaq2ffH+NVLKXpVhC/mX6pG/+kezhNQAi
         Htde46wtZNfKefu18atUus0WyGyHoAfYOSl7qA4bLR949sqWbXrQlZac42pKD2R5odDx
         Y4RA==
X-Forwarded-Encrypted: i=1; AJvYcCXAbnxZBhmMygIcSHPSwpiil94Q2HOBJu1jBUO89b9Vm6bmISIkWj/xKXcYsN/sxNdPDvq8VkDiKp2A5sI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50PC/pIpXN5YNRDnty9UZrry93Q5S0BOmoj7B4DJ674zDE1j1
	f27mTPAu69mA1l96UR8vkrE1XE79LiG9SX80pabfvAvuuAT7c5he8T4z9w==
X-Google-Smtp-Source: AGHT+IEgYcWTaeOshrLT8f/FPiMSXzroWdvPPJYAcZ9c6pOiLEoo5oO83qE0Gp5XjMwefmeO+j1tkg==
X-Received: by 2002:a17:902:f64a:b0:206:d73c:971b with SMTP id d9443c01a7336-206d73c977emr10425625ad.55.1725521617796;
        Thu, 05 Sep 2024 00:33:37 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea55abasm23383635ad.224.2024.09.05.00.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:33:37 -0700 (PDT)
Date: Thu, 5 Sep 2024 07:33:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH -next] hv: vmbus: Constify struct kobj_type and struct
 attribute_group
Message-ID: <Ztlewjyvp0Td3geO@liuwe-devbox-debian-v2>
References: <20240904011553.2010203-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904011553.2010203-1-lihongbo22@huawei.com>

On Wed, Sep 04, 2024 at 09:15:53AM +0800, Hongbo Li wrote:
> The `struct attribute_group` and `struct kobj_type` are not
> modified, and they are only used in the helpers which take a
> const type parameter.
> 
> Constifying these structure and moving them to a read-only section,
> and this can increase over all security.
> 
> ```
> [Before]
>    text   data    bss    dec    hex    filename
>   20568   4699     48  25315   62e3    drivers/hv/vmbus_drv.o
> 
> [After]
>    text   data    bss    dec    hex    filename
>   20696   4571     48  25315   62e3    drivers/hv/vmbus_drv.o
> ```
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Applied to hyprev-fixes, thanks.

I massage the commit message a bit to make it more readable.

> ---
>  drivers/hv/vmbus_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 7242c4920427..71fd8b97df33 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1831,12 +1831,12 @@ static umode_t vmbus_chan_attr_is_visible(struct kobject *kobj,
>  	return attr->mode;
>  }
>  
> -static struct attribute_group vmbus_chan_group = {
> +static const struct attribute_group vmbus_chan_group = {
>  	.attrs = vmbus_chan_attrs,
>  	.is_visible = vmbus_chan_attr_is_visible
>  };
>  
> -static struct kobj_type vmbus_chan_ktype = {
> +static const struct kobj_type vmbus_chan_ktype = {
>  	.sysfs_ops = &vmbus_chan_sysfs_ops,
>  	.release = vmbus_chan_release,
>  };
> -- 
> 2.34.1
> 

