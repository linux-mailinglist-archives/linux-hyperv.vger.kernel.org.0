Return-Path: <linux-hyperv+bounces-3608-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD7FA0549C
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 08:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD9D3A6125
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 07:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72D1A0BFA;
	Wed,  8 Jan 2025 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SewjkS54"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F2015B984;
	Wed,  8 Jan 2025 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321655; cv=none; b=pCSGLmlXUCRscWAcWUzy6kak8udyNEH+O8A+L/umqezc8eMHNmWMWfYUpnzNje4Xcun/zEHCmT7bteuCZTVHWpTxBWqfikugVJ1fRF8mVLLeLGJZB8I0rkxqGXoO0fu+0bMDNzIfaXqozHJSRj24cU/heJTEWIPRwuI8/at1+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321655; c=relaxed/simple;
	bh=dCAbm9m4vx4P/f65Z/UDdifXA/98PJTc1g1kKEInPAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7oPBT2LQXuLxan+d+WELLrkeyJeSQ3LM3B/cVZ8fjfeJ6xVasmOVmLUbrV4aB0gxhMgyhgUbMpBorYr+RY/U3Al+anBrEi66Gw0pn6WclWPFW58YaeziWleWe7s0BFXBHQMncr0a8zPGY9pAz+80PBHQ9e+SnPXUtlWkAIyIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SewjkS54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BB2C4CEE0;
	Wed,  8 Jan 2025 07:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736321654;
	bh=dCAbm9m4vx4P/f65Z/UDdifXA/98PJTc1g1kKEInPAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SewjkS54yYsO5O14a13QYrqGbPYrdFT1Q2x0WWKdQXGDjW7pjC9FdrCu8JrumBzEb
	 ydgDU1DY9N9+sjQ8Z8pGFjLkbrc2aXtpTRs0PpJsOAkmAMdBm7xPYBa9/YCkblU7VH
	 yBVLnZ2pgqEd8sLLsDop3XkhMqD2rMOlDuTqlftEMrkiSXeaZop4biUE1VM9gmDcTr
	 IoBxt8PA6IL8Y6uxFAKEc1zGp4GJ6tGV1hHLfYSb8CxgEEvdKjAQlPtQANiLfW5eTE
	 +1IS/coovOFHe0e2JwCzNtfUVJ1PxJbApWju/FHViiiaVe4FyR3SwN2n4XSLYRw22k
	 +MdYeVG5UaXLg==
Date: Wed, 8 Jan 2025 07:34:12 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"tiala@microsoft.com" <tiala@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"apais@microsoft.com" <apais@microsoft.com>,
	"benhill@microsoft.com" <benhill@microsoft.com>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>,
	"vdso@hexbites.dev" <vdso@hexbites.dev>
Subject: Re: [PATCH v5 1/5] hyperv: Define struct hv_output_get_vp_registers
Message-ID: <Z34qdI3puoSe9PiR@liuwe-devbox-debian-v2>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-2-romank@linux.microsoft.com>
 <SN6PR02MB4157F8C28BD92F36B27C9032D4102@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e43633f6-c303-439d-8dbe-730a5762753c@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e43633f6-c303-439d-8dbe-730a5762753c@linux.microsoft.com>

On Mon, Jan 06, 2025 at 12:24:32PM -0800, Roman Kisel wrote:
> 
> 
> On 1/6/2025 9:37 AM, Michael Kelley wrote:
> > From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, December 30, 2024 10:10 AM
> [...]
> > 
> > These bit field definitions don't look right. We want to "fill up"
> > the field size, so that we're explicit about each bit, and not leave
> > it to the compiler to add padding (which __packed tells the
> > compiler not to do). So in aggregate, the "u64" bit fields should
> > account for all 64 bits, but here you account for only 32 bits.
> > There are two ways to fix this:
> > 
> > 		u32 interruption_pending : 1;
> > 		u32 interruption_type: 1;
> > 		u32 reserved : 30;
> > 		u32 error_code;
> > Or
> > 		u64 interruption_pending : 1;
> > 		u64 interruption_type: 1;
> > 		u64 reserved : 30;
> > 		u64 error_code : 32;
> > 
> > 
> > Nuno -- your thoughts?
> 
> Quite a blunder on my side! Thank you very much for your help :)
> GDB is my witness:
> 
> (gdb) ptype /o union hv_arm64_pending_synthetic_exception_event
> /* offset      |    size */  type = union
> hv_arm64_pending_synthetic_exception_event {
> /*                    16 */    u64 as_uint64[2];
> /*                    13 */    struct {
> /*      0: 0   |       4 */        u32 event_pending : 1;
> /*      0: 1   |       4 */        u32 event_type : 3;
> /*      0: 4   |       4 */        u32 reserved : 4;
> /*      1      |       4 */        u32 exception_type;
> /*      5      |       8 */        u64 context;
> 
>                                    /* total size (bytes):   13 */
>                                };
> 
>                                /* total size (bytes):   16 */
>                              }
> 
> which looks messed up to me to put it mildly. Will fix next time.

We are pretty close to the next merge window (~2 weeks). Can you please
resend a version this week or early next week?

Nuno, if you have any comments on this series, now it is the time to
share them.

Thanks,
Wei.

