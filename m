Return-Path: <linux-hyperv+bounces-10494-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HnOMPWC8mnLsAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10494-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 00:15:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6437E49AD18
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 00:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B201E300B193
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 22:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B634279FE;
	Wed, 29 Apr 2026 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odLTKtmh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A19427A00;
	Wed, 29 Apr 2026 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500915; cv=none; b=JzDfmRw4oXUk3mhb59gtXGgNYWZXwG4N3rYK+7DeP3P0DV1HIKOu81rEqTnvSbjoI3Pq7+r10t9bO7VIGW+FUtEWVmGMQSID2T7u9PsB+tjhHQ2d7lBZXuysomaCCANOlWcKV5zLnfevjQm0UcXmdjHr+jZ7tjV/zHViETnytkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500915; c=relaxed/simple;
	bh=Zv93FCnz67ibqE38O1qzNFDzi+UZGB7hG6LB4C3igVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0lQ1/nOTq46FAJspG+30IWzVa5iiyvp+GINXLE9iGyM8pGvbQJN7txnDwxSvgdBBM4z+5BZD78tqrSjEfVljyHCAcNWMVXsxLEunfG84AUIJEyv1pM0kHHkUZXeFBz/g0ljgX2YOHZASQsjDquxsGk89FHc2Kf3j8euRzP1Dc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odLTKtmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21A7C19425;
	Wed, 29 Apr 2026 22:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777500915;
	bh=Zv93FCnz67ibqE38O1qzNFDzi+UZGB7hG6LB4C3igVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odLTKtmhClfTk3Km3hQINQ06PMeFURKHZC3Fzz6opZr8C3gmdw0ZekWQcJERI09im
	 wTdIHglCLpk/NEXhuYOM3hdVi9nsD+tYnwJ71+GXrLy75VL1gE4/eUYSjJ7nmFGdNo
	 9nHZ4+fb8nQbs4mBBQSDgdt9TOElYDA30e+LyA6wH7wSH0e2Ayyq6PIo5QtyyiX88R
	 HcoOEbg/ub5RO2YtH2yCJUudjPT5+bCw2fJf58o9emgH+WXWI1LtUklJOAzzaOncuK
	 AgN8YwKyt2GVG7m8YVyxXWCkZ39p9j/xgCOp0zHhGQf5GXZ31iv7LMqmx6rb3cOrWx
	 HbiyYjn+AMO4Q==
Date: Wed, 29 Apr 2026 22:15:13 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Ky Srinivasan <ksrinivasan@novell.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH] hv: utils: handle and propagate errors in
 kvp_register
Message-ID: <20260429221513.GA2584450@liuwe-devbox-debian-v2.local>
References: <20260414111008.307220-2-thorsten.blum@linux.dev>
 <SA1PR21MB6683C1A3130951962841B3AECE252@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB6683C1A3130951962841B3AECE252@SA1PR21MB6683.namprd21.prod.outlook.com>
X-Rspamd-Queue-Id: 6437E49AD18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10494-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Tue, Apr 14, 2026 at 05:48:04PM +0000, Long Li wrote:
> > Make kvp_register() return an error code instead of silently ignoring failures, and
> > propagate the error from kvp_handle_handshake() instead of returning success.
> > 
> > This propagates both kzalloc_obj() and hvutil_transport_send() failures to
> > kvp_handle_handshake() and thus to kvp_on_msg().
> > 
> > Fixes: 245ba56a52a3 ("Staging: hv: Implement key/value pair (KVP)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Reviewed-by:  Long Li <longli@microsoft.com>

Applied to hyperv-fixes, thanks!

