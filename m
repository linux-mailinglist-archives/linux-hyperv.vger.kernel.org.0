Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BCF1DA4DC
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2020 00:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgESWm5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 May 2020 18:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgESWm4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 May 2020 18:42:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3456DC061A0E;
        Tue, 19 May 2020 15:42:56 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a2so881529ejb.10;
        Tue, 19 May 2020 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkNEkulDdH4K6Pc2AjIHGc1nu83ozdPkLgankdo3z+8=;
        b=AweT9CPIrUxa0N4vmOK6oeo/RxnZYLc+CExt9z8FbB6GnMgeBCd0HEvdw8smURG8fg
         ejGoOvcyyG4x6E1LsYeAohAFISL1LexnmcLI17QeGLW30w7WSPiLSp9PTWtY2jxCxCfG
         T2LZQReOgUzOuD6RqkMr9W/oePZEfvsya+tZEwsqcIDTH93LLKWo/eYhSxAZmit3lexc
         VRq86Yrb2RMPQZx87PCOtd1hZ+2IxPd0JKJso1L/tLwVYWaCH1MxtKCEbFdwHQwReNAT
         GhAlb+w4vwOYm7cBfs+zGlldrJNucHi+c/0Omu1JZOKu0R/HdMfHM6Dqf1fWcIGwwETU
         yVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkNEkulDdH4K6Pc2AjIHGc1nu83ozdPkLgankdo3z+8=;
        b=XaU1jhLE1SRbpBiJD1OF0Z1QNEEEMf+vE6DuHqsb3VORdGmlp9GKT9NVaQnsYSye/m
         wsvxIbwL2u4d3JSfQZ9cxW3tomVgSTPX050hzk+PtlSRGDwUBZMO5PWOJl7bm9S2bzjT
         z2upDf9yBcIZwsDvEd75/rWAh1fJVahTv7D7yhs46HreUaXOL/jejRW544r8ntvVAQ45
         QuPb3wz+E7cKFv5gk+Gka5vcJxLHNsJNBLHnFCtYV8mYcHwypRwSfmk6MA1gap+khLTY
         IzGmqkKfvxnUgYAKYItRpTF0Az7vXI2GxCCp7kjNesSwlKyQ0PEAfHQE23beg0F9hgXY
         YqYw==
X-Gm-Message-State: AOAM533h4nEXOSWhEsbZt3M4igiXyNm9w9jYsw7lV02fFbVNid89jG/E
        PkQW3C0cIRPoXsnYCZpWrRI1aKCtw+u5mDqmrjXjAcyt
X-Google-Smtp-Source: ABdhPJz1cbZ0mWSKAwLvdrgyvCIeCQXQpdCsWBcPW7aOrjkzx37rBjrlZHsWHTx3L65i6XkCMQlISf0P+HM/SVSd/tQ=
X-Received: by 2002:a17:906:404c:: with SMTP id y12mr1381799ejj.9.1589928174706;
 Tue, 19 May 2020 15:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200519163234.226513-1-sashal@kernel.org>
In-Reply-To: <20200519163234.226513-1-sashal@kernel.org>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 20 May 2020 08:42:43 +1000
Message-ID: <CAPM=9txZpiCGkv3jiBC1F8pTe4A2pqWpQDyjRBXk2roFqw+0+Q@mail.gmail.com>
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

On Wed, 20 May 2020 at 02:33, Sasha Levin <sashal@kernel.org> wrote:
>
> There is a blog post that goes into more detail about the bigger
> picture, and walks through all the required pieces to make this work. It
> is available here:
> https://devblogs.microsoft.com/directx/directx-heart-linux . The rest of
> this cover letter will focus on the Linux Kernel bits.
>
> Overview
> ========
>
> This is the first draft of the Microsoft Virtual GPU (vGPU) driver. The
> driver exposes a paravirtualized GPU to user mode applications running
> in a virtual machine on a Windows host. This enables hardware
> acceleration in environment such as WSL (Windows Subsystem for Linux)
> where the Linux virtual machine is able to share the GPU with the
> Windows host.
>
> The projection is accomplished by exposing the WDDM (Windows Display
> Driver Model) interface as a set of IOCTL. This allows APIs and user
> mode driver written against the WDDM GPU abstraction on Windows to be
> ported to run within a Linux environment. This enables the port of the
> D3D12 and DirectML APIs as well as their associated user mode driver to
> Linux. This also enables third party APIs, such as the popular NVIDIA
> Cuda compute API, to be hardware accelerated within a WSL environment.
>
> Only the rendering/compute aspect of the GPU are projected to the
> virtual machine, no display functionality is exposed. Further, at this
> time there are no presentation integration. So although the D3D12 API
> can be use to render graphics offscreen, there is no path (yet) for
> pixel to flow from the Linux environment back onto the Windows host
> desktop. This GPU stack is effectively side-by-side with the native
> Linux graphics stack.

Okay I've had some caffiene and absorbed some more of this.

This is a driver that connects a binary blob interface in the Windows
kernel drivers to a binary blob that you run inside a Linux guest.
It's a binary transport between two binary pieces. Personally this
holds little of interest to me, I can see why it might be nice to have
this upstream, but I don't forsee any other Linux distributor ever
enabling it or having to ship it, it's purely a WSL2 pipe. I'm not
saying I'd be happy to see this in the tree, since I don't see the
value of maintaining it upstream, but it probably should just exists
in a drivers/hyperv type area.

Having said that, I hit one stumbling block:
"Further, at this time there are no presentation integration. "

If we upstream this driver as-is into some hyperv specific place, and
you decide to add presentation integration this is more than likely
going to mean you will want to interact with dma-bufs and dma-fences.
If the driver is hidden away in a hyperv place it's likely we won't
even notice that feature landing until it's too late.

I would like to see a coherent plan for presentation support (not
code, just an architectural diagram), because I think when you
contemplate how that works it will change the picture of how this
driver looks and intergrates into the rest of the Linux graphics
ecosystem.

As-is I'd rather this didn't land under my purview, since I don't see
the value this adds to the Linux ecosystem at all, and I think it's
important when putting a burden on upstream that you provide some
value.

Dave.
