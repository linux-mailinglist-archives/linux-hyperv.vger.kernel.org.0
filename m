Return-Path: <linux-hyperv+bounces-11480-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1TznFEEyIWr1AQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11480-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 10:07:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5CC63DD92
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 10:07:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=M0OAFG8c;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11480-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11480-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16D383019312
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 08:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B71237CD5A;
	Thu,  4 Jun 2026 08:01:59 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A02371045;
	Thu,  4 Jun 2026 08:01:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560118; cv=none; b=KJO33mHGhLVTg0gezBmbPBb4us/WgCddu9/Qsvw1wGZa2H2Q5ZQPX7xZKSG5XdVUOI1RV3MQ11YU64gpGtdLYG52tIK8Vb0CjQyYiJm8r20uQwzhAveTWEnWSA3F8dxp3my/6LbSBalSpm5O9kzX+YW+f88PZEVUSx7AyQBDJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560118; c=relaxed/simple;
	bh=ts9jrAU57ltejvV2tgKn8Cfqk7RM1A/olmKnc253cX4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TAVaITq4ghXsK6OTBIHJFdALE9Rgb29IrGyH2dS66V7BB2p8/DXYa7y88U0SEKx6Jx8hph2IUON+CuFvIsNY7I8N8rg1znrEDb7fVopT/vXsRaz3P8tMPnHgTTcvIpD0gThEccNcSrVoqqcUbyHQGQkm+OZb2jUKgyz6MUPFpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M0OAFG8c; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 2578220B7169; Thu,  4 Jun 2026 01:01:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2578220B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780560103;
	bh=6fqrlz32L/cPeUzKMaEmJOmXUcO099vvoAd3Gj4tEMI=;
	h=From:To:Subject:Date:From;
	b=M0OAFG8cE56HMjR7a0RtABXDysPWKojajLQ1bhQduW7W8urEabEDtLRALGgInbvs5
	 QiM92qUnf6WtIMJoFgsvNVaekSZ8LqdxBV/5OEE0dEaWy9XfJtlww34zGuNhIoIKi+
	 xP3DnheQP+4tU96qia4DyO/q5+w0Xwwu/rC1eEOM=
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
Subject: [PATCH net 0/2] net: mana: fix error-path issues in queue setup
Date: Thu,  4 Jun 2026 01:01:24 -0700
Message-ID: <20260604080137.1995269-1-gargaditya@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11480-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E5CC63DD92

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

Aditya Garg (2):
  net: mana: initialize gdma queue id to INVALID_QUEUE_ID
  net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check

 drivers/net/ethernet/microsoft/mana/gdma_main.c | 2 ++
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.43.0


