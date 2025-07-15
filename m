Return-Path: <linux-hyperv+bounces-6250-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBF5B051AC
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 08:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4361AA3906
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 06:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FE92D3A96;
	Tue, 15 Jul 2025 06:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdOWnfdE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DB42D3238;
	Tue, 15 Jul 2025 06:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752560700; cv=none; b=ppFc7yc0xZHqUzdtXzLWI6Fdk+EKITIGFYMC/uvKzE4AUIQ+cjvGx74bCv8rLexb1L71Nb7ASldojR8HxFMrtBhls7MeeQdJdtGc51RzFwodvNIbrxXENrnGXfhdL1yTR1Ajf63MJLhzY2XtqlF6T2/oggNCqp6YOtckts8ENug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752560700; c=relaxed/simple;
	bh=abspjSvivLNZ7JqRTXenpI1qgQVpPqZ6Q7QkayAhcco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgZyeCpZ1qHssbm16chK3JDYl1muwDtolCZqVR4Xz8W3l/i9ycF6o77WzEkCHM2eIxjfcOe/zijQ2x/p/zCJ/ygCxZXG4u+xVVEDYhsBVysQBjjiPM2SpraPtgtVveVTygOptaJbt7xtuHBUxMAZ/OIe/llyMaLxx8OlGodsQO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdOWnfdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1BEC4CEE3;
	Tue, 15 Jul 2025 06:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752560699;
	bh=abspjSvivLNZ7JqRTXenpI1qgQVpPqZ6Q7QkayAhcco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JdOWnfdEMSp1mulN712vPGlM+ixIAfeBjfH7nEE75tvzQLUd49ObJzA6li1btIGyB
	 xKwqrwjkZF6lez18opXcKp3anIO/r4cJXkEJMWwL81DWwmuPJM/uIfBStNk/jLYVIb
	 qNwtJPR8KpIX8kHMpJ1huWEmkhLR0YzCdkzojx+eXZ6zvfIfiAEmsWSMoWLP9M+Wn+
	 3QZAvmqSv6KAaA8wXcmyDp+ugaW4A1QxFg/9RoeSwR9jtRnrpBiGf32BtT8LuI2UBn
	 A+qnmzZj4/N2ueN0bpQbGafSON56WT0PvGZwY43/aDTzUxOn6hQal0az40GHJ1mWgQ
	 t5nZj132Rl6XQ==
Date: Tue, 15 Jul 2025 06:24:58 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, tglx@linutronix.de,
	bhelgaas@google.com, romank@linux.microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	jinankjain@linux.microsoft.com, skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com, x86@kernel.org
Subject: Re: [PATCH v3 0/3] Nested virtualization fixes for root partition
Message-ID: <aHX0OrqPItroxWaL@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <1752261532-7225-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752261532-7225-1-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Jul 11, 2025 at 12:18:49PM -0700, Nuno Das Neves wrote:
> Fixes for running as nested root partition on the Microsoft Hypervisor.
> 
> The first patch changes vmbus to make hypercalls to the L0 hypervisor
> instead of the L1. This is needed because L0 hypervisor, not the L1, is
> the one hosting the Windows root partition with the VMM that provides
> vmbus.
> 
> The 2nd and 3rd patches fix interrupt unmasking on nested. In this
> scenario, the L1 (nested) hypervisor does the interrupt mapping to root
> partition cores. The vectors just need to be mapped with
> MAP_DEVICE_INTERRUPT instead of affinitized with RETARGET_INTERRUPT.
> 
> Changes in v3:
> - Remove 3 patches (#1,#3,#4 from v2) which were merged already (Wei Liu)
> - Fix bug in #1 introduced in v2 (Michael Kelley)
> - Improve commit message in #2 (Michael Kelley)
> - Document return value of hv_map_msi_interrupt() in #2 (Michael Kelley)
> 
> Changes in v2:
> - Reword commit messages for clarity (Michael Kelley, Bjorn Helgaas)
> - Open-code nested hypercalls to reduce unnecessary code (Michael Kelley)
> - Add patch (#3) to fix cpu_online_mask issue (Thomas Gleixner)
> - Add patch (#4) to fix error return values (Michael Kelley)
> - Remove several redundant error messages and checks (Michael Kelley)
> 
> Nuno Das Neves (1):
>   Drivers: hv: Use nested hypercall for post message and signal event
> 
> Stanislav Kinsburskii (2):
>   x86/hyperv: Expose hv_map_msi_interrupt()
>   PCI: hv: Use the correct hypercall for unmasking interrupts on nested
> 

Applied. Thanks.

