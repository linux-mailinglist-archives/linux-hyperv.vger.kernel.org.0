Return-Path: <linux-hyperv+bounces-10038-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACsvMtXy02lxoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10038-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:52:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C0D3A5EA6
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F8353006D7D
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD20E3932E2;
	Mon,  6 Apr 2026 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLWGHv2n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A21639151C;
	Mon,  6 Apr 2026 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497898; cv=none; b=rcDShFXBpDaOo5hFfP3e1yKaMRiH66+utEfMsg2ZCqs4oadmwiPc1j7QWYrH00WR8JzMNxb/9xiKtO2y0KnLRDS7rxfKpN0p5Lz4YVf5E4fBMhRF+L50rkguagwWRLdkEfDGhyRUizDHeNK7ksTWJHTlVCd4FpJWIobmjeKrjXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497898; c=relaxed/simple;
	bh=aOE7o6CfWDeEXlNasCvA6VtuO3c6A+iWm2BI/VVTy8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZsrjJpJxEn0K0q/04t62BzG9guSd5iiBaX6YCW0ZqP2Qkhm6Nm2EnM2GLC0eY4ErH0H1Iijm06CtFKC4/K31BXnI4YU/dGA7DDhxjUINtv4x0jnVsvTZNB/w3bpvuAo/A83qSJNHgxCnzO9Q2fgSvV5WU68mHZlAzo02TCJX6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLWGHv2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB90C4CEF7;
	Mon,  6 Apr 2026 17:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775497898;
	bh=aOE7o6CfWDeEXlNasCvA6VtuO3c6A+iWm2BI/VVTy8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RLWGHv2nHqR6OOlc3WD9/QohEKn5qnQ0C4IlpSX9N1dC2BeLGFibY+wyKS+IKcd3/
	 zmm5UPjEYYMXiZXlZ2pjNRmhki7GdfgVWCB4ok9RwJ40MQeSgIzG7a4D4b1xOov2RY
	 XlurxrQXxxFi3tcS9vXrGa0J7cldmy/HeoL6TIrl5ABZ92dcu/f8hwCyhUP60oyZu1
	 SZcVnOB1x/uxszZ+++xx/VeDJDyeQ7WGw05PkLndcURL1sXEovvBssdHqiKagVLyQL
	 Ua/8tOCgFLZ8gLpD9ZYnl1JBZrv9jrd1f5QGS6tazDVGFQIOslIxIiVvLsYOyumf7u
	 9cxsF0aXd0wqQ==
Date: Mon, 6 Apr 2026 10:51:36 -0700
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
 stephen@networkplumber.org, jacob.e.keller@intel.com, leitao@debian.org,
 kees@kernel.org, dipayanroy@microsoft.com
Subject: Re: [PATCH net-next,v4] net: mana: Force full-page RX buffers via
 ethtool private flag
Message-ID: <20260406105136.5e02420e@kernel.org>
In-Reply-To: <adHTm2SvjDrezEdv@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <acrkwuIFyBXhwICF@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20260330154755.6a8c73a6@kernel.org>
	<adHTm2SvjDrezEdv@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-10038-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
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
X-Rspamd-Queue-Id: E9C0D3A5EA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 4 Apr 2026 20:14:35 -0700 Dipayaan Roy wrote:
>   Function                        Fragment   Full-page   Delta
>   =E2=94=80----------------------------   =E2=94=80-------   ---------   =
-----
>   napi_pp_put_page                  3.93%      0.85%    +3.08%
>   page_pool_alloc_frag_netmem       1.93%         =E2=80=94     +1.93%
>   Total page_pool overhead          5.86%      0.85%    +5.01%


Thanks for the analysis, and presumably recycling the full page is
cheaper because page_pool_put_unrefed_netmem() hits the fastpath
because page_pool_napi_local() returns true?

