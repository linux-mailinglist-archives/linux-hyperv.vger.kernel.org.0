Return-Path: <linux-hyperv+bounces-11459-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9HMYD/52H2rlmAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11459-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 02:36:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D09633396
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 02:36:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YUxovYYO;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11459-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11459-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F37A301A2A4
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jun 2026 00:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A6223EAB4;
	Wed,  3 Jun 2026 00:36:10 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE0B63B9;
	Wed,  3 Jun 2026 00:36:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780446970; cv=none; b=QmInrZsPpOBz3h/c31pgGMzo6AT0M/2aPpf46rTLZyFXirdUjj5x3YBA/PsZft4CIv/EfQmHSKGmiaZdvqllhwu/nz96vAxivgObIr+vqd16aLpfLoIK6iyB5wbwDwn0PSiZt4Cudhnj6uwtd6Ic61di9SIrFWI6zlMoPLt7BBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780446970; c=relaxed/simple;
	bh=MfxSBQ7FpIjW+XoZea7Me1fc7/DqySN+aGsMB3ADWC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEIB1+q+vXSrhtjBqdm4Yz3wuAZXZ+WkwezbogIftX1c5wPq8qUG3Iow4Kg71nNLKjjNPBqKDXXrBRXZ0PisSF2a3OXB8RpXA/4lNjCGUoLXEguzLO4TLLTkAMB+BAQ+eZcKdIoMzS40jJ3GxObr9ji3LcpjAut2QTa9iOyIqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUxovYYO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB251F00893;
	Wed,  3 Jun 2026 00:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780446969;
	bh=SLkU7PYVCeZihT1F/frvulQEOLYYzwLpY2joSuqmbFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YUxovYYOwqxK0M4zHnFPEa9l8r/VBix5KW/qBoZf6rQ40rTolEqQ8kaREyEn7XHRw
	 p9woDWqoGo9XSfI0CZnHi4V4BiDxpE/+ie4HYZgIAnAomT3ClJZWQOetqz5cA519XA
	 X0URwv2DmsU0NrFPl3Pvsf+wHhIgP4fqi0ArSKNBr85e7p0TnQ7yVNXVKA5Odomlye
	 CtVXGlrnUcrxB/5OH1TzPlqtCs8r9zcMkjoYZgm5b2vAN+ZoIPVaxhg/SBNETSv4Hj
	 /yVn6t75XWU3gjfzxCkKOcwuM2VoRVRTY0p8hVyuJ2ch9na8/kT+dvburrFs80M1O1
	 xxZ7+s4JAXzWg==
Date: Tue, 2 Jun 2026 17:36:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Konstantin Taranov <kotaranov@microsoft.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
 "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
 Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v11 0/6] net: mana: Per-vPort EQ
 and MSI-X management
Message-ID: <20260602173607.34063034@kernel.org>
In-Reply-To: <SA1PR21MB6683230E973519C12E2AB797CE122@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260523020258.1107742-1-longli@microsoft.com>
	<20260527192735.34a794cf@kernel.org>
	<SA1PR21MB6683A7B2415BEAF17BD0EB4ECE092@SA1PR21MB6683.namprd21.prod.outlook.com>
	<SA1PR21MB6683230E973519C12E2AB797CE122@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11459-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longli@microsoft.com,m:kotaranov@microsoft.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jgg@ziepe.ca,m:leon@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:shradhagupta@linux.microsoft.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99D09633396

On Tue, 2 Jun 2026 22:48:05 +0000 Long Li wrote:
> Changes in patch 6 from v2 to v11:
> 
>  - Error handling updated from NULL/-ENOMEM to IS_ERR()/PTR_ERR() for mana_gd_get_gic() return values
>  - Added mdev->eqs[i]->eq.irq = gic->irq to populate the irq field on all RDMA EQs for consistency with the Ethernet path
>  - Introduced a separate msi variable instead of modifying spec.eq.msix_index directly
>  - Commit message updated
> 
> The gdma.h changes are identical to v2.

Hm, yes, Leon seems to be AFK since May 19th.
Please repost with his tag included, the list of changes you provided
does seem immaterial. I don't want to merge v11 as is, there's a good
chance people marked this thread as ignored by now.

