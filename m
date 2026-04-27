Return-Path: <linux-hyperv+bounces-10401-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL/zH1TF72m4FwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10401-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 22:21:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BC5479F1D
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 22:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C89E330103BA
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CAC363089;
	Mon, 27 Apr 2026 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZg05WDq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711032F691F;
	Mon, 27 Apr 2026 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321068; cv=none; b=PoTsNot26uIY3Q8yrXGFir4wrzap4hv3oX6W60734Ow0PKxmuoEUExH56bDFq0S644P7wlOh/CY8JTX0RUI1Wy+YIcUCjw/wTSJA83fdDDuSbV1/fwpjghhJaggcs0J18vhXUPIIHisCxfoHdRnGZPwL+Ahbt2rI8wsWnxB2Yyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321068; c=relaxed/simple;
	bh=h3ynAWc+KoIn2+PfrPfZOKHeqJ7c7EO2O5VFULiKX/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnEVv32C9JvwpDdmwgRRKzDvCy1jrmIy23R9bGJ5YZRQmWVEPRDDwcI3pvdsNndUD8w6+FTk4rtREeczynR9Nh1tTyqdQ60MIy4KrSzOsudfe3/qoJt8z4ojeaP7/xAEYBF6U86wlkUX0eV6hUmze9+N7wwYfIjy63D574R9CmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZg05WDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919C5C19425;
	Mon, 27 Apr 2026 20:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777321067;
	bh=h3ynAWc+KoIn2+PfrPfZOKHeqJ7c7EO2O5VFULiKX/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uZg05WDqsUvgubQYtoia9zuGY+BfgeBh+A0L0TAgox5S6gpSMlOc387pWsqSWVDns
	 2lS2/zPiZ6cBnEp401HXLASraMbLAPCXjOfr1d19gNtipPEKe8tBhoJgPZRlmlVdBd
	 T4adWsYnFxiV+prsL8qFMh6tr7t272eB8wkg7PL1e5ENom2VzP6O+cF0AiFNGkvfrs
	 zHkyEhHiOpMaRrhczJjjTREeGP2dYDiz4wEEXniF/rwIas8vVHl9YM5slMnmZmDTPX
	 5ewinJM60znpxfBdbr+LxVw8NakjQxE92PYoJUbo9FhZAJK5uCtS4LHyjwVA8YnHS5
	 vJByFaQBoGgvg==
Date: Mon, 27 Apr 2026 13:17:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: David Wei <dw@davidwei.uk>, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
 horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, stephen@networkplumber.org,
 jacob.e.keller@intel.com, leitao@debian.org, kees@kernel.org,
 john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 dipayanroy@microsoft.com
Subject: Re: [PATCH net-next v6 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
Message-ID: <20260427131745.2eac52ef@kernel.org>
In-Reply-To: <aex119OtL8CEGXkb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260407200216.272659-1-dipayanroy@linux.microsoft.com>
	<20260409183509.0b24dea6@kernel.org>
	<20260412125917.4fa8fc8d@kernel.org>
	<ad5kuCZz+gR1TlSh@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20260416083146.0bb94d2b@kernel.org>
	<aeoVC27mIzoKytqA@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<685d7bf9-062d-4bd2-8448-f7714bb05302@davidwei.uk>
	<aex119OtL8CEGXkb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D5BC5479F1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10401-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[davidwei.uk,microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, 25 Apr 2026 01:05:43 -0700 Dipayaan Roy wrote:
> Hi Jakub,
> with this new data from David, is it convincing enough for a mana driver
> specific private flag, which can be set from user space by a udev rule
> by detecting the underlying platform? If not then I will send the next
> version with the other rxbuflen approach. 

I think so, thank you both for the testing.
Please look out for the net-next opening up and repost the patches.
(The reopening is delayed, it was supposed to happen already but I
can't get a clean run out of our CI, sigh)

