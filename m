Return-Path: <linux-hyperv+bounces-9844-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G6uIpzqymkkBQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9844-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 23:26:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 202E8361726
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 23:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A035F3033FA8
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 21:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4940F3A255D;
	Mon, 30 Mar 2026 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XBkQvf3e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E450B3A0B31;
	Mon, 30 Mar 2026 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905957; cv=none; b=RMqJ0gDC2Y3ES1XxgI1GVIjHcJdUIwnKOW93lLyTec8U0mHIztZRobY/vGjAm5Or76uVnLPw0+j7TIS11slm8ijbODwLz9rZqWcM8zhgvtwaCm/lBi9aGeEFl241g+oR8O1z5j1uhef4ccs3GZ6Xq06Fc6fwwJFEGRRK1NNV4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905957; c=relaxed/simple;
	bh=If7vVj0h1LhktKg/4O6eqdxK+wF1bpWIunX1Ems26PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHPzVvOMELOjQWdhw37MY8Unu9+ZD+2A4h/LilwLK+5l1Vhu3Vh/C0v1Aff36yR+NRbllrW5cVHbivz2yFGMaEHgiK5aG7s+v4EtCySof/tGKgCACrQuGPBkSbVJGmX2dXlnczXkQEyO0QImnSG2nERNln5Sf8u/CbvS0woampc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XBkQvf3e; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5133220B6F01;
	Mon, 30 Mar 2026 14:25:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5133220B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774905955;
	bh=IwSLCGjXGeocGyGh33Yf2x6hCh0qt8zHQ2pVGBY1Sk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBkQvf3eVa7qnCN/1sCCUX+emG0HZmZndso23lclf+MoGCXIKrdoVDYtDCxlwsDI3
	 YEKYZVi61/QAGECahg+tAAKv6cAm+XLR8Ln0261labfWm7cyJE7FrtrSdFvNct2Ue5
	 Qrj3DQBP1XaMAjzoQjCs/PAhdWCkudM/ZuIwyfZU=
Date: Mon, 30 Mar 2026 14:25:53 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/6] Drivers: hv: vmbus: fix hyperv_cpuhp_online variable
 shadowing
Message-ID: <acrqYVRHubvOaPD7@skinsburskii.localdomain>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
 <20260327201920.2100427-2-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327201920.2100427-2-jloeser@linux.microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9844-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii.localdomain:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 202E8361726
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 01:19:12PM -0700, Jork Loeser wrote:
> vmbus_alloc_synic_and_connect() declares a local 'int
> hyperv_cpuhp_online' that shadows the file-scope global of the same
> name. The cpuhp state returned by cpuhp_setup_state() is stored in
> the local, leaving the global at 0 (CPUHP_OFFLINE). When
> hv_kexec_handler() or hv_machine_shutdown() later call
> cpuhp_remove_state(hyperv_cpuhp_online) they pass 0, which hits the
> BUG_ON in __cpuhp_remove_state_cpuslocked().
> 
> Remove the local declaration so the cpuhp state is stored in the
> file-scope global where hv_kexec_handler() and hv_machine_shutdown()
> expect it.
> 
> Fixes: 2647c96649ba ("Drivers: hv: Support establishing the confidential VMBus connection")

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 3e7a52918ce0..301273d61892 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1430,7 +1430,6 @@ static int vmbus_alloc_synic_and_connect(void)
>  {
>  	int ret, cpu;
>  	struct work_struct __percpu *works;
> -	int hyperv_cpuhp_online;
>  
>  	ret = hv_synic_alloc();
>  	if (ret < 0)
> -- 
> 2.43.0
> 

