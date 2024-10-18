Return-Path: <linux-hyperv+bounces-3153-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D816B9A3DA4
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Oct 2024 13:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1281F21B97
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Oct 2024 11:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4B0DF5C;
	Fri, 18 Oct 2024 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HpnAXpUJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C20179BD;
	Fri, 18 Oct 2024 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252699; cv=none; b=Am+a/0jqOhxQE7SugJ5r8RJqjoWxG70+hpLfYsw5nRArBxnGg3bPHq67l0nM8dzYTBr5AR089QN5PZUZjX6aA3BBm/aQXczA6w4bV/vmanAibRS3vLbIdc5lOIYmrg0ECQdXZM51BvfVN9CJwjp0n92lbuQD1FlCs1t2ZOcewyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252699; c=relaxed/simple;
	bh=FoVY3P+dkyEn1SWQ9ZUM9aCshtQ1vE7jS0OV3E2b8x0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F8aC96+2ScMl0XYnavuRSkqxs6ICHRVbAeVQdDTcZyXrXgTkUBQnTzIehUnAH3377wG8mgnS2k+7XdL5ZVmCfvLsRq3snx5JQyN1FPK0Ikql2DiUyRjdZOwuuplWU2R6AonCn+zmx51/i0dhsvo7VYEe3/+CCvTxUdEWUnltK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HpnAXpUJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.corp.microsoft.com (unknown [131.107.147.150])
	by linux.microsoft.com (Postfix) with ESMTPSA id D8F0C20CECAC;
	Fri, 18 Oct 2024 04:58:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D8F0C20CECAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729252697;
	bh=dtC0uJaKntPOoglRd28A23lF01Ckdn3wHUspz7OqR/w=;
	h=From:To:Cc:Subject:Date:From;
	b=HpnAXpUJWq6fakJSAigCKmTywxfCYC24HG2Rz2WcbxWRDo+cYuQPeqBn8HLeFoY4p
	 YD36byegJ2nQqk99RjlUSG3hqkJqYG5m4/25aO9RJmM5GJbSwAsjmHpLfsn3vV7IVJ
	 ZP92X7rE/S0D1UjC6HkONZR3qwPjgf1H9jn2367M=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naman Jain <namjain@linux.microsoft.com>,
	John Starks <jostarks@microsoft.com>,
	jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH 0/2] Drivers: hv: vmbus: Wait for offers and log missing offers
Date: Fri, 18 Oct 2024 04:58:09 -0700
Message-Id: <20241018115811.5530-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After VM requests for channel offers during boot or resume from
hibernation, host offers the available channels and then sends a
separate message when all offers are delivered. Wait for this
message to make this offers request and receipt process synchronous.

This is to support user mode (VTL0) in OpenHCL (A Linux based
paravisor for Confidential VMs) to ensure that all channel offers
are present when init begins in VTL0, and it knows which channels
the host has offered and which it has not.

This is in analogy to a PCI bus not returning from probe until it has
scanned all devices on the bus.

As part of this implementation, some code cleanup is also done for the
logic which becomes redundant due to this change.

Second patch prints the channels which are not offered when resume
happens from hibernation to supply more information to the end user.

John Starks (1):
  Drivers: hv: vmbus: Log on missing offers

Naman Jain (1):
  Drivers: hv: vmbus: Wait for offers during boot

 drivers/hv/channel_mgmt.c | 38 +++++++++++++++++++++++---------------
 drivers/hv/connection.c   |  4 ++--
 drivers/hv/hyperv_vmbus.h | 14 +++-----------
 drivers/hv/vmbus_drv.c    | 30 +++++++++++++++---------------
 4 files changed, 43 insertions(+), 43 deletions(-)

-- 
2.34.1


