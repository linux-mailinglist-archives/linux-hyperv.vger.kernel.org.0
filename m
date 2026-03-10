Return-Path: <linux-hyperv+bounces-9203-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOVdEK4AsGm0eQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9203-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 12:29:50 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 819BA24AD45
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 12:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E53DF31366EB
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 11:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A312371046;
	Tue, 10 Mar 2026 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k0ItWpFr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE45314D13;
	Tue, 10 Mar 2026 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141494; cv=none; b=ayxm6q7RTRRd9UEhndoR4/Do3CD+hlqQ5SDEo8gCM6nrSPk8tNGVzWal7zFiBMwahC/PQ4+5AC9DC9m78awXkkHK4CmnINM0n3xHUqvnuJ9N6DCYhyfoBYoQDVGzfv1av0C+VhXFEllXCjYTMsETm2EvQzzAvhjg3O1v9fJexB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141494; c=relaxed/simple;
	bh=keOhyXrvN5qREOF0Z+aLwGzUovBlxaJJ6XX1xa1whzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxmiojAAryMMq9Owonixdf5tncp0W/Q27pOC8zpUM5M3jXXXfalTR6PjfvsweMN2pa2XZLEVUHKCNdwLAWUJcuz4f+HCXI7atAzX/l/C1pWlgWsUuCC/UhOImdFmdKG5Eym+Vvptx7HMpHhQuVWtZOmRSgUZYLtVdrX3bnd5UJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k0ItWpFr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.66] (unknown [167.220.238.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4ED2F20B710C;
	Tue, 10 Mar 2026 04:18:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4ED2F20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773141492;
	bh=Kgzc2oPfF/BASQsZXTQUEjIXgI5WMGm8pDvFQ+jBV+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k0ItWpFrcIBohaxQGzM69xX5PmGKzri1+xhv2IKje2gA/eVxzGWG/2M8jiYYPARTF
	 fe09BTdNjC5lbKOyoUXr3TMaBcYSFzCPxpvZcVYdbmSzpa3alpbfICSGJydzghIu9W
	 CPQD83qY245UPjO95vLgADE7JfAp43wdyUmo/pHc=
Message-ID: <8d5360bb-eaf1-4325-acc7-5f3ccdb59dc2@linux.microsoft.com>
Date: Tue, 10 Mar 2026 16:48:05 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix potential NULL pointer
 dereference in vmbus_acpi_add()
To: =?UTF-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
 <a.vatoropin@crpt.ru>, "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260310084140.473079-1-a.vatoropin@crpt.ru>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260310084140.473079-1-a.vatoropin@crpt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 819BA24AD45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9203-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



On 3/10/2026 2:12 PM, Ваторопин Андрей wrote:
> From: Andrey Vatoropin <a.vatoropin@crpt.ru>
> 
> The current driver supports detection via both the ACPI interface and the
> Device Tree interface (OF).
> 
> In the function vmbus_platform_driver_probe() upon driver detection via OF,
> the branch vmbus_device_add() should be executed.
> 
> However, the variable "acpi_disabled" is a global variable that, in general
> equals 0 when CONFIG_ACPI is enabled. Therefore, it may enter another
> branch with vmbus_acpi_add().
> 
> Therefore, in the function vmbus_acpi_add(), when the device is not ACPI,
> the ACPI_COMPANION macro may return a NULL value, and this pointer is then
> dereferenced.
> 
> Add a NULL pointer check for the "device" pointer before dereferencing it.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: f83705a51275 ("Driver: VMBus: Add Devicetree support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
> ---
>   drivers/hv/vmbus_drv.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index bc4fc1951ae1..c9ee3375b524 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2571,6 +2571,9 @@ static int vmbus_acpi_add(struct platform_device *pdev)
>   	struct acpi_device *ancestor;
>   	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>   
> +	if (!device)
> +		return -ENODEV;
> +
>   	vmbus_root_device = &device->dev;
>   
>   	/*

I understand the case we are trying to make here, but I tried 
reproducing this at my end, where we are probing VMBus using Devicetree, 
and CONFIG_ACPI is enabled and there is no "acpi=off" in kernel cmdline.
But still, when the control reaches this particular function - 
vmbus_platform_driver_probe(), acpi_disabled still shows up as 1 for me.
Can you please share your configuration how you are able to reproduce 
this issue.

Secondly, let's say this case happens, then while our fix prevents null 
pointer crash from happening, it does not fix the problem completely in 
the sense - vmbus_device_add() should still have been called in this 
scenario IMO. Please see if there is any way to do that, or comment, if 
you feel this issue won't be there.

Regards,
Naman

