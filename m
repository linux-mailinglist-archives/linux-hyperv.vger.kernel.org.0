Return-Path: <linux-hyperv+bounces-5475-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AD0AB3CBF
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 17:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28D43A8D10
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 15:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C67241139;
	Mon, 12 May 2025 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKVnn6nN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F823F26A;
	Mon, 12 May 2025 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065258; cv=none; b=WBfwdx4nexQ/KMg1dL4+iEQ/cmi+Bo39/sDpjF15xYXKJCxUOJIx6yIkRou0nWpCOGswbgfLj6+/tvpTIkvwvUjOxHiVAcioISfoUtX32NiAF9xX5Zp0d+ta7NXLhENHdLwIpXe2xY4/zlgO8ApKwkAMzi/7LiPTmWAO+rPucRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065258; c=relaxed/simple;
	bh=JdI7oAucpfQga6SNtoLiK1x85u5SQLaTRYXuixnOt4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPpLssUiR2svlMTkpYsuW/6V1HytHbWVWvRm1yV2S2Rru+VFKEtmChq6l9VsMPbCAncmYYtLBEkRe51Tzk5fMHeGMMhuBGQVAMVjyPykT9BndL+IYlx8ZrUMwkOTP72Rq0jR7Esvq0xDIrr/V8U3KUIO2oe/hKw99HN9a3gM2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKVnn6nN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D85C4CEEE;
	Mon, 12 May 2025 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747065257;
	bh=JdI7oAucpfQga6SNtoLiK1x85u5SQLaTRYXuixnOt4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKVnn6nNqrhq6Q+AAGFNEXibBRnCZWPSyDqyX/O/H+8/zqBEKr1V1SVWA63GKTFIH
	 Ed1/NrUZ15r8V2j0V6TBNG6+1wI4OvxPS2q/ErNT778UgegY8hlf50NRgEbYHLVU9X
	 cyN6o3waLbXTcDfzEVlmMAlYoKg8k8NNp2phmKNqNGxJJmnPhXZ1U8F09v01jpcB+P
	 UalbxAooBTwOf42N+GorCynaQxGinWvHgk91vCQtY/K3Hht133RuD+W33eNEs4mq8i
	 eP/OZQ/r9AFM++7Tbl3jQnuXR7GwF2Gd2JNvZzUEIkaKlYOVul1LmmpUI3IzUo2mrK
	 pw4JpAtM+1z/Q==
Date: Mon, 12 May 2025 10:54:15 -0500
From: Rob Herring <robh@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, devicetree@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v3 05/13] x86/dt: Parse the `enable-method` property of
 CPU nodes
Message-ID: <20250512155415.GB3377771-robh@kernel.org>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-6-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503191515.24041-6-ricardo.neri-calderon@linux.intel.com>

On Sat, May 03, 2025 at 12:15:07PM -0700, Ricardo Neri wrote:
> Add functionality to parse and validate the `enable-method` property for
> platforms that use alternative methods to wakeup secondary CPUs (e.g., a
> wakeup mailbox).
> 
> Most x86 platforms boot secondary CPUs using INIT assert, de-assert
> followed by a Start-Up IPI messages. These systems do no need to specify an
> `enable-method` property in the cpu@N nodes of the DeviceTree.
> 
> Although it is possible to specify a different `enable-method` for each
> secondary CPU, the existing functionality relies on using the
> APIC wakeup_secondary_cpu{ (), _64()} callback to wake up all CPUs. Ensure
> that either all CPUs specify the same `enable-method` or none at all.
> 
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>  - Introduced this patch.
> 
> Changes since v1:
>  - N/A
> ---
>  arch/x86/kernel/devicetree.c | 88 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 86 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index dd8748c45529..5835afc74acd 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -127,8 +127,59 @@ static void __init dtb_setup_hpet(void)
>  
>  #ifdef CONFIG_X86_LOCAL_APIC
>  
> +#ifdef CONFIG_SMP
> +static const char *dtb_supported_enable_methods[] __initconst = { };

If you expect this list to grow, I would say the firmware should support 
"spin-table" enable-method and let's stop the list before it starts. 
Look at the mess that's arm32 enable-methods... Considering you have no 
interrupts, I imagine what you have is not much different from a 
spin-table (write a jump address to an address)? Maybe it would already 
work as long as jump table is reserved (And in that case you don't need 
the compatible or any binding other than for cpu nodes).

OTOH, as the wakeup-mailbox seems to be defined by ACPI, that seems 
fine to add, but I would simplify the code here to not invite more 
entries. Further ones should be rejected IMO.

> +
> +static bool __init dtb_enable_method_is_valid(const char *enable_method_a,
> +					      const char *enable_method_b)
> +{
> +	int i;
> +
> +	if (!enable_method_a && !enable_method_b)
> +		return true;
> +
> +	if (strcmp(enable_method_a, enable_method_b))
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(dtb_supported_enable_methods); i++) {
> +		if (!strcmp(enable_method_a, dtb_supported_enable_methods[i]))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int __init dtb_configure_enable_method(const char *enable_method)
> +{
> +	/* Nothing to do for a missing enable-method or if the system has one CPU */
> +	if (!enable_method || IS_ERR(enable_method))
> +		return 0;
> +
> +	return -ENOTSUPP;
> +}
> +#else /* !CONFIG_SMP */
> +static inline bool dtb_enable_method_is_valid(const char *enable_method_a,
> +					      const char *enable_method_b)
> +{
> +	/* No secondary CPUs. We do not care about the enable-method. */
> +	return true;
> +}
> +
> +static inline int dtb_configure_enable_method(const char *enable_method)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_SMP */
> +
> +static void __init dtb_register_apic_id(u32 apic_id, struct device_node *dn)
> +{
> +	topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
> +	set_apicid_to_node(apic_id, of_node_to_nid(dn));
> +}
> +
>  static void __init dtb_cpu_setup(void)
>  {
> +	const char *enable_method = ERR_PTR(-EINVAL), *this_em;
>  	struct device_node *dn;
>  	u32 apic_id;
>  
> @@ -138,9 +189,42 @@ static void __init dtb_cpu_setup(void)
>  			pr_warn("%pOF: missing local APIC ID\n", dn);
>  			continue;
>  		}
> -		topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
> -		set_apicid_to_node(apic_id, of_node_to_nid(dn));
> +
> +		/*
> +		 * Also check the enable-method of the secondary CPUs, if present.
> +		 *
> +		 * Systems that use the INIT-!INIT-StartUp IPI sequence to boot
> +		 * secondary CPUs do not need to define an enable-method.
> +		 *
> +		 * All CPUs must have the same enable-method. The enable-method
> +		 * must be supported. If absent in one secondary CPU, it must be
> +		 * absent for all CPUs.
> +		 *
> +		 * Compare the first secondary CPU with the rest. We do not care
> +		 * about the boot CPU, as it is enabled already.
> +		 */
> +
> +		if (apic_id == boot_cpu_physical_apicid) {
> +			dtb_register_apic_id(apic_id, dn);
> +			continue;
> +		}
> +
> +		this_em = of_get_property(dn, "enable-method", NULL);

Use typed accessors. of_property_match_string() would be good here. 
There's some desire to avoid more of_property_read_string() calls too 
because that leaks un-refcounted DT data to the caller (really only an 
issue in overlays).

> +
> +		if (IS_ERR(enable_method)) {
> +			enable_method = this_em;
> +			dtb_register_apic_id(apic_id, dn);
> +			continue;
> +		}
> +
> +		if (!dtb_enable_method_is_valid(enable_method, this_em))
> +			continue;
> +
> +		dtb_register_apic_id(apic_id, dn);
>  	}
> +
> +	if (dtb_configure_enable_method(enable_method))
> +		pr_err("enable-method '%s' needed but not configured\n", enable_method);
>  }
>  
>  static void __init dtb_lapic_setup(void)
> -- 
> 2.43.0
> 

