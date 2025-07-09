Return-Path: <linux-hyperv+bounces-6164-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77106AFF4E0
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 00:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A227A6F1A
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A1723D28E;
	Wed,  9 Jul 2025 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9zZ7/yD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B18801;
	Wed,  9 Jul 2025 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100813; cv=none; b=Oi/rG1P6bT1C8pXTViKWOi1lV9VVZ+yi+t4YNMtxsV3FScW6nuN5EAijGS4YssZgawhNUYzT5BZxvyRlw3sIPdePjMVZNdS7oeAX/MP625B03T4FhjHZI92KiBm/een+PFeHO+oiTXs/VUmJRcy8yIHky7ncA164XZfRHKHqoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100813; c=relaxed/simple;
	bh=zZUqL8U8mMT5zEZPoWWHhrKYAz8QUabcClak4IR9naM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/8EHpVEmiL9PWyHYcFKFgBzj7JWv5/3tvGIAzEjT4OZIGbO2n8AjiIjZeraZxjaYXp0ABJigVtYLCFvIfusZstJ3goarXEDptjoJhqUqKEOIFHsXKy09Vzkg48Cm7CFWXeFEJF/5oTYkvE82bJdd/ZPVkmY6yHtxThxbtovG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9zZ7/yD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0559C4CEEF;
	Wed,  9 Jul 2025 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752100812;
	bh=zZUqL8U8mMT5zEZPoWWHhrKYAz8QUabcClak4IR9naM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I9zZ7/yDoFLqyk0NNXDTCeLHPqSVseJk01YszbAwU5OuMg0HxthTX5qFtPPHiQCRh
	 hKMdHZF4CpaL7onCJPMILrRAYxTsAvI3EFHfnysF/ypTf2ZgLzLERvha2CUTGOYcXU
	 kgmG16ekFBvZe1n28rpADzPnh6cdeHoMzgnao5XAIi6hHa2uylh/3L9AuCH9kuBnQs
	 /PEAGMvyTakk3SWGFs4feTp6Vv74YhD3B2ouT8OPzK0CWNrwsUoS+Yfc0P5XISFjU4
	 5J97di5ltID1BxDdYEG0ynnJDrQ+BiJzPT2RENTDrRU5uu3CcHqpyACyWfgFpyq7xB
	 a+4wFa+KAGcTQ==
Date: Wed, 9 Jul 2025 22:40:11 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, deller@gmx.de, javierm@redhat.com,
	arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: Select CONFIG_SYSFB only if EFI is
 enabled
Message-ID: <aG7vy8qECWqIz-7T@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250613230059.380483-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613230059.380483-1-mhklinux@outlook.com>

On Fri, Jun 13, 2025 at 04:00:59PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Commit 96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB
> for Hyper-V guests") selects CONFIG_SYSFB for Hyper-V guests
> so that screen_info is available to the VMBus driver to get
> the location of the framebuffer in Generation 2 VMs. However,
> if CONFIG_HYPERV is enabled but CONFIG_EFI is not, a kernel
> link error results in ARM64 builds because screen_info is
> provided by the EFI firmware interface. While configuring
> an ARM64 Hyper-V guest without EFI isn't useful since EFI is
> required to boot, the configuration is still possible and
> the link error should be prevented.
> 
> Fix this by making the selection of CONFIG_SYSFB conditional
> on CONFIG_EFI being defined. For Generation 1 VMs on x86/x64,
> which don't use EFI, the additional condition is OK because
> such VMs get the framebuffer information via a mechanism
> that doesn't use screen_info.
> 
> Fixes: 96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/linux-hyperv/20250610091810.2638058-1-arnd@kernel.org/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506080820.1wmkQufc-lkp@intel.com/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-fixes. Thanks!


