Return-Path: <linux-hyperv+bounces-5372-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06733AABB6F
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 09:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 644417BCE21
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 07:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84812255E4C;
	Tue,  6 May 2025 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dlcr2WOo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D6725522B;
	Tue,  6 May 2025 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746512933; cv=none; b=RjnwTYlCexdQwMHMHb6Yqmt7ncjoZbRA15kVR+mktlYVwaBvY+5w1jzKUewFgQJGJ06FMF6nrkVWbBXBYWVu30jdtAB16OkvjgJzdEBQW1KhRRyyPYQ0Rh8XU3FpCrMdkAv4YzJxTVsG3RQrTNGoI3EdjSdtuaV1xgBIwB7NnOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746512933; c=relaxed/simple;
	bh=kH0zL3g/VPEJGNVmWs+mqPxhZROJtNBQ1N5HtAVARzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbBUiLQZq/hoXmRgY3jgnoffI5Q3iopORYClkVGjlkAEUsYfZ/pHx4tTSd5G6Z+H+9gmoizW2VKIAOWldtCq3ABBbRDPg62q9xrkppmTIaRVclQp3rpJCDNiGmLlKlHbqcvNLHti455xIa3Rh5a3onTmoGxNunCElAXphCLjc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dlcr2WOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967EDC4CEE4;
	Tue,  6 May 2025 06:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746512931;
	bh=kH0zL3g/VPEJGNVmWs+mqPxhZROJtNBQ1N5HtAVARzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dlcr2WOo/Vla7Fnf0kVzInx3A5hPgTFN6MwZLFUz01KB7j3YuRXnsxQ3r5wa8edSU
	 D43BC5BBndKo/etLoojTIeZvEFDec1f7BbNdO7V2dFpXVSMqGAkXH9kAC9fSzzfvcE
	 pu5PmKM6tA2i94mzhh9PEXJU9y9fcBGtutCB4o94TnzclrdVdYgpeuopSEGLhTbmtw
	 CBVT/NJ881oknD8CBbbqoZ190j0pucurhP+xx3WJxEerT1BYZGbQIDu/1uM6pIlCr/
	 3dp+o+I2vk/WHJ8XPWAJxZPUxSmA3nnagwOSd2bdfdW4YZ7K82Pne/TJ+4kWVADibV
	 DLdJCth7eAXzw==
Date: Tue, 6 May 2025 06:28:50 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mikelley@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
	tiala@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v3] x86/hyperv: Fix APIC ID and VP index
 confusion in hv_snp_boot_ap()
Message-ID: <aBmsIjIfgCv5G3Lj@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250428182705.132755-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428182705.132755-1-romank@linux.microsoft.com>

On Mon, Apr 28, 2025 at 11:27:05AM -0700, Roman Kisel wrote:
> To start an application processor in SNP-isolated guest, a hypercall
> is used that takes a virtual processor index. The hv_snp_boot_ap()
> function uses that START_VP hypercall but passes as VP index to it
> what it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.
> 
> As those two aren't generally interchangeable, that may lead to hung
> APs if the VP index and the APIC ID don't match up.
> 
> Update the parameter names to avoid confusion as to what the parameter
> is. Use the APIC ID to the VP index conversion to provide the correct
> input to the hypercall.
> 
> Cc: stable@vger.kernel.org
> Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Unfortunately this patch fails to apply. Please send a new version based
on the latest hyperv-next.

Thanks,
Wei.

