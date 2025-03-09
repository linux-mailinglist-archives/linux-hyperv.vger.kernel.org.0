Return-Path: <linux-hyperv+bounces-4320-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDEEA58963
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 00:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2483B3A8B7B
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 23:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410C72165F3;
	Sun,  9 Mar 2025 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYIouOAC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116F51CAA6C;
	Sun,  9 Mar 2025 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741564501; cv=none; b=trWoEWAoBk4FEGs2kmuUXHcr7A3Id+iVJIc7649IikKLPwPFqI2TOPPsmz7UZTuzchxsiQJtbdpaSeKOhHzrGIu9dT/WVOdm4AmUCvyW2aijEqfjCgDAbcLIt270KuBS52mptkCHMaXwMwektI7+xCvsx24oXN4MKgAgcje18rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741564501; c=relaxed/simple;
	bh=nsBH/xv/bf+vR33VyvDASVttWOn8x8HdXn/bnG5ryyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl0OXMbqBUXdzoPbjqlsqQ/NhekaB1xVTVSJPNaFWtpP8AED5h9EFgkdnyd1TMv6iMtzjo+ZX0NuLqZv+XGnEJDk9c/pHJ3TG0iz91QgTsuKCFL5I7N19wRs+owVAq39nDURt3ewmwu/XS8/9XcHJfuN0onkaqLNTJc2LxA/Njg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYIouOAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C090C4CEE3;
	Sun,  9 Mar 2025 23:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741564500;
	bh=nsBH/xv/bf+vR33VyvDASVttWOn8x8HdXn/bnG5ryyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYIouOAC9aIesShyEt3ia6/nz7UkK5mqzmMmxtLcmlcFmCbIGJrNP2tqsw649jH6l
	 +FGCI+hv9qIcON9meY9mouLgT+f5eyi4rq9460NznS1KL4VP8Ne4yIaAiY8QGa3Yp/
	 H9aa7yR673YQQmlgGelI0jb8twQTD6FOHF1dXV0bRhVlzAdf7M7tYqrLtDeVSifi8b
	 3zQ4GIStjUMQduu3R6xSjBxzlTk1x+BBoJrzi3B87FwGqeC7BnuasFGLdViU+GMs/n
	 nZ8ttkEjGeli5fCIlFUzRqU/Pd4F9aZYYK6tznoG7Asac3SUxw2EVDGDB4HRQzMljz
	 yWTaY/CX6dqKQ==
Date: Sun, 9 Mar 2025 23:54:59 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	deller@gmx.de, javierm@redhat.com, thomas.tai@oracle.com,
	tzimmermann@suse.de, kasong@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] fbdev: hyperv_fb: Fix hang in kdump kernel when on
 Hyper-V Gen 2 VMs
Message-ID: <Z84qU0vJYD72GxcP@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250218230130.3207-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218230130.3207-1-mhklinux@outlook.com>

On Tue, Feb 18, 2025 at 03:01:30PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Gen 2 Hyper-V VMs boot via EFI and have a standard EFI framebuffer
> device. When the kdump kernel runs in such a VM, loading the efifb
> driver may hang because of accessing the framebuffer at the wrong
> memory address.
> 
> The scenario occurs when the hyperv_fb driver in the original kernel
> moves the framebuffer to a different MMIO address because of conflicts
> with an already-running efifb or simplefb driver. The hyperv_fb driver
> then informs Hyper-V of the change, which is allowed by the Hyper-V FB
> VMBus device protocol. However, when the kexec command loads the kdump
> kernel into crash memory via the kexec_file_load() system call, the
> system call doesn't know the framebuffer has moved, and it sets up the
> kdump screen_info using the original framebuffer address. The transition
> to the kdump kernel does not go through the Hyper-V host, so Hyper-V
> does not reset the framebuffer address like it would do on a reboot.
> When efifb tries to run, it accesses a non-existent framebuffer
> address, which traps to the Hyper-V host. After many such accesses,
> the Hyper-V host thinks the guest is being malicious, and throttles
> the guest to the point that it runs very slowly or appears to have hung.
> 
> When the kdump kernel is loaded into crash memory via the kexec_load()
> system call, the problem does not occur. In this case, the kexec command
> builds the screen_info table itself in user space from data returned
> by the FBIOGET_FSCREENINFO ioctl against /dev/fb0, which gives it the
> new framebuffer location.
> 
> This problem was originally reported in 2020 [1], resulting in commit
> 3cb73bc3fa2a ("hyperv_fb: Update screen_info after removing old
> framebuffer"). This commit solved the problem by setting orig_video_isVGA
> to 0, so the kdump kernel was unaware of the EFI framebuffer. The efifb
> driver did not try to load, and no hang occurred. But in 2024, commit
> c25a19afb81c ("fbdev/hyperv_fb: Do not clear global screen_info")
> effectively reverted 3cb73bc3fa2a. Commit c25a19afb81c has no reference
> to 3cb73bc3fa2a, so perhaps it was done without knowing the implications
> that were reported with 3cb73bc3fa2a. In any case, as of commit
> c25a19afb81c, the original problem came back again.
> 
> Interestingly, the hyperv_drm driver does not have this problem because
> it never moves the framebuffer. The difference is that the hyperv_drm
> driver removes any conflicting framebuffers *before* allocating an MMIO
> address, while the hyperv_fb drivers removes conflicting framebuffers
> *after* allocating an MMIO address. With the "after" ordering, hyperv_fb
> may encounter a conflict and move the framebuffer to a different MMIO
> address. But the conflict is essentially bogus because it is removed
> a few lines of code later.
> 
> Rather than fix the problem with the approach from 2020 in commit
> 3cb73bc3fa2a, instead slightly reorder the steps in hyperv_fb so
> conflicting framebuffers are removed before allocating an MMIO address.
> Then the default framebuffer MMIO address should always be available, and
> there's never any confusion about which framebuffer address the kdump
> kernel should use -- it's always the original address provided by
> the Hyper-V host. This approach is already used by the hyperv_drm
> driver, and is consistent with the usage guidelines at the head of
> the module with the function aperture_remove_conflicting_devices().
> 
> This approach also solves a related minor problem when kexec_load()
> is used to load the kdump kernel. With current code, unbinding and
> rebinding the hyperv_fb driver could result in the framebuffer moving
> back to the default framebuffer address, because on the rebind there
> are no conflicts. If such a move is done after the kdump kernel is
> loaded with the new framebuffer address, at kdump time it could again
> have the wrong address.
> 
> This problem and fix are described in terms of the kdump kernel, but
> it can also occur with any kernel started via kexec.
> 
> See extensive discussion of the problem and solution at [2].
> 
> [1] https://lore.kernel.org/linux-hyperv/20201014092429.1415040-1-kasong@redhat.com/
> [2] https://lore.kernel.org/linux-hyperv/BLAPR10MB521793485093FDB448F7B2E5FDE92@BLAPR10MB5217.namprd10.prod.outlook.com/
> 
> Reported-by: Thomas Tai <thomas.tai@oracle.com>
> Fixes: c25a19afb81c ("fbdev/hyperv_fb: Do not clear global screen_info")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-fixes, thanks!

