Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571031DA0EC
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2020 21:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgESTV2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 May 2020 15:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTV1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 May 2020 15:21:27 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA093C08C5C0
        for <linux-hyperv@vger.kernel.org>; Tue, 19 May 2020 12:21:27 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b18so491975oti.1
        for <linux-hyperv@vger.kernel.org>; Tue, 19 May 2020 12:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbaEch3BY3ODcnVgLC0hRHtedgFalkSFoQATtp1WcHk=;
        b=Y/RMDymDON0bwyyZ29+IvRuIAUnJO414fQ9LYamwaJ5kt61JBCF0rFdIU3yuQwDPk2
         iYNGRk3B2gmUPXaK2kKvabsYjeHTV94ujVw90CdK9WQ2VBtuYvhgSPyeEHQzm6hpO7nS
         ccnTCje2hk0umRkhgMHpXOY8sRihZT2qnrJ5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbaEch3BY3ODcnVgLC0hRHtedgFalkSFoQATtp1WcHk=;
        b=Ho00a7gtB+rUL6qTVQk6ZodG5Ocbm7uVDNlapDcqsbBhwaXxupBJSpZsjpEH8YfWmh
         tBirBLntn3CcmK+Blbeg2Xd9l/2u8b4HUkmK93QrCqN2L/CYHhB/ZVQGrn4yv3o0BLR5
         j5RYosLfkGbP/h/PT0q3p561OgHzgwEwEB6v2NybrYFAYF9OVx59VkFjyTIN834MFg/a
         Ox1XKKTYu9IsJKp47MDfbVqOSHbcg0XiFYnEpgYGe0RBIDdJGW/qyoJAQFb7z+Sr87o/
         w7crsUgGrSRUais+I7esl69rC6kb1srOacvegjlaOFIY1iUqdYKwT64vTrOVn7kT/4ye
         EjRw==
X-Gm-Message-State: AOAM5315rgMDglGAIeefmDDHwZkOmXDVdHk0tYWgmymCG+iJr/sET7fK
        D67Qf2YYvrCTmSl3v6kdz7AZC9GuB2gcDecKEAsBbg==
X-Google-Smtp-Source: ABdhPJxqdRYzfXDfRYY9zzactC2h4TzlGjsY6K4bWoLgaI8ZY86K9YOQ8yYAu8QtONdcCDKSXu91+/CrZjJN/6Oed1M=
X-Received: by 2002:a9d:600e:: with SMTP id h14mr470787otj.281.1589916086888;
 Tue, 19 May 2020 12:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200519163234.226513-1-sashal@kernel.org>
In-Reply-To: <20200519163234.226513-1-sashal@kernel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 19 May 2020 21:21:15 +0200
Message-ID: <CAKMK7uGnSDHdZha-=dZN5ns0sJ2CEnK2693uix4tzqyZb9MXCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] DirectX on Linux
To:     Sasha Levin <sashal@kernel.org>,
        Olof Johansson <olof.johansson@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Ekstrand <jason@jlekstrand.net>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "Wilson, Chris" <chris@chris-wilson.co.uk>,
        "Syrjala, Ville" <ville.syrjala@linux.intel.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        spronovo@microsoft.com, Wei Liu <wei.liu@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        iourit@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Sasha

So obviously great that Microsoft is trying to upstream all this, and
very much welcome and all that.

But I guess there's a bunch of rather fundamental issues before we
look into any kind of code details. And that might make this quite a
hard sell for upstream to drivers/gpu subsystem:

- From the blog it sounds like the userspace is all closed. That
includes the hw specific part and compiler chunks, all stuff we've
generally expected to be able to look in the past for any kind of
other driver. It's event documented here:

https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements

What's your plan here?

btw since the main goal here (at least at first) seems to be get
compute and ML going the official work-around here is to relabel your
driver as an accelerator driver (just sed -e s/vGPU/vaccel/ over the
entire thing or so) and then Olof and Greg will take it into
drivers/accel ...

- Next up (but that's not really a surprise for a fresh vendor driver)
at a more technical level, this seems to reinvent the world, from
device enumeration (why is this not exposed as /dev/dri/card0 so it
better integrates with existing linux desktop stuff, in case that
becomes a goal ever) down to reinvented kref_put_mutex (and please
look at drm_device->struct_mutex for an example of how bad of a
nightmare that locking pattern is and how many years it took us to
untangle that one.

- Why DX12 on linux? Looking at this feels like classic divide and
conquer (or well triple E from the 90s), we have vk, we have
drm_syncobj, we have an entire ecosystem of winsys layers that work
across vendors. Is the plan here that we get a dx12 driver for other
hw mesa drivers from you guys, so this is all consistent and we have a
nice linux platform? How does this integrate everywhere else with
linux winsys standards, like dma-buf for passing stuff around,
dma-fence/sync_file/drm_syncobj for syncing, drm_fourcc/modifiers for
some idea how it all meshes together?

- There's been a pile of hallway track/private discussions about
moving on from the buffer-based memory managed model to something more
modern. That relates to your DXLOCK2 question, but there's a lot more
to userspace managed gpu memory residency than just that. monitored
fences are another part. Also, to avoid a platform split we need to
figure out how to tie this back into the dma-buf and dma-fence
(including various uapi flavours) or it'll be made of fail. dx12 has
all that in some form, except 0 integration with the linux stuff we
have (no surprise, since linux isn't windows). Finally if we go to the
trouble of a completely revamped I think ioctls aren't a great idea,
something like iouring (the gossip name is drm_uring) would be a lot
better. Also for easier paravirt we'd need 0 cpu pointers in any such
new interface. Adding a few people who've been involved in these
discussions thus far, mostly under a drm/hmm.ko heading iirc.

I think the above are the really big ticket items around what's the
plan here and are we solving even the right problem.

Cheers, Daniel


On Tue, May 19, 2020 at 6:33 PM Sasha Levin <sashal@kernel.org> wrote:
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
>
> The driver creates the /dev/dxg device, which can be opened by user mode
> application and handles their ioctls. The IOCTL interface to the driver
> is defined in dxgkmthk.h (Dxgkrnl Graphics Port Driver ioctl
> definitions). The interface matches the D3DKMT interface on Windows.
> Ioctls are implemented in ioctl.c.
>
> When a VM starts, hyper-v on the host adds virtual GPU devices to the VM
> via the hyper-v driver. The host offers several VM bus channels to the
> VM: the global channel and one channel per virtual GPU, assigned to the
> VM.
>
> The driver registers with the hyper-v driver (hv_driver) for the arrival
> of VM bus channels. dxg_probe_device recognizes the vGPU channels and
> creates the corresponding objects (dxgadapter for vGPUs and dxgglobal
> for the global channel).
>
> The driver uses the hyper-V VM bus interface to communicate with the
> host. dxgvmbus.c implements the communication interface.
>
> The global channel has 8GB of IO space assigned by the host. This space
> is managed by the host and used to give the guest direct CPU access to
> some allocations. Video memory is allocated on the host except in the
> case of existing_sysmem allocations. The Windows host allocates memory
> for the GPU on behalf of the guest. The Linux guest can access that
> memory by mapping GPU virtual address to allocations and then
> referencing those GPU virtual address from within GPU command buffers
> submitted to the GPU. For allocations which require CPU access, the
> allocation is mapped by the host into a location in the 8GB of IO space
> reserved in the guest for that purpose. The Windows host uses the nested
> CPU page table to ensure that this guest IO space always map to the
> correct location for the allocation as it may migrate between dedicated
> GPU memory (e.g. VRAM, firmware reserved DDR) and shared system memory
> (regular DDR) over its lifetime. The Linux guest maps a user mode CPU
> virtual address to an allocation IO space range for direct access by
> user mode APIs and drivers.
>
>
>
> Implementation of LX_DXLOCK2 ioctl
> ==================================
>
> We would appreciate your feedback on the implementation of the
> LX_DXLOCK2 ioctl.
>
> This ioctl is used to get a CPU address to an allocation, which is
> resident in video/system memory on the host. The way it works:
>
> 1. The driver sends the Lock message to the host
>
> 2. The host allocates space in the VM IO space and maps it to the
> allocation memory
>
> 3. The host returns the address in IO space for the mapped allocation
>
> 4. The driver (in dxg_map_iospace) allocates a user mode virtual address
> range using vm_mmap and maps it to the IO space using
> io_remap_ofn_range)
>
> 5. The VA is returned to the application
>
>
>
> Internal objects
> ================
>
> The following objects are created by the driver (defined in dxgkrnl.h):
>
> - dxgadapter - represents a virtual GPU
>
> - dxgprocess - tracks per process state (handle table of created
>   objects, list of objects, etc.)
>
> - dxgdevice - a container for other objects (contexts, paging queues,
>   allocations, GPU synchronization objects)
>
> - dxgcontext - represents thread of GPU execution for packet
>   scheduling.
>
> - dxghwqueue - represents thread of GPU execution of hardware scheduling
>
> - dxgallocation - represents a GPU accessible allocation
>
> - dxgsyncobject - represents a GPU synchronization object
>
> - dxgresource - collection of dxgalloction objects
>
> - dxgsharedresource, dxgsharedsyncobj - helper objects to share objects
>   between different dxgdevice objects, which can belong to different
> processes
>
>
>
> Object handles
> ==============
>
> All GPU objects, created by the driver, are accessible by a handle
> (d3dkmt_handle). Each process has its own handle table, which is
> implemented in hmgr.c. For each API visible object, created by the
> driver, there is an object, created on the host. For example, the is a
> dxgprocess object on the host for each dxgprocess object in the VM, etc.
> The object handles have the same value in the host and the VM, which is
> done to avoid translation from the guest handles to the host handles.
>
>
>
> Signaling CPU events by the host
> ================================
>
> The WDDM interface provides a way to signal CPU event objects when
> execution of a context reached certain point. The way it is implemented:
>
> - application sends an event_fd via ioctl to the driver
>
> - eventfd_ctx_get is used to get a pointer to the file object
>   (eventfd_ctx)
>
> - the pointer to sent the host via a VM bus message
>
> - when GPU execution reaches a certain point, the host sends a message
>   to the VM with the event pointer
>
> - signal_guest_event() handles the messages and eventually
>   eventfd_signal() is called.
>
>
> Sasha Levin (4):
>   gpu: dxgkrnl: core code
>   gpu: dxgkrnl: hook up dxgkrnl
>   Drivers: hv: vmbus: hook up dxgkrnl
>   gpu: dxgkrnl: create a MAINTAINERS entry
>
>  MAINTAINERS                      |    7 +
>  drivers/gpu/Makefile             |    2 +-
>  drivers/gpu/dxgkrnl/Kconfig      |   10 +
>  drivers/gpu/dxgkrnl/Makefile     |   12 +
>  drivers/gpu/dxgkrnl/d3dkmthk.h   | 1635 +++++++++
>  drivers/gpu/dxgkrnl/dxgadapter.c | 1399 ++++++++
>  drivers/gpu/dxgkrnl/dxgkrnl.h    |  913 ++++++
>  drivers/gpu/dxgkrnl/dxgmodule.c  |  692 ++++
>  drivers/gpu/dxgkrnl/dxgprocess.c |  355 ++
>  drivers/gpu/dxgkrnl/dxgvmbus.c   | 2955 +++++++++++++++++
>  drivers/gpu/dxgkrnl/dxgvmbus.h   |  859 +++++
>  drivers/gpu/dxgkrnl/hmgr.c       |  593 ++++
>  drivers/gpu/dxgkrnl/hmgr.h       |  107 +
>  drivers/gpu/dxgkrnl/ioctl.c      | 5269 ++++++++++++++++++++++++++++++
>  drivers/gpu/dxgkrnl/misc.c       |  280 ++
>  drivers/gpu/dxgkrnl/misc.h       |  288 ++
>  drivers/video/Kconfig            |    2 +
>  include/linux/hyperv.h           |   16 +
>  18 files changed, 15393 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/dxgkrnl/Kconfig
>  create mode 100644 drivers/gpu/dxgkrnl/Makefile
>  create mode 100644 drivers/gpu/dxgkrnl/d3dkmthk.h
>  create mode 100644 drivers/gpu/dxgkrnl/dxgadapter.c
>  create mode 100644 drivers/gpu/dxgkrnl/dxgkrnl.h
>  create mode 100644 drivers/gpu/dxgkrnl/dxgmodule.c
>  create mode 100644 drivers/gpu/dxgkrnl/dxgprocess.c
>  create mode 100644 drivers/gpu/dxgkrnl/dxgvmbus.c
>  create mode 100644 drivers/gpu/dxgkrnl/dxgvmbus.h
>  create mode 100644 drivers/gpu/dxgkrnl/hmgr.c
>  create mode 100644 drivers/gpu/dxgkrnl/hmgr.h
>  create mode 100644 drivers/gpu/dxgkrnl/ioctl.c
>  create mode 100644 drivers/gpu/dxgkrnl/misc.c
>  create mode 100644 drivers/gpu/dxgkrnl/misc.h
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
