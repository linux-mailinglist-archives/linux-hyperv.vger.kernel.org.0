Return-Path: <linux-hyperv+bounces-11063-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOsROqfyDWrA4wUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11063-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 19:43:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D8C59460F
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 19:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D7FF30D6D5E
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 17:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55AB36F421;
	Wed, 20 May 2026 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bueYDKXe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C493F1ACA;
	Wed, 20 May 2026 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297367; cv=none; b=JrsBFLERYjQJVSHwJBhQsFFNbHXF2FlcZXsEmTY3VanjXGeH8YxJrf5zxBEi0J+orJGuRr2TWCkAq6c31OkS3l48IvIWcCobG6Qa47op8gJxGsyodEURxYDcJk7Z/bFnhZK07zzmdHK243YO4sUc2l6fO5/FID7UFLgxdePvnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297367; c=relaxed/simple;
	bh=PXvSbANKYjYvunX1Ew5+YjvUrSZfd8wtauvppfdD4KQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dh9EmSIVhG7c1cy26QpNtJQ3B8ANGzcuswrxi9onqTvNlTZ6cC+WVBhmplLAnp/7HGqART6UaC/9q/gzWPdSKmY6CttSfG+gvDeUpmn8exBsrFpCvQfDCQd/gqxarrAiFwlwQ7Z+wQgK7kIpEcSsXI5tY+p8U7Ih0CGKq9xOm5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bueYDKXe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id CF5A820B7168; Wed, 20 May 2026 10:15:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF5A820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779297359;
	bh=R2ZZOAVumVjHe9058fhmUj1oT/TuUdahfEOP4265b1Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bueYDKXekMFz2Ou8ngVl8eYDqJUMB6X/jWowWrU1NP/+hZY+WeYg5HK+Qoz95wNNn
	 z2ivUyghIbqVs7Snss8qhP1i33ZAFzHEzJ5Wie0h1ns7S/u7RfHOW9csHQrHXQsnmM
	 F6R9azOTwe7HmZRKSW8YmpJljNU3BFSHZ2AJ3idk=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id CD6A930705A4;
	Wed, 20 May 2026 10:15:59 -0700 (PDT)
Date: Wed, 20 May 2026 10:15:59 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Arnd Bergmann <arnd@kernel.org>
cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>, 
    Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, 
    Arnd Bergmann <arnd@arndb.de>, linux-hyperv@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: add vmbus dependency
In-Reply-To: <20260520074044.923728-1-arnd@kernel.org>
Message-ID: <52a29c5-715e-8ea-af1-dafebfca7a84@linux.microsoft.com>
References: <20260520074044.923728-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11063-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,arndb.de:email,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 87D8C59460F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> When the vmbus driver is not part of the kernel, the mvhv_root
> driver now fails to link:
>
> ERROR: modpost: "hv_vmbus_exists" [drivers/hv/mshv_root.ko] undefined!
>
> Avoid this by adding an explicit Kconfig dependency. Note that
> stubbing out the hv_vmbus_exists() based on configuration would
> also work for some cases, but not with MSHV_ROOT=y and HYPERV_VMBUS=m.
>
> Fixes: f1a9e67c1138 ("mshv: limit SynIC management to MSHV-owned resources")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> drivers/hv/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 52af086fdeb2..21193b571a80 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -75,6 +75,7 @@ config MSHV_ROOT
> 	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> 	# no particular order, making it impossible to reassemble larger pages
> 	depends on PAGE_SIZE_4KB
> +	depends on HYPERV_VMBUS
> 	select EVENTFD
> 	select VIRT_XFER_TO_GUEST_WORK
> 	select HMM_MIRROR
> -- 
> 2.39.5
>

Yes, this is the right short-term fix. We will need to solve the root case 
(no VMBUS required) with a separate SYNIC driver abstraction.

Reviewed-by: Jork Loeser <jloeser@linux.microsoft.com>

Thank you!
Jork


