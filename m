Return-Path: <linux-hyperv+bounces-4642-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F45CA6A400
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 11:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC308A6257
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5584922258E;
	Thu, 20 Mar 2025 10:46:34 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFEE7482;
	Thu, 20 Mar 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467594; cv=none; b=CgQ56aeTwW2SuCb04bUOpRHWdAAKulVSNi/l/TJ4aDUxVJ/IoAZCQIspmDOH9ltiKm1IXIO7n8LAOccY/8Aoo8IakCvkm8qi9yYqeh59Xk1lVEp1EXdnAlPNLR8AYjaboDaKJYXfziGP5RHd6ArpzMr3g1PRez+4mUTCQxfnvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467594; c=relaxed/simple;
	bh=qo3bx4y1OgFeBHPu7HD6Z1utr2SwL7M4yO/d4FkV4V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpEnFbSAQNpYCJA4g3dNcCDyeMvW8ZxiTDXsVMCmaoLuHq4ndSXpLOPziKNIryL0ps4VB18ipaiIo2sXswLqEmyafMbmBFricWZ1sppjWzwkgvGniJnoIZcGS7No4yAgSwC4NXpsYZ5fCy1IawnmcC8YW1Alxk7kPQAPIVEKs9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-523de5611a3so287938e0c.1;
        Thu, 20 Mar 2025 03:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742467591; x=1743072391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcUl7AglmAhanLKGRDwml74U0DwMqoxNAsyIj9YcrII=;
        b=f3W5c9kXHuEzeG3uRSWbPSBeCmEtNA43NOQDtjeIeIp/zSP1PfzTG5BX3djPdLNa15
         rm3kBcsD2mrNUfAo6Z6lhM5HKdf7LdyqJyzhx/2tmIXVbper6SJE9kBCCf4H4D/GFjy+
         OO3Jwi3WQT/Cmh4NONOEUK5cbp9NHoTh7m3c2cVpRJpKIaandQjr4fhnxp8G/uSYqLNB
         pFg3siOEHdokESCMHjjw/pRymPkt2e2dNKm3DtJOjsG+YBBQkLCmWPXxut+WRgrr2+Yp
         8tO5E9t8yAzUhO6BDDvcSK286m6vhY1GPwCFq5LPff3/L372uXtnjKfErEJagYXMXXq5
         9DWA==
X-Forwarded-Encrypted: i=1; AJvYcCVDbUyRt9DZ4P0vR7Cw/rOVG9scUQnrop1aNZwAQ898/jb8md8pcAVWwkb70tgWjyy1ZxnUWLbPvRh5ovpo@vger.kernel.org, AJvYcCWCHiUFBSKD7VGLQLo8sc1AHTqgWk1CH56DB656/O1GZ/lvepPmqNL2Crq+ZBE2AsKhXRlFiW/E7t1Q0NXZ@vger.kernel.org, AJvYcCWsp8AAfJ2BFMFUJYp29O0eT2Ixrcx/yck5xvLN0UWW/CYLosRfA2c9GiM4c+IcuN5IeBqeB8TVX8EYQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoE2xSVwhlK/dlWeLcxrv39nEcLdg5g7xedbGGsmJcEnY2K4b6
	AalLGOopkKVKD2jQ52c9b6vRC4uruwtm5bSFsEZnQCGOiZ2L5qmO7G2wIpC7
X-Gm-Gg: ASbGnctDjMUpz9nF5S2jHCSRfTv5saki21kNJ0ZzGMQ+7GUu98bZEup+FyCzBIRww5t
	yNHA6O7dlbc9HR1JzALq3BPEGhP/fpmTI75ykgoY6rA7/1R72Pu7SNYmLb6PUf8ea7sVScnQRt7
	b7b8Ovs9cV4cDF63t76+HL6zhUlOyf5Yj/pZsD3zhEOHKiD46fg93wxb4lFXm8tmFQzOpk0EDy+
	H51+ZVJYf91A4VvvrtJsJ/RCK0n4k7oRxCA48uOYY9M8RFzd8qIqMIAdezLkmN73rOsp7xD3Rev
	gqgM+NONEbhCWK15FMmHqPXnnWMi5S6gVqrdMAiutG/H3qKaQ/1sSBJA+dJUsYlu6DhDqX8OZE1
	QnuLWtx4=
X-Google-Smtp-Source: AGHT+IHTEbg99abufsBEGzV6hCoID1T6Ynpb+0RFpqlvO3I+qTNl1JXWBwKqJAdUJKM0FgFbhCRUEw==
X-Received: by 2002:a05:6122:4312:b0:520:420a:a07a with SMTP id 71dfb90a1353d-5258926a30dmr4476426e0c.8.1742467590832;
        Thu, 20 Mar 2025 03:46:30 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a715293sm2841004e0c.43.2025.03.20.03.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 03:46:30 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86b9d1f729eso240013241.3;
        Thu, 20 Mar 2025 03:46:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/rzzCTPaVK4yqttMSii+GnP+V2o0Zs2Fb08EtB5OdNK1E9IzT+Z1ztdrsBCdov/FlNmJEIQOW5t4lhh20@vger.kernel.org, AJvYcCUxlg8v+N3rieYeygyS/rJCunOUmxU5Jt3p+QvObwZ1kg/x3Jb9wExmT+VyLARy6mxQ0B8vx96y3Z0U0Q==@vger.kernel.org, AJvYcCVfG8/BAD1fc279IlxDyzeN8xxaIfDLkKOsQmcjgk4wyJGXgDPMN+lY+H+MlItFHZIRr0Pu/ztE7qFmFeAM@vger.kernel.org
X-Received: by 2002:a05:6102:3e89:b0:4bb:e511:15a3 with SMTP id
 ada2fe7eead31-4c4ec64ca04mr5179605137.8.1742467590396; Thu, 20 Mar 2025
 03:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SN6PR02MB4157227300E59ACB3B0DABD0D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <303572c2-4839-4dae-a249-9967fcc9cf03@gmx.de> <BN7PR02MB4148157E5307E306FD9D093ED4D92@BN7PR02MB4148.namprd02.prod.outlook.com>
In-Reply-To: <BN7PR02MB4148157E5307E306FD9D093ED4D92@BN7PR02MB4148.namprd02.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Mar 2025 11:46:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVvuPr454jcVExGpHX_94_=y0GfVPJu1YLO1-H0OkBTdQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqSJaAlYE2RSivsmsHWzNr0rgT1XY8eXSxtnUbzAmsz9cOYCVmAaJLksWc
Message-ID: <CAMuHMdVvuPr454jcVExGpHX_94_=y0GfVPJu1YLO1-H0OkBTdQ@mail.gmail.com>
Subject: Re: fbdev deferred I/O broken in some scenarios
To: Michael Kelley <mhklinux@outlook.com>
Cc: Helge Deller <deller@gmx.de>, 
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Michael,

On Wed, 19 Mar 2025 at 21:29, Michael Kelley <mhklinux@outlook.com> wrote:
> From: Helge Deller <deller@gmx.de> Sent: Tuesday, March 18, 2025 1:16 AM
> > On 3/18/25 03:05, Michael Kelley wrote:
> > > I've been trying to get mmap() working with the hyperv_fb.c fbdev driver, which
> > > is for Linux guests running on Microsoft's Hyper-V hypervisor. The hyperv_fb driver
> > > uses fbdev deferred I/O for performance reasons. But it looks to me like fbdev
> > > deferred I/O is fundamentally broken when the underlying framebuffer memory
> > > is allocated from kernel memory (alloc_pages or dma_alloc_coherent).
> > >
> > > The hyperv_fb.c driver may allocate the framebuffer memory in several ways,
> > > depending on the size of the framebuffer specified by the Hyper-V host and the VM
> > > "Generation".  For a Generation 2 VM, the framebuffer memory is allocated by the
> > > Hyper-V host and is assigned to guest MMIO space. The hyperv_fb driver does a
> > > vmalloc() allocation for deferred I/O to work against. This combination handles mmap()
> > > of /dev/fb<n> correctly and the performance benefits of deferred I/O are substantial.
> > >
> > > But for a Generation 1 VM, the hyperv_fb driver allocates the framebuffer memory in
> > > contiguous guest physical memory using alloc_pages() or dma_alloc_coherent(), and
> > > informs the Hyper-V host of the location. In this case, mmap() with deferred I/O does
> > > not work. The mmap() succeeds, and user space updates to the mmap'ed memory are
> > > correctly reflected to the framebuffer. But when the user space program does munmap()
> > > or terminates, the Linux kernel free lists become scrambled and the kernel eventually
> > > panics. The problem is that when munmap() is done, the PTEs in the VMA are cleaned
> > > up, and the corresponding struct page refcounts are decremented. If the refcount goes
> > > to zero (which it typically will), the page is immediately freed. In this way, some or all
> > > of the framebuffer memory gets erroneously freed. From what I see, the VMA should
> > > be marked VM_PFNMAP when allocated memory kernel is being used as the
> > > framebuffer with deferred I/O, but that's not happening. The handling of deferred I/O
> > > page faults would also need updating to make this work.

I assume this is triggered by running any fbdev userspace that uses
mmap(), e.g. fbtest?

> > > The fbdev deferred I/O support was originally added to the hyperv_fb driver in the
> > > 5.6 kernel, and based on my recent experiments, it has never worked correctly when
> > > the framebuffer is allocated from kernel memory. fbdev deferred I/O support for using
> > > kernel memory as the framebuffer was originally added in commit 37b4837959cb9
> > > back in 2008 in Linux 2.6.29. But I don't see how it ever worked properly, unless
> > > changes in generic memory management somehow broke it in the intervening years.
> > >
> > > I think I know how to fix all this. But before working on a patch, I wanted to check
> > > with the fbdev community to see if this might be a known issue and whether there
> > > is any additional insight someone might offer. Thanks for any comments or help.
> >
> > I haven't heard of any major deferred-i/o issues since I've jumped into fbdev
> > maintenance. But you might be right, as I haven't looked much into it yet and
> > there are just a few drivers using it.
>
> Thanks for the input. In the fbdev directory, there are 9 drivers using deferred I/O.
> Of those, 6 use vmalloc() to allocate the framebuffer, and that path works just fine.
> The other 3 use alloc_pages(), dma_alloc_coherent(), or __get_free_pages(), all of
> which manifest the underlying problem when munmap()'ed.  Those 3 drivers are:
>
> * hyperv_fb.c, which I'm working with
> * sh_mobile_lcdcfb.c
> * ssd1307fb.c

Nowadays sh_mobile_lcdcfb is used only on various SuperH boards
(I have no hardware to test).

sh_mobile_lcdcfb was used on ARM-based SH/R-Mobile SoCs until DT
support was added to the DRM driver for the corresponding hardware.
The platform using it was migrated to DRM in commit 138588e9fa237f97
("ARM: dts: renesas: r8a7740: Add LCDC nodes") in v6.8). At the time
of the conversion, fbtest worked fine with sh_mobile_lcdcfb.

Deferred I/O is also used in DRM drivers for displays that are connected
using I2C or SPI.  Last time I tried the st7735r driver, it worked fine
with fbtest.  That was also on arm32, though.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

