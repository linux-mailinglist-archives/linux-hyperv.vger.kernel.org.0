Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AA31DA535
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2020 01:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgESXMj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 May 2020 19:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgESXMj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 May 2020 19:12:39 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205DFC061A0E;
        Tue, 19 May 2020 16:12:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m185so984940wme.3;
        Tue, 19 May 2020 16:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nXZIh+0a9uZrepq31HrqjjhS+2AZ4SL6HL9QDxcUlU=;
        b=a+HujN4J2T5GBiw+FOginmhSWhcLYquVQeHuLk5YIilloN5ZtHaFfSdVwmsWf3xHno
         cZBu3sb2iEurmfDZvbqBbClGg9LFg8SVWo8KzIdVzn+mbfbEFQwI3OBZ6z3yL2/YTSI8
         w1D7quHDgXaZVFy4bFv4mYt3R69G9ehUOVk6y86bLABjpRSLrbIFBvgFVFDL6vu+VKxT
         D8H2yHEy7JIGpcxootlOblYZsUwXM5Sdy6XSOao11sK+qCMzBu2x+OmdEY2IZUyOUz+Z
         g/zcdpZOSTmtzH3sQG7HV4tox1bOYPsBtsk4xde/Kp+1aXD/uqOTlf7Qk+12mfFvShgB
         pMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nXZIh+0a9uZrepq31HrqjjhS+2AZ4SL6HL9QDxcUlU=;
        b=D06LThemApIglEAHxJ8vPCxSO19n1AubWkGQX0k/Kr2ESAUDnEy37qnrEk5jKr7PDM
         VNIE/0ELmKuy3GnX8oTIw20AEMyYH8dOS/x46eQVl8xNrCMYjbaSbKBYZJ8/GZ2vCZ6R
         FQIwJWSpBbCe66jjUxjvOr1cjXj8dVTKd/MBFoL1EP01UnmX679mS7FZZwyrAek/KhQq
         gbxGb/7EMWxUhvvqT+fLrzdsOQC1fCX37g9WDq0E3MXBQsWjWGwwExjzjo6YVVofH4P6
         rVc0ooOC+d30GurS/INsbqMq42fh3Yfomc64+e/oQcJcxanQ848f0xTO7MZ2gENMfzz0
         8M0w==
X-Gm-Message-State: AOAM533UH3LaYhZqzFMKDvnklrXx1IlBQZLndTh3EPqBkNShlVIkH2XS
        O1ztT4s4czrYANl8H2NYs5ws2gpOpN5OStzqwVg=
X-Google-Smtp-Source: ABdhPJxAHqucqBj12xjabdjLamMUC2A4wmKz1xYaVdTR7QJ4jEJL9z/KA49Rzy2njbcAVgo4okup/a+0i39+OHRlUGk=
X-Received: by 2002:a1c:38c3:: with SMTP id f186mr1790842wma.137.1589929957694;
 Tue, 19 May 2020 16:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200519163234.226513-1-sashal@kernel.org> <CAPM=9txZpiCGkv3jiBC1F8pTe4A2pqWpQDyjRBXk2roFqw+0+Q@mail.gmail.com>
In-Reply-To: <CAPM=9txZpiCGkv3jiBC1F8pTe4A2pqWpQDyjRBXk2roFqw+0+Q@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 20 May 2020 09:12:25 +1000
Message-ID: <CAPM=9tx4wh-Lk6Dffsdh-7mYvXx+GX2AxhrGqFgyN8-AWJvP6A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] DirectX on Linux
To:     Sasha Levin <sashal@kernel.org>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        "Ursulin, Tvrtko" <tvrtko.ursulin@intel.com>,
        linux-hyperv@vger.kernel.org, sthemmin@microsoft.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        haiyangz@microsoft.com, LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        spronovo@microsoft.com, wei.liu@kernel.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        iourit@microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 20 May 2020 at 08:42, Dave Airlie <airlied@gmail.com> wrote:
>
> On Wed, 20 May 2020 at 02:33, Sasha Levin <sashal@kernel.org> wrote:
> >
> > There is a blog post that goes into more detail about the bigger
> > picture, and walks through all the required pieces to make this work. It
> > is available here:
> > https://devblogs.microsoft.com/directx/directx-heart-linux . The rest of
> > this cover letter will focus on the Linux Kernel bits.
> >
> > Overview
> > ========
> >
> > This is the first draft of the Microsoft Virtual GPU (vGPU) driver. The
> > driver exposes a paravirtualized GPU to user mode applications running
> > in a virtual machine on a Windows host. This enables hardware
> > acceleration in environment such as WSL (Windows Subsystem for Linux)
> > where the Linux virtual machine is able to share the GPU with the
> > Windows host.
> >
> > The projection is accomplished by exposing the WDDM (Windows Display
> > Driver Model) interface as a set of IOCTL. This allows APIs and user
> > mode driver written against the WDDM GPU abstraction on Windows to be
> > ported to run within a Linux environment. This enables the port of the
> > D3D12 and DirectML APIs as well as their associated user mode driver to
> > Linux. This also enables third party APIs, such as the popular NVIDIA
> > Cuda compute API, to be hardware accelerated within a WSL environment.
> >
> > Only the rendering/compute aspect of the GPU are projected to the
> > virtual machine, no display functionality is exposed. Further, at this
> > time there are no presentation integration. So although the D3D12 API
> > can be use to render graphics offscreen, there is no path (yet) for
> > pixel to flow from the Linux environment back onto the Windows host
> > desktop. This GPU stack is effectively side-by-side with the native
> > Linux graphics stack.
>
> Okay I've had some caffiene and absorbed some more of this.
>
> This is a driver that connects a binary blob interface in the Windows
> kernel drivers to a binary blob that you run inside a Linux guest.
> It's a binary transport between two binary pieces. Personally this
> holds little of interest to me, I can see why it might be nice to have
> this upstream, but I don't forsee any other Linux distributor ever
> enabling it or having to ship it, it's purely a WSL2 pipe. I'm not
> saying I'd be happy to see this in the tree, since I don't see the
> value of maintaining it upstream, but it probably should just exists
> in a drivers/hyperv type area.
>
> Having said that, I hit one stumbling block:
> "Further, at this time there are no presentation integration. "
>
> If we upstream this driver as-is into some hyperv specific place, and
> you decide to add presentation integration this is more than likely
> going to mean you will want to interact with dma-bufs and dma-fences.
> If the driver is hidden away in a hyperv place it's likely we won't
> even notice that feature landing until it's too late.
>
> I would like to see a coherent plan for presentation support (not
> code, just an architectural diagram), because I think when you
> contemplate how that works it will change the picture of how this
> driver looks and intergrates into the rest of the Linux graphics
> ecosystem.
>
> As-is I'd rather this didn't land under my purview, since I don't see
> the value this adds to the Linux ecosystem at all, and I think it's
> important when putting a burden on upstream that you provide some
> value.

I also have another concern from a legal standpoint I'd rather not
review the ioctl part of this. I'd probably request under DRI
developers abstain as well.

This is a Windows kernel API being smashed into a Linux driver. I
don't want to be tainted by knowledge of an API that I've no idea of
the legal status of derived works. (it this all covered patent wise
under OIN?)

I don't want to ever be accused of designing a Linux kernel API with
illgotten D3DKMT knowledge, I feel tainting myself with knowledge of a
properietary API might cause derived work issues.

Dave.
