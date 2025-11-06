Return-Path: <linux-hyperv+bounces-7440-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B25C3CAD9
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 18:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386DA1895518
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1234834D4DE;
	Thu,  6 Nov 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qHjz6s/Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED233A01E;
	Thu,  6 Nov 2025 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448533; cv=none; b=hjLZ9GjfRaIxM2UM49XMou85oa2SZu9hds4Y4agXPCJzcummF1uW5W0B7LUM8qhNJIiTMMsN+tKorZi2oHWjSLmky4U9wfM8Mhl60m/hTl7Of4xQ7zF0IMWx3bBhnOoN0WLqu5sMb9WAt0liNdRP2E4IQGjvwY4cvxWu6YT84O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448533; c=relaxed/simple;
	bh=ClCUY1zHLN/rkfUXBxvfF4LGsF2prN2TTiQWPM1E4ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQ6oxoYm3SOOCh9kloO1O7cR2tdC+HgtFIvq28FD7spw+EGbfQzbVwycIUdsjtGtjFZGgRTvQAt5shz04l5flLOyHrPvtYjYGeZdRkumKtweIFZkG/61YihhqHbu22+vQNMPZHACwCaukC7kZNV49UC8wwL51kNCVHWrZ2kDoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qHjz6s/Z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.225.81] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 35393201CEE7;
	Thu,  6 Nov 2025 09:02:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35393201CEE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762448530;
	bh=8y664bY37IGz1dufpO7hBbK9UBL89+/dpzNT8ViQ6vw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qHjz6s/ZSQzKFpmU03giqT9ROcWKGY1u0v/KZoPV5hOM7WKies05xNDwsTbB93ctD
	 uDbvBWle4oX3wlHo+OXuJFzAu7NLcwAC1f4CqcRMD/Y1Lu3oCcgWJljAVNiwMXeujj
	 Cog5kPnBDOTPzQWPEJHUIsSSeSBVG5aYWWN73iLE=
Message-ID: <9603998c-1987-4bd2-9804-eea57207ec02@linux.microsoft.com>
Date: Thu, 6 Nov 2025 22:32:00 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/2] Drivers: hv: Export some symbols for mshv_vtl
To: Peter Zijlstra <peterz@infradead.org>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Kelley <mhklinux@outlook.com>,
 Mukesh Rathor <mrathor@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Christoph Hellwig <hch@infradead.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>
References: <20251029050139.46545-1-namjain@linux.microsoft.com>
 <20251029050139.46545-2-namjain@linux.microsoft.com>
 <20251106144919.GT3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20251106144919.GT3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/2025 8:19 PM, Peter Zijlstra wrote:
> On Wed, Oct 29, 2025 at 05:01:38AM +0000, Naman Jain wrote:
>> MSHV_VTL driver is going to be introduced, which is supposed to
>> provide interface for Virtual Machine Monitors (VMMs) to control
>> Virtual Trust Level (VTL). Export the symbols needed
>> to make it work (vmbus_isr, hv_context and hv_post_message).
> 
> Please consider using EXPORT_SYMBOL_FOR_MODULES()
> 
>> +EXPORT_SYMBOL_GPL(hv_context);
>> +EXPORT_SYMBOL_GPL(hv_post_message);
>> +EXPORT_SYMBOL_GPL(vmbus_isr);


Thanks Peter. I can use that in the next version.

Regards,
Naman

