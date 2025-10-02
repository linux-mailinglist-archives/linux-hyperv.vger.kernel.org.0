Return-Path: <linux-hyperv+bounces-7064-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B61EBB58AA
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Oct 2025 00:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8F23A4A68
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Oct 2025 22:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E63619C556;
	Thu,  2 Oct 2025 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dfOZmbP0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDE72F2D;
	Thu,  2 Oct 2025 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444226; cv=none; b=WAJMunQnTWjlI8xeLrE38EPNU4Mv/D4aEZIKzvHEG+VdtXQOA85AIxmdzrnBnHCrQ+WsSNFeDmtVUFcY02i5SjEGCvYeILh9RmqC8YTccmEopO7ox5U3bLiEhSXS3o/D0LGl1U3qLQu2Fyi41vEm7Wigj2g84Tgi2YNeJQ2sIs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444226; c=relaxed/simple;
	bh=fF75rwgKIO8KDklsni4x/9EcLRPv8qHp2cT2OZREY20=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AVzPNBx15R/P5h+c2YiAYg89g8Rz4ohpp6CtFPoAMfoEGI3t5hS0U1WKcDnuE4kkbcoNXvEuo/7Np0CxCrftwfgvV6Uo4ehE7/OWBPp/jR0kfonZe0uT2+AGDRULf24gEBM3u7LNejMeJLr3FsxzCCiVaLKUN3vBdmL2WgB7rj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dfOZmbP0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.160.245] (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 136E8211B7D4;
	Thu,  2 Oct 2025 15:30:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 136E8211B7D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759444224;
	bh=z6OYRJ9samRnQk1PTwtlFMjIR8HmV/wZd9vd6dwjQ+I=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dfOZmbP0MBG3PV5UExxHxALUVk0WBPVdqaxtHduycv0PWhGynTrLwgf71Ubp9yIFB
	 fGT1OBF9PTcjxiXKFltOiI0OjYGpVRC1IvwRLI3EKVxESXtFj00grsB7+TBXl+TLMJ
	 /b3asgCXtO9sKk5hVXNLnCkF+4ZE4WC9JXcW2QfY=
Message-ID: <605ce8cf-bdf9-45ca-b407-708625c8dcfa@linux.microsoft.com>
Date: Thu, 2 Oct 2025 15:30:22 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH] Drivers: hv: Use -ETIMEDOUT for HV_STATUS_TIME_OUT
 instead of -EIO
To: "K. Y. Srinivasan" <kys@microsoft.com>
References: <20251002221347.402320-1-easwar.hariharan@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20251002221347.402320-1-easwar.hariharan@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2025 3:13 PM, Easwar Hariharan wrote:
> Use the -ETIMEDOUT errno value as the correct 1:1 match for the
> hypervisor timeout status
> 
> Fixes: 3817854ba89201 ("hyperv: Log hypercall status codes as strings")
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 49898d10fafff..9b51b67d54cc8 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -781,7 +781,7 @@ static const struct hv_status_info hv_status_infos[] = {
>  	_STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,		-EIO),
>  	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EIO),
>  	_STATUS_INFO(HV_STATUS_OPERATION_FAILED,		-EIO),
> -	_STATUS_INFO(HV_STATUS_TIME_OUT,			-EIO),
> +	_STATUS_INFO(HV_STATUS_TIME_OUT,			-ETIMEDOUT),
>  	_STATUS_INFO(HV_STATUS_CALL_PENDING,			-EIO),
>  	_STATUS_INFO(HV_STATUS_VTL_ALREADY_ENABLED,		-EIO),
>  #undef _STATUS_INFO

Actually looking at the whole struct, it may be useful to also change at least some of
 the following codes?

        _STATUS_INFO(HV_STATUS_INVALID_ALIGNMENT,               -EIO), -> EINVAL
        _STATUS_INFO(HV_STATUS_ACCESS_DENIED,                   -EIO), -> EACCES
        _STATUS_INFO(HV_STATUS_INVALID_PARTITION_STATE,         -EIO), -> EINVAL
        _STATUS_INFO(HV_STATUS_OPERATION_DENIED,                -EIO), -> EACCES
        _STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,     -EIO), -> ERANGE
        _STATUS_INFO(HV_STATUS_INSUFFICIENT_BUFFERS,            -EIO), -> ENOBUFS
        _STATUS_INFO(HV_STATUS_NOT_ACKNOWLEDGED,                -EIO), -> EBUSY
        _STATUS_INFO(HV_STATUS_INVALID_VP_STATE,                -EIO), -> EINVAL
        _STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,                -EIO), -> EINVAL
        _STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,          -EIO), -> EINVAL
        _STATUS_INFO(HV_STATUS_VTL_ALREADY_ENABLED,             -EIO), -> EBUSY

Nuno, Stas, others, what do you think?

Thanks,
Easwar (he/him)

