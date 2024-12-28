Return-Path: <linux-hyperv+bounces-3551-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B665B9FDBFE
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Dec 2024 19:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24217A02DA
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Dec 2024 18:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B6A19CC36;
	Sat, 28 Dec 2024 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuKZJaMN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A34219B586;
	Sat, 28 Dec 2024 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735411807; cv=none; b=Ux+v9V9afyQJAo6csLuFgOiBoaqZB/1fa3gfVH9pBejMR1CnwpoA+gCoACmgRc3OGRBwdD/30eZ2lIP+/PgRF4fyiQukMrQ7N1tRj7mHhtfWrlsnGp2FuR31VwnxftrcZbtChPaXAsJZ83maB8CQWNVyQOqv4nGLHftM5a7fKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735411807; c=relaxed/simple;
	bh=hMJtabK1vX54uoCs62Uh1uKXB0G3C1rvDyjRxtrbzJ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0bk2hnL81C547Hi+cDTdvsSfrLCv55oABgH+or/G6b2lbJ18ohMPCn+QzBz8b2ZG3B6LxzVTyqL7x3HcjmjTWASuaD057Z/+IG5zz2qI1hbMob1H48gUyAzSKnerqeXzID11EGqUwCR6ojprvB66aQObLzCn6f8SfxYGY405hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuKZJaMN; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso10325159276.3;
        Sat, 28 Dec 2024 10:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411804; x=1736016604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9g5yzfm32qCCSZ9hYX8RFrDFECwqUd1W8h8dBnaZOA=;
        b=PuKZJaMN7FM+htxTzxyU2Jh6Tj90YZj5dk4dLhZ8e64xzWhyoWeZ0dPF92AXKybcEL
         HC381gJKDAgRrKmOveaDxQZ29tFgQyh5DOSC/8uqHwMOtsYlKryM+dgCO0Gqcah5uK53
         NN66t1T3M/Muf/jCvJhWT6dLfXOZZIeKDK1KGmDTn5RlqTJqUE2GJcXdx2kd1YBS/NZ5
         y11MRSF6WmK2ZcMbVzuFlm1uaoLGAX9pgx5v/fq8c2hzhoR+R3oi+T49iN2C/DITMI8X
         Um830iWdX34tWyYafNK3Z91zsvAYhrl1bbkPz3Hb+N9nE6Oq+LwlfqDPKL4De0lz+jo6
         5KKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411804; x=1736016604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9g5yzfm32qCCSZ9hYX8RFrDFECwqUd1W8h8dBnaZOA=;
        b=HMehnsPFmKvwTQAE1Z3mFY7mZPNDj9cAiZ39yPtxAFAM9U3+nFKjBFZeCaF/butfqK
         YWPpocL+MsDqitGN51tgCd0gHt8mhxLOkbDX9ADA/ew3YjplG0MmIITs5qX0CJ4MpS32
         eqr6ulDS8njzNQyWs8VWBSuNN2Be/mYID7ds1J96OPzy/Wv7T39Gj9CzTELZ0UIdxrvC
         /lo4yZ14S8f4XwjcVR50Z9CzwE8/w69NlDyFl8TGtNskV/ROL0IDkL2jhQJwg7waMekv
         qDUy26HW1DwxdH6rkwZf1yUW+/Uj90OhGRikvDhyC9c3BDKL998Gzmsj0iKawDfAukkz
         AhrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8MPh1JlRZLLJ6dV1lR6k4MhAiJnlOF/+ATdAA6x49jhVxCD4i2EnSVWGDDx/KrxELjF0JUXyV@vger.kernel.org, AJvYcCUr/AmaZy9FYF37P6XRqyjnubZGkNKhneDkBJQn1ERItxLQ09GK5CtbiO7hlRMsICu6msn46kVZeHgixFFu@vger.kernel.org, AJvYcCW/t4QjK1oJQ24FH6Yzj8ASUze5SjBxvUx5fjpkEPzxxltHxXEb/E14jfGxqt5ym1ocs/dpu/8MXiDL@vger.kernel.org, AJvYcCWnDRDNqVf7t6DU5BJ5Qc5u4lWJ3r5zLap4JTgfV88nFOZ3dY2LwxlwZTEIcRZLxefCAMxIsYxHF+zxbfI=@vger.kernel.org, AJvYcCXBXQpyg6zd4wVz4B6or52CX6i9ntNREp5H4G17UbEGCuv9VdWJWhTONsXcptojD8lR36a5rdRCNcnIyg==@vger.kernel.org, AJvYcCXmYs3iaVPeu+vN8t9StpFo1GRFo95FSCxh/G0EcQaGF/7XCXq9fP6ZuIXD8JBMELfJHl90hI3AaIPL7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1P2eBpvhVWT4uyg/VljvtOyXT8CfemHR9tmmgEO1Xh6Basg3W
	+XZUNl/1TQRvlbVXG1DJPq8++DNT5GiDaX5hrQ7k+vnU9IBYXnOgcT0Xthd59iw=
X-Gm-Gg: ASbGncuYAZ8d7s7yFOKP6wXHVt/qBoqNXzL0+HC0fKdur9EePJZBuOxgmy5FKIukU1q
	vBDw1ZloYbyeNp3v/enrslFrg5vyB2ACWY+/AxAwOypWGcXrkWW9HInEJAPwGZRpoZGcbpFvSc3
	rWxeh0C4yvXySXzTbrwgfLVHHY5hQXJt3R1IFu0EMHObjkLoiGLQYy4UlNVar5CnB79cZSekACW
	H2gWWxcJs2QAkCCDWB1yuOhlI+x16/ayptpnDeT5E5Z355KFaqwYYhL8gMCyI5TZkLfhnReSyIw
	BDdI6RkN1HkKVIWd
X-Google-Smtp-Source: AGHT+IFRAv4ES1nGe5GZzQSCr0JvuQEh3E1vBTb1UadMisfKYeWtlE6qWVQlRiPBMv3C59QKs6b8rQ==
X-Received: by 2002:a25:cc1:0:b0:e53:4d98:7459 with SMTP id 3f1490d57ef6-e538c3cfd9dmr14310782276.40.1735411804331;
        Sat, 28 Dec 2024 10:50:04 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cf73675sm5102193276.51.2024.12.28.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:50:03 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>,
	Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [PATCH 06/14] cpumask: re-introduce cpumask_next{,_and}_wrap()
Date: Sat, 28 Dec 2024 10:49:38 -0800
Message-ID: <20241228184949.31582-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241228184949.31582-1-yury.norov@gmail.com>
References: <20241228184949.31582-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpumask_next_wrap_old() has two additional parameters, comparing to it's
analogue in linux/find.h find_next_bit_wrap(). The reason for that is
historical.

Before 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
macro"), cpumask_next_wrap() was used to implement for_each_cpu_wrap()
iterator. Now that the iterator is an alias to generic
for_each_set_bit_wrap(), the additional parameters aren't used and may
confuse readers.

All existing users call cpumask_next_wrap() in a way that makes it
possible to turn it to straight and simple alias to find_next_bit_wrap().

In a couple places kernel users opencode missing cpumask_next_and_wrap().
Add it as well.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index b267a4f6a917..18c9908d50c4 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -284,6 +284,43 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 		small_cpumask_bits, n + 1);
 }
 
+/**
+ * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
+ *			   @n and wrapping around, if needed
+ * @n: the cpu prior to the place to search (i.e. return will be > @n)
+ * @src1p: the first cpumask pointer
+ * @src2p: the second cpumask pointer
+ *
+ * Return: >= nr_cpu_ids if no further cpus set in both.
+ */
+static __always_inline
+unsigned int cpumask_next_and_wrap(int n, const struct cpumask *src1p,
+			      const struct cpumask *src2p)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_and_bit_wrap(cpumask_bits(src1p), cpumask_bits(src2p),
+		small_cpumask_bits, n + 1);
+}
+
+/*
+ * cpumask_next_wrap - get the next cpu in *src, starting from
+ *			   @n and wrapping around, if needed
+ * @n: the cpu prior to the place to search
+ * @src: cpumask pointer
+ *
+ * Return: >= nr_cpu_ids if no further cpus set in both.
+ */
+static __always_inline
+unsigned int cpumask_next_wrap(int n, const struct cpumask *src)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_bit_wrap(cpumask_bits(src), small_cpumask_bits, n + 1);
+}
+
 /**
  * for_each_cpu - iterate over every cpu in a mask
  * @cpu: the (optionally unsigned) integer iterator
-- 
2.43.0


