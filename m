Return-Path: <linux-hyperv+bounces-10070-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hE8+Nam01Wn78wcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10070-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 03:51:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D74163B61A5
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 03:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1D93300BCB2
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 01:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DA7346E58;
	Wed,  8 Apr 2026 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmFT+Cq7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725DA1E1C11;
	Wed,  8 Apr 2026 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775613091; cv=none; b=UyfRUDMqQzZl5KmMHOsGE3LUHo5jP6bFPNXNTBpOtfRVF9X20fTwcV7bx8X51LARziOODYLnFrooDzIjLHzuGed1d6ArcDr2EZAy+pL8uDDN3i3MmzoYmtlZCz0ja9YZ9jTA6gJh5T8C5HhpWWDU7XL889sTTKa1le3zUxmrbnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775613091; c=relaxed/simple;
	bh=fCBSQGqMzevTkcT7LslCcxFsnnfWHpPEEY4JITLJoI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBk3Iq2oywvYi3LztNLnOnVIUpCv+vqrlPOkURyA8ZO/NnWpKdAj/s+t+OXd6N+R2TFXpoQDLjJTNrnALvF5vyoQBSWYXUL8O+2ScoLX1qivXbE+geFqI2GKZuVj2GUZMpPGXBcVLiJbvv0NHBDvRq9k6sryjJFyNVU8k/7wsF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmFT+Cq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC6EC116C6;
	Wed,  8 Apr 2026 01:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775613091;
	bh=fCBSQGqMzevTkcT7LslCcxFsnnfWHpPEEY4JITLJoI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rmFT+Cq7dOHDzaGRk/uVDX5HCxAuPad+QD64QI+cQin3Ltrp4p9HFTqU3yloYEgLF
	 p7FdoxIQwaY89/hwlM5EpDqSv98tk5ojAezjn0cxqMoAQFvRIzaeDz5VXmnBmdxHxi
	 JsEX0uOoJ2oevc4aHYzF6eBWaPbu4JoT8XmZ3QEw1rA0PKKH0xpWlWsq4c8YmNC0Is
	 87qj9fr3YYji1yDHn/FMmAs+u/QbnuolbArIEW3yLl7nDd3CgQMTbbJIzjUQtSVv7d
	 uoQlqRYjU9o+V3yMg44SCYEhvGhsNJjVBDKR8TfrHXMclAT4KgUorGpGuVE52bLBdv
	 hetGX8PaMDIqA==
Date: Tue, 7 Apr 2026 18:51:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Dipayaan Roy <dipayanroy@linux.microsoft.com>, <kys@microsoft.com>,
 <haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <leon@kernel.org>, <longli@microsoft.com>,
 <kotaranov@microsoft.com>, <horms@kernel.org>,
 <shradhagupta@linux.microsoft.com>, <ssengar@linux.microsoft.com>,
 <ernis@linux.microsoft.com>, <shirazsaleem@microsoft.com>,
 <linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <stephen@networkplumber.org>, <jacob.e.keller@intel.com>,
 <dipayanroy@microsoft.com>, <leitao@debian.org>, <kees@kernel.org>
Subject: Re: [PATCH net-next v5 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
Message-ID: <20260407185128.605dcacf@kernel.org>
In-Reply-To: <e80b603d-8be0-4aee-8a31-c9cbb4a8ab00@intel.com>
References: <adHaF6DloRthctRb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<e80b603d-8be0-4aee-8a31-c9cbb4a8ab00@intel.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10070-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D74163B61A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 7 Apr 2026 15:10:45 +0200 Alexander Lobakin wrote:
> > On some ARM64 platforms with 4K PAGE_SIZE, utilizing page_pool 
> > fragments for allocation in the RX refill path (~2kB buffer per fragment)
> > causes 15-20% throughput regression under high connection counts  
> > (>16 TCP streams at 180+ Gbps). Using full-page buffers on these  
> > platforms shows no regression and restores line-rate performance.
> > 
> > This behavior is observed on a single platform; other platforms
> > perform better with page_pool fragments, indicating this is not a
> > page_pool issue but platform-specific.
> > 
> > This series adds an ethtool private flag "full-page-rx" to let the
> > user opt in to one RX buffer per page:
> > 
> >   ethtool --set-priv-flags eth0 full-page-rx on  
> 
> Sorry I may've missed the previous threads.
> 
> Has this approach been discussed here? Private flags are generally
> discouraged.
> 
> Alternatively, you can provide Ethtool ops to change the Rx buffer size,
> so that you'd be able to set it to PAGE_SIZE on affected platforms and
> the result would be the same.

Actually, hm. Now that you spoke up I wonder how much this is
an inherent ARM problem vs problem in whatever ARM Microsoft's
management empire-built themselves into.

Do you have access to any ARM servers? Google says GCP offers ARM
instances with idpf NICs. So if idpf benefits from the same
"tuning" we should totally push for a proper API not priv flags.

