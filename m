Return-Path: <linux-hyperv+bounces-7005-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77578BA5819
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Sep 2025 04:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A0B1BC31A2
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Sep 2025 02:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8349B214A64;
	Sat, 27 Sep 2025 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WyuSzmT7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F641A9F8D;
	Sat, 27 Sep 2025 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758938535; cv=none; b=NlEORDJ9dTEzOVCVqQkZ36kViFbx2Oz7dXxsilYFtsZ3tLRUOAtNT5Ij3xJaI7onkfjTqxhsjotZcDhUzP/wbKJnofxLyjBOtVXPN2OjfeM1JrtUjubAMyZd9gSFkR/QQOk7xkaXnkIOrl/fZ2muNHBOK12E8yd5FJVJOtZllVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758938535; c=relaxed/simple;
	bh=pMK3MWyD+jdFmAhXAcOBUDqBKIoI0nuhzxNxK6sXQZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XL7YzXHdw6Ha6fn06LX/eWaNHds5NXIFVyEApmCjLACSWrCfTvWNPdNi/WH66mfhHqK1IicoaaFE08PQV4NqVHiqhNG2WGWZtEccB9fB5iVBFv05x9a+KwPpe9HingWsz1I6InG2A5mCG+fxQs0knN7elYL0XppaWs8K5fTOiEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WyuSzmT7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id C41172012C16;
	Fri, 26 Sep 2025 19:02:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C41172012C16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758938523;
	bh=+ST5D05V/wSFnk67xNrK9zeouWofug5S+jjy0tUV9dc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WyuSzmT7qPxs/EHffPHMt7LyAYGKVyQJR6wWSH3LHlpW9uRwvfkOcNRIdCxwXzQVq
	 y4XpyQxwLm7gt9YtqUWnyf1+TI/MLiCB6tYMz56UNoNwiMgNaUcFmILfR7jfUGzgpl
	 r4xhknXCAcf5EyQyiIpsvw0Lkuovi8ltDRhmMEes=
Message-ID: <0ef4d844-a0af-9fa6-2163-b83f80bc74b1@linux.microsoft.com>
Date: Fri, 26 Sep 2025 19:02:02 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/3] Introduce movable pages for Hyper-V guests
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <175874669044.157998.15064894246017794777.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <175874669044.157998.15064894246017794777.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/25 14:30, Stanislav Kinsburskii wrote:
>>From the start, the root-partition driver allocates, pins, and maps all
> guest memory into the hypervisor at guest creation. This is simple: Linux
> cannot move the pages, so the guest?s view in Linux and in Microsoft
> Hypervisor never diverges.
> 
> However, this approach has major drawbacks:
> - NUMA: affinity can?t be changed at runtime, so you can?t migrate guest memory closer to the CPUs running it ? performance hit.
> - Memory management: unused guest memory can?t be swapped out, compacted, or merged.
> - Provisioning time: upfront allocation/pinning slows guest create/destroy.
> - Overcommit: no memory overcommit on hosts with pinned-guest memory.
> 
> This series adds movable memory pages for Hyper-V child partitions. Guest
> pages are no longer allocated upfront; they?re allocated and mapped into
> the hypervisor on demand (i.e., when the guest touches a GFN that isn?t yet
> backed by a host PFN).
> When a page is moved, Linux no longer holds it and it is unmapped from the hypervisor.
> As a result, Hyper-V guests behave like regular Linux processes, enabling standard Linux memory features to apply to guests.
> 
> Exceptions (still pinned):
>   1. Encrypted guests (explicit).
>   2 Guests with passthrough devices (implicitly pinned by the VFIO framework).


As I had commented internally, I am not fully comfortable about the
approach here, specially around use of HMM, and the correctness of
locking for shared memory regions, but my knowledge is from 4.15 and
maybe outdated, and don't have time right now. So I won't object to it
if other hard core mmu developers think there are no issues.

However, we won't be using this for minkernel, so would like a driver
boot option to disable it upon boot that we can just set in minkernel
init path. This option can also be used to disable it if problems are
observed on the field. Minkernel design is still being worked on, so I
cannot provide much details on it yet.

Thanks,
-Mukesh


> ---
> 
> Stanislav Kinsburskii (3):
>       Drivers: hv: Rename a few memory region related functions for clarity
>       Drivers: hv: Centralize guest memory region destruction in helper
>       Drivers: hv: Add support for movable memory regions
> 
> 
>  drivers/hv/Kconfig          |    1 
>  drivers/hv/mshv_root.h      |    8 +
>  drivers/hv/mshv_root_main.c |  448 +++++++++++++++++++++++++++++++++++++------
>  3 files changed, 397 insertions(+), 60 deletions(-)
> 


