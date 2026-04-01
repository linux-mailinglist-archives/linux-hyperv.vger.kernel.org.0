Return-Path: <linux-hyperv+bounces-9866-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCaXHbg8zWn5awYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9866-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 17:41:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EEB37D54E
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 17:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3556C30EB0E5
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 15:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4BF364EB8;
	Wed,  1 Apr 2026 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HFK6xH+f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WOYb7gX4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461023E63A2
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Apr 2026 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056525; cv=none; b=AS0HxHyMiqJ0s87Pf1PP4/pKEbbL6F4ZZAqEZOv06G7+x5t8tL2aA7wLpF0KsalwVWn6wZwYv1p7diGsyNny20UghMX/vhv9vyTLSGi9adQvaSEgeytXztecjb5k8v34jFjlPYOj9A8nSdRlGHUFbNHAITgAPEGQuMXrriWZQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056525; c=relaxed/simple;
	bh=kvqOkaF6oavCc4vNTZWL2JJS/yqns89t/Q/Tuma3bP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAaT3o1pG97cqdA6bi+HfFxzx1E2mD/tgYjbWJDl2A3b/TDKP6z6hgLn2SoBQc8ZVqbSkMrz23WhYn5Q7TXuo1/xjavV+katMaCjoaAWeJxH2Rzg2XN1mVIm/frukGZTKJerLSUiFJGsWIzkXF27pZaYT/FI59Lw/3L34nuqgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HFK6xH+f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WOYb7gX4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775056520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9UA6CbhJOyc53y7U55vWWMB+MhknXEN+VZtt265QSPg=;
	b=HFK6xH+faz0dr//fImspb5AYfOi0AWxDWOc5CuA2L4g8iGQLUc2+LnmnMhm7MMAYen7aHl
	7ODHyKSEH9tyLxVQrE5XE6jzGuytfuRIDd1hrAv5M2CEuv6oLZrv9WvZeq+XKmEjXtVd3k
	0TK5iZepmg1HufAQCfmrxr4ITIMDpiZ32V1mjo9HTWcMVlcjo2NGIxUGrny4MJTQSx9elp
	9U+uGAfAv6h+h5EcJpPGEn5PKTDEROTFbsHXuQCjdnAOFrO2V1heXnutxmIDB120yO6Pfs
	WyvOuTEXnNh7nD+aUPpeX5f/5a/6/lsy7RJiT01Hhwn5vwv5ea9MAC+8VzxdrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775056520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9UA6CbhJOyc53y7U55vWWMB+MhknXEN+VZtt265QSPg=;
	b=WOYb7gX4prS0JO6ia6gnbROOoU08PckrX0nAIW9F1uruvixD7DVUYAS+AgimZ12MPDSYfP
	tlZTD+zYfbtgeqBQ==
To: linux-hyperv@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/2] hv: vmbus: Small cleanups
Date: Wed,  1 Apr 2026 17:15:15 +0200
Message-ID: <20260401151517.1743555-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,siemens.com,outlook.com,kernel.org,linutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9866-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2EEB37D54E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replacing the lockdep_hardirq_threaded() annotation which does not
belong in drivers and removing the vmbus_irq_initialized which seems
redundant.

Sebastian Andrzej Siewior (2):
  hv: vmbus: Replace lockdep_hardirq_threaded() with lockdep annotation
  hv: vmbus: Remove vmbus_irq_initialized

 drivers/hv/vmbus_drv.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

--=20
2.53.0


