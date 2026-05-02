Return-Path: <linux-hyperv+bounces-10576-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNYvAMcN9mn6RwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10576-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 16:44:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B4E4B2871
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 16:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 630833008E3C
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6A633F39C;
	Sat,  2 May 2026 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GqGuaenA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F41E26C39E;
	Sat,  2 May 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777733059; cv=none; b=EWOdpGaKVVfn7qqy+Vz7Qzw2iww9v06yoML1EdedYFwCbx/rTH7XFmHGkzU6u+//E3YGAEBTF1sg2YvQpsLXF9xaHC600nPsaV9LiUMOYiv8PrAnsRXaHvvzD2YGzlvZWGSn5T6+9SnNndzI2rl4w7oRsDnqK/oD2J12c8aeL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777733059; c=relaxed/simple;
	bh=9anMKQ+rbHIGnPyigBLYB5XWjiPeTIFHRFXh7oWCqo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5FXkkD49VHFHUicLsj0cV4aao2wYWzPRu9fjB4HWFG5vAkRSv22IW6q9aps09nZZixJIEr9JPfJNPuz1XfTLEt0Z7v4afvPRaLd6MHhNb6y3U4jaUtAxWMna1vIGyhI+DPvRe1UKQBgRDWlSVHa8x7R6Pq6cVMvjK0QTEaaznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GqGuaenA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 7E00D20B7168; Sat,  2 May 2026 07:44:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E00D20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777733057;
	bh=qHya1MwtRo/niKHniV2lfJqQo0X6kB9NDUD2elQdyjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GqGuaenAO5464eEgBQHtkBs7AQO8pKJj+2KuhLG5p91lczZBKkaXIZM6X4LN+a7wR
	 6T7PbOTbmAWSRPt3bKcZaTu3ABsY0L+2fBMlEc78geWBSYwV6L5PRrRcO6ng8BceHV
	 IFsRLPwYJwhlLKC8lpRYt0rQJiqr35QJ3BLVTJMU=
Date: Sat, 2 May 2026 07:44:17 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, dipayanroy@linux.microsoft.com,
	yury.norov@gmail.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: hardening: Reject zero
 max_num_queues from GDMA_QUERY_MAX_RESOURCES
Message-ID: <afYNwfvQ4/0Ps3NB@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260430083627.1873757-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430083627.1873757-1-ernis@linux.microsoft.com>
X-Rspamd-Queue-Id: 78B4E4B2871
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10576-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shradhagupta@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,linux.microsoft.com:dkim]

On Thu, Apr 30, 2026 at 01:36:21AM -0700, Erni Sri Satya Vennela wrote:
> In a CVM environment, hardware responses cannot be trusted. The
> GDMA_QUERY_MAX_RESOURCES command returns resource limits used to
> determine the maximum number of queues.
> 
> In mana_gd_query_max_resources(), gc->max_num_queues is initialized
> from num_online_cpus() and successively clamped by the hardware-reported
> max_eq, max_cq, max_sq, max_rq, and num_msix_usable values. If any of
> these hardware values is zero, gc->max_num_queues becomes zero and the
> function returns success. This leads to a confusing failure later when
> alloc_etherdev_mq() is called with zero queues, returning NULL and
> producing a misleading -ENOMEM error.
> 
> Add an explicit zero check for gc->max_num_queues after all clamping
> steps and return -ENOSPC for a clear early failure, consistent with the
> existing gc->num_msix_usable <= 1 guard.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Changes in v2:
> * Rebase to latest main.
> ---
>  drivers/net/ethernet/microsoft/mana/gdma_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 098fbda0d128..f3316e929175 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -194,6 +194,9 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
>  	if (gc->max_num_queues > gc->num_msix_usable - 1)
>  		gc->max_num_queues = gc->num_msix_usable - 1;
>  
> +	if (gc->max_num_queues == 0)
> +		return -ENOSPC;
> +
>  	return 0;
>  }
>

Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>  

> -- 
> 2.34.1

