Return-Path: <linux-hyperv+bounces-8129-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F288CEF5A9
	for <lists+linux-hyperv@lfdr.de>; Fri, 02 Jan 2026 22:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B748B3004ED8
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jan 2026 21:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB2D2989B5;
	Fri,  2 Jan 2026 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ChXZpmQJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C881EEA49;
	Fri,  2 Jan 2026 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767389824; cv=none; b=fRhzZ3Z50FjoK68gIjlcc3dIIS/SDpvViLYTdk3lT4P3jCJQj0QDSU7t2y7Pzc6GBQOeL4agC+B9G6OOBGLXioZ0IBh9e6g4ZkSy9UbS3Z6U02VhzmzbbXHs4HbO471WQX3/AO6XXAd1KAHtOYo4/O0c8UiBFMarDEJqBk/KrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767389824; c=relaxed/simple;
	bh=5GciWRNeDesprc5wddVQVxM2IcMxIdBAxMt2iGq4gk0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lyLKgfjvQSV8/tTn8yvGtrB3TDUC9+aq/4Ok/ahAvE6GszGsqF5wOBtzamVbRRvN2tstYCdiVzMfK/75YBhDF3DbrgysrEL0jsUNQYyvktVCNPoyneiP2lSaEcYiJxYCxAhA/3SieSNff3b378GVgssJgVd8xMk+MO3ZiCLJOsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ChXZpmQJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 79D8D2125368; Fri,  2 Jan 2026 13:37:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79D8D2125368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767389822;
	bh=AY6Msj5KiNAXUZMujFdimcaR6Y4L46KP9IklLiE96Cw=;
	h=From:To:Cc:Subject:Date:From;
	b=ChXZpmQJhvJPOsfL+brMMBxj1WEO64pwXD8v1MckduFVVW8fu+21gN+oV6e8znMdu
	 EO866IWDYvS7aGDyhtmy+IfjnyQ5nY5nCBsSm4tJzh3M+IDfmVTQsS+DcBN1zI+BcE
	 1x9XZwUVxKrPr5D6TPv/vXZ9C6e7BW/IGlBqEsls=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH net-next, 0/2] net: mana: Add support for coalesced RX packets
Date: Fri,  2 Jan 2026 13:35:56 -0800
Message-Id: <1767389759-3460-1-git-send-email-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

Our NIC can have up to 4 RX packets on 1 CQE. To support this feature,
update the RX code path, and ethtool handler. Also add counters for it.

Haiyang Zhang (2):
  net: mana: Add support for coalesced RX packets on CQE
  net: mana: Add ethtool counters for RX CQEs in coalesced type

 drivers/net/ethernet/microsoft/mana/mana_en.c | 49 +++++++++----
 .../ethernet/microsoft/mana/mana_ethtool.c    | 72 +++++++++++++++++--
 include/net/mana/mana.h                       | 12 ++--
 3 files changed, 112 insertions(+), 21 deletions(-)

-- 
2.34.1


