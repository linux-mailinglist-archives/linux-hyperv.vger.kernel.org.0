Return-Path: <linux-hyperv+bounces-8500-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JY6BnIPdGmp1wAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8500-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 01:16:50 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E587BA05
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 01:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 385833013013
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 00:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9FA4369A;
	Sat, 24 Jan 2026 00:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Aoa5TueK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B3CF9D9;
	Sat, 24 Jan 2026 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769213796; cv=none; b=j7aQbLD1YcPQMNZ9/vYuW3td8EFO8XC3ifZZ5V95f8sZBvD0HG5gC47r66ZUnk+VO3pGDFaSSOjgWi3WtLKHuTysrLxq4adeR0pc8OoQ/1pkaG1HMwNriN5x/yjyVM0u5PT5wmVBDQBcUC/pGN6eCQS1lLWu5e7C+ZesjdDGFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769213796; c=relaxed/simple;
	bh=eeUDYx/KEqNcnAZl3H51Zi1YvtK5Vn6KIT1KnsyFDBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k996y1bYYmavPaFG2U/XokJUoy4h1YvleqVr1ut48mz5d3Dk0QmXzBKxAC/ZFoTK2rvLr4rR8M2cntOSYzCTOExN+6KrKC/Jp8getNQ5OgB0aYJfrGkrfFCDihhFMqn/PhZpKvqAeYlogoGrV/XH6NEznaWr4Ub59NuyFnj/zeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Aoa5TueK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.32.59] (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5874820B7167;
	Fri, 23 Jan 2026 16:16:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5874820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769213794;
	bh=qDPebu+VYKh4SHEsugrX7nkwnEnxxaP4Wnfy4G0gCbs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Aoa5TueKP9nesierISYQdK6vFQi25Jawv3Sg5s7doKuUu0zIbxJTHaQyQbj2nqJCm
	 eDr9YG+rHyLQHQl0gm090Ley7Clmz5R2o4Xs917RnPwdXeOqeE/z1HHq3WH2JUtrGK
	 7FCtSWAvtHLHHVTnq13PplubAXoAjoG8VViuiI3w=
Message-ID: <549041d1-360d-d34c-4e3b-62802346acaa@linux.microsoft.com>
Date: Fri, 23 Jan 2026 16:16:33 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8500-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 74E587BA05
X-Rspamd-Action: no action

On 1/23/26 14:20, Stanislav Kinsburskii wrote:
> The MSHV driver deposits kernel-allocated pages to the hypervisor during
> runtime and never withdraws them. This creates a fundamental incompatibility
> with KEXEC, as these deposited pages remain unavailable to the new kernel
> loaded via KEXEC, leading to potential system crashes upon kernel accessing
> hypervisor deposited pages.
> 
> Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> management is implemented.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>   drivers/hv/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 7937ac0cbd0f..cfd4501db0fa 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -74,6 +74,7 @@ config MSHV_ROOT
>   	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
>   	# no particular order, making it impossible to reassemble larger pages
>   	depends on PAGE_SIZE_4KB
> +	depends on !KEXEC
>   	select EVENTFD
>   	select VIRT_XFER_TO_GUEST_WORK
>   	select HMM_MIRROR
> 
> 

Will this affect CRASH kexec? I see few CONFIG_CRASH_DUMP in kexec.c
implying that crash dump might be involved. Or did you test kdump
and it was fine?

Thanks,
-Mukesh


