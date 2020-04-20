Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB9D1B08CF
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2020 14:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgDTMI3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Apr 2020 08:08:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40562 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgDTMI2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Apr 2020 08:08:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id k13so10621607wrw.7;
        Mon, 20 Apr 2020 05:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8IrFThSk1fchwYwkQB2VvTz6i+J6Xv3NsNLPKTgfzss=;
        b=ceoFhSb7s7b/nTQgS49MErGW/StZPrsdeG3WhzQrv1HFaZeDoqfZZYQq7BFvqgnH92
         SefEKkuhiikZOGuEqi/uSZGbBc8Bel1FTdxwLURl42CdvOqZ+4iQ6JnkPRTe5hysze1N
         EryKg6GIgpAoIY9tJB7HeZvY16Tvyjih6b0USXZ0u0dX4ptE9OvZMpfS/vpLHOCSXCG4
         fqkqsDRknpdFeec6gnA0prISjHL+x2FhNGdKC+9kDgJPy+oTC4b+ASqwfkMie1XNrnkV
         NdAAdmgi0EKBxv1fHiSPkZHricjA5FyW+x44Vcw2WY6vpKA59yfE9xe7D3Tq6m4CnWrn
         08Pg==
X-Gm-Message-State: AGi0PuY5HsjaciMp6v8ZG0cQpr1OwplwHOHjyY1Jv9Ea6Ja7XO6ymAWp
        x9N018BxVLP0E6dD9J+BsQQ=
X-Google-Smtp-Source: APiQypIq0tYSDgiZhBXS+e7724ZzctVwppbD2oAuHlQR1KtdVxaLIPo4bzhgsoGliXG6rmSWdgYLlA==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr18076400wro.8.1587384506480;
        Mon, 20 Apr 2020 05:08:26 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id y10sm1061455wma.5.2020.04.20.05.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 05:08:25 -0700 (PDT)
Date:   Mon, 20 Apr 2020 13:08:22 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH] x86/hyperv: Suspend/resume the VP assist page for
 hibernation
Message-ID: <20200420120822.4bncj2iwgqbpoxei@debian>
References: <1587104999-28927-1-git-send-email-decui@microsoft.com>
 <20200417110007.uzfo6musx2x2suw7@debian>
 <HK0P153MB0273A04F0585524883C46B0FBFD90@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0P153MB0273A04F0585524883C46B0FBFD90@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Apr 17, 2020 at 11:47:41PM +0000, Dexuan Cui wrote:
> > From: Wei Liu <wei.liu@kernel.org>
> > Sent: Friday, April 17, 2020 4:00 AM
> > To: Dexuan Cui <decui@microsoft.com>
> > 
> > On Thu, Apr 16, 2020 at 11:29:59PM -0700, Dexuan Cui wrote:
> > > Unlike the other CPUs, CPU0 is never offlined during hibernation. So in the
> > > resume path, the "new" kernel's VP assist page is not suspended (i.e.
> > > disabled), and later when we jump to the "old" kernel, the page is not
> > > properly re-enabled for CPU0 with the allocated page from the old kernel.
> > >
> > > So far, the VP assist page is only used by hv_apic_eoi_write(). When the
> > > page is not properly re-enabled, hvp->apic_assist is always 0, so the
> > > HV_X64_MSR_EOI MSR is always written. This is not ideal with respect to
> > > performance, but Hyper-V can still correctly handle this.
> > >
> > > The issue is: the hypervisor can corrupt the old kernel memory, and hence
> > > sometimes cause unexpected behaviors, e.g. when the old kernel's non-boot
> > > CPUs are being onlined in the resume path, the VM can hang or be killed
> > > due to virtual triple fault.
> > 
> > I don't quite follow here.
> > 
> > The first sentence is rather alarming -- why would Hyper-V corrupt
> > guest's memory (kernel or not)?
> 
> Without this patch, after the VM resumes from hibernation, the hypervisor 
> still thinks the assist page of vCPU0 points to the physical page allocated by
> the "new" kernel (the "new" kernel started up freshly, loaded the saved state 
> of the "old" kernel from disk into memory, and jumped to the "old" kernel),
> but the same physical page can be allocated to store something different in
> the "old" kernel (which is the currently running kernel, since the VM resumed).
> 
> Conceptually, it looks Hyper-V writes into the assist page from time to time,
> e.g. for the EOI optimization. This "corrupts" the page for the "old" kernel.
> 
> I'm not absolutely sure if this explains the strange hang issue or triple fault
> I occasionally saw in my long-haul hibernation test, but with this patch,
> I never reproduce the strange hang/triple fault issue again, so I think this
> patch works.

OK. I wouldn't be surprised if the corruption ends up changing code in
the kernel which further triggers triple fault etc. 

I would suggest make this clear in the commit message to not give the
impression that Hyper-V has this weird behaviour of corrupting guest
memory for no reason.

We can replace the paragraph starting with "The issue is: ..." with:

---
Linux needs to update Hyper-V the correct VP assist page to prevent
Hyper-V from writing to a stale page, which causes guest memory
corruption.  The memory corruption may have caused some of the hangs and
triple faults we saw during non-boot CPUs resume.
---

This What do you think?

Wei.

> 
> > Secondly, code below only specifies cpu0. What does it do with non-boot
> > cpus on the resume path?
> > 
> > Wei.
> 
> hyperv_init() registers hv_cpu_init()/hv_cpu_die() to the cpuhp framework:
> 
> cpuhp = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
>                        hv_cpu_init, hv_cpu_die);
> 
> In the hibernation procedure, the non-boot CPUs are automatically disabled
> and reenabled, so hv_cpu_init()/hv_cpu_die() are automatically called for them,
> e.g. in the resume path, see:
>     hibernation_restore()
>         resume_target_kernel()
>             hibernate_resume_nonboot_cpu_disable()
>                 disable_nonboot_cpus() 
>             syscore_suspend()
>                 hv_cpu_die(0)  // Added by this patch
>             swsusp_arch_resume()
>                 relocate_restore_code()
>                     restore_image()
>                         jump to the old kernel and we return from 
>                         the swsusp_arch_suspend() in create_image()
>                             syscore_resume()
>                                 hv_cpu_init(0) // Added by this patch.
>                             suspend_enable_secondary_cpus()
>                             dpm_resume_start()
>                             ...
> Thanks,
> -- Dexuan
