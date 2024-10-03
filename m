Return-Path: <linux-hyperv+bounces-3104-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1990898E905
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 05:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7A8B26C97
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 03:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3DE126C02;
	Thu,  3 Oct 2024 03:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpmmQlYR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E083A14;
	Thu,  3 Oct 2024 03:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727927660; cv=none; b=a53IIR8cMcpQc74JVlbViejMnAJJ7FNf2L7tk38hLo36Raes+0ijMLWIjKAnbcUi0FuYpGO3zOgYqEzKrA51g+yGgKZOzJ799wLUH1Z2jx6zqLi0eEWXWZJpb9gSQCFodB8JP77ipSSdKrd+Nh2DkV67JEZL7odKgav6u8772HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727927660; c=relaxed/simple;
	bh=mDj2uu52EkY79d3Z3PI3h5sVX5EsQJI7OPSTCaXIcWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4ZkjDjwJN82Bi8yrcDxgC0PqSuh3dTnMJ/W7SudLh6fuzp0vol7OtnToI5jMbNIzG8KJDecQLB3IGm336slDj3uGL624lUlTLIgg77dLmP16ddDEQzljS045alOus3Yjsp2txNLi8TJQ5IXSL9+8i0OnoyuXoHlAul5ELrXhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpmmQlYR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20bc506347dso3436785ad.0;
        Wed, 02 Oct 2024 20:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727927658; x=1728532458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GSs10GU2u5qMkicjk65IeToN9GtR5XLc5mZWEtwh55s=;
        b=FpmmQlYR+XLwuCNxXtx8dKMd/Pr9xJh0QzRMOQwtBolSBCKFn0bAIBv0WddDZV9jtS
         v4n0d6Ey8L+hCOr7H+gz3Cp8QWdMidiPHUypbI6zFEid4hPdnAGckjEVVAlBDZCWHlp+
         z354EL7I0IFyphbKOkCCSzqgBw8Gw2ILS4zZJfjERzHqObSraChVA4ZSGLNUVmifoZQv
         pYLHA6e6XjGxBqwufXbxYwMTw/klAmnYxGRA89/2n/JThA3kG1wagn8dEs6ZfbFBHI1T
         Nh3xsCYA6GJEu8mfjzA8lX2gEDk0tDHCnBJd1aZDr9onwLaLH6yeCg8ID+jbahW3sajq
         dY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727927658; x=1728532458;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSs10GU2u5qMkicjk65IeToN9GtR5XLc5mZWEtwh55s=;
        b=hxcd4pq6TNs7MNGsuXdoMw1I0m2lR/cB5L2RxYUj5PvBCWdftxCHSKRcQIsfNh1hX9
         yGyYi7eRLGZ7loqiRgykNuQnizuqzCDCO5MYaiTPD5t1GTkv9gn6Hdw3hWGQdOMFcfHC
         oG0wL5R646xi0MPBwiwcpHcYwZRRg2YSsZTn8NS5R8v6OhvYGXH7E1Gq4zqG1CzO+hoO
         iEJhItBK4omb9CFobeCxKSHri8oI74GqGrBiSoJhJBXloTs9ieWjcESj42a5PIsAJdxM
         WonaYKPeMx8mssqvzv9USB3whGe0BJlO6ae/0HE/HVmwf1I8rpOZZ2cZgE0jcJ74kixi
         Az7w==
X-Forwarded-Encrypted: i=1; AJvYcCU6drYiDz7K843PuDkE9On8tXB2GRSDQNnioXAONLY+tKwac7DU2Va0BAwzeu4E7tChYYCrpzNh+U3nMA==@vger.kernel.org, AJvYcCW9REvtG11n/CHMoYkkXoAlw7zSBAx0c44rGdzVgS6r7NtOt4ER4CYyOrC4TQdzwXnATijGCQsfdRAI6I4=@vger.kernel.org, AJvYcCWgcuS7CfFnAK9tFY1Hzv/zCb9fWZJNWwcd4CmI81Y2BRNg7bvo1ZB7tO8xNBVAO74yMuX+LKwLYI79LbjX@vger.kernel.org, AJvYcCXcyUQW5MowdD0AT4BqL9FrOCgTi5PGLmh0hoorTK7lJMkp2036MZ9lh19ZW/cIQ64z2tAapbTp@vger.kernel.org
X-Gm-Message-State: AOJu0YxVKe9TrSUPoED/vEDuGD2BG2F9jOmNJtYuyr0hWeqFWMw9GckK
	Kajxde4gfpQ1t9g95IxylcJV8pKDbtAOjeGy6B6T3qKdhho47Dhs
X-Google-Smtp-Source: AGHT+IH5HR+8rOf74TLiMWc+piVxUVmSj2sS59cu/Eu9BismoJQet5IB5QGdpPAF2AYaHOgyIyKs/w==
X-Received: by 2002:a17:902:d511:b0:20b:84cc:592e with SMTP id d9443c01a7336-20bc5a18d52mr85497045ad.31.1727927658496;
        Wed, 02 Oct 2024 20:54:18 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead8dc2sm906115ad.44.2024.10.02.20.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 20:54:18 -0700 (PDT)
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
Subject: [PATCH net-next 5/5] hv_netvsc: Don't assume cpu_possible_mask is dense
Date: Wed,  2 Oct 2024 20:53:33 -0700
Message-Id: <20241003035333.49261-6-mhklinux@outlook.com>
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

Current code allocates the pcpu_sum array with size num_possible_cpus().
This code assumes the cpu_possible_mask is dense, which is not true in
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
 drivers/net/hyperv/netvsc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 153b97f8ec0d..f8e2dd6d271d 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1557,7 +1557,7 @@ static void netvsc_get_ethtool_stats(struct net_device *dev,
 		data[i++] = xdp_tx;
 	}
 
-	pcpu_sum = kvmalloc_array(num_possible_cpus(),
+	pcpu_sum = kvmalloc_array(nr_cpu_ids,
 				  sizeof(struct netvsc_ethtool_pcpu_stats),
 				  GFP_KERNEL);
 	if (!pcpu_sum)
-- 
2.25.1


