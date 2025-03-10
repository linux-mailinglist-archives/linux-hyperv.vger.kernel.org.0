Return-Path: <linux-hyperv+bounces-4324-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534ADA58AEA
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 04:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792D8169487
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 03:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786B15234;
	Mon, 10 Mar 2025 03:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H11J43mG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA61328F5;
	Mon, 10 Mar 2025 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741578734; cv=none; b=GOSF3txhxtWXzahP2c5q/nJxGiTHMhzcTdTTY/zMtUpR0PL1KEDdNTwF/9PJWbhx3cVoxtq34hc1qCZA5yHH7wteFWtwIEf2S89p5HvuaLW4aUPPYEmjUdwkxhCQQa5JEjO4DyrGbOznIpw/pqrHf4ZXZ/fl1D3IorGAdUEjpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741578734; c=relaxed/simple;
	bh=GLiTXk3xqNdxw/6RPWiBD/kVhU+h7XMkKggEyjYKjYg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Zp3NfwyAHCatWLihW1tM6vDBUcMg2FDc5i5o656DW8fWGCehzUEvVUeaKgmNTvjdXrKUMjr1crAPpzNm7vtLmx7t6Z1oBTZIT6qEYZFUKQFlitTMiF0HjbSJwFPnu4PuOYPbQ0RAO4vrXsN8zYg+pxpxK/sYkDWBpTK24jRuugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H11J43mG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22337bc9ac3so69853035ad.1;
        Sun, 09 Mar 2025 20:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741578732; x=1742183532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0IGnM/XG5+syEQeucL9wjoemJeMGsLlHitsgC8cCCQ=;
        b=H11J43mG+HnPNHOqcf33k6Nfm2JXhIOwipw+truD0baQ8Y/hdk7fpVgLWU5KMmg7/z
         rFsM2Eg56vyV2CM0P7kzsZklgp4nTBGLZIif2Ie2VAaR6DnTswPUnLzsA+7+2VYK1Sig
         oVVZgPORzY4lwDyCopp0BNRQW2v4DdpF6MYnAA1O3qEeXmmsJNRaGt7SGQubpYl7IAEs
         LSQTg8vmG5/S+UEmuoB93GI8N9RDv19PIgUwGQ+GsgGoJJokn1+voG43q9Yt8TPV+GR1
         e8+mZk+oGBvpVoh4etwQE4QtEffJASCdQ4YTj/ipfRfcQiD58EBm1lDC+GpDnR8Hxn/g
         BkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741578732; x=1742183532;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0IGnM/XG5+syEQeucL9wjoemJeMGsLlHitsgC8cCCQ=;
        b=TK3HPfwwccJ2CN0n6Nz+nwiRvBy0+2PE6SCfqw2D9pN6HJuedObXn6JA9PCatlWGqF
         kJRXQIe9h58gu1MHzPOvEuJVktIzaBqrvdtJYuCSuvkyTxdYs+iVOzwLlvNHy/cAhQp5
         SsfdeoyMJ3mGleKX+KrUeyjYj5afmVSkGgP8ChdRv5hHOsEMSEfHyiDXn2d36bEeGvn0
         rtwrdl+OHWvAU92ABzmuPCr+lUv3vkQ2wyyrIObImrELSPk4gWpvwbx9RTeP5e7GWggy
         bjipZGNygLobTY5ZwmhcXSfYYCeWyvohutlKTCkMvFUNhXlPlz1QD1OTmg69Ou3zAive
         hc5A==
X-Forwarded-Encrypted: i=1; AJvYcCUFLDtbZPqdcqFwapG4nIkkTeeItl9myUrecp7LXFr6tmh4Ce/RG5yR8Fje+ofuAZLxVQNJP3LenlG9ju0=@vger.kernel.org, AJvYcCVFdevaxqCqxhGB+KNvKa5eFP1jn191ORLm2rpFlhUig3CdOxDFoPteCD4OhkmPXh+lARXL/NUhJbqeGdX8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/DMS8wsehI+ovBFJ4Ez1ERad7D4x4tr6CzeoEhHcS+/h+qSH
	tMaZ9O1g4EPMqQdugwxK3j3G37dScGno/g0Rs9XLmyRuPAK0hQROC3dgNw==
X-Gm-Gg: ASbGncuxE6lxNc6FrH1mgbrXgrkLYc1H4r5BqFaqW/MNJS1WA4qbDi+MXMcys9NNnvZ
	WZTi7sun9Fn5mVI4zJwAP+ZmBNrCoZpTVGEx2yv47PkCTO2PY82kjLh9dm1ofuo5oNRQDI0I0BM
	fiDlrEweAv9hkexyvDE1lO97v4uPSNswXmfP7X9AhuNYEY3Mq+nxhX9yC969T5ljxaZQfE5E1z0
	huuFWAWSFCyOcmTvuw9JDY/T6bvNnpSZxOkZf2OolI2m9lRWyOTpsFoQeGKwvBUGTSbcqYaA9Fy
	qLUuTtGrrMj35Igs09GOmnOYvRCbpWRO70fckFHkDa06jfM8D/fvziUMbytJcTo+5Ikm6eF2B9Q
	9n8WB9ovjA0zIlb/skftyvNs=
X-Google-Smtp-Source: AGHT+IHwWnr0i+ZICikVKHp28qKVCYb333XNjRu81K4pxDILjsPoZMzDuJo+QxrLuBCMoDAzD0PfHw==
X-Received: by 2002:a17:902:cf41:b0:223:5e76:637a with SMTP id d9443c01a7336-2242889c67bmr193099635ad.23.1741578732082;
        Sun, 09 Mar 2025 20:52:12 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa4a79sm66838575ad.214.2025.03.09.20.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 20:52:11 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	kys@microsoft.com,
	jakeo@microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v2 1/1] Drivers: hv: vmbus: Don't release fb_mmio resource in vmbus_free_mmio()
Date: Sun,  9 Mar 2025 20:52:08 -0700
Message-Id: <20250310035208.275764-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

The VMBus driver manages the MMIO space it owns via the hyperv_mmio
resource tree. Because the synthetic video framebuffer portion of the
MMIO space is initially setup by the Hyper-V host for each guest, the
VMBus driver does an early reserve of that portion of MMIO space in the
hyperv_mmio resource tree. It saves a pointer to that resource in
fb_mmio. When a VMBus driver requests MMIO space and passes "true"
for the "fb_overlap_ok" argument, the reserved framebuffer space is
used if possible. In that case it's not necessary to do another request
against the "shadow" hyperv_mmio resource tree because that resource
was already requested in the early reserve steps.

However, the vmbus_free_mmio() function currently does no special
handling for the fb_mmio resource. When a framebuffer device is
removed, or the driver is unbound, the current code for
vmbus_free_mmio() releases the reserved resource, leaving fb_mmio
pointing to memory that has been freed. If the same or another
driver is subsequently bound to the device, vmbus_allocate_mmio()
checks against fb_mmio, and potentially gets garbage. Furthermore
a second unbind operation produces this "nonexistent resource" error
because of the unbalanced behavior between vmbus_allocate_mmio() and
vmbus_free_mmio():

[   55.499643] resource: Trying to free nonexistent
			resource <0x00000000f0000000-0x00000000f07fffff>

Fix this by adding logic to vmbus_free_mmio() to recognize when
MMIO space in the fb_mmio reserved area would be released, and don't
release it. This filtering ensures the fb_mmio resource always exists,
and makes vmbus_free_mmio() more parallel with vmbus_allocate_mmio().

Fixes: be000f93e5d7 ("drivers:hv: Track allocations of children of hv_vmbus in private resource tree")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
Changes in v2:
* Fixed minor formatting issues reported by checkpatch.pl --strict
  [Saurabh Sengar]

 drivers/hv/vmbus_drv.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 22afebfc28ff..8d3cff42bdbb 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2272,12 +2272,25 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 	struct resource *iter;
 
 	mutex_lock(&hyperv_mmio_lock);
+
+	/*
+	 * If all bytes of the MMIO range to be released are within the
+	 * special case fb_mmio shadow region, skip releasing the shadow
+	 * region since no corresponding __request_region() was done
+	 * in vmbus_allocate_mmio().
+	 */
+	if (fb_mmio && start >= fb_mmio->start &&
+	    (start + size - 1 <= fb_mmio->end))
+		goto skip_shadow_release;
+
 	for (iter = hyperv_mmio; iter; iter = iter->sibling) {
 		if ((iter->start >= start + size) || (iter->end <= start))
 			continue;
 
 		__release_region(iter, start, size);
 	}
+
+skip_shadow_release:
 	release_mem_region(start, size);
 	mutex_unlock(&hyperv_mmio_lock);
 
-- 
2.25.1


