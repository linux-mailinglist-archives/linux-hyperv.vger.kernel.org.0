Return-Path: <linux-hyperv+bounces-3102-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C433C98E8FD
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 05:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB46287C16
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 03:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29AF7F490;
	Thu,  3 Oct 2024 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk+PR3RD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D86537F8;
	Thu,  3 Oct 2024 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727927657; cv=none; b=NcgKf+IJ1H9R4TsKdPMLIrxijxjDjh3f9hEAQBwKl/Tmt1oP1SmgsYvMdJptfvS+Pgp3mEwSaA4rTJz6XqGUSg7zacSDT2Yz1wUXpnL6l5DICbJQLmlogAQlF6L9L4ckHL4zNdSAqAQH2+8RD7IJ/RVbafGLPLIxDYIz38fJXvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727927657; c=relaxed/simple;
	bh=mHoaQT1JoyG6LkyzWkFbXUPdVaWzkJTm5hCach2QWbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxVLtz9B0IHJp3B0j9epa0c6W9EtOQ0sMagg0RVndyqczLf6FzCbZleOdAC4C2pykkmnFIyIQWXiEZNqz4w6ALVCchbXKJnCQc7i3XQqg78FHD316aig9nxKBzUbr4a7CQufwviTfpj/yAXjVdoxmL4A8wjUDcYGp57oT0pGL28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk+PR3RD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ba6b39a78so3016695ad.3;
        Wed, 02 Oct 2024 20:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727927655; x=1728532455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tDuFxybHODEaeVrwvh+oodf/QVAaDeDVDDTRMXteliU=;
        b=hk+PR3RDdJxOiqwo2fJLWdB8qDPiHpmfoy+oJJnQoc3qFUTP/w4iwXI6XHddMNDYgu
         dpTmIHOyEo/iWJooCaUcbyAUeKeLL3CLwobxSVIZn/9G+yO2lxE9dups8UmHoci/8baC
         tZ62+ffRbBN4wL5Ij/nKxPH39Vn6SaYn17uwLsHXv+jSfXKHB1sh4/Bm9FAi0F71ajLR
         3XIDW2m5QdlHZupiwRzXd+NNkA9wn4ZOscPCZsAeIYRTlT61guGmmCSuC1d2NG6qy8G9
         IrjvrMCOYuiEYcHKXOSvv3wSrkGilIkPgjXRbzzCvSWjlM+OJzIZ416OPUMyzQDncOqM
         TzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727927655; x=1728532455;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDuFxybHODEaeVrwvh+oodf/QVAaDeDVDDTRMXteliU=;
        b=sHM8qs6ZBbf+kzBLeEdrobG1QlN2RBCL9p+ZU9OmdNwkc12FQALnZyqyyqKNZ82Gh1
         tyhfZAmpK9kVMXgOjAKDQRc+RLYhb+Kcw8VSad8grRgRIv93WhKMO8pXNyGVo1SKu3LG
         PK0Hy2NA4CRkAMjA+2NYqQplibxYjpxZWg1VJ0b9Ux1DtjzWtdv2PZ01yENwFvy9dmF3
         L+78rzjrZNDk7buFzJI4RuAXhnrVBx94fvpwtdw3+HIo3Rkd/sXwleBT17zGEbmMFasF
         sGwy2M8tL3cP/d/UgkkSbxGToCN9xZrMpqlACSSICowQCv74iqFMt37me1hMnUYnfXeD
         blEw==
X-Forwarded-Encrypted: i=1; AJvYcCW/V4goKU2joEQ0H4ZRvMEssmPj2zVV5gLbC895qP11E1Dllu51POaaroL2h9IogwpPAVNZgHYg@vger.kernel.org, AJvYcCX/L5uiqGTEmxDiv2cgu+SsiaYdVNhZwcx2NmUCWoHDqxPcvTiK1osgBm/S38q72uvPDfHN+PD6Ktvb+dw=@vger.kernel.org, AJvYcCXmagrxil7bE/HWovt/4vK2TAp2kcaN8YNaQRDJ+mRMHxH7ncyQTm95vLuoSL1LrY3lzr4TnwcZsjIqlbQb@vger.kernel.org, AJvYcCXp0UHnpTqFZPBZb6rFAvuWNGoNvZygtsQ+h9ZD+llv30/rS2nk7Ysg3o3AEYlBDclQRHdG9SookKkY3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAmob5gej3qWrUSnabFSety0cLRqytGq/sv1QubshNaXZKRaFK
	aIk6CCXl5Kcsd8GY4wt4aTyBTD7Zz5ZFgfiyUpeSOfJN3+xNctLN
X-Google-Smtp-Source: AGHT+IFKLPlcSp9SUFRml4GIrUDRe7i+pHx0/lLBWbzLd4R0zTcKVcErbP/p5ZwNke1aAWlNDTBqqg==
X-Received: by 2002:a17:903:c5:b0:20b:a431:8f2f with SMTP id d9443c01a7336-20bc5a701bbmr52713415ad.55.1727927655583;
        Wed, 02 Oct 2024 20:54:15 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead8dc2sm906115ad.44.2024.10.02.20.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 20:54:15 -0700 (PDT)
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
Subject: [PATCH 3/5] iommu/hyper-v: Don't assume cpu_possible_mask is dense
Date: Wed,  2 Oct 2024 20:53:31 -0700
Message-Id: <20241003035333.49261-4-mhklinux@outlook.com>
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

Current code gets the APIC IDs for CPUs numbered 255 and lower.
This code assumes cpu_possible_mask is dense, which is not true in
the general case per [1]. If cpu_possible_mask contains holes,
num_possible_cpus() is less than nr_cpu_ids, so some CPUs might get
skipped. Furthermore, getting the APIC ID of a CPU that isn't in
cpu_possible_mask is invalid.

However, the configurations that Hyper-V provides to guest VMs on x86
hardware, in combination with how x86 code assigns Linux CPU numbers,
*does* always produce a dense cpu_possible_mask. So the dense assumption
is not currently causing failures. But for robustness against future
changes in how cpu_possible_mask is populated, update the code to no
longer assume dense.

The correct approach is to determine the range to scan based on
nr_cpu_ids, and skip any CPUs that are not in the cpu_possible_mask.

[1] https://lore.kernel.org/lkml/SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com/

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/iommu/hyperv-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 8a5c17b97310..2a86aa5d54c6 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -164,8 +164,8 @@ static int __init hyperv_prepare_irq_remapping(void)
 	 * max cpu affinity for IOAPIC irqs. Scan cpu 0-255 and set cpu
 	 * into ioapic_max_cpumask if its APIC ID is less than 256.
 	 */
-	for (i = min_t(unsigned int, num_possible_cpus() - 1, 255); i >= 0; i--)
-		if (cpu_physical_id(i) < 256)
+	for (i = min_t(unsigned int, nr_cpu_ids - 1, 255); i >= 0; i--)
+		if (cpu_possible(i) && cpu_physical_id(i) < 256)
 			cpumask_set_cpu(i, &ioapic_max_cpumask);
 
 	return 0;
-- 
2.25.1


