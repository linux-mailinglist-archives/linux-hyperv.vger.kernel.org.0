Return-Path: <linux-hyperv+bounces-7907-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3169AC98635
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Dec 2025 18:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEB28342E00
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Dec 2025 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FEE32D0D4;
	Mon,  1 Dec 2025 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GcM1L16S"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDDE33469F;
	Mon,  1 Dec 2025 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608446; cv=none; b=UMM45+B8YJ7pQII7saDI7+z3PsxfWiC2OR+UorWyHCPDBjrChNFoZreNCuTAgFYQ/cwAng8W/L9K4RgZSxscNSbBZkveW30lLb4sTqpoW1GXlFVZnK5twgjkiGpA3yT7w2Enrrncv2CDjDKHRFKxgAediUuFEZIMOCy6ge4/0sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608446; c=relaxed/simple;
	bh=0uVlCWS+2nyvVLTP80Vfxn7RSILLEqyUW0DZ3UO0dFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLCLn2QXnKSet6jei2UAUBhgYzANn26sJADz7FQ94xNMGKF3rZPOmiN149xrCKUa5bsOzkuV80TgjXT1GNl3o6VVi13emiC/azSg4uCHuVPZGUvR0NblbMAqaAINMuQ14cNzhBS44cBe6rQYdzharKC+qtpdRwIZ6WwUNOx62rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GcM1L16S; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-166.hsd1.wa.comcast.net [98.225.44.166])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5DDE0201C97E;
	Mon,  1 Dec 2025 09:00:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5DDE0201C97E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764608443;
	bh=SGILBTuxRAkYYjPjKe+hQSh/7/DCnIlpArjKNZHO1qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GcM1L16Sc3tGfYfzJ9rdmd21mELY9wHyJNjOdyXbL3Ft2SwmNH2sRuoOiylZysJ6p
	 qCVHk4PQNMpcQK1lLUBjA5g5WuSwpHQY1w8iCeD4PJe8OsOpoIAvGYeNzIGvnzgO62
	 XHsK+x6GnOvSpmqk3y9M8D/OgV3V0HEv0RRNJ7dI=
Date: Mon, 1 Dec 2025 09:00:41 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, anbelski@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com
Subject: Re: [PATCH v6 1/3] hyperv: Add definitions for MSHV sleep state
 configuration
Message-ID: <aS3JuZUcrKGPhYRo@skinsburskii.localdomain>
References: <20251126215013.11549-1-prapal@linux.microsoft.com>
 <20251126215013.11549-2-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126215013.11549-2-prapal@linux.microsoft.com>

On Wed, Nov 26, 2025 at 03:49:51PM -0600, Praveen K Paladugu wrote:
> Add the definitions required to configure sleep states in mshv hypervsior.
> 

Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |  4 +++-
>  include/hyperv/hvhdk_mini.h | 40 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 1d5ce11be8b6..04b18d0e37af 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -465,19 +465,21 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_RESET_DEBUG_SESSION			0x006b
>  #define HVCALL_MAP_STATS_PAGE				0x006c
>  #define HVCALL_UNMAP_STATS_PAGE				0x006d
> +#define HVCALL_SET_SYSTEM_PROPERTY			0x006f
>  #define HVCALL_ADD_LOGICAL_PROCESSOR			0x0076
>  #define HVCALL_GET_SYSTEM_PROPERTY			0x007b
>  #define HVCALL_MAP_DEVICE_INTERRUPT			0x007c
>  #define HVCALL_UNMAP_DEVICE_INTERRUPT			0x007d
>  #define HVCALL_RETARGET_INTERRUPT			0x007e
>  #define HVCALL_NOTIFY_PARTITION_EVENT                   0x0087
> +#define HVCALL_ENTER_SLEEP_STATE			0x0084
>  #define HVCALL_NOTIFY_PORT_RING_EMPTY			0x008b
>  #define HVCALL_REGISTER_INTERCEPT_RESULT		0x0091
>  #define HVCALL_ASSERT_VIRTUAL_INTERRUPT			0x0094
>  #define HVCALL_CREATE_PORT				0x0095
>  #define HVCALL_CONNECT_PORT				0x0096
>  #define HVCALL_START_VP					0x0099
> -#define HVCALL_GET_VP_INDEX_FROM_APIC_ID			0x009a
> +#define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
>  #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index f2d7b50de7a4..41a29bf8ec14 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -140,6 +140,7 @@ enum hv_snp_status {
>  
>  enum hv_system_property {
>  	/* Add more values when needed */
> +	HV_SYSTEM_PROPERTY_SLEEP_STATE = 3,
>  	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE = 15,
>  	HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY = 21,
>  	HV_SYSTEM_PROPERTY_CRASHDUMPAREA = 47,
> @@ -155,6 +156,19 @@ union hv_pfn_range {            /* HV_SPA_PAGE_RANGE */
>  	} __packed;
>  };
>  
> +enum hv_sleep_state {
> +	HV_SLEEP_STATE_S1 = 1,
> +	HV_SLEEP_STATE_S2 = 2,
> +	HV_SLEEP_STATE_S3 = 3,
> +	HV_SLEEP_STATE_S4 = 4,
> +	HV_SLEEP_STATE_S5 = 5,
> +	/*
> +	 * After hypervisor has received this, any follow up sleep
> +	 * state registration requests will be rejected.
> +	 */
> +	HV_SLEEP_STATE_LOCK = 6
> +};
> +
>  enum hv_dynamic_processor_feature_property {
>  	/* Add more values when needed */
>  	HV_X64_DYNAMIC_PROCESSOR_FEATURE_MAX_ENCRYPTED_PARTITIONS = 13,
> @@ -184,6 +198,32 @@ struct hv_output_get_system_property {
>  	};
>  } __packed;
>  
> +struct hv_sleep_state_info {
> +	u32 sleep_state; /* enum hv_sleep_state */
> +	u8 pm1a_slp_typ;
> +	u8 pm1b_slp_typ;
> +} __packed;
> +
> +struct hv_input_set_system_property {
> +	u32 property_id; /* enum hv_system_property */
> +	u32 reserved;
> +	union {
> +		/* More fields to be filled in when needed */
> +		struct hv_sleep_state_info set_sleep_state_info;
> +
> +		/*
> +		 * Add a reserved field to ensure the union is 8-byte aligned as
> +		 * existing members may not be. This is a temporary measure
> +		 * until all remaining members are added.
> +		 */
> +		 u64 reserved0[8];
> +	};
> +} __packed;
> +
> +struct hv_input_enter_sleep_state {     /* HV_INPUT_ENTER_SLEEP_STATE */
> +	u32 sleep_state;        /* enum hv_sleep_state */
> +} __packed;
> +
>  struct hv_input_map_stats_page {
>  	u32 type; /* enum hv_stats_object_type */
>  	u32 padding;
> -- 
> 2.51.0

