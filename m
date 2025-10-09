Return-Path: <linux-hyperv+bounces-7173-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 137ADBCA9DB
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Oct 2025 20:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0034812E6
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Oct 2025 18:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543552512C8;
	Thu,  9 Oct 2025 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tKCjmXIf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAEB21FF38;
	Thu,  9 Oct 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760036023; cv=none; b=D/QNq4Dz0pNkY67EIS7npu2qO25Jc0cmHu8mU85WqC2gCOS1UiYygqw0wYTGxQJxVg/jYR7JVyu8X5Q6vhdBtFz9XuXtNb9g46aQNKnpZymD2oMoUULpcroJxd/xstdNjFBG6+5ze9MvIVGY0ISy5kfo5+0BFM5km9rXuPcve0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760036023; c=relaxed/simple;
	bh=ahKsEBsebIAvxVEpnkpdGbJQSre6pnqocFTciVXlNVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OqPF0iO7RJ3lX7BpMJCYp7FeGnWfgor9yGwjZD5Fo95FuGnPho3qDIDH/QPT9TFv1Pd/2aWgaqr543f2XLKi1TuWTdWn5xJwN6RtBIeeXBekkn9jmGgIXVbJYsWmyRPhpyHGMbM4sTL8JtVMNt7sg7efHhNLoP36nhIjRrSpVNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tKCjmXIf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.193.78] (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id B3B672038B77;
	Thu,  9 Oct 2025 11:53:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3B672038B77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760036020;
	bh=VmxKPO+i5KTsorZ+pMnJ55Bwhxr8Xq+S/RT8s6iZC3Y=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tKCjmXIfvIIljj0G5qLBAQXiawr5IkJ/VrgzdjM4W0PjAGiAmqj3+pND4DVUBmzpv
	 mVuGhSD+lgnJej3DV7Q948H+zzs+AkfS/UviVn9aAGsv4mHKljdub9XMJr29b12cWd
	 0wS0ZHh0gV60zQz0LjFCITzG/UvvDLmEQzpF1i7s=
Message-ID: <2768abf3-6974-49e6-9ea2-5e5e04f533a7@linux.microsoft.com>
Date: Thu, 9 Oct 2025 11:53:39 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Drivers: hv: Use better errno matches for HV_STATUS
 values
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251006230821.275642-1-easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20251006230821.275642-1-easwar.hariharan@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/2025 4:08 PM, Easwar Hariharan wrote:
> Use a better mapping of hypervisor status codes to errno values and
> disambiguate the catch-all -EIO value. While here, remove the duplicate
> INVALID_LP_INDEX and INVALID_REGISTER_VALUES hypervisor status entries.
> 

To be honest, in retrospect the idea of 'translating' the hypercall error
codes is a bit pointless. hv_result_to_errno() allows the hypercall helper
functions to be a bit cleaner, but that's about it. When debugging you
almost always want to know the actual hypercall error code. Translating
it imperfectly is often useless, and at worst creates a red
herring/obfuscates the true source of the error.

With that in mind, updating the errno mappings to be more accurate feels
like unnecessary churn. It might even be better to remove the errno mappings
altogether and just translate HV_STATUS_SUCCESS to 0 and any other error
to -EIO or some other 'signal' error code to make it more obvious that
a *hypercall* error occurred and not some other Linux error. We'd still
want to keep the table in some form because it's also used for the error
strings.

The cleanup removing the duplicates in the table is welcome.

Nuno

> Fixes: 3817854ba89201 ("hyperv: Log hypercall status codes as strings")
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
> Changes in v2: Change more values, delete duplicated entries
> v1: https://lore.kernel.org/all/20251002221347.402320-1-easwar.hariharan@linux.microsoft.com/
> ---
>  drivers/hv/hv_common.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 49898d10fafff..bb32471a53d68 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -758,32 +758,30 @@ static const struct hv_status_info hv_status_infos[] = {
>  	_STATUS_INFO(HV_STATUS_SUCCESS,				0),
>  	_STATUS_INFO(HV_STATUS_INVALID_HYPERCALL_CODE,		-EINVAL),
>  	_STATUS_INFO(HV_STATUS_INVALID_HYPERCALL_INPUT,		-EINVAL),
> -	_STATUS_INFO(HV_STATUS_INVALID_ALIGNMENT,		-EIO),
> +	_STATUS_INFO(HV_STATUS_INVALID_ALIGNMENT,		-EINVAL),
>  	_STATUS_INFO(HV_STATUS_INVALID_PARAMETER,		-EINVAL),
> -	_STATUS_INFO(HV_STATUS_ACCESS_DENIED,			-EIO),
> -	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_STATE,		-EIO),
> -	_STATUS_INFO(HV_STATUS_OPERATION_DENIED,		-EIO),
> +	_STATUS_INFO(HV_STATUS_ACCESS_DENIED,			-EACCES),
> +	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_STATE,		-EINVAL),
> +	_STATUS_INFO(HV_STATUS_OPERATION_DENIED,		-EACCES),
>  	_STATUS_INFO(HV_STATUS_UNKNOWN_PROPERTY,		-EIO),
> -	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
> +	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-ERANGE),
>  	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
>  	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
>  	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
>  	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
>  	_STATUS_INFO(HV_STATUS_INVALID_PORT_ID,			-EINVAL),
>  	_STATUS_INFO(HV_STATUS_INVALID_CONNECTION_ID,		-EINVAL),
> -	_STATUS_INFO(HV_STATUS_INSUFFICIENT_BUFFERS,		-EIO),
> -	_STATUS_INFO(HV_STATUS_NOT_ACKNOWLEDGED,		-EIO),
> -	_STATUS_INFO(HV_STATUS_INVALID_VP_STATE,		-EIO),
> +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_BUFFERS,		-ENOBUFS),
> +	_STATUS_INFO(HV_STATUS_NOT_ACKNOWLEDGED,		-EBUSY),
> +	_STATUS_INFO(HV_STATUS_INVALID_VP_STATE,		-EINVAL),
>  	_STATUS_INFO(HV_STATUS_NO_RESOURCES,			-EIO),
>  	_STATUS_INFO(HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED,	-EIO),
>  	_STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,		-EINVAL),
>  	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EINVAL),
> -	_STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,		-EIO),
> -	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EIO),
>  	_STATUS_INFO(HV_STATUS_OPERATION_FAILED,		-EIO),
> -	_STATUS_INFO(HV_STATUS_TIME_OUT,			-EIO),
> +	_STATUS_INFO(HV_STATUS_TIME_OUT,			-ETIMEDOUT),
>  	_STATUS_INFO(HV_STATUS_CALL_PENDING,			-EIO),
> -	_STATUS_INFO(HV_STATUS_VTL_ALREADY_ENABLED,		-EIO),
> +	_STATUS_INFO(HV_STATUS_VTL_ALREADY_ENABLED,		-EBUSY),
>  #undef _STATUS_INFO
>  };
>  





