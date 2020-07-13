Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B817721D3C9
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2020 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgGMKbp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jul 2020 06:31:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37513 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbgGMKbo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jul 2020 06:31:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id a6so15684185wrm.4;
        Mon, 13 Jul 2020 03:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CCePzgWtJFKcMgODa5jFeHTDF8NO0ER8pFarnzTDiDQ=;
        b=q6HCzAjeoeW2a0xyjVmlhkDaPuaycY0oZK63HPm2O2ApwY44YB7v/UXJiTd97/q+t/
         gDgmTQBBMwAo/KkMeCKF2A6ZJvPEzHoYV1TBAChD5LvR7ulPVhJoPHS12d7m4yJqQxwV
         3X1erC0yhO7HVZ+n2ESo3fmUnrUS4M0Fw4w13+gvWO75XgGe5eB+uFBwpWzCjpZ7xFve
         bf5CHbeUoO//roCxNO3zIDvzwZR3TwtNqYjnqj2P7a7bmp66EHD3tv9uzjiGm246JnRZ
         oAyh2sIMKHD4/RqPifBbNObszUO6JdANjce3twaZBR4zxEN0cTg9mnE1WIv26Y8CKo9+
         O4Uw==
X-Gm-Message-State: AOAM531ETy2T1hBb97ClwCaVDh1dinYxI0hfeDvKPknsR55lD4X/TvHd
        DDmBO9PpiAZ2/8rrJaSxHwc=
X-Google-Smtp-Source: ABdhPJwpeBitCzz5T9p3w+kPl4FZwVK1EF+ot37OC9F9q6oskqgCGysSapFH32WQblNKBRBPmXUsvg==
X-Received: by 2002:a5d:4b84:: with SMTP id b4mr82900296wrt.334.1594636302336;
        Mon, 13 Jul 2020 03:31:42 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b186sm6308931wme.1.2020.07.13.03.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 03:31:41 -0700 (PDT)
Date:   Mon, 13 Jul 2020 10:31:40 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, rdunlap@infradead.org,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, peterz@infradead.org,
        allison@lohutok.net, alexios.zavras@intel.com,
        gregkh@linuxfoundation.org, namit@vmware.com,
        mikelley@microsoft.com, longli@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [RESEND][PATCH v3] x86/apic/flat64: Add back the
 early_param("apic", parse_apic)
Message-ID: <20200713103140.xesdtvpczlfv6edb@liuwe-devbox-debian-v2>
References: <20200626182106.57219-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626182106.57219-1-decui@microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 26, 2020 at 11:21:06AM -0700, Dexuan Cui wrote:
> parse_apic() allows the user to try a different APIC driver than the
> default one that's automatically chosen. It works for X86-32, but
> doesn't work for X86-64 because it was removed in 2009 for X86-64 by
> commit 7b38725318f4 ("x86: remove subarchitecture support code"),
> whose changelog doesn't explicitly describe the removal for X86-64.
> 
> The patch adds back the functionality for X86-64. The intent is mainly
> to work around an APIC emulation bug in Hyper-V in the case of kdump:
> currently Hyper-V does not honor the disabled state of the local APICs,
> so all the IOAPIC-based interrupts may not be delivered to the correct
> virtual CPU, if the logical-mode APIC driver is used (the kdump
> kernel usually uses the logical-mode APIC driver, since typically
> only 1 CPU is active). Luckily the kdump issue can be worked around by
> forcing the kdump kernel to use physical mode, before the fix to Hyper-V
> becomes widely available.
> 
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
> 
> The patch is safe because if the apic= early param is not specified,
> the current algorithm of choosing an APIC driver is unchanged; when the
> param is specified (e.g. on X86-64, "apic=physical flat"), the kernel
> still tries to find a "more suitable" APIC driver in the above step 3 and
> 4: e.g. if the BIOS/firmware requires that apic_x2apic_phys should be used,
> the above step 4 will override the APIC driver to apic_x2apic_phys, even
> if an early_param "apic=physical flat" is specified.
> 
> On Hyper-V, when a Linux VM has <= 8 virtual CPUs, if we use
> "apic=physical flat", sending IPIs to multiple vCPUs is still fast because
> Linux VM uses the para-virtualized IPI hypercalls: see hv_apic_init().
> 
> The patch adds the __init tag for flat_acpi_madt_oem_check() and
> physflat_acpi_madt_oem_check() to avoid a warning seen with "make W=1":
> flat_acpi_madt_oem_check() accesses cmdline_apic, which has a __initdata
> tag.
> 
> Fixes: 7b38725318f4 ("x86: remove subarchitecture support code")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

[...]

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

This is a verbatim copy of the code in probe_32.c. Can you avoid the
duplication by moving the snippet from probe_32.c to apic.c?

You can declare cmdline_apic in local.h if you do that.

Wei.
