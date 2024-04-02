Return-Path: <linux-hyperv+bounces-1902-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FEB89573C
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 16:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33E21C228F2
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F51413AA48;
	Tue,  2 Apr 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ancif7vn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7715B134720;
	Tue,  2 Apr 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068835; cv=none; b=t7MtX4Qw+/gZiL4SXLcsNLaSW8ySobbxNSGD1UnKHJmrAnxpZPEyBIW8pnlVoy9UiuOylf38Vc4YdVkqZTMt7bPzUNdp881+QM6BgZuaZBDsR08+Gw+AkkqSautv/rrYQe7NBR/SXtWalK+3WkKp11mC2d/MCo5dazzMu6LEDv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068835; c=relaxed/simple;
	bh=CGrhuqWYPP8H290q1WEIekXlnoE7/jenzk4pjw4XnWg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cEvBSy+zNqw5+/o9Lk1zBvqfyc9vBIpkyiBdHQFPCKXOMunVMP8OmQ8jTBnqKzNYHQYtnunbEyIuzO/cb6moaPpeqTY+A4Zkumo9D7EGkT09GWFVa7Y625qA/lMg/qbrx0N5YPYtsJqIrbwo85t/OPxUbpqevsbJ0OroSNcTelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ancif7vn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id F25CA201F162;
	Tue,  2 Apr 2024 07:40:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F25CA201F162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712068834;
	bh=Bxbbj2SvqsN8wzO/KU4J8PCc7zlqP7qVbVq+Jfz0eaE=;
	h=From:To:Cc:Subject:Date:From;
	b=ancif7vnP5YK7ryXpaiERVAvn2qbsARmdOhkxPb25LuzfUbvWsxf4SHGa9o7UobKm
	 3CU7vJGjjPmF8CQmx/gGXogEWWVZxhsLhpdfDyasofHEPGSSWRqjbNzmWUI6JsNHYn
	 wJNyAYr+rUeSSM3UoXeYHivyU5v4c+fWPDadXCIM=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
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
	peterz@infradead.org,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: ssengar@microsoft.com
Subject: [PATCH v2 0/4] Fixing SMP config for DeviceTree platforms
Date: Tue,  2 Apr 2024 07:40:26 -0700
Message-Id: <1712068830-4513-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Original motivation for these changes was to fix an SMT warning observed
in Hyper-V VTL platform. Check V1 for more details:
https://lore.kernel.org/lkml/1710265404-23146-1-git-send-email-ssengar@linux.microsoft.com/

But on further review it was observed that x86 DeviceTree config has
modified recently, and there is opportunity to improve the existing
smp parsing for DeviceTree.

https://lore.kernel.org/lkml/20230807135027.064321764@linutronix.de/

Changes are small but I have logically separated them into four patches.
I am willing to merge them if there are too many 

[V2]
- Modified the approch how to fix the SMT issue, this is patch 3
  in this series. V1 for it is mentioned in above link.
- Added 2 more patches which are related to new SMP config parsing.
  These are patches 2 and 4 in this series.
- Fixed an issue with hv_vtl platform how it should use the smp
  parsing for DeviceTree with a fixes tag.

Saurabh Sengar (4):
  x86/hyperv/vtl: Correct parse_smp_cfg assignment
  x86/of: Set the parse_smp_cfg for all the DeviceTree platforms by
    default
  x86/of: Map NUMA node to CPUs as per DeviceTree
  x86/of: Change x86_dtb_parse_smp_config to static

 arch/x86/hyperv/hv_vtl.c          |  1 -
 arch/x86/include/asm/prom.h       |  9 ++-------
 arch/x86/kernel/devicetree.c      | 24 ++++++++++++++----------
 arch/x86/platform/ce4100/ce4100.c |  1 -
 4 files changed, 16 insertions(+), 19 deletions(-)

-- 
2.34.1


