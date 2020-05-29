Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B81F1E7ECE
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2020 15:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgE2NdJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 May 2020 09:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgE2NdI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 May 2020 09:33:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7161C03E969;
        Fri, 29 May 2020 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=RGL+y9NOcTeaeonO432mTywIGtAKUuDfA6X3LNU3o7s=; b=leVbbmovqVdJWzUoztoloA16Py
        y5JqNpn2j0113oKvV1KHL85kPjmuqC9NJ+zVjxqWc7j6QAEtYDlA/wOF88O9Tmr4knbmTM2vNd0sa
        Ry5ZPjyfNMzzgC8sczIxzEAWMUavjmAsqov5DJKP7FmF3XCoOrrIXrz5eSZr0DZzZihlrzMQQDRaH
        rtzek78AV9xkAuMtgjuCSaQMjQ/p+SLagyOC937/RzX8j3znAmOLUQ8i2BTZrbzjRccCFbCdQwYLk
        tEw0f5xzB/aCE/PvpCBra8VOQ60jz/a+EDF2dkLIvzU9zG1SBEBMHZumWR4ZlUFoRBUXl/3AqRrE7
        U8/bF9MA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jef8C-0005RZ-HC; Fri, 29 May 2020 13:33:04 +0000
Subject: Re: [PATCH] x86/apic/flat64: Add back the early_param("apic",
 parse_apic)
To:     Dexuan Cui <decui@microsoft.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        peterz@infradead.org, allison@lohutok.net,
        alexios.zavras@intel.com, gregkh@linuxfoundation.org,
        namit@vmware.com, mikelley@microsoft.com, longli@microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20200529063729.22047-1-decui@microsoft.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <928eb231-242c-d2b1-d40b-a2892c55b415@infradead.org>
Date:   Fri, 29 May 2020 06:33:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529063729.22047-1-decui@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 5/28/20 11:37 PM, Dexuan Cui wrote:
> parse_apic() allows the user to try a different apic driver than the
> default one that's automatically chosen. It works for x86_32, but
> doesn't work for x86_64 becauase it was removed in 2009 for x86_64 by:
> commit 7b38725318f4 ("x86: remove subarchitecture support code"),
> whose changelog doesn't explicitly describe the removal for x86_64.
> 
> The patch adds back the functionality for x86_64. The intent is mainly
> to work around an APIC emulation bug in Hyper-V in the case of kdump:
> currently Hyper-V does not honor the disabled state of the local APICs,
> and all the IOAPIC-based interrupts may not be delivered to the correct
> virtual CPU, if the logical-mode APIC driver is used (the kdump
> kernel usually uses the logical-mode APIC driver, since typically
> only 1 CPU is active). Luckily the kdump issue can be worked around by
> forcing the kdump kernel to use physical mode, before the fix to Hyper-V
> becomes widely available.
> 
> IMHO the patch is safe because the current default algorithm to choose
> the apic driver is unchanged; the patch makes a difference only when
> the user specifies the apic= kernel parameter, e.g. "apic=physical flat".
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/kernel/apic/apic_flat_64.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)

Hi,
Looks like you will also need to update
Documentation/admin-guide/kernel-parameters.txt, where it says:

			For X86-32, this can also be used to specify an APIC
			driver name.


> diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
> index 7862b152a052..efbec63bb01f 100644
> --- a/arch/x86/kernel/apic/apic_flat_64.c
> +++ b/arch/x86/kernel/apic/apic_flat_64.c
> @@ -23,9 +23,34 @@ static struct apic apic_flat;
>  struct apic *apic __ro_after_init = &apic_flat;
>  EXPORT_SYMBOL_GPL(apic);
>  
> +static int cmdline_apic __initdata;
> +static int __init parse_apic(char *arg)
> +{
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
> +
> +
>  static int flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
>  {
> -	return 1;
> +	if (!cmdline_apic)
> +		return 1;
> +
> +	return apic == &apic_flat;
>  }
>  
>  /*
> 


-- 
~Randy

