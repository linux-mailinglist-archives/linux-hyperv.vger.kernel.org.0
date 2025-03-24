Return-Path: <linux-hyperv+bounces-4677-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD394A6DC73
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Mar 2025 15:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011EE189318A
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Mar 2025 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674AB25F994;
	Mon, 24 Mar 2025 14:00:08 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C7825F96B;
	Mon, 24 Mar 2025 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824808; cv=none; b=VPY771aoliSEzeglmSuv5e7WyGIpH8UBVhz+myoFZm5C6gvHMkTKogqb3+7inFvrLQM2seEVwV33XM0HkbGgRjEPl90h9lnhgntZkrcrkCT1+K17n8iPcvaRC5Ikzrzxj7Mn95LVJV23w0jHK8Wh7zxXPAawoIk14XBSZ+zeJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824808; c=relaxed/simple;
	bh=yQYvw5ZtI6vmtZW/ypQ1OLR0sQhFNGSyU4vXFqj4EEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SADAWKs2PkLLA7TGjWqyi4B8pX5TEZOT3XHM0zcccsj/DulPwVMPgcmEzR6pgqcmVAxwTJHa3Aa7KHX/LrrkihH3iYo87FxVO7U0C/aJiMtFqrZMRj32ZMJlsOGboY1ayDyZSrw8lV+WHGIxeZ3mNDZUBnXyNMDPXLI/9ObUXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523f1b31cf8so1766921e0c.0;
        Mon, 24 Mar 2025 07:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742824805; x=1743429605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXcFAhOso9RJxk+9NCcLf8mohkPRGIOlOMnED2EzPlQ=;
        b=YsOSswr4Vc/NClTmSisddFaK/V49vk8f5eqESYzr26KaRVqEPM2eox2wIoKHwZd9H/
         +DeCjd1KBIsXvSrwSlWhNQfORO+NSZRUCbC3Gg9+wqbRpLHvCNRG1orNXCUQ1YRuycrL
         rFDGyj7cOzEpp+8z1bZNtQyXS6MB0MeIEvYWzAAvVi+xAujsybWgB6bYrUOzA8Dddbe3
         uDrxw9dGkrcC7+VlfLbwMdnMXNEaHWNVrl1Zx1qEmHslU0uXyKyHuxQ0geFAe6vxqKb8
         4ftoyU+Vt4x1Q+70jgmnQgeUtMJQHJYkYkv7WUPAJvSkjzb0w37Y4vkjG2rMDRfJ7jb6
         FkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN7H9Y5pE9FUjNmJeRbDd0i2+3J7Sv5VQGvatIXxBiOy09lwU6N5bS1P/ynVwwVWlV3ADvWVoE4q1oTVDC@vger.kernel.org, AJvYcCVgD9kzFSm6gnVq8V/IW8u1Tg4gN9tbXtmNQ8PuW9dw6zLez3AgRB+AsScoAlrjy/6I51/9x7YAenZxZ0jW@vger.kernel.org, AJvYcCVnkVcrOGTKp0fWOyxFF/KGRDi9umtrE1hm4toxpc4+/1jrh45rhqsdSmM962Ny4BSrf4EX8jhYile14g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLicvzkpkxtmKw3hyBGJRS5/5unUUwkDGJN96NCtZtppgY9VK1
	zjzsJEf0H+Sz/cICwf3LSyyigxEy0d/yGVppf5fh4ZM7E1vXaeT7YDKh3NYR
X-Gm-Gg: ASbGncvHHxs0bO1VAYF+DalTeNKcBZTXoWvgIqcbSQKopU9wnvkwfOwHYjAMJzuGBh6
	Cc7PCutmn9jXoAGA58i0tVdyBFpKnCCLcJmubsLxOL084K7LvZzssys9HByDallnBDHOWSNEFha
	whdqkD6qSpl7iQKhPwSct97In3Na211WliKscqWe0oM25Oa65werwLZCwfHegRSzIFq39Qlq9vc
	Z4HPoGWcRSTGhda9tBVUgve+sw7ywcRL2vFFwhYGzDN3ZDjPhPsDewgsxCydmte9p3rxouhPTLC
	7+Oo41ZslePOml15i0vn5aQPq7LyWAv9oqLuFkk486w/cvJXbJH/E+Teg+oXLebbDWGVqWrNpho
	r2+RmOB4=
X-Google-Smtp-Source: AGHT+IHOoB2H977qNNnQu1ak2WVPQheKXmXHNKqLPLtz4Jk7YFdEYMfocdsm7ASPAgvdqjcaol0/CQ==
X-Received: by 2002:a05:6102:808c:b0:4c3:64bc:7d16 with SMTP id ada2fe7eead31-4c50d612de4mr9012975137.16.1742824804838;
        Mon, 24 Mar 2025 07:00:04 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86f9f3c2cf4sm1533786241.19.2025.03.24.07.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 07:00:04 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86dddba7e0eso1804761241.1;
        Mon, 24 Mar 2025 07:00:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGMberwwNK27l2sgiaOVirVu9VL147WeQ6F4dUFVOikJNy2iyRn4M5nyvRwr288u0VZa7zaODuWqF2SA==@vger.kernel.org, AJvYcCWxK/UfAfuSNaq2YVO6y34nq2dMHI324v80mA+GsbxusGNjAOiAsflPlKTC/23LX/GJaklkX2s7veTZLPnB@vger.kernel.org, AJvYcCX01C7AwXDVfzVm0RL2stqN5oBx6e5fLkgELKStM95zQXetpFrgLDv60NXvUZIBw/veJU+a0HfWufzSsDM+@vger.kernel.org
X-Received: by 2002:a05:6102:3c83:b0:4c1:94c1:1c34 with SMTP id
 ada2fe7eead31-4c50d61330cmr8666737137.20.1742824803903; Mon, 24 Mar 2025
 07:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SN6PR02MB4157227300E59ACB3B0DABD0D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <303572c2-4839-4dae-a249-9967fcc9cf03@gmx.de> <BN7PR02MB4148157E5307E306FD9D093ED4D92@BN7PR02MB4148.namprd02.prod.outlook.com>
 <CAMuHMdVvuPr454jcVExGpHX_94_=y0GfVPJu1YLO1-H0OkBTdQ@mail.gmail.com> <SN6PR02MB415740F004283A40C3C41490D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB415740F004283A40C3C41490D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Mar 2025 14:59:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHpzQ8UcnJ_zxMnc7uDJPU-cybqo76ZUabqNBPcrY3nw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq5DoU61pl8s2Du4_m9CBACy9bVyIMaQz_LNeBbMufFKQ0jhZ45DiLgpjE
Message-ID: <CAMuHMdVHpzQ8UcnJ_zxMnc7uDJPU-cybqo76ZUabqNBPcrY3nw@mail.gmail.com>
Subject: Re: fbdev deferred I/O broken in some scenarios
To: Michael Kelley <mhklinux@outlook.com>
Cc: Helge Deller <deller@gmx.de>, 
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Michael,

On Thu, 20 Mar 2025 at 21:15, Michael Kelley <mhklinux@outlook.com> wrote:
> From: Geert Uytterhoeven <geert@linux-m68k.org> Sent: Thursday, March 20, 2025 3:46 AM
> > On Wed, 19 Mar 2025 at 21:29, Michael Kelley <mhklinux@outlook.com> wrote:
> > > From: Helge Deller <deller@gmx.de> Sent: Tuesday, March 18, 2025 1:16 AM
> > > > On 3/18/25 03:05, Michael Kelley wrote:
> > > > > The fbdev deferred I/O support was originally added to the hyperv_fb driver in the
> > > > > 5.6 kernel, and based on my recent experiments, it has never worked correctly when
> > > > > the framebuffer is allocated from kernel memory. fbdev deferred I/O support for using
> > > > > kernel memory as the framebuffer was originally added in commit 37b4837959cb9
> > > > > back in 2008 in Linux 2.6.29. But I don't see how it ever worked properly, unless
> > > > > changes in generic memory management somehow broke it in the intervening years.
> > > > >
> > > > > I think I know how to fix all this. But before working on a patch, I wanted to check
> > > > > with the fbdev community to see if this might be a known issue and whether there
> > > > > is any additional insight someone might offer. Thanks for any comments or help.
> > > >
> > > > I haven't heard of any major deferred-i/o issues since I've jumped into fbdev
> > > > maintenance. But you might be right, as I haven't looked much into it yet and
> > > > there are just a few drivers using it.
> > >
> > > Thanks for the input. In the fbdev directory, there are 9 drivers using deferred I/O.
> > > Of those, 6 use vmalloc() to allocate the framebuffer, and that path works just fine.
> > > The other 3 use alloc_pages(), dma_alloc_coherent(), or __get_free_pages(), all of
> > > which manifest the underlying problem when munmap()'ed.  Those 3 drivers are:
> > >
> > > * hyperv_fb.c, which I'm working with
> > > * sh_mobile_lcdcfb.c
> > > * ssd1307fb.c
> >
> > Nowadays sh_mobile_lcdcfb is used only on various SuperH boards
> > (I have no hardware to test).
> >
> > sh_mobile_lcdcfb was used on ARM-based SH/R-Mobile SoCs until DT
> > support was added to the DRM driver for the corresponding hardware.
> > The platform using it was migrated to DRM in commit 138588e9fa237f97
> > ("ARM: dts: renesas: r8a7740: Add LCDC nodes") in v6.8). At the time
> > of the conversion, fbtest worked fine with sh_mobile_lcdcfb.
>
> OK, good to know. sh_mobile_lcdcfb gets its framebuffer using
> dma_alloc_coherent(). Do you recall how big the framebuffer was?
> If over 4 MiB, dma_alloc_coherent() would have allocated from CMA,
> and that works OK.

1536000 bytes (800x480 (960 virtual), 16bpp), i.e. less than 4 MiB.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

