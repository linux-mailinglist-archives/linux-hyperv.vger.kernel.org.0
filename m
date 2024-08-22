Return-Path: <linux-hyperv+bounces-2804-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF6995BE56
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 20:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFDD41F24C6B
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 18:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D69B1D0DCF;
	Thu, 22 Aug 2024 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzRi/wgo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C611D04A3;
	Thu, 22 Aug 2024 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351870; cv=none; b=ERJa/NhxAT4ks4LN+rDYzwnSIw/bMPT/vpGeBCs9tiTAVRVqrzwqf3tplU/cDGvtjP4onwagcrUb++3M/2vLLQ1+Ft74BCvMul7oeL8LkuJswj2Ckz+JJx4r7d/qZCGKSG09lYE5X1a9IkuhdeVgc3ugcveMe7DCP/siLC5qlcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351870; c=relaxed/simple;
	bh=t7o/ANRPJFs0l8TeamTdj8dI882TkX1rTKCkymHtYNQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sNwVVueQlv0VfXkpeXfO69G4Vwyj2HFtHfkAR7Acq+K56/hUH8Ecgxq2s/kihbcI2TZvd7808riO5yIx3SiGUD2V8TPpd8HLcl6W3ZqbNm7h5Wk8ok59u97R3sZ8ZoZnDVzakFdRm3nQGGag4Zv8ZdcbORoqP9p4MqqzQOERoP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzRi/wgo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20208830de8so9578615ad.1;
        Thu, 22 Aug 2024 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351868; x=1724956668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/ThqndoEMvfHog7jEmoHMSz79N0bCj0y64RGbOiEjY=;
        b=OzRi/wgoVrZDJ5Rkh+0iPMQIXeyjTV1ftxw2uki2dS9gMIIM2IvlcC8mqXvh4uyX4V
         xYIOxzeROfx0KcFaXUxID1rP6kMMEqInb8k2oWZIzIYjxvQftsKNj7FfVn5xOsl5uNq2
         ic/tESASFCndVqudGGqlPU3MQhPcnwYWY6OYRvNv7xAyJ8poMoBjBytRuOUAKiIknvHH
         JLROu2RrrpZwFUR5l32nmnz4eorlO0oDmgkfhTTJF8Q//A1vRBMpLA3iwqEiGvB2h5QZ
         6IRlDYfbwPVQPikjsKGXegSoWbOtFqJ0h7zejWogeggbKXAQCSM7DptLpALHvNR0vjm3
         OWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351868; x=1724956668;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/ThqndoEMvfHog7jEmoHMSz79N0bCj0y64RGbOiEjY=;
        b=HqALGnFQXwe5N1lefH5KIpRwrNr8+AWISCx5loojud4epryXbGuF0Fo9OzVnxWhe6k
         SjBb7OBuo0qnux1UW4BnfmHgS7cPzNG/PcsB8HLbw7zDEqLQopPGjk4py94MBFQDyxqB
         YssJ4y0mIfXrPr0BIb542Mdt08SOmrJt8qw1DwvbkFIq9AIrtfe42zwbxzHdyogZADnZ
         bD5Ffi/vcA5z4tBoIpBYBtc9p/qXmJjbqNrdt4VjkvJzCL84J6EF9ymCNnEAnx8Dfc6p
         7l7QBDkHFtJdO6ZhyWi+d5zbx97OtjoT1QEZ8R8iTX7hsvPTrDNdxgkBvydM43QDHMso
         VqHw==
X-Forwarded-Encrypted: i=1; AJvYcCUKuCWlU1Z0q7UkmU0mLAqETLzVRvPYIQlIrY2mbDGbfYpG/TeRfOcniPZrsWkQQly61YpjQgsi42Kb29hg@vger.kernel.org, AJvYcCW6n9KMU0VEGteCumo55XDN5T5x0PNyopOtOsD+73il4wwIy4dnFcrKWVLa5FJ+gA924XAvF/ySwQmOcA==@vger.kernel.org, AJvYcCXE/Y2TSuX6kiibKbGLXS0pR5SSDECz6gN0Hvbz57qL063JQ4zyb5QbGdfsYtDxxbkUso72SL9BDThd1Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFz/losVgYPcgOG1tdi1UwYGh/fgealbrOK296eS0i+beSiuEN
	I1nXnR5Vy+ENhA+Ql8x2VyZ+8Y1zov1LofhHSzXsyzSgx8eTc6qm
X-Google-Smtp-Source: AGHT+IE5HU0h4JUoQwfjPC2hkmon5bCJZ8hz8HnwTaO4uEWN3UXUQmXUdXTWmLmVascnml4B3X8Sbw==
X-Received: by 2002:a17:902:d4ca:b0:202:162c:1f36 with SMTP id d9443c01a7336-20367d3b815mr78784005ad.36.1724351868111;
        Thu, 22 Aug 2024 11:37:48 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:47 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 2/7] dma: Handle swiotlb throttling for SGLs
Date: Thu, 22 Aug 2024 11:37:13 -0700
Message-Id: <20240822183718.1234-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

When a DMA map request is for a SGL, each SGL entry results in an
independent mapping operation. If the mapping requires a bounce buffer
due to running in a CoCo VM or due to swiotlb=force on the boot line,
swiotlb is invoked. If swiotlb throttling is enabled for the request,
each SGL entry results in a separate throttling operation. This is
problematic because a thread may be holding swiotlb memory while waiting
for memory to become free.

Resolve this problem by only allowing throttling on the 0th SGL
entry. When unmapping the SGL, unmap entries 1 thru N-1 first, then
unmap entry 0 so that the throttle isn't released until all swiotlb
memory has been freed.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
This approach to SGLs muddies the line between DMA direct and swiotlb
throttling functionality. To keep the MAY_BLOCK attr fully generic, it
should propagate to the mapping of all SGL entries.

An alternate approach is to define an additional DMA attribute that
is internal to the DMA layer. Instead of clearing MAX_BLOCK, this
attr is added by dma_direct_map_sg() when mapping SGL entries other
than the 0th entry. swiotlb would do throttling only when MAY_BLOCK
is set and this new attr is not set.

This approach has a modest amount of additional complexity. Given
that we currently have no other users of the MAY_BLOCK attr, the
conceptual cleanliness may not be warranted until we do.

Thoughts?

 kernel/dma/direct.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4480a3cd92e0..80e03c0838d4 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -438,6 +438,18 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu_all();
 }
 
+static void dma_direct_unmap_sgl_entry(struct device *dev,
+		struct scatterlist *sgl, enum dma_data_direction dir,
+		unsigned long attrs)
+
+{
+	if (sg_dma_is_bus_address(sgl))
+		sg_dma_unmark_bus_address(sgl);
+	else
+		dma_direct_unmap_page(dev, sgl->dma_address,
+				      sg_dma_len(sgl), dir, attrs);
+}
+
 /*
  * Unmaps segments, except for ones marked as pci_p2pdma which do not
  * require any further action as they contain a bus address.
@@ -449,12 +461,20 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 	int i;
 
 	for_each_sg(sgl,  sg, nents, i) {
-		if (sg_dma_is_bus_address(sg))
-			sg_dma_unmark_bus_address(sg);
-		else
-			dma_direct_unmap_page(dev, sg->dma_address,
-					      sg_dma_len(sg), dir, attrs);
+		/*
+		 * Skip the 0th SGL entry in case this SGL consists of
+		 * throttled swiotlb mappings. In such a case, any other
+		 * entries should be unmapped first since unmapping the
+		 * 0th entry will release the throttle semaphore.
+		 */
+		if (!i)
+			continue;
+		dma_direct_unmap_sgl_entry(dev, sg, dir, attrs);
 	}
+
+	/* Now do the 0th SGL entry */
+	if (nents)
+		dma_direct_unmap_sgl_entry(dev, sgl, dir, attrs);
 }
 #endif
 
@@ -492,6 +512,11 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 			ret = -EIO;
 			goto out_unmap;
 		}
+
+		/* Allow only the 0th SGL entry to block */
+		if (!i)
+			attrs &= ~DMA_ATTR_MAY_BLOCK;
+
 		sg_dma_len(sg) = sg->length;
 	}
 
-- 
2.25.1


