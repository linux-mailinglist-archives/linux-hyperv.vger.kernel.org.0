Return-Path: <linux-hyperv+bounces-11533-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K2UXCiyaJmooZgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11533-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 12:32:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC67F6551E5
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 12:32:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b="c6i2/Eb9";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11533-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11533-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF1F13051655
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jun 2026 10:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BA03BB122;
	Mon,  8 Jun 2026 10:14:06 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71082E7F0A;
	Mon,  8 Jun 2026 10:14:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913645; cv=none; b=AHDNxDXmcTzaqahXcjBOSAVlaiSqeWEDglFeduktchET6CZmhU1f3wm1JSVyBB9WwJnE1ZgTW2P4Ffq/xLJ9FYvqi7GS0Z9YUfgmEL78ViSvRrDqgHFJEGR7ZMfcUAxNLkMsx3YyrN6e67sgCE8TfVe244DgVkrnz7E+nOwQyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913645; c=relaxed/simple;
	bh=14PKb+pOpqvay+ly6H71FW6oy9lPH/lGH1WLwWO4SAw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Vs7jJISirWxMSy433+d2gg/kA541RO7miz8rAKEzZg4ED864hD96SE1Qeur4r+2F/YBCNpweRuZILhD2d/Cr+ppbV+oUF38VwY+YJtxneAEBjjE8IEg45GL1mWMYaLrVmxTb6FJHc78vS9GOaeWvgam/RhS23EzbtWs9pIuHKSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c6i2/Eb9; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id C646520B7166; Mon,  8 Jun 2026 03:13:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C646520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780913627;
	bh=siiZgZU3VC/xhvfvYivTsPp+vnhZSEEwa81CmEUhSyM=;
	h=From:To:Subject:Date:From;
	b=c6i2/Eb9TTdyx3xnYdUkhzxMXW5IVpgL5xRWLwBqMtEcHv6UG6FmVDlh93fRaSgs7
	 wCrN5FjSC93akX0IDNNNsUjR1q8AXJUi/Ss7H0K8RoJq1YiyZMaSl8RgEfzR05FHfV
	 4on5iMvp0huwCu51z4bnZuofwXDokC4rff0O1yGE=
From: Aditya Garg <gargaditya@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	ernis@linux.microsoft.com,
	kees@kernel.org,
	shacharr@microsoft.com,
	stephen@networkplumber.org,
	gargaditya@microsoft.com,
	gargaditya@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] net: mana: fix error-path issues in queue setup
Date: Mon,  8 Jun 2026 03:13:39 -0700
Message-ID: <20260608101345.2267320-1-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11533-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:ernis@linux.microsoft.com,m:kees@kernel.org,m:shacharr@microsoft.com,m:stephen@networkplumber.org,m:gargaditya@microsoft.com,m:gargaditya@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.microsoft.com:mid,linux.microsoft.com:from_mime,linux.microsoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC67F6551E5

Two error-path fixes in MANA queue setup, both surfaced during Sashiko
AI review of a recently upstreamed patch series.

Patch 1 initializes queue->id to INVALID_QUEUE_ID in
mana_gd_create_mana_wq_cq() so that a CQ creation failure before the
firmware id is assigned does not NULL gc->cq_table[0] and silently
break whichever real CQ owns that slot. This mirrors the existing
pattern in mana_gd_create_eq().

Patch 2 guards mana_destroy_txq()'s call to mana_destroy_wq_obj() with
an INVALID_MANA_HANDLE check, mirroring mana_destroy_rxq(). Without
it, TX setup failures lead to a firmware-rejected destroy of (u64)-1
and a spurious error in dmesg.

Changes in v2:
  - Rebased onto net.

Aditya Garg (2):
  net: mana: initialize gdma queue id to INVALID_QUEUE_ID
  net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check

 drivers/net/ethernet/microsoft/mana/gdma_main.c | 2 ++
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.43.0


