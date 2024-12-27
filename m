Return-Path: <linux-hyperv+bounces-3545-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EEA9FD6FF
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 19:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A96E7A20A0
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B401F869A;
	Fri, 27 Dec 2024 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MYN7K2cf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9429245005;
	Fri, 27 Dec 2024 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735324639; cv=none; b=GrZ5LKG3sRWXiBIQVrITy6npRf+ExoybbPsXeibhSpJmQnkjQTB3YlsLqPxyLaT1NkExx8hZn9SsZX98JgW9KPRGp/jQLGTHBNfCq3JmS3GVJejI8Wchk4+TATQaTVt70FLY6NUxCTsJEc9QZuE9lHUCBmMFTy1ttRMPH9xNLDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735324639; c=relaxed/simple;
	bh=UU+3mRFvB4gkphXZHtPeDzVZVJXxfpjtDfLPdAKtxXM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pgGidrtN+LFtXOmiLOjLs1sKi0NRK64KOoTYUjk4t6ynQhvVGUzMtmIVC16V+zuOJpz+gbH9kv9WimQsv9BXDiXiINCBGm00C+r9f/NYUWRCyTouq/PZ+CKq9RtkEZ8I6nIAundDzLHmKcnLWLJtyLSRFcxetuaQ58j1iahEYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MYN7K2cf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.65.29] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 42A31203EC3A;
	Fri, 27 Dec 2024 10:37:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42A31203EC3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735324637;
	bh=eerzWytKzg4x7zgMm84QD5vYRYEn3V6CdFkxIkDnP/c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MYN7K2cfAkeAZZNfYjYD4UbznXW/wk141w3S313MhWfYEnagNLrVOzvrlRGe26Kt3
	 XaU4cRu67mucMUygjZRthThVAiwcQkbr1gMpVYzy3/G8MwhfwIEeH18W/7q2XVe5Ga
	 zkMxyI4Fsa40o8be8wnh1OaYBvMSp8kPRGLYkvbI=
Message-ID: <cc95e01d-e141-4f0d-8b15-71d7591e1163@linux.microsoft.com>
Date: Fri, 27 Dec 2024 10:37:16 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, nunodasneves@linux.microsoft.com,
 tglx@linutronix.de, tiala@microsoft.com, wei.liu@kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 eahariha@linux.microsoft.com, apais@microsoft.com, benhill@microsoft.com,
 ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v4 1/5] hyperv: Define struct hv_output_get_vp_registers
To: Roman Kisel <romank@linux.microsoft.com>
References: <20241227183155.122827-1-romank@linux.microsoft.com>
 <20241227183155.122827-2-romank@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20241227183155.122827-2-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/27/2024 10:31 AM, Roman Kisel wrote:
> There is no definition of the output structure for the
> GetVpRegisters hypercall. Hence, using the hypercall
> is not possible when the output value has some structure
> to it. Even getting a datum of a primitive type reads
> as ad-hoc without that definition.
> 
> Define struct hv_output_get_vp_registers to enable using
> the GetVpRegisters hypercall. Make provisions for all
> supported architectures. No functional changes.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h | 65 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 63 insertions(+), 2 deletions(-)
> 

Looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

