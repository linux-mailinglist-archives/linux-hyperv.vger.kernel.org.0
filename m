Return-Path: <linux-hyperv+bounces-11255-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gACXLmNNF2r7AAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11255-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 22:00:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB405E9D79
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 22:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DECD3005EB8
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125B03624A6;
	Wed, 27 May 2026 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RO/7LQrx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18BB37DAC0;
	Wed, 27 May 2026 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912032; cv=none; b=IUR65BsBofKslWri+FRV7HCDiMQ8dPNZfvW+uEw0DbkjO+2W5IkXfcC7XJLKevR+gvFfa7gMTTADj9Jiq+lPA+BTY2dK9hZgtFUYXZf1p2wBswk3MqN5bCEmSn5VYqT9Yv2op1tTv9jwMTQrbjZRkVHXJT8e5kkLWeNdDKDlBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912032; c=relaxed/simple;
	bh=giD1fP0qo+NXqhT7Zu9puQx7zES/b1xWn2eGbhw/h+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We8eQDFUuCjinRdCYR0NC3k8gMjYI1X7YQJEuv9wrG3tPy0gcm5gV4J4w2Odoj8WzcLoF2CU4u1yWSgpNZYoTKhOAEW9yot7Iwy/yZvRsxerWxLBj9wbLcNWCflXYG3mfGpngrpDuql9TnIaCpwiVBjdyQsWcGEOm+eyfBEkywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RO/7LQrx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 216AE20B7167; Wed, 27 May 2026 13:00:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 216AE20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779912020;
	bh=/2dLZHfni1Tt8Z52ghcz4jMNQ8OpvIftsbok8Z+JxQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RO/7LQrx6/JO2NKcPmrj7+ReFDRWW+GzX+ELY9DGg5/4xAkXtWX+nW9aTC0AyzCvJ
	 ZSgHVSO8e/3Djv1SshxLvq2rM7e4EMl/C/POSANuQLpyVaGjBOKUtRG7WDVyjSSskj
	 PPAk/R3qYWLFYx35HsTDUEh3tYEDelPrHYQfZhAI=
Date: Wed, 27 May 2026 16:00:20 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	longli@microsoft.com, linux-hyperv@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hyperv: Clean up and fix the guest ID comment in hvgdk.h
Message-ID: <ahdNVLMHrSgpVKwr@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260527192101.1471995-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527192101.1471995-1-decui@microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11255-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 9CB405E9D79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:21:01PM -0700, Dexuan Cui wrote:
> Change the "64 bit" to "64-bit", and the "Os" to "OS".
> 
> Remove the obsolete paragraph since the guideline has been
> published in the Hypervisor Top Level Functional Specification
> for many years.
> 
> The "OS Type" is 0x1 for Linux, not 0x100.
> 
> No functional change.
> 
> Fixes: 83ba0c4f3f31 ("Drivers: hv: Cleanup the guest ID computation")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

> ---
>  include/hyperv/hvgdk.h | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hyperv/hvgdk.h b/include/hyperv/hvgdk.h
> index 384c3f3ff4a5..f538144280ca 100644
> --- a/include/hyperv/hvgdk.h
> +++ b/include/hyperv/hvgdk.h
> @@ -10,18 +10,12 @@
>  
>  /*
>   * The guest OS needs to register the guest ID with the hypervisor.
> - * The guest ID is a 64 bit entity and the structure of this ID is
> + * The guest ID is a 64-bit entity and the structure of this ID is
>   * specified in the Hyper-V TLFS specification.
>   *
> - * While the current guideline does not specify how Linux guest ID(s)
> - * need to be generated, our plan is to publish the guidelines for
> - * Linux and other guest operating systems that currently are hosted
> - * on Hyper-V. The implementation here conforms to this yet
> - * unpublished guidelines.
> - *
>   * Bit(s)
>   * 63 - Indicates if the OS is Open Source or not; 1 is Open Source
> - * 62:56 - Os Type; Linux is 0x100
> + * 62:56 - OS Type; Linux is 0x1
>   * 55:48 - Distro specific identification
>   * 47:16 - Linux kernel version number
>   * 15:0  - Distro specific identification
> -- 
> 2.34.1
> 

