Return-Path: <linux-hyperv+bounces-10586-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP/mBiPD9mlsYQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10586-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 03 May 2026 05:38:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7955A4B44B2
	for <lists+linux-hyperv@lfdr.de>; Sun, 03 May 2026 05:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8DB9300795B
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 May 2026 03:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA93F3451DA;
	Sun,  3 May 2026 03:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Lxq88ZCn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BAD2E62A9;
	Sun,  3 May 2026 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777779486; cv=none; b=GgLUj7kkaeZz3ee5hf2SRnII9aMoHDTTlsFqxdjfIFe6m5ffxLDjLKIqUG4FzGEn/yRdGexV6BF5dJBGCriq1GvQ3JsiVD0Uv57rUZa0bkWqVAPaShGmU4KKggzwtRGRA9tM8MQHmMgFEQe1EEdgQZVsObO1JX4fJnkytOiZ0aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777779486; c=relaxed/simple;
	bh=WmmpyX1K6RGWPIfadBlZg/ek/3iePlbUJRyOO0swObY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekZimyQL9A8KvCcqRRvWh26hWSentJb99PQnQrFLworVblLPK9Nl4v451ea+yfuega20XEe+Tz6JQMvL8aILR02incfeNQhK4tUXXDyKDo5neZ+mciqEhtMNb29AroW8UQrWL3TysojeN/t9yqO/PwWDHN2ieNYE7XAb6kzOcac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Lxq88ZCn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id A88B620B7168; Sat,  2 May 2026 20:38:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A88B620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777779484;
	bh=ZIS5xXbTQdgHRdNjkf4kTseeEPdbP6MssM1GrGX32H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lxq88ZCnJP6fNS3tzIYkmaCpeELaZaCIcHVRYrfYkscKgfTBPYdrTMHIaI4G4gJSY
	 tXhE2MdVb1M2hLfSxGzpzDqTl6kbx7RcAmx3s4wpubR7MUcvwAPOuP/4wIWeazgIJW
	 GE9H1QGI+Bttolt20ywCKDcPMVMLKEmr3WA4l/Rg=
Date: Sat, 2 May 2026 20:38:04 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	stephen@networkplumber.org, jacob.e.keller@intel.com,
	dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org,
	john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
	yury.norov@gmail.com
Subject: Re: [PATCH 0/3] net: mana: Fix mana_destroy_rxq() cleanup for
 partial RXQ init
Message-ID: <afbDHPE5BBfYBRlH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260430035935.1859220-1-dipayanroy@linux.microsoft.com>
 <20260502165258.GM15617@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260502165258.GM15617@horms.kernel.org>
X-Rspamd-Queue-Id: 7955A4B44B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10586-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]

On Sat, May 02, 2026 at 05:52:58PM +0100, Simon Horman wrote:
> On Wed, Apr 29, 2026 at 08:57:51PM -0700, Dipayaan Roy wrote:
> > When mana_create_rxq() fails partway through initialization (e.g. the
> > hardware rejects the WQ object creation), the error path calls
> > mana_destroy_rxq() to tear down a partially-initialized RXQ.
> > This exposed multiple issues in mana_destroy_rxq() path, as it assumed
> > the RXQ was always fully initialized, leading to multiple issues:
> > 
> > 1. xdp_rxq_info_unreg() was called on an unregistered xdp_rxq,
> >    triggering a WARN_ON ("Driver BUG") in net/core/xdp.c.
> > 
> > 2. mana_destroy_wq_obj() was called with INVALID_MANA_HANDLE,
> >    sending a bogus destroy command to the hardware.
> > 
> > 3. mana_deinit_cq() was called twice — once inside mana_destroy_rxq()
> >    and again in mana_create_rxq()'s error path — causing a
> >    use-after-free since mana_destroy_rxq() frees the rxq first.
> > 
> > This was observed during ethtool ring parameter changes when the
> > hardware returned an error creating the RXQ. This series makes
> > mana_destroy_rxq() safe to call at any stage of RXQ initialization
> > by guarding each teardown step, and removes the redundant cleanup
> > in mana_create_rxq().
> 
> For the series:
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> I don't think that you need to repost for this. But please keep in mind for
> future submissions that fixes for code present in the net tree should be
> targeted at that tree, like this:
> 
> Subject: [PATCH net vN/M] ...
Thanks Simon,
it was a typo from my end.

> 
> Also, FTR, there is an AI generated review of this patch-set available
> on sashiko.dev. It seems to me that the issues flagged there pre-date
> this patch-set and should not block progress of it. But you may wish
> to use that review as the basis of some follow-up.
Agreed, Sashiko flagged a pre-exisitng issue in the tx path.
I will send that as a separate patch set.

Thanks and Regards
Dipayaan Roy



