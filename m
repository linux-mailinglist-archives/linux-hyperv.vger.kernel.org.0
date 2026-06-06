Return-Path: <linux-hyperv+bounces-11518-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UIceC5p3I2rduAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11518-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Jun 2026 03:27:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6576B64C1A5
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Jun 2026 03:27:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WozLIiq0;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11518-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11518-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF0B130234FC
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Jun 2026 01:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF6523C8A0;
	Sat,  6 Jun 2026 01:27:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB54071C4;
	Sat,  6 Jun 2026 01:27:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780709271; cv=none; b=u+4H/5thOqZO1jY6SWs/oF2a5KZN9rLdYu+slRGS8cLW8n0vHU610UDfSkgvZINf9aBl80mJ8q+cKqhhsDwWse0SSZRwG2SOkHerbUSSzzmbKqSXsjUtNs3ZAZ6Y/xCZp52Y/ZTdT2dXdCNLQfMSm2Fp6btinw7uMgksqVyx8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780709271; c=relaxed/simple;
	bh=1OJtF7vY9H8KdCtv0DLdAod04oMqb1yTg4e1NStshKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdcsOCBsp6p6dQd2shY4Ngr9mpwuF6aVvG3wi5Fa7op8xdN/c2DvmT4nKSpYPqDFOBx34yzj67+9dZ3XpOif+JvX782MhPQhbJ63y14agipr3S6PCOUw6KMkVOFxBH9Dl5owK6pQj6hPfXrP/WaozIuH2AdyYB5WgdeBIdfoIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WozLIiq0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEA51F00893;
	Sat,  6 Jun 2026 01:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780709270;
	bh=jXywdkzqZJYiigfuu3nQzbSjqzHWAoQ1g0NVJCMwSZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WozLIiq0kZcEHuHGfIXwaSSSF/vTYHL7CJz0GCOvQ+Rt34qwjo7qySAzCtrd3C95w
	 x08DDn2plKEEseJkl6qSGjy54FbHqYk8wAHdAR0OPPy5RVjfy8zIuElXznL6+owGr3
	 nL/wo+xqscL0m1VM8HNOM7GQm+kEHH+M7NAvyUNTrIttxUVm0SjfQ/uRjprQHnhkGz
	 FJeyPzY4YkqyPfNbwAnM79tgVf3n0prC1AwwHCorwO/hlzNG8l8ugO802FWs9bynNb
	 C8lJwxyqLKNi2iwALi4MVcDVtQD1igaNBlf46ofsSNFGFf0o9FCqT+VWKObVf2j9VS
	 PgJtDaH5Gph+g==
Date: Fri, 5 Jun 2026 18:27:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shradhagupta@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, ernis@linux.microsoft.com, kees@kernel.org,
 shacharr@microsoft.com, stephen@networkplumber.org,
 gargaditya@microsoft.com, ssengar@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: mana: fix error-path issues in queue setup
Message-ID: <20260605182748.5f106575@kernel.org>
In-Reply-To: <20260604080137.1995269-1-gargaditya@linux.microsoft.com>
References: <20260604080137.1995269-1-gargaditya@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11518-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:gargaditya@linux.microsoft.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:ernis@linux.microsoft.com,m:kees@kernel.org,m:shacharr@microsoft.com,m:stephen@networkplumber.org,m:gargaditya@microsoft.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6576B64C1A5

On Thu,  4 Jun 2026 01:01:24 -0700 Aditya Garg wrote:
> Two error-path fixes in MANA queue setup, both surfaced during Sashiko
> AI review of a recently upstreamed patch series.
> 
> Patch 1 initializes queue->id to INVALID_QUEUE_ID in
> mana_gd_create_mana_wq_cq() so that a CQ creation failure before the
> firmware id is assigned does not NULL gc->cq_table[0] and silently
> break whichever real CQ owns that slot. This mirrors the existing
> pattern in mana_gd_create_eq().
> 
> Patch 2 guards mana_destroy_txq()'s call to mana_destroy_wq_obj() with
> an INVALID_MANA_HANDLE check, mirroring mana_destroy_rxq(). Without
> it, TX setup failures lead to a firmware-rejected destroy of (u64)-1
> and a spurious error in dmesg.

Looks like these patches were generated against net-next, please rebase:

Applying: net: mana: initialize gdma queue id to INVALID_QUEUE_ID
Applying: net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check
error: patch failed: drivers/net/ethernet/microsoft/mana/mana_en.c:2351
error: drivers/net/ethernet/microsoft/mana/mana_en.c: patch does not apply
Patch failed at 0002 net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check

