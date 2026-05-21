Return-Path: <linux-hyperv+bounces-11150-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPuBBwd3D2pEMgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11150-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:20:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 210BE5AC174
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCC113007228
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 21:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73C9263C7F;
	Thu, 21 May 2026 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oAZp3aYZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A3C1FC7;
	Thu, 21 May 2026 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779398401; cv=none; b=uYoDXjMEywLTVQ02X3II0wrVEBp8YhQylvJz+h/Ojm9C9mkv59L+BbTkE+8t9o4dA4/28xM8ILI12D+V9Z4PZtVUicg50hArJtGrSf88mHcgP/M6/RdWo0JpgJ3Q3fSl4XFNGaIcd2slMYxK9TooMV3KLP8HW12Dta6EJfbq4sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779398401; c=relaxed/simple;
	bh=uAhNGKoUoZS7yIsJA1EkwqwwmT+PqJ513utvNA2Rj0s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CHWGQ0trybyTHlWN8JlIBuT5biGco6AIwvUEFrx63tHDV6zmk9ZLtPw8vl8H14GjDUpAOKFM2wBqLo5yGx6ru6X0doXzfh2sF3YmR1dhVqYGNxR5rJJFIRMSpuTCmhwG6zq1dIBoVti1BrX0DJ1lpzk2eSs6ZY1NXfue2/ofJME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oAZp3aYZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 3D4D920B7167; Thu, 21 May 2026 14:19:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D4D920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779398393;
	bh=SkT2Ar15CWoKufyEIfm/ejBxnP9BRNzxlOjoF9yxgbQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=oAZp3aYZHSR/+FRIfDjLfs3aIvr13eXykVWMcn3j3sOFH0Z8RzIv+3yN4WSq4AGBR
	 5/Nx1Z4uMNfvPGVoflUU5Cs/asjC87rgV2nw8uwRjndnZc6socoiDDqNZCOoIRN7xR
	 kJQfO6ZEZ4wt0Ft2cE6FmWVoLJyG+2GhfTc9KNxM=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 3A5A430705A4;
	Thu, 21 May 2026 14:19:53 -0700 (PDT)
Date: Thu, 21 May 2026 14:19:53 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: mhklinux@outlook.com
cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
    decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org, 
    linux-kernel@vger.kernel.org, arnd@arndb.de, 
    hamzamahfooz@linux.microsoft.com
Subject: Re: [PATCH 1/1] mshv: Add conditional VMBus dependency
In-Reply-To: <20260521164921.1995-1-mhklkml@zohomail.com>
Message-ID: <79f77f98-f91-4cf-47ca-c986faed5055@linux.microsoft.com>
References: <20260521164921.1995-1-mhklkml@zohomail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-11150-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,outlook.com:email,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 210BE5AC174
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026, Michael Kelley wrote:

> From: Michael Kelley <mhklinux@outlook.com>

> * Add #ifdefs around MSHV SynIC calls to hv_vmbus_exists(). When

Could as well do an empty definition of hv_vmbus_exists() if VMBUS is not 
configured, no?

> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 2d0b3fcb0ff8..aa11bcefddf2 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -74,6 +74,7 @@ config MSHV_ROOT
> 	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> 	# no particular order, making it impossible to reassemble larger pages
> 	depends on PAGE_SIZE_4KB
> +	depends on HYPERV_VMBUS if HYPERV_VMBUS

Nice, thanks!

Reviewed-by: Jork Loeser <jloeser@linux.microsoft.com>

