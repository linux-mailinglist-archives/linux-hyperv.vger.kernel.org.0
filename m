Return-Path: <linux-hyperv+bounces-6749-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71291B45CBA
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 17:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2678B17D1FA
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4788B2FB0A6;
	Fri,  5 Sep 2025 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9K0Zady"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7F2F7ACE;
	Fri,  5 Sep 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086808; cv=none; b=Wtkjska8U1MwCKrJa+47kVEN5qTYb6xKjQKr7RySPjajZvRpzYoFbZA/fLbHeiakjqw2ghFJEP9HOh8qRTCpkk6K+UxNimFLLD8R+Riwmxh4b4EHnEesxNxFtG5B9flhAzwF6V5fgOeG40YNqn6voXj+1wtDcaxaA4wwgUT9KpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086808; c=relaxed/simple;
	bh=RKl0oH9K/77QrV6Iu9zpJegJ6Grz5vWUbGNUph4Wk+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjDmZRX2Ftb1abdMvsNm2eysJv56JdqkB9WJTJQtSNR9tUFzaCn5UuggZMBh8g2V4c2eixZBTOQJUJYBkTFZpSmk9NG/O+VGgq4QuF4raC25rQCshnqM8bS+mH3ZIemdOFlHKF5oVeuIXz4HfuLbPTgi6QKY4Ri1NROTnpumPik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9K0Zady; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7459fa1ef2aso2353131a34.1;
        Fri, 05 Sep 2025 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757086806; x=1757691606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnLPWF2bAcQVbqrjz3TVGHgiOphWHv7Vq8hRwdfUIWg=;
        b=a9K0ZadytNdN6CY+GN59bVtfqHRd2dC07i9yhrnMYGQwcTGlN6ybn5hxSSWJTRlS/m
         BtfhlCRXnph7cGFUEfBpz2hjAvp2sI8Qnw6y22DwHaisyN5eVI52KumT6tKdM9R2h+77
         bnjF0MgL0xeh6/NZu37p4P7e5EyK7tPk2RdqyTJbJizFz7LwHKsJiVHovnUh9Avxz5sq
         p+OIyHCoQjGyTQqbTjQ3ehbB8U+7JEA302tUIo3htLYNUBjY3Feq5+R8gVT1bPbpuFHF
         nQN+Od6tKoUhTt6m40n9KmmyMfpg3HU31Jmx7dsQFa/u2kWHXgqyMu/t598KK7O8Pze6
         nasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757086806; x=1757691606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnLPWF2bAcQVbqrjz3TVGHgiOphWHv7Vq8hRwdfUIWg=;
        b=toRM0ENDfmN7z++P6EGJwjSMPmEEz2SnG7P9cleVFswtpSyuZYTACQoJlwA3GPgNlj
         jFTODcQ1fS0O6sE1K+kuAwMmtFB8vyTR8j4WHkeQlEV1EodasQogeFLxFnkj40+Rd4+s
         rGLmCWfkhSAwm4A4LPBtfuH/Mvns0gEKRyShm1uwTtxLvGexcsNfSRKB6N65v5SDB7n0
         zCS710e2+dcCh2wD+1NwV/q2nE+nNGg+Vuim4s4WROzVrJ3lghVhsay0Q3vOajUSwM7r
         bSk5qqXGlkxx806xkHMZa3usJyHswZlJeTOUTEpuVUq6Do81+FFa7hR4qwE0qlHxBoT9
         2d2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWChhF2SuGcr7YbgpXBmlAhZUqBnIAqhlj3rXK07dqzOl26Yxyn/+hwl4KxsqspsuB6JcYUA+5pMUKsvx4=@vger.kernel.org, AJvYcCWNxbD3KeqalJhMqBtgvIUzKbC7qU4yqy4/bs1BG3nQeewO8vxMhonerTJmYEBMP87Pujk3Ak3yXev6qFhY@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/klMhI3BF3ScJhSAaY9MtrR2aQCO9eSdhaOVCh8ikGJj2uvK
	RjaQPifwo0W7V2WEsGXVzCOgaejjFsK+BJ8xbT2lNU2qwxBn+Z86qQdV
X-Gm-Gg: ASbGnct6xxuUSEsJ7iAPTgTdjOm1Ggo8ojFogX/BmtxEQsKfARfzMuxTRt/Z8t/Kedf
	WHRpzNsbzDqcbHJ6wwjGMt1RASKHpas/vHr6Sa/g54lQ/JVqMXMItfTatxNNby+Qajrcxx94XXd
	vaXpxcBWEs+n5t5QHk7kAJI9/aH28+BVns6DWmysAY/QL9mGGLf9m3kx2X/2+oE1t4b6XcuZ/yr
	+J345jUbOsJ5jX8WXjGcVtA8fMtDFigdcmE6VyAINM0jtRE2VseQjRGvF4UsrtaBiZ51uP3oHHW
	yZzUnzUO1f4EdtegcYKKB0VwsuhPokbNssJX5vgfIZhng0edos2jUEASu4zgu08MJ5r4yS40S5m
	cMNfZS4xFbG4rAjXPJLfs9NN0GZvTHTpeorBO6fCFC5zWu+PgCKGt
X-Google-Smtp-Source: AGHT+IEmIw3f0aZNCO/f+i6InRqnfbv5gdPlLDM3Iu80lfYM79vGYYbtkKzB7IZZC4l/jjBzrOFOtA==
X-Received: by 2002:a05:6830:4d8e:20b0:745:902a:9c6b with SMTP id 46e09a7af769-745902aa25amr5826827a34.3.1757086805751;
        Fri, 05 Sep 2025 08:40:05 -0700 (PDT)
Received: from ?IPV6:2603:8081:c640:1::1007? ([2603:8081:c640:1::1007])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74647c1c2f9sm1800104a34.1.2025.09.05.08.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:40:05 -0700 (PDT)
Message-ID: <1801fe7b-4fb7-4fd7-a620-7a2095a9284d@gmail.com>
Date: Fri, 5 Sep 2025 10:40:03 -0500
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX
 hypercall
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-4-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Praveen K Paladugu <praveenkpaladugu@gmail.com>
In-Reply-To: <1756428230-3599-4-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/28/2025 7:43 PM, Nuno Das Neves wrote:
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
>   drivers/hv/mshv_root.h         |  2 ++
>   drivers/hv/mshv_root_hv_call.c | 31 ++++++++++++++++++++++++++
>   include/hyperv/hvgdk_mini.h    |  1 +
>   include/hyperv/hvhdk.h         | 40 ++++++++++++++++++++++++++++++++++
>   include/hyperv/hvhdk_mini.h    | 26 ++++++++++++++++++++++
>   5 files changed, 100 insertions(+)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index e3931b0f1269..4aeb03bea6b6 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -303,6 +303,8 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type type,
>   int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
>   				   u64 page_struct_count, u32 host_access,
>   				   u32 flags, u8 acquire);
> +int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code, u64 arg,
> +				      void *property_value, size_t property_value_sz);
>   
>   extern struct mshv_root mshv_root;
>   extern enum hv_scheduler_type hv_scheduler_type;
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index 1c38576a673c..7589b1ff3515 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -590,6 +590,37 @@ int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>   	return hv_result_to_errno(status);
>   }
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
>   int
>   hv_call_clear_virtual_interrupt(u64 partition_id)
>   {
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 79b7324e4ef5..1bde0aa102ec 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -490,6 +490,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
>   #define HVCALL_GET_VP_STATE				0x00e3
>   #define HVCALL_SET_VP_STATE				0x00e4
>   #define HVCALL_GET_VP_CPUID_VALUES			0x00f4
> +#define HVCALL_GET_PARTITION_PROPERTY_EX		0x0101
>   #define HVCALL_MMIO_READ				0x0106
>   #define HVCALL_MMIO_WRITE				0x0107
>   
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 57f3f9c2a685..fd3555def008 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -411,6 +411,46 @@ struct hv_input_set_partition_property {
>   	u64 property_value;
>   } __packed;
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
>   enum hv_vp_state_page_type {
>   	HV_VP_STATE_PAGE_REGISTERS = 0,
>   	HV_VP_STATE_PAGE_INTERCEPT_MESSAGE = 1,
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 858f6a3925b3..bf2ce27dfcc5 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -96,8 +96,34 @@ enum hv_partition_property_code {
>   	HV_PARTITION_PROPERTY_XSAVE_STATES                      = 0x00060007,
>   	HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE		= 0x00060008,
>   	HV_PARTITION_PROPERTY_PROCESSOR_CLOCK_FREQUENCY		= 0x00060009,
> +
> +	/* Extended properties with larger property values */
> +	HV_PARTITION_PROPERTY_VMM_CAPABILITIES			= 0x00090007,
>   };
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
>   enum hv_snp_status {
>   	HV_SNP_STATUS_NONE = 0,
>   	HV_SNP_STATUS_AVAILABLE = 1,

Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>

