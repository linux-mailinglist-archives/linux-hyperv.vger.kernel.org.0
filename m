Return-Path: <linux-hyperv+bounces-4950-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1B7A915DF
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 09:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9BD3BC0BD
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 07:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EB32222B9;
	Thu, 17 Apr 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PbdFh24m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706AC21CC7B;
	Thu, 17 Apr 2025 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876638; cv=none; b=oLTtBJdOBxIsIUlnhQRd9C3YJPwAhTyCn4dmzmyBggPiVLoKBSwEAYq5yrDwsJrMJqj3T9QvqxBLFSYwcgb5ctVum4/bHoT7ltUGPuRhBwKs5YZEbZDqUBaUU0203ZCg9egG3lB+uxKNoT9aDKd1kNnNML7kJptZ0RASmTUVmbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876638; c=relaxed/simple;
	bh=13xHlsY61EkSejsLPZ23IxACNJ0NV+gOvYVIBuw6xfU=;
	h=From:To:Subject:Date:Message-Id; b=tqCCLPzHFw/8TvVqVLVapNY1ihFAJghqSxVFkYbpQTz0owAeAZ9TuTQLYXZI/KpdzVJj59kzwcdKc74RPwgu4pXXkWerO/inD5jsElQEQl6r0KmVZvVUBvPyfdNNLyy1WJR8j3bREyAbPRHoHKTTBd3zBFZz1tWMV/AG9e+NDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PbdFh24m; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id F04E021199C7; Thu, 17 Apr 2025 00:57:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F04E021199C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744876636;
	bh=QCGtOoOPCkFMxU8OEWg52zg84Z5FI97+rF/DHlAjGwY=;
	h=From:To:Subject:Date:From;
	b=PbdFh24muPk1natGqOQ4k6H7jzVLFbQAeWwrG2KikkFnaG3JbA1WLfS6qkSmQQ/+7
	 2/DgbsYOP/orw9824sqs2QeYLsS9zZuubwpxILBhab+yHyEQnOd9ofNRj6NwukLeS4
	 RE45MXL+lba5uGdZCksVi0W/cWGC3YBAwjaDlTdg=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	kent.overstreet@linux.dev,
	brett.creeley@amd.com,
	schakrabarti@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	rosenp@gmail.com,
	paulros@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH 0/3] net: mana: Add HTB Qdisc offload support
Date: Thu, 17 Apr 2025 00:57:07 -0700
Message-Id: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Introduce support for HTB Qdisc offload on the mana ethernet 
controller to enable bandwidth clamping for egress traffic.

The controller offloads only one HTB leaf to support bandwidth
clamping on the hardware. This involves calling the function 
mana_set_bw_clamp() which internally calls a HWC command 
to the hardware to set the speed.

The minimum supported bandwidth is 100 Mbps, and only multiples
of 100 Mbps are supported by the hardware. The speed will be reset to
maximum bandwidth supported by the SKU, when the HTB leaf is deleted.

Also add speed support in mana_get_link_ksettings to display speed in the
standard port information using ethtool. This involves calling
mana_query_link_config(), which internally sends a HWC command to
the hardware to query speed information.

Note that this feature is not supported by all hardware.

Erni Sri Satya Vennela (3):
  net: mana: Add speed support in mana_get_link_ksettings
  net: mana: Add sched HTB offload support
  net: mana: Handle unsupported HWC commands

 .../net/ethernet/microsoft/mana/hw_channel.c  |   4 +
 drivers/net/ethernet/microsoft/mana/mana_en.c | 191 ++++++++++++++++++
 .../ethernet/microsoft/mana/mana_ethtool.c    |   6 +
 include/net/mana/mana.h                       |  36 ++++
 4 files changed, 237 insertions(+)

-- 
2.34.1


