Return-Path: <linux-hyperv+bounces-6757-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB10B4639E
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 21:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6555A1CC05CB
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 19:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506C62773DD;
	Fri,  5 Sep 2025 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oxgvVIwe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8251B0437;
	Fri,  5 Sep 2025 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100541; cv=none; b=qBUwqXaAyPNHBwKzjyuvk+WeWOJEFVMt06OSor57+/pDW92tCvKOhqeZFsxzTOqkszVYu46aFHV+Qtn0YsLU7RJocrHkzNwNqeejiCK4CMTXD859lfL+r612cNmSYfv0B26jRJvuBxKm308lYXcm45jGbqWuZsBTfDsSpkEHmPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100541; c=relaxed/simple;
	bh=aZwWIcVROekwX0QX81CFdnNn+7H4sa89FqagQ7rpxYE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dW2J+TYdqMGMNd982Sj2OBT8QwoOcs7AYwEDeaDK7s2KV3ydAAF132/UC42V/tHTMPhklV5gy4ASdoEcVs/K2hHy8CrvCNaXT1UBOcoMc6gWkA/ECpkZPolcIj7MWqscsY2pQdQMHeDDouDKV49q9C+U5NTyAOKoOb/DbBO6UR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oxgvVIwe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.233.45] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0BD2020171D8;
	Fri,  5 Sep 2025 12:28:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0BD2020171D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757100539;
	bh=PLvgTD/OnnHbaAuzBIftWPCH/3g71OS/Vst5x6sK4RY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oxgvVIweVYk/2rEpPm2xG+5iB4S8cLhpEFmApKoAcYsZMqLOFnHPI5wEAGa6deLrs
	 AK9DJdDT60cR/wKR1DCGxqo8XSdOOtU4cx9Yq871WReR3trTik0hCmiNpohkfj+sp8
	 LVddchAwweMP4xeWMdq1e9OUD6x6QkV/9DvnpFBc=
Message-ID: <daa0202d-3f9e-42eb-a356-2a1ac08e69d2@linux.microsoft.com>
Date: Fri, 5 Sep 2025 12:28:59 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
 decui@microsoft.com, paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH 3/6] mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX
 hypercall
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-4-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1756428230-3599-4-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/2025 5:43 PM, Nuno Das Neves wrote:
> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> 
> This hypercall can be used to fetch extended properties of a
> partition. Extended properties are properties with values larger than
> a u64. Some of these also need additional input arguments.
> 
> Add helper function for using the hypercall in the mshv_root driver.
> 
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         |  2 ++
>  drivers/hv/mshv_root_hv_call.c | 31 ++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h    |  1 +
>  include/hyperv/hvhdk.h         | 40 ++++++++++++++++++++++++++++++++++
>  include/hyperv/hvhdk_mini.h    | 26 ++++++++++++++++++++++
>  5 files changed, 100 insertions(+)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index e3931b0f1269..4aeb03bea6b6 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -303,6 +303,8 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type type,
>  int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
>  				   u64 page_struct_count, u32 host_access,
>  				   u32 flags, u8 acquire);
> +int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code, u64 arg,
> +				      void *property_value, size_t property_value_sz);
>  
>  extern struct mshv_root mshv_root;
>  extern enum hv_scheduler_type hv_scheduler_type;
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index 1c38576a673c..7589b1ff3515 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -590,6 +590,37 @@ int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>  	return hv_result_to_errno(status);
>  }
>  
> +int
> +hv_call_get_partition_property_ex(u64 partition_id, u64 property_code, u64 arg,

One line like in patch 2..

<snip>

Thanks,
Easwar (he/him)

