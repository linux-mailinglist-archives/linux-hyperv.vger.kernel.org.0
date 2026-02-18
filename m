Return-Path: <linux-hyperv+bounces-8891-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BQ4GvKblWmsSgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8891-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 12:01:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15515155BE4
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 12:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8A45300C012
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 11:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910873043DC;
	Wed, 18 Feb 2026 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFNdk2JA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD742F83B7
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771412457; cv=none; b=DbWLED4LDtD2Xw9vh/RPXei/KI1MkkK4epnCUw7GJ1hm2l47jKdW8FGl8WY4o4Io0mOXb0rmiQipqTthgwsrZUHcbijrduTA0OBZ9D5u8f/aAv5WYEeHhCOy85ZCEKC3p5bxi3mWzOYj+R0zLOgVHf3oz2fBto3ALlvHJkZ5bgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771412457; c=relaxed/simple;
	bh=jut32K0qD5zIBVpRTNRvCDkT9o6H9Ok5g7HL5cpHO9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZUI3S1wQikIqTC6XjW6JKP6BIq/Y/mq2kCocEOqG5P/yMhsIl1HEPAKWU7ZouRGy+D/eK7sKl0AEY/loNRf+XXJ6SiQItjCL6rcXuNtc8m/Ooj4WO0VzuXG3PQEpn8vhH27JbOUWLPNHscK5EPCsNiCTCejRpnOrloxURAzOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFNdk2JA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-436317c80f7so480031f8f.1
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 03:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771412454; x=1772017254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qthjmaZatp2uaj2R40wSdI4uEfUCjCNWJ8jI4UcjTZM=;
        b=mFNdk2JAUyWNjqFDJ04UbR48jtVHACrlNROeDzS8/XiyOSt6BwamqqlVno6JZ0Kq6c
         RVn45/ZNlHwjYAso64XVwtjXpPTX8hqqUP4Pa13kl51TMc09gsAq9VEpYdp4WciOU7Zu
         0sk0Q7ZuL/iERODCQ+s8y/oQluvIAzJGxS3D5EZr3f/OtdVZ9uNzdEE/zJizojhQ9U2V
         LL3ke8CQxEKjDk54j/dp9GTHvbEKdRA4yFArXEVvHCmcfKTMl2FGy1WLtSXquuH31cMM
         TBE4CfRBNu1oE8IvUAsZ7aAIIGjvgHQ2gfuzX6XdFDR88A8+s77Nj70TQzjGoIRBpePR
         APNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771412454; x=1772017254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qthjmaZatp2uaj2R40wSdI4uEfUCjCNWJ8jI4UcjTZM=;
        b=ncC/kPZzPMOBcGMbjtM0EM2E08v9B12sQy25/vPwlUDfqGYyeD+VZgX01RzkXGCCuL
         9OoofkeYxlVR24HcSPM7hbUO/HdOMFivazcU9swaOd6/TK9nP4+THZW/t1DbdEmhrYTq
         iH3P9sUSnTa0sD1l6NGnVoMKqKoENCi8jimWRrx9xCUMfoDkDuOmKebMJedvQXfnPTmj
         PwLTnuldQy562+QZcmSwqGzPlbT4+rmzYgxxe5icTNKdM84DYSck7Glwp64R75HAb0Z7
         eZGauX7LzyxffETJQ+J5c1PM3c4Z/f4/ju7YfFRyXtZRgbd6QatTNZisS5b9adyVX2o3
         Wqdw==
X-Gm-Message-State: AOJu0Yz+CbA862ICKiOp6+bU7/nl4jd4/6vFirnGnUmk9nKqrK35wiYX
	oasUByNQpt4N1vs9ou84QHLDNVe7whKdnInMseJp1bzAX2UCiLmozMci33rDJjaD
X-Gm-Gg: AZuq6aKv/VwvP/fLLw6dd4bwkmEfzr9yw+SDZM8ionchooQb7tXVDlKJrPQTk1QuSe2
	3GB3ZObOQ78ek1UKREoItxPNBi1hlfZoauD3wayNbydVku3s5I7eaPM5DFizLI6RF0pjKhKdf3i
	+smXdTOaZltku6qrpEzkiZNmGGyH6U9PQbFrxSvwrG8lLDgN7qEOU3zFzYWQoLh/IBWXRjSkltY
	yoBMdyYqQf7w47ObsWMHrhTSPmfTFcmeE0dMhPwo4+FaAA5V9uD65ytDbJ5jNKdZEsd1/7NcOaZ
	oVnYoxc41UzPBXPnluys1xjLIlneQvpfriF79MH2TNZKY0WJ5HkAKGSGovDAMx0FQUAXqnftfo9
	T1I2LwdnVFC2Uiu4zeMq9dL7/CVwe98tLFrZF/FspUFiY9eZ5LbO3tsQxRlEIpqFl+X0WeMJ/OA
	RbfuzZQVC4CRNBQ0QIUW0qoeAD44gFffQJmm5VcZAjXABhYsNKBiNf2lvCuBwD49lfMOjTYf/cK
	8YHImYBDDQRAxRC3QRx5vLQHAJQkZMw/lhr31tiFr1o
X-Received: by 2002:a05:600c:c1c8:20b0:47e:e0b3:2437 with SMTP id 5b1f17b1804b1-48398c667edmr17184675e9.5.1771412453875;
        Wed, 18 Feb 2026 03:00:53 -0800 (PST)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839712580esm26652285e9.1.2026.02.18.03.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 03:00:53 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH RESEND] mshv: Use try_cmpxchg() instead of cmpxchg()
Date: Wed, 18 Feb 2026 12:00:18 +0100
Message-ID: <20260218110041.179949-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218102604.178561-1-ubizjak@gmail.com>
References: <20260218102604.178561-1-ubizjak@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-8891-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[ubizjak.gmail.com:query timed out,decui.microsoft.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15515155BE4
X-Rspamd-Action: no action

Use !try_cmpxchg() instead of cmpxchg (*ptr, old, new) != old.
x86 CMPXCHG instruction returns success in ZF flag, so this
change saves a compare after CMPXCHG.

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


