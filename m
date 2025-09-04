Return-Path: <linux-hyperv+bounces-6733-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFF9B4441A
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 19:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146117A4F1C
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3366F302CC2;
	Thu,  4 Sep 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="o10992Qn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF61FBEBE;
	Thu,  4 Sep 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005972; cv=pass; b=RZVya8LldGqjrDK5au0LyOQzmSWvwBAE/UtRdzb3U8kejcCJIjkc3DKajRZF3eGII72Jdpw8f27Zt89gNhO+ZBeIIYVB6+l1+rq6Te0BzVX45Z5+6OKs5ieicWMqJdg/QcfDFKVggRGLdjHGTlpU6gWO08ZptMpcJziG15peyi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005972; c=relaxed/simple;
	bh=J0PDh7YPhCtCnE18DnagL2PYdsiX2HUWTixdcKT0K1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjN9Acsw0tswiyiQ0VkL9dF/+PGEizU65UKnzseyCPhhS4yUljqyPDGpfpbYeNshaHrLm32ajujk4J8v5lz4t0xs1OwIG+zGZf6u118vzAJ4fdtYSNZsaLmJ9eMi+rDTwocQkzr4L9OsevGcWD1X/GRI7g6d1rZ2VOFRG4LrnSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=o10992Qn; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1757005955; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=awdfshsf9LeZMBTsWgFP5A48DantBBxesJwOLTd/81CNd1nc5UxPEXZdzjQSGN/epRxc20Nmhkz3YK85cJUb08Eq91yIpMtRMpigzm809HoBG15a89D1VAWyjxRFU67Xk0IMLGT9cQ0LykuRFpm2Czb0iITJmLDSA5obwZNtfOQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757005955; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sk6VgJ1Bvjr1IOB8Z/fbh53gjN3zNQQwdoUxlZP6PqU=; 
	b=kQ/D03zDXWQskoDEitcQ9AuXqwRaiKVK2B2wUYHssmvqyWxnFELo2IdyvVEPILGneu8wDJuBfRWwu4Xq3D8d4sPXo/M9NXqGNUWU4mZs7UtxWddabsZKRdX7shDv82FbmgFB5mTG47lkcn7vdHLGWHB5LjJl5nFXN0ee2m1doD8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757005955;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=sk6VgJ1Bvjr1IOB8Z/fbh53gjN3zNQQwdoUxlZP6PqU=;
	b=o10992Qn91wrpWBFhtPZBbt5jndlgNhf+N59xp9dLmz3o5u0AOiq09HIpDXdrEmF
	WvQ/Pf6kAWr1I/zin6QxzekdHtnDmWy7q6+NWqMYjTkMMfvKuO3BiIK7rajcSURf4xB
	g87cd/GFMG69BWW9FOYSZZN965+ZZK50zLi7A3oI=
Received: by mx.zohomail.com with SMTPS id 1757005952913804.4744067471462;
	Thu, 4 Sep 2025 10:12:32 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:12:26 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	mhklinux@outlook.com, decui@microsoft.com,
	paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH 3/6] mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX
 hypercall
Message-ID: <aLnIepjJ45ZHFSDC@anirudh-surface.localdomain>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-4-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1756428230-3599-4-git-send-email-nunodasneves@linux.microsoft.com>
X-ZohoMailClient: External

On Thu, Aug 28, 2025 at 05:43:47PM -0700, Nuno Das Neves wrote:
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
> +				  void *property_value, size_t property_value_sz)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_get_partition_property_ex *input;
> +	struct hv_output_get_partition_property_ex *output;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id = partition_id;
> +	input->property_code = property_code;
> +	input->arg = arg;
> +	status = hv_do_hypercall(HVCALL_GET_PARTITION_PROPERTY_EX, input, output);
> +
> +	if (!hv_result_success(status)) {
> +		hv_status_debug(status, "\n");
> +		local_irq_restore(flags);
> +		return hv_result_to_errno(status);
> +	}
> +	memcpy(property_value, &output->property_value, property_value_sz);
> +
> +	local_irq_restore(flags);
> +
> +	return 0;
> +}
> +
>  int
>  hv_call_clear_virtual_interrupt(u64 partition_id)
>  {
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 79b7324e4ef5..1bde0aa102ec 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -490,6 +490,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_GET_VP_STATE				0x00e3
>  #define HVCALL_SET_VP_STATE				0x00e4
>  #define HVCALL_GET_VP_CPUID_VALUES			0x00f4
> +#define HVCALL_GET_PARTITION_PROPERTY_EX		0x0101
>  #define HVCALL_MMIO_READ				0x0106
>  #define HVCALL_MMIO_WRITE				0x0107
>  
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 57f3f9c2a685..fd3555def008 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -411,6 +411,46 @@ struct hv_input_set_partition_property {
>  	u64 property_value;
>  } __packed;
>  
> +union hv_partition_property_arg {
> +	u64 as_uint64;
> +	struct {
> +		union {
> +			u32 arg;
> +			u32 vp_index;
> +		};
> +		u16 reserved0;
> +		u8 reserved1;
> +		u8 object_type;
> +	};
> +} __packed;
> +
> +struct hv_input_get_partition_property_ex {
> +	u64 partition_id;
> +	u32 property_code; /* enum hv_partition_property_code */
> +	u32 padding;
> +	union {
> +		union hv_partition_property_arg arg_data;
> +		u64 arg;
> +	};
> +} __packed;
> +
> +/*
> + * NOTE: Should use hv_input_set_partition_property_ex_header to compute this
> + * size, but hv_input_get_partition_property_ex is identical so it suffices
> + */
> +#define HV_PARTITION_PROPERTY_EX_MAX_VAR_SIZE \
> +	(HV_HYP_PAGE_SIZE - sizeof(struct hv_input_get_partition_property_ex))
> +
> +union hv_partition_property_ex {
> +	u8 buffer[HV_PARTITION_PROPERTY_EX_MAX_VAR_SIZE];
> +	struct hv_partition_property_vmm_capabilities vmm_capabilities;
> +	/* More fields to be filled in when needed */
> +} __packed;
> +
> +struct hv_output_get_partition_property_ex {
> +	union hv_partition_property_ex property_value;
> +} __packed;
> +
>  enum hv_vp_state_page_type {
>  	HV_VP_STATE_PAGE_REGISTERS = 0,
>  	HV_VP_STATE_PAGE_INTERCEPT_MESSAGE = 1,
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 858f6a3925b3..bf2ce27dfcc5 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -96,8 +96,34 @@ enum hv_partition_property_code {
>  	HV_PARTITION_PROPERTY_XSAVE_STATES                      = 0x00060007,
>  	HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE		= 0x00060008,
>  	HV_PARTITION_PROPERTY_PROCESSOR_CLOCK_FREQUENCY		= 0x00060009,
> +
> +	/* Extended properties with larger property values */
> +	HV_PARTITION_PROPERTY_VMM_CAPABILITIES			= 0x00090007,
>  };
>  
> +#define HV_PARTITION_VMM_CAPABILITIES_BANK_COUNT		1
> +#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	59
> +
> +struct hv_partition_property_vmm_capabilities {
> +	u16 bank_count;
> +	u16 reserved[3];
> +	union {
> +		u64 as_uint64[HV_PARTITION_VMM_CAPABILITIES_BANK_COUNT];
> +		struct {
> +			u64 map_gpa_preserve_adjustable: 1;
> +			u64 vmm_can_provide_overlay_gpfn: 1;
> +			u64 vp_affinity_property: 1;
> +#if IS_ENABLED(CONFIG_ARM64)
> +			u64 vmm_can_provide_gic_overlay_locations: 1;
> +#else
> +			u64 reservedbit3: 1;
> +#endif
> +			u64 assignable_synthetic_proc_features: 1;
> +			u64 reserved0: HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT;
> +		} __packed;
> +	};
> +} __packed;
> +
>  enum hv_snp_status {
>  	HV_SNP_STATUS_NONE = 0,
>  	HV_SNP_STATUS_AVAILABLE = 1,
> -- 
> 2.34.1
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


