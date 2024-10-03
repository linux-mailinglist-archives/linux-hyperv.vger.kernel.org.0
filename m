Return-Path: <linux-hyperv+bounces-3099-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C860598E8F1
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 05:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9EDF1C21F28
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 03:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EBB2E62C;
	Thu,  3 Oct 2024 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHB/4L0P"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FF2110E;
	Thu,  3 Oct 2024 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727927653; cv=none; b=lRha9N+OZjg7KtEA+zsM3TLm1HrI0DvzWFLvqvF82ZUNLA/C7EXf3yzTGKM6f8KdFfgq1i9ivvIXERe8+hARDWhWxy5F42R+28DGivbX2C0FrJgdpuHKFVk7kOedWLrvMolje7J1hLIJQZZl2eewsVoktx/7xLw85mb21BDhIZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727927653; c=relaxed/simple;
	bh=QmeSYrrI24PWcddwX8PrLWtm0wkKceIF+Cz20bFHXtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ks8c/rHnP3OLebSayBGp/bCOkEXL4lVuRHRwb5hxtXP2jPZIAAUMXqRDOCG2RUSut+rN1wGpNnCeDye/6eEmpzuwxPq580nO5MAg/Ygnmh04fBWUzXFe/L4QVFluPywmoTX8FNVYrlQDT0lDEIzXj9bJPJUQ/PdIL3/ht3ZetqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHB/4L0P; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b6c311f62so4117585ad.0;
        Wed, 02 Oct 2024 20:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727927651; x=1728532451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hHOtVVpxaSz37zmcbp5H7y6KJdcMIRfAVEwysl7iO1A=;
        b=BHB/4L0PF9ia5SwMAz2yQwSjcKg5W86YyjRWIOsNYnrSenbzLae1Qr7w5MvN8XUqwZ
         A9aTLIm01qnfY11cnbKViRxiGKuajG3ylb/uvThVIf4K1/HXu58KzTNmfoufF1Am1Kq/
         6wXiYnQAtGo1TkPv0R7f4Tx5I2mKv2oX7IKblij59rDz6N7HuR5Q3/8ybbxyCAVexN22
         SRULjX8sWTaKJwnE9ufPoLGenO4/joGKaWTfYORYghbS5tZeRdmzmDEMiNBUOWr122OG
         iaH+gp8xPiX9v/h3qPRnRwTTB2n/eJe9Mcg6fA45aaz2Yz95pcCFBKM1/RsAeB0G5/mO
         LjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727927651; x=1728532451;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHOtVVpxaSz37zmcbp5H7y6KJdcMIRfAVEwysl7iO1A=;
        b=wr7S8tg0f5QDQGd2eA532ztMPPy5SNH8UZvsCdKSi3TFKjwiuRXMBVWQ/PDzZZ19pV
         ekZdpkk5RLj7kKjG66fVxmkL2bXBR43bgFIqpqKK7MxSWqOWzEB/RUjlzvL7AV8NndFC
         n8tZXoz6TeNrAZ2BQIcPaIaIHKUYMHGJeC9OkIrPYbgyhonrLvScq9J94LUF3EXuCiko
         YACpUOIK4HxK+eY/qjAO13QlrWyl1/W9sVbM/8zLqfw2tx3I4pn1g6boQ0CEVJpaNOax
         F7BdA7/apyg3S2bIw25KUejEpns4QpzlQQ0cjToIoD4XkE9Y9+Fbh9afKeqRLLDTE+sE
         qY2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVKJ8x7yfKjfOBnIU9+ZKcre+Av+dvqz7tYDI4syiyM3OEvTac2sw3y4JqAvYW5e2rKSc+2sS+XGLpzQ==@vger.kernel.org, AJvYcCUy8ieDOV5a44Vbs10ErpOBGvfgYTWFd5AwxoVXI/R7sW8CmOsuZC9+F+plNxB4m9AipmalS5NoBjcjSN6a@vger.kernel.org, AJvYcCVLX0w6VER2XI2LpKWWtHk6BobF907V43eCz+AVXX9zQihuCwn5OfJ8TQegxmKN+aSkriZxo4p+@vger.kernel.org, AJvYcCWJCm7uSX5HDpYY2VGlHzYLYWOK53BPmZZLxWDXX6z9HXa2n+1OJmFYBmAbwzE9ht2swid5+wMPh7Gud44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDp7oGoPCyvWu6fUFxzcxychfqSD1RoGSRxjGboQ5VctD+cWCJ
	1VxfTK8t/Zc3SjdwgqYBOF0wEVSF0lkkme0jrVK8Zcwv9Bh/g/ix
X-Google-Smtp-Source: AGHT+IFHg+L2rkL479r/ys+rVampY0Tz/cLk/l2GdysFP7KsfE+ZMCPSsA6gvnNI+6jswnDv5pviaw==
X-Received: by 2002:a17:902:e88f:b0:20b:849d:48fa with SMTP id d9443c01a7336-20bc5a04f8cmr68592895ad.27.1727927651458;
        Wed, 02 Oct 2024 20:54:11 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead8dc2sm906115ad.44.2024.10.02.20.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 20:54:11 -0700 (PDT)
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
Subject: [PATCH 0/5] hyper-v: Don't assume cpu_possible_mask is dense
Date: Wed,  2 Oct 2024 20:53:28 -0700
Message-Id: <20241003035333.49261-1-mhklinux@outlook.com>
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

Code specific to Hyper-V guests currently assumes the cpu_possible_mask
is "dense" -- i.e., all bit positions 0 thru (nr_cpu_ids - 1) are set,
with no "holes". Therefore, num_possible_cpus() is assumed to be equal
to nr_cpu_ids.

Per a separate discussion[1], this assumption is not valid in the
general case. For example, the function setup_nr_cpu_ids() in
kernel/smp.c is coded to assume cpu_possible_mask may be sparse,
and other patches have been made in the past to correctly handle
the sparseness. See bc75e99983df1efd ("rcu: Correctly handle sparse
possible cpu") as noted by Mark Rutland.

The general case notwithstanding, the configurations that Hyper-V
provides to guest VMs on x86 and ARM64 hardware, in combination
with the algorithms currently used by architecture specific code
to assign Linux CPU numbers, *does* always produce a dense
cpu_possible_mask. So the invalid assumption is not currently
causing failures. But in the interest of correctness, and robustness
against future changes in the code that populates cpu_possible_mask,
update the Hyper-V code to no longer assume denseness.

The typical code pattern with the invalid assumption is as follows:

	array = kcalloc(num_possible_cpus(), sizeof(<some struct>),
			GFP_KERNEL);
	....
	index into "array" with smp_processor_id()

In such as case, the array might be indexed by a value beyond the size
of the array. The correct approach is to allocate the array with size
"nr_cpu_ids". While this will probably leave unused any array entries
corresponding to holes in cpu_possible_mask, the holes are assumed to
be minimal and hence the amount of memory wasted by unused entries is
minimal.

Removing the assumption in Hyper-V code is done in several patches
because they touch different kernel subsystems:

Patch 1: Hyper-V x86 initialization of hv_vp_assist_page (there's no
	 hv_vp_assist_page on ARM64)
Patch 2: Hyper-V common init of hv_vp_index
Patch 3: Hyper-V IOMMU driver
Patch 4: storvsc driver
Patch 5: netvsc driver

I tested the changes by hacking the construction of cpu_possible_mask
to include a hole on x86. With a configuration set to demonstrate the
problem, a Hyper-V guest kernel eventually crashes due to memory
corruption. After the patches in this series, the crash does not occur.

[1] https://lore.kernel.org/lkml/SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com/

Michael Kelley (5):
  x86/hyperv: Don't assume cpu_possible_mask is dense
  Drivers: hv: Don't assume cpu_possible_mask is dense
  iommu/hyper-v: Don't assume cpu_possible_mask is dense
  scsi: storvsc: Don't assume cpu_possible_mask is dense
  hv_netvsc: Don't assume cpu_possible_mask is dense

 arch/x86/hyperv/hv_init.c       |  2 +-
 drivers/hv/hv_common.c          |  4 ++--
 drivers/iommu/hyperv-iommu.c    |  4 ++--
 drivers/net/hyperv/netvsc_drv.c |  2 +-
 drivers/scsi/storvsc_drv.c      | 13 ++++++-------
 5 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.25.1


