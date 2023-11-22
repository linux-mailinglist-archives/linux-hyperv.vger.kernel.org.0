Return-Path: <linux-hyperv+bounces-1018-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437927F3C9D
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 04:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE854281266
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 03:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97889BA25;
	Wed, 22 Nov 2023 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D4B181;
	Tue, 21 Nov 2023 19:52:01 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6b709048f32so5615177b3a.0;
        Tue, 21 Nov 2023 19:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700625120; x=1701229920;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYeSgGrWxn5lhSUxV7NfeTtpO0KR/JRi5G3+hv3lCUI=;
        b=T4CsZ4ln8LdIn3B4V+hm3mKIoBGXh+IHViURQSBQ0C+zbXKslsu13bALZ2vfLDZz2Z
         XBw4SoOfAz6MxgRg9YoObx5qoHnzpKzbeMk6PpG4z/jgfvMZwgAGWGG2/Py6zglxoiG2
         t65DIVnQ59sBPIHn43LMWNoJFCMou8484S/S5HpL7Q+DcBTd4XegP8vKRxDgMyeEQtGV
         0otaEUT6FI5JF5LmL/QFLM3IOmQgQ7iIGlOOCLTc8cm9mJu/inFnh2ON1bDaTnfYWFdT
         HpNkAy7ibRRUI+b7gE6YUIMJGKt3dTIfmSE7tUazQvGcaVOlThSjBZFBL5DB+91Ml5fb
         SgOA==
X-Gm-Message-State: AOJu0YwXD7AqtG5LI9JgoTXsBVGS1iep7JoNByzkohe7kqUQutCs51Xp
	WCh1TyK8bZ5CDOcWh8zsH6uMHQoLAyk=
X-Google-Smtp-Source: AGHT+IFL2h2f9bZd/pAPJxAzcHcduX8GKiMtuLr4lXLakYSw7Y3ekI/O9yCh93k3jWyqS4D79d4dhA==
X-Received: by 2002:a05:6a00:158c:b0:6cb:916f:f3d8 with SMTP id u12-20020a056a00158c00b006cb916ff3d8mr1197172pfk.22.1700625120340;
        Tue, 21 Nov 2023 19:52:00 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id v17-20020a056a00149100b006cb6e83bf7fsm5835015pfu.192.2023.11.21.19.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 19:51:59 -0800 (PST)
Date: Wed, 22 Nov 2023 03:51:57 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/hyperv: Use atomic_try_cmpxchg() to micro-optimize
 hv_nmi_unknown()
Message-ID: <ZV163ePuUQyyeKUj@liuwe-devbox-debian-v2>
References: <20231114170038.381634-1-ubizjak@gmail.com>
 <SN6PR02MB41570168279C428D385ADCB0D4B1A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAFULd4Z3DZh0SoEyNHfz3=DM2CkDGtNP_f1gVx64NJkzmWp-Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4Z3DZh0SoEyNHfz3=DM2CkDGtNP_f1gVx64NJkzmWp-Pw@mail.gmail.com>

On Wed, Nov 15, 2023 at 09:58:29PM +0100, Uros Bizjak wrote:
> On Wed, Nov 15, 2023 at 6:19 PM Michael Kelley <mhklinux@outlook.com> wrote:
> >
> > From: Uros Bizjak <ubizjak@gmail.com> Sent: Tuesday, November 14, 2023 8:59 AM
> > >
> > > Use atomic_try_cmpxchg() instead of atomic_cmpxchg(*ptr, old, new) == old
> > > in hv_nmi_unknown(). On x86 the CMPXCHG instruction returns success in
> > > the ZF flag, so this change saves a compare after CMPXCHG. The generated
> > > asm code improves from:
> > >
> > >   3e: 65 8b 15 00 00 00 00    mov    %gs:0x0(%rip),%edx
> > >   45: b8 ff ff ff ff          mov    $0xffffffff,%eax
> > >   4a: f0 0f b1 15 00 00 00    lock cmpxchg %edx,0x0(%rip)
> > >   51: 00
> > >   52: 83 f8 ff                cmp    $0xffffffff,%eax
> > >   55: 0f 95 c0                setne  %al
> > >
> > > to:
> > >
> > >   3e: 65 8b 15 00 00 00 00    mov    %gs:0x0(%rip),%edx
> > >   45: b8 ff ff ff ff          mov    $0xffffffff,%eax
> > >   4a: f0 0f b1 15 00 00 00    lock cmpxchg %edx,0x0(%rip)
> > >   51: 00
> > >   52: 0f 95 c0                setne  %al
> > >
> > > No functional change intended.
> > >
> > > Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> > > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > > Cc: Wei Liu <wei.liu@kernel.org>
> > > Cc: Dexuan Cui <decui@microsoft.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > ---
> > >  arch/x86/kernel/cpu/mshyperv.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/kernel/cpu/mshyperv.c
> > > b/arch/x86/kernel/cpu/mshyperv.c index e6bba12c759c..01fa06dd06b6
> > > 100644
> > > --- a/arch/x86/kernel/cpu/mshyperv.c
> > > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > > @@ -262,11 +262,14 @@ static uint32_t  __init ms_hyperv_platform(void)
> > > static int hv_nmi_unknown(unsigned int val, struct pt_regs *regs)  {
> > >       static atomic_t nmi_cpu = ATOMIC_INIT(-1);
> > > +     unsigned int old_cpu, this_cpu;
> > >
> > >       if (!unknown_nmi_panic)
> > >               return NMI_DONE;
> > >
> > > -     if (atomic_cmpxchg(&nmi_cpu, -1, raw_smp_processor_id()) != -1)
> > > +     old_cpu = -1;
> > > +     this_cpu = raw_smp_processor_id();
> > > +     if (!atomic_try_cmpxchg(&nmi_cpu, &old_cpu, this_cpu))
> > >               return NMI_HANDLED;
> > >
> > >       return NMI_DONE;
> > > --
> > > 2.41.0
> >
> > The change looks correct to me.  But is there any motivation other
> > than saving 3 bytes of generated code?  This is not a performance
> > sensitive path.  And the change adds 3 lines of source code.  So
> > I wonder if the change is worth the churn.
> 
> Yes, I was trying to make the function more easy to understand and
> similar to nmi_panic() from kernel/panic.c. I had also the idea of
> using CPU_INVALID #define instead of -1, but IMO, the above works as
> well.
> 
> > In any case,
> >
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-fixes.

Uros, just so you know, DKIM verification failed when I used b4 to apply
this patch. You may want to check your email setup.

For such a simple patch I'm not worried about spoofing authorship, and I
also checked the same email address had sent similar patches before.

Thanks,
Wei.

> 
> Thanks,
> Uros.

