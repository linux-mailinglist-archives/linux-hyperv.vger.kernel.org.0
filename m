Return-Path: <linux-hyperv+bounces-9405-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGTxCp1AtGnCjwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9405-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 17:51:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CC8287836
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 17:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC4A8300F128
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2913947A6;
	Fri, 13 Mar 2026 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gUpSR8OM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C3D2FF15B;
	Fri, 13 Mar 2026 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420496; cv=none; b=ivyoFvAoGHUrCLUjNZF9iLgUHR4ATBj2ZH+NbfBlZ0LxaVWJGO9VfK6zJirtdrE4Jdi8VCXwPcqiTPqwZKCVmeiKc0He17U9vpFRK8z+DpXLzNyIPScrCeG6aMl81z8f+Nm81cQwKQ+QBMaw/fIbeuWXh3BrgvWwhiMs44H/igc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420496; c=relaxed/simple;
	bh=vQUWVIL8Rq3tfpBd86zevjrQYdBUhMPRGOxBjnm6N1M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EeJcm4hrU742Bu711AdNaDOLT4cpvaeAF26/EDb1mc/H4/kXL2MNMMC2FQUSjN3u8YAf+YgDjJ96hcYcl1pQk5NWaRvWLXa47euRaKxj1VKOqr+vwKY6EpISy5gZdcZ3/MKf1fjdts6Vqq6Y1jnz8NrcImCFee5ZAFm4Lc/p0As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gUpSR8OM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7770520B710C;
	Fri, 13 Mar 2026 09:48:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7770520B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773420494;
	bh=zWoNkM3lAc+Jy1N+IhhTfR7d93WJA4oyYP6gBRjF4tQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gUpSR8OM6IYfLYZgjOYImhJJ+SSxcoaj6J9P7YjIQri/YOv69aAbErBpG2zEEBfnP
	 hlDzoUwjekrHllzewPSyWZXz4kUnlKA6BiPKonknPD1nxJ7cSYdwZuCh6xBEfMb6ZR
	 /M4gkNrw+OPknTjTckv7YG+q+IzuYF6Eoa5hhh6M=
Message-ID: <10b5be11-55f1-417f-81d0-cf882a11e376@linux.microsoft.com>
Date: Fri, 13 Mar 2026 09:48:08 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 wei.liu@kernel.org, easwar.hariharan@linux.microsoft.com,
 decui@microsoft.com, longli@microsoft.com, drawat.floss@gmail.com,
 ssengar@microsoft.com
Subject: Re: [PATCH] MAINTAINERS: Update maintainers for Hyper-V DRM driver
To: Saurabh Sengar <ssengar@linux.microsoft.com>
References: <20260313042148.1021099-1-ssengar@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260313042148.1021099-1-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.microsoft.com,microsoft.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-9405-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[easwar.hariharan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.freedesktop.org:email]
X-Rspamd-Queue-Id: 83CC8287836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/2026 9:21 PM, Saurabh Sengar wrote:
> Add myself, Dexuana, and Long as maintainers. Deepak is stepping down
> from these responsibilities.

Minor typo in Dexuan's name. Probably something Wei can fix when he picks up.

- Easwar

> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6358dd7f1632..d67afcb0acc3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8028,7 +8028,9 @@ F:	Documentation/devicetree/bindings/display/himax,hx8357.yaml
>  F:	drivers/gpu/drm/tiny/hx8357d.c
>  
>  DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
> -M:	Deepak Rawat <drawat.floss@gmail.com>
> +M:	Dexuan Cui <decui@microsoft.com>
> +M:	Long Li <longli@microsoft.com>
> +M:	Saurabh Sengar <ssengar@linux.microsoft.com>
>  L:	linux-hyperv@vger.kernel.org
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained


