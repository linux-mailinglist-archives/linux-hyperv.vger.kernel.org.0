Return-Path: <linux-hyperv+bounces-3783-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA74EA20F06
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 17:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B096B3A9176
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 16:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775DC1DED64;
	Tue, 28 Jan 2025 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc9X5FxV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B21DE89D;
	Tue, 28 Jan 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082821; cv=none; b=rXvtA1vkiheUR/mjh5kQXO1v4IIE3mRRDRMNdEBD79pmn6fqu8t4SaftSbTEX+VUevvSlLrgSH5+Z0wV8f+8ex/kVRTlqamS+C+aOm5iwWOVHepJZeIWazyBGlJyzj0FDrHlen//H/l9fyc7mrV6hsV87Uza3EOYjmZxHGAQfB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082821; c=relaxed/simple;
	bh=ZLbaWScI820HBD006hMz3NNgEber6YTKJOKCgmSkmLs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7VOFPLJg6iy/jEla/v+7r1swoP63DuZAeO8uDFs02F+8hAJ7zGdhP2cvzUnb6PLuRrlMrxIszIWUN86jDUfowsbiUMKRreUu9Bk/VDDqbHXAfgJ3wa2X7v2nnefcZshFy0D3CEJ9thfnWch3pERTdyAjp5eRSrPaTBs6ED/dlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kc9X5FxV; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3a26de697fso8810984276.3;
        Tue, 28 Jan 2025 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738082818; x=1738687618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCckKKNOPT0GHbl/F3PRHzvVHT9Q6qmCcPDx48VRDmE=;
        b=kc9X5FxVafYyw/xVty1V4ERNz05ClGQINcQ/EvA3MEuCtpwzjSwNPHdBVWsMulktMN
         0lg++oJXbqvG6UfsHutK6ZSLysW/c2+HedvyMd6WOmKq1U5L3M8ogTTW9X+4f34YU8Jg
         1T601YIiPdINKHC3hI2/lx4ohGdRmGjLrPpAIHF6rmcVemHC7+NUiRLzxHXButgUZI2h
         qB0nS5W95DDdvO6lnuC3y+DNqOBOdMpsFj+GmmvzcFgSHUyILmJ4Wa5y+nLxv/JmVplf
         kOdGEwYZwHOxHVX61UaqdZCtsOg7qAcVdOdJ+ouiMrGWnghG4uRxpX5pMK1yAcdw80wO
         2eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738082818; x=1738687618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCckKKNOPT0GHbl/F3PRHzvVHT9Q6qmCcPDx48VRDmE=;
        b=M4c5ym4Wzfz78CQxxBIIor1ARq44xlbJnbgMkSndfVgHFjn/EDXpB+GK7AKdFZZtBF
         DOgwsQx02LGqSLNepmm+U8Z8Wm/c+4IH6uvmZ2NCukdC+hMOXRwj58d+G5sYItJHm2fu
         1pNi4mX4oL2xkI5ML90+ZSpxoC/h8dP/eNsvXpmuBaE3XRmRC7as9p4Ynr+kU+CYkz4F
         UJs7qH7BNXvlRF2hLSNhb3cN6aleTZJeIJ3DEp00rwLIV+2RfBUQwKT4nz4MWdg1yvoE
         PaTM3YHOwKSZWYt5h+ujwSrJWPyTmlsqri8A90e1yVnxCdRHhz5/uPbDk8jDHkMn18zs
         34Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV+Tnl1eH49YhU0vRYYCXAnF9ukgqduaObeEic7C6ihO+drmArU61uEQ4TNdUi2bjE8nXx5XNrRoWiT72Q=@vger.kernel.org, AJvYcCVPX13fpkil+VbVBgS8IjNiF6gjxhhHc2SutQTeaIjiVptIRtzteZzNcI+qEzHupftCh9Gp+RIWI3zM@vger.kernel.org, AJvYcCVR/b93I8vu3sTkEA9xMl/QJJeXLaZjdXJI+C846Qnw5nadYsDHJEtmznusAq56Mwltd43/ceKOYUuZdUWG@vger.kernel.org, AJvYcCWfnKSGgk5/GJwuHIhFwfqQPwvje/fkxIFDIGk197gGhBJdgLlJzZsDrUDht7XU92+xH5PNO+eF@vger.kernel.org, AJvYcCXWwUAIU72o6hUtls33NOP/I04MxVZ64g+GJQtLPVg1BYxF3sGBvjIfnqDC9/cJUpPqzeL1w0oPyst7ig==@vger.kernel.org, AJvYcCXiB+LBCmf1O+zidOUhwoDzXc2HZu5vGB7GB3nqKn0W2p7Kq2xU2g/J7n4WHSt7DEXYpuoJEYuZ9PwtNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCudxGHkqcobTjDhWYXCU7vWQ0TZGKW+6t4Z4aWg/uSpWmSS1l
	3ztnAjH2K5AHYk+RhBna6kyM8bfJDbo8IHR8yzcJrtLjy3OZYoqAjTBc4+brCNQ=
X-Gm-Gg: ASbGnctg1oS7JEpht4vO57bvWKvXGaB7pjtwxfrXANOrNu3jRxYVc5+A+M/CJIoQdsv
	MGU8pSI9EfxLTrC6UoZGmPw8KSZHYRCihnV6boI4hPTPNhdgP/MDdcdsXebXL35OCrz+uUhzj+V
	asYIB5juMFWB7Pfi1yB370MEEtSyMZLmQkNmoH6iDw8MQp30rwIcStQK+sPhnC+N1c2DsZQlv8X
	HaC0BBjMR1Y34O+5qL+miX94LN6hb/6cc1PDbbz/vXXdDg7BzMmc6xvV0IJn7oL9464L3yagW0i
	PRRxFmeGRkJ1yC1xGgwsEK1ztqrRfDQjBQuOxL9DYzSF51NwnWY=
X-Google-Smtp-Source: AGHT+IFBJfNymvCDO315tC4xVxs+zkZuQynCdmKqW3cIaAkZSV4RPPUZkZxV0shs/Si+4edVpo1BeA==
X-Received: by 2002:a05:690c:c8b:b0:6ef:ac8b:529b with SMTP id 00721157ae682-6f6eb90589fmr351241927b3.26.1738082818497;
        Tue, 28 Jan 2025 08:46:58 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f75bf90de2sm17571157b3.70.2025.01.28.08.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:46:58 -0800 (PST)
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
Subject: [PATCH v2 05/13] cpumask: deprecate cpumask_next_wrap()
Date: Tue, 28 Jan 2025 11:46:34 -0500
Message-ID: <20250128164646.4009-6-yury.norov@gmail.com>
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

The next patch aligns implementation of cpumask_next_wrap() with the
find_next_bit_wrap(), and it changes function signature.

To make the transition smooth, this patch deprecates current
implementation by adding an _old suffix. The following patches switch
current users to the new implementation one by one.

No functional changes were intended.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/s390/kernel/processor.c        | 2 +-
 drivers/pci/controller/pci-hyperv.c | 2 +-
 drivers/scsi/lpfc/lpfc_init.c       | 2 +-
 include/linux/cpumask.h             | 4 ++--
 kernel/padata.c                     | 2 +-
 lib/cpumask.c                       | 6 +++---
 6 files changed, 9 insertions(+), 9 deletions(-)

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
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 6084b38bdda1..c39316966de5 100644
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
index 418987056340..78e202fabf90 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -290,7 +290,7 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
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


