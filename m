Return-Path: <linux-hyperv+bounces-2968-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FD896CDE5
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820C41C22A7F
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB5192B82;
	Thu,  5 Sep 2024 04:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkYKxCn1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A11925A7;
	Thu,  5 Sep 2024 04:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509897; cv=none; b=sTTZuPuxY6PDi9IDPry+r6KNR7TI/YkvJJU5+wI5r+eGEy0584D4sBybXpkFgeXDnq2HT2CZvOLL+zWT41WEf8FwnZO1h9Fp4GthrFVwKbUkXO0/t8U1YpWFGPrFpxnds8W8gb37RmCKy1wU1LVYV7j9sKZnkx5WEcUWhL5/ywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509897; c=relaxed/simple;
	bh=komCIO/1EqUhOEh024NdqNhz+3ocvxMCYj+7ZMEMtMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CONYJ2uuZwr3KtlRownIFbFzzYTfQl5To6odufs0lWvazRYNO3A8pN4xbISJ2gfuVUh34UNC/3SHEGbgjI2CUmn4dr97LwK5Frr80PkslmJLw1LogBezfqfSBMrSBOnh4qdJWr2BL1jPhvFrtAuSzaY0KSpcuuegFa+4upK5m0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkYKxCn1; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70f5cd2fa39so271486a34.0;
        Wed, 04 Sep 2024 21:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509894; x=1726114694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nD0rUo0iZKECgz1mfgeWlPajiiX/VTTiXfcH67/TdcA=;
        b=XkYKxCn1A1dEKAtXEzy+NxebodU3P1lZiRzQU6f4Jl8zcC2ZduCAr6KINzvSHsD9ma
         NMqYh2ilpBedMGDxLKKluHe3gGq2yT39Sat9Ut1xoFLBe2e4vjKxeski8aafOwSh5UH8
         Iu9YNrKyKbhISxTEQyf7M7mLTHIAoNcvsEFmt1QbHvzc1tClklYGTg4IF2FYllQpGE9U
         SJ5p2G4YOkU1j05lC24fh8fyP3r5fmf0lfbMSZ9m6CxGy6KJaPXFVx7OAwyS1Z31j994
         mfoUfJ2pAwyJ1Lea92NXBo648mcXitJOdySXcW+TxbzyVgUXbPtnVwEHimxUJq9vy37S
         7JPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509894; x=1726114694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nD0rUo0iZKECgz1mfgeWlPajiiX/VTTiXfcH67/TdcA=;
        b=wadsu93y0ivOHwSzCDoFJ2jEl3l2mWGOzO5hH+j2Evib6o4BY9aI1fzbn5o1LGMM2a
         mZfvb0Vi/9HnF/4mbYdExKyzOH8wztSUOht3wLpamXx+hJkNyF4wWHsAFjbFsK+xwuJw
         GC3WaoqEU9bC1FxXDZDgqUnic2LBte1ik8HCJ+g7SJ3NZV7jTca1mGlrL3ldaAkmHkoO
         OnrW3dAL2TrckTFBA5UrcQIcciZYkvCOPjqlm1z/oJ2BuA5Uhtc/WcNFVw3z5PwtSoDS
         ODWCatuF3pDSxJKtdtn8obdGRwv8e1yebAG//OiFfT4/o53NHpf0NgS1mfwE1GUG/iW7
         JzDg==
X-Forwarded-Encrypted: i=1; AJvYcCUOTe1mSZWPqeHxAABoAFN179bl9tqGPy3MfGQPbrPrNPrZi2zMb5Pgi1A4nIWVRrTKuSykkJJICMS8nyBN@vger.kernel.org, AJvYcCXMMgIAx0tYD488RKcgSLH+Bj6ssRkgAw4QvBA68YyJdSBkQPyVSm/eJiZ2fqdSBAkGBUEROMKj9rTkx4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7POgkSfZ4aq1A+KBA/8kSO1ok9siRL3dEcgrKYELwnydNU/5
	Zudza0ZXkaZgymwjloUSNPnjON8vaWFvwVGg8FM184ZNZnzE3LMbFWUi8w==
X-Google-Smtp-Source: AGHT+IFZIWBeGssZlbykHlhtPJzaOPXIEAb+m9BSaPwc6IUQXl2xcYZG1msLYwzKd+swNkLxBLV4NA==
X-Received: by 2002:a05:6358:88d:b0:1b5:a034:4713 with SMTP id e5c5f4694b2df-1b7ef352898mr2009643555d.0.1725509894565;
        Wed, 04 Sep 2024 21:18:14 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:18:14 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Helge Deller <deller@gmx.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Samuel Holland <samuel@sholland.org>,
	Lyude Paul <thatslyude@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 21/24] Input: serio-raw - fix potential serio port name truncation
Date: Wed,  4 Sep 2024 21:17:26 -0700
Message-ID: <20240905041732.2034348-22-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905041732.2034348-1-dmitry.torokhov@gmail.com>
References: <20240905041732.2034348-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When compiling with W=1 the following warnings are triggered:

drivers/input/serio/serio_raw.c: In function ‘serio_raw_connect’:
drivers/input/serio/serio_raw.c:303:28: error: ‘%ld’ directive output may be truncated writing between 1 and 11 bytes into a region of size 7 [-Werror=format-truncation=]
  303 |                  "serio_raw%ld", (long)atomic_inc_return(&serio_raw_no));

atomic_inc_return() returns an int, so there is no reason to cast it
to long and print as such. Fix the issue by removing the cast,
printing it as unsigned decimal, and expanding the name from 16 to 20
bytes to accommodate the largest possible port number.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/serio_raw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index aef8301313b2..e058fef07f57 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -29,7 +29,7 @@ struct serio_raw {
 	unsigned char queue[SERIO_RAW_QUEUE_LEN];
 	unsigned int tail, head;
 
-	char name[16];
+	char name[20];
 	struct kref kref;
 	struct serio *serio;
 	struct miscdevice dev;
@@ -277,7 +277,7 @@ static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 	}
 
 	snprintf(serio_raw->name, sizeof(serio_raw->name),
-		 "serio_raw%ld", (long)atomic_inc_return(&serio_raw_no));
+		 "serio_raw%u", atomic_inc_return(&serio_raw_no));
 	kref_init(&serio_raw->kref);
 	INIT_LIST_HEAD(&serio_raw->client_list);
 	init_waitqueue_head(&serio_raw->wait);
-- 
2.46.0.469.g59c65b2a67-goog


