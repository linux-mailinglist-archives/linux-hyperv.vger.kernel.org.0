Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D46345CFD
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Mar 2021 12:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhCWLfF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Mar 2021 07:35:05 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:55894 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCWLeb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Mar 2021 07:34:31 -0400
Received: by mail-wm1-f43.google.com with SMTP id 12so10847694wmf.5;
        Tue, 23 Mar 2021 04:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sx96tZdFzleJmckps5BrYhpq4EiEUeB9mDj5nietAwc=;
        b=VLJE43x/D6um2I2ZS3MJso1bDCY7siKL/DkaaWz3L5FFTJjKajv9qqaR32vb7ujcqm
         Z0OerjueE7fqfATtG7g9Ho/YSM2y1kfUSfw4nyl+p3kvC+pCQxzK6ufrUX2c/OrvXNmQ
         M38UXJtzShNGoWMuKA4Ufnb0BL3p6MUKIbyu7qex5IyeOXD5sUTOAMj3X48zeMRo98Nf
         GJ5i59aIb87hccUrHHvRlnFcMxuslbMDfkunQ2AiS0CG1MsUrNX8kL6q+ZrDxOLjHowc
         sjpNK6U+jmOFWUcRZmGy1ajdVyMatbzUfOEyhJrCjvwHJzqkj1lLsfMotDIqAJrG9tmN
         HaNw==
X-Gm-Message-State: AOAM532FNrzHX5Zc0J+ML2ic9tMqvgTnKAZY8aDjmtFlmghYnAPt7W85
        lKE63EQqN4PJwxXELsd7BHWdwarKeU0=
X-Google-Smtp-Source: ABdhPJw4zc1Gt3nGU1IVl568bG4fASUlM6JPACxb5i4BgPxchKFJZxXDzvbsw7VUejy+q6Kk/2V1FQ==
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr3003900wma.94.1616499270661;
        Tue, 23 Mar 2021 04:34:30 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u17sm2226301wmq.3.2021.03.23.04.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 04:34:30 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:34:29 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Xu Yihang <xuyihang@huawei.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johnny.chenyi@huawei.com" <johnny.chenyi@huawei.com>,
        "heying24@huawei.com" <heying24@huawei.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH -next] x86: Fix unused variable 'msr_val' warning
Message-ID: <20210323113429.zj64itbfpqkruval@liuwe-devbox-debian-v2>
References: <20210322031713.23853-1-xuyihang@huawei.com>
 <20210322210828.GA1961861@gmail.com>
 <MWHPR21MB15939242EA50C7C1728412D0D7659@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210323001303.GA3092649@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323001303.GA3092649@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 23, 2021 at 01:13:03AM +0100, Ingo Molnar wrote:
> 
> * Michael Kelley <mikelley@microsoft.com> wrote:
> 
> > From: Ingo Molnar <mingo.kernel.org@gmail.com> Sent: Monday, March 22, 2021 2:08 PM
> > > 
> > > * Xu Yihang <xuyihang@huawei.com> wrote:
> > > 
> > > > Fixes the following W=1 kernel build warning(s):
> > > > arch/x86/hyperv/hv_spinlock.c:28:16: warning: variable 'msr_val' set but not used [-
> > > Wunused-but-set-variable]
> > > >   unsigned long msr_val;
> > > >
> > > > As Hypervisor Top-Level Functional Specification states in chapter 7.5 Virtual Processor
> > > Idle Sleep State, "A partition which possesses the AccessGuestIdleMsr privilege (refer to
> > > section 4.2.2) may trigger entry into the virtual processor idle sleep state through a read to
> > > the hypervisor-defined MSR HV_X64_MSR_GUEST_IDLE". That means only a read is
> > > necessary, msr_val is not uesed, so __maybe_unused should be added.
> > > >
> > > > Reference:
> > > >
> > > > https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
> > > >
> > > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > > Signed-off-by: Xu Yihang <xuyihang@huawei.com>
> > > > ---
> > > >  arch/x86/hyperv/hv_spinlock.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
> > > > index f3270c1fc48c..67bc15c7752a 100644
> > > > --- a/arch/x86/hyperv/hv_spinlock.c
> > > > +++ b/arch/x86/hyperv/hv_spinlock.c
> > > > @@ -25,7 +25,7 @@ static void hv_qlock_kick(int cpu)
> > > >
> > > >  static void hv_qlock_wait(u8 *byte, u8 val)
> > > >  {
> > > > -	unsigned long msr_val;
> > > > +	unsigned long msr_val __maybe_unused;
> > > >  	unsigned long flags;
> > > 
> > > Please don't add new __maybe_unused annotations to the x86 tree -
> > > improve the flow instead to help GCC recognize the initialization
> > > sequence better.
> > > 
> > > Thanks,
> > > 
> > > 	Ingo
> > 
> > Could you elaborate on the thinking here, or point to some written
> > discussion?   I'm just curious.   In this particular case, it's not a problem
> > with the flow or gcc detection.  This code really does read an MSR and
> > ignore that value that is read, so it's not clear how gcc would ever
> > figure out that's OK.
> 
> Yeah, so the canonical way to signal that the msr_val isn't used would 
> be to rewrite this as:
> 
> 
> 	if (READ_ONCE(*byte) == val) {
> 		unsigned long msr_val;
> 
> 		rdmsrl(HV_X64_MSR_GUEST_IDLE, msr_val);
> 
> 		(void)msr_val;
> 	}
> 
> (Also see the patch below - untested.)
> 
> This makes it abundantly clear that the rdmsr() msr_val return value 
> is not 'maybe' unused, but totally intentionally skipped.
> 
> Thanks,
> 
> 	Ingo
> 

Thank you for the advice, Ingo.

Wei.
