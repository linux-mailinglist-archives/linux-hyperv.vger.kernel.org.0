Return-Path: <linux-hyperv+bounces-10406-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFnfFdbm72lPHgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10406-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 00:44:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B93147B95E
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 00:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BC763004622
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 22:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2EB3ACF16;
	Mon, 27 Apr 2026 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6RgOq+V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240F308F05;
	Mon, 27 Apr 2026 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777329872; cv=none; b=q/TSrzFRt6jKdAHq47NxCtKV9jT6pSz/J1tpD4//G+BrMUk4Wdzi1BU5E+zV4h82T+l8vqEDigA/fSSA2IjsroL51PAUsvmRcnF6GRj2Dtl+k5aKxbdzpBU8i/gDnszBCDBplQGj7Yg+qzzvmffcJxEYp6IY18VXahCvnj8CUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777329872; c=relaxed/simple;
	bh=R4LMRbc5mg+8UIeUjMdT+Efo6WUGtul9TLdlExK2ELg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4I7Zo4AwGZQTno7qf7eXzV/7kFVPUuITcE82Py3Sa+r1x1fdKwopcKRG9v/yjZehScNvb6DFBCplKpqebH/LmNJ8SmE+w8KUSbsfdTrWBYRBROxFwaN+/exxMcg4rKmi88UarAjjc2tg5q4HNT4WrtYfTtVBTgdFHCDbkRcuHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6RgOq+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4E5C19425;
	Mon, 27 Apr 2026 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777329872;
	bh=R4LMRbc5mg+8UIeUjMdT+Efo6WUGtul9TLdlExK2ELg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c6RgOq+VoUwVn47JnHkDjnuu/vZqEpPZOlm1WZEXW/vRsvPtcEGYyFKv9mV4QRI4g
	 sHTuo03n9gQ59wKHHTU91b6z0CY/HRapOAxL2u/H9v68niu59kvE7L5CJ2Iy6q5Fcz
	 kZd2yb5mLU38GFtoTykuyYSTBnimjRDQyc3jh7DMUtOdDR3mxaT+iXvNAGF1i8Trea
	 iBZ4c3jzhxByCX3W8ZYweQjMeL1Muhoo7vEde1Ax8Q7FfB/RsIs7uz1aGjkDSFpWCl
	 r8WFeBXaND+y38YxAN8HcdklDfKfu+lLMFdQ1u/b4uYKWE6Ulb9sPXLQ7YyM35dihO
	 /dYNut8aAZ1Ng==
Date: Mon, 27 Apr 2026 15:44:29 -0700
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
Subject: Re: [RFC PATCH net-next] net: mana: Force single RX buffer per page
 under SWIOTLB bounce modes
Message-ID: <20260427154429.6a141824@kernel.org>
In-Reply-To: <ae91hyrLf4n23XE6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <ae91hyrLf4n23XE6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5B93147B95E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10406-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 07:41:11 -0700 Dipayaan Roy wrote:
> In both cases, sub-page RX buffer fragments allocated via page_pool may
> not be compatible with bounce buffering in this mode, leading to failures
> in the RX path.

What does it mean to not be compatible with swiotlb?
Normally that indicates that DMA API is mis-used.

