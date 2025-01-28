Return-Path: <linux-hyperv+bounces-3784-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDFDA20F0D
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 17:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9380D188A63F
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 16:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10311E1A16;
	Tue, 28 Jan 2025 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9UGeBZ+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5721DF99C;
	Tue, 28 Jan 2025 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082823; cv=none; b=WFwDjGWpJJijYx06C79e5tRQaCt8aTILtYlUQDlU5HAsFhzdkz/lPyo5Yje/cV92IL51Aufhrnz65pkWiASdq8sAVdL3kYeJOi4qpZmn8jtesIeAtxTbM1GcLYrGRIKALQXg4NwKwR4i91S44HzCrBfCkzaK/Eb8KAfxzlcfcI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082823; c=relaxed/simple;
	bh=3Nw6u6TcLstz84UwM+gUpBPEmbRa4zVJY8ONgf+AwsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSodrBO7wUU8MMBnzDDgQ8O5zQcCaxu06VVJmCICdBZJa6tYuvrQokHLGfG4z0qt8rIdX/K5nqdahid0quFQUb45Jrq5ln3vmiAbijzUvS9FLHj+/LIj33wIwTlLwDAgaaoBL3u8vjHPjzyHBhyKBCI/OLo7m0Qfqa3ESfzL288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9UGeBZ+; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e46ac799015so7740234276.0;
        Tue, 28 Jan 2025 08:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738082821; x=1738687621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPo0Qmhd/LgFOJoY/TurPrp2onCgGxY+Z0rc3zytFz4=;
        b=a9UGeBZ+Dno0Hqv6IasDiD8ZD+hk+4MOxDk3m+WeFm1wxfhE5xgXERj2DscxD48/tE
         f4csOBOmqyCeRDC78ibzKgcISvJXKb3PlH6KlTMl8zqubgyYhoIBdgdmPN3BeKhc1k9V
         QbQvLREla2BJvVYxY4Q1H7c59f51E5IYoBLwzrVx66dYq+IR4Lnz1nd0hLXSRJQ9mHRO
         PcPhq/v+zlJzjM1SOysIwyVXqjGA3Xz8YCCPSu35GhgPd8UFNQQ8oL3ax5MqDNtwYrsQ
         wsb9KahlQRPsog/F4MSXnGiH+tywFandzovmbnh33AipmXyg7rvPKcQpsS7XejQAexWk
         rOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738082821; x=1738687621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPo0Qmhd/LgFOJoY/TurPrp2onCgGxY+Z0rc3zytFz4=;
        b=X5Yx5FIeR/f66E47J9vlGznyqpCct5m5+6680xg0oT3DxQUfQgTGdnlYCuA+pK54KS
         tKV0AxhCdrMcfSClax2nLvCStE6pSGDuD4/1DHBoMRhaUiL1Kfq8Llt7/x6lOM52NYkB
         ieQ9NieY4qlWF+x85EgRmcoyMJxbI03/NqCKLJO1HOVlinOpx2kDz7eOQawhTLLfMkhp
         rqbuzkhYmaotO2KFxTO/MC72MnY1jxbe6HZdC35aqr7LOqPRFmqlrJpKqryO+33yCM4g
         OJvYRufgqWGlc2KhYrVcJfYDDFJG7zRKDmmFcoABgWL/F4QUWcChTKGxndtVxrvxPmuI
         dYQg==
X-Forwarded-Encrypted: i=1; AJvYcCU35hHcfnlqtpJEN+O82UN1Brf/72LZZES5UQ8NqQqRa42xCOz30RQGwEs1dKEZ9HlEd9iuGGR9sTkZIQ==@vger.kernel.org, AJvYcCUbtpxn7lrnLe6Dpme+arpijr8w8fEqPXB0LpCcAkFA/5N281DO+F8YSo1LuEfZMZkmr8rYwNAM3uYa9Xo=@vger.kernel.org, AJvYcCUweCNvy0SPTZueHpesRX2m1V31u2Mtq55GL7Y7jiyJpyLEvJvPKz5zKddlG4GxBFxgzN48t9Tql1Wk@vger.kernel.org, AJvYcCVId/NIazBXfhFUus7mfEy/ZTmbRNO1txa7gNAUbYeTIH9qSvIF7XCodXkdNf1AiHC5tINVZI9AnoJp+Q==@vger.kernel.org, AJvYcCWdG9M1jPa6XgtUmzP3bqTeBP1GT8g1vBXB+v+LfHMzjo9x1WvEg8cb8xQ+9VsbpI2HwohxNGpc9KV1w+XT@vger.kernel.org, AJvYcCWo10fMyNYOIks7POrIMPkp1V70sJ58XVW1uJnMYzN7kOg9AEnVFep4jJvKGAIz9rhS6vgCfZco@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5BMayPiOFo3C4dq+VfFf940YiItomgLLzAA6tiFWet8x/yR2D
	isbqe3smHuij6MtzK/YlmbtdaoSYvKnI+Tj+IAjuKnxhDWgOSRHxlWEhXPx22PI=
X-Gm-Gg: ASbGnctZcQmlHAnxbsOmglEk6+8wErnieRp6d9hRtPRo3oMoDC1bYmNky0vyBkq2uBc
	r/QSa+xWkNffp+0tIxbmm+ljoJMYM6WmFhEU6elVR/D3KzKzKbJKdXXcunNI/Bs0kDCQoFVMxnt
	SzxBQAfHtlv1hMg9AdmTN2zzTB6qWqNkK3E7PcIO3tfiQW99CIsMQH5v2ggOLVbeM1uMiMyaeJE
	Su48iNgP9yqt/S3/UiH0tP3VV/hTCdbZWCXLNcw5gzz7U6gjvTrCPFxLV7cdMFHnb+/YxxzYd6/
	4nOjyOZAjBAulHqSNaygHC3QFQSO3tB/68kr1fEthufr/L9EIXA=
X-Google-Smtp-Source: AGHT+IEbCDwztaXs4775wdhVhgVxaydy6EUMlQBUSRYIasXW3lx4ypNqxsjWkznwG36W84zpcNPfgw==
X-Received: by 2002:a05:6902:982:b0:e58:306f:e83a with SMTP id 3f1490d57ef6-e58306fe89cmr14077851276.29.1738082820769;
        Tue, 28 Jan 2025 08:47:00 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e589a2260a9sm196205276.37.2025.01.28.08.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:47:00 -0800 (PST)
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
Cc: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 06/13] cpumask: re-introduce cpumask_next{,_and}_wrap()
Date: Tue, 28 Jan 2025 11:46:35 -0500
Message-ID: <20250128164646.4009-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250128164646.4009-1-yury.norov@gmail.com>
References: <20250128164646.4009-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpumask_next_wrap_old() has two additional parameters, comparing to its
generic counterpart find_next_bit_wrap(). The reason for that is
historical.

Before 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
macro"), cpumask_next_wrap() was used to implement for_each_cpu_wrap()
iterator. Now that the iterator is an alias to generic
for_each_set_bit_wrap(), the additional parameters aren't used and may
confuse readers.

All existing users call cpumask_next_wrap() in a way that makes it
possible to turn it to straight and simple alias to find_next_bit_wrap().

In a couple of places kernel users opencode missing cpumask_next_and_wrap().
Add it as well.

CC: Alexander Gordeev <agordeev@linux.ibm.com>
CC: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index b267a4f6a917..4f3d8d66e86e 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -284,6 +284,44 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 		small_cpumask_bits, n + 1);
 }
 
+/**
+ * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
+ *			   @n+1. If nothing found, wrap around and start from
+ *			   the beginning
+ * @n: the cpu prior to the place to search (i.e. search starts from @n+1)
+ * @src1p: the first cpumask pointer
+ * @src2p: the second cpumask pointer
+ *
+ * Return: next set bit, wrapped if needed, or >= nr_cpu_ids if @src1p & @src2p is empty.
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
+/**
+ * cpumask_next_wrap - get the next cpu in *src, starting from @n+1. If nothing
+ *		       found, wrap around and start from the beginning
+ * @n: the cpu prior to the place to search (i.e. search starts from @n+1)
+ * @src: cpumask pointer
+ *
+ * Return: next set bit, wrapped if needed, or >= nr_cpu_ids if @src is empty.
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


