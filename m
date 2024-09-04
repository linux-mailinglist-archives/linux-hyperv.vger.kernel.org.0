Return-Path: <linux-hyperv+bounces-2937-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 795A396B7EC
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 12:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7C61F2764B
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 10:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339B21CEEA8;
	Wed,  4 Sep 2024 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K+ver78V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82E8192586
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Sep 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444594; cv=none; b=Dt7lwgGgIjRIYT0KBYykalsQlatOke7Me9yy9OTqxSSmT9N0b4O4Z7pvcxOF/+xSoZVi8HOE2Xf+4nX14bPUOfCPcrGE8uZrewiPuKvKGQ8e6Wt3JDKObqQQVeJ/CFr5mVksK1eB+Ft4qkeslKYtWcutpfDYFVFPsDk+GoUHFn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444594; c=relaxed/simple;
	bh=Fch26/NgVExZVn6y9d/X4TnObhd/Itu8bQX8gDHSHPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksP4G4oNfjmuG5bRMxdbSKzZHOQuSJFRDTIhbsSKUBEnqWEeLEeDUMvMlJQYOhk3yO6VMBGKJyfCVEv0BoyF3085tCkd5XKH+b7UnJ4VLUo9X4XV8aoXAV8ciS7wlvtuk6+Fqshl88yB6vLouF3kTFUSvb4PcSJjWKIlxNP3m/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K+ver78V; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.130.174] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id C237320B7165;
	Wed,  4 Sep 2024 03:09:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C237320B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725444592;
	bh=7q10i6MVZG7PkoD4otTOkgEiclxpUEnUWPKrQ7amPdY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K+ver78V+Dxsm7nyLDjhRiuwvK+ZowJZe7hptGr4NIRAYym0ZSe4lwglJS7cU85xg
	 FzNCo1eiNXU9n4/dUsrcFb9oTnTM2fGpm1EW2jth97ePAcm/GoqBYDnrsDrVZCKZKu
	 wq3kl6Lx/Pl1mtwoUXgPN9Iz2p1+rC1A12u2bs+A=
Message-ID: <690efd2f-c814-40d0-b017-e93089e814b2@linux.microsoft.com>
Date: Wed, 4 Sep 2024 15:39:48 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] hv: vmbus: Constify struct kobj_type and struct
 attribute_group
To: Hongbo Li <lihongbo22@huawei.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org
References: <20240904011553.2010203-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20240904011553.2010203-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/2024 6:45 AM, Hongbo Li wrote:
> The `struct attribute_group` and `struct kobj_type` are not
> modified, and they are only used in the helpers which take a
> const type parameter.
> 
> Constifying these structure and moving them to a read-only section,
> and this can increase over all security.
> 
> ```
> [Before]
>     text   data    bss    dec    hex    filename
>    20568   4699     48  25315   62e3    drivers/hv/vmbus_drv.o
> 
> [After]
>     text   data    bss    dec    hex    filename
>    20696   4571     48  25315   62e3    drivers/hv/vmbus_drv.o
> ```
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   drivers/hv/vmbus_drv.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 7242c4920427..71fd8b97df33 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1831,12 +1831,12 @@ static umode_t vmbus_chan_attr_is_visible(struct kobject *kobj,
>   	return attr->mode;
>   }
>   
> -static struct attribute_group vmbus_chan_group = {
> +static const struct attribute_group vmbus_chan_group = {
>   	.attrs = vmbus_chan_attrs,
>   	.is_visible = vmbus_chan_attr_is_visible
>   };
>   
> -static struct kobj_type vmbus_chan_ktype = {
> +static const struct kobj_type vmbus_chan_ktype = {
>   	.sysfs_ops = &vmbus_chan_sysfs_ops,
>   	.release = vmbus_chan_release,
>   };


Small thing, I hope you included before and after logs in commit msg to
show that some of the data section moved to text as you made these
variables constant. If not, please move these after ---.


Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman

