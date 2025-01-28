Return-Path: <linux-hyperv+bounces-3782-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616A0A20EEC
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 17:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2551F7A1C07
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 16:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D051AB6F1;
	Tue, 28 Jan 2025 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PywFc3sI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700892904;
	Tue, 28 Jan 2025 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082815; cv=none; b=T4PJRgH+7zsceXUgCb0no4Vmx9DPtZCLBJVpaCXHdz6lEudr2Mr9KNmJyooPWyNVagxiJBgKi84oizDrMetThKylUYxXy83aPxGTnEGSQ9tYI03eCMnIHxN0G/lrJMrU2qA1Tl99MlAnknMij7qt2Itm1B/E9dF9pJveY9dARL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082815; c=relaxed/simple;
	bh=MnNisqc0NqM7r0VRLdYxL9biktVBMmD/OyitwnsNYBQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n2NFDmO4g907QLI9+Rl4GLTpewG+m1dZVGJPOdTMdPg4BAUsWtLUI6iZmpnxOp80CzAT1+6Rh9Jz12KpCby7uJCGA+aZvSXSNpas+/iNsruAbC6bW1ovuz9OzhGu+3bVhLf6Qb0GMkGlZJiEnZW6MswMg+o+peDLFKiL1cDJXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PywFc3sI; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e53a5ff2233so10578620276.3;
        Tue, 28 Jan 2025 08:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738082812; x=1738687612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7I3FQn+a3IeKpvoyXVLY346phLoqlukuEhizyoucyY=;
        b=PywFc3sI7IvCYfljupHJDeqTN0qgHFuNtm2sh616Yi8HMGe2uxDSrhfnaTmR9sg7vQ
         6ast+9ATzSkJ3NlSFXzTAo2bhl7P5evAdCuyTOgOxOFJEULLPZ+35CwXDkjsXi9N01iO
         11ZXNqCgIg0hMSYsOxxKFzmlqsrB2cLYt4VyXBOp6SajaegBWAn9ZGn2IejJ1U1KrlRR
         YEY6BMmnxLUeFIvcoD9Uv+yHiIS1k8B26GdLmR925inSOod88Dg3/3alN9VKd8/aB3dS
         +mz70cyQvZLp3MqNQT7L8inlKyB6EOg0bZF2mpmr35eBUdxtue7z/kQKv3zUHWuN6Oxc
         55DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738082812; x=1738687612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7I3FQn+a3IeKpvoyXVLY346phLoqlukuEhizyoucyY=;
        b=u2JorK4Vnik8rYcCOp4uMQ8ZAKh3jjQEm914r9ZMQMbJLX2fWTrPSzGXrhgkdsDchW
         4Mq5I2CamEzSyRI5iXOoAvNMcH1QCzVCEfpo/2/llO3zjna9dVAqowVS9Hd16By6sZGt
         X5jzvrzouqnwS/Q0xqt6jau/anRShgoL983+0MBjKrFI/CmkDqQuzBH1enN2ul1GDXMl
         bOrfCAxvkCCoN4v0d5V/uDCWsHfbG/9wtlakGNF2fBvtpu0yAgnYa8B23dpxKdABd1r/
         u6S56tLJ01scBuKsGqAgm3DupUqnYILcCfcbzYm9QS+NubYDmk2B5Qck0qc2+h5SaWBw
         6d8w==
X-Forwarded-Encrypted: i=1; AJvYcCUw7A4/aKodNnfvJHQ9JFMNzR3F2GOT4qtClourtrtGxU5WXERiJTuFnJ0d7VKf7eierPEZ8y7W4Sxb4A==@vger.kernel.org, AJvYcCV3QVjvxW205kpZNF74ZCGay4xwepFP0ZT+W/GWCPrncTH5Qo3tVZBS782yjvzL3nd9e0lrTfY7@vger.kernel.org, AJvYcCWuh9YLWqNU+pS2jYMh7lExdNi5NKoIG1Y7AjyNwoOz8sHPM84dDuZlXV/0PW9UEX9+xBKqXX0oq2d46pMZ@vger.kernel.org, AJvYcCWulg7RuwxTFIT+30FXb1AI8UnASifUSUqn1fzIpcMKlEWEEZ9+LuIVPaP2V9gWNh96StgLW9/34VVw@vger.kernel.org, AJvYcCX1HbcttBIKrNALy0J9adrE0rj+9P2QYOaBNBW+JSowLrDufexrqfLsDJOMuP+oGm7VbF/uQTGO08bS81Q=@vger.kernel.org, AJvYcCXqK43iZzu1fqPj4nVKYyfryRzLnMFbjlm3Ys2mUZRkHvT60NvIt2gEODfD1fD6BsSp2JIBas5Pyx8wdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjo2ljoqSVzCl6flbi/G8VHhaHbEsQBqLWSSE6l/W1ZVFhFb6Q
	n1iL+GisL04b+8zPZhhgXujr4kHhKK3WoyCJSRX5X32tpJ6ZCfPyCVomGxa1/Ao=
X-Gm-Gg: ASbGncuBMGFLWFBJEjwXGljiZN+hN4PXJTkMqLfvMVQg+5kEG6DGk7aemKsJLfBuyE6
	AWHEQFd7im1O5LwqrTpuVlEuR5gFnthWrBs/3kpzW4p1hAeugRNDXV+JiXabqhxdr2eDRMkI/Jn
	21ayFxP8xiHMzyZjK0QPyeW0oEN4sXfmDs7aLH9R0xHCBfSUmHoaOEKxvaNWsFzKeX/O5w2/HdU
	vmiMM+Nn3gZVeWOhMao1xAPt0iKJYriGSe5tibfo0JBu520VFMi0YT/a7BVSihEvd40sUHPHbM5
	po/lcQKWxEdfIhpmCFU2gvf8/rUXkQK6UxNipyBj3i6qzdexi5w=
X-Google-Smtp-Source: AGHT+IFvmgf54bypeg06iXMG7R6vW3zKyn1725RIYJUIjUALciExdJNbHjTn7B/5gtx7qirVGTp6aA==
X-Received: by 2002:a05:6902:70c:b0:e58:5a:7694 with SMTP id 3f1490d57ef6-e58005a7945mr26770575276.20.1738082811957;
        Tue, 28 Jan 2025 08:46:51 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e583b7697c9sm2098812276.16.2025.01.28.08.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:46:51 -0800 (PST)
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
Subject: [PATCH v2 00/13] cpumask: cleanup cpumask_next_wrap() implementation and usage
Date: Tue, 28 Jan 2025 11:46:29 -0500
Message-ID: <20250128164646.4009-1-yury.norov@gmail.com>
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

v1: https://lore.kernel.org/netdev/20241228184949.31582-1-yury.norov@gmail.com/T/
v2:
 - rebase on top of today's origin/master;
 - drop #v1-10: not needed since v6.14 @ Sagi Grinberg;
 - #2, #3: fix picking next unused CPU @ Nick Child;
 - fix typos, cleanup comments @ Bjorn Helgaas, Alexander Gordeev;
 - CC Christoph Hellwig for the whole series.

Yury Norov (13):
  objpool: rework objpool_pop()
  virtio_net: simplify virtnet_set_affinity()
  ibmvnic: simplify ibmvnic_set_queue_affinity()
  powerpc/xmon: simplify xmon_batch_next_cpu()
  cpumask: deprecate cpumask_next_wrap()
  cpumask: re-introduce cpumask_next{,_and}_wrap()
  cpumask: use cpumask_next_wrap() where appropriate
  padata: switch padata_find_next() to using cpumask_next_wrap()
  s390: switch stop_machine_yield() to using cpumask_next_wrap()
  scsi: lpfc: switch lpfc_irq_rebalance() to using cpumask_next_wrap()
  scsi: lpfc: rework lpfc_next_{online,present}_cpu()
  PCI: hv: Switch hv_compose_multi_msi_req_get_cpu() to using
    cpumask_next_wrap()
  cpumask: drop cpumask_next_wrap_old()

 arch/powerpc/xmon/xmon.c            |  6 +--
 arch/s390/kernel/processor.c        |  2 +-
 drivers/net/ethernet/ibm/ibmvnic.c  | 18 +++++---
 drivers/net/virtio_net.c            | 12 ++---
 drivers/pci/controller/pci-hyperv.c |  3 +-
 drivers/scsi/lpfc/lpfc.h            | 23 +++-------
 drivers/scsi/lpfc/lpfc_init.c       |  2 +-
 include/linux/cpumask.h             | 69 ++++++++++++++++++++---------
 include/linux/objpool.h             |  7 ++-
 kernel/padata.c                     |  2 +-
 lib/cpumask.c                       | 37 +---------------
 11 files changed, 81 insertions(+), 100 deletions(-)

-- 
2.43.0


