Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4344D4AADAB
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Feb 2022 05:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiBFEPn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Feb 2022 23:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBFEPm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Feb 2022 23:15:42 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C96C06173B;
        Sat,  5 Feb 2022 20:15:40 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id s24so5808385oic.6;
        Sat, 05 Feb 2022 20:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iezE6Xqc6hFU7aHTVpwF61JgkfP7V/wCbDedqGRrLIY=;
        b=BZq2FUh3xq7vF5ZFHzRRdv9LgekvSS5BXAnhbNwSDGEmBMdcFEoUVASM3kMgDLfnsR
         seGz1RWHXtZGn/SI4SQ2vvAwU1/ecnhPiJIYWRNybwcAD8FwvZLJCbVuoN8jdbBxE+Ap
         AQf+JQKiKvDb3kaHOuNFHpvaMiDHehPIe+uABuL04EuCrcITa9kWr1qCNu3r8b+QnvQn
         /zgEnHV0kM3R5/LgDWTQNE+3rHJDOy8iwZLFs+38KO4cw5C5ZwQ3FU7kOTNCfc/pM+gS
         m/ZVbDD+r57L6kVKdyGDnzBF+SgksgxK7+mVQPtenT9sDqcQBCk6nfuIKo7PaDIKNTtd
         e2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iezE6Xqc6hFU7aHTVpwF61JgkfP7V/wCbDedqGRrLIY=;
        b=hH36IRJ3HPP1PnanJI6pAcualCvEJeN9ZzrQb/m8kxhNw5LNWm5OOfLDvCMvWPSBJ6
         FiWTI9CcfD6JAIezKAevGwsU5hmxo56oBHq60lZ2lkzOdVCyVvrfDANDBA+/syqtKwEJ
         CKz+0Eu1fwCg1dx6TWIpTjf588wTZJ422FYcZFBjabNp5K3n2T8pWl2uHMhRTohz2nCb
         36PrYGKvSHRAfP4+z30GPTfMKoem1hhpUe21/ttTm6VDEoKqolHsCSXlRh8bOJzlHj6O
         +AtjGElUA94ARRoXsTBJGlc7qkUZZyvZgrvRX+4Rv9Q7I0tEOa3rtVfdfVjbD+D0Eyxz
         OXww==
X-Gm-Message-State: AOAM530y/HeE1aOrlJjgexk6LG7Y5Qfh82Usj19ZtYGLNArtDQPOf4ns
        1kbD+dUQTZxVonXsWtlXpO1VSz1/qdDgt2arnQG58PxT
X-Google-Smtp-Source: ABdhPJwXRZZSkLsS4riOO7I3Yb1GIQOGQj5hyIMci5CoZ1ckmzLXY6x7OJZoP+mFFFki4SXYgbXobVDSqWHGsvamcRM=
X-Received: by 2002:a05:6808:1184:: with SMTP id j4mr2843441oil.73.1644120938968;
 Sat, 05 Feb 2022 20:15:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644025661.git.iourit@linux.microsoft.com>
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Sat, 5 Feb 2022 21:15:27 -0700
Message-ID: <CADvTj4riwoFngTkAOTyc=SuZ3FeTwpyz3FteV_+3BiQ=uiLX7Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] Driver for Hyper-v virtual compute device
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
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

On Fri, Feb 4, 2022 at 7:33 PM Iouri Tarassov
<iourit@linux.microsoft.com> wrote:
>
> This is a follow-up on the changes we sent a few weeks back[1]
>
> [1] https://lore.kernel.org/lkml/cover.1641937419.git.iourit@linux.microsoft.com/
>
> The changes since [1]:
>
> - the driver code is split to more patches for easy reviewing
> - static variable dxgglobaldev is removed
> - various compiler warnings are fixed
> - the patch for DXGSYNCFILE is removed. This patch requires more work and will
> be submitted separately.
>
> Foreword
> -------------------------------------------------------
> The patches contain implementation of the Hyper-V vGPU / Compute hardware
> driver, which powers the Windows Subsystem for Linux (WSL) and will soon power
> the Windows Subsystem for Android (WSA).
>
> This set of patches is rebuilt from ground up and organized in logical layers
> to better understand how the driver is built, making it easier for reviewers
> to understand and follow. The first patch introduces headers and driver
> initialization. The subsequent patches add additional functionality to the
> driver.
>
> Per earlier feedback, the driver is now located under the Hyper-V node as it
> is not a classic Linux GPU (KMS/DRM) driver and really only make sense
> when running under a Windows host under Hyper-V. Although we refer to this
> driver as vGPU for shorthand, in reality this is a generic virtualization
> infrastructure for various class of compute accelerators, the most popular
> and ubiquitous being the GPU. We support virtualization of non-GPU devices
> through this infrastructure. These devices are exposed to user-space and
> used by various API and framework, such as CUDA, OpenCL, OpenVINO,
> OneAPI, DX12, etc...
>
> One critical piece of feedback, provided by the community in our earlier
> submission, was the lack of an open source user-space to go along with our
> kernel compute driver. At the time we only had CUDA and DX12 user-space APIs,
> both of which being closed source. This is a divisive issue in the community
> and is heavily debated (https://lwn.net/Articles/821817/).
>
> We took this feedback to heart and we spent the last year working on a way
> to address this key piece of feedback. Working closely with our partner Intel,
> we're happy to say that we now have a fully open source user-space for the
> OpenCL, OpenVINO and OneAPI compute family of APIs on Intel GPU platforms.
> This is supported by this open source project
> (https://github.com/intel/compute-runtime).
>
> To make it easy for our partners to build compute drivers, which are usable
> in both Windows and WSL environment, we provide a library, that provides a
> stable interface to our compute device abstraction. This was originally part
> of the libdxcore closed source API, but have now spawn that off into it's
> own open source project (https://github.com/microsoft/libdxg).
>
> Between the Intel compute runtime project and libdxg, we now have a fully
> open source implementation of our virtualized compute stack inside of WSL.
> We will continue to support both open source user-space API against our
> compute abstraction as well as closed source one (CUDA, DX12), leaving
> it to the API owners and partners to decide what makes the most sense for them.

Does the fully open source user-space implementation actually use the entire
user-space API exposed by this driver?

It's not entirely clear but it appears that a good portion of the user-space API
for this driver is unused and only has corresponding userspace library defines
but not any actual usage(in the open source implementation at least).

It seems like it may be a good idea to audit the ioctls and make sure
all of them
actually get used by the open source userspace to ensure that we don't have any
exposed uapi's which only have closed source userspace consumers.

>
> A lot of efforts went into addressing community feedback in this revised
> set of patches and we hope this is getting closer to what the community
> would like to see.
>
> We're looking forward additional feedback.
>
> Driver overview
> -------------------------------------------------------
> dxgkrnl is a driver for Hyper-V virtual compute devices, such as vGPU
> devices, which are projected to a Linux virtual machine (VM) by a Windows
> host. dxgkrnl works in context of WDDM (Windows Display Driver Model)
> for GPU or MCDM (Microsoft Compute Driver Model) for non-GPU devices.
> WDDM/MCDM consists of the following components:
> - Graphics or Compute applications
> - A graphics or compute user mode API (for example OpenGL, Vulkan, OpenCL,
>   OpenVINO, OneAPI, CUDA, DX12, ...)
> - User Mode Driver (UMD), written by a hardware vendor
> - optional libdxg library helping UMD portability across Windows and Linux
> - dxgkrnl Linux kernel driver (this driver)
> - Kernel mode port driver on the Windows host (dxgkrnl.sys / dxgmms*.sys)
> - Kernel Mode miniport driver (KMD) on the Windows host, written by a
>   hardware vendor running on the Windows host and interfacing with the
>   hardware device.
>
> dxgkrnl exposes a subset the WDDM/MCDM D3DKMT interface to user space. See
> https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/d3dkmthk/
> This interface provides user space with an abstracted view and control
> of compute devices in a portable way across Windows and WSL. It is used for
> devices such as GPU or AI/ML processors. This interface is mapped to custom
> IOCTLs on Linux (see d3dkmthk.h).
>
> A more detailed overview of this architecture is available here:
> https://devblogs.microsoft.com/directx/directx-heart-linux/
>
> Compute devices are paravirtualized, meaning that the actual communication with
> the corresponding device happens on the host. The version of dxgkrnl inside
> of the Linux kernel coordinates with the version of dxgkrnl running on Windows
> to provide a consistent and portable abstraction for the device that the various
> APIs and UMD can rely on across Windows and Linux.
>
> Dxgkrnl creates the /dev/dxg device, which can be used to enumerate devices.
> UMD or an API runtime open the device and send ioctls to create various device
> objects (dxgdevice, dxgcontext, dxgallocation, etc., defined in dxgkrnl.h)
> and to submit work to the device. The WDDM objects are represented in user mode
> as opaque handles (struct d3dkmthandle). Dxgkrnl creates a dxgprocess object
> for each process, which opens the /dev/dxg device. This object has a handle
> table, which is used to translate d3dkmt handles to kernel objects. Handle
> table definitions are in hmgr.h. There is also a global handle table for
> objects, which do not belong to a particular process.
>
> Driver initialization
> -------------------------------------------------------
> When dxgkrnl is loaded, dxgkrnl registers for virtual PCI device arrival
> notifications and VM bus channel device notifications (see dxgmodule.c). When
> the first virtual device is started, dxgkrnl creates a misc device (/dev/dxg).
> A user mode client can open the /dev/dxg device and send IOCTLs to enumerate
> and control virtual compute devices.
>
> Virtual device initialization
> -------------------------------------------------------
> A virtual device is represented by a dxgadapter object. It is created when the
> corresponding device arrives on the virtual PCI bus. The device vendor is
> PCI_VENDOR_ID_MICROSOFT and the device id is PCI_DEVICE_ID_VIRTUAL_RENDER.
> The adapter is started when the corresponding VM bus channel and the global
> VM bus channel are initialized.
> Dynamic arrival/removal of devices is supported.
>
> Internal objects
> -------------------------------------------------------
> Dxgkrnl creates various internal objects in response to IOCTL calls. The
> corresponsing objects are also created on the host. Each object is placed to
> a process or global handle table. Object handles (d3dkmthandle) are returned
> to user mode. The object handles are also used to reference objects on the host.
> Corresponding objects in the guest and the host have the same handle value to
> avoid handle translation. The internal objects are:
> - dxgadapter
>   Represents a virtual device object. It is created for every device projected by
>   the host to the VM.
> - dxgprocess
>   The object is created for each Linux process, which opens /dxg/dev. It has the
>   object handle table, which holds pointers to all internal objects, which are
>   created by this process.
> - dxgcontext
>   Represents a device execution thread in the packet scheduling mode (as oppose to
>   the hardware scheduling mode).
> - dxghwqueue
>   Represents a device execution thread in the hardware scheduling mode.
> - dxgdevice
>   A collection of device contexts, allocations, resources, sync objects, etc.
> - dxgallocation
>   Represents a device accessible memory allocation.
> - dxgresource
>   A collection of dxgallocation objects. This object could be shared between
>   devices and processes.
> - dxgsharedresource
>   Represents a dxgresource object, which is sharable between processes.
> - dxgsyncobject
>   Represents a device synchronization object, which is used to synchronize
>   execution of the device execution contexts.
> - dxgsharedsyncobject
>   Represent a device synchronization object, which is sharable between processes.
> - dxgpagingqueue
>   Represents a queue, which is used to manage residency of the device allocation
>   objects.
>
> Communications with the host
> -------------------------------------------------------
> Dxgkrnl communicates with the host via Hyper-V VM bus channels. There is a
> global channel and a per device channel.  The VM bus messages are defined in
> dxgvmbus.h and the implementation is in dxgvmbus.c.
>
> Most VM bus messages to the host are synchronous. When the host enables the
> asynchronous mode, some high frequency VM bus messages are sent asynchronously
> to improve performance. When async messages are enabled, all VM bus messages are
> sent only via the global channel to maintain the order of messages on the host.
>
> The host could send asynchronous messages to dxgkrnl via the global VM bus
> channel. The host messages are handled by dxgvmbuschannel_receive().
>
> PCI config space of the device is used to exchange information between the host
> and the guest during dxgkrnl initialization. Look at dxg_pci_probe_device().
>
> CPU access to device accessible allocations
> -------------------------------------------------------
> D3DKMT API allows creation of allocations, which are accessible by the device
> and the CPU. The global VM bus channels has associated IO space, which is used
> to implement CPU access to CPU visible allocations. For each such allocation
> the host allocates a portion of the guest IO space and maps it to the
> allocation memory (it could be in system memory or in device local memory).
> A user mode application calls the LX_DXLOCK2 ioctl to get the allocation
> CPU address. Dxgkrnl uses vm_mmap to allocate a user space VA range and maps
> it to the allocation IO space using io_remap_pfn_range(). This way Linux
> user mode virtual addresses point to the host system memory or device local
> memory.
>
> Sharing objects between processes
> -------------------------------------------------------
> Some dxgkrnl objects could be shared between processes. This includes resources
> (dxgresource) and synchronization objects (dxgsyncobject).
> The WDDM API provides a way to share objects using so called "NT handles".
> "NT handle" on Windows is a native Windows process handle (HANDLE). "NT handles"
> are implemented as file descriptors (FD) on Linux.
> The LX_DXSHAREOBJECTS ioctl is used to get an FD for a shared object.
> Before a shared object can be used, it needs to be "opened" to get the "local"
> d3dkmthandle handle. The LX_DXOPENRESOURCEFROMNTHANDLE and
> LX_DXOPENSYNCOBJECTFROMNTHANDLE2 aioctls re used to open a shared object.
>
> Iouri Tarassov (24):
>   drivers: hv: dxgkrnl: Driver initialization and creation of dxgadapter
>   drivers: hv: dxgkrnl: Open device file and dxgprocess creation
>   drivers: hv: dxgkrnl: Enumerate and open dxgadapter objects
>   drivers: hv: dxgkrnl: Creation of dxgdevice
>   drivers: hv: dxgkrnl: Creation of dxgcontext objects
>   drivers: hv: dxgkrnl: Creation of GPU allocations and resources
>   drivers: hv: dxgkrnl: Create and destroy GPU sync objects
>   drivers: hv: dxgkrnl: Operations using GPU sync objects
>   drivers: hv: dxgkrnl: Sharing of dxgresource objects
>   drivers: hv: dxgkrnl: Sharing of sync objects
>   drivers: hv: dxgkrnl: Creation of hardware queue. Sync object
>     operations to hw queue.
>   drivers: hv: dxgkrnl: Creation of paging queue objects.
>   drivers: hv: dxgkrnl: Submit execution commands to the compute device
>   drivers: hv: dxgkrnl: Implement LX_DXSHAREOBJECTWITHHOST ioctl
>   drivers: hv: dxgkrnl: IOCTL to get the dxgdevice state
>     LX_DXGETDEVICESTATE
>   drivers: hv: dxgkrnl: Mmap(unmap) CPU address to device allocation:
>     LX_DXLOCK2, LX_DXUNLOCK2
>   drivers: hv: dxgkrnl: IOCTLs to handle GPU allocation properties
>   drivers: hv: dxgkrnl: Various simple IOCTLs and unused ones
>     LX_DXQUERYVIDEOMEMORYINFO, LX_DXFLUSHHEAPTRANSITIONS,
>     LX_DXINVALIDATECACHE  LX_DXGETSHAREDRESOURCEADAPTERLUID
>   drivers: hv: dxgkrnl: Simple IOCTLs LX_DXESCAPE,
>     LX_DXMARKDEVICEASERROR, LX_DXQUERYSTATISTICS,
>     LX_DXQUERYCLOCKCALIBRATION
>   drivers: hv: dxgkrnl: IOCTLs to offer and reclaim allocations
>   drivers: hv: dxgkrnl: Ioctls to set/get scheduling priority
>   drivers: hv: dxgkrnl: IOCTLs to manage allocation residency
>   drivers: hv: dxgkrnl: IOCTLs to handle GPU virtual addressing (GPU VA)
>   drivers: hv: dxgkrnl: Add support to map guest pages by host
>
>  MAINTAINERS                     |    7 +
>  drivers/hv/Kconfig              |    2 +
>  drivers/hv/Makefile             |    1 +
>  drivers/hv/dxgkrnl/Kconfig      |   26 +
>  drivers/hv/dxgkrnl/Makefile     |    5 +
>  drivers/hv/dxgkrnl/dxgadapter.c | 1371 ++++++++
>  drivers/hv/dxgkrnl/dxgkrnl.h    |  956 ++++++
>  drivers/hv/dxgkrnl/dxgmodule.c  |  942 ++++++
>  drivers/hv/dxgkrnl/dxgprocess.c |  334 ++
>  drivers/hv/dxgkrnl/dxgvmbus.c   | 3750 +++++++++++++++++++++
>  drivers/hv/dxgkrnl/dxgvmbus.h   |  882 +++++
>  drivers/hv/dxgkrnl/hmgr.c       |  566 ++++
>  drivers/hv/dxgkrnl/hmgr.h       |  112 +
>  drivers/hv/dxgkrnl/ioctl.c      | 5450 +++++++++++++++++++++++++++++++
>  drivers/hv/dxgkrnl/misc.c       |   43 +
>  drivers/hv/dxgkrnl/misc.h       |   96 +
>  include/linux/hyperv.h          |   16 +
>  include/uapi/misc/d3dkmthk.h    | 1945 +++++++++++
>  18 files changed, 16504 insertions(+)
>  create mode 100644 drivers/hv/dxgkrnl/Kconfig
>  create mode 100644 drivers/hv/dxgkrnl/Makefile
>  create mode 100644 drivers/hv/dxgkrnl/dxgadapter.c
>  create mode 100644 drivers/hv/dxgkrnl/dxgkrnl.h
>  create mode 100644 drivers/hv/dxgkrnl/dxgmodule.c
>  create mode 100644 drivers/hv/dxgkrnl/dxgprocess.c
>  create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.c
>  create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.h
>  create mode 100644 drivers/hv/dxgkrnl/hmgr.c
>  create mode 100644 drivers/hv/dxgkrnl/hmgr.h
>  create mode 100644 drivers/hv/dxgkrnl/ioctl.c
>  create mode 100644 drivers/hv/dxgkrnl/misc.c
>  create mode 100644 drivers/hv/dxgkrnl/misc.h
>  create mode 100644 include/uapi/misc/d3dkmthk.h
>
> --
> 2.35.1
>
>
>
