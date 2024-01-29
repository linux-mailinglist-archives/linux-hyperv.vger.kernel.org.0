Return-Path: <linux-hyperv+bounces-1472-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6ED83FE2B
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jan 2024 07:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC871C22366
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jan 2024 06:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C8C4C3D4;
	Mon, 29 Jan 2024 06:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jSZtqzg7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3424E1BA;
	Mon, 29 Jan 2024 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509291; cv=none; b=QWSir/IqRCoH8YjZtzc3b7UO8+GGuW3eGyWhyMLZyMme4b5UHB7jEuA7T4vuiECjoNcovW2DKl5AhPmU5Yo3hbvkmi0sTrUginyzcjTuUROnzvghJFBoVVotbyBCoJUfsDAdUeXqMTPGF2QX7Jx3iN+YOW81UJQlPEDlsZ33/9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509291; c=relaxed/simple;
	bh=ec1CV2THC3H1N8o33FHc4Q4ijpR0Th7MXa1oozMc+Ew=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Cgzwo5g4fFeP7Asaamc+syDeScPW7t6xZZY5XAoYeqjA3Pmqi6PIBzWBXBTQTPkvs2AbJmxxj3ruepnD9wJVVZQ0YHiKqE9F8xtko0VPuZ5dJYGzveaANAcPrskVV0H4ThwV0xdfcZq7pF9JZb3PqemLz8xWThBi1lKqJoK7rTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jSZtqzg7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 108FC20E67C9; Sun, 28 Jan 2024 22:21:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 108FC20E67C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706509283;
	bh=jcQHPDqDH8my6Yg3JLMYBYEVM6vbGA15v2Ma7JnnpbI=;
	h=From:To:Cc:Subject:Date:From;
	b=jSZtqzg7Z/LHGLI+tcluq4k/xiPa8sO7gsoNtcAZaeIUYAXXZzaeeBvOtRXMg+DFM
	 QFr1bU7qG+LYs+qrJB3HGsQsvviftwdDy2sF6wAyoUZRq7llrFBht1cVV+OH+8WwFD
	 lg0saiuaj7R/A/qWiKyRJCsbZp7mfwD8F3OaywkQ=
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: kys@microsoft.com,
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
	paulros@microsoft.com,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: [PATCH 0/4 V3 net-next] net: mana: Assigning IRQ affinity on HT cores
Date: Sun, 28 Jan 2024 22:21:03 -0800
Message-Id: <1706509267-17754-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This patch set introduces a new helper function irq_setup(),
to optimize IRQ distribution for MANA network devices.
The patch set makes the driver working 15% faster than
with cpumask_local_spread().

Souradeep Chakrabarti (1):
  net: mana: Assigning IRQ affinity on HT cores

Yury Norov (3):
  cpumask: add cpumask_weight_andnot()
  cpumask: define cleanup function for cpumasks
  net: mana: add a function to spread IRQs per CPUs

 .../net/ethernet/microsoft/mana/gdma_main.c   | 88 ++++++++++++++++---
 include/linux/bitmap.h                        | 12 +++
 include/linux/cpumask.h                       | 16 ++++
 lib/bitmap.c                                  |  7 ++
 4 files changed, 113 insertions(+), 10 deletions(-)
--
Change:
V1 -> V2:
Added some details on the performance study on the patch 4/4.

V2 -> V3:
Commit message has been modified, fixed the table in patch 4/4.
-- 
2.34.1


