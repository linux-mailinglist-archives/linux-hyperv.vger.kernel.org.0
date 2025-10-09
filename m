Return-Path: <linux-hyperv+bounces-7176-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4869CBCAAD8
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Oct 2025 21:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936943C78C3
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Oct 2025 19:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE49E245022;
	Thu,  9 Oct 2025 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Gkmh54JQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1DF1E0E1F;
	Thu,  9 Oct 2025 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037762; cv=none; b=JC7/jEgRGdruvD2hz+zn5pUqyqEqdWTHrf7DYD72N8j8mjTmu5TSmUOMSmg3fXi2GGXIixhlgdOy+I4wR8nb8sN+arR4eUNT9pPToWWo3P+GLhSj1pkflIXQ5+IVQebzpXs7Webtfm348izCFG36FIciwyq0DfaZkRwHirtke90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037762; c=relaxed/simple;
	bh=Fk9cSATlVh21jfOWJypHKa1pvdY171ZyTYISHIUTdRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhYCkQIS6x7/DZ7lg9x/CqAn7CfEAlDy49LFCNnwzdIs//sGywr7RS74nveaSfYSG3h15l+2PTynFc73EZP6Am9dlu8WDMCcX77tt3HU8dCso8G8KJ3iksGP8skGbSyQU5YDIifBAJFTlmrutLiqCCkvNMSz8mY1domVXlJJ8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Gkmh54JQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.193.78] (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C6F32038B77;
	Thu,  9 Oct 2025 12:22:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C6F32038B77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760037760;
	bh=9iGJljTf82FVEBJBrTnWOZAa2x8x399u8WqlqZg1Nts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gkmh54JQE50kAWCVp2RcNolcOBgrFEggJQqobf1OqmweT2aWs9VuBnqzWZ9hRW1NJ
	 cyvqBlHM7P24Qv/q5kClXCzZqV8uZ88gck25RFkoN4jLuUHiLSW1gmn9A5jamrTLm5
	 +Jbr3mEu3Hy4VafO+ARm+dOKrMq5urbw+669DuXo=
Message-ID: <d975bc21-9ec0-497d-a481-a7f0c282d5b5@linux.microsoft.com>
Date: Thu, 9 Oct 2025 12:22:39 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hyperv: Add definitions for MSHV sleep state
 configuration
To: Praveen K Paladugu <prapal@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de
Cc: anbelski@linux.microsoft.com
References: <20251009160501.6356-1-prapal@linux.microsoft.com>
 <20251009160501.6356-2-prapal@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20251009160501.6356-2-prapal@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/2025 8:58 AM, Praveen K Paladugu wrote:
> Add the definitions required to configure sleep states in mshv hypervsior.
> 
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |  4 +++-
>  include/hyperv/hvhdk_mini.h | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 77abddfc750e..943df5d292f2 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -464,18 +464,20 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_RESET_DEBUG_SESSION			0x006b
>  #define HVCALL_MAP_STATS_PAGE				0x006c
>  #define HVCALL_UNMAP_STATS_PAGE				0x006d
> +#define HVCALL_SET_SYSTEM_PROPERTY			0x006f
>  #define HVCALL_ADD_LOGICAL_PROCESSOR			0x0076
>  #define HVCALL_GET_SYSTEM_PROPERTY			0x007b
>  #define HVCALL_MAP_DEVICE_INTERRUPT			0x007c
>  #define HVCALL_UNMAP_DEVICE_INTERRUPT			0x007d
>  #define HVCALL_RETARGET_INTERRUPT			0x007e
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
> index 858f6a3925b3..8fa86c014c25 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -114,10 +114,24 @@ enum hv_snp_status {
>  
>  enum hv_system_property {
>  	/* Add more values when needed */
> +	HV_SYSTEM_PROPERTY_SLEEP_STATE = 3,
>  	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE = 15,
>  	HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY = 21,
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
> @@ -145,6 +159,25 @@ struct hv_output_get_system_property {
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

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

