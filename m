Return-Path: <linux-hyperv+bounces-6752-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EC8B45DC9
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2347C7937
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1D42F7ABF;
	Fri,  5 Sep 2025 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7uKZmaU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392502F7AC5;
	Fri,  5 Sep 2025 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089138; cv=none; b=PqxQRfCK828lrfjSRfphTUtU/JQ3J3SB3Ma2zEVsB7FEUY1WRbNof/lmSS2gSY4X2ORzWtz0KQ2m1iCFJJ/5vwj4bSD0ZJCmGlgPWYdbtX8+z5kWts/HASUa9qgp/nMRMGNbzSSSWQ9MdQwwRXbwjxlTi2vxB9UVjP2c1skWlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089138; c=relaxed/simple;
	bh=U1mx1Wksi8A7mUsEBiH+rHZueA4Z4vGBR3iHeII/Ky4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/uEx/jDYwpiNVwx9bsR+m4wG0joVc4FtmVfPjxt+55mwTyPaVT4UdYa8X/hAlDb9cmdTmQ/sDvlIdhR7DMxuvJg+3whfm3FTgP6mdrFLWFZ1bcHe4SDCSMGfz55J4gBIojTBry3Ca0Mb9Ffv/hA9adLSfqUqputltgRw4VkkhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7uKZmaU; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61bd4a3f39cso608868eaf.0;
        Fri, 05 Sep 2025 09:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757089135; x=1757693935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ac9utsvRqlJOG5E+XTcxgGGpWGJvaIjIEeoph2D159s=;
        b=T7uKZmaUJSeR1E8c8rATQRQiwb9BccPKZzqZxPZkPGsXpSGrZmSo0QHZbCN5DZ4RdX
         iJIRdx6nstz3afeguiNoeDMMt+NgW309tV5N3Er9C1Qc+bPxgK4HiZ77I9SERKdqBd+1
         OWkxu/QTEzEYulE0ILJlqUR90IOROfkVLVaDhkX12M4A2q3EXmO9qBIuSVpiiCRPiibf
         kdfP4fIKL9id6rAeJYcXmFG6wyqgAtMvsBR9Bolc05mgfSJjMX6ovuVDCW5erXG0P44K
         qRrWIOl5gbm+mwjaGn+f6ro/9Nn2Rjbemo3DUDHNACtZJtq9h0vb8fV0mW1hpjdm/iEP
         eAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757089135; x=1757693935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ac9utsvRqlJOG5E+XTcxgGGpWGJvaIjIEeoph2D159s=;
        b=Zqzyz104y+8rj1nA5DUaxJ8O968aYDqw+0HqOa/8zsxpN4Lr0famoEFk7EfLID6Jc/
         pSGd08LEE+1yziV65HxOWqvB0Z08VbQ2BB+FGId1AKrgaoQaoCCBJ9e9XtqJZIiC+SLZ
         m7b9gDES/rWD/g6TY8/RGox7Npo+tub0rPBl2IdWMp+q8qB7+sHJfBGr+CgppHM7O/Rl
         9ETYghn/q/LXnw4QCxiz2PcTk9BqINKvCgvoWBWl7Yx1ti9TWQy0fWkY/D9V9jCep7yT
         QzTBYwEsL3XQEuE7pnVGAVlftqju8su1Q1w0tewG35Y6G2iOAWQyn1upXl/TfaD3mz2x
         U3iA==
X-Forwarded-Encrypted: i=1; AJvYcCWBGjWct6Rawo4a1okO5JjsO93QnjQo88gRRMeTa7xnMOdBKyUjFrQ//G0EmdHNF49mnFJgy4fWrRXpJ0pF@vger.kernel.org, AJvYcCWGXx/q7pu1pwCuZ/N4Cgm42m6IMU/Ob0esdmIAXAbNlyBsrGW7dVLLrcmhzPftajtSVNjV9JM5unMsQUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK/y2TwDXZicFad/LPhMdyIzWiF3rf49JOVdj0vjjrvCiRu4+A
	+W52K3eqhgbltLEa9yx2HpbFdlCBYYSFKleHJeHNS3KSvEjbvBwklZmD
X-Gm-Gg: ASbGnctcpKHadNd8TZTMhv0f+ZE9neNoAn02jr/CuoOWouPcJ3S2XzZxOj0y/Zz6RCu
	bLsXo4kOuTc6mnUIdBRIkx57JFi2D8pYo+OU0WBTTl/bzW1pWeIJaT4sTQp8tiH3BZP3Pbws/mw
	EkodiScVp6QCN0xS8FN1bqHW4KsXFuOvpmbWoFLP3WH27MVzao7WKXg0n52mioVReIhA59yeoKM
	jwi6dZ7gtci9jLRkh2ERbPpPKGjlTlaSyFaWjKDC7tbx3+Q+7plRC28G20l5msASYqHVhPbNcsz
	yPaQMe7SXuyg+YG56KXvCJzprquAATQ7gnjaXIDm5uXDXTpEl8A+mSyldX3FD6PkbTnmgjCe/Fb
	qHiN518kGeg8cOZKxCLQF0el5IQGjzlJE9ca8W27+ow==
X-Google-Smtp-Source: AGHT+IG7BEqKx80IS5UHPppgbQuPg03UAYmcDVccGEPkEX3oxSM0+i9ms49ePa7/Vv1XxWEVmJQ6SA==
X-Received: by 2002:a05:6808:d4b:b0:439:af0a:dc9c with SMTP id 5614622812f47-439af0b0de4mr1618409b6e.32.1757089135142;
        Fri, 05 Sep 2025 09:18:55 -0700 (PDT)
Received: from ?IPV6:2603:8081:c640:1::1007? ([2603:8081:c640:1::1007])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4380001d1b6sm3631482b6e.17.2025.09.05.09.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 09:18:54 -0700 (PDT)
Message-ID: <07437725-60fc-4831-aa6a-d83470caaadc@gmail.com>
Date: Fri, 5 Sep 2025 11:18:52 -0500
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] mshv: Allocate vp state page for
 HVCALL_MAP_VP_STATE_PAGE on L1VH
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com,
 Jinank Jain <jinankjain@linux.microsoft.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-6-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Praveen K Paladugu <praveenkpaladugu@gmail.com>
In-Reply-To: <1756428230-3599-6-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/28/2025 7:43 PM, Nuno Das Neves wrote:
> From: Jinank Jain <jinankjain@linux.microsoft.com>
> 
> Introduce mshv_use_overlay_gpfn() to check if a page needs to be
> allocated and passed to the hypervisor to map VP state pages. This is
> only needed on L1VH, and only on some (newer) versions of the
> hypervisor, hence the need to check vmm_capabilities.
> 
> Introduce functions hv_map/unmap_vp_state_page() to handle the
> allocation and freeing.
> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>   drivers/hv/mshv_root.h         | 11 +++---
>   drivers/hv/mshv_root_hv_call.c | 61 +++++++++++++++++++++++++---
>   drivers/hv/mshv_root_main.c    | 72 +++++++++++++++++-----------------
>   3 files changed, 96 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 0cb1e2589fe1..d7c9520ef788 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -279,11 +279,12 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
>   			 /* Choose between pages and bytes */
>   			 struct hv_vp_state_data state_data, u64 page_count,
>   			 struct page **pages, u32 num_bytes, u8 *bytes);
> -int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> -			      union hv_input_vtl input_vtl,
> -			      struct page **state_page);
> -int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> -				union hv_input_vtl input_vtl);
> +int hv_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +			 union hv_input_vtl input_vtl,
> +			 struct page **state_page);
> +int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +			   void *page_addr,
> +			   union hv_input_vtl input_vtl);
>   int hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
>   			u64 connection_partition_id, struct hv_port_info *port_info,
>   			u8 port_vtl, u8 min_connection_vtl, int node);
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index 7589b1ff3515..1882cc90f2f5 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -526,9 +526,9 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
>   	return ret;
>   }
>   
> -int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> -			      union hv_input_vtl input_vtl,
> -			      struct page **state_page)
> +static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +				     union hv_input_vtl input_vtl,
> +				     struct page **state_page)
>   {
>   	struct hv_input_map_vp_state_page *input;
>   	struct hv_output_map_vp_state_page *output;
> @@ -547,7 +547,14 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>   		input->type = type;
>   		input->input_vtl = input_vtl;
>   
> -		status = hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input, output);
> +		if (*state_page) {
> +			input->flags.map_location_provided = 1;
> +			input->requested_map_location =
> +				page_to_pfn(*state_page);
> +		}
> +
> +		status = hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input,
> +					 output);
>   
>   		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
>   			if (hv_result_success(status))
> @@ -565,8 +572,39 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>   	return ret;
>   }
>   
> -int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> -				union hv_input_vtl input_vtl)
> +static bool mshv_use_overlay_gpfn(void)
> +{
> +	return hv_l1vh_partition() &&
> +	       mshv_root.vmm_caps.vmm_can_provide_overlay_gpfn;
> +}
> +
> +int hv_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +			 union hv_input_vtl input_vtl,
> +			 struct page **state_page)
> +{
> +	int ret = 0;
> +	struct page *allocated_page = NULL;
> +
> +	if (mshv_use_overlay_gpfn()) {
> +		allocated_page = alloc_page(GFP_KERNEL);
> +		if (!allocated_page)
> +			return -ENOMEM;
> +		*state_page = allocated_page;
> +	} else {
> +		*state_page = NULL;
> +	}
> +
> +	ret = hv_call_map_vp_state_page(partition_id, vp_index, type, input_vtl,
> +					state_page);
> +
> +	if (ret && allocated_page)
> +		__free_page(allocated_page);
> +
> +	return ret;
> +}
> +
> +static int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +				       union hv_input_vtl input_vtl)
>   {
>   	unsigned long flags;
>   	u64 status;
> @@ -590,6 +628,17 @@ int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>   	return hv_result_to_errno(status);
>   }
>   
> +int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +			   void *page_addr, union hv_input_vtl input_vtl)
> +{
> +	int ret = hv_call_unmap_vp_state_page(partition_id, vp_index, type, input_vtl);
> +
> +	if (mshv_use_overlay_gpfn() && page_addr)
> +		__free_page(virt_to_page(page_addr));
> +
> +	return ret;
> +}
> +
>   int
>   hv_call_get_partition_property_ex(u64 partition_id, u64 property_code, u64 arg,
>   				  void *property_value, size_t property_value_sz)
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 29f61ecc9771..f91880cc9e29 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -964,28 +964,25 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>   	if (ret)
>   		return ret;
>   
> -	ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
> -					HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> -					input_vtl_zero,
> -					&intercept_message_page);
> +	ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
> +				   HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> +				   input_vtl_zero, &intercept_message_page);
>   	if (ret)
>   		goto destroy_vp;
>   
>   	if (!mshv_partition_encrypted(partition)) {
> -		ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
> -						HV_VP_STATE_PAGE_REGISTERS,
> -						input_vtl_zero,
> -						&register_page);
> +		ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
> +					   HV_VP_STATE_PAGE_REGISTERS,
> +					   input_vtl_zero, &register_page);
>   		if (ret)
>   			goto unmap_intercept_message_page;
>   	}
>   
>   	if (mshv_partition_encrypted(partition) &&
>   	    is_ghcb_mapping_available()) {
> -		ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
> -						HV_VP_STATE_PAGE_GHCB,
> -						input_vtl_normal,
> -						&ghcb_page);
> +		ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
> +					   HV_VP_STATE_PAGE_GHCB,
> +					   input_vtl_normal, &ghcb_page);
>   		if (ret)
>   			goto unmap_register_page;
>   	}
> @@ -1049,21 +1046,19 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>   	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
>   		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
>   unmap_ghcb_page:
> -	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available()) {
> -		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
> -					    HV_VP_STATE_PAGE_GHCB,
> -					    input_vtl_normal);
> -	}
> +	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
> +		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
> +				       HV_VP_STATE_PAGE_GHCB, vp->vp_ghcb_page,
> +				       input_vtl_normal);
>   unmap_register_page:
> -	if (!mshv_partition_encrypted(partition)) {
> -		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
> -					    HV_VP_STATE_PAGE_REGISTERS,
> -					    input_vtl_zero);
> -	}
> +	if (!mshv_partition_encrypted(partition))
> +		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
> +				       HV_VP_STATE_PAGE_REGISTERS,
> +				       vp->vp_register_page, input_vtl_zero);
>   unmap_intercept_message_page:
> -	hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
> -				    HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> -				    input_vtl_zero);
> +	hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
> +			       HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> +			       vp->vp_intercept_msg_page, input_vtl_zero);
>   destroy_vp:
>   	hv_call_delete_vp(partition->pt_id, args.vp_index);
>   	return ret;
> @@ -1804,24 +1799,27 @@ static void destroy_partition(struct mshv_partition *partition)
>   				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
>   
>   			if (vp->vp_register_page) {
> -				(void)hv_call_unmap_vp_state_page(partition->pt_id,
> -								  vp->vp_index,
> -								  HV_VP_STATE_PAGE_REGISTERS,
> -								  input_vtl_zero);
> +				(void)hv_unmap_vp_state_page(partition->pt_id,
> +							     vp->vp_index,
> +							     HV_VP_STATE_PAGE_REGISTERS,
> +							     vp->vp_register_page,
> +							     input_vtl_zero);
>   				vp->vp_register_page = NULL;
>   			}
>   
> -			(void)hv_call_unmap_vp_state_page(partition->pt_id,
> -							  vp->vp_index,
> -							  HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> -							  input_vtl_zero);
> +			(void)hv_unmap_vp_state_page(partition->pt_id,
> +						     vp->vp_index,
> +						     HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> +						     vp->vp_intercept_msg_page,
> +						     input_vtl_zero);
>   			vp->vp_intercept_msg_page = NULL;
>   
>   			if (vp->vp_ghcb_page) {
> -				(void)hv_call_unmap_vp_state_page(partition->pt_id,
> -								  vp->vp_index,
> -								  HV_VP_STATE_PAGE_GHCB,
> -								  input_vtl_normal);
> +				(void)hv_unmap_vp_state_page(partition->pt_id,
> +							     vp->vp_index,
> +							     HV_VP_STATE_PAGE_GHCB,
> +							     vp->vp_ghcb_page,
> +							     input_vtl_normal);
>   				vp->vp_ghcb_page = NULL;
>   			}
>   
Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>

