Return-Path: <linux-hyperv+bounces-11123-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJA7JwdPDmrL9gUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11123-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 02:17:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5A259D390
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 02:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F06D93014C46
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 00:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C621E9B37;
	Thu, 21 May 2026 00:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcsaiMWO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AD71E8342;
	Thu, 21 May 2026 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779322628; cv=none; b=qmyikhRZnZzLq0Z4lbDlyOLYmSta0KQq9X+9Wmfs4kdifKwlCCfrTjBeNkin+SOM+vjbGOgazIvqhnUu+TeKh1UuYowhLYU14ZvnCrydDK5iipc7JdfzD7WxUTt9TLXdM9tOVSUOPoLXpLl7piZ9C22GIU6ZikGE3Oqij24wDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779322628; c=relaxed/simple;
	bh=9xQyMzRJDgjOsefu5RYTSnP5MQ/1ObcFiMsvdejp5ms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fC82iRipcxvfCnux1QNoUL+5QP+s2NExsZRwtVZUPBmXmGs0kKCNyiQaS2j2wGR8+rBgBqlq+k/70tEFNWL+AI4dVUF18A/ZU+rXbaqqabzp4eprxv2WHVYkBBDGUtzIc4Io5EFsqDgrFHCMiiNABx8I4eDVc/FqHn0qJ0fEmzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcsaiMWO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCAC1F000E9;
	Thu, 21 May 2026 00:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779322625;
	bh=MFWnW8FG7FPKHLVohR1ScLZecv9inExETb+L71ZQhq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NcsaiMWO3+TfDhFPX38AQ0QkCqwNQxSzpwYSdvZ01lVDAVksWUP6tp4njVyJ72dTu
	 /s4M+Zg9kIWs0UGDvHLB/RJClNVfgcMxmcAlX2ZQNf+ucBgqdDuejvSq30wpvt6muY
	 S89S9gvlcMsYJyTrDmjUczzZufmj0sFni/JwnCPEVE/n4nJR7PKZNariSMkdVDoOHW
	 AtzAU+erRvqXZuqG71RL9qjv4FdAt82AFIlrqxbdkRbjUoeb17/UIuViYB3K0czR4N
	 4J6k6jmHHprdU2xGcWQlxFQboRBgSvOdbfcV2ab8q05tLg43gaAX4Z7qG2QGJ9h7nP
	 YIlNwPWFV70OA==
Date: Wed, 20 May 2026 17:17:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 stephen@networkplumber.org, jacob.e.keller@intel.com,
 dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org,
 john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com
Subject: Re: [PATCH net 2/2] net: mana: Skip redundant detach in queue reset
 handler if already detached
Message-ID: <20260520171703.689c5462@kernel.org>
In-Reply-To: <20260518194654.735580-3-dipayanroy@linux.microsoft.com>
References: <20260518194654.735580-1-dipayanroy@linux.microsoft.com>
	<20260518194654.735580-3-dipayanroy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11123-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B5A259D390
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 12:43:51 -0700 Dipayaan Roy wrote:
> +	/* If already detached (indicates detach succeeded but attach failed
> +	 * previously). Now skip mana detach and just retry mana_attach.
> +	 */
> +	if (!netif_device_present(ndev))
> +		goto attach;
> +
>  	err = mana_detach(ndev, false);
>  	if (err) {
>  		netdev_err(ndev, "mana_detach failed: %d\n", err);
>  		goto dealloc_pre_rxbufs;
>  	}
>  
> +attach:

goto's are acceptable for error unwinding, not to jump around 
a function seemingly to avoid indenting something. Please use
normal constructs or perhaps move the netif_device_present()
into mana_detach() as an early exit condition? 

>  	err = mana_attach(ndev);

