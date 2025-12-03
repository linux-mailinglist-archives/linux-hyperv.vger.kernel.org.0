Return-Path: <linux-hyperv+bounces-7958-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBC3CA1EA9
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Dec 2025 00:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 222D2301EC49
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 23:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDC22F066A;
	Wed,  3 Dec 2025 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pafrbO/W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B742EF655;
	Wed,  3 Dec 2025 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764802938; cv=none; b=ZvPHK+t/6e8fTY+vw+gephRSSAjT99NB5fMjgFKMH6HG+JTXX3hcrSSlJ8wQwzUVRUlGKeIQbp+yvUFpM6zJvaLBFO6I4AB40KjREHes1VosC9MWdukYS8z+eqxTtTw/Hp/m/36CaAOOjPp1mzPWZBgdvmIU8xbQXVYJ4XU1YLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764802938; c=relaxed/simple;
	bh=RGrs6MsFQWg5LHPeywP+JpvrebAanEiS52InEXC1U5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzG3qlTamYB6aCLuV9HwvJRJY9SPkO36P6Uzy/paEM6+YtNEjGhiVCbxWhh3eB6pylpJtUrgRZ1V2kdrqmey7NCeV4s4ruCe0gBnKoRECV6TNh8+L036IjjRHFZFv/Tih2lnbo88pGEVEk+vPNbikyV0XHOGKRUNlJosMrm4vHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pafrbO/W; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.161.205] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8C3D92120731;
	Wed,  3 Dec 2025 15:02:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C3D92120731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764802936;
	bh=47wu+LxTGUYi0cFlOvrv6e4lnheffuErviB8O+zycrQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pafrbO/W0wdn3igOngA4M4VqgE95ptBpkFhowYOnJ/ixZSp+td7M6kVl+X46pHSfu
	 Sy72dUXKfOJi6evuQosB/vYdcoWuG1YoO0DDf2fijqShPwuLGOy1mf3CLpNuRJI1/6
	 bHeq7vMSQuyW67QIFSPl1Kd6rfF58I73km7Xuhv8=
Message-ID: <d24f9dce-fdfb-4733-8fcd-228c2274094d@linux.microsoft.com>
Date: Wed, 3 Dec 2025 15:02:14 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] hyperv: Use reboot notifier to configure sleep
 state
To: Praveen K Paladugu <prapal@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de
Cc: anbelski@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
 skinsburskii@linux.microsoft.com
References: <20251126215013.11549-1-prapal@linux.microsoft.com>
 <20251126215013.11549-3-prapal@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20251126215013.11549-3-prapal@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/2025 1:49 PM, Praveen K Paladugu wrote:
> Configure sleep state information in mshv hypervisor. This sleep state
> information from ACPI will be used by hypervisor to poweroff the host.
> 
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c       |  1 +
>  arch/x86/include/asm/mshyperv.h |  2 +
>  drivers/hv/mshv_common.c        | 80 +++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
> 
As Michael mentioned, please fix the bug in the Makefile, and clean up
the unnecessary function stubs. Otherwise, it looks good to me.
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

