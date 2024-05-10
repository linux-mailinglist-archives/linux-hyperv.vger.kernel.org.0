Return-Path: <linux-hyperv+bounces-2096-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7828C2994
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 19:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D154B2514A
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 17:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B219A1BDCF;
	Fri, 10 May 2024 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jp4/F3Wf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5003F3A29A;
	Fri, 10 May 2024 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363691; cv=none; b=dalzUXoq0fVgl5q08wRsvyvisXrwB8CXX8obMlJJn+ONvZmoYuJRCrKlGmDaXSh0fwAyqEdKx8vwD+CY+CqzaBv0M+l5ocxgbcxkPWhG+/F3rBTrvF5xFYe8BCMUygiS3D9MC4byxKiA8gvi7GStaC64WYJFehmSPamCZFYzM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363691; c=relaxed/simple;
	bh=vP4A2cNoEDU3BHRV2UWqBoZFuXGL1RzbYffT+DgLkvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G0ILKzuN6s9eK587qC5nqGDzV5fMuaKZYJ96BBG9Roc0SDhUAOC9whGYqLrlKU9Rgswg7q7pqvhjFRh/QK68eV1Dves+x8hET4Vj8Gbop+ztR2s6lq/mxASm6XD+eNX5s0B7vvsDsI4GJk+kdTTexa+uM1Sx84qS3GpKdiTsMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jp4/F3Wf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.49.54] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id BADCE20B2C87;
	Fri, 10 May 2024 10:54:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BADCE20B2C87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715363690;
	bh=Qu2tPRqem1dQ4iklfODF8kUb57zN2BcGzR19ExYI5oQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=jp4/F3WfZ+1K9YFN2qFmQz3asAk4E1I8n/aK8HWolvZCKTkpS/RtrxSOSw8xiC7ao
	 Rsjk96uSka4m/tNCbyRo/Nt7z0IW3gQOhT0V3TbpYF8rzgSVxr6SF3KccgtOIsZsJb
	 8Rs9ULmh7Xh+k2Dt4TwrLtE6ePCpYYGAX+pUyXBQ=
Message-ID: <807443f4-2442-4925-becc-6eb20887acf6@linux.microsoft.com>
Date: Fri, 10 May 2024 10:54:49 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation: hyperv: Improve synic and interrupt
 handling description
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, kys@microsoft.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240507131607.367571-1-mhklinux@outlook.com>
 <20240507131607.367571-2-mhklinux@outlook.com>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240507131607.367571-2-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/2024 6:16 AM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Current documentation does not describe how Linux handles the synthetic
> interrupt controller (synic) that Hyper-V provides to guest VMs, nor how
> VMBus or timer interrupts are handled. Add text describing the synic and
> reorganize existing text to make this more clear.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  Documentation/virt/hyperv/clocks.rst | 21 +++++---
>  Documentation/virt/hyperv/vmbus.rst  | 79 ++++++++++++++++++----------
>  2 files changed, 66 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/virt/hyperv/clocks.rst b/Documentation/virt/hyperv/clocks.rst
> index a56f4837d443..919bb92d6d9d 100644
> --- a/Documentation/virt/hyperv/clocks.rst
> +++ b/Documentation/virt/hyperv/clocks.rst
> @@ -62,12 +62,21 @@ shared page with scale and offset values into user space.  User
>  space code performs the same algorithm of reading the TSC and
>  applying the scale and offset to get the constant 10 MHz clock.
>  
> -Linux clockevents are based on Hyper-V synthetic timer 0. While
> -Hyper-V offers 4 synthetic timers for each CPU, Linux only uses
> -timer 0. Interrupts from stimer0 are recorded on the "HVS" line in
> -/proc/interrupts.  Clockevents based on the virtualized PIT and
> -local APIC timer also work, but the Hyper-V synthetic timer is
> -preferred.
> +Linux clockevents are based on Hyper-V synthetic timer 0 (stimer0).
> +While Hyper-V offers 4 synthetic timers for each CPU, Linux only uses
> +timer 0. In older versions of Hyper-V, an interrupt from stimer0
> +results in a VMBus control message that is demultiplexed by
> +vmbus_isr() as described in the VMBus documentation.

Is VMBus documentation here referring to Documentation/virt/hyperv/vmbus.rst?
If so, could you please add internal links with :ref:? See for example in
Documentation/process/1.Intro.rst. If referring to Microsoft documentation, please
provide a permalink. Please do also look for other opportunities to cross-link within
Documentation or to external resources.

Thanks for the improvements!

Easwar

