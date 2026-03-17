Return-Path: <linux-hyperv+bounces-9477-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCoDEAPFuGnTjAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9477-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 04:05:39 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D94FE2A3013
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 04:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E832B300B9CA
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 03:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218472BDC05;
	Tue, 17 Mar 2026 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ5JSiLa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDDB1A4F2F;
	Tue, 17 Mar 2026 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716677; cv=none; b=usi2xw8h78uT61jwEBRow+jGdEeIxV/S2SF5oHPHAYwaSGgPbkarRaw7wSSicaONOh5x9bBafbydGolSIBO0JHjlJvAtAv2P/us1O+SARUFWcH/206un/Lmgi92ZhsmmnEO5Lwb0e904l3qlqaENL0sP1mfbiNSJLjuwNiGtaTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716677; c=relaxed/simple;
	bh=W2p8Bh7NPxrvg557DX7elFth74v5U8eTamjSI0+vU60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJDRc9tfNykJyTDTtYW6zv7z/6gaCGoKEljLqhzy1oot2V/bF1Q7ZfrGEqN2UFXFBrhuJUX2MFbY9EFlTmJBKOPaknKnVWaOSuf17/E2MP8hGJfjEMS4IqumuXMzOKC6P7YSog9MgYXvCH57c8Mx50vtjDIivf8OXvZc60r7Z7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ5JSiLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A5CC19421;
	Tue, 17 Mar 2026 03:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773716676;
	bh=W2p8Bh7NPxrvg557DX7elFth74v5U8eTamjSI0+vU60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SJ5JSiLa6XoPYD75hNDspfksnrwakUOtWIvtbZJBW1sUgomQoKsC8GoYB99gY7zvz
	 1eft9ypmBo2nK54KDthq5DcRh48hirJLyXC7Vcl6pCeZiOSq6sGN+Yo2+3iTAl+32p
	 cFvXDBpxFeKv8EfseZb1oZCVuOWK04fw6ch5lSlfum+DMYpvuISLY5ughe4QTc2vks
	 esYmSVEJyz9KnxqggIubC8PRNDxFYyhfzVJNmBXOqZeHQa05QTDjOVi4pgX+v5EbIB
	 uobZTxWXuGLJyg+NydU2v1mhjy17rvcVmik/WBIqT8e+4gBEQZ4nvx5AL+PncnyMI4
	 Wf/4gszSGVGHA==
Date: Mon, 16 Mar 2026 20:04:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Kory
 Maincent (Dent Project)" <kory.maincent@bootlin.com>, Gal Pressman
 <gal@nvidia.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, haiyangz@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH net-next v5 1/3] net: ethtool: add ethtool
 COALESCE_RX_CQE_FRAMES/NSECS
Message-ID: <20260316200434.3a0b99ec@kernel.org>
In-Reply-To: <20260312193725.994833-2-haiyangz@linux.microsoft.com>
References: <20260312193725.994833-1-haiyangz@linux.microsoft.com>
	<20260312193725.994833-2-haiyangz@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9477-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,lwn.net,linuxfoundation.org,bootlin.com,nvidia.com,pengutronix.de,linux.dev,microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D94FE2A3013
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 12:37:04 -0700 Haiyang Zhang wrote:
> +Rx CQE coalescing allows multiple received packets to be coalesced into a single
> +Completion Queue Entry (CQE). ``ETHTOOL_A_COALESCE_RX_CQE_FRAMES`` describes the
> +maximum number of frames that can be coalesced into a CQE.
> +``ETHTOOL_A_COALESCE_RX_CQE_NSECS`` describes max time in nanoseconds after the
> +first packet arrival in a coalesced CQE to be sent.

Looks good overall, can we broaden the language a bit?
Replace "a single Completion Queue Entry (CQE)" with "a single
Completion Queue Entry (CQE) or descriptor write back"?
I'm assuming your devices don't coalesce CQE writes.
For non-RDMA devices the notion of CQE is a bit foreign but 
descriptor write back coalescing serves similar purpose.
In either case host can't see the frame even if it's busy
polling.

So:

Rx CQE coalescing allows multiple received packets to be coalesced 
into a single Completion Queue Entry (CQE) or descriptor writeback.
``ETHTOOL_A_COALESCE_RX_CQE_FRAMES`` describes the maximum number of 
frames that can be coalesced into a CQE or writeback.
``ETHTOOL_A_COALESCE_RX_CQE_NSECS`` describes max time in nanoseconds 
after the first packet arrival in a coalesced CQE to be sent.

