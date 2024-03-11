Return-Path: <linux-hyperv+bounces-1713-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B6C87873F
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 19:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791452826EF
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CB953E0A;
	Mon, 11 Mar 2024 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eP/1yYXB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D524206B;
	Mon, 11 Mar 2024 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181604; cv=none; b=rpRnN6YI6SQB5MWYlGys2EsQOEgaxfAik+Q8SSv7+yFZiyCK1SYSUcaaXPdhBiv3zRTLM5OBdT6c/JQhNmzfi2qWcL9HoOOojytS0zr9cFBVyOPh4CW+tzWFTv5HZxJgQrh9+YTfCiMSOIB4lS0Rhia47fliEzfHrxCFtKDyj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181604; c=relaxed/simple;
	bh=a4JyKkLCCbO+MulXcAirdwxtoQe9OwOjnOmaZZ2bKBk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=n11RLy31gA0CLy+7gldOGCgY9da5oQYejIdB0qvWli7kUdc/Sfys6hnUIrTn5GRsLKrkDnZ5DRW+oymHO4zbHJOxvDbMxCqRP2EQ3Guw5jB9Duxikn+29mZOLTlqioPb/AxkwC9SuOAUl/4D4jkNX/CF0v2ybOx569U/vaOeuZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eP/1yYXB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-24-16-32-44.hsd1.wa.comcast.net [24.16.32.44])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2115720B74C0;
	Mon, 11 Mar 2024 11:26:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2115720B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710181602;
	bh=Bdqb9HLBXGUlrozZBR7+QNODKCVBETr0bgd76Woo+0w=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=eP/1yYXBcoNL7inNHVfJ/dTgmvtoh4xrKyj1xzFODwmvac1XLVRQLnEfQwTTCAzDT
	 gT1GJKGVBHr8O3Be8eUxg2dZ7Br/Vn6ApDxzkftjDmMA9f0wzQ3Ol6x15oS2jyvLNj
	 sdNf6OII+zVL0GYtoSKyEbJfTw6uxHqRMbod9bss=
Message-ID: <a2cb9fad-0109-4f1b-9996-35eb11b62435@linux.microsoft.com>
Date: Mon, 11 Mar 2024 11:26:40 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mshyperv: Introduce hv_get_hypervisor_version function
Content-Language: en-CA
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mhkelley58@gmail.com, haiyangz@microsoft.com, mhklinux@outlook.com,
 kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 catalin.marinas@arm.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
 arnd@arndb.de
References: <1709852618-29110-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1709852618-29110-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/2024 3:03 PM, Nuno Das Neves wrote:
> Introduce x86_64 and arm64 functions to get the hypervisor version
> information and store it in a structure for simpler parsing.
> 
> Use the new function to get and parse the version at boot time. While at
> it, move the printing code to hv_common_init() so it is not duplicated.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> ---
> Changes since v1:
> - Amend commit message
> - Address minor style issues
> - Remove unneeded EXPORT_SYMBOL_GPL(hv_get_hypervisor_version)
> ---
>  arch/arm64/hyperv/mshyperv.c      | 18 ++++++++--------
>  arch/x86/kernel/cpu/mshyperv.c    | 34 ++++++++++++++-----------------
>  drivers/hv/hv_common.c            |  8 ++++++++
>  include/asm-generic/hyperv-tlfs.h | 23 +++++++++++++++++++++
>  include/asm-generic/mshyperv.h    |  1 +
>  5 files changed, 55 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index f1b8a04ee9f2..99362716ac87 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -19,10 +19,17 @@
>  
>  static bool hyperv_initialized;
>  
> +int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
> +{
> +	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
> +			 (struct hv_get_vp_registers_output *)info);
> +
> +	return 0;
> +}
> +
>  static int __init hyperv_init(void)
>  {
>  	struct hv_get_vp_registers_output	result;
> -	u32	a, b, c, d;
>  	u64	guest_id;
>  	int	ret;
>  
> @@ -54,15 +61,6 @@ static int __init hyperv_init(void)
>  		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
>  		ms_hyperv.misc_features);
>  
> -	/* Get information about the Hyper-V host version */
> -	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
> -	a = result.as32.a;
> -	b = result.as32.b;
> -	c = result.as32.c;
> -	d = result.as32.d;
> -	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> -		b >> 16, b & 0xFFFF, a,	d & 0xFFFFFF, c, d >> 24);
> -
>  	ret = hv_common_init();
>  	if (ret)
>  		return ret;
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index d306f6184cee..56e731d8f513 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -350,13 +350,24 @@ static void __init reduced_hw_init(void)
>  	x86_init.irqs.pre_vector_init	= x86_init_noop;
>  }
>  
> +int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
> +{
> +	unsigned int hv_max_functions;
> +
> +	hv_max_functions = cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
> +	if (hv_max_functions < HYPERV_CPUID_VERSION) {
> +		pr_err("%s: Could not detect Hyper-V version\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	cpuid(HYPERV_CPUID_VERSION, &info->eax, &info->ebx, &info->ecx, &info->edx);
> +
> +	return 0;
> +}
> +
>  static void __init ms_hyperv_init_platform(void)
>  {
>  	int hv_max_functions_eax;
> -	int hv_host_info_eax;
> -	int hv_host_info_ebx;
> -	int hv_host_info_ecx;
> -	int hv_host_info_edx;
>  
>  #ifdef CONFIG_PARAVIRT
>  	pv_info.name = "Hyper-V";
> @@ -407,21 +418,6 @@ static void __init ms_hyperv_init_platform(void)
>  		pr_info("Hyper-V: running on a nested hypervisor\n");
>  	}
>  
> -	/*
> -	 * Extract host information.
> -	 */
> -	if (hv_max_functions_eax >= HYPERV_CPUID_VERSION) {
> -		hv_host_info_eax = cpuid_eax(HYPERV_CPUID_VERSION);
> -		hv_host_info_ebx = cpuid_ebx(HYPERV_CPUID_VERSION);
> -		hv_host_info_ecx = cpuid_ecx(HYPERV_CPUID_VERSION);
> -		hv_host_info_edx = cpuid_edx(HYPERV_CPUID_VERSION);
> -
> -		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> -			hv_host_info_ebx >> 16, hv_host_info_ebx & 0xFFFF,
> -			hv_host_info_eax, hv_host_info_edx & 0xFFFFFF,
> -			hv_host_info_ecx, hv_host_info_edx >> 24);
> -	}
> -
>  	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
>  	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
>  		x86_platform.calibrate_tsc = hv_get_tsc_khz;
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 2f1dd4b07f9a..5d64cb0a709d 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -278,6 +278,14 @@ static void hv_kmsg_dump_register(void)
>  int __init hv_common_init(void)
>  {
>  	int i;
> +	union hv_hypervisor_version_info version;
> +
> +	/* Get information about the Hyper-V host version */
> +	if (!hv_get_hypervisor_version(&version))
> +		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> +			version.major_version, version.minor_version,
> +			version.build_number, version.service_number,
> +			version.service_pack, version.service_branch);
>  
>  	if (hv_is_isolation_supported())
>  		sysctl_record_panic_msg = 0;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 3d1b31f90ed6..32514a870b98 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -817,6 +817,29 @@ struct hv_input_unmap_device_interrupt {
>  #define HV_SOURCE_SHADOW_NONE               0x0
>  #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
>  
> +/*
> + * Version info reported by hypervisor
> + */
> +union hv_hypervisor_version_info {
> +	struct {
> +		u32 build_number;
> +
> +		u32 minor_version : 16;
> +		u32 major_version : 16;
> +
> +		u32 service_pack;
> +
> +		u32 service_number : 24;
> +		u32 service_branch : 8;
> +	};
> +	struct {
> +		u32 eax;
> +		u32 ebx;
> +		u32 ecx;
> +		u32 edx;
> +	};
> +};
> +
>  /*
>   * The whole argument should fit in a page to be able to pass to the hypervisor
>   * in one hypercall.
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 04424a446bb7..f8e7428f1e55 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -275,6 +275,7 @@ static inline int cpumask_to_vpset_skip(struct hv_vpset *vpset,
>  	return __cpumask_to_vpset(vpset, cpus, func);
>  }
>  
> +int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
>  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
>  bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);

fixup! mshyperv: Introduce hv_get_hypervisor_version function

---
 include/asm-generic/mshyperv.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index f8e7428f1e55..452b7c089b71 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -161,6 +161,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 	}
 }
 
+int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
+
 void hv_setup_vmbus_handler(void (*handler)(void));
 void hv_remove_vmbus_handler(void);
 void hv_setup_stimer0_handler(void (*handler)(void));
@@ -275,7 +277,6 @@ static inline int cpumask_to_vpset_skip(struct hv_vpset *vpset,
 	return __cpumask_to_vpset(vpset, cpus, func);
 }
 
-int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
 bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
-- 
2.25.1




