Return-Path: <linux-hyperv+bounces-9608-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDI/OUxdvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9608-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:32:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CC62D22EF
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B25130A24EA
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF4A3FB06D;
	Thu, 19 Mar 2026 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es17dUGs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8B3F7E63
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951962; cv=none; b=IWz7derySj2H1jDicwDMnPSbjO8dZ2OJd6feUFRaMv2L9yL09XADncMKSInbXLEXjncw3pM/NnATEL0EdKInJjMZscoxFbOMojhBMXRRh2yG4vNsecb9gJp0U6C4woNDsWYprTqwB6DjnoTY2mcTi/Zd6fIk6i8fT8fOaCf1+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951962; c=relaxed/simple;
	bh=TZYhOsCGtU9mKXmRW4NBGD3j+TN7qU+aGKFvmIk5bt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UETJF77pn6dmTEmtFF3UvgTTDM1NdvfXEsnT6t+x55wjNiLjWeKirLi6qt4MFoSg6vCF5SxUZSYS9jXzorcfzJIvylre9bQdESqTXJkf8N4oeo0MS8tavb5z3htqY+lWydl43Pixblp+vjMv1QDvoWdJXJnxE9ERRST8/qF6KqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es17dUGs; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b94a19fdso1130111f8f.0
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951956; x=1774556756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZ5+je+LO/LQ72HVOLcGhJe+wJgOlQLSoEPyelVdyag=;
        b=es17dUGsO8oBhP+TZQemsAsscu0nQSy5Y460KaXUA/GSmHd6AmXumeApSH+LJ5v1gb
         cnbDbNnGWhpct/Ig37SrWfzdJFR4wEo1VQOAd+x0y8pBiGVPBhon5Ub15xtXGmiXsNW2
         TWXegD76WsxLvChyyo5Bnb2tdZPEruliCbLeWlpWu7B4TuItou56sptyWgeu62gkPDBR
         UHi5CYuTfh1VRyUZIwotZ9Aiyp+q1hC/siXqVVw417Pzpd58JBiTTfdI1XMZj1711upd
         E8ETzAY1+4d7v+qDNqP2zYNZ5o1ub0b884nZ2k1+8xX7SwhXj8nG2b+j06p0KSkb2rO7
         Qf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951956; x=1774556756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZ5+je+LO/LQ72HVOLcGhJe+wJgOlQLSoEPyelVdyag=;
        b=h/Cs3wL9TwoFNOfDLN+F6puQrPLLNsSt2gtR9TdLgOD/rcwZGoxn0RVZ1+0g2O/fS9
         3e1MkDcqQDmu8jSpER+VJ/FGHvFvF9v1kFGLQ2Ry4fXNUhIitxkNj2T1WHVAZyJbuazC
         /inxtmqYo9+LQ1igLwCcKX9Yx2hdOQlini4QR4l5Dd85V7et6uWNPkIAox/kWa/GyxdE
         ScoqFrl8z7oPWYIGamyarLNEF6vPWri4nam+otyuipJSFhN86/mC/eFm6INvRVkq8BxS
         J2B8sHNbg+YI8cglGJnq0DaDRKf1dVPRGtUqCdqVMioXToTG90RQI8SCIvO/4m0ICppU
         6lXQ==
X-Gm-Message-State: AOJu0YwGpuy5w09hzcO6OMcMfuJtHgnDscuj+RpVcwmrcAHQ5Cczf7iv
	cSUvOjmsdqN+TMnkwEHCgnylYdGwHpTFwiM/wk3i++SRj2pT5X/cNOeuly4UzFmVhFM=
X-Gm-Gg: ATEYQzzF/lzermy+a4TJoqa7oR9lSB0mvixvdBnke7Mmd6M1zTLSs0uhnUb0JZfVQU5
	hJ4zl5WI6qt4HQ59gej6imOdx8miC5lP0w82OYbaVfShYRJHRwA6mAgSH9ZstF41JNPibYW3Iaw
	Z4bfR3hgP+Quqm/bEZOPqmWF0h/PR0VDeB5pv32XiiXINIu9WES2o2u6ZXI9RrOLgD44wWoxB7M
	+8H3N7fBO3ussKa0toPiGwesluv2oA7yzM51FvQf/CE2830vsdm9lQrBLbCYxXrExS1wtz51OK0
	iiSGaFo1IbYzAI1cZa+hm1tQaicMkIxoTvtmHZUh4nxpVb2n3Kri372CDaMB3zx5F94jJzgrxJj
	tg6CP0FXzWUmkTYO9q73j9Tq6/stwkPeeL3ARVCRSngdYq7RcNTgUUIH1TetQOAbRrW4OnafHTS
	k8bi/eQll3NMKpibmuSTITc6UNGsCr/vzbQAQ0mLE6XwYvij5S
X-Received: by 2002:a05:6000:2dc2:b0:43b:5094:a9bf with SMTP id ffacd0b85a97d-43b64263f98mr1152697f8f.29.1773951955459;
        Thu, 19 Mar 2026 13:25:55 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:55 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 37/55] drivers: hv: dxgkrnl: Added missed NULL check for resource object
Date: Thu, 19 Mar 2026 20:24:51 +0000
Message-ID: <20260319202509.63802-38-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9608-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.983];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78CC62D22EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/ioctl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 69324510c9e2..98350583943e 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -1589,7 +1589,8 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 				&process->handle_table,
 				HMGRENTRY_TYPE_DXGRESOURCE,
 				args.resource);
-			kref_get(&resource->resource_kref);
+			if (resource != NULL)
+				kref_get(&resource->resource_kref);
 			dxgprocess_ht_lock_shared_up(process);
 
 			if (resource == NULL || resource->device != device) {
@@ -1693,10 +1694,8 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 					    &standard_alloc);
 cleanup:
 
-	if (resource_mutex_acquired) {
+	if (resource_mutex_acquired)
 		mutex_unlock(&resource->resource_mutex);
-		kref_put(&resource->resource_kref, dxgresource_release);
-	}
 	if (ret < 0) {
 		if (dxgalloc) {
 			for (i = 0; i < args.alloc_count; i++) {
@@ -1727,6 +1726,9 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 	if (adapter)
 		dxgadapter_release_lock_shared(adapter);
 
+	if (resource && !args.flags.create_resource)
+		kref_put(&resource->resource_kref, dxgresource_release);
+
 	if (device) {
 		dxgdevice_release_lock_shared(device);
 		kref_put(&device->device_kref, dxgdevice_release);

