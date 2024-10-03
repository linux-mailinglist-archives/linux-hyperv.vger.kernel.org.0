Return-Path: <linux-hyperv+bounces-3101-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB8398E8F8
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 05:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A060E287768
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 03:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F15D59B71;
	Thu,  3 Oct 2024 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN7o4/xB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C3B3FE55;
	Thu,  3 Oct 2024 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727927656; cv=none; b=avgnYnDFUWLrD5bSAFb6rCYaO6NgEJcDcGNyXoOsC4HXbpfFaMfrHdJxdurILVryaDawl/HHpEdoQi0jdPtE4CksBcAme03FBjzvh/M1zeIsZVXs2Fcrz331gcDp/iuAu+883xHAHVW5bzmqvgk2vS1Jvdg8VxvpJNPLOdfNF90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727927656; c=relaxed/simple;
	bh=pneaunq42UDCs3Bs1TW/8ZciN54md0YfS4FpuQiIs44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b6lUd3SoLsbvsh7c7IGpHC5o9vl+A2BPRNRDdP9LkfJbGYPlj8qZEpBdkkUTpxWr4XiL07C1kBkE5S93uz7U1EBsXZfgM/Xry+rMMjqFjK23QIQQ8JCSWFg2v4w3fqgxTiToM+9G+VmjzKHDfcow1LqA+BaQPIuipL7WQVUGRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN7o4/xB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20bc506347dso3436475ad.0;
        Wed, 02 Oct 2024 20:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727927654; x=1728532454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cq0XjbGrpMlRn53fkSkj2ZE6QfO3xJ5aVKsySHlaSk8=;
        b=HN7o4/xBuVpKA/hifZxREWgf7BcmhAJgVp0CEOoBTxoFam8S39rXKbFojJveVPjIKS
         pNTDiCI0lIQXtq/EvE0361IZnm6n1EmfH/6mh7g8LxzJEwoYDb8K1BYb31u33Bbvbryu
         LvsMZeyFABIH4EM3y5YTeW9AibI2LlZxL+DwaTEK5J1nJGn+UZSv7xtrxxyIEVZWj4o0
         UZqLJls16pBErxAMPMxuoEWepMDrYOiF6mH4yyJAemuh2IDpCsRSYU+UjFO7jbNwL6g8
         825JKEbIpcGy7s3hlB2HdMDa0bS9N1g2gPVqp5EBj7q/0C/Q82sfT6HAbzlrixok9coW
         014A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727927654; x=1728532454;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cq0XjbGrpMlRn53fkSkj2ZE6QfO3xJ5aVKsySHlaSk8=;
        b=hVgr3c38qcRwfTQq2Dnju89ceDMi+rFkNpEb7GUJBoOxnFf39GmLOWFJXrSTlkwSyq
         RPEQMJ7hqAS4S9Se4qabmTG2t988ZkTuJ5L3jP37sIybknl0oi1mXjHlTqkvAD/XqDSQ
         OWRrT7/BLON7xLMqO5P126vI4b9/+wzOZIee+VlnQtZJa224inMjb20UhgXxM0+s2NZG
         cznL4JJQ7hG5+XQewJP0r4tYTTGv7wWVFN6qj4dULyRLN01XkbxOOgQNE2k86wzAqxSC
         XRVIBpus5TfWuQO6/HfC+rmz9riqXAT2LNny1KV7tx2ru8Lj/TIwZNukVit9aVPR3yrY
         6qgw==
X-Forwarded-Encrypted: i=1; AJvYcCUCcWThjTBz7vRLY8mNgJsxOCuok+nd6RG7EDV1e8luRaWw60qVJ2ufv+l430CfKCWP7N14Xlzzi/kJgKg=@vger.kernel.org, AJvYcCULUG9q4oUfOjywZW9RLRbmMIpODc3KFLaGDjQ3u0TTT2W2/ylse30gZijfAYOSHQ30V0cWsFiNUmQFCzW+@vger.kernel.org, AJvYcCUexGazJApFmGc00jX8wIEmZPa+UjVeQE90vJCHnlo9/hqJOo5BFb79Sot6uX49c6x8JnabpI7LJqZ/YQ==@vger.kernel.org, AJvYcCVWfN4GuT4tlf9XgxdWk8T/Xwa5sdpW46RkiJ9cG4ESQEwTOFPcEK8ZkFvr2rGYRdr3HcqXVT2S@vger.kernel.org
X-Gm-Message-State: AOJu0Ywys/oNzDfs1EELo2KsXGS4BPTJmg9eThlFnRaoHqSN+fnMLtMx
	KRu3aY241Z4ksAfTU35EI/k0tyA2IkP1PuKpOU/hCb2ygDPi99DU
X-Google-Smtp-Source: AGHT+IHQarg1wLyg3MVulXjHU7XNbDYC9jQJBTn5bjTS6CS6tyLfUuDFFuLBjAX11JvWqCMk5JvUAg==
X-Received: by 2002:a17:902:d4cd:b0:20b:c264:fde8 with SMTP id d9443c01a7336-20bc59f9fcfmr79593655ad.22.1727927654255;
        Wed, 02 Oct 2024 20:54:14 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead8dc2sm906115ad.44.2024.10.02.20.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 20:54:13 -0700 (PDT)
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
Subject: [PATCH 2/5] Drivers: hv: Don't assume cpu_possible_mask is dense
Date: Wed,  2 Oct 2024 20:53:30 -0700
Message-Id: <20241003035333.49261-3-mhklinux@outlook.com>
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

Current code allocates the hv_vp_index array with size
num_possible_cpus(). This code assumes cpu_possible_mask is dense,
which is not true in the general case per [1]. If cpu_possible_mask
is sparse, the array might be indexed by a value beyond the size of
the array.

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

Using nr_cpu_ids also reduces initialization time, in that the loop to
initialize the array currently rescans cpu_possible_mask on each
iteration. This is n-squared in the number of CPUs, which could be
significant for large CPU counts.

[1] https://lore.kernel.org/lkml/SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com/

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index d50caf0d723d..8c44938cb084 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -345,14 +345,14 @@ int __init hv_common_init(void)
 		BUG_ON(!hyperv_pcpu_output_arg);
 	}
 
-	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
+	hv_vp_index = kmalloc_array(nr_cpu_ids, sizeof(*hv_vp_index),
 				    GFP_KERNEL);
 	if (!hv_vp_index) {
 		hv_common_free();
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < num_possible_cpus(); i++)
+	for (i = 0; i < nr_cpu_ids; i++)
 		hv_vp_index[i] = VP_INVAL;
 
 	return 0;
-- 
2.25.1


