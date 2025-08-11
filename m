Return-Path: <linux-hyperv+bounces-6512-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F272B1FED0
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Aug 2025 07:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FC1189A6B2
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Aug 2025 05:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F994270545;
	Mon, 11 Aug 2025 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HagoNJBb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574726E179
	for <linux-hyperv@vger.kernel.org>; Mon, 11 Aug 2025 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891495; cv=none; b=NijeawoZANvaBbXQHRu90GQqCQLZeA/uY8q5KWzAhMYKxqhI6buwUR7+EXfXsJvBqm8MQWg4//GN4mWzAM8SN91e/xcEbUrjTIqOBScQeGBOKJu+umLmbtqXEgam2ri7TIdSa32EXITvF/h1MElnI03Yejb7CP9c5iOs1sGVoco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891495; c=relaxed/simple;
	bh=0yp2V2VVk7SzKuFUi/ZVfl/o+NZ050J3YB1CuCwPaGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EUU/FnABQAHlW61cZ26swXT7QMSvq/lJ1dpKZQCWdOwZEb71TP3pG1K4j3zxDBqfKNpWDn02ICTEDtmJPyjpMb3JydL0NvViWkhumd3FCpCheq/goOgFR7VA8zErqGyUel3A6pfdZQpE7h21U+UDV4v4o2eyqFbUowoG5moO0p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HagoNJBb; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-b34a8f69862so2799402a12.2
        for <linux-hyperv@vger.kernel.org>; Sun, 10 Aug 2025 22:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754891493; x=1755496293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FGXD3kaHwd6Vj5dcpPpaYy6WT0iTxp+nQotnuFSJvo=;
        b=cRVMVwsysWAcdt+fdJDyn11IM0xOSfqy9lBY7/bSvZYVSOoCzdbOAXZyOqJJ01IdnV
         kumwn0LgrPWV331Ft8ajvDfobF0A9XalTipVW0rh+VBYUzblDhoScPsxwrWuTA8CgLwV
         EgiOTYsXi66pxo8QNvnNCpk6uAMZP2WoT9irjvDCAoP37bEujnc2Ms5Gyg2shcstgGjD
         gAyJPfatrT+FxwtN81merJSXeu8TaWU1PTb9xtOdnGTYRnAAuwI5PTaJlE8l2ZvTh5+t
         ZiQKkJkfF1QuZXKOsrCz7fSMOyEauBWrHWcngvqO2jCx34y27Cqc6vi18zJGSBqCqK/E
         r0tA==
X-Forwarded-Encrypted: i=1; AJvYcCVLN286IfZNUw0gvVBHWI8ALamcp2L/GWuDworgBIvD44QKj1kcxCVxvbi+Zwxg74yMhQIeLY+RSDO3ZT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKYQ0evCfO2ZauuW1Wb9nelC5ySG3TxacwYL8twEyw9VDANvC
	o1PtsW8v/z/ubR2M9M7B+ABynqpXOnIPjKJ+IJg2Q4disNQRgfK3nwINOw8o577ocwLzE32cFYC
	MvhVqH0MF2IVCr7QvvV8PQLszrrjKNFonat/aQQQ5Ur9rPhepzbLKqefvlEOsVnVIQcqgg84hmQ
	0qatwikH50ad2wRQaYOGLD/S8GGzyZ+aRJuu0oNZuyySFBrihaaWSjAh03kTnLl3BXaG6OacR0m
	aSrGhr05WTsGSYvwnpppa83QA==
X-Gm-Gg: ASbGncvXPb6EmecxD5k6e4MkecnHK+gxp6UzCeDjwkXMy/i0TJbnDIRpV7kq2v7wSG8
	w3Rw53zGmICZqQ+fHjC7buMN1kqm5gl/dhYmZRW9i0YQ9DNkLZuKzOEiJvhsEr1Wf98NSaWas3E
	ZDD8tD1qXNH1kFkf990So+wvfsT1Rsj9cDMBvvHrBxuwS97yVhR1XzABER8CGRiTSWRNK37rLL7
	Fy/sc/gjYrzA29fGHCA2LN5vbz6IJxiVrca2ccNaGD+XZuRo0mUb5mm4kq5sEXivTPBhd8zRg6M
	RklZ4Ft9CWVxu4PuS/daJnbfkdWHwkhaqBHHgbf4PzaESleJTQccE/2uKjSa1Yp2MvXJyl9oyZi
	r4P9jNKo577/I2Nu6dJPR9Ri+4+NQDBDLuIb3SxSF4wmVgZbZwc1C1/ndzvx85CCaDhJVposqlF
	TQX+e2Ew==
X-Google-Smtp-Source: AGHT+IG9oKZJxxQkCakLC+6cx68VQ6gy9K4ZgAZ2XEJOdtrCQZEkLaOv0JfOApvhL+dAps68S4AvCFBmxhF1
X-Received: by 2002:a17:902:e5cd:b0:242:9bbc:3646 with SMTP id d9443c01a7336-242c225abdamr178662405ad.56.1754891492235;
        Sun, 10 Aug 2025 22:51:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-241e899b59csm18172485ad.73.2025.08.10.22.51.31
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:51:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70732006280so80728516d6.3
        for <linux-hyperv@vger.kernel.org>; Sun, 10 Aug 2025 22:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754891491; x=1755496291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9FGXD3kaHwd6Vj5dcpPpaYy6WT0iTxp+nQotnuFSJvo=;
        b=HagoNJBbvs8WLIpLTExqvMa5PlAM3qXlrJWy6cq0p7jdveH0Jmk+/H+B7XHZ+y7nx8
         /Fp0ti8epILIQgjZGX4WGgJ+pwRksrsuUpJbCJmNc0LYsRPP6jGhpgGwoTOJzzoH5aOY
         IGKoE/Cs/J7G5FGHJKsXelDTXPeVcP9hWWlXc=
X-Forwarded-Encrypted: i=1; AJvYcCX2HyUEEt90ZKQgfh5k2SmeQe4Oju8gQLHqcmne6kEBDmV7cofJgQwWIBnvFNC3Oy0f8zRZZ62iBXBwDCc=@vger.kernel.org
X-Received: by 2002:a05:6214:c83:b0:707:bba:40d4 with SMTP id 6a1803df08f44-7099a1b9ccfmr151427586d6.11.1754891490827;
        Sun, 10 Aug 2025 22:51:30 -0700 (PDT)
X-Received: by 2002:a05:6214:c83:b0:707:bba:40d4 with SMTP id 6a1803df08f44-7099a1b9ccfmr151427376d6.11.1754891490332;
        Sun, 10 Aug 2025 22:51:30 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9d6d6csm150672406d6.4.2025.08.10.22.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:51:29 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	stephen@networkplumber.org,
	linux-hyperv@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] uio_hv_generic: Fix another memory leak in error handling  paths
Date: Sun, 10 Aug 2025 22:38:08 -0700
Message-Id: <20250811053808.145482-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 0b0226be3a52dadd965644bc52a807961c2c26df upstream.

Memory allocated by 'vmbus_alloc_ring()' at the beginning of the probe
function is never freed in the error handling path.

Add the missing 'vmbus_free_ring()' call.

Note that it is already freed in the .remove function.

Fixes: cdfa835c6e5e ("uio_hv_generic: defer opening vmbus until first use")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/0d86027b8eeed8e6360bc3d52bcdb328ff9bdca1.1620544055.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/uio/uio_hv_generic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 6625d340f..865a5b289 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -306,7 +306,7 @@ hv_uio_probe(struct hv_device *dev,
 	pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
 	if (pdata->recv_buf == NULL) {
 		ret = -ENOMEM;
-		goto fail_close;
+		goto fail_free_ring;
 	}

 	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
@@ -366,6 +366,8 @@ hv_uio_probe(struct hv_device *dev,

 fail_close:
 	hv_uio_cleanup(dev, pdata);
+fail_free_ring:
+	vmbus_free_ring(dev->channel);

 	return ret;
 }

