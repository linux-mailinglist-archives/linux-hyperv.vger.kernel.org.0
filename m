Return-Path: <linux-hyperv+bounces-4787-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89811A79DFA
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Apr 2025 10:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3408A173B2C
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Apr 2025 08:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558EB2417FA;
	Thu,  3 Apr 2025 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LeDwQYpg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8F82417DD;
	Thu,  3 Apr 2025 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668682; cv=none; b=kowZgyIRFjN7Zpv9fKEzlY5lez6jRPB64vxjF4H3CmBhrYHp8t3/u0hJkpRbXyOAT7+iTJR/ua5IjBXNHjUzumy7MOMR5zUrI/fDm/ueonKOebruGXOKfan9w7Mf2i7PV9MCx5G5G9Wm4aDS7fCTgH5jZvBqkHP8KUATGpgj++w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668682; c=relaxed/simple;
	bh=hYAP/5okbsYRgEeJ15yz4elTcVcEkLGM75c2aFm4S5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgb5VpIYgWlJ/m2d7pzyddjPh8shyuleYEkuE/kARJFjfXp4EuCBGqMMIHjO+ab3rZLwFgE4TCzn9jl5TPtbzFB6UBqcJ47teUzNHGn9hkILdbmrWHQ045fHLg3s25DTi1tipjSCOaU3He8aH/eXYjiDfkDSf7lqEz5oOwSb41M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LeDwQYpg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.22] (unknown [167.220.238.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id 82586211251B;
	Thu,  3 Apr 2025 01:24:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82586211251B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743668680;
	bh=rnj8EK/JzdiA1b2uvyspu3Hqf7UsyAdJb+qGDBbwtpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LeDwQYpgTU9/DJozxCC9HANUKSZJixwyB+yMnSQA6EmAS6HyriejyFkKaXJn7jXat
	 CQFj8PWp6rKJ2hKbQ5mqDWvfbSJRpPeFlSnqBvWffOsEaAWVAkRS4yUeOuzeOjYoE2
	 F8f0YPMxQgzvHeb64TgjBWYBSytaUFsJ2LF/MOI4=
Message-ID: <b7102dfb-86e4-4a85-8444-de18258473f2@linux.microsoft.com>
Date: Thu, 3 Apr 2025 13:54:37 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: Fix bad pointer dereference in
 hv_get_partition_id
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 wei.liu@kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, mhklinux@outlook.com,
 decui@microsoft.com
References: <1743528737-20310-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <1743528737-20310-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/1/2025 11:02 PM, Nuno Das Neves wrote:
> 'output' is already a pointer to the output argument, it should be
> passed directly to hv_do_hypercall() without the '&' operator.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
> This patch is a fixup for:
> e96204e5e96e hyperv: Move hv_current_partition_id to arch-generic code

You can add Fixes: tag, so that it gets ported to previous kernel, in 
case, it does not make it to 6.14.


Regards,
Naman

> 
>   drivers/hv/hv_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index b3b11be11650..a7d7494feaca 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -307,7 +307,7 @@ void __init hv_get_partition_id(void)
>   
>   	local_irq_save(flags);
>   	output = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, &output);
> +	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output);
>   	pt_id = output->partition_id;
>   	local_irq_restore(flags);
>   


