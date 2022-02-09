Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536334AEC36
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Feb 2022 09:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiBII06 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Feb 2022 03:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbiBII04 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Feb 2022 03:26:56 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21603C05CB82;
        Wed,  9 Feb 2022 00:26:58 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id v67so1715694oie.9;
        Wed, 09 Feb 2022 00:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41yfUpGIyxWzE/33BXhtKiam8iPGuUMqJkEcuWzBJGk=;
        b=NtgOYfL3vJCpbYK1R1nJMegC9wNB9O6kJ91Sr0QFI8LCtyPNQfuC45mX1OgveNNonh
         xVbPZpOXON00OTzUjyGKyohIxr8DbOGh/yS8NVCNh6PD6yCKn9N0tV9EnwyV8PoUMRUL
         +DMidSutxTZacXH6TveYVzc5zFB8e/DobIOiErgQA5Weu6TKhX8INykhnguHjGNnkIlv
         SURSDfP+B8onewzqRNZ8QIaMKu/L1QnOPhvWnY/xZrLzmR92Wwn3DunhrZQu2JMgm/wV
         P2Y+zk154bIxYQ0NGcs+Btd0TUwvkRcKNcCebkcJ6w8hWBqYtu1ZYfFyCZJ8VbVP4Za9
         p6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41yfUpGIyxWzE/33BXhtKiam8iPGuUMqJkEcuWzBJGk=;
        b=18PTM2UBjV7kEHJQWhhBPXeKiyxaxrY1SJYuMnmDbDv/zT80YcU9rlFzD4MqWLr0iM
         XhpJfkFc787S9UWlNX3JwsmztmWWkpSRGOENEDFBTOdiRPwqGkrM5ScjMotPBx7NiCuN
         WckrNuOFCNnWcS90QcKl+2nl4B7quQVrOPJvoYB6nlQQAOt0TAAafkmK+KgkYxskhnBr
         ylJ465reQgS1C6AFfgLa8LTepTBKMCaGUAEhm/O17kUAbJxrz4RwjkhTBNS5VB4DxbZX
         3JZzRKor4gIlRbyB8R9e/txhAxKfPMR8IgjHImJZ3pwhbEvvx5YNt2KTwDI6qMAq5V1C
         KkqQ==
X-Gm-Message-State: AOAM533FR1fB9AOzLRlledJTxl+94W9VpcZyhbiRK2HsG9dd+M3OvIUW
        EdOUsgtICbgkExdx8MwZOEHDEWv5aOAP8bbFlbg=
X-Google-Smtp-Source: ABdhPJzfe5vGl2j6BxuI08oeOapu4bQlvHlvM+xVew2SOCIEFabIB/2jHMBSvI3ncvbhyUTR2woMzGCLUWUC3lgyu8w=
X-Received: by 2002:a05:6808:1184:: with SMTP id j4mr497685oil.73.1644395217343;
 Wed, 09 Feb 2022 00:26:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644025661.git.iourit@linux.microsoft.com>
 <CADvTj4riwoFngTkAOTyc=SuZ3FeTwpyz3FteV_+3BiQ=uiLX7Q@mail.gmail.com> <YgDCnxsnqJ1gihLf@infradead.org>
In-Reply-To: <YgDCnxsnqJ1gihLf@infradead.org>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 9 Feb 2022 01:26:46 -0700
Message-ID: <CADvTj4q_-A9p2UkH975SPPYmSzVAv38VJxLDBQjEnHoCSERzOw@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] Driver for Hyper-v virtual compute device
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Iouri Tarassov <iourit@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        spronovo@microsoft.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Feb 6, 2022 at 11:56 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Feb 05, 2022 at 09:15:27PM -0700, James Hilliard wrote:
> > Does the fully open source user-space implementation actually use the entire
> > user-space API exposed by this driver?
>
> I think that is the abolute minimum.  But more importantly: I don't
> think we'd want to expose interface in a virtual GPU driver that aren't
> also supported by a native one.

Yeah, that's one of the obvious huge issues with what is being done here, I mean
it seems pretty clear that this is all designed to provide a way to
run an effectively
entirely closed source graphics/compute stack with Linux and sidestep the lack
of a stable kernel driver API by letting vendors target the windows
kernel instead
for their closed source drivers.

I think the closed source and WSL specific user space components are the biggest
problem with this whole graphics/compute stack potentially as that is what
application developers are being encouraged to target.

I mean it's pretty clear this is being designed in a way to ultimately prevent
users from running applications on non-WSL Linux systems, Microsoft isn't even
hiding that at all as they even list it as a specific goal of the
directx related changes
being pushed to mesa(which are designed to interface with the closed
source directx
userspace libraries this kernel driver is designed to support):
https://devblogs.microsoft.com/directx/in-the-works-opencl-and-opengl-mapping-layers-to-directx/
> > Make it easier for developers to port their apps to D3D12. For developers looking
> > to move from older OpenCL and OpenGL API versions to D3D12,

Notice that the mapping/compatibility work they are pushing is
essentially entirely
one way, it's designed to make Linux applications work on top of the
closed source
WSL directx userspace but does not allow applications targeting
directx API's to work
without a WSL system in any way.

It's basically classic
EEE(https://en.wikipedia.org/wiki/Embrace,_extend,_and_extinguish)
strategy except that it's targeting non-WSL Linux instead of Linux in
general for the
extinguish parts(by using a passthrough driver like this to bypass the kernel):

* Embrace: provide OpenCL and OpenGL API compatibility layers so all existing
  non-directx graphics/compute software works on WSL.

* Extend: add the WSL-only directx graphics/compute user space to
Linux and tie it to
  a WSL kernel/host while maintaining backwards compatibility with OpenCL and
  OpenGL API's for any software that doesn't get ported to directx

* Extinguish: encourage application developers to migrate to new
WSL-only directx
  graphics/compute API's and away from non-WSL specific OpenGL/OpenCL API's

> > We took this feedback to heart and we spent the last year working on a way
> > to address this key piece of feedback. Working closely with our partner Intel,
> > we're happy to say that we now have a fully open source user-space for the
> > OpenCL, OpenVINO and OneAPI compute family of APIs on Intel GPU platforms.
> > This is supported by this open source project
> > (https://github.com/intel/compute-runtime).

One would really want to see a mapping layer that translates directx
API's to open API's,
such as those exposed by the intel compute runtime instead of the
other way around.

Fundamentally I think the changes in this series do nothing to address
the main issues
in the original
series(https://lore.kernel.org/lkml/20200519163234.226513-1-sashal@kernel.org/)
as the DX12 userspace components(which are what microsoft wants apps
to target) are
still closed source. Having an open source consumer of this driver
isn't going to help much
if the main stack being used is closed source. Especially since this
driver is designed to
around the closed source DX12 driver constraints and not the open
source user space
constraints:
https://lore.kernel.org/all/5493bb21-7c85-9a8a-07f6-983d1d5c425b@linux.microsoft.com/
> > d3dkmthk.h defines a binary interface to the compute driver. It cannot
> > be changed, because it must
> > be binary compatible with the Windows display graphics model.

Since the Windows and Linux compute-runtime drivers are developed together there
should be no reason one needs to maintain binary compatibility with the Windows
display model as opposed to just ensuring each side of the driver can
talk with each
other:
https://github.com/intel/compute-runtime/blob/master/FAQ.md#does-neo-support-microsoft-windows
> > Our closed-source driver for Windows is using the same codebase. At this time,
> > we do not support compilation of the stack for Windows. It is our long-term intention
> > to offer that option.

The binary compatibility requirement with d3dkmthk.h is a constraint imposed
by only the closed source stack effectively. So we should be able to tweak the
kernel binary interface as needed for the purposes of the open source
compute-runtime as the Linux side userspace is already effectively hardware
specific, tweaking the host side would simply be a matter of getting an updated
driver release with the host tweaks which is already a requirement for the
compute-runtime. The binary compatibility seems to only be helpful for those
wanting to port closed source drivers with minimal changes.

The directx support could instead be built on top of an open source userspace on
the Linux side which would allow for one to choose between either a WSL or
non-WSL based graphics/compute stack via a reverse of the mapping layer
(https://www.collabora.com/news-and-blog/news-and-events/introducing-opencl-and-opengl-on-directx.html).
But that approach won't lock users into WSL like this one would so it
seems unlikely
to happen.
