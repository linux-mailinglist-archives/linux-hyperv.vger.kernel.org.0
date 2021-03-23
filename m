Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BD63453A9
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Mar 2021 01:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhCWANR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Mar 2021 20:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhCWANI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Mar 2021 20:13:08 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F082BC061574;
        Mon, 22 Mar 2021 17:13:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p19so10109676wmq.1;
        Mon, 22 Mar 2021 17:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZLe4jHn51FP9H526Os3ku5j3JqFdmzNB4MqtKFDpbIo=;
        b=XkX373mmw4Dh8HNW12L7baOLdDWuLmPv1oNSV6ScxDctk7lmRGYaod7yEB90gcMX/K
         UBOw2C8snMjVAxSiJ5uQRc+5rqB3BIHzyy0xTv+3Gz5p1fS4S/qgFqo+kUO73GXhZWNl
         m5MvQXvT5sptN81SnUM72vURmrqo5KVQD7tSqLh1mXA8V4AbQY9FYRYPq1kQubPMCmS+
         rsmSSPmacJwcgQLRQJGe/eILAxr4AIr2bu8koYFEG65yJGjqlUaP7VG8MKrKdm0+vhNA
         sKJHeXVPA+ko1BBiQGgbB79xCn6q4b7v1RLDgcbbb2gGe5eadZDJehvPJVW9W02Ojw8C
         0qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZLe4jHn51FP9H526Os3ku5j3JqFdmzNB4MqtKFDpbIo=;
        b=bcWsOByx3Spl2UeimkMx0ADZDNaVHyemN/7YfOijR63Ddiy+HhJznV9VRI2MgKF3dI
         2DnauW/qurn/TRx05ZGszv1TCPDyXHDWyW+PW8vW5EJ7fJYT6bnNmsEB8QlJLJ4WsE1/
         VAMCCDaZEZPd68ieJTusbYLI+pblLseb24aM8uLun+WmmIMETTIv3kKBz8u62B4kjFwx
         72o0KBkSpbICCrN2rfZPxJ9nd0UQtadx1rGCSq+r/x+E5PuGI+DgIOe44sVYoB3K0S6X
         RV39F/KWVlDz9UqYaOfWyXc3+AT41UKEbdPh9iK49QR0lP9L0OCcB8pMhKtaenqgzFv/
         Ld4Q==
X-Gm-Message-State: AOAM531G0fwoF19mGR6Dw2rcwN5uQ6dBAQAEoS8qymp9DZCP9grsm8wn
        254F77TFtPuFWNnhgEu7Z5Q=
X-Google-Smtp-Source: ABdhPJyiMJCXP21k5ih0g4dCgf3B3uM6BiQ7EiFsAguiHdlPeoeSRijIhUPuyLWLLQkiOoX/oJ4I/Q==
X-Received: by 2002:a1c:b48a:: with SMTP id d132mr751143wmf.108.1616458386647;
        Mon, 22 Mar 2021 17:13:06 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a4sm6686525wrx.86.2021.03.22.17.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:13:05 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 23 Mar 2021 01:13:03 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Xu Yihang <xuyihang@huawei.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johnny.chenyi@huawei.com" <johnny.chenyi@huawei.com>,
        "heying24@huawei.com" <heying24@huawei.com>
Subject: Re: [PATCH -next] x86: Fix unused variable 'msr_val' warning
Message-ID: <20210323001303.GA3092649@gmail.com>
References: <20210322031713.23853-1-xuyihang@huawei.com>
 <20210322210828.GA1961861@gmail.com>
 <MWHPR21MB15939242EA50C7C1728412D0D7659@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15939242EA50C7C1728412D0D7659@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


* Michael Kelley <mikelley@microsoft.com> wrote:

> From: Ingo Molnar <mingo.kernel.org@gmail.com> Sent: Monday, March 22, 2021 2:08 PM
> > 
> > * Xu Yihang <xuyihang@huawei.com> wrote:
> > 
> > > Fixes the following W=1 kernel build warning(s):
> > > arch/x86/hyperv/hv_spinlock.c:28:16: warning: variable 'msr_val' set but not used [-
> > Wunused-but-set-variable]
> > >   unsigned long msr_val;
> > >
> > > As Hypervisor Top-Level Functional Specification states in chapter 7.5 Virtual Processor
> > Idle Sleep State, "A partition which possesses the AccessGuestIdleMsr privilege (refer to
> > section 4.2.2) may trigger entry into the virtual processor idle sleep state through a read to
> > the hypervisor-defined MSR HV_X64_MSR_GUEST_IDLE". That means only a read is
> > necessary, msr_val is not uesed, so __maybe_unused should be added.
> > >
> > > Reference:
> > >
> > > https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
> > >
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: Xu Yihang <xuyihang@huawei.com>
> > > ---
> > >  arch/x86/hyperv/hv_spinlock.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
> > > index f3270c1fc48c..67bc15c7752a 100644
> > > --- a/arch/x86/hyperv/hv_spinlock.c
> > > +++ b/arch/x86/hyperv/hv_spinlock.c
> > > @@ -25,7 +25,7 @@ static void hv_qlock_kick(int cpu)
> > >
> > >  static void hv_qlock_wait(u8 *byte, u8 val)
> > >  {
> > > -	unsigned long msr_val;
> > > +	unsigned long msr_val __maybe_unused;
> > >  	unsigned long flags;
> > 
> > Please don't add new __maybe_unused annotations to the x86 tree -
> > improve the flow instead to help GCC recognize the initialization
> > sequence better.
> > 
> > Thanks,
> > 
> > 	Ingo
> 
> Could you elaborate on the thinking here, or point to some written
> discussion?   I'm just curious.   In this particular case, it's not a problem
> with the flow or gcc detection.  This code really does read an MSR and
> ignore that value that is read, so it's not clear how gcc would ever
> figure out that's OK.

Yeah, so the canonical way to signal that the msr_val isn't used would 
be to rewrite this as:


	if (READ_ONCE(*byte) == val) {
		unsigned long msr_val;

		rdmsrl(HV_X64_MSR_GUEST_IDLE, msr_val);

		(void)msr_val;
	}

(Also see the patch below - untested.)

This makes it abundantly clear that the rdmsr() msr_val return value 
is not 'maybe' unused, but totally intentionally skipped.

Thanks,

	Ingo

 arch/x86/hyperv/hv_spinlock.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index f3270c1fc48c..7d948513ed42 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -25,7 +25,6 @@ static void hv_qlock_kick(int cpu)
 
 static void hv_qlock_wait(u8 *byte, u8 val)
 {
-	unsigned long msr_val;
 	unsigned long flags;
 
 	if (in_nmi())
@@ -48,8 +47,14 @@ static void hv_qlock_wait(u8 *byte, u8 val)
 	/*
 	 * Only issue the rdmsrl() when the lock state has not changed.
 	 */
-	if (READ_ONCE(*byte) == val)
+	if (READ_ONCE(*byte) == val) {
+		unsigned long msr_val;
+
 		rdmsrl(HV_X64_MSR_GUEST_IDLE, msr_val);
+
+		(void)msr_val;
+	}
+
 	local_irq_restore(flags);
 }
 
