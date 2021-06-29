Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B03B7665
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jun 2021 18:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhF2QX4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Jun 2021 12:23:56 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48816 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhF2QXz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Jun 2021 12:23:55 -0400
Received: from [192.168.86.36] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id 692EF20B6C50;
        Tue, 29 Jun 2021 09:21:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 692EF20B6C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1624983688;
        bh=Z7pcrKqmM92YWVYHFuan2ZevsK4gQaBE9jCjMfyNwkE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UsVBC2embOIFocHXP6D79DLndcRWKHAcjIjP5P/vNzJ2jTp2kHNxVcx6UwtViqkv2
         DKipN/zYSzehkHHciHbehZwyld2JS/kcdKWy56G8tCALTABhx/GYbva1aXhYNpwNy6
         FdacPgI22svraBIocRoGwncNPDkwJf1iHgm/z0wY=
Subject: Re: [PATCH 06/17] mshv: SynIC port and connection hypercalls
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <cover.1622654100.git.viremana@linux.microsoft.com>
 <3125953aae8e7950a6da4c311ef163b79d6fb6b3.1622654100.git.viremana@linux.microsoft.com>
 <20210629130652.lzydiyqgwd47lhue@liuwe-devbox-debian-v2>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <28a207e5-5e8d-4d0d-86c7-0776d354768d@linux.microsoft.com>
Date:   Tue, 29 Jun 2021 12:21:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210629130652.lzydiyqgwd47lhue@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 6/29/2021 9:06 AM, Wei Liu wrote:
> On Wed, Jun 02, 2021 at 05:20:51PM +0000, Vineeth Pillai wrote:
>> Hyper-V enables inter-partition communication through the port and
>> connection constructs. More details about ports and connections in
>> TLFS chapter 11.
>>
>> Implement hypercalls related to ports and connections for enabling
>> inter-partiion communication.
>>
>> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> Vineeth, feel free to squash the following patch.
Thanks Wei, I will have this in the next iteration.

~Vineeth
>
> ---8<---
> >From afb9ab422895364216acb4261399f6f5154eea17 Mon Sep 17 00:00:00 2001
> From: Wei Liu <wei.liu@kernel.org>
> Date: Tue, 29 Jun 2021 12:58:47 +0000
> Subject: [PATCH] fixup! mshv: SynIC port and connection hypercalls
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>   drivers/hv/hv_call.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
> index d5cdbe4e93da..30aefcbdda85 100644
> --- a/drivers/hv/hv_call.c
> +++ b/drivers/hv/hv_call.c
> @@ -797,7 +797,7 @@ hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
>   		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
>   			pr_err("%s: %s\n",
>   			       __func__, hv_status_to_string(status));
> -			ret = -hv_status_to_errno(status);
> +			ret = hv_status_to_errno(status);
>   			break;
>   		}
>   		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> @@ -826,7 +826,7 @@ hv_call_delete_port(u64 port_partition_id, union hv_port_id port_id)
>   
>   	if (status != HV_STATUS_SUCCESS) {
>   		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
> -		return -hv_status_to_errno(status);
> +		return hv_status_to_errno(status);
>   	}
>   
>   	return 0;
> @@ -866,7 +866,7 @@ hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
>   		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
>   			pr_err("%s: %s\n",
>   			       __func__, hv_status_to_string(status));
> -			ret = -hv_status_to_errno(status);
> +			ret = hv_status_to_errno(status);
>   			break;
>   		}
>   		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> @@ -896,7 +896,7 @@ hv_call_disconnect_port(u64 connection_partition_id,
>   
>   	if (status != HV_STATUS_SUCCESS) {
>   		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
> -		return -hv_status_to_errno(status);
> +		return hv_status_to_errno(status);
>   	}
>   
>   	return 0;
> @@ -918,7 +918,7 @@ hv_call_notify_port_ring_empty(u32 sint_index)
>   
>   	if (status != HV_STATUS_SUCCESS) {
>   		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
> -		return -hv_status_to_errno(status);
> +		return hv_status_to_errno(status);
>   	}
>   
>   	return 0;
