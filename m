Return-Path: <linux-hyperv+bounces-6172-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAA3AFF581
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 01:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79DA1BC6E67
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 23:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDFB22837F;
	Wed,  9 Jul 2025 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWacwsk2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E879DA;
	Wed,  9 Jul 2025 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752105081; cv=none; b=TJgHcROwku/J9FWnlPjW3ULVT+ZK7D+UotwPziwyoh9uCFKHvA//5CRl+YzmodiKRH9iOEYW/J+YsjFLKIIUMsS/xg5bSmGfrPJFr1q0GmGqNc9Y3buz6m5+AbVnPhV8XTHe5oAzlhZ52i3qPT4Hg0urzBBVJmCMirfgNuQ0K2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752105081; c=relaxed/simple;
	bh=iHHDdi61luMjOOB6cLZIe2NqS6hgH4l1r7NpDne4SJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAMT4CJ1YXaGHCCT9+eB1ubHAfX9k1n0zgl4hzhiy9jiMG/waO2ABhyO512mln6wBJYPPPHOcWVKtyDBWgQpTfuYYQ0UrMviZyAMKVjoHSH5M75D6c6aw48v8WjBkq2kK5IHLYWEEEFJWwUt9KdpYg/dV9QoHEyzGi6ISagXIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWacwsk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4F3C4CEEF;
	Wed,  9 Jul 2025 23:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752105081;
	bh=iHHDdi61luMjOOB6cLZIe2NqS6hgH4l1r7NpDne4SJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eWacwsk2dDys5dUjq5eKhC6vFLRjjzMaKYIRbg9sezsrHgTqzkp9ItcMIJU5H+EN4
	 EBeK0oVZGFl3JjKF4ktrsP5OVQz5KZjXDdlw1a1i7wFakVLu9cchydNeEV10/BVzdh
	 8LnGZMottz+MOntboVjxv2QH5IzEPZK7MRuBNizGuG/xj/PIGObD/HMoxFqmZLoeqi
	 TfFIksllkSLTBdPW1Oq4gX2V+lJ23Rg4EutgHkTwNIPEWiTG0SwMWzVjge5LEBJ9vH
	 0tTj0c/oegwXKGz2Fk2B73+CZtCxWekDDlNCYYcnZpOhGC+QSQrniTMN2cmsDGl18d
	 IruP939/zBCww==
Date: Wed, 9 Jul 2025 23:51:19 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	mhklinux@outlook.com, tglx@linutronix.de, bhelgaas@google.com,
	romank@linux.microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	jinankjain@linux.microsoft.com, skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com, x86@kernel.org
Subject: Re: [PATCH v2 0/6] Nested virtualization fixes for root partition
Message-ID: <aG8Ad0yeifapux5D@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>

On Thu, Jul 03, 2025 at 03:44:31PM -0700, Nuno Das Neves wrote:
[...]
>   PCI: hv: Don't load the driver for baremetal root partition
>   x86/hyperv: Fix usage of cpu_online_mask to get valid cpu
>   x86/hyperv: Clean up hv_map/unmap_interrupt() return values
>   PCI: hv: Use the correct hypercall for unmasking interrupts on nested
> 

These are applied to hyperv-fixes.

>   Drivers: hv: Use nested hypercall for post message and signal event
>   x86: hyperv: Expose hv_map_msi_interrupt function

These have pending comments so they are not yet applied.

Wei

