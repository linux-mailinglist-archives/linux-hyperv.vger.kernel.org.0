Return-Path: <linux-hyperv+bounces-3417-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D4D9E7EC2
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 08:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8741886425
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 07:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62C577111;
	Sat,  7 Dec 2024 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7ZgI9Gx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91AE22C6E3;
	Sat,  7 Dec 2024 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733557644; cv=none; b=VS+1Y8bTqV37XOtj992IXVNt2EcFzHaFXbV8vb/zoSDkq32f3Pu5e/EN7L0NbzsEnhATD+CyvDYG17RvvfYwHUsH95J08AzDJSlTGuWrSYaSufVK8dWPxS+LNG4hnRuvOkdrh9UonwwPD24LVn/FhFX3tKTjqHAktQSs/rk1GO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733557644; c=relaxed/simple;
	bh=j1gSkhCovogep0/9Jq5s8i8/lrGWnRSes+LrOjKcg0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gABvefKPXORGZqquVaSxB/9yvUMq3Q+HTGT4S3aFdDMoZyLCGVSRh7QLwbbNgVl4Dk69xMH/kXeSUZh3mggIPmUnKHsF+tly/vZ135tgoXm3R87FS8r20J2MhYjSUBJyIz/+RGj0PQAui2+6zRqH0xf6cXgucBFV36aJdo5fvV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7ZgI9Gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9E1C4CECD;
	Sat,  7 Dec 2024 07:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733557644;
	bh=j1gSkhCovogep0/9Jq5s8i8/lrGWnRSes+LrOjKcg0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7ZgI9Gx1cc1spK+OWD+hFk3STA+xp7ZLaU5v/VnhNjNqJ/BXxuO6wUjp9C1kHrb/
	 Y1pLvkRpwdKPktXrgZNzl+/ncAjcGQqDqhGotoFKExpetbcjqVmLA8UCrp+9iJp9gP
	 9kMW8UdGaAZiSV4cLBFdcRxevVpCk868sPKGkgnVLZB/zUs/lZF+Wat6Yh5aQDR6w3
	 tVMUn5enGXB6RYMpqPBOOsXzD3LpM8jp3Ma5JEtbQXlaUbE7iCcgyTq9EGG0Ir8EL8
	 2g+VFznGy8hM7DkY/rb/gErKmA1Gn6auv3xWIEmkpWmcbshLC4C8VKsJZ22RQF+WZ1
	 X8+h1mULXQi6g==
Date: Sat, 7 Dec 2024 07:47:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] x86/hyper-v: Fix hv tsc page based sched_clock for
 hibernation
Message-ID: <Z1P9ipIZjI712RTf@liuwe-devbox-debian-v2>
References: <20240917053917.76787-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917053917.76787-1-namjain@linux.microsoft.com>

On Tue, Sep 17, 2024 at 11:09:17AM +0530, Naman Jain wrote:
> read_hv_sched_clock_tsc() assumes that the Hyper-V clock counter is
> bigger than the variable hv_sched_clock_offset, which is cached during
> early boot, but depending on the timing this assumption may be false
> when a hibernated VM starts again (the clock counter starts from 0
> again) and is resuming back (Note: hv_init_tsc_clocksource() is not
> called during hibernation/resume); consequently,
> read_hv_sched_clock_tsc() may return a negative integer (which is
> interpreted as a huge positive integer since the return type is u64)
> and new kernel messages are prefixed with huge timestamps before
> read_hv_sched_clock_tsc() grows big enough (which typically takes
> several seconds).
> 
> Fix the issue by saving the Hyper-V clock counter just before the
> suspend, and using it to correct the hv_sched_clock_offset in
> resume. This makes hv tsc page based sched_clock continuous and ensures
> that post resume, it starts from where it left off during suspend.
> Override x86_platform.save_sched_clock_state and
> x86_platform.restore_sched_clock_state routines to correct this as soon
> as possible.
> 
> Note: if Invariant TSC is available, the issue doesn't happen because
> 1) we don't register read_hv_sched_clock_tsc() for sched clock:
> See commit e5313f1c5404 ("clocksource/drivers/hyper-v: Rework
> clocksource and sched clock setup");
> 2) the common x86 code adjusts TSC similarly: see
> __restore_processor_state() ->  tsc_verify_tsc_adjust(true) and
> x86_platform.restore_sched_clock_state().
> 
> Cc: stable@vger.kernel.org
> Fixes: 1349401ff1aa ("clocksource/drivers/hyper-v: Suspend/resume Hyper-V clocksource for hibernation")
> Co-developed-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Applied to hyperv-fixes with the subject line fixed up. Thanks.

