Return-Path: <linux-hyperv+bounces-6051-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB7EAEDEF9
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 15:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41D716A3C3
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 13:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F61B286D61;
	Mon, 30 Jun 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fylkOZ5k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07C1DFCB;
	Mon, 30 Jun 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290025; cv=none; b=FejkROEYGwUYFTMcJdEk9xv8++39w+AdZB0kQ2u4ktXxZeUqz/Kmm1FgXstdoj4PweOO980GWglpcoySePLKJBPENZHDHmNO37I4DQnGtvieSx56gCjmM6PKOTm/U2GYuaO+kIK8k0rPRGswtBJLMtltWpNPsEgi315715aMBrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290025; c=relaxed/simple;
	bh=WB0nc/JVBgjX+0w5qWA+TY03gWgQdNO+7U5DPyzBrc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvjKn5ba3ktf6dfJ6g95TfJiki5HphJtp/nXQ+CXCff4aFwaPNk9DAvOx3cN8jHI7cQ3WvjIo0FaKpnN2+nta8fcasVv1jlwF+Yp3acMwoA/qb5s4Kh0azY570fyJE0NyY/z1K+pY4Cod+OKQ8LOhANJ0l0HMNWkJcNpGWDBVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fylkOZ5k; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YYG13o2W8Ak2/TreizFs+5Zc+1d5uQAAtxrsG6NxhF8=; b=fylkOZ5k7E1+e+XbEZHOeRgIUT
	eBG2zbCQb23kdh8/0XTcUnWMcpr52XqGYKK4TqDZRjI2dhPGgOzHJHvP0t4W4FZ8bXdtbATp0lNsl
	2JM/6omQYE1nyAde5P61f560L4PKXNef0rwzKiRJup8jUjme4AwOHiTk8TEO32VKKMpJcCYq4EWUT
	hCieesBkq3ZN35mTtq1cnxACfvLKXXMJ9uhKPhNdm9AQjFpjZyW0YI8Gtn4Hb0UVW4e4RARkiIJmA
	OuctUxOFamGi0JSTIU+IUrjz1k1wR8grATon+2IvlzadZijCahOLRE9kk+lVHVruNqjq7Szd0VJU7
	hUblIiCQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWEX9-00000003tYR-2Sg3;
	Mon, 30 Jun 2025 13:26:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ACDC0300158; Mon, 30 Jun 2025 15:26:54 +0200 (CEST)
Date: Mon, 30 Jun 2025 15:26:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, linux-hyperv@vger.kernel.org,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v5 02/10] x86/acpi: Move acpi_wakeup_cpu() and helpers to
 smpwakeup.c
Message-ID: <20250630132654.GN1613376@noisy.programming.kicks-ass.net>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-2-df547b1d196e@linux.intel.com>
 <20250630110316.GJ1613376@noisy.programming.kicks-ass.net>
 <sh3fz5qlmy2smu74ezibbptxgmlpedzui3c4q6x22jc5w5ik4q@qms3osoxh74t>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sh3fz5qlmy2smu74ezibbptxgmlpedzui3c4q6x22jc5w5ik4q@qms3osoxh74t>

On Mon, Jun 30, 2025 at 03:07:08PM +0300, Kirill A. Shutemov wrote:
> On Mon, Jun 30, 2025 at 01:03:16PM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 27, 2025 at 08:35:08PM -0700, Ricardo Neri wrote:
> > 
> > > -	/*
> > > -	 * Wait for the CPU to wake up.
> > > -	 *
> > > -	 * The CPU being woken up is essentially in a spin loop waiting to be
> > > -	 * woken up. It should not take long for it wake up and acknowledge by
> > > -	 * zeroing out ->command.
> > > -	 *
> > > -	 * ACPI specification doesn't provide any guidance on how long kernel
> > > -	 * has to wait for a wake up acknowledgment. It also doesn't provide
> > > -	 * a way to cancel a wake up request if it takes too long.
> > > -	 *
> > > -	 * In TDX environment, the VMM has control over how long it takes to
> > > -	 * wake up secondary. It can postpone scheduling secondary vCPU
> > > -	 * indefinitely. Giving up on wake up request and reporting error opens
> > > -	 * possible attack vector for VMM: it can wake up a secondary CPU when
> > > -	 * kernel doesn't expect it. Wait until positive result of the wake up
> > > -	 * request.
> > > -	 */
> > > -	while (READ_ONCE(acpi_mp_wake_mailbox->command))
> > > -		cpu_relax();
> > > -
> > > -	return 0;
> > > -}
> > 
> > > +	while (READ_ONCE(acpi_mp_wake_mailbox->command))
> > > +		cpu_relax();
> > > +
> > > +	return 0;
> > > +}
> > 
> > So I realize this is just code movement at this point, but this will
> > hard lockup the machine if the AP doesn't come up, right?
> 
> Correct.
> 
> > IIRC we have some timeout in the regular SIPI bringup if the AP doesn't
> > respond.
> 
> See the comment.

Doh, reading hard ;-) Thanks!

