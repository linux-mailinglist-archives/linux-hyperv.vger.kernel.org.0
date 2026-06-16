Return-Path: <linux-hyperv+bounces-11629-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MJfdBO6sMGqRWAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11629-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2026 03:54:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5500968B59F
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2026 03:54:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="kDp2M/pS";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11629-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11629-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10F5030D3BBC
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2026 01:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07ED37C92E;
	Tue, 16 Jun 2026 01:54:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C00248886;
	Tue, 16 Jun 2026 01:54:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574891; cv=none; b=H8HAOotJ215HqjQDUWgW5DgQnckjS1oEfapbDC/Wf3CgpDnpjE6DlgNxkKQ/FXuE+9QSbRVj+pM8AUAvZ+/tnCfL4mE3d7GVWuUWdf/NF1XtYsFnKbbdxVQbEJFi2siWEdSMSkg4RBMh1JPlCBUnbV3DY7aEhmk94oJaN9wt/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574891; c=relaxed/simple;
	bh=1OTtdrVdMwcsqHxVYAtrpUX2n8+40J5vZPyZtkd8uOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFGoTaQ8WCCSR2efiMhLTP6n8geu6xk1b0o7zbl9/sb0ophxyvbB9FAujOpXBeit4Vbm3JE1ONijgteI4wCKQVMTcIktuV6rHxHwm0wCdOIm1dI9KqSc3F26Cf3UYQdw8R/3fieK1Td3NGANGAU2EX0Zm4AIvvRYS4NsbF3hQ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDp2M/pS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBA31F000E9;
	Tue, 16 Jun 2026 01:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574890;
	bh=xVB2C8Izg4g9sd9i5QQCFPWuDiomXx2/37KEb+1MF2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kDp2M/pSrkAbqIOUJCckm8SnZND80Tl9OlXlq5UKaB3MEUxj6hAS0RM47jhzKYzJ4
	 CbHDdw4/I7ztuOw8dbS0tXGQpa5iB7IZ8a5wbcQ9L4SBguQTB+j+zt5WrnlinjWNYj
	 p49Fo2OyQaOU/Iokc9fHBlX1j5voNwNwh44Nw3CTNVXEAIMCUaZ/Darvv5cGwFL13s
	 DxxSJIvcxvIIbbOlD1lIyrzw8a1XnI2IQC4qybWsShHPIKD03eIOXFaMKTSVAmwF9H
	 Jzxw2vcdn1uiAoGj2iDnCp08Phvhby3VLU59ssxcEY7CJrVFh+X8Ooy828oU3+ME5U
	 Oou/iBzhiF07Q==
Date: Mon, 15 Jun 2026 18:54:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>,
 Simon Horman <horms@kernel.org>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Erni Sri Satya Vennela
 <ernis@linux.microsoft.com>, Dipayaan Roy <dipayanroy@linux.microsoft.com>,
 Aditya Garg <gargaditya@linux.microsoft.com>, Breno Leitao
 <leitao@debian.org>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, paulros@microsoft.com
Subject: Re: [PATCH net-next v4] net: mana: Add Interrupt Moderation support
Message-ID: <20260615185449.6a496c1f@kernel.org>
In-Reply-To: <20260613205812.2659945-1-haiyangz@linux.microsoft.com>
References: <20260613205812.2659945-1-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11629-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5500968B59F

On Sat, 13 Jun 2026 13:57:54 -0700 Haiyang Zhang wrote:
> Add Static and Dynamic Interrupt Moderation (DIM) support for
> Rx and Tx.
> Update queue creation procedure with new data struct with the related
> settings.
> Add functions to collect stat for DIM, and workers to update DIM data
> and settings.
> Update ethtool handler to get/set the moderation settings from a user.
> To avoid detach/re-attach ops, ring DIM doorbell to change settings
> at run time.
> By default, adaptive-rx/tx (DIM) are enabled if supported by HW.

The merge window has started and we need to start working on our PRs.
This will need to be reposted after 7.2-rc1 is tagged, sorry
-- 
pw-bot: defer

