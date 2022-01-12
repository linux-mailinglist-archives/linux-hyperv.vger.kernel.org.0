Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6724948CC91
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jan 2022 20:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbiALT4f (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jan 2022 14:56:35 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33280 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357555AbiALTzQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jan 2022 14:55:16 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1A26320B7179;
        Wed, 12 Jan 2022 11:55:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A26320B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642017315;
        bh=x15IDYVjN7RmJq/ZDmcFJDGLtztPJCe768FLoWupCoM=;
        h=From:To:Cc:Subject:Date:From;
        b=dA8EE64ArzO25ASyZjuC3XxzhAWvfPmmI2H7xEkLri37zgsWTxAn14xVLcF0jQ96q
         IOK3dCOtapaCCil0sDwv7Bb/LQXvPAkA/FT2eODBnsr36O/iYzw2uTSKlX+J57ofhl
         JRIGWyRtdpbCYcSFx16FpKQFn+1lDPwnEt9z5EzQ=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v1 0/9] drivers: hv: dxgkrnl: Driver overview
Date:   Wed, 12 Jan 2022 11:55:05 -0800
Message-Id: <cover.1641937419.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is a follow-up on the changes we sent a few months back[1].

[1] https://lore.kernel.org/lkml/20200814123856.3880009-1-sashal@kernel.org/

The patches address the feedback, given by Greg KH and other reviewers, contain
bug fixes, the implementation of asynchronous VM bus messages to the host
and contain the remaining implementation of our vGPU / Compute hardware
virtualization support that powers the Windows Subsystem for Linux (WSL) and
will soon power the Windows Subsystem for Android (WSA).

This set of patches is rebuilt from ground up and organized in logical layers
to better understand how the driver is built, making it easier for reviewers
to understand and follow. The first patch introduces headers and driver
initialization. The subsequent patches add additional functionality to the
driver.

Per earlier feedback, the driver is now located under the Hyper-V node as it
is not a classic Linux GPU (KMS/DRM) driver and really only make sense
when running under a Windows host under Hyper-V. Although we refer to this
driver as vGPU for shorthand, in reality this is a generic virtualization
infrastructure for various class of compute accelerators, the most popular
and ubiquitous being the GPU. We support virtualization of non-GPU devices
through this infrastructure. These devices are exposed to user-space and
used by various API and framework, such as CUDA, OpenCL, OpenVINO,
OneAPI, DX12, etc...

One critical piece of feedback, provided by the community in our earlier
submission, was the lack of an open source user-space to go along with our
kernel compute driver. At the time we only had CUDA and DX12 user-space APIs,
both of which being closed source. This is a divisive issue in the community
and is heavily debated (https://lwn.net/Articles/821817/).

We took this feedback to heart and we spent the last year working on a way
to address this key piece of feedback. Working closely with our partner Intel,
we're happy to say that we now have a fully open source user-space for the
OpenCL, OpenVINO and OneAPI compute family of APIs on Intel GPU platforms.
This is supported by this open source project
(https://github.com/intel/compute-runtime).

To make it easy for our partners to build compute drivers, which are usable
in both Windows and WSL environment, we provide a library, that provides a
stable interface to our compute device abstraction. This was originally part
of the libdxcore closed source API, but have now spawn that off into it's
own open source project (https://github.com/microsoft/libdxg).

Between the Intel compute runtime project and libdxg, we now have a fully
open source implementation of our virtualized compute stack inside of WSL.
We will continue to support both open source user-space API against our
compute abstraction as well as closed source one (CUDA, DX12), leaving
it to the API owners and partners to decide what makes the most sense for them.

A lot of efforts went into addressing community feedback in this revised
set of patches and we hope this is getting closer to what the community
would like to see.

We're looking forward additional feedback.

Overview
-------------------------------------------------------
dxgkrnl is a driver for Hyper-V virtual compute devices, such as vGPU
devices, which are projected to a Linux virtual machine (VM) by a Windows
host. dxgkrnl works in context of WDDM (Windows Display Driver Model)
for GPU or MCDM (Microsoft Compute Driver Model) for non-GPU devices.
WDDM/MCDM consists of the following components:
- Graphics or Compute applications
- A graphics or compute user mode API (for example OpenGL, Vulkan, OpenCL,
  OpenVINO, OneAPI, CUDA, DX12, ...)
- User Mode Driver (UMD), written by a hardware vendor
- optional libdxg library helping UMD portability across Windows and Linux
- dxgkrnl Linux kernel driver (this driver)
- Kernel mode port driver on the Windows host (dxgkrnl.sys / dxgmms*.sys)
- Kernel Mode miniport driver (KMD) on the Windows host, written by a
  hardware vendor running on the Windows host and interfacing with the
  hardware device.

dxgkrnl exposes a subset the WDDM/MCDM D3DKMT interface to user space. See
https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/d3dkmthk/
This interface provides user space with an abstracted view and control
of compute devices in a portable way across Windows and WSL. It is used for
devices such as GPU or AI/ML processors. This interface is mapped to custom
IOCTLs on Linux (see d3dkmthk.h).

A more detailed overview of this architecture is available here:
https://devblogs.microsoft.com/directx/directx-heart-linux/

Compute devices are paravirtualized, meaning that the actual communication with
the corresponding device happens on the host. The version of dxgkrnl inside
of the Linux kernel coordinates with the version of dxgkrnl running on Windows
to provide a consistent and portable abstraction for the device that the various
APIs and UMD can rely on across Windows and Linux.

Dxgkrnl creates the /dev/dxg device, which can be used to enumerate devices.
UMD or an API runtime open the device and send ioctls to create various device
objects (dxgdevice, dxgcontext, dxgallocation, etc., defined in dxgkrnl.h)
and to submit work to the device. The WDDM objects are represented in user mode
as opaque handles (struct d3dkmthandle). Dxgkrnl creates a dxgprocess object
for each process, which opens the /dev/dxg device. This object has a handle
table, which is used to translate d3dkmt handles to kernel objects. Handle
table definitions are in hmgr.h. There is also a global handle table for
objects, which do not belong to a particular process.

Driver initialization
-------------------------------------------------------
When dxgkrnl is loaded, dxgkrnl registers for virtual PCI device arrival
notifications and VM bus channel device notifications (see dxgmodule.c). When
the first virtual device is started, dxgkrnl creates a misc device (/dev/dxg).
A user mode client can open the /dev/dxg device and send IOCTLs to enumerate
and control virtual compute devices.

Virtual device initialization
-------------------------------------------------------
A virtual device is represented by a dxgadapter object. It is created when the
corresponding device arrives on the virtual PCI bus. The device vendor is
PCI_VENDOR_ID_MICROSOFT and the device id is PCI_DEVICE_ID_VIRTUAL_RENDER.
The adapter is started when the corresponding VM bus channel and the global
VM bus channel are initialized.
Dynamic arrival/removal of devices is supported.

Internal objects
-------------------------------------------------------
Dxgkrnl creates various internal objects in response to IOCTL calls. The
corresponsing objects are also created on the host. Each object is placed to
a process or global handle table. Object handles (d3dkmthandle) are returned
to user mode. The object handles are also used to reference objects on the host.
Corresponding objects in the guest and the host have the same handle value to
avoid handle translation. The internal objects are:
- dxgadapter
  Represents a virtual device object. It is created for every device projected by
  the host to the VM.
- dxgprocess
  The object is created for each Linux process, which opens /dxg/dev. It has the
  object handle table, which holds pointers to all internal objects, which are
  created by this process.
- dxgcontext
  Represents a device execution thread in the packet scheduling mode (as oppose to
  the hardware scheduling mode).
- dxghwqueue
  Represents a device execution thread in the hardware scheduling mode.
- dxgdevice
  A collection of device contexts, allocations, resources, sync objects, etc.
- dxgallocation
  Represents a device accessible memory allocation.
- dxgresource
  A collection of dxgallocation objects. This object could be shared between
  devices and processes.
- dxgsharedresource
  Represents a dxgresource object, which is sharable between processes.
- dxgsyncobject
  Represents a device synchronization object, which is used to synchronize
  execution of the device execution contexts.
- dxgsharedsyncobject
  Represent a device synchronization object, which is sharable between processes.
- dxgpagingqueue
  Represents a queue, which is used to manage residency of the device allocation
  objects.

Communications with the host
-------------------------------------------------------
Dxgkrnl communicates with the host via Hyper-V VM bus channels. There is a
global channel and a per device channel.  The VM bus messages are defined in
dxgvmbus.h and the implementation is in dxgvmbus.c.

Most VM bus messages to the host are synchronous. When the host enables the
asynchronous mode, some high frequency VM bus messages are sent asynchronously
to improve performance. When async messages are enabled, all VM bus messages are
sent only via the global channel to maintain the order of messages on the host.

The host could send asynchronous messages to dxgkrnl via the global VM bus
channel. The host messages are handled by dxgvmbuschannel_receive().

PCI config space of the device is used to exchange information between the host
and the guest during dxgkrnl initialization. Look at dxg_pci_probe_device().

CPU access to device accessible allocations
-------------------------------------------------------
D3DKMT API allows creation of allocations, which are accessible by the device
and the CPU. The global VM bus channels has associated IO space, which is used
to implement CPU access to CPU visible allocations. For each such allocation
the host allocates a portion of the guest IO space and maps it to the
allocation memory (it could be in system memory or in device local memory).
A user mode application calls the LX_DXLOCK2 ioctl to get the allocation
CPU address. Dxgkrnl uses vm_mmap to allocate a user space VA range and maps
it to the allocation IO space using io_remap_pfn_range(). This way Linux
user mode virtual addresses point to the host system memory or device local
memory.

Sharing objects between processes
-------------------------------------------------------
Some dxgkrnl objects could be shared between processes. This includes resources
(dxgresource) and synchronization objects (dxgsyncobject).
The WDDM API provides a way to share objects using so called "NT handles".
"NT handle" on Windows is a native Windows process handle (HANDLE). "NT handles"
are implemented as file descriptors (FD) on Linux.
The LX_DXSHAREOBJECTS ioctl is used to get an FD for a shared object.
Before a shared object can be used, it needs to be "opened" to get the "local"
d3dkmthandle handle. The LX_DXOPENRESOURCEFROMNTHANDLE and
LX_DXOPENSYNCOBJECTFROMNTHANDLE2 aioctls re used to open a shared object.

Iouri Tarassov (9):
  drivers: hv: dxgkrnl: Driver initialization and creation of dxgadapter
  drivers: hv: dxgkrnl: Open device object, adapter enumeration,
    dxgdevice, dxgcontext creation
  drivers: hv: dxgkrnl: Implement creation/destruction of GPU
    allocations/resources
  drivers: hv: dxgkrnl: Implement operations with GPU sync objects
  drivers: hv: dxgkrnl: Implement sharing resources and sync objects
  drivers: hv: dxgkrnl: Seal the shared resource object when
    dxgk_share_objects is called.
  drivers: hv: dxgkrnl: Implementation of submit command, paging and
    hardware queue.
  drivers: hv: dxgkrnl: Implement various WDDM ioctls
  drivers: hv: dxgkrnl: Implement DXGSYNCFILE

 MAINTAINERS                      |    7 +
 drivers/hv/Kconfig               |    2 +
 drivers/hv/Makefile              |    1 +
 drivers/hv/dxgkrnl/Kconfig       |   28 +
 drivers/hv/dxgkrnl/Makefile      |    5 +
 drivers/hv/dxgkrnl/dxgadapter.c  | 1375 ++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h     |  953 ++++++
 drivers/hv/dxgkrnl/dxgmodule.c   |  924 +++++
 drivers/hv/dxgkrnl/dxgprocess.c  |  343 ++
 drivers/hv/dxgkrnl/dxgsyncfile.c |  210 ++
 drivers/hv/dxgkrnl/dxgsyncfile.h |   30 +
 drivers/hv/dxgkrnl/dxgvmbus.c    | 3725 ++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h    |  928 +++++
 drivers/hv/dxgkrnl/hmgr.c        |  597 ++++
 drivers/hv/dxgkrnl/hmgr.h        |  112 +
 drivers/hv/dxgkrnl/ioctl.c       | 5458 ++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/misc.c        |   43 +
 drivers/hv/dxgkrnl/misc.h        |   97 +
 include/linux/hyperv.h           |   16 +
 include/uapi/misc/d3dkmthk.h     | 1954 +++++++++++
 20 files changed, 16808 insertions(+)
 create mode 100644 drivers/hv/dxgkrnl/Kconfig
 create mode 100644 drivers/hv/dxgkrnl/Makefile
 create mode 100644 drivers/hv/dxgkrnl/dxgadapter.c
 create mode 100644 drivers/hv/dxgkrnl/dxgkrnl.h
 create mode 100644 drivers/hv/dxgkrnl/dxgmodule.c
 create mode 100644 drivers/hv/dxgkrnl/dxgprocess.c
 create mode 100644 drivers/hv/dxgkrnl/dxgsyncfile.c
 create mode 100644 drivers/hv/dxgkrnl/dxgsyncfile.h
 create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.c
 create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.h
 create mode 100644 drivers/hv/dxgkrnl/hmgr.c
 create mode 100644 drivers/hv/dxgkrnl/hmgr.h
 create mode 100644 drivers/hv/dxgkrnl/ioctl.c
 create mode 100644 drivers/hv/dxgkrnl/misc.c
 create mode 100644 drivers/hv/dxgkrnl/misc.h
 create mode 100644 include/uapi/misc/d3dkmthk.h

-- 
2.32.0

