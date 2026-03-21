Return-Path: <linux-hyperv+bounces-9684-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFtKCa1tvml1PQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9684-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 11:06:37 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BD62E49AE
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 11:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 988B83026C0C
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 10:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9191C2D97B7;
	Sat, 21 Mar 2026 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmviCYv3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5052BDC28;
	Sat, 21 Mar 2026 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774087471; cv=none; b=PXC2xVXupXcqsHQFeQb+t/QFa/6rE+SgwqrSbsDxeaIOnPEuelHcXYL/Gg5nkn4G3xap1LOqT/vGI+dRc2a+XPC1sk+Tp9bqRp9yawmUl4D4G27u/G5nRSKxzEhiPQs1eheXxUnfzftbU+FOv+pcVvZdY8NV/pMJRegnqhJn02Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774087471; c=relaxed/simple;
	bh=BTLgz+KnnI4AgvbDXAdQA/3E+5q59La1tbh18XBDHWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tR12Wrd+5MvMdc4bV4BzzuRhfmh0v+v6Y2SgsIyt6KiGG2yn5u6qMov/m2MzpTxbuEJ9h9J0uQHO31mr+XDvTEFrDYy+Uw053oyUHPn1MTms2oIMnQWcaK4l8RcTDL7TqjpHQrYiYR6KVXPPlhurJPyQkenjfSWENdjdfZS6iII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmviCYv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F931C19421;
	Sat, 21 Mar 2026 10:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774087471;
	bh=BTLgz+KnnI4AgvbDXAdQA/3E+5q59La1tbh18XBDHWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LmviCYv373j/wUabQM73A49Sk142C9nkshjAa84iW2gUEH2W81b4bph9x/Dq8comx
	 5xJRUaIlgtehawIjDAnaeLmKdZJk3Ft1+IdNafTUyZzReuvjodZxF4OnrNBK/iYmV/
	 smcSqvWOj8oQYPlTGdEbJ0lBx7VcCDMCgjG2eAfql4UOMpreqm1behGl+gAq69zOx2
	 Y5Wfqr2yqmBxrMLvsn34IiaIDrOLSOlavafXly4uzGPPkFdvvMS7zUt92iCurqcQs1
	 nHnKPorCDwQLRlm7XRDGDlhmb0DoSgERwQ4J6YBAhu6mIXSyymuhKpiiPdmWwwAFor
	 KbnAKuZg8/VQQ==
Date: Sat, 21 Mar 2026 10:04:25 +0000
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shradhagupta@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
	kotaranov@microsoft.com, yury.norov@gmail.com, kees@kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Use at least SZ_4K in doorbell ID
 range check
Message-ID: <20260321100425.GX74886@horms.kernel.org>
References: <20260320122107.1560839-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320122107.1560839-1-ernis@linux.microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9684-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 85BD62E49AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 05:21:01AM -0700, Erni Sri Satya Vennela wrote:
> mana_gd_ring_doorbell() accesses doorbell offsets up to 0xFF8 + 8 = 4KB
> within a doorbell page. When db_page_size is zero, the validation check
> in mana_gd_register_device() reduces to:
>   db_page_off + 0 > bar0_size
> which passes, even though mana_gd_ring_doorbell() will access
> [db_page_off, db_page_off + 4KB) and may go beyond BAR0.
> 
> Use max(SZ_4K, db_page_size) in the range check so that a zero or
> unexpectedly small db_page_size still results in a rejection when the
> doorbell page would fall outside BAR0.

Thanks Erni,

I understand the maths here. And to that extent this change makes sense to me.
But I am curious to know how a db_page_size of zero works. I was expecting
some space is required there.

> 
> Fixes: 89fe91c65992 ("net: mana: hardening: Validate doorbell ID from GDMA_REGISTER_DEVICE response")
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

...

