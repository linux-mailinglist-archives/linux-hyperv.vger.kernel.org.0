Return-Path: <linux-hyperv+bounces-10580-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5VvjKGMY9ml2SQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10580-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 17:29:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A964B29A1
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 17:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6A19300DE16
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B072D35F61E;
	Sat,  2 May 2026 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8Sps+6w"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2232D77F7;
	Sat,  2 May 2026 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777735775; cv=none; b=tWRVLrnJY2KrM3um6vpx90d8vzWiucml2pPix50Ucegc6UAO2Wosv9HjDS9fsU+xIvbBVBjxWdnlpqlGxHVwtrfQfwf8N0oBcI4aTaCvvkRmp+uWjkpJGu1ZnKi6075hs8e0LSEuIFQ98F8utfhnemHdo6g4bnkG85+hiEQ2zEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777735775; c=relaxed/simple;
	bh=zc8WlUvWc0EpgXm+rDxDw/E6TdrFDkHDA+IUWiiswpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqCnvlwoD1hr3jUhfyXfhTK/bqbGHEcz1HHV2M6k6aHVup6PrxkWaDkAx/FAhPbATvyxljNYkGuTVdrXi8LsUbCBIIFWRkfkiGglVEzc2vmL7nuc3fqzN56Si/9i0t40bxz8bsCog0GT0vVGVxitchAiKQYFHVyWNW/kwRHo1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8Sps+6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1570EC19425;
	Sat,  2 May 2026 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777735775;
	bh=zc8WlUvWc0EpgXm+rDxDw/E6TdrFDkHDA+IUWiiswpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8Sps+6w/SDg7BhBggF89twzUkiT3Cyqm6VDUNc9Q2Gc2vSxAAjymmFD2x5UG5D4F
	 SAuW1G0gZnWb+Ate55cJfNE31Ud7+NK9GkXVbTI71zR+aLpUx+k8XV1LJj3YwRPvhB
	 Zi7VKb7zbMPxJB8yqdhRsfTp2JffOCBjtEYroGfWpXjpfBR24j2UJw74cKmWRrj5cZ
	 cfLwDYSIgefYEYcyJvJG/nTkzZHt6KukzUl2xIkAk0uNCng6M1uQKSwwj1H3wYOxCN
	 7nlizfsF+fYQcMe/+qfibsISZ0box/0NzDgqIaXdDOCZ+SpIZddcbbzovIg5nwTVxq
	 iYQbieacDj+1A==
Date: Sat, 2 May 2026 16:29:29 +0100
From: Simon Horman <horms@kernel.org>
To: longli@microsoft.com
Cc: kotaranov@microsoft.com, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
	jgg@ziepe.ca, leon@kernel.org, haiyangz@microsoft.com,
	kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/6] net: mana: Create separate EQs for each
 vPort
Message-ID: <20260502152929.GL15617@horms.kernel.org>
References: <20260429221625.1841150-2-longli@microsoft.com>
 <20260502152354.289044-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502152354.289044-2-horms@kernel.org>
X-Rspamd-Queue-Id: D7A964B29A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10580-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,horms.kernel.org:mid]

On Sat, May 02, 2026 at 04:23:55PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Sorry about this, there was supposed to be some different text here.

This review is available at https://netdev-ai.bots.linux.dev/sashiko/
And I apologise that it overlaps with the review from https://sashiko.dev
which I also posted.

