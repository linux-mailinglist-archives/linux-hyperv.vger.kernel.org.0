Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E966148D313
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jan 2022 08:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiAMHng (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Jan 2022 02:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiAMHnf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Jan 2022 02:43:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3931FC06173F;
        Wed, 12 Jan 2022 23:43:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1C27B82017;
        Thu, 13 Jan 2022 07:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B13C36AE3;
        Thu, 13 Jan 2022 07:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642059812;
        bh=fnnJBlH0u6ip/NvEi+buzoRsa1aNMDokJlFRs9qzyII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uSL6wbn50ncS7Hxn7FwohdoxyjvBfE3y2W0t1V+Ab3/FqvfwIPT6JcY/ykWNCbzNW
         1aONMEPuHNAioAKkXhkKJg7UGqHnGVq4L73vn7jyMIOaIAXBfB00bFCe8YwyXTaglR
         kR75n43ui0gvRLhJY2SR80OTLp7TOHOQqBOQdQCU=
Date:   Thu, 13 Jan 2022 08:43:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH v1 1/9] drivers: hv: dxgkrnl: Driver initialization and
 creation of dxgadapter
Message-ID: <Yd/YIZQqn7Uvi8dB@kroah.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <1b26482b50832b95a9d8532c493cee6c97323b87.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b26482b50832b95a9d8532c493cee6c97323b87.1641937419.git.iourit@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 12, 2022 at 11:55:06AM -0800, Iouri Tarassov wrote:
> - Add support for a Hyper-V based vGPU implementation that exposes the
>   DirectX API to Linux userspace.
> - Handle driver loading, registration for the PCI and VM bus device
>   notifications
> - Add headers for user mode interfaces, internal driver objects and VM bus
>   communication interface
> - Handle initialization of VM bus channels and creation of the dxgadapter
>   object
> - Removed dxg_copy_from_user and dxg_copy_to_user
> - Connect the dxgkrnl module to the drivers/hv/ makefile and Kconfig.
> - Create a MAINTAINERS entry

This looks like a history list?

What exactly is this?

> 
> PCI driver registration
> 
> A PCI device is created for each virtual GPU (vGPU) device, projected by
> the host. The device vendor is PCI_VENDOR_ID_MICROSOFT and device id is
> PCI_DEVICE_ID_VIRTUAL_RENDER. dxg_pci_probe_device handles arrival of such
> devices and it creates dxgadapter objects. The PCI config space of the
> vGPU device has luid of the corresponding per GPU VM bus channel. This is
> how the adapters are linked to VM bus channels.
> 
> dxgadapter initialization
> 
> A dxgadapter object represents a virtual GPU, projected to the VM by the
> host. This object can start functioning only when the global VM bus
> channel and the corresponding per vGPU VM bus channel are initialized in
> the guest. Notifications about arrival of vGPU PCI device and VM bus
> channels can happen in any order. Therefore, the initial dxgadapter object
> state is DXGADAPTER_STATE_WAITING_VMBUS. A list of VM bus channels and a
> list of dxgadapter objects are created. When dxgkrnl is notified about a
> VM bus channel arrival, if tries to start all adapters, which are not
> started yet.
> 
> VM bus interface version is exchanged by reading/writing the PCI config
> space of the vGPU device.
> 
> Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
> ---
>  MAINTAINERS                     |    7 +
>  drivers/hv/Kconfig              |    2 +
>  drivers/hv/Makefile             |    1 +
>  drivers/hv/dxgkrnl/Kconfig      |   26 +
>  drivers/hv/dxgkrnl/Makefile     |    5 +
>  drivers/hv/dxgkrnl/dxgadapter.c |  189 +++
>  drivers/hv/dxgkrnl/dxgkrnl.h    |  953 +++++++++++++++
>  drivers/hv/dxgkrnl/dxgmodule.c  |  882 ++++++++++++++
>  drivers/hv/dxgkrnl/dxgprocess.c |   37 +
>  drivers/hv/dxgkrnl/dxgvmbus.c   |  543 +++++++++
>  drivers/hv/dxgkrnl/dxgvmbus.h   |  901 ++++++++++++++
>  drivers/hv/dxgkrnl/hmgr.c       |   88 ++
>  drivers/hv/dxgkrnl/hmgr.h       |  112 ++
>  drivers/hv/dxgkrnl/ioctl.c      |   37 +
>  drivers/hv/dxgkrnl/misc.c       |   37 +
>  drivers/hv/dxgkrnl/misc.h       |   96 ++
>  include/linux/hyperv.h          |   16 +
>  include/uapi/misc/d3dkmthk.h    | 1954 +++++++++++++++++++++++++++++++

Why are you adding apis and structures that you are not actually using
in this commit?  Please only add the ones that you use, when you use
them.

This commit should be much smaller, and in more different parts.

thanks,

greg k-h
