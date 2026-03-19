Return-Path: <linux-hyperv+bounces-9626-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCU9NiJevGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9626-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:35:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5422C2D23C4
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 305363050435
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012F407110;
	Thu, 19 Mar 2026 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk7dGGM0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83062406288
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951977; cv=none; b=gyVUxJBRuW3fwGWUo0ioPtec640zNgPXQY9CA/6f4GyApzBSeBowuWg8/n1Ma8WQp+T3PmGhq6opNHBwtloIbXK8f+IzhSEjF+uBV+pwV8ZbMgG4OlUmPAjhlvcuPbziOtVs34qiAU07LwhlSMZZC9oitPC1KUni2w1QspqMlEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951977; c=relaxed/simple;
	bh=64Yjo7ZvmJXvIMfS8hCbiomKgwsOGgRqkHQNG224eB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwxqcCQ3OiIjs9VuWti1AtxzhhN3vQ/u5kShjLprgZFhhPHBGH52bK+qlJRKKEbWF+iarqGKm8Pzqbi7QEJN5XZXVl/CxI5iDjZPlSkngC+Eo8qRPZcjMwN4qZNuMUi+mT/VVYEynDS6/uRr0yhSuhtN339c9Tg/Se5YU7jW1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jk7dGGM0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b527ac5d0so668938f8f.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951974; x=1774556774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq7pLRQgbUoZPtACF262weOXRDH8/ti4RFZhN9vDeZQ=;
        b=jk7dGGM0o+auPryu6y4fotHKDslBd69DwCXT4qoksDq1zB75d0QIQUN39b14jyjrrv
         9OXoiblg5WDuyRDzlLWcB23M/qyJeKZDAbrsB0TsA9M94nbjAHPl7s63jezdrltQ1VNR
         5p/C668x8w/9bJTRx27veww9HUMVpJ+DAahZ9XfaUeAW87fAnRaBSHRSSVtibnlJIcdm
         BcBSOuuIthTGSbccV8+f9ku9+tEg5fR8NOVSROopivfqjcm2efbyVkkEB8mFzTkGFRtp
         spaWfkkVSsfRAoFuf7j8PNb8dbKyJYmjXwBJNSS/p4V+LTr17fDInRuHw6ineZjCYNKl
         +dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951974; x=1774556774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sq7pLRQgbUoZPtACF262weOXRDH8/ti4RFZhN9vDeZQ=;
        b=aoQjVAbOX1/Wr4pX3zEUOSMT+ym84/PlhgiUits8CVc4UU4WDCJAbOqpiUIWRrMt/Y
         2FIg7AJF8n3dqr6K0TNIxAK5V5O5Fo7ujs8szFPDwXVx1PLlHwlvAoFKhmbYzfq4fL+V
         dW30cErZKMkXbgG2njgnwnEE0rahhpN60EC0NL7NRZd1KlhKdn4UaFilHPKjy8pMSi88
         VIWfSH/d5aCPoLYe+Wi6wajloieieLkBZ7wF0d3midlNfP1ivuq5/hTQpTiZDiBlwIuJ
         +IKLewSLxK1zCrLHa64KW0nhhGfw58e7bZJ+a+6k0wWrwcwO0vO09bx4tH0Nj4Vf522o
         MUUA==
X-Gm-Message-State: AOJu0YzhiXXrHMxz5gAN6rujakCwRo/irH4lLRjI+U8TpTnBuGAcmYMq
	TA5/rdgO/NgU/Vy1f7/a0avZtkdXQktUCHNWH9tQzmwMSPafuDTOn/Z5IDcxu49ekqs=
X-Gm-Gg: ATEYQzxrEBBfXxIz3p8HMv+jDkSdFyj7TDc7vuIU075/A8p+SojbulBKwmcOOQk2DOt
	FeNFWUDK3TTLPY8JUCZTLJbY2rabxCDWzYXz/WfiMUvaRHCc3jPGwX1cuKjt+oC4AaoIW2amZhF
	kCldAwX0j91AiYdWPI08o7XtvILo+n9KF34lSt1nSkGEOHTIEf3Anan8fznuUJcymIYKyZuHkoN
	NKbwGT7TBw7/YrASmRXp3uKKvPCcJv2cxIce7gCNTcJNYqZUswNY8xxbzl3oWk7jjiuWImdGqKi
	DtqV3P2oymxpXnUUYgQsw5y/L7lsQXtDpwLkAWJvrCBkZsWKPZ+5a/4yOxl9ESAZodj7FdtgbZh
	19QUBNhbY4H4YZ8nRuT+F00Des/lTUCXJdCA5F3zgvIBSUISnbk3F0gBNxQ+Z+vqZvZ4RLEU6L8
	Y89H7p85czprmHvrOO0xV3HOn0Mu4Wq/VY0MTYpKfP71LBtXJC
X-Received: by 2002:a05:6000:310b:b0:439:f605:afde with SMTP id ffacd0b85a97d-43b6428ae11mr1251408f8f.51.1773951973717;
        Thu, 19 Mar 2026 13:26:13 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.26.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:26:13 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 54/55] drivers: hv: dxgkrnl: Fix crash at hmgrtable_free_handle
Date: Thu, 19 Mar 2026 20:25:08 +0000
Message-ID: <20260319202509.63802-55-eric.curtin@docker.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319202509.63802-1-eric.curtin@docker.com>
References: <20260319202509.63802-1-eric.curtin@docker.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9626-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.982];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5422C2D23C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hideyuki Nagase <hideyukn@microsoft.com>

Fix a potential NULL pointer crash in hmgrtable_free_handle() when
free_handle_list_tail is HMGRTABLE_INVALID_INDEX. Guard the entry
dereference with a bounds check before writing the next_free_index.

Signed-off-by: Hideyuki Nagase <hideyukn@microsoft.com>
---
 drivers/hv/dxgkrnl/hmgr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/dxgkrnl/hmgr.c b/drivers/hv/dxgkrnl/hmgr.c
index 24101d0091ab..059f94307a0e 100644
--- a/drivers/hv/dxgkrnl/hmgr.c
+++ b/drivers/hv/dxgkrnl/hmgr.c
@@ -462,9 +462,14 @@ void hmgrtable_free_handle(struct hmgrtable *table, enum hmgrentry_type t,
 		 */
 		entry->next_free_index = HMGRTABLE_INVALID_INDEX;
 		entry->prev_free_index = table->free_handle_list_tail;
-		entry = &table->entry_table[table->free_handle_list_tail];
-		entry->next_free_index = i;
+		if (table->free_handle_list_tail != HMGRTABLE_INVALID_INDEX) {
+			entry = &table->entry_table[table->free_handle_list_tail];
+			entry->next_free_index = i;
+		}
 		table->free_handle_list_tail = i;
+		if (table->free_handle_list_head == HMGRTABLE_INVALID_INDEX) {
+			table->free_handle_list_head = i;
+		}
 	} else {
 		DXG_ERR("Invalid handle to free: %d %x", i, h.v);
 	}

