Return-Path: <linux-hyperv+bounces-3549-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 559E59FDBDF
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Dec 2024 19:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93673A143D
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Dec 2024 18:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422CA192D95;
	Sat, 28 Dec 2024 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq/xuTBu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B1478F34;
	Sat, 28 Dec 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735411797; cv=none; b=Pe3PFPtIs6Pw29IemAo3ag7xcJWDbdjuCGFrRBitywSZS+M6GVWsyFWfs3ZhdJo0mXBZVbxwWmob/7Ks7kQa6BS3wBXBUnhvhrn0sLMr4pOjMnTRM8MGek9G/Ya9RV6iT4XA4XioJClmzHFR0HpATyk/m238axMLfS5KwElJqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735411797; c=relaxed/simple;
	bh=1yAI3ZDHyUkDV9UQDHx22Hbwp4ZXby1Wc02tN6J1Y4M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MWDQj6D4k513gI7QV7oxevADx80E8TWYfHZVFW4vBOngZJsyIZQfDJpPTWnqpgMwKmzDMq+Wp09sa6t0t6FISWTvcG+v9nOdYBMLQs+WhbQprECnt10pPx1Sb+E7XhEqYHNVbMvMokQM0qdRr51uDJGshBIUdt9npar/h5IqwdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gq/xuTBu; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so4633297276.3;
        Sat, 28 Dec 2024 10:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411794; x=1736016594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmPTlVzrMWsZV/0UuabLUVbV1EH4j//h4cVfthapkOk=;
        b=gq/xuTBurrj1cIJFk2EBHB5j3HScOX88aqR54EhRNsU9CKBkCC0euiBrTTjqE8HXCn
         J76Y3mfQoOhI2X+gX1luJYrJPXNhwlhgOe0JMryVbFI8CgkNk5PUZvWDeFMfAe1srcC5
         dzNfsJT9iQWQWp9GKCCfFWUm/5U0z/mZaQuG/hyUQ+4yP0AvlDr/B+cA/fAzKwTe0Hdp
         a75t3NvSWd2sbmG8CHaZ5hFGHUb95Rjlaw82xPEPr91mslpFN8H3t3UI+NBVnAlGzP+B
         s0apu7wPjdsjnMKb2HXX6nriitYB9RV1igLI6dy6AxeVJW+wOAI4+ncgMQAHPpXiWtO7
         vLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411794; x=1736016594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmPTlVzrMWsZV/0UuabLUVbV1EH4j//h4cVfthapkOk=;
        b=nu5Fm33A79J69WSTBdY7Ng0EkdSZbz2NlrHGrG9fi7W0JfJdaNh/pKvdopAxcSjwGh
         vg8RXaBeM76SlbLRYKPYM19kPD0M0aOno7otU5Yntk2Lsrn+mB6FjkNxDCNCNHGqHe3H
         kpWuSKY/b7VYEK8T25VP6UkhymedjTfMdh+atlaDBWrxsrC10NOt4zr8CizgK4LHEnmB
         +uvvxT1ay9diQ4s6QiCAmUMPX+At++pmulJ4z6wuzoxmDrhiT7P1YqTbud3X6nz1S58J
         i86/pH4abwF7VgQ2GKa5XW4RE+5IF7qsImpGk2C4P1+jGKiJqMIPc3/+ZrZj75iJA1Qt
         fhjw==
X-Forwarded-Encrypted: i=1; AJvYcCUC04k8Xxup8BZfJkaAefS6giGWoiAniwcYaRXbrqM6L3t3Z6eQuY4mzNSCh8BLQu1Ze2hl/ii12US1EA==@vger.kernel.org, AJvYcCVcU0+8XK1sZgYsFa+RZmoJOD0aPR6XcgQFGn6qs3/s4pa91zLirkRppBmYTysO7NHK7U6sgyv8@vger.kernel.org, AJvYcCX1CHzBZYYw1s/6MyGo4m3or5ansdrBh+2mWpZ3JdsvSUuZ4O7xZ+vW3fmqWQuTaEZT4woG0Mw2FyjoYmA=@vger.kernel.org, AJvYcCX8n/qCITBtrw86FAt2+i2s7Q3ufr+W6fMNsalPwg6ZFVn4SfARdiOxvuqwl4JNL+sUDjmeZljbfX13hgIr@vger.kernel.org, AJvYcCXJOmd9bM8lmoh1B1fSuvpeqkv6ATKdXI/gvxVhfxE1rxpjO3/QJvI1yxxUMAaFPidAtn/8/Lz8JBF7mQ==@vger.kernel.org, AJvYcCXh7O5RwqvPbkfIu1inKDniW3FYZRzusynZPyd3ZsGVydwlUlJTeSXLOf9ZHlfD2XGwWMyg54k6Xd0I@vger.kernel.org
X-Gm-Message-State: AOJu0YzsS1C57ipjEYmauOhS1FTiV5EO5tY3vDwhJqHLPX7uA3W/8Izu
	yTBrx0sTL1jZOHmX/gLOgRaCOWFaXSn0CKWMV0B7QKSWv2zWalHgIWYgMLaYXD8=
X-Gm-Gg: ASbGncu2bgunPziC7dwfv0XaZ/+F0zifhWZu1O9IFN4qeoXUSygTtsQeOkQSuoT9Tm/
	rkriyLMAg7CVWbbX4rhkTRkRmb9Tuag0jt++Cmb5kCmvFCbQsRmfXj23Wm2MbythLGGc54iOj+x
	b/Q0SpYW7Cq7YdTzsx3vIUzLMFcaoxJCM5jf3tUi5vYkWgA1Kjm0Ymm25Rk7mfNuXjeKTlrnR/7
	8JUoV7YenQm44LGi5aC9WCLXy/DdU1DdllxCfrA6EkGHoCnUBu8Nm8xVN5M5hEFUsSgCcBLOBB8
	76nH5fPb7lsj3jaz
X-Google-Smtp-Source: AGHT+IEkJJFH0m3oTNAbR0yAINMZTww0cO+zE7+Lf9uNhKvuTxiLtpcDAvH2RV2/PHCyo+AVfgp8KA==
X-Received: by 2002:a05:6902:18c1:b0:e39:8b94:16e6 with SMTP id 3f1490d57ef6-e538c3a2eb7mr19599866276.39.1735411794393;
        Sat, 28 Dec 2024 10:49:54 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cbedbe7sm5061343276.4.2024.12.28.10.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:49:53 -0800 (PST)
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
Subject: [PATCH 00/14] cpumask: cleanup cpumask_next_wrap() implementation and usage
Date: Sat, 28 Dec 2024 10:49:32 -0800
Message-ID: <20241228184949.31582-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpumask_next_wrap() is overly complicated, comparing to it's generic
version find_next_bit_wrap(), not mentioning it duplicates the above.
It roots to the times when the function was used in the implementation
of for_each_cpu_wrap() iterator. The function has 2 additional parameters
that were used to catch loop termination condition for the iterator.
(Although, only one is needed.)

Since 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
macro"), for_each_cpu_wrap() is wired to corresponding generic
wrapping bitmap iterator, and additional complexity of
cpumask_next_wrap() is not needed anymore.

All existing users call cpumask_next_wrap() in a manner that makes
it possible to turn it to a straight and simple alias to
find_next_bit_wrap().

This series replaces historical 4-parameter cpumask_next_wrap() with a
thin 2-parameter wrapper around find_next_bit_wrap().

Where it's possible to use for_each_cpu_wrap() iterator, the code is
switched to use it because it's always preferable to use iterators over
open loops.

This series touches various scattered subsystems and To-list for the
whole series is quite a long. To minimize noise, I send cover-letter and
key patches #5 and 6 to every person involved. All other patches are sent
individually to those pointed by scripts/get_maintainers.pl.

I'd like to move the series with my bitmap-for-next branch as a whole.

Yury Norov (14):
  objpool: rework objpool_pop()
  virtio_net: simplify virtnet_set_affinity()
  ibmvnic: simplify ibmvnic_set_queue_affinity()
  powerpc/xmon: simplify xmon_batch_next_cpu()
  cpumask: deprecate cpumask_next_wrap()
  cpumask: re-introduce cpumask_next_wrap()
  cpumask: use cpumask_next_wrap() where appropriate
  padata: switch padata_find_next() to using cpumask_next_wrap()
  s390: switch stop_machine_yield() to using cpumask_next_wrap()
  nvme-tcp: switch nvme_tcp_set_queue_io_cpu() to using
    cpumask_next_wrap()
  scsi: lpfc: switch lpfc_irq_rebalance() to using cpumask_next_wrap()
  scsi: lpfc: rework lpfc_next_{online,present}_cpu()
  PCI: hv: switch hv_compose_multi_msi_req_get_cpu() to using
    cpumask_next_wrap()
  cpumask: drop cpumask_next_wrap_old()

 arch/powerpc/xmon/xmon.c            |  6 +---
 arch/s390/kernel/processor.c        |  2 +-
 drivers/net/ethernet/ibm/ibmvnic.c  | 17 +++++-----
 drivers/net/virtio_net.c            | 12 +++++---
 drivers/nvme/host/tcp.c             |  2 +-
 drivers/pci/controller/pci-hyperv.c |  3 +-
 drivers/scsi/lpfc/lpfc.h            | 23 +++-----------
 drivers/scsi/lpfc/lpfc_init.c       |  2 +-
 include/linux/cpumask.h             | 48 ++++++++++++++++-------------
 include/linux/objpool.h             |  7 ++---
 kernel/padata.c                     |  2 +-
 lib/cpumask.c                       | 37 ++--------------------
 12 files changed, 60 insertions(+), 101 deletions(-)

-- 
2.43.0


