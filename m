Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF6D37EE76
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 May 2021 00:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhELVnv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 May 2021 17:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387260AbhELUd3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 May 2021 16:33:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8359C061345;
        Wed, 12 May 2021 13:29:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620851248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T8VGM7T2ebwxRKCm5/uITXAy1lYGXfvGxWTRjsElJlo=;
        b=tolPteYN+1BOe/u6A1hk+xYj0vM7JQBAx1QnrNmuv4xyd1EGQv/70l3ul3vocp9hyYA1zs
        WklamftkByCa5+e7/tOTgSQYo6JpeMsrWboXpiNtkpsyGy1U+qR773gqBbZ5tD+JNnbCD/
        ibtkRiKfKSFRjqDMllzvVRqE1T7UHo/u6UUZ4EFjt3qHqUr/gwrhys+UhITVVWck5eqQPd
        h/tHkvkPcjYTnMK6105DE76hrQWSdDbjUJluIo4pMvGSD0TOAlyz629ncbP/xvvx6KF/kt
        w7zfZVs+a+309+mkLqfY/qOFcGhY8+EGBIVMtIlpz8/pZszMU2xcTjXL0IpA4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620851248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T8VGM7T2ebwxRKCm5/uITXAy1lYGXfvGxWTRjsElJlo=;
        b=EQTh/A7XSqo9mXKYkLMu0PQUecmLYJRHnb+Pm4yi3tEuGxUxVg7ubba0KNUejp7niMF6Ej
        0w60bRAIGZVLDwCA==
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mohammed Gamal <mgamal@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/hyper-v: Re-enable VDSO_CLOCKMODE_HVCLOCK on X86
In-Reply-To: <20210512084630.1662011-1-vkuznets@redhat.com>
References: <20210512084630.1662011-1-vkuznets@redhat.com>
Date:   Wed, 12 May 2021 22:27:28 +0200
Message-ID: <87tun766kv.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 12 2021 at 10:46, Vitaly Kuznetsov wrote:
> Mohammed reports (https://bugzilla.kernel.org/show_bug.cgi?id=213029)
> the commit e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO
> differences inline") broke vDSO on x86. The problem appears to be that
> VDSO_CLOCKMODE_HVCLOCK is an enum value in 'enum vdso_clock_mode' and
> '#ifdef VDSO_CLOCKMODE_HVCLOCK' branch evaluates to false (it is not
> a define). Replace it with CONFIG_X86 as it is the only arch which
> has this mode currently.
>
> Reported-by: Mohammed Gamal <mgamal@redhat.com>
> Fixes: e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO differences inline")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/clocksource/hyperv_timer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 977fd05ac35f..e17421f5e47d 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -419,7 +419,7 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
>  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
>  }
>  
> -#ifdef VDSO_CLOCKMODE_HVCLOCK
> +#ifdef CONFIG_X86
>  static int hv_cs_enable(struct clocksource *cs)
>  {
>  	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
> @@ -435,7 +435,7 @@ static struct clocksource hyperv_cs_tsc = {
>  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
>  	.suspend= suspend_hv_clock_tsc,
>  	.resume	= resume_hv_clock_tsc,
> -#ifdef VDSO_CLOCKMODE_HVCLOCK
> +#ifdef CONFIG_X86
>  	.enable = hv_cs_enable,
>  	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
>  #else

That's lame as it needs to be patched differently once ARM64 gains
support. What about the below?

Thanks,

        tglx
---
--- a/arch/x86/include/asm/vdso/clocksource.h
+++ b/arch/x86/include/asm/vdso/clocksource.h
@@ -7,4 +7,6 @@
 	VDSO_CLOCKMODE_PVCLOCK,	\
 	VDSO_CLOCKMODE_HVCLOCK
 
+#define HAVE_VDSO_CLOCKMODE_HVCLOCK
+
 #endif /* __ASM_VDSO_CLOCKSOURCE_H */
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -419,7 +419,7 @@ static void resume_hv_clock_tsc(struct c
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
 }
 
-#ifdef VDSO_CLOCKMODE_HVCLOCK
+#ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
 static int hv_cs_enable(struct clocksource *cs)
 {
 	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
@@ -435,7 +435,7 @@ static struct clocksource hyperv_cs_tsc
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.suspend= suspend_hv_clock_tsc,
 	.resume	= resume_hv_clock_tsc,
-#ifdef VDSO_CLOCKMODE_HVCLOCK
+#ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
 	.enable = hv_cs_enable,
 	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
 #else
