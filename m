Return-Path: <linux-hyperv+bounces-9093-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE/9L43IpWnEFgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9093-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 18:27:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 357831DDC97
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 18:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E6F630241BB
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 17:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B9342668C;
	Mon,  2 Mar 2026 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cvuzvGNX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1876F361DA1;
	Mon,  2 Mar 2026 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772472458; cv=none; b=Rp26BevBmiay4gU5eGoqn3sXhhz3XFsCNkXC3FB8Im+UrhnzIW5069payEaVbPNj0ZBeakZ+Bz/Ug+hc7+B9wCxX2gu1jBQPY59D7UqSuL+JtBemyCgVkSNmRvy53dcIR2IUHVcN8SkogCBUnn8mOB7lZcEozBOebuCcU+oyg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772472458; c=relaxed/simple;
	bh=9cB27lFaLse0MHG9ECXxjwuJ4ZkuReJjFI99UkhGOGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOvtkyc03dzrzy2yeXFRvhIuztK7TjStpbedIeozsRxga/jXXFzEgfSaBiDtitw8d2vVysa5uHJdJ+j8nhPdSsdkLpkqWXnqgd1NsNtaCucFT5ku6p3FW2rreWHRP2/pwYA7icOzJVejMILbM/dd4Xil0U8SZqXaYSyKeEaxjcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cvuzvGNX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id BFC0520B6F02; Mon,  2 Mar 2026 09:27:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BFC0520B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772472456;
	bh=+mRTNfwd2pVmXbuezER6zzEAHCrq6U4U+Asxmvr2WSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvuzvGNXiMc7LsgatqjKZabeY/n8tMzEZ4Xr/54my2bxUV6hI9zcPpKXvfHwJaOWp
	 a3zEkGsBEruFKSFtXQ8mHDe3aGB/JdAVoHwaPVzt5aspnM0FfOAsGxKawgUAP+xSro
	 HaHcxlCJVHzIbJ+HtdXvhK13fPFV3QRorlG4cb8w=
Date: Mon, 2 Mar 2026 09:27:36 -0800
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com, ssengar@linux.microsoft.com,
	shradhagupta@linux.microsoft.com, gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: mana: Add MAC address to vPort logs and
 clarify error messages
Message-ID: <aaXIiFgHhyzQixL+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260225192252.943534-1-ernis@linux.microsoft.com>
 <aaRsN8FDf8aH54QB@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaRsN8FDf8aH54QB@horms.kernel.org>
X-Rspamd-Queue-Id: 357831DDC97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9093-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

> I have reservations about the usefulness of including __func__ and __LINE__
> in debug messages. In a nutshell, it requires the logs to be correlated
> (exactly?) with the source used to build the driver. And at that point
> I think other mechanism - e.g. dynamic trace points - are going to be
> useful if the debug message (without function and line information)
> is insufficient to pinpoint the problem.
> 
> This is a general statement, rather than something specifically
> about this code. But nonetheless I'd advise against adding this
> information here.
> 
Thankyou Jakub and Simon for the suggestions.
I'll remove both in the next version.

