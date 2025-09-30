Return-Path: <linux-hyperv+bounces-7027-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AC2BAE98A
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Sep 2025 23:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DA13AE2B8
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Sep 2025 21:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9867528B407;
	Tue, 30 Sep 2025 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWb6Ppzu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0CD1F03F3;
	Tue, 30 Sep 2025 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266511; cv=none; b=aksCZ5j90rtFPrWzEig+p4ecCOKotixmOhB4mYOM358RQjt3BVkpoPUOR5jnSI7cglXWzIwcoS12ai9NxMSQ9sOqq00HD7h4piEEw4E14K6XcYsaScDI6YgApMB2MwBhBEdZJ/SbQPX6HMFL2k/mW0DLd1r7GK0bceCdM4SjVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266511; c=relaxed/simple;
	bh=ZAL0HOzeNQKMFeOr3SOV5m0bdPDZddnTRwkZby2vpGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUYvPH+4JBTGmVY8kMYOzIJ4cJ4vduLHLlgi/WlNa6i7ro+CI5zVr8YYtKBsDLvyqRY5YMzdeqHMqK6ANAShWVD2e2THGl/lhBF04DAzS0ioeiST3tvLaBurXTWa3+FFAEvQRmJp57J5kv8SnoCFmqfcc5/9cuXWhAJYuz23FRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWb6Ppzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5F9C4CEF0;
	Tue, 30 Sep 2025 21:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759266511;
	bh=ZAL0HOzeNQKMFeOr3SOV5m0bdPDZddnTRwkZby2vpGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kWb6Ppzu/o7rRrFRnH7qkJCRdOxle7mlQ79B74bB7L2F7zdyq4RYMk+npBtRASDSF
	 GYJRvDm2an67MQ7vreDFwMoIX7F2TUcyzu/MeLQ/EIP7leyea6Q+V4IPFARLCRBFZ9
	 OYl3hPRX2OHvGwaWjHUKO3hc7yZQTW3H7eH5rsUMib9mNhla5Nqx2zp+f5vXroSlN0
	 32upOUpx0sOJtfc6lUaqIWYoUqX+orbS9DnCE3IpGH9Hnb8Z037mM0nO/Z8l0NfLEw
	 58WNGIa5ycIRxhUoZrWNFG7rTYE3HmKkjetrJ7poubDfJJwAU3FprsGZ+N4wXbRFDD
	 u3vN0+d+GY1mQ==
Date: Tue, 30 Sep 2025 21:08:29 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 06/10] x86/realmode: Make the location of the
 trampoline configurable
Message-ID: <aNxGzWMoM_oQ6n1N@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-6-df547b1d196e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-6-df547b1d196e@linux.intel.com>

On Fri, Jun 27, 2025 at 08:35:12PM -0700, Ricardo Neri wrote:
> From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> 
> x86 CPUs boot in real mode. This mode uses 20-bit memory addresses (16-bit
> registers plus 4-bit segment selectors). This implies that the trampoline
> must reside under the 1MB memory boundary.
> 
> There are platforms in which the firmware boots the secondary CPUs,
> switches them to long mode and transfers control to the kernel. An example
> of such mechanism is the ACPI Multiprocessor Wakeup Structure.
> 
> In this scenario there is no restriction to locate the trampoline under 1MB
> memory. Moreover, certain platforms (for example, Hyper-V VTL guests) may
> not have memory available for allocation under 1MB.
> 
> Add a new member to struct x86_init_resources to specify the upper bound
> for the location of the trampoline memory. Keep the default upper bound of
> 1MB to conserve the current behavior.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Thomas, this is originally your idea. I take it you will be fine this
patch. I can pick this up in the Hyper-V tree.

Let me know otherwise.

Thanks,
Wei

> ---
> Changes since v4:
>  - None
> 
> Changes since v3:
>  - Added Reviewed-by tag from Michael. Thanks!
> 
> Changes since v2:
>  - Edited the commit message for clarity.
>  - Minor tweaks to comments.
>  - Removed the option to not reserve the first 1MB of memory as it is
>    not needed.
> 
> Changes since v1:
>  - Added this patch using code that Thomas suggested:
>    https://lore.kernel.org/lkml/87a5ho2q6x.ffs@tglx/
> ---
>  arch/x86/include/asm/x86_init.h | 3 +++
>  arch/x86/kernel/x86_init.c      | 3 +++
>  arch/x86/realmode/init.c        | 7 +++----
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index 36698cc9fb44..e770ce507a87 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -31,12 +31,15 @@ struct x86_init_mpparse {
>   *				platform
>   * @memory_setup:		platform specific memory setup
>   * @dmi_setup:			platform specific DMI setup
> + * @realmode_limit:		platform specific address limit for the real mode trampoline
> + *				(default 1M)
>   */
>  struct x86_init_resources {
>  	void (*probe_roms)(void);
>  	void (*reserve_resources)(void);
>  	char *(*memory_setup)(void);
>  	void (*dmi_setup)(void);
> +	unsigned long realmode_limit;
>  };
>  
>  /**
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index 0a2bbd674a6d..a25fd7282811 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -9,6 +9,7 @@
>  #include <linux/export.h>
>  #include <linux/pci.h>
>  #include <linux/acpi.h>
> +#include <linux/sizes.h>
>  
>  #include <asm/acpi.h>
>  #include <asm/bios_ebda.h>
> @@ -69,6 +70,8 @@ struct x86_init_ops x86_init __initdata = {
>  		.reserve_resources	= reserve_standard_io_resources,
>  		.memory_setup		= e820__memory_setup_default,
>  		.dmi_setup		= dmi_setup,
> +		/* Has to be under 1M so we can execute real-mode AP code. */
> +		.realmode_limit		= SZ_1M,
>  	},
>  
>  	.mpparse = {
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 88be32026768..694d80a5c68e 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -46,7 +46,7 @@ void load_trampoline_pgtable(void)
>  
>  void __init reserve_real_mode(void)
>  {
> -	phys_addr_t mem;
> +	phys_addr_t mem, limit = x86_init.resources.realmode_limit;
>  	size_t size = real_mode_size_needed();
>  
>  	if (!size)
> @@ -54,10 +54,9 @@ void __init reserve_real_mode(void)
>  
>  	WARN_ON(slab_is_available());
>  
> -	/* Has to be under 1M so we can execute real-mode AP code. */
> -	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, 1<<20);
> +	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, limit);
>  	if (!mem)
> -		pr_info("No sub-1M memory is available for the trampoline\n");
> +		pr_info("No memory below %pa for the real-mode trampoline\n", &limit);
>  	else
>  		set_real_mode_mem(mem);
>  
> 
> -- 
> 2.43.0
> 

