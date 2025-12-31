Return-Path: <linux-hyperv+bounces-8109-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F2CEC87C
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Dec 2025 21:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7016F30275F9
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Dec 2025 20:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EC630CDBC;
	Wed, 31 Dec 2025 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOLtj1i0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A030C61D
	for <linux-hyperv@vger.kernel.org>; Wed, 31 Dec 2025 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767212098; cv=none; b=NNn00jufy9P7NbbGyTLKIzYjcoXZNIDOrE++G+qD1d7GBF9WZAF/YSYaN/EyiYgKekil9a0T+UNAm94T+0weR9aVEo5pMDRyAZmh2rsaNpYp2VJSkzsofc/vusCLpzW7glAxBq5qmSiWsrP1PvO2Cz6nHkE69hWLbqbF1ofo+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767212098; c=relaxed/simple;
	bh=j0wRfTvsE3CxZN9SSW6iELNAOxMlcXC+gSziMxUme8w=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=sdvDqENdpHYK8lgI6Sk8qfSkgj7IJjsmKxWz/YV3CliLQaT3IWkgU3jv/ZK9m3Lw3RJmRG5YjV0JXFQ8DWNhHHxAvWAc78+yVNQDPS1c7/pcDGUTk6x6xqxPxIlaU7uWlnZWPxnFaQDnm8Mi7+qYec4DscS47Gc02o4zR7cxbd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOLtj1i0; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34c30f0f12eso7555495a91.1
        for <linux-hyperv@vger.kernel.org>; Wed, 31 Dec 2025 12:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767212096; x=1767816896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QjjOf9ISUEjvSrNS2kHfZt2DoH207uoV/5FX1VQIGi8=;
        b=VOLtj1i0LaujZfffGP30SjvhpQnA4M/yovAQc/ggxev6fb+3NZJ5cl7se9LbBc3l72
         S7t7t5Ocm+OYttnW1D69e8EPjAMg6CybItZb733+8cjPA71oju2jegVSoA2DgSSa2uRg
         rf+DEzrUN/o6xhcxgdDrZlUbpEISfMQbo4y9hqx/7VEeXStA0HXnEyOLTQANyGjuvL+c
         khQ96GznLn+uEZidKSV4QQqlwnBQ5l3NIWRHrFOzlHhBKZRIJ1/oktcXMm1XOOPKheZZ
         Cztbd4sleFTK1cYntV5xZwUTyu0MHpe3NHoPdWOK2X3GO2bbKiIdSk9tzPKTS7fn5sfQ
         XEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767212096; x=1767816896;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjjOf9ISUEjvSrNS2kHfZt2DoH207uoV/5FX1VQIGi8=;
        b=jG5aWmInaEyTiFRejLXAn1L0z8dowyUtgj3DKS60Rt5RItQXh3HZ8QUjPZSeSWOGeh
         sIIOFguKaN1eBV3tsF5htA0FGt6AH5QwYUbD5sILwh0T2R3/hLs3CtKjxse4FSpXM2Ou
         T3u2pYrcvnpanNIYqEDMRqrCAFFqBSpRQEQt+o8A5S9B4C3Hfn4LyYK/lDJlfR3JyysZ
         K31mjnl0VPaGf7wyYAr2Vh0j4qhjqtnLlhEfSpa/I99cefwFuQQDrDZWn6L8YUWwM7d7
         SsM0k7dlU4wnOZ8YDwDIc4HyKQOZh6vGR4MK45gLoEwVocVbEFKDQdhtClJ3MTY9+Lna
         2otw==
X-Forwarded-Encrypted: i=1; AJvYcCUYxBVwiWzHi3000cwcXOPfoQ7zdHN7WFACBG/4tJzo6g3DgeRNFs6InAkCErB7o6zByhI19sWBC2yVgLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm8nyAT6T4rULpzDbd3LPZr6xGxwohehU7rp3cXUWHEGLgdu5y
	311G+CMtveoIPIrkR11hvwsN49x1j3Kro/2w/m67rVpSZWS1FQUto9AV
X-Gm-Gg: AY/fxX7HtlYIeJEDLqcX90a1frvi/obku6LlRXPpomZfwQrJXBTIyImyFKn2bj1LDXT
	4SV1jonVOmpWGkZfeTOv14v092ek4i0d5uZQduuEayJjlBfZJNdtnzhceU4ioaceU2X+v7l012F
	Bh608AuwLShbuUmnGU8Qt/uMeitVEUySU5ts4vnDeJ/9XF89Mmyobhf+uaPNhtKJrB8EL+hf3c5
	I7TBmzCobSbQnd9jPa94m3NKUy4KMGqXk5BSNU8L7edD+ruI/PPiTomZonncWuGD9aTq7J/eKwM
	fYYNd4z+nlu/mbsZi2q1H+lUUpZehU7cIXGLSV0k0ny3kczwRtkeJvXsHI4yzyv7r+6lKgJeYOz
	bc+IvGVAd7dteZ6Ha45bWZvj7VYecDwB3vXMY84yB66mtSHR7RNKMp9ytOZDA+N4VVqkxR/mM9U
	BXOLnUOYVq2bne70LZA1fNRhE/sYHErhoeMcYjoUojFxycEtHmgtUsSOgGj87dJcU6mQ==
X-Google-Smtp-Source: AGHT+IGab5+rD5sIZ7CYNyMfJQ8VF3fFUkJxP61LuyWALMhlD1CwP+/WCxLmCka21AwrSfOntggNhQ==
X-Received: by 2002:a17:90b:5804:b0:340:2f48:b51a with SMTP id 98e67ed59e1d1-34e9212a47fmr32583952a91.15.1767212096411;
        Wed, 31 Dec 2025 12:14:56 -0800 (PST)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48cea1sm36673718b3a.45.2025.12.31.12.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 12:14:56 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	dan.carpenter@linaro.org
Subject: [PATCH v2 1/1] Drivers: hv: Always do Hyper-V panic notification in hv_kmsg_dump()
Date: Wed, 31 Dec 2025 12:14:47 -0800
Message-Id: <20251231201447.1399-1-mhklinux@outlook.com>
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

hv_kmsg_dump() currently skips the panic notification entirely if it
doesn't get any message bytes to pass to Hyper-V due to an error from
kmsg_dump_get_buffer(). Skipping the notification is undesirable because
it leaves the Hyper-V host uncertain about the state of a panic'ed guest.

Fix this by always doing the panic notification, even if bytes_written
is zero. Also ensure that bytes_written is initialized, which fixes a
kernel test robot warning. The warning is actually bogus because
kmsg_dump_get_buffer() happens to set bytes_written even if it fails, and
in the kernel test robot's CONFIG_PRINTK not set case, hv_kmsg_dump() is
never called. But do the initialization for robustness and to quiet the
static checker.

Fixes: 9c318a1d9b50 ("Drivers: hv: move panic report code from vmbus to hv early init code")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/202512172103.OcUspn1Z-lkp@intel.com/
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v2:
* Reworked patch to focus on always sending the panic message, with
  resolving the uninitialized variable report as a side effect. See
  discussion on v1 of the patch [1]

[1] https://lore.kernel.org/linux-hyperv/20251219160832.1628-1-mhklinux@outlook.com/

 drivers/hv/hv_common.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 0a3ab7efed46..f1c17fb60dc1 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -195,13 +195,15 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 
 	/*
 	 * Write dump contents to the page. No need to synchronize; panic should
-	 * be single-threaded.
+	 * be single-threaded. Ignore failures from kmsg_dump_get_buffer() since
+	 * panic notification should be done even if there is no message data.
+	 * Don't assume bytes_written is set in case of failure, so initialize it.
 	 */
 	kmsg_dump_rewind(&iter);
-	kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
+	bytes_written = 0;
+	(void)kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
 			     &bytes_written);
-	if (!bytes_written)
-		return;
+
 	/*
 	 * P3 to contain the physical address of the panic page & P4 to
 	 * contain the size of the panic data in that page. Rest of the
@@ -210,7 +212,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 	hv_set_msr(HV_MSR_CRASH_P0, 0);
 	hv_set_msr(HV_MSR_CRASH_P1, 0);
 	hv_set_msr(HV_MSR_CRASH_P2, 0);
-	hv_set_msr(HV_MSR_CRASH_P3, virt_to_phys(hv_panic_page));
+	hv_set_msr(HV_MSR_CRASH_P3, bytes_written ? virt_to_phys(hv_panic_page) : 0);
 	hv_set_msr(HV_MSR_CRASH_P4, bytes_written);
 
 	/*
-- 
2.25.1


