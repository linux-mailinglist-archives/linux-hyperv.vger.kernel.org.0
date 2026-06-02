Return-Path: <linux-hyperv+bounces-11452-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fEfOCXo8H2oDjAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11452-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 02 Jun 2026 22:26:34 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D477631B8F
	for <lists+linux-hyperv@lfdr.de>; Tue, 02 Jun 2026 22:26:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Tq/GPlrP";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11452-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11452-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C84F301DCD9
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jun 2026 20:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC793630B9;
	Tue,  2 Jun 2026 20:21:30 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280B31FCFFC;
	Tue,  2 Jun 2026 20:21:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431690; cv=none; b=CvlgWOWaaNGMKHBw7+Lq2c/GlZ1LPH9AuvFgnEayKvT40UHX2Ie4KYJZ1EkM6/qWFLEDYB2u07Y5/YKq81TfoE+xBEgrgVdJspgJ9v1nJk38V6L1iQXiLBYC7KfYwjM1uEA+ILrqcsWjSRaumV/59jf+fcRBtvOpR/77ZavZhzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431690; c=relaxed/simple;
	bh=3/i1pydAaLW5HRp1XQJvOXNtw6c4Pe+vnJtHoHVROao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLEtLc2k1dPebjHNkMX8yxMg+/oDELJRhuKx3DHhr58+c88gN4/E2DU9p4892ogHM4GniHUDks5mWSsI2JbSjP2VM55LiE4imZR3IFqYkiDXV8hIzXo+jEUnXeQdWjCaXxpf6v7HsIr5Csau9J0ln/ic70/ZUPuKBo5REwPqSIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq/GPlrP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1276F1F00893;
	Tue,  2 Jun 2026 20:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780431688;
	bh=3/i1pydAaLW5HRp1XQJvOXNtw6c4Pe+vnJtHoHVROao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tq/GPlrPlaZa/Zo3OrrpAhvAp6Fybd27rxyHvAOkF02e3R4LB6RwB1INaWZLdE6y9
	 hPUpEIvO+xOI8CCvKUdBffQKZPXSyqaTLZ6TVsVmA3Z9Yke4Dce9/GL1mxY68byYbs
	 FDWcyjnYbp0JYrByxUJUk38DnaCWQ39DfpfTjyk6c4YnzZGnTaCV4lifyHyW4JbbU+
	 QlaDF+LMjNh9VlJALl+5bMYZrEBTVyW7OzGaH3eEMLfDav8UBYKmcJWfbHlG0zsD9m
	 ozDMlrRAH87qdhtKX2Y55Vvo5gsXjJCPIANim86HnI+UCeUyrNtvRO8fMMltDUpF/Q
	 7oEERAgZGUO4w==
Date: Tue, 2 Jun 2026 13:21:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kotaranov@microsoft.com, horms@kernel.org, dipayanroy@linux.microsoft.com,
 kees@kernel.org, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Cache MANA_QUERY_LINK_CONFIG result
 to avoid repeated HWC queries
Message-ID: <20260602132127.25fc27ee@kernel.org>
In-Reply-To: <20260528180757.1536640-1-ernis@linux.microsoft.com>
References: <20260528180757.1536640-1-ernis@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11452-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ernis@linux.microsoft.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:dipayanroy@linux.microsoft.com,m:kees@kernel.org,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D477631B8F

On Thu, 28 May 2026 11:07:51 -0700 Erni Sri Satya Vennela wrote:
> mana_query_link_cfg() sends an HWC command to firmware on every call,
> but the link speed and QoS values it returns only change when the
> driver explicitly calls mana_set_bw_clamp(). This function is called
> not only by userspace via ethtool get_link_ksettings, but also
> periodically by hv_netvsc through netvsc_get_link_ksettings and by
> the sysfs speed_show attribute via dev_attr_show, resulting in
> unnecessary HWC traffic every few minutes.

mana is ops-locked, right? Because you support net shapers

Could you instead take the netdev_lock() in the work?
It's already held around the user space originated calls.

