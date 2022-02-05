Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481304AA7A7
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 09:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242364AbiBEIZp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Feb 2022 03:25:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48636 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238695AbiBEIZo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Feb 2022 03:25:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABC1E61617;
        Sat,  5 Feb 2022 08:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13E6C340E8;
        Sat,  5 Feb 2022 08:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644049544;
        bh=cHRofIRbkCZFNO7G6xt7MUkOdA/E+NK0r5aCmAXSzz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mKpxsjSpvcXr6Y35B/y3bz1HV2R2tDQ++z1u73YykV6cr3wAMGK5ghG0MXG+5JX2c
         tzVXK+LSW+20Dla0fFzc0pXpzKZZTyYXsO9Ezq8BtYLTAQS30bHgBDDgIRxsVlDtBA
         LCWVZ0w/dyYGT8P6fJ1G0rzq136xXLxE1aGWrL30=
Date:   Sat, 5 Feb 2022 09:25:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH v2 01/24] drivers: hv: dxgkrnl: Driver initialization and
 creation of dxgadapter
Message-ID: <Yf40f9MBfPPfyNuS@kroah.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
 <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 04, 2022 at 06:33:59PM -0800, Iouri Tarassov wrote:
> This is the first commit for adding support for a Hyper-V based
> vGPU implementation that exposes the DirectX API to Linux userspace.
> 
> - Handle driver loading, registration for the PCI and VM bus device
>   notifications
> - Add headers for user mode interfaces, internal driver objects and VM bus
>   communication interface

Only add the interfaces for the changes that you need in this commit.
Do not add them all and then use them later, that makes it impossible to
review.

> - Handle initialization of VM bus channels and creation of the dxgadapter
>   object
> - Connect the dxgkrnl module to the drivers/hv/ makefile and Kconfig.
> - Create a MAINTAINERS entry
> 
> A PCI device is created for each virtual GPU (vGPU) device, projected by
> the host. The device vendor is PCI_VENDOR_ID_MICROSOFT and device id is
> PCI_DEVICE_ID_VIRTUAL_RENDER. dxg_pci_probe_device handles arrival of such
> devices and it creates dxgadapter objects. The PCI config space of the
> vGPU device has luid of the corresponding per GPU VM bus channel. This is
> how the adapters are linked to VM bus channels.
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
>  drivers/hv/dxgkrnl/dxgadapter.c |  172 +++
>  drivers/hv/dxgkrnl/dxgkrnl.h    |  223 ++++
>  drivers/hv/dxgkrnl/dxgmodule.c  |  736 ++++++++++++
>  drivers/hv/dxgkrnl/dxgprocess.c |   17 +
>  drivers/hv/dxgkrnl/dxgvmbus.c   |  578 +++++++++
>  drivers/hv/dxgkrnl/dxgvmbus.h   |  855 ++++++++++++++
>  drivers/hv/dxgkrnl/hmgr.c       |   23 +
>  drivers/hv/dxgkrnl/hmgr.h       |   75 ++
>  drivers/hv/dxgkrnl/ioctl.c      |   24 +
>  drivers/hv/dxgkrnl/misc.c       |   37 +
>  drivers/hv/dxgkrnl/misc.h       |   89 ++
>  include/linux/hyperv.h          |   16 +
>  include/uapi/misc/d3dkmthk.h    | 1945 +++++++++++++++++++++++++++++++
>  18 files changed, 4831 insertions(+)

Would you want to review a 4800 line patch all at once?

Please take some time and review other commits on the mailing list and
offer up your comments to them.  That will help you understand how to
create your own changes better.

thanks,

greg k-h
