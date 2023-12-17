Return-Path: <linux-hyperv+bounces-1347-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41D5816268
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 Dec 2023 22:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1680CB2147F
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 Dec 2023 21:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA8C49F6A;
	Sun, 17 Dec 2023 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/agvUpw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683D48CE6;
	Sun, 17 Dec 2023 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e4e05eedf6so8023907b3.1;
        Sun, 17 Dec 2023 13:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702848739; x=1703453539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auyx6SZcEGnvEGrHnzOQrDxyNrYMhwUgQ6pbJgj8x3Y=;
        b=a/agvUpwupImSz1M5QAWqzrFv1ZTUftRc+9WNFLUrhy6mryAwumxQVEiuXztE3evU+
         GeHlA902uOvQMMJMo2bT/blEYxBtQ52oGbgPY3bTWAcYRllAxsEX8D7rb+wKkZoX5gTn
         7MGkT3Bk7Q8wuslIELajtArk8L02knN65zr9jGN8RodwffqK9TPwSB9z5sOx4+00B5u2
         vWwO9ZNXRYX59yoXvvogwFbkbowqu4W7G/Zij+4ATUqfMRgADgVePop0jerdOmgAqBFF
         bWOnq3ZbYh+wnUjcG7654GX5HCxW9oNkJqiXygT/1v57tUN7lYX5L0ZnKiJXS2DpPIHK
         LRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702848739; x=1703453539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auyx6SZcEGnvEGrHnzOQrDxyNrYMhwUgQ6pbJgj8x3Y=;
        b=i6IubGn2kfDRIeW5hK6f50qKCyG3Wm/DqItUk3cyDotZQYoOllAUGPPC9lxYr8+rhD
         VSv3BCoVhWm5Zf0aJt+/JgyDudMByNb9Ki6tL/oKwVzvcPpseEXcVVrNO/vRIG/mW7+g
         4NU9n3GS37kwwQ/UCivD8HE8d2miyKGXD69y5WVpVz+rrM/c1FGeSSlEWrzz7F0DveuK
         CoaxZaZ0Vrl9S8p+WXe3iRB4xztW+qb+HpBepmiXiVWqa1KXVh8Cas+9coXfdBlt9SGz
         /W4WBtiFQep8IVJisME6ObF0UjJIvWG5+jj/cB32Ot589/HyYuPW3OBGFm1gleYl8x6a
         s+AA==
X-Gm-Message-State: AOJu0Ywu9HL1j59OW9gzVBxt7N5cliHF1ax8IsMGUgz0fVZ3/DRI6gyq
	nKOBakDCZqzO2hShkIRzAZU=
X-Google-Smtp-Source: AGHT+IHrVJh65QscY3p0Jy/D0oultjqQoAlOiktIjt87rcL3Qvqjz6HxK+awwKKSPzoRtatI2hoa3w==
X-Received: by 2002:a81:5f08:0:b0:5e2:6d88:5b41 with SMTP id t8-20020a815f08000000b005e26d885b41mr4928049ywb.16.1702848738771;
        Sun, 17 Dec 2023 13:32:18 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:9c41:1dd2:7d5d:e008])
        by smtp.gmail.com with ESMTPSA id p5-20020a0dff05000000b005d38b70b3easm8337664ywf.19.2023.12.17.13.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 13:32:17 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	yury.norov@gmail.com,
	leon@kernel.org,
	cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com,
	vkuznets@redhat.com,
	tglx@linutronix.de,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: schakrabarti@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH 1/3] cpumask: add cpumask_weight_andnot()
Date: Sun, 17 Dec 2023 13:32:12 -0800
Message-Id: <20231217213214.1905481-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231217213214.1905481-1-yury.norov@gmail.com>
References: <20231217213214.1905481-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to cpumask_weight_and(), cpumask_weight_andnot() is a handy
helper that may help to avoid creating an intermediate mask just to
calculate number of bits that set in a 1st given mask, and clear in 2nd
one.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h  | 12 ++++++++++++
 include/linux/cpumask.h | 13 +++++++++++++
 lib/bitmap.c            |  7 +++++++
 3 files changed, 32 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99451431e4d6..5814e9ee40ba 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -54,6 +54,7 @@ struct device;
  *  bitmap_full(src, nbits)                     Are all bits set in *src?
  *  bitmap_weight(src, nbits)                   Hamming Weight: number set bits
  *  bitmap_weight_and(src1, src2, nbits)        Hamming Weight of and'ed bitmap
+ *  bitmap_weight_andnot(src1, src2, nbits)     Hamming Weight of andnot'ed bitmap
  *  bitmap_set(dst, pos, nbits)                 Set specified bit area
  *  bitmap_clear(dst, pos, nbits)               Clear specified bit area
  *  bitmap_find_next_zero_area(buf, len, pos, n, mask)  Find bit free area
@@ -169,6 +170,8 @@ bool __bitmap_subset(const unsigned long *bitmap1,
 unsigned int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
 unsigned int __bitmap_weight_and(const unsigned long *bitmap1,
 				 const unsigned long *bitmap2, unsigned int nbits);
+unsigned int __bitmap_weight_andnot(const unsigned long *bitmap1,
+				    const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_set(unsigned long *map, unsigned int start, int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
 
@@ -425,6 +428,15 @@ unsigned long bitmap_weight_and(const unsigned long *src1,
 	return __bitmap_weight_and(src1, src2, nbits);
 }
 
+static __always_inline
+unsigned long bitmap_weight_andnot(const unsigned long *src1,
+				   const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return hweight_long(*src1 & ~(*src2) & BITMAP_LAST_WORD_MASK(nbits));
+	return __bitmap_weight_andnot(src1, src2, nbits);
+}
+
 static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
 		unsigned int nbits)
 {
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index cfb545841a2c..228c23eb36d2 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -719,6 +719,19 @@ static inline unsigned int cpumask_weight_and(const struct cpumask *srcp1,
 	return bitmap_weight_and(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
 }
 
+/**
+ * cpumask_weight_andnot - Count of bits in (*srcp1 & ~*srcp2)
+ * @srcp1: the cpumask to count bits (< nr_cpu_ids) in.
+ * @srcp2: the cpumask to count bits (< nr_cpu_ids) in.
+ *
+ * Return: count of bits set in both *srcp1 and *srcp2
+ */
+static inline unsigned int cpumask_weight_andnot(const struct cpumask *srcp1,
+						const struct cpumask *srcp2)
+{
+	return bitmap_weight_andnot(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
+}
+
 /**
  * cpumask_shift_right - *dstp = *srcp >> n
  * @dstp: the cpumask result
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 09522af227f1..b97692854966 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -348,6 +348,13 @@ unsigned int __bitmap_weight_and(const unsigned long *bitmap1,
 }
 EXPORT_SYMBOL(__bitmap_weight_and);
 
+unsigned int __bitmap_weight_andnot(const unsigned long *bitmap1,
+				const unsigned long *bitmap2, unsigned int bits)
+{
+	return BITMAP_WEIGHT(bitmap1[idx] & ~bitmap2[idx], bits);
+}
+EXPORT_SYMBOL(__bitmap_weight_andnot);
+
 void __bitmap_set(unsigned long *map, unsigned int start, int len)
 {
 	unsigned long *p = map + BIT_WORD(start);
-- 
2.40.1


