Return-Path: <linux-hyperv+bounces-3103-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F32B98E901
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 05:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1941287DDF
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 03:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621E884A3E;
	Thu,  3 Oct 2024 03:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vye9dtoi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B407E563;
	Thu,  3 Oct 2024 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727927659; cv=none; b=D6Gg/546MP7WZ/uOG4zI0eyjGGfRrG9OYiOl9hDFgQDFy7fjM56r8YAb17yEkIfe1dmln4mK9ng6n4gnDHJ1wbld+Je6jeHBGYjxjVGofbAvmBF4mbljc4dfkpDKDRRu9Pl50qJGyTwoPbSaJIaJKzKMxjUt0kf9pI4xS2DaG0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727927659; c=relaxed/simple;
	bh=x6Zn7HjTzGMYc9FJ3+apAp57nj/OHxiWOSQMFh0tXkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tz5xhfQdxw25OIO9pai9tBrngx8qr3owHjxdKoSP/J2u8ATZmCSGbU6qjUqS8PpSW4JiZFVXIIflrrsXaz35Im7E1VtRbHf+K4cRBUHlTgSSdXt4E1lhlmcYsKZTQ37o3Hs2Cqpo9+fpuOa3htqtgBTFCL9NqbOElZAsJRYcnNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vye9dtoi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b5fb2e89dso2859805ad.1;
        Wed, 02 Oct 2024 20:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727927657; x=1728532457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DIVjY9QXcz2STFKs3TT5rFa2kP9kKUnHMheJi7enQS4=;
        b=Vye9dtoiPnko278xZMa47KkEsn74dxqL2J5FOVAMdOl+LOrbKaovnhx8ABLCg1fXWv
         GE5ewhb7ghelL0FKhrGDOk124/Oy83y4VlnJ3bKjsWxmVFlR2NUKS0KHtzxvple2fOEr
         8xXL9PEaio8tjAWXD4GgwmXoFgUOedNZ19kFlTTxZe7c8NqA/7CvIfc2Z8YJk0YcnPk5
         JJsQJkgxAmKqjOdZkiiFWzkh8eyVaOdKiPPQh7AK1dxqy+Dg2wKZd5MIu7KOp8/XvvPC
         3n6kOCmhjH1eZ/M/QTjWclPJOBPDD7nh92HIMa67Y88okTBnOkJlebeMe2cQmXvsnzmO
         sYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727927657; x=1728532457;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIVjY9QXcz2STFKs3TT5rFa2kP9kKUnHMheJi7enQS4=;
        b=jJq4D7KpNgGCh+ygsU5u4270F8UaCmyjqY+vB2lC9y5WtvaIn8lR1pPo1CceLZ6xyG
         kyQXICEKBhgHWgEXJoY7Lp9BzFboiuMQtu1HrlaTeXEKMdxM1QAMJbWNn2hN6vO5Txii
         FxWMFfedkfUx/3mGT3mfIk8R/8eXHMxcHv2MjGpMCi/jga1wiPugQ73VjWxwcXPYrD3b
         g58J0ULsqHWTmm9xRRBqlsfcEYy5kV5DHLhdJAvzXCgnL1SbgBogf2MvSedRS9zh5HGi
         E3TftkcqmdyLllYmc+mw4y1AMqrKhRK9pMaiNBQ0GN2IH1Smo1EzmxlLlBmYtx7eJcqu
         kBAw==
X-Forwarded-Encrypted: i=1; AJvYcCUBiABG0SF7EsbQxAHXx98u4u3njeyqfV9hoYbvnV/GmPZaXXG/JS8qPDVMX78ZZfR7uV6MZeoj@vger.kernel.org, AJvYcCVImcCHHsSKBcS2b4q5VJpg4xEUFrslr2cRTuyL/AXlDfJZk0J1hQDGaA8EmjDza6PmwgR2CRZDUfdS2Q==@vger.kernel.org, AJvYcCW3zOBGNiChj+y1LAwAUJM8XI4pLmkfRtiaoTO72XzjK2OeoYM7mQ/KQ6XfUBb8eI2stVSbJd6kd4b4iFU=@vger.kernel.org, AJvYcCXSxf9GfllJiiqLNSEr8l8/o7K6CAqck/VQeC+TZgFCyHC86BAX+vhMTA5cGzwD98VACBtcZlbtASvO5t5+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9eM1LGS5GpE2Tu20B31bA6M4LnWGDv/WgvKfabxicmhkEWnpm
	SJHXRhdTuF+y/zbL4kabgTXe3Cv6M+FqQiP1HAU0IhMBt5vke+5J
X-Google-Smtp-Source: AGHT+IGYAsSvN1ppKu/WfTnxiRO2Z7TJtHRQQ6nzYxEJteJVC5HlpEBwNUkwvfBEkQqK2Sk6/i2hLw==
X-Received: by 2002:a17:902:d2c5:b0:206:ba20:dd40 with SMTP id d9443c01a7336-20bc59f4da9mr80367265ad.27.1727927656951;
        Wed, 02 Oct 2024 20:54:16 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead8dc2sm906115ad.44.2024.10.02.20.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 20:54:16 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: iommu@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 4/5] scsi: storvsc: Don't assume cpu_possible_mask is dense
Date: Wed,  2 Oct 2024 20:53:32 -0700
Message-Id: <20241003035333.49261-5-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003035333.49261-1-mhklinux@outlook.com>
References: <20241003035333.49261-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Current code allocates the stor_chns array with size num_possible_cpus().
This code assumes cpu_possible_mask is dense, which is not true in
the general case per [1]. If cpu_possible_mask is sparse, the array
might be indexed by a value beyond the size of the array.

However, the configurations that Hyper-V provides to guest VMs on x86
and ARM64 hardware, in combination with how architecture specific code
assigns Linux CPU numbers, *does* always produce a dense cpu_possible_mask.
So the dense assumption is not currently causing failures. But for
robustness against future changes in how cpu_possible_mask is populated,
update the code to no longer assume dense.

The correct approach is to allocate and initialize the array using size
"nr_cpu_ids". While this leaves unused array entries corresponding to
holes in cpu_possible_mask, the holes are assumed to be minimal and hence
the amount of memory wasted by unused entries is minimal.

[1] https://lore.kernel.org/lkml/SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com/

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/scsi/storvsc_drv.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 11b3fc3b24c9..f2beb6b23284 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -917,14 +917,13 @@ static int storvsc_channel_init(struct hv_device *device, bool is_fc)
 
 	/*
 	 * Allocate state to manage the sub-channels.
-	 * We allocate an array based on the numbers of possible CPUs
-	 * (Hyper-V does not support cpu online/offline).
-	 * This Array will be sparseley populated with unique
-	 * channels - primary + sub-channels.
-	 * We will however populate all the slots to evenly distribute
-	 * the load.
+	 * We allocate an array based on the number of CPU ids. This array
+	 * is initially sparsely populated for the CPUs assigned to channels:
+	 * primary + sub-channels. As I/Os are initiated by different CPUs,
+	 * the slots for all online CPUs are populated to evenly distribute
+	 * the load across all channels.
 	 */
-	stor_device->stor_chns = kcalloc(num_possible_cpus(), sizeof(void *),
+	stor_device->stor_chns = kcalloc(nr_cpu_ids, sizeof(void *),
 					 GFP_KERNEL);
 	if (stor_device->stor_chns == NULL)
 		return -ENOMEM;
-- 
2.25.1


