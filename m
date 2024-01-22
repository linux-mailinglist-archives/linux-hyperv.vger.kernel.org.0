Return-Path: <linux-hyperv+bounces-1455-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83650836C93
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jan 2024 18:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391FB1F26CD6
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jan 2024 17:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715213EA6C;
	Mon, 22 Jan 2024 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bXTGcyCe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161363D57B;
	Mon, 22 Jan 2024 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939265; cv=none; b=Jy+zl/qYICGaKqb8KfQozfVu8TX6Dpo0emyti+wWTrPmXpWk/hnQSKCXVy4L+tAJOJBFO3LH6Q6Ovsru3gZb0e+kBheIa87WOg2ifTkZrLh7Ceo/VdA2UJW88Fn8rxTz1ew9lsLgLBLCFBbuKduy2npe4IiPN16tcZgVsGUD+G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939265; c=relaxed/simple;
	bh=JYlP6PYFKBxEkI9PAgsSX46npvX9bKn6YKMVh4R9Y1A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=s6jwRfA+FDf207nyhb876JRADoufhgJMGpsWwK5q2sqTskK/Dy4eFjWrAigcygohsRE2WZhq/XT95dvn3db3q0GljJMBV1s1rLhKY/tczt+0KWJVXL+4TaGvSbr+zMxpBekVPp0bFUQv/DExSCYaDhQQvNri7EgOaOTXcITFvGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bXTGcyCe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 9EFC920E1AB5; Mon, 22 Jan 2024 08:01:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9EFC920E1AB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705939263;
	bh=Rw8jwgVZoYjfKXdEQm8UxCv82lHMwpdoFJrxNC9RYwM=;
	h=From:To:Cc:Subject:Date:From;
	b=bXTGcyCeohgLywzb+DCFeM7Q7EnH05mCkdpVg/tORXzu6Cn1yUSqTWt3alatzDSXi
	 gsPEbtNvGE5Wear/qASZTGozA9tj/QC6inEhv7JkBpSnm0Hg/SzpCEk1WPxke/qPeB
	 baFsP34J3/BlHQWiNPPqR1ZwGyXkWmEmGLuALczM=
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
Subject: [PATCH 0/4 V2 net-next] net: mana: Assigning IRQ affinity on HT cores
Date: Mon, 22 Jan 2024 08:00:55 -0800
Message-Id: <1705939259-2859-1-git-send-email-schakrabarti@linux.microsoft.com>
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

-- 
2.34.1


