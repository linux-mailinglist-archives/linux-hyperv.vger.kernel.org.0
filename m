Return-Path: <linux-hyperv+bounces-3921-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEF6A31C01
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 03:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1BF16121D
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 02:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9441DB551;
	Wed, 12 Feb 2025 02:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgN9z1y/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A11CBEAA;
	Wed, 12 Feb 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327250; cv=none; b=Do7h77DPlZnJ5SaYyykSZ94+WQccCz45T+SH9sL5vAozkcHm9n/lUgFsH+LuyjvK6XeimLfLHzZtEbphdDl3n09AirTeekdr//0EkPATV7Vd5Pg8jo/ypD/G42cRFCdHIzAH11zqdWmh3zdlqeBdr6Erb+VhEww3p46E2eQ1jao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327250; c=relaxed/simple;
	bh=ZYzY4+l+dFRYzltNbW6pH6aQvA9KFT1LHvoYLNAw0oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/SdkC3A6AFva20TmxcT5SPEAbPdKcTplfUN+BdICvvx9j67eSXhd8hy6LKlvNFpu89YZJnuUFWdpKi3RUAXC6sSEeB2u//bYeAPLxonvV8hIJiQgwYvJgwkFTNCbsfAIgio+iPd63xrCoW36WDbpyeq5K689me/zxAYQOS+XFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgN9z1y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335CBC4CEDD;
	Wed, 12 Feb 2025 02:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739327249;
	bh=ZYzY4+l+dFRYzltNbW6pH6aQvA9KFT1LHvoYLNAw0oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgN9z1y/SGiCZfh4jONXnZe7Z3FTeK+evpamez7ckDebJkMxbSk6RtQEAHifX7y+t
	 TYFG/MSCvMj9hM1QSBuMMcNivVAv2+SoNklsUbU7RnUjW/IKx8PcppLe+uq3OwIYQU
	 AaSbXGe6qdG4u5NkzU9iATBqIRGx0AWMSnY4QYCAFvgWdMQ+uOpXfxOOWq9Cn9Qx5l
	 58ZAdicfJ8mHP9XeQ7QTC0WhB7bheyIOoPYAJROSQQNGmqT6B99rM/phRsM943C3nk
	 BkPudRTFvQx3eLJHokmwbC8L5D5kvnaPy5VIDAtJd5OOAx1K8+tlSjIBh8uET4lIBl
	 hUvo3w0qKI4dg==
Date: Wed, 12 Feb 2025 02:27:27 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	deller@gmx.de, weh@microsoft.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] fbdev: hyperv_fb: iounmap() the correct memory when
 removing a device
Message-ID: <Z6wHDw8BssJyQHiM@liuwe-devbox-debian-v2>
References: <20250209235252.2987-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209235252.2987-1-mhklinux@outlook.com>

On Sun, Feb 09, 2025 at 03:52:52PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> When a Hyper-V framebuffer device is removed, or the driver is unbound
> from a device, any allocated and/or mapped memory must be released. In
> particular, MMIO address space that was mapped to the framebuffer must
> be unmapped. Current code unmaps the wrong address, resulting in an
> error like:
> 
> [ 4093.980597] iounmap: bad address 00000000c936c05c
> 
> followed by a stack dump.
> 
> Commit d21987d709e8 ("video: hyperv: hyperv_fb: Support deferred IO for
> Hyper-V frame buffer driver") changed the kind of address stored in
> info->screen_base, and the iounmap() call in hvfb_putmem() was not
> updated accordingly.
> 
> Fix this by updating hvfb_putmem() to unmap the correct address.
> 
> Fixes: d21987d709e8 ("video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-fixes. Thanks.

