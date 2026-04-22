Return-Path: <linux-hyperv+bounces-10291-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N56OgQT6GnVEgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10291-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 02:15:00 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8CB440D3F
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 02:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E860E3021188
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 00:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E67125D0;
	Wed, 22 Apr 2026 00:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AYhX44x+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56E2611E;
	Wed, 22 Apr 2026 00:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776816897; cv=none; b=osdyOkQ32gDmMTRpcm4Q1dpCPJ/nWtYrx3cWZLmZ3g3WOwB2VSJkkqBtekvCPQG27WqCVBhuuxfs/Xlgr7xAwvQJmxYeproFVJ1CtqhjVcAUN8xg1XrS9JF7GQvBcriJZh5qmC1mQfQafxgO+YcjWznFXkWM+DTa7HBOpcx8CPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776816897; c=relaxed/simple;
	bh=n+gzSbQ+Nh70TB5Oh5NtO/k5eoDXzLgogu7dHUv+P3g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceicxDvMDCF4zOBTA//qwH/3grQjmbItfsiD/fIqf8sGlTSJVaPHYwXmrXq5lzzcKMi80YbDV44H6XHVRZICCAAoy1DSSGEzUs7Vug119dX6RY+3sR2LIS7Ue+hbVdy53s4zXeyR9QlZmbre+8PikLXMj5GqmEhS84/NDs5Nq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AYhX44x+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id A089020B6F01;
	Tue, 21 Apr 2026 17:14:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A089020B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776816895;
	bh=Z+jwkIhd42xBajnfQykGWHTIAfdJzq5ERBpDsh6wsaQ=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=AYhX44x+YDi3VNcnsiuTBO1VAxBZfuE1Hps4DtGi30sFytfLVE4QL+Jc+Gix+XYEZ
	 +U4gWddQWaKWuKdNo0STzne0GYybrggkIYu/mBgAZlVhbXfZazs0p5LHZIpwYnr5Ku
	 xOizc2KqdcHty7szX0P1zlmwhk26a4RDrvrohBUk=
Date: Tue, 21 Apr 2026 17:14:53 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH
 --to=kys@microsoft.com,haiyangz@microsoft.com,wei.liu@kernel.org,decui@microsoft.com,longli@microsoft.com]
 mshv: Fix interrupt state corruption in hv_do_map_pfns error path
Message-ID: <aegS_X7J4XhjfPbc@skinsburskii.localdomain>
References: <177681100155.270589.16151793616470732178.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177681100155.270589.16151793616470732178.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10291-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,skinsburskii.localdomain:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 8B8CB440D3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 10:36:41PM +0000, Stanislav Kinsburskii wrote:
> Restore interrupt state before breaking out of the loop on error.
> 

Please disregard

> The irq_flags are saved before entering the loop, but the early exit
> path on error fails to restore them. This leaves interrupts in an
> inconsistent state and can lead to lockdep warnings or other
> interrupt-related issues.
> 
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_hv_call.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index 7ed623668c8e..6381f949d9d9 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -237,8 +237,10 @@ static int hv_do_map_pfns(u64 partition_id, u64 gfn, u64 pfns_count,
>  			} else {
>  				pfnlist[i] = mmio_spa + done + i;
>  			}
> -		if (ret)
> +		if (ret) {
> +			local_irq_restore(irq_flags);
>  			break;
> +		}
>  
>  		status = hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
>  					     input_page, NULL);
> 
> 

