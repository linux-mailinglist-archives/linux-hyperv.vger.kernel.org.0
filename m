Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779B8223BD9
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jul 2020 15:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgGQNDJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Jul 2020 09:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgGQNDJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Jul 2020 09:03:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94ADC061755;
        Fri, 17 Jul 2020 06:03:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594990987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K67oesJG2nf2tuwx/U+5a5ylEwqGnasVmEPnOhGf1MA=;
        b=yUWrVUlWYt5L6J1zJGlMSoDUEeenk9WdAxLpAQL4rlrkm2ro6YsH/GzL0sy5ne7PhD/poK
        owreXWjU5n2WFnC8w34NQ1ZCGpSEAFCo14ukpLS9igkhE2F19QIVnJV7m3P37AWdOgJy51
        poJ3ZrRNygrl4kDVirbpyiO4qEOldOa+DkWBe9wxPRivWj04rKMCwzPLh4xgv/cxDSF87O
        fjetTkkmQybPvY/KoxLE9XFk4cu7yLOd1WazBNC6nP1WxYMj2m7UfAf4+da2d0OtWEP8f0
        pfZlY7dyabJE2dl1XVifxvBdtjMcsFH7M57tDWrT30nJ+ilrE/gyBwcvp20cFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594990987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K67oesJG2nf2tuwx/U+5a5ylEwqGnasVmEPnOhGf1MA=;
        b=Jtmdaz5zQ5M5bd+/nFtueKXuEHZ3fbzSRqIIqDF1d/JPtYIY2chJkpGIEWChjtF/SiTwo/
        KDLeiBjt/XoTc4Cw==
To:     Dexuan Cui <decui@microsoft.com>, mingo@redhat.com,
        rdunlap@infradead.org, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        peterz@infradead.org, allison@lohutok.net,
        alexios.zavras@intel.com, gregkh@linuxfoundation.org,
        decui@microsoft.com, namit@vmware.com, mikelley@microsoft.com,
        longli@microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [RESEND][PATCH v3] x86/apic/flat64: Add back the early_param("apic", parse_apic)
In-Reply-To: <20200626182106.57219-1-decui@microsoft.com>
References: <20200626182106.57219-1-decui@microsoft.com>
Date:   Fri, 17 Jul 2020 15:03:06 +0200
Message-ID: <87mu3ys391.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

What has the early param to do with apic/flat64?

> parse_apic() allows the user to try a different APIC driver than the
> default one that's automatically chosen. It works for X86-32, but
> doesn't work for X86-64 because it was removed in 2009 for X86-64 by
> commit 7b38725318f4 ("x86: remove subarchitecture support code"),
> whose changelog doesn't explicitly describe the removal for X86-64.

Well, the patches leading to this had the clear intent to simplify the
whole APIC code and the removal of that command line override was part
of that cleanup. Up to now nothing needed it at all.

> The patch adds back the functionality for X86-64. The intent is mainly

git grep 'This patch' Documentation/process 

> to work around an APIC emulation bug in Hyper-V in the case of kdump:
> currently Hyper-V does not honor the disabled state of the local APICs,
> so all the IOAPIC-based interrupts may not be delivered to the correct
> virtual CPU, if the logical-mode APIC driver is used (the kdump
> kernel usually uses the logical-mode APIC driver, since typically
> only 1 CPU is active). Luckily the kdump issue can be worked around by
> forcing the kdump kernel to use physical mode, before the fix to Hyper-V
> becomes widely available.

This is just another proof that virtualization creates more problems
than it solves.

> The current algorithm of choosing an APIC driver is:
>
> 1. The global pointer "struct apic *apic" has a default value, i.e
> "apic_default" on X86-32, and "apic_flat" on X86-64.
>
> 2. If the early_param "apic=" is specified, parse_apic() is called and
> the pointer "apic" is changed if a matching APIC driver is found.
>
> 3. default_acpi_madt_oem_check() calls the acpi_madt_oem_check() method
> of all APIC drivers, which may override the "apic" pointer.
>
> 4. default_setup_apic_routing() may override the "apic" pointer, e.g.
> by calling the probe() method of all APIC drivers. Note: refer to the
> order of the APIC drivers specified in arch/x86/kernel/apic/Makefile.

What's the 'current algorithm'? #2 is not in use on 64bit currently.

And looking at 32bit then the above decription is wrong. Once a command
line parameter is specified and matched then #3 and #4 do not override
anything. See the probe code in 32 bit.

> On Hyper-V, when a Linux VM has <= 8 virtual CPUs, if we use
> "apic=physical flat", sending IPIs to multiple vCPUs is still fast because
> Linux VM uses the para-virtualized IPI hypercalls: see hv_apic_init().

And this is relevant because?

> The patch adds the __init tag for flat_acpi_madt_oem_check() and
> physflat_acpi_madt_oem_check() to avoid a warning seen with "make W=1":
> flat_acpi_madt_oem_check() accesses cmdline_apic, which has a __initdata
> tag.

And both function have pointers stored in the corresponding apic
structs, i.e. after init these pointers become dangling. No...

Aside of that the only function which accesses cmdline_apic is
flat_acpi_madt_oem_check() according to the patch below.

> Fixes: 7b38725318f4 ("x86: remove subarchitecture support code")

This fixes tag is blantantly wrong. You want to add:

Fixes: Broken hypervisor

When this mess was removed hyperv still wore diapers.

>  			Format: { quiet (default) | verbose | debug }
>  			Change the amount of debugging information output
>  			when initialising the APIC and IO-APIC components.
> -			For X86-32, this can also be used to specify an APIC
> -			driver name.
> +			This can also be used to specify an APIC driver name.
>  			Format: apic=driver_name
> -			Examples: apic=bigsmp
> +			Examples:
> +			  On X86-32:  apic=bigsmp
> +			  On X86-64: "apic=physical flat"
> +			  Note: the available driver names depend on the
> +			  architecture and the kernel config; the setting may
> +			  be overridden by the acpi_madt_oem_check() and probe()
> +			  methods of other APIC drivers.

Which is wrong because that's not true for 32bit.

> @@ -2855,13 +2855,10 @@ static int __init apic_set_verbosity(char *arg)
>  		apic_verbosity = APIC_DEBUG;
>  	else if (strcmp("verbose", arg) == 0)
>  		apic_verbosity = APIC_VERBOSE;
> -#ifdef CONFIG_X86_64
> -	else {
> -		pr_warn("APIC Verbosity level %s not recognised"
> -			" use apic=verbose or apic=debug\n", arg);
> -		return -EINVAL;
> -	}
> -#endif
> +
> +	/* Ignore unrecognized verbosity level setting. */
> +
> +	pr_info("APIC Verbosity level is %d\n", apic_verbosity);

We need that printk on every boot because?

>  
>  	return 0;
>  }
> diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
> index 7862b152a052..da8f3640453f 100644
> --- a/arch/x86/kernel/apic/apic_flat_64.c
> +++ b/arch/x86/kernel/apic/apic_flat_64.c
> @@ -23,9 +23,34 @@ static struct apic apic_flat;
>  struct apic *apic __ro_after_init = &apic_flat;
>  EXPORT_SYMBOL_GPL(apic);
>  
> -static int flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
> +static int cmdline_apic __initdata;
> +static int __init parse_apic(char *arg)
>  {
> -	return 1;
> +	struct apic **drv;
> +
> +	if (!arg)
> +		return -EINVAL;
> +
> +	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
> +		if (!strcmp((*drv)->name, arg)) {
> +			apic = *drv;
> +			cmdline_apic = 1;
> +			return 0;
> +		}
> +	}
> +
> +	/* Parsed again by __setup for debug/verbose */
> +	return 0;
> +}
> +early_param("apic", parse_apic);

We surely need yet another copy of the code in probe_32.c

> +static int __init flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
> +{
> +	if (!cmdline_apic)
> +		return 1;
> +
> +	return apic == &apic_flat;

Comments are overrated...

>  }
>  
>  /*
> @@ -157,7 +182,7 @@ static struct apic apic_flat __ro_after_init = {
>   * We cannot use logical delivery in this case because the mask
>   * overflows, so use physical mode.
>   */
> -static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
> +static int __init physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
>  {

See above ...

But why do you need all this if it is only relevant for a crash dump
kernel? Can't this be simply cured by using 'nolapic' on the kernel
command line?

Even if you must have the local apic for whatever reason in the kdump
kernel then this can be completely done w/o command line hackery simply
because its only required for the mshypervers + kdump case.

Thanks,

        tglx
---
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -176,6 +176,13 @@ static int physflat_acpi_madt_oem_check(
 		return 1;
 	}
 #endif
+	/*
+	 * Workaround for a bug in the MS hypervisor which fails to reset
+	 * the APIC properly when a kernel crash jumps into the kdump
+	 * kernel.
+	 */
+	if (hypervisor_is_type(X86_HYPER_MS_HYPERV) && is_kdump_kernel())
+		return 1;
 
 	return 0;
 }
