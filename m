Return-Path: <linux-hyperv+bounces-8643-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KBfN6HXgGnMBwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8643-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 17:58:09 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C38CF414
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 17:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BBAB3000FE3
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FDC2798ED;
	Mon,  2 Feb 2026 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Kz5lkvHo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407DB1400C;
	Mon,  2 Feb 2026 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051378; cv=none; b=dOraOS1BFvZl5/0/t5Dfneeirsx4q2zsKkqBgCdO51kajJxFG73HxNwsU3W1mU3w5SL9ePefN5HI1SWu+N0by392yvJBZxNCMjGTrzHB7kHEcaaJ4xK8yaRorIHElkiFylvpBkty3h1laIzZvaBTfVHZCGe//aHu7f/3tsblAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051378; c=relaxed/simple;
	bh=YHzu/3DnCsZpFhSOf4RIi1l/kwpWFH5GlblRo6zpXN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIQTrWAxyWjvhfKmJvZpDDnhQwOHrG+uA598Fx50TjvZH7Drm+zmueQeeYx8Qv/LckW4mq+l6BKzOcV7/kKMAk5TOVFq4ZQiXbTziJaXHX6vW5oB+lhNOUA+EjL0KwqoP4hZ3SCV5IBqRMDcYWujgTS4DuULiL4AMPsclR/cXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Kz5lkvHo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.105] (unknown [49.205.250.63])
	by linux.microsoft.com (Postfix) with ESMTPSA id E30AB20B7168;
	Mon,  2 Feb 2026 08:56:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E30AB20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770051377;
	bh=DeZSj6Zj/3RidThgBmwdnPrrjVo2bvT3MWr1TnZnhTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kz5lkvHoZ1DsxYPp2MVHtI6Gq4u6bu3vKWuUSMw/6bxd2eRfXSo3xR38Vd0orxO38
	 RaVxeNUbdkGLl4mKPUqdl4uWT50mV4JdQ3WXwx6x3EedyY5rx6kUo38JIv6wSycZEw
	 PfXYroPLmqs9+EPW7l62q11LygRKp6vvkz6apqIc=
Message-ID: <26bdf7a9-91ea-4236-a5a6-d7f8571ab87b@linux.microsoft.com>
Date: Mon, 2 Feb 2026 22:26:10 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8643-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37C38CF414
X-Rspamd-Action: no action



On 1/24/2026 3:50 AM, Stanislav Kinsburskii wrote:
> The MSHV driver deposits kernel-allocated pages to the hypervisor during
> runtime and never withdraws them. This creates a fundamental incompatibility
> with KEXEC, as these deposited pages remain unavailable to the new kernel
> loaded via KEXEC, leading to potential system crashes upon kernel accessing
> hypervisor deposited pages.
> 
> Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> management is implemented.
> 

I have not gone through entire conversation that has happened already on 
this, but if you send a next version for this, please change commit msg 
and subject to include MSHV_ROOT instead of MSHV, to avoid confusion.

Regards,
Naman

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


