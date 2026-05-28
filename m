Return-Path: <linux-hyperv+bounces-11301-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC71BCGoF2qhMQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11301-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 04:27:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0416B5EBC3D
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 04:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C66DE3010232
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCBC2F547F;
	Thu, 28 May 2026 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeFqvv5+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5632E92BA;
	Thu, 28 May 2026 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935257; cv=none; b=Z2hau5TI43mbrwDcxhMh5xNKPBgkuTOagaGc8fBUBSs5YnbLqY0CmDytiDSrDMVkVFIrjXvbD4pvsY/vsOhNRGv58bUkCVE7moaaxKWrmpqpBg2+R4UaTf+E7SG7gVWLFT4nB5+HXZMoMnjsHC+jKKw7BvyMPOI1GBrGceFoDhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935257; c=relaxed/simple;
	bh=dmb/hy0IbR3i5uy+od9KVGCaLdQwxDjYmUf8Xfw96Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/A6bF4nPlwqzlZFiU0LX3YvAW/ocHEsff7EkmeB/Dh2hTD9qLWEI/riYBQqUYjs8EuYOyDte/7ZnlZpg7ajh4copLLwlML/ZSl41VDAdvC5nHIIza5BIDzhp8IG+NnWOYCLAJ9ORW1HH6Lk81EPTjc9W/duKU7s17bEZsnrfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeFqvv5+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA541F000E9;
	Thu, 28 May 2026 02:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779935256;
	bh=maTG8Js/fanjViCJFnZ1I6Y7ycF/UHkaEKk6SqwCkv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FeFqvv5+1XoZxQyVyDc88Xza5pnNKMwixzq6SzQjVVNQIIDumTBQsdEO916B0+W9B
	 ICFL7h5BF5TMogrURM/t0Yfm5BXEvFO2kDPw80xDqH0Y4H1TsBig6e323laNRFRZVP
	 qcAOmNlOWIQdy4bsx0ixMJAElBjn4kmCkC2oKCet025LHNPzOPN5qJXNq7oa6QnEjj
	 BazThnuN0PmMRatofV/X3tp3I4eSvwtblik9SXDsKN6LXk9qlvoTKci8JChjz3oj4Z
	 npj4TeS0qCNOJEusyK9i7IyNDInQc0hsMcins814jbCjdoQI34UZuYhBqTqRvMaJi/
	 3Wg/Futh/nSvQ==
Date: Wed, 27 May 2026 19:27:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Konstantin Taranov <kotaranov@microsoft.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 shradhagupta@linux.microsoft.com, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 0/6] net: mana: Per-vPort EQ and MSI-X
 management
Message-ID: <20260527192735.34a794cf@kernel.org>
In-Reply-To: <20260523020258.1107742-1-longli@microsoft.com>
References: <20260523020258.1107742-1-longli@microsoft.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11301-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0416B5EBC3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 19:02:50 -0700 Long Li wrote:
> The following changes since commit 95fab46aea57d6d7b76b319341acbefe8a9293c8:
> 
>   Merge branch 'net-convert-atm-xdp-af_iucv-l2tp_ppp-rxrpc-tipc-to-getsockopt_iter' (2026-05-22 11:11:12 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/longlimsft/linux.git tags/mana-eq-msi-v11
> 
> for you to fetch changes up to a26d11135abba51e81ae8b9689e288718af95088:
> 
>   RDMA/mana_ib: Allocate interrupt contexts on EQs (2026-05-22 20:35:43 +0000)

The branch is no good, it needs to be your patches applied on top 
of a commit already in Linus's tree. The current branch is on
top of net-next, RDMA would have to pull in 100s of networking
commits together with your changes.

