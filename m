Return-Path: <linux-hyperv+bounces-9622-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +McRH1hevGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9622-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:36:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C152D23DB
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54A1B30C1925
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DA7405AB1;
	Thu, 19 Mar 2026 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CT91zqyN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6E401A0D
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951973; cv=none; b=X9dSO0CwgJ7R3Zkw7l5sbR2AXChswF5j1FTrpvmXEDyinNQFP/lNg0a0QQK0hn6HnRdcm0dckAaDhpyyXqL0RtoVypFh6OOO+pgvsjQIM3PbKMMix44hxyyAFoS7F5CHMtJou2UJs+8kinF7iHy1rNFTkGoTe1eArlcB0ZppnA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951973; c=relaxed/simple;
	bh=CYzAd6S2tuDyMt904iUrjc5QlAl/T5Oy/hTKXGVuzUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHBM4t6ipmb18QZQjw0Mav7oWbMjt1P18dPK/22ZuA902LUyzZaavJYJpfHU8lVnIGrLmqbSHyE1TUHO9NwG+0aDtr7x5c+DyQ/1tkc4djCjyiBwz9MK/4k6TBSQpXpx7VrA2LefkValyeL9SaPP7OdYvPc37VJENavJQViuCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CT91zqyN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b4d73463dso946558f8f.3
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951970; x=1774556770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T94hCUBCgJxRtV1K3dOdspjWMVTTyxiqKQc25Q0XT4=;
        b=CT91zqyN+dvLLJVIzAYSXQRh+f9gqVxqHrzBoio7Sz8GXzlZZXUpBv5IJnxGrJerhI
         4tuv0wrW5LR+JfjTHAFYAkvpEOzsqlPfUSk0W8Lf0GoxoGxvWBKewkcDkSuOyiRG7YvL
         Y1/+v7+ZrM02ZKp0VzSfkec519gJgMZdCviDBfg4M7jgMWZ8FrkCf7ft/SgOHoVsYQNM
         broSmvavT/A0FC8LLkKV77yTCoU+8e9xx7apHrnaYV5aiDOFl1YeHd7rxCCXT5qYTExY
         1geUP050xKB3CR11DLFFNtelr+ZTAC3gJ7uQfQRSzD/h80PbymvKRLOchIGKhVlSwGaG
         1Udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951970; x=1774556770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8T94hCUBCgJxRtV1K3dOdspjWMVTTyxiqKQc25Q0XT4=;
        b=oIUY+P9Iek32sLCS9+sn9q7nyWrpkkxA1abmImF1wGl4zD9OxD9/i9dFdPL0OF7O2Q
         Ioc7DoB2aG6A8gXIrX+8frah7nJ6G8DHyeRXPzj9n4ZP+ZwWsn+vTjeL8FXUYSuy7eO4
         EsfGnH6qWw9bKoEvO2kM+xjJjXm8HCAolz7sp/aVIQWl2jA1mHZdatoJ+Hmg5uswIzYm
         8IBPPxgyMsJGgnEdPZsbtOwejv62BNt0CAgB4cC1x2BleROyG82oi6rG46WUBBuaX9fL
         f2oKd9VuI20Czv1gXiws7EkYzracrIpToXQIOhrrwFNhL8DwV1o+rKTOFVwNF3pL9VuT
         gnJg==
X-Gm-Message-State: AOJu0YwQzYhbzdxgAzPRpuu/XFKrqJEF6PYFMrszQC9ClSesDlfU/Eke
	NRDLVS0DMHWm/oZ7M22OzUegFtnuJKZ3T/R6QUEMAVzAcCYA0SF1dGrmAuEIymVqZ2I=
X-Gm-Gg: ATEYQzyspvH37NZ2SWvh6JrnRxLeVCceqFdDIJsWZ0hw7F/9cffgIhoKY2obXJ0GcAK
	vDQTwzSjafv+gwZWlftuS6dE97n8aGs0/dPE7jNQKzTmjaP5O+n2VwawgwAdFsBpU7awdNplgW8
	XoFTrKnl5eWpXR6bO8QnH1x+odrPLbLz3Aal7KaPSfbgk4vQ7vxW83BCMLUe/Z5KOFVMHmr30tm
	k1dnRIOp21E/bMCcqyJW/Eb/ac6BuX0rU2OyMrFPgOPGbULyfXM2xWeHkrJAltJa7xp8PXo6Z5P
	jhZNUjEyAVkghTiFtjk03KPSU3nX2ciIAgyPzAcgeePHIf2wou9uJO826iB1tOtJ9fRTeF26nqa
	65pt8eFnvmbkxa9s5q3XpFFbvDjUrZZr8QlJaiwyPVwZ0mG5yHwk6ha2iwemudnRCxkGUF1XTxV
	pP4Taf7XfoxOIX8OsiBNINBcZeO0fJC5FXT0cNkLa+X/tBCb8J
X-Received: by 2002:a05:6000:2203:b0:43b:46b6:87aa with SMTP id ffacd0b85a97d-43b64277e1amr1210039f8f.27.1773951969551;
        Thu, 19 Mar 2026 13:26:09 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.26.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:26:09 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 50/55] drivers: hv: dxgkrnl: Fix build breaks when switching to 6.6 kernel due to removed uuid_le_cmp
Date: Thu, 19 Mar 2026 20:25:04 +0000
Message-ID: <20260319202509.63802-51-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9622-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.982];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: E9C152D23DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

uuid_le_cmp was removed and needs to be replaced by guid_equal. The
relevant upstream commits are:
1fb1ea0d9cb8 "mei: Move uuid.h to the MEI namespace"
f5b3c341a46e "mei: Move uuid_le_cmp() to its only user"
5e6a51787fef "uuid: Decouple guid_t and uuid_le types and respective macros"

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgmodule.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 5459bd9b82fb..e3ac70df1b6f 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -762,7 +762,7 @@ static int dxg_probe_vmbus(struct hv_device *hdev,
 
 	mutex_lock(&dxgglobal->device_mutex);
 
-	if (uuid_le_cmp(hdev->dev_type, dxg_vmbus_id_table[0].guid) == 0) {
+	if (guid_equal(&hdev->dev_type, &dxg_vmbus_id_table[0].guid)) {
 		/* This is a new virtual GPU channel */
 		guid_to_luid(&hdev->channel->offermsg.offer.if_instance, &luid);
 		DXG_TRACE("vGPU channel: %pUb",
@@ -777,8 +777,7 @@ static int dxg_probe_vmbus(struct hv_device *hdev,
 		list_add_tail(&vgpuch->vgpu_ch_list_entry,
 			      &dxgglobal->vgpu_ch_list_head);
 		dxgglobal_start_adapters();
-	} else if (uuid_le_cmp(hdev->dev_type,
-		   dxg_vmbus_id_table[1].guid) == 0) {
+	} else if (guid_equal(&hdev->dev_type, &dxg_vmbus_id_table[1].guid)) {
 		/* This is the global Dxgkgnl channel */
 		DXG_TRACE("Global channel: %pUb",
 			 &hdev->channel->offermsg.offer.if_instance);
@@ -810,7 +809,7 @@ static void dxg_remove_vmbus(struct hv_device *hdev)
 
 	mutex_lock(&dxgglobal->device_mutex);
 
-	if (uuid_le_cmp(hdev->dev_type, dxg_vmbus_id_table[0].guid) == 0) {
+	if (guid_equal(&hdev->dev_type, &dxg_vmbus_id_table[0].guid)) {
 		DXG_TRACE("Remove virtual GPU channel");
 		dxgglobal_stop_adapter_vmbus(hdev);
 		list_for_each_entry(vgpu_channel,
@@ -822,8 +821,7 @@ static void dxg_remove_vmbus(struct hv_device *hdev)
 				break;
 			}
 		}
-	} else if (uuid_le_cmp(hdev->dev_type,
-		   dxg_vmbus_id_table[1].guid) == 0) {
+	} else if (guid_equal(&hdev->dev_type, &dxg_vmbus_id_table[1].guid)) {
 		DXG_TRACE("Remove global channel device");
 		dxgglobal_destroy_global_channel();
 	} else {

