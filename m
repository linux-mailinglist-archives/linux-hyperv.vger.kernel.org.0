Return-Path: <linux-hyperv+bounces-7261-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF500BEBE6C
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Oct 2025 00:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB8C1A6823A
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 22:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915BC2D4B61;
	Fri, 17 Oct 2025 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYmk3XE3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63054354AC3;
	Fri, 17 Oct 2025 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739437; cv=none; b=aj4BWwkuMBjKH0k++drNE8G3WKns47xYppMBeBwgFKRmWXRzdPR5wzcFYRvOJ7pc692wLlLNBp+wmHnfXRLNkZ5l22xtUQk8Kyn6BIBPvghkHpTUmZjqmRBGE1SJ9nuZrNM80YaCeO3XlzfFPeO8dGmTWzpUeJd0awSCbArETTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739437; c=relaxed/simple;
	bh=Ovl+JqvhHviVFFKauvKu4PvAiJaBPtSMmtveUxiHyjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIBPfQHwKcjUF9oO88ZBCvLQtgYqdiRhdYI46JyoNXi+o879eyKjH0jPEAIhHEtBqFandFWqjWhBotGCa7IGQcl1gaCHDzezyhHf/SthCYz6J+Hyfww+yi4Vp1jEw7mVDE/BH34I8UWvkjUdIlzeS+XXDUDGUisWyrrZmZlCjZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYmk3XE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2616C4CEE7;
	Fri, 17 Oct 2025 22:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760739436;
	bh=Ovl+JqvhHviVFFKauvKu4PvAiJaBPtSMmtveUxiHyjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYmk3XE3AWwq8x6KFRktFNPY7hNev1ei9PgW2ao7HjiVTeIu4P+9as6tB43eZ9nMp
	 gsAzBH437+mNS+GlRKh2xcFg7dcQjEH+jsjviq1Kccvx5zMcVOBjdROxm4/yQO6VcB
	 rZJzdSzSI1djXkFfzV01tHa8f+DiMa5hQoPUJYdJtl3U3syD5CBq/Z0Gr5SRYK5yrw
	 VaHeZd8+RnVzSV6CicHNoJSvcbewcMwhVAxecVFnbcX5yykh1sFejt91+DBDdSMFD/
	 uCUG3M40EzJAv2MZVVYeutTNknmLStm7aqHck5NcHYpZPBY6FavRCb3bKyJADr6bHd
	 j7RubOQOpt56A==
Date: Fri, 17 Oct 2025 22:17:15 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v6 04/10] x86/dt: Parse the Wakeup Mailbox for Intel
 processors
Message-ID: <20251017221715.GE614927@liuwe-devbox-debian-v2.local>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-4-40435fb9305e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-rneri-wakeup-mailbox-v6-4-40435fb9305e@linux.intel.com>

On Thu, Oct 16, 2025 at 07:57:26PM -0700, Ricardo Neri wrote:
> The Wakeup Mailbox is a mechanism to boot secondary CPUs on systems that do
> not want or cannot use the INIT + StartUp IPI messages.
> 
> The platform firmware is expected to implement the mailbox as described in
> the Multiprocessor Wakeup Structure of the ACPI specification. It is also
> expected to publish the mailbox to the operating system as described in the
> corresponding DeviceTree schema that accompanies the documentation of the
> Linux kernel.
> 
> Reuse the existing functionality to set the memory location of the mailbox
> and update the wakeup_secondary_cpu_64() APIC callback. Make this
> functionality available to DeviceTree-based systems by making CONFIG_X86_
> MAILBOX_WAKEUP depend on either CONFIG_OF or CONFIG_ACPI_MADT_WAKEUP.
> 
> do_boot_cpu() uses wakeup_secondary_cpu_64() when set. It will be set if a
> wakeup mailbox is enumerated via an ACPI table or a DeviceTree node. For
> cases in which this behavior is not desired, this APIC callback can be
> updated later during boot using platform-specific hooks.
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Can I get an ack from x86 maintainers?

Wei

