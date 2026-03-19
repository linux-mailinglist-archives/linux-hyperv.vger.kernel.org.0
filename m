Return-Path: <linux-hyperv+bounces-9621-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGmaGfhdvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9621-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:35:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0622D23A6
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71D2F3238CEC
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B85405AA5;
	Thu, 19 Mar 2026 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggnRzfk/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D113402B8D
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951973; cv=none; b=dex0ocXPq3MwFA7RdWOQPQBVoBcbFNHrdVMkGFUMO8hJlNuygH/IHL+cyVL/SxnMlScjO+fXmLB1gTf52mXxPnMKLy3425N2rkCbSivmrpuaT8G7KF49xfvikZ567DrUsA6mrfwaSml/Tb0qUuhdXqg7cOxUz4rONEO1Z81VCGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951973; c=relaxed/simple;
	bh=LFLCyuKa/ngNOlQyHMH67L9xJ7S+T7/bhafBPLwr5Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZmk4luP36QLzHUxo4K6XVkvmh7eq2Lx4CcGe6VL1afYw2cc5I2tFCHWvbVomBUCFrE2snlP3/eSGfkV5fDlAw3IFTYhM6S3evYfsyM2WT4/bQ+u7zJefVJLeJzGhLMs4eu2iMmmWWN61fgWdHENb/5NmVob9xj38KmBjiMYWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggnRzfk/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so1324280f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951969; x=1774556769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALSozRz7iDmiBySUPyDVWjPDIGIexogo2v+RuRQMcPw=;
        b=ggnRzfk/Y8iVr7rrCCHBnOHwnzhneIBnNGHMmUKLS319CPtlL0ReDnnZazHwwcGdoj
         pLxHSG0O/VvsZFNuA9iedRac9zloQSGAGQsKCHweJVYKTLOgZsq3MzY5Xw4p2HgrDxt4
         /ZoAb8a/RRRowEh3qXpCjn7GfgE+Owgb1YQQJptYV4SoSQYjxTvOL56ktvc8zstJlux1
         b32hLCykE1QpEWkHEBuQhJ1Nv7p8WzG39FzamiLrn+0WdyTqUn0VWR2cmyfJGfXSls7E
         kpucvyQG+hjJGV2WWBbYeFSu78cIWKwmX3b19UhpHOgpIYORMyrNmvOhbXHZHi+3Az4V
         xtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951969; x=1774556769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALSozRz7iDmiBySUPyDVWjPDIGIexogo2v+RuRQMcPw=;
        b=rNSi71/X7WQHuzfPKmL6ch+svCPWWq1cfpiuoF1CAJThcN48d1GVJx+IneeCiQAMF0
         3otOSGr6yT8ofaYGvyaNGDajg6M2l5/rPNc9pa4+I0QHyjiHN4o8e7DMUUt18/bz1Iq7
         eugqlRJNEOkeDVcvqrLEab3BJ5T9cFnug6H60PufPpWYhcI6DWYPI3p5m36SMk/uVVng
         g0HymSAUn2+xxTdNE0hnXz1ZqlIOkjGYGPQQ/7QvZCI2D93+zSfVQwq901LGtNdBEPjq
         doqMzUWRRw1Np55PkFYAmxNClpWbD+sP5oSYxzE32CQErO7uctOc6twK0z8gJWAWSk6u
         qoGg==
X-Gm-Message-State: AOJu0Yx6SLAf5AxyXazMzNQ7t+q+yLcDRiqTyjnXx4DFgZe9G9wmL46I
	hOuoa7k6pquFAW3FBYs2kKRAiLSWIY9NWcxcfxBV9HeE4i/rLOdyYlbIEsLKPelexJI=
X-Gm-Gg: ATEYQzyd/zN6pkJhqctmQ+6uWBIjea4tTlCQXn0TDiVyFe92uuWE/9OIYCCkzM3WQsT
	QasyJ52hdHFkNrLtarxoR49r5W3ALJ+Pd1hmED/W4xEIdoIhySboivLZobLeeg4bMNg5FgU1vU3
	h5kOUxfRUV6YxJnmxjjDijmBXXC4LORhDhgAmiT+NgS+yQC8Q84PSicETqewfXp+05sOEbzHKpf
	rYbyopc7sH1sa8UlrF5HugyhvjW/Dpk5F3aHGDIPRQyc8/KP2/L/Tqj2Q9Rwv5gGBGgP53FHJtR
	9U2icafpcyFfB3lFxNwGx0WMov4G1T9H02A1quXHD3MWYmBgxr/6MdoB8zUxy2/0vNQzRfUXweq
	1yCEJjtspyrvfn3dlrUoLjadhLrNuVDQWE6SRez1lLzZkeJ7C5R8e3VoeGIBUEcaSqkFCueI8RN
	GHEynDG5afNFpr33X1hu6AfhTn1mJiw/JAgR55gD1/htGt+VvY
X-Received: by 2002:a05:6000:2089:b0:43b:5356:a7fc with SMTP id ffacd0b85a97d-43b6428b374mr1147641f8f.55.1773951968561;
        Thu, 19 Mar 2026 13:26:08 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.26.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:26:08 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 49/55] drivers: hv: dxgkrnl: Fix build breaks when switching to 6.6 kernel due to hv_driver remove callback change.
Date: Thu, 19 Mar 2026 20:25:03 +0000
Message-ID: <20260319202509.63802-50-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9621-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.982];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD0622D23A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

The hv_driver remove callback has been updated to return void instead of int.
dxg_remove_vmbus() in dxgmodule.c needs to be updated to match. See this
commit for more context:
96ec2939620c "Drivers: hv: Make remove callback of hyperv driver void returned"

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgmodule.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 0fafb6167229..5459bd9b82fb 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -803,9 +803,8 @@ static int dxg_probe_vmbus(struct hv_device *hdev,
 	return ret;
 }
 
-static int dxg_remove_vmbus(struct hv_device *hdev)
+static void dxg_remove_vmbus(struct hv_device *hdev)
 {
-	int ret = 0;
 	struct dxgvgpuchannel *vgpu_channel;
 	struct dxgglobal *dxgglobal = dxggbl();
 
@@ -830,12 +829,9 @@ static int dxg_remove_vmbus(struct hv_device *hdev)
 	} else {
 		/* Unknown device type */
 		DXG_ERR("Unknown device type");
-		ret = -ENODEV;
 	}
 
 	mutex_unlock(&dxgglobal->device_mutex);
-
-	return ret;
 }
 
 MODULE_DEVICE_TABLE(vmbus, dxg_vmbus_id_table);

