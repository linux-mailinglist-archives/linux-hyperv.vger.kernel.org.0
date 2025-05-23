Return-Path: <linux-hyperv+bounces-5652-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6820AC27C2
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 18:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1B4174C37
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1099829615A;
	Fri, 23 May 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFReMnH7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80CA4120B;
	Fri, 23 May 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748018412; cv=none; b=LlQPnH6CXt+sz7NYPjoaCUubZLyzPOHn92UesrNUxe4HhiO8w8lpE3G3EbUgyMylZT74L/6ukHh65o4wMixOdZ9FoBHT9g2GH1BtRYRmE7d4pofrsaUMO6lgOFd6wJc2oWP3R4sgLrEw+hIEqxnMrYSxhMQz/A0IHAnZwfyIdnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748018412; c=relaxed/simple;
	bh=UyjBgLtWr0fpH7g7Zr6wHBl8CiqKBfacyA4jE6n0eeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJeDQeCac5j+foyVZg/mBRf+FUz4RGaTyXJxpgn+T1qmhHUf9sX2FZQw9CIny5l1UN3Wx27sij8mA+EzEOJcPbYlccSJrVDCGyhXaEOE/RE+aJVfv4PCSAhi5wTawwZAwCDIoWniDTvQ8AzyXjAUqGouCt4y+t3GjzQ5j8T6EbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFReMnH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1D9C4CEE9;
	Fri, 23 May 2025 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748018411;
	bh=UyjBgLtWr0fpH7g7Zr6wHBl8CiqKBfacyA4jE6n0eeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFReMnH7Q5k8LTkjFz1GAsaPX728ggISMg0J5V4sL5Op2cCdV+eEKYqOButPOLX7+
	 9Nvd4dRpb3PuNFb8Vo2CFybeemqE1e5g8Bk4eyxtXzLGiPK3pFG1q+TXTKdczn751F
	 3WwkzYhSydqWogDUiz3rMm7gbbohY4a2OuH5EcaS+LZe7xmREnI4iq2rUMXKa+DeQB
	 ELrifydnLe2s3QZ+/1aSAsAwR6VEaWsrMHmlYWUgqj4FtAdkDRCH3ZDKKKrVNESccg
	 UWSgnSx/dCdWg9rcYyy5KjR8TzaMo4n7oEWU8r4TOXoONPyUDKPJyTWxm4vKw4duSW
	 Re0xjsydG7H4A==
Date: Fri, 23 May 2025 16:40:10 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, deller@gmx.de, javierm@redhat.com,
	arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Drivers: hv: Always select CONFIG_SYSFB for
 Hyper-V guests
Message-ID: <aDCk6haZF4fjRHf4@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520040143.6964-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520040143.6964-1-mhklinux@outlook.com>

On Mon, May 19, 2025 at 09:01:43PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> The Hyper-V host provides guest VMs with a range of MMIO addresses
> that guest VMBus drivers can use. The VMBus driver in Linux manages
> that MMIO space, and allocates portions to drivers upon request. As
> part of managing that MMIO space in a Generation 2 VM, the VMBus
> driver must reserve the portion of the MMIO space that Hyper-V has
> designated for the synthetic frame buffer, and not allocate this
> space to VMBus drivers other than graphics framebuffer drivers. The
> synthetic frame buffer MMIO area is described by the screen_info data
> structure that is passed to the Linux kernel at boot time, so the
> VMBus driver must access screen_info for Generation 2 VMs. (In
> Generation 1 VMs, the framebuffer MMIO space is communicated to
> the guest via a PCI pseudo-device, and access to screen_info is
> not needed.)
> 
> In commit a07b50d80ab6 ("hyperv: avoid dependency on screen_info")
> the VMBus driver's access to screen_info is restricted to when
> CONFIG_SYSFB is enabled. CONFIG_SYSFB is typically enabled in kernels
> built for Hyper-V by virtue of having at least one of CONFIG_FB_EFI,
> CONFIG_FB_VESA, or CONFIG_SYSFB_SIMPLEFB enabled, so the restriction
> doesn't usually affect anything. But it's valid to have none of these
> enabled, in which case CONFIG_SYSFB is not enabled, and the VMBus driver
> is unable to properly reserve the framebuffer MMIO space for graphics
> framebuffer drivers. The framebuffer MMIO space may be assigned to
> some other VMBus driver, with undefined results. As an example, if
> a VM is using a PCI pass-thru NVMe controller to host the OS disk,
> the PCI NVMe controller is probed before any graphics devices, and the
> NVMe controller is assigned a portion of the framebuffer MMIO space.
> Hyper-V reports an error to Linux during the probe, and the OS disk
> fails to get setup. Then Linux fails to boot in the VM.
> 
> Fix this by having CONFIG_HYPERV always select SYSFB. Then the
> VMBus driver in a Gen 2 VM can always reserve the MMIO space for the
> graphics framebuffer driver, and prevent the undefined behavior. But
> don't select SYSFB when building for HYPERV_VTL_MODE as VTLs other
> than VTL 0 don't have a framebuffer and aren't subject to the issue.
> Adding SYSFB in such cases is harmless, but would increase the image
> size for no purpose.
> 
> Fixes: a07b50d80ab6 ("hyperv: avoid dependency on screen_info")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Applied.

