Return-Path: <linux-hyperv+bounces-3550-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6979FDBF3
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Dec 2024 19:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F61A1882CF0
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Dec 2024 18:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5DF19B5A9;
	Sat, 28 Dec 2024 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL2ObHx2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1327119ABD4;
	Sat, 28 Dec 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735411805; cv=none; b=XiJUe1M9JimeHWQNYkHukjGRyrLg5Fa6k5Qp+yr8knAOefD4jRHbzweh3ClMqM1B84XNUT2p01jP+ZfwTjTIvJfbJEUTmhCs9JO2JR58x4bnE2SlaNR074iddxArohYJmaj1C2G147moJOVvUX7uNoLNNDeMAPUPBFt3XZLZzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735411805; c=relaxed/simple;
	bh=00KAaZiElDeuSwSawiskbWLQDjpCB7R5sWeWi2JBcew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xox75NfqjfdF5LDcjjgGe0gudl4DNihB51X26kIzUeBxtjoOZJfLIGc9cYE10A710jzFLLCSuHCkn9OEmG2ErxiVlj5ey8guNxJES6asYJc9Z1tcCFUSbjYfHrTcgk9ejFFcbofG4HaXdgJNaVGw+1Z4b1SsBhwK0aWeC74MSVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aL2ObHx2; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3a26de697fso8956710276.3;
        Sat, 28 Dec 2024 10:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411803; x=1736016603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bA6qa5mRtLx/JNJepZMf5RGZWm5ti1ameVb2qE56fE=;
        b=aL2ObHx2oNVLQwq4vzzcqeb7CgxJfKtxhe21VuYUNlYNmZ4B9TWc/12mv62z7tAk0D
         ZQZad+m2WeRSRDScpOuevkmmf2YaKue0pUCsbHJk2Eh9ErUFaXO+FfORBtUswlgdGj2a
         nli1y9vdXMmMviur0x+VVe/H1a3YvGdYxE1NOsxW1xerko2XRd+4B5GWFqpr5xrehB/m
         J8I0dSsFWJ9/cVJVndDYCV+CovuspuTOvoJkPeoXLtSswx2PL+r2g2aG4id/TQitn546
         qBGceh6QFw7JgThQFNab5PoZA5ew4Jx9g1qUUyPtVCpnQM5EBJHia+hlyEf+kwHun2Ww
         y5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411803; x=1736016603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bA6qa5mRtLx/JNJepZMf5RGZWm5ti1ameVb2qE56fE=;
        b=XaiCPctElVabZ+Wn2vyADiE65poDmKZreQqIqA0ySVhR7yZ2qPDXOIGYqotZogbjmE
         Zvk0Fl2Kug7893wcKfKGuWioso/wWwUta4rWxKPb5e8zkRbLDWrLJH7s73wDkB74f+7y
         ILtyUrdSg9PCnvz3KydV5mOHPWFdhYJvQ1dI3B88lU5aSsLqvg/ACAA4+jxHvwK/q1b0
         UelHFXR5dje5u6x3xRywAhyqI/lzTq3JmFGA9cGM8XOnok+6O0lPzzCtTGWyuLVJQeCY
         xIz45Ay8zQ/SGlK1HOeH6R4ixVzhDNTdIsCNKOMUMzdL5fHQ3FnUYOeFhjW6L0DAQwEs
         Zl2w==
X-Forwarded-Encrypted: i=1; AJvYcCUM0zyJvtu93rrgSqQhqnlJaLZq2xO92j5kTnak0AFLJ984BLEQyn4vDVPE+1MTUc+dfvowiS3hxsdRDjgT@vger.kernel.org, AJvYcCUcnmxVTxmN4sE5CLh4LRP2kv1NjcVrFVyuYV8O8SD8Rzaq3j6gpaetTgaVGLX6m/0cnBD/L8tb@vger.kernel.org, AJvYcCVUrxtRb5zOWsI31oiH9KkZTx0XD6j9oUan+QTIxAAD7aH5jiJED4jf3YQTsI3Ug/3ZDoB8luKIhQ/X@vger.kernel.org, AJvYcCXSCJw7yqWHzZdPanqULSvwRJbkOMo9gs5W8UKF1XK0gPCi/kjwqozhbLH91vB1sJxYvzMQTAPHtTI9Hxk=@vger.kernel.org, AJvYcCXds06KnQhPZ+I2iQ5eNPa1EvsmgbT94b0+KRDXGcl6N5rWMP5MMCqGBrdefmbihJGXbrukC3iAEOgTJg==@vger.kernel.org, AJvYcCXfUQRXOWZPY3E3AuPSlwzpPEYdMyGDpxFitUMsmgPl6qZabYY5LJWN1DcnfdAyJX58/FFNNteRd2piUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+uBW8v/PwWsCp2vIjcFs/z90sI/ZtIt+WUCoO1qnVZARS3R1
	WTiZth0pLm6XyFQ43BlhhFOx4TARwlZFZqcX4UJPhvCW78o6nh3medUSgGGiqXs=
X-Gm-Gg: ASbGncvWXJTis6OcAH9/JjphydM4SKiOkJooHMxgZ0bDndL8vtQRf1ssX0mFU3FyNAN
	+D+fbbAcP+nm6IVNVwbFgjh9sYO2ZxpfnaCr3Jr6xJSbODxdUxoEnT46W2hY15hkbHZUQegY4Yk
	7dk0DusZb43wGW4lOIIUJ+UNkBJMaHt0FcW7RIh+VtuvGogcFqetuFXLsjjAljvOkanedG251UN
	PDCdE/C6Qg8Z4DbGmhoeb6YHsHDMGf3f6I4ibMB4WAB+8GuVzyh7UbjLP8g5ZRcepmRx3mV0UG6
	X3pG7RkICNmYoNIJ
X-Google-Smtp-Source: AGHT+IEdltlfo7VoM/K9Hx3CK/leMoimfCHWr7pfYR9wsJX7DjblcCmfKrexz0jlZQgTcU9bnrqr/g==
X-Received: by 2002:a05:6902:1a48:b0:e49:5f2d:e71d with SMTP id 3f1490d57ef6-e538c267d16mr23706682276.21.1735411803005;
        Sat, 28 Dec 2024 10:50:03 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cbeba44sm5051923276.7.2024.12.28.10.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:50:02 -0800 (PST)
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
Subject: [PATCH 05/14] cpumask: deprecate cpumask_next_wrap()
Date: Sat, 28 Dec 2024 10:49:37 -0800
Message-ID: <20241228184949.31582-6-yury.norov@gmail.com>
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

The next patche aligns implementation of cpumask_next_wrap() with the
generic version in find.h which changes function signature.

To make the transition smooth, this patch deprecates current
implementation by adding an _old suffix. The following patches switch
current users to the new implementation one by one.

No functional changes were intended.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/s390/kernel/processor.c        | 2 +-
 drivers/nvme/host/tcp.c             | 2 +-
 drivers/pci/controller/pci-hyperv.c | 2 +-
 drivers/scsi/lpfc/lpfc_init.c       | 2 +-
 include/linux/cpumask.h             | 4 ++--
 kernel/padata.c                     | 2 +-
 lib/cpumask.c                       | 6 +++---
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 5ce9a795a0fe..42ca61909030 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -72,7 +72,7 @@ void notrace stop_machine_yield(const struct cpumask *cpumask)
 	this_cpu = smp_processor_id();
 	if (__this_cpu_inc_return(cpu_relax_retry) >= spin_retry) {
 		__this_cpu_write(cpu_relax_retry, 0);
-		cpu = cpumask_next_wrap(this_cpu, cpumask, this_cpu, false);
+		cpu = cpumask_next_wrap_old(this_cpu, cpumask, this_cpu, false);
 		if (cpu >= nr_cpu_ids)
 			return;
 		if (arch_vcpu_is_preempted(cpu))
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 28c76a3e1bd2..054904376c3c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1578,7 +1578,7 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	if (wq_unbound)
 		queue->io_cpu = WORK_CPU_UNBOUND;
 	else
-		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
+		queue->io_cpu = cpumask_next_wrap_old(n - 1, cpu_online_mask, -1, false);
 }
 
 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cdd5be16021d..86d1c2be8eb5 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1757,7 +1757,7 @@ static int hv_compose_multi_msi_req_get_cpu(void)
 
 	spin_lock_irqsave(&multi_msi_cpu_lock, flags);
 
-	cpu_next = cpumask_next_wrap(cpu_next, cpu_online_mask, nr_cpu_ids,
+	cpu_next = cpumask_next_wrap_old(cpu_next, cpu_online_mask, nr_cpu_ids,
 				     false);
 	cpu = cpu_next;
 
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 7f57397d91a9..31622fb0614a 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12876,7 +12876,7 @@ lpfc_irq_rebalance(struct lpfc_hba *phba, unsigned int cpu, bool offline)
 
 	if (offline) {
 		/* Find next online CPU on original mask */
-		cpu_next = cpumask_next_wrap(cpu, orig_mask, cpu, true);
+		cpu_next = cpumask_next_wrap_old(cpu, orig_mask, cpu, true);
 		cpu_select = lpfc_next_online_cpu(orig_mask, cpu_next);
 
 		/* Found a valid CPU */
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 30042351f15f..b267a4f6a917 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -296,7 +296,7 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 
 #if NR_CPUS == 1
 static __always_inline
-unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
+unsigned int cpumask_next_wrap_old(int n, const struct cpumask *mask, int start, bool wrap)
 {
 	cpumask_check(start);
 	if (n != -1)
@@ -312,7 +312,7 @@ unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, boo
 	return cpumask_first(mask);
 }
 #else
-unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
+unsigned int __pure cpumask_next_wrap_old(int n, const struct cpumask *mask, int start, bool wrap);
 #endif
 
 /**
diff --git a/kernel/padata.c b/kernel/padata.c
index d51bbc76b227..454ff2fca40b 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -274,7 +274,7 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
 	if (remove_object) {
 		list_del_init(&padata->list);
 		++pd->processed;
-		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
+		pd->cpu = cpumask_next_wrap_old(cpu, pd->cpumask.pcpu, -1, false);
 	}
 
 	spin_unlock(&reorder->lock);
diff --git a/lib/cpumask.c b/lib/cpumask.c
index e77ee9d46f71..c9a9b451772a 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -8,7 +8,7 @@
 #include <linux/numa.h>
 
 /**
- * cpumask_next_wrap - helper to implement for_each_cpu_wrap
+ * cpumask_next_wrap_old - helper to implement for_each_cpu_wrap
  * @n: the cpu prior to the place to search
  * @mask: the cpumask pointer
  * @start: the start point of the iteration
@@ -19,7 +19,7 @@
  * Note: the @wrap argument is required for the start condition when
  * we cannot assume @start is set in @mask.
  */
-unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
+unsigned int cpumask_next_wrap_old(int n, const struct cpumask *mask, int start, bool wrap)
 {
 	unsigned int next;
 
@@ -37,7 +37,7 @@ unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, boo
 
 	return next;
 }
-EXPORT_SYMBOL(cpumask_next_wrap);
+EXPORT_SYMBOL(cpumask_next_wrap_old);
 
 /* These are not inline because of header tangles. */
 #ifdef CONFIG_CPUMASK_OFFSTACK
-- 
2.43.0


