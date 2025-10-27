Return-Path: <linux-hyperv+bounces-7353-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A5BC1185D
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 22:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 041D54E777A
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 21:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CE930DEA2;
	Mon, 27 Oct 2025 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oUsxudKL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715022E6CA6;
	Mon, 27 Oct 2025 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599974; cv=none; b=JvIXl2fyJ0CY2v3xo1GkyCRTnnBC6Nbs92yU4ck8CJCq2PoyaPAzi15cPM5M17fKTa0/B0DnBKmjWpJoImwoey2rOrfiIolgAi5nHRJSenB8+YABnlNfNuFqdnneJKbQLv1zxT70BJ3QF95ROKbbpFSFiuXb+KMglQs8ejZeeY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599974; c=relaxed/simple;
	bh=6TCiXmKZmHvlxUnmjyYUaqLbN9oZjycAy1AqgqBs7EI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dz/EPgdiUUKiFMGb118uJQgMsxvMygNnoBCmOWb96LxQeqNiGQ9nELuolmYcuVIDNHFcBKjoktV6n2UYqe8xFfN2Qd6GY9jxQtKSpNxY6vPi5PNnwVT0WflUSWHjpRI1MXqmpmQ6vKvSZxqAmtDnnwgpZtFjoSHXnVnmRlwdbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oUsxudKL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7D639200FE4F;
	Mon, 27 Oct 2025 14:19:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D639200FE4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761599972;
	bh=f33z+NeSbMiTM7slCE3zWmMDaC5DHvqCgfHYGeaDfJo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oUsxudKLw8X7oPli2lri3x/P9MYBYDiwdXeJsxSrCsJZ8j+lSItOp7bgNpAF6D3yH
	 bmbBmrcQ72pqREWHK3H/NgkSce640KnZ8aS+rRCcnJwqsyus0LFmbTJxweiz9l+tPN
	 Ss8AbbVNDxzHdjafT7F+YFpH5fJDyecjSTWaAklQ=
Message-ID: <accc901b-999c-46fe-9c44-07cbb4301769@linux.microsoft.com>
Date: Mon, 27 Oct 2025 14:19:21 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 easwar.hariharan@linux.microsoft.com, anbelski@linux.microsoft.com,
 nunodasneves@linux.microsoft.com, skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v3 2/2] hyperv: Enable clean shutdown for root partition
 with MSHV
To: Praveen K Paladugu <prapal@linux.microsoft.com>
References: <20251027202859.72006-1-prapal@linux.microsoft.com>
 <20251027202859.72006-3-prapal@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20251027202859.72006-3-prapal@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/2025 1:28 PM, Praveen K Paladugu wrote:
> Without configuing sleep state info within mshv, if a root partition is
> shut down, it will try to shutdown by writing to ACPI regions. These
> writes are intercepted by mshv and will result in a Machine Check
> Exception (MCE).
> 
> Root eventually panics with a trace similar to:
> 
> [   81.306348] reboot: Power down
> [   81.314709] mce: [Hardware Error]: CPU 0: Machine Check Exception: 4 Bank 0: b2000000c0060001
> [   81.314711] mce: [Hardware Error]: TSC 3b8cb60a66 PPIN 11d98332458e4ea9
> [   81.314713] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1759339405 SOCKET 0 APIC 0 microcode ffffffff
> [   81.314715] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
> [   81.314716] mce: [Hardware Error]: Machine check: Processor context corrupt
> [   81.314717] Kernel panic - not syncing: Fatal machine check
> 
> To prevent this, properly configure sleep states within MSHV, enable a
> reboot notifier, allowing the root partition to cleanly shut down without
> any panics. Only S5 sleep state is enabled for now.
> 
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c       |   8 +++
>  arch/x86/include/asm/mshyperv.h |   2 +
>  drivers/hv/mshv_common.c        | 103 ++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
> 

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

