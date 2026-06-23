Return-Path: <linux-hyperv+bounces-11652-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uj6xIBvgOWrwyQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11652-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Jun 2026 03:23:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C76A36B3288
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Jun 2026 03:23:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MGfbgCFz;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11652-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11652-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 246173048DC4
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Jun 2026 01:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FF73845AC;
	Tue, 23 Jun 2026 01:22:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E313845D8;
	Tue, 23 Jun 2026 01:22:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177771; cv=none; b=bQSoiS11pQAxjvYvEX8/+P4MqzmFLGc3t7KuLiXPl5Vz9TTSQZ6DtuCjAPRpvtD7tBV0RjYifB0W9bTI4GdAFzbXP4toJkoNpqNbEYV5r3++KVyFjTUrOGfX03VFOX71ESougEvfnqwOPCwD+murEQdYRRyHgAOPdHaPUCVxHbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177771; c=relaxed/simple;
	bh=2gMFkMAQrW/BA7+IwQktlX2qUqcrPQKdzGus9HDyqWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+UN/fS030SGUULf41Q8CplfofB+zHD+bv97Wwj0vCPUQbxxRUa3FOuONpRakpB2xwYncRSFtKNk+1BErRNegGHM0JFYOHSw7bwRyB2vUCc1E2yUHyhqlKEXk+MvOoC54hiXxs5buXd3/KKPwzYd7/QFDGvoMI8quDHWzbO3GJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGfbgCFz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12171F00A3A;
	Tue, 23 Jun 2026 01:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782177769;
	bh=wiKhmTj/5RgoNGcYgTQIYqio1KFyNm5e6m1cvBDw4eQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MGfbgCFzZKk4plutnehTRFn0PHmkUOWb3N/O6uMWHJVQK4yGunLCWvO9MSNiJuPlf
	 fBub8iueFHDtghORpRJx/x78iQbGP3eAhSrLsKCJO/bf/DvIRmwEQ8oxmk9EY8Cude
	 JAjZa47yXa1Xvv0IDXPoDJbvWNYVlvvam8AQQWd8ys0BT+sO6WGsQC9oFI+HJTrINY
	 z+ar4D+ef6qOUHvGun8Yv7wQmoryMKstJvaudrEQsB2NpZE6NPDq4+33QslYdWIzsk
	 f5OmV8gMIh8CCIv/p1L0bMgl2wJFDLzWsS/+TMlFvjkjmMJQNQQPcU4yhPdo847m4s
	 S1e7mL8f+nihQ==
Date: Mon, 22 Jun 2026 18:22:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, Simon
 Horman <horms@kernel.org>, Erni Sri Satya Vennela
 <ernis@linux.microsoft.com>, Dipayaan Roy <dipayanroy@linux.microsoft.com>,
 Shiraz Saleem <shirazsaleem@microsoft.com>, Michael Kelley
 <mhklinux@outlook.com>, Long Li <longli@microsoft.com>, Yury Norov
 <yury.norov@gmail.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Paul Rosswurm
 <paulros@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>,
 Saurabh Singh Sengar <ssengar@microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 net] net: mana: Optimize irq affinity for low vcpu
 configs
Message-ID: <20260622182248.5bfc49ce@kernel.org>
In-Reply-To: <20260619073338.481035-1-shradhagupta@linux.microsoft.com>
References: <20260619073338.481035-1-shradhagupta@linux.microsoft.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11652-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:shradhagupta@linux.microsoft.com,m:decui@microsoft.com,m:wei.liu@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:mhklinux@outlook.com,m:longli@microsoft.com,m:yury.norov@gmail.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:paulros@microsoft.com,m:shradhagupta@microsoft.com,m:ssengar@microsoft.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:yurynorov@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,gmail.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C76A36B3288

On Fri, 19 Jun 2026 00:33:35 -0700 Shradha Gupta wrote:
> Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
> Cc: stable@vger.kernel.org

If you want this to be a fix -- could you please rewrite the commit
message? What matters most is the comparison before the bad commit,
the bad commit, and then with this fix applied. Perhaps the three
cases you list is that but it's not immediately obvious..
-- 
pw-bot: cr

