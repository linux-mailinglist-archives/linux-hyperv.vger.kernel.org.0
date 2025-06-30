Return-Path: <linux-hyperv+bounces-6049-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE7BAEDA6D
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 13:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557293AC278
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 11:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C91A259C83;
	Mon, 30 Jun 2025 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hg+vdUNO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69323D2B2;
	Mon, 30 Jun 2025 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751281413; cv=none; b=kPqwDvIg+Q9FBuW9Kyr7iAMkpAQyn4TvJNek1Rtjr5EFi8Yz1gnaZq+p7pnTySF4FdJSyeGs1mxNXVhdodxySeuZTknoLUFevQqtsgn6UEHIn4wxG7TkTdc3TsXZN54hTu/wyxJ8/TcA4LZWofTMwJQ7y8JKb9m2SFqZSM6OxPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751281413; c=relaxed/simple;
	bh=S/kgr45aGQe7p4sUYNlgyDg5B/Jj4yai+eKw+uTD4Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5PKtWy/rYPYYaTrSwzwH+MuZWxvp04RpeZYvF2Ykha21nNp8Wb3FYJhRY814M9jD99JFk53TEp3CrCIXWPFvrLb83A4NMdoVEKNG2dYnn9T6Sa2+jk9q8hjbq4w/YMJ8ufg6SvMmxFD0xg07clj+nOoiwAbtNFKJi4+12pzog8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hg+vdUNO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xhkuJDoMgg4Z0i9VP/q8C7p19DtU+zyREc5m/VGNSZc=; b=hg+vdUNOrP+EUg2yPqPN7LoSz5
	Oij6dkdPF9R/8DltEAXrn03hw/0SLf+dUn9BP8i5amOnXyEcVonXTj5bQkuQG+JbzntfrJ6zuE0oT
	4U/ChpKiGn8/amLZ+B+OkXT0H6+S0ZwzRmULf0K/vhIQNPCE//9Vz0kGhEraN68MGoeZWLlK7+iGA
	lDCyxgvlq0VFz79CqvdNvB3CkH6Pn3WKfhXFrrMdETPZl8Y4kFFbcbCBSpMGYmO691tMlCfD1h9AT
	C4HW3/rNyJfuc/ORcM0TiZNHWQ4Do6wslAUVm5QvmQBZwETzHVPyoLSSWFBdta9fVOLYS58AjEA2d
	t6RDH8Tg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWCI9-00000006lR2-10Dk;
	Mon, 30 Jun 2025 11:03:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0B34B300125; Mon, 30 Jun 2025 13:03:16 +0200 (CEST)
Date: Mon, 30 Jun 2025 13:03:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v5 02/10] x86/acpi: Move acpi_wakeup_cpu() and helpers to
 smpwakeup.c
Message-ID: <20250630110316.GJ1613376@noisy.programming.kicks-ass.net>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-2-df547b1d196e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-2-df547b1d196e@linux.intel.com>

On Fri, Jun 27, 2025 at 08:35:08PM -0700, Ricardo Neri wrote:

> -	/*
> -	 * Wait for the CPU to wake up.
> -	 *
> -	 * The CPU being woken up is essentially in a spin loop waiting to be
> -	 * woken up. It should not take long for it wake up and acknowledge by
> -	 * zeroing out ->command.
> -	 *
> -	 * ACPI specification doesn't provide any guidance on how long kernel
> -	 * has to wait for a wake up acknowledgment. It also doesn't provide
> -	 * a way to cancel a wake up request if it takes too long.
> -	 *
> -	 * In TDX environment, the VMM has control over how long it takes to
> -	 * wake up secondary. It can postpone scheduling secondary vCPU
> -	 * indefinitely. Giving up on wake up request and reporting error opens
> -	 * possible attack vector for VMM: it can wake up a secondary CPU when
> -	 * kernel doesn't expect it. Wait until positive result of the wake up
> -	 * request.
> -	 */
> -	while (READ_ONCE(acpi_mp_wake_mailbox->command))
> -		cpu_relax();
> -
> -	return 0;
> -}

> +	while (READ_ONCE(acpi_mp_wake_mailbox->command))
> +		cpu_relax();
> +
> +	return 0;
> +}

So I realize this is just code movement at this point, but this will
hard lockup the machine if the AP doesn't come up, right?

IIRC we have some timeout in the regular SIPI bringup if the AP doesn't
respond.

