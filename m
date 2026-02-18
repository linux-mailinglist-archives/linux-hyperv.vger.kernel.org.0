Return-Path: <linux-hyperv+bounces-8890-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OMoAe2TlWk1SgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8890-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 11:26:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7652F15567A
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 11:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB752302DE2E
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535EA2D949F;
	Wed, 18 Feb 2026 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiZmceBv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4C3266581
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771410391; cv=none; b=XohjkfT8yWmid3lp7mIDlSZwhyPnSOnbwMtuAAggkwsMNqBTS88uVaOfeFqPihY8QvQcolQY6lYkm4ugihIepzOwzgbG1JJilYSUNlISqKECC3iWNrz7X2dtJlBgXymPZN0zRHlv3f5JHRfZAv1pwMJfG0qdyyuhXSz1vu27kXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771410391; c=relaxed/simple;
	bh=5JcgXZrgOrM6do+BK1JI3r1U2blIESuaxyCRVIaOUh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XkzV4vz0DYZS8CbDtrFjYmRZjHMQkI/j3mA3Y45CvvON1/0v7CEt8eT6gHxhiw9CYb6usmcTLqXp8mqpVkZYzra6g50ZywQp+DY3Fxs1bP96ZLO6809WodzBMlTs9NtqM3Qt+gkLSDwSaCPt9/sY8dV+9YYH8JeaiH8ICHrSLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiZmceBv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so36991185e9.2
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 02:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771410388; x=1772015188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7gvcifprQLUEgZOpsRUHwX7m6i+hMM96dVdgLDV6HiQ=;
        b=HiZmceBvW8yrDll2ym7cY8EwgbRoaAWSCCFa90mU+iM/HU1tircVIjELDY0QovKNQr
         YFlF9NN29PqwbuL5X+spNoFujDWqAL5ikAF6i5PKqEEuv54wmptAUGsFMOB0wKj+EeB+
         8YHx/RBCnaRplDAg25UjsjOfKOtuuWZ0Z/kab9dA2XYAdzQ+3mPlczl1/cxdBpL9z5aS
         o+32DgkVB3vhEupwZ0ogvC8Zo9ILBpwZQ+DaSbbuVl8xVRoifsv8Zs7qfsFXkO9H2Ft3
         Dvi7/D9xjdYJ98fpxLXn0vjKyQKGdWMW4YAR5cQ6szNlgLUZoJzvKUYqTNSsBsm3oZjb
         pSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771410388; x=1772015188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gvcifprQLUEgZOpsRUHwX7m6i+hMM96dVdgLDV6HiQ=;
        b=wF10DROA39dk+y9AWG8Db3GeJasdYDGjTwNq4mu2GeHyy9acDzp+o6t/czNxv3Ys54
         qgeRINs7R94K05RsitU7pEPk6Et5VUnClCaWn8l+N3Vch2yaKLyTSHYet2bReKqF5hy/
         2VvsLd2098CqBviOfsYhvDg5ZKzCVKqU9XoEkBtLfW4jWgs1GPGHrZMVrK+15tx5nBF+
         0VDXm+V+ZJFsIXspgaOebUKonXO0FCpVZou+v+Q+g/PdhCzaPzWE4khMyILyOR/fXBjJ
         KbeAdO8Iku8TWx9tFKGA7xkhip+8W3XUmqcEpAfpen6bz/vB10FLkVsgH/SF0oUnrECF
         N+wQ==
X-Gm-Message-State: AOJu0YzCc5zPjd6XsVTfWpvy4EoUYCPZJriKXuZ1VIhNrm3m8nnmqjw3
	uroWjAIlmADIyekGKLYmz3zX2D7ihwV5dgxslV88lShaZpFgDDufh6IJYoacIWCF
X-Gm-Gg: AZuq6aL5QZI9B6woqc8/g3B84EJ2pZjlzO989snEd/HfWPM4gr61AzqgFquAMA0csZL
	COyUt90StZ4njGWpO5NODbIw/GSvbNyLgi8i4oZrigorbDAZiaHF257Itogelqk4YgMHLnJ7jmf
	I9/8n6eMWPJqS/+9ng58qxsiaId5tkDSEHsPtnUrU1s3gSpMFtN/UpeW38gCgX/TP2bVCZYG4rk
	GNrh5v1uG5X63+bfKiyWdKrfuUTb75ibqRCea7oyJ11VQd/UCuHed6CJq0KSBY1gdAuzAvvepJJ
	SDKEZGCluyVkcjrBimGYYNAsXWyb32ox4kXIYu5v6LyVZieVC7zdTuKQe5LwRFuEpZQCwHGMOB1
	0fbPaA3QSLO/JkvSn+NJHl2ijTYy+u7QNYEuAFT8kan7qnIcUS2yRnoZQg3mq3MBXJTXIPdMv+K
	yXK6EX24COoh+ziIpHKOEkgDVdSN/1KrY3TvYwFQYFkSR9HFMZR+4YMOJnjrd8aApUUsNGTDuwa
	pRiCiENIhbe9xx3Fb5MGkOTLI3GLSPE/+Mr+oOSL6Y23NHLpkl14aQ=
X-Received: by 2002:a05:600c:c04b:10b0:483:7eea:b172 with SMTP id 5b1f17b1804b1-4837eeab900mr168690775e9.23.1771410387217;
        Wed, 18 Feb 2026 02:26:27 -0800 (PST)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d994670sm463007875e9.4.2026.02.18.02.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 02:26:26 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH] mshv: Use try_cmpxchg() instead of cmpxchg()
Date: Wed, 18 Feb 2026 11:25:37 +0100
Message-ID: <20260218102604.178561-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-8890-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7652F15567A
X-Rspamd-Action: no action

Use !try_cmpxchg() instead of cmpxchg (*ptr, old, new) != old.
x86 CMPXCHG instruction returns success in ZF flag, so this
change saves a compare after cmpxchg().

The generated assembly code improves from e.g.:

     415:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
     41a:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
     41f:	f0 49 0f b1 91 a8 02 	lock cmpxchg %rdx,0x2a8(%r9)
     426:	00 00
     428:	48 3b 44 24 30       	cmp    0x30(%rsp),%rax
     42d:	0f 84 09 ff ff ff    	je     33c <...>

to:

     415:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
     41a:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
     41f:	f0 49 0f b1 91 a8 02 	lock cmpxchg %rdx,0x2a8(%r9)
     426:	00 00
     428:	0f 84 0e ff ff ff    	je     33c <...>

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Long Li <longli@microsoft.com>
---
 drivers/hv/hyperv_vmbus.h | 4 ++--
 drivers/hv/mshv_eventfd.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index cdbc5f5c3215..7bd8f8486e85 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -370,8 +370,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 	 * CHANNELMSG_UNLOAD_RESPONSE and we don't care about other messages
 	 * on crash.
 	 */
-	if (cmpxchg(&msg->header.message_type, old_msg_type,
-		    HVMSG_NONE) != old_msg_type)
+	if (!try_cmpxchg(&msg->header.message_type,
+			 &old_msg_type, HVMSG_NONE))
 		return;
 
 	/*
diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 0b75ff1edb73..525e002758e4 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -128,8 +128,8 @@ static int mshv_vp_irq_try_set_vector(struct mshv_vp *vp, u32 vector)
 
 	new_iv.vector[new_iv.vector_count++] = vector;
 
-	if (cmpxchg(&vp->vp_register_page->interrupt_vectors.as_uint64,
-		    iv.as_uint64, new_iv.as_uint64) != iv.as_uint64)
+	if (!try_cmpxchg(&vp->vp_register_page->interrupt_vectors.as_uint64,
+			 &iv.as_uint64, new_iv.as_uint64))
 		return -EAGAIN;
 
 	return 0;
-- 
2.53.0


