Return-Path: <linux-hyperv+bounces-6511-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19726B1FEC6
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Aug 2025 07:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 472A57AA8DE
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Aug 2025 05:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DE326B2AD;
	Mon, 11 Aug 2025 05:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hu/xsv1l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33FF26B098
	for <linux-hyperv@vger.kernel.org>; Mon, 11 Aug 2025 05:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891434; cv=none; b=JyBqBWf8nF6elBHz7LXPP12SYALpnwwl+qTrSzvS69gPDGaKqNp1MYVJtnOMOibS6gmibAhKaz9Ym1AAG7Rt51FOhptxZocVplvGldcj+pu5Oc9zFZzCXCMiXkmRazDYe/h1o2VdZguHbyQBZhppl22tfg7anSjCSHLhkAqKJ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891434; c=relaxed/simple;
	bh=0yp2V2VVk7SzKuFUi/ZVfl/o+NZ050J3YB1CuCwPaGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WzRUj1ZI0cUVjObqYTsRV0oAu3w9T6j9mEu7WW+PQKCPrGB7VBMBQFjWmtiPmTziZeWbXmZTBRmGa/rjmaXuJi/DnCBrXNNU710vrKTnb+gzDPAxRGI4fix3Ea5q69HyRmQta26RZdCY54fZEFwTxmd3QFXFB0+8CWwXIspatlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hu/xsv1l; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3e3ea9e8154so16273395ab.2
        for <linux-hyperv@vger.kernel.org>; Sun, 10 Aug 2025 22:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754891432; x=1755496232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FGXD3kaHwd6Vj5dcpPpaYy6WT0iTxp+nQotnuFSJvo=;
        b=tN2Mkh+RG7/zRfQylguKXE9rets53YpjtFhZ1jE5wWWhxavxPtASpAuHXwH7KHvPds
         yturIqcjziW9hqDw6PiYdrmRdMnN3KNIQ5MPz8zSX+OJqIuVfR5maXzmZtdxvzdYI3gK
         dNr+L7m2WgI1YSGwC1CsBhrxAL8M7LuYg49Zf3CgX97tIRpuUu0lSTpH7AEuOpKDSraz
         p/9SbrgErzorqjbf/7evR65sb5tSZnUsj0Vj4mMRVlONnBigU+ICjzlS0W2c12/yRYy5
         FQnBfFVzgxnX9eE3EbWUfI7iwVj0jKrtayS7z38nv+n8kF151j4g9WNJwi3ZtPWjsUkD
         aB4g==
X-Forwarded-Encrypted: i=1; AJvYcCUFmhCmWK6akwkcIYJiIRsTRI8gnJgSp5dZQmwg8xij/rsSx0Q+JTcWXTB/oxAcR+N3Oo4z2cSIWktlNUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBfNUR/fjJa0Kdp8Gt3r6mpcJF0Fln1Z6fG2Qfn8CfD5H/r4wu
	nGG2r4YXRYjcfp1CDsRheVnomD+zblfILZgt9dR9v7/qTtrHMzBbfTkh+bitbn2zD57NFmKAbXm
	Q3w0nhNOErpK2LE2LiNK6LAXgwIDhUc9r4QdQrZwkwED+IrAULPSiZBVxRY8Ud7Htg21P4ZLG3u
	4n87Ow+2DgPf4dT31+dTUKk5IJwKCL0ryACYfIkjXvUJhZK6IFW/A5OG7O3ORi+cE6r3NUXrKAp
	HFtC1tdinXz32rdU7q7eIbkjw==
X-Gm-Gg: ASbGncvuLx5E09xZB6VZp7ebMSd1+n8WtDGjo3Ywi/Y7Hvu1IhwMmGxiPOt15NuGIlY
	ErOyJYUcR7RSi5b3FysYV8j8wLq6kfVakOl2vnxRDRk8YnFgXdRVFPJEJ0M0VIAXEFUZ2eRZfjl
	x4H8QcKT2rlj57jnuXVL81E8TnTVG716bdPdfjx9VrMYfbaj8ruWDxzNFU0GSDTfE/8Ban31NNK
	FNqZqbyX0HifzimD3y2cue1FozBJZ0UqxVc8B2w5HORxVCLIE8OlYQsslbi9zB3anOKhc9FRJPJ
	eGq2XnM+KxsTfiMLKCx5iC8s3iadqx7YRUxgdHypC+H5MUKyEM5+o3AqT5QGVDrXGchg9oknclF
	B+y+DEkPJoILBv4/7ekDY0zvfZcF2CEFGSi4ZLIsz3ltOiUPiMXoIFo5FTPd5y4GtbjVScuvyWW
	nVcgI=
X-Google-Smtp-Source: AGHT+IFA4gqb+xFYmeodL2Od4pwFmGG1yQPElwYDZ0b89vKRvh+46eQue11Byhw3K7yzDQynUvOCKczy/hsk
X-Received: by 2002:a05:6e02:1a23:b0:3e3:ec24:f616 with SMTP id e9e14a558f8ab-3e533196f83mr217095185ab.15.1754891431996;
        Sun, 10 Aug 2025 22:50:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3e533bd31bdsm6648205ab.5.2025.08.10.22.50.31
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:50:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e7ffe84278so851737685a.2
        for <linux-hyperv@vger.kernel.org>; Sun, 10 Aug 2025 22:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754891431; x=1755496231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9FGXD3kaHwd6Vj5dcpPpaYy6WT0iTxp+nQotnuFSJvo=;
        b=Hu/xsv1lHeaKP0Y/TICX/h21gFB3AHPyTXa/2a552THojLnYaoyz5O+I5zAsAv2t2o
         zVi3EyAIpAUlbDL5vKFhi+TTJUMn69EfwKawAA1UCdSbK8BMrbF0ZN/YgTPQ6UW+DjOW
         6lB2nS1uOufa45S2URM/BECqZRg3ARWqIG9WQ=
X-Forwarded-Encrypted: i=1; AJvYcCXxwt2s7i03dFGt5W4BRoyaplmKfdWpzHfc07M2PyYOHBX9IAMydrN5/nZzVlYQkhPbOTIBR3/WQzJ68OI=@vger.kernel.org
X-Received: by 2002:a05:620a:5783:b0:7e8:1718:daf6 with SMTP id af79cd13be357-7e82c6840b7mr1332717185a.15.1754891430876;
        Sun, 10 Aug 2025 22:50:30 -0700 (PDT)
X-Received: by 2002:a05:620a:5783:b0:7e8:1718:daf6 with SMTP id af79cd13be357-7e82c6840b7mr1332714785a.15.1754891430374;
        Sun, 10 Aug 2025 22:50:30 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e8050b6101sm1021477285a.26.2025.08.10.22.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:50:29 -0700 (PDT)
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
Subject: [PATCH] uio_hv_generic: Fix another memory leak in error handling  paths
Date: Sun, 10 Aug 2025 22:37:08 -0700
Message-Id: <20250811053708.145381-1-shivani.agarwal@broadcom.com>
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

