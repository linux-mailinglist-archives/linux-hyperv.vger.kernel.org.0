Return-Path: <linux-hyperv+bounces-2323-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4695B8FCFB7
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2024 15:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EB82B2D509
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2024 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784F4188CAA;
	Wed,  5 Jun 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtNWZznl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D06188CA8;
	Wed,  5 Jun 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591442; cv=none; b=FAjzOgX8qeOcgzDOCyOxO1qgJS1QBhgewIhUaG3B+P0ynXZwmQPP7UUqVsgt+qwvtiGXUPUIZn2yoHjkLLYLzaFypaH8+m+nPrRXj7Bf+xEFeLJHXdBKdspXgpijPfzjpnZVXv8JdGbTqE1zIa4CDYdi+3K2YYPiu1hDWP6E4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591442; c=relaxed/simple;
	bh=Ird/7ibDYFzjfXEOhEaNA8pLzi4g/oGwnmrePMvc8zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg3aROMyTZL02rynHvIqTG14/CXkql5C9kxVwEGNP6rY44vE/BqQuWFDJvBLtaxiqIth6oIO00hCsvNqpxwtYudWfwOrDh6EcMn1UODId7yk3ngNo+5UVUQaETwbWYZtBgYSpt8z5PGBU5wubOc7DfQyl73dhGhMC9KljKbUfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtNWZznl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717591441; x=1749127441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ird/7ibDYFzjfXEOhEaNA8pLzi4g/oGwnmrePMvc8zQ=;
  b=QtNWZznlXRcxrcn0CUbbSJWub/jQbw+vQF0Hss5AiYZ6FsGxUgIEyVUV
   PjcgTvzaaiI01VGRv9L6b476qdOX+AfACiHoGzX5W/DalARM/ZCHHAHrx
   cPUz9WsSnzDfl9pYSFFuIAXPyOAFVwcikkm5za7VRGYZjUEelx6giUdfS
   g5/2sxnrP+ep66PnbTHG1Nrw7OaBfrdi8LROMXUCF0sC3YmfNfdjRuoQe
   muXbtSFHX/z8dnH9nPy2oGsve0c8ultI1fBGiryoEW/bd6FyuiRl3BotV
   UjZFGiyWkReWQHNvj+p1oAGGjyevjou4rSaD9r+mWhZGsBM6yoDpwrOjd
   A==;
X-CSE-ConnectionGUID: hcWdyrQ8TC+vWi8VfqXufg==
X-CSE-MsgGUID: vAirULW6Q+e82WXA4Q+/vw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25603464"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="25603464"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 05:43:47 -0700
X-CSE-ConnectionGUID: fqlx1KVQTw22jSK8Bo+f2g==
X-CSE-MsgGUID: ActVDDhwSRyovQJ4dmAvOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42133851"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 05 Jun 2024 05:43:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E5C7F1B6; Wed, 05 Jun 2024 15:43:39 +0300 (EEST)
Date: Wed, 5 Jun 2024 15:43:39 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 11/19] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <ass6d7jqmjmttnyfzpdfid6dymqriors2awdtyedwvc7ft4zhg@qzj637lzmjt6>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-12-kirill.shutemov@linux.intel.com>
 <68943e0b-8d82-42de-8f09-058e97d9a392@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68943e0b-8d82-42de-8f09-058e97d9a392@intel.com>

On Tue, Jun 04, 2024 at 09:27:59AM -0700, Dave Hansen wrote:
> On 5/28/24 02:55, Kirill A. Shutemov wrote:
> > +/* Stop new private<->shared conversions */
> > +static void tdx_kexec_begin(bool crash)
> > +{
> > +	/*
> > +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> > +	 * conversions to finish.
> > +	 *
> > +	 * If race happened, just report and proceed.
> > +	 */
> > +	if (!set_memory_enc_stop_conversion(!crash))
> > +		pr_warn("Failed to stop shared<->private conversions\n");
> > +}
> 
> I don't like having to pass 'crash' in here.
> 
> If interrupts are the problem we have ways of testing for those directly.
> 
> If it's being in an oops that's a problem, we have 'oops_in_progress'
> for that.
> 
> In other words, I'd much rather this function (or better yet
> set_memory_enc_stop_conversion() itself) use some existing API to change
> its behavior in a crash rather than have the context be passed down and
> twiddled through several levels of function calls.
> 
> There are a ton of these in the console code:
> 
> 	if (oops_in_progress)
> 		foo_trylock();
> 	else
> 		foo_lock();
> 
> To me, that's a billion times more clear than a 'wait' argument that
> gets derives from who-knows-what that I have to trace through ten levels
> of function calls.

Okay fair enough. Check out the fixup below. Is it what you mean?

One other thing I realized is that these callback are dead code if kernel
compiled without kexec support. Do we want them to be wrapped with
#ifdef COFNIG_KEXEC_CORE everywhere? It is going to be ugly.

Any better ideas?

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3d23ea0f5d45..1c5aa036b76b 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -834,7 +834,7 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 }
 
 /* Stop new private<->shared conversions */
-static void tdx_kexec_begin(bool crash)
+static void tdx_kexec_begin(void)
 {
 	/*
 	 * Crash kernel reaches here with interrupts disabled: can't wait for
@@ -842,7 +842,7 @@ static void tdx_kexec_begin(bool crash)
 	 *
 	 * If race happened, just report and proceed.
 	 */
-	if (!set_memory_enc_stop_conversion(!crash))
+	if (!set_memory_enc_stop_conversion())
 		pr_warn("Failed to stop shared<->private conversions\n");
 }
 
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index d490db38db9e..4b2abce2e3e7 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -50,7 +50,7 @@ int set_memory_np(unsigned long addr, int numpages);
 int set_memory_p(unsigned long addr, int numpages);
 int set_memory_4k(unsigned long addr, int numpages);
 
-bool set_memory_enc_stop_conversion(bool wait);
+bool set_memory_enc_stop_conversion(void);
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
 
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index b0f313278967..213cf5379a5a 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -152,8 +152,6 @@ struct x86_init_acpi {
  * @enc_kexec_begin		Begin the two-step process of converting shared memory back
  *				to private. It stops the new conversions from being started
  *				and waits in-flight conversions to finish, if possible.
- *				The @crash parameter denotes whether the function is being
- *				called in the crash shutdown path.
  * @enc_kexec_finish		Finish the two-step process of converting shared memory to
  *				private. All memory is private after the call when
  *				the function returns.
@@ -165,7 +163,7 @@ struct x86_guest {
 	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
-	void (*enc_kexec_begin)(bool crash);
+	void (*enc_kexec_begin)(void);
 	void (*enc_kexec_finish)(void);
 };
 
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index fc52ea80cdc8..340af8155658 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -137,7 +137,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	 * down and interrupts have been disabled. This allows the callback to
 	 * detect a race with the conversion and report it.
 	 */
-	x86_platform.guest.enc_kexec_begin(true);
+	x86_platform.guest.enc_kexec_begin();
 	x86_platform.guest.enc_kexec_finish();
 
 	crash_save_cpu(regs, safe_smp_processor_id());
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 513809b5b27c..0e0a4cf6b5eb 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -723,7 +723,7 @@ void native_machine_shutdown(void)
 	 * conversions to finish cleanly.
 	 */
 	if (kexec_in_progress)
-		x86_platform.guest.enc_kexec_begin(false);
+		x86_platform.guest.enc_kexec_begin();
 
 	/* Stop the cpus and apics */
 #ifdef CONFIG_X86_IO_APIC
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 8a79fb505303..82b128d3f309 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -138,7 +138,7 @@ static int enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool
 static int enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return 0; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
-static void enc_kexec_begin_noop(bool crash) {}
+static void enc_kexec_begin_noop(void) {}
 static void enc_kexec_finish_noop(void) {}
 static bool is_private_mmio_noop(u64 addr) {return false; }
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 2a548b65ef5f..443a97e515c0 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2240,13 +2240,14 @@ static DECLARE_RWSEM(mem_enc_lock);
  *
  * Taking the exclusive mem_enc_lock waits for in-flight conversions to complete.
  * The lock is not released to prevent new conversions from being started.
- *
- * If sleep is not allowed, as in a crash scenario, try to take the lock.
- * Failure indicates that there is a race with the conversion.
  */
-bool set_memory_enc_stop_conversion(bool wait)
+bool set_memory_enc_stop_conversion(void)
 {
-	if (!wait)
+	/*
+	 * In a crash scenario, sleep is not allowed. Try to take the lock.
+	 * Failure indicates that there is a race with the conversion.
+	 */
+	if (oops_in_progress)
 		return down_write_trylock(&mem_enc_lock);
 
 	down_write(&mem_enc_lock);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

