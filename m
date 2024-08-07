Return-Path: <linux-hyperv+bounces-2748-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847AE94AEF7
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 19:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B3FB21DC1
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9602F13C9A2;
	Wed,  7 Aug 2024 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KSpGaFRJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sERAv430"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62C12C465;
	Wed,  7 Aug 2024 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723052010; cv=none; b=TaGxW3Ifv0CTSjTa/qSkIsuvJzLJ+reWXTnKA4RUmw1Z8a3FNIUDykP6MBMyRKLmTlTcKy6J3y5JWrIjfmLoX2+g26M9qSxUlPF6emV460FNunMAKok8gp89xhTfmhCp1zx1ws7XTF4Un2fnE291/xT8HO9B2uvae7LGhCCuZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723052010; c=relaxed/simple;
	bh=k5Q4CZ8cUfM1zYiJ/MG0eS7kuEq1mdGVpXNIl1FNhYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FkGD/v8uOo4lVV824yBbBgiEZT/B9DI9RVzjBzwPyGslo/vj7tzWmmj6aNyxBnAZ0pt+EZaSlacYx6SE5E9VQel6xm/v25BwPuz3fJdM4B9qsvl/ieizs5yP4m9vI9HD/xxtEfidurhAKgiE94GN8850+6smjjeCM8MMXrzIjZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KSpGaFRJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sERAv430; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723052007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuqh98j/r4CgK85vbcGJbJsFxU9Ph3Ujqns0jxVK4rk=;
	b=KSpGaFRJjJqdYd2TE3dKamP43ILEw+i4AnMR6H7g0AivhWljstUXJnasMe0Jx3DkS9EJJa
	NjDV3SibOT1ES+2gOdsfoXp7b96IpdA86fNxYxwept1zelRiEshaVM366AbCzuUliy723C
	eDDL8FNm1Gwvx4fTevugizs/VWz5I/+iN/BAZSqjbWtQ6ud2RxUkx5hJ5z3+ch/mYgSSzz
	8q6QQFO6ENFwqiUJ/BRXx+sSMFvLFxTxP5cm7fK9tZSh/m23Vx7ZS5ztdN1+hi8hYUHlJd
	wy/Nx3K396D3dRVxfkhFCD32AQaPn59QLCWtypAzWNJZ+j6t2F+nWyonMGLbpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723052007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuqh98j/r4CgK85vbcGJbJsFxU9Ph3Ujqns0jxVK4rk=;
	b=sERAv430bitc2W3PXrAlMhOokYz+X84Wg06SWRIFgozuoJrjLNnrauo2nv7ZgTVN7isig3
	EX6IA11ofipHk7CQ==
To: Yunhong Jiang <yunhong.jiang@linux.intel.com>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, rafael@kernel.org, lenb@kernel.org,
 kirill.shutemov@linux.intel.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
 yunhong.jiang@linux.intel.com
Subject: Re: [PATCH 6/7] x86/hyperv: Reserve real mode when ACPI wakeup
 mailbox is available
In-Reply-To: <20240806221237.1634126-7-yunhong.jiang@linux.intel.com>
References: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
 <20240806221237.1634126-7-yunhong.jiang@linux.intel.com>
Date: Wed, 07 Aug 2024 19:33:26 +0200
Message-ID: <87a5ho2q6x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 06 2024 at 15:12, Yunhong Jiang wrote:
> +static void __init hv_reserve_real_mode(void)
> +{
> +	phys_addr_t mem;
> +	size_t size = real_mode_size_needed();
> +
> +	/*
> +	 * We only need the memory to be <4GB since the 64-bit trampoline goes
> +	 * down to 32-bit mode.
> +	 */
> +	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, SZ_4G);
> +	if (!mem)
> +		panic("No sub-4G memory is available for the trampoline\n");
> +	set_real_mode_mem(mem);
> +}

We really don't need another copy of reserve_real_mode(). See uncompiled
patch below. It does not panic when the allocation fails, but why do you
want to panic in that case? If it's not there then the system boots with
a single CPU, so what.

>  void __init hv_vtl_init_platform(void)
>  {
>  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
>  
>  	if (wakeup_mailbox_addr) {
>  		x86_platform.hyper.is_private_mmio = hv_is_private_mmio_tdx;
> +		x86_platform.realmode_reserve = hv_reserve_real_mode;
>  	} else {
>  		x86_platform.realmode_reserve = x86_init_noop;
>  		x86_platform.realmode_init = x86_init_noop;
> @@ -259,7 +276,8 @@ int __init hv_vtl_early_init(void)
>  		panic("XSAVE has to be disabled as it is not supported by this module.\n"
>  			  "Please add 'noxsave' to the kernel command line.\n");
>  
> -	real_mode_header = &hv_vtl_real_mode_header;
> +	if (!wakeup_mailbox_addr)
> +		real_mode_header = &hv_vtl_real_mode_header;

Why is that not suffient to be done in hv_vtl_init_platform() inside the
condition which clears x86_platform.realmode_reserve/init?

x86_platform.realmode_init() is invoked from an early initcall while
hv_vtl_init_platform() is called during early boot.

Thanks,

        tglx
---
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -31,12 +31,18 @@ struct x86_init_mpparse {
  *				platform
  * @memory_setup:		platform specific memory setup
  * @dmi_setup:			platform specific DMI setup
+ * @realmode_limit:		platform specific address limit for the realmode trampoline
+ *				(default 1M)
+ * @reserve_bios:		platform specific address limit for reserving the BIOS area
+ *				(default 1M)
  */
 struct x86_init_resources {
 	void (*probe_roms)(void);
 	void (*reserve_resources)(void);
 	char *(*memory_setup)(void);
 	void (*dmi_setup)(void);
+	unsigned long realmode_limit;
+	unsigned long reserve_bios;
 };
 
 /**
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -8,6 +8,7 @@
 #include <linux/ioport.h>
 #include <linux/export.h>
 #include <linux/pci.h>
+#include <linux/sizes.h>
 
 #include <asm/acpi.h>
 #include <asm/bios_ebda.h>
@@ -68,6 +69,8 @@ struct x86_init_ops x86_init __initdata
 		.reserve_resources	= reserve_standard_io_resources,
 		.memory_setup		= e820__memory_setup_default,
 		.dmi_setup		= dmi_setup,
+		.realmode_limit		= SZ_1M,
+		.reserve_bios		= SZ_1M,
 	},
 
 	.mpparse = {
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -45,7 +45,7 @@ void load_trampoline_pgtable(void)
 
 void __init reserve_real_mode(void)
 {
-	phys_addr_t mem;
+	phys_addr_t mem, limit = x86_init.resources.realmode_limit;
 	size_t size = real_mode_size_needed();
 
 	if (!size)
@@ -54,17 +54,15 @@ void __init reserve_real_mode(void)
 	WARN_ON(slab_is_available());
 
 	/* Has to be under 1M so we can execute real-mode AP code. */
-	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, 1<<20);
+	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, limit);
 	if (!mem)
-		pr_info("No sub-1M memory is available for the trampoline\n");
+		pr_info("No memory below %lluM for the real-mode trampoline\n", limit >> 20);
 	else
 		set_real_mode_mem(mem);
 
-	/*
-	 * Unconditionally reserve the entire first 1M, see comment in
-	 * setup_arch().
-	 */
-	memblock_reserve(0, SZ_1M);
+	/* Reserve the entire first 1M, if enabled. See comment in setup_arch(). */
+	if (x86_init.resources.reserve_bios)
+		memblock_reserve(0, x86_init.resources.reserve_bios);
 }
 
 static void __init sme_sev_setup_real_mode(struct trampoline_header *th)

