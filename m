Return-Path: <linux-hyperv+bounces-8164-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5004CFB02C
	for <lists+linux-hyperv@lfdr.de>; Tue, 06 Jan 2026 21:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0835A30550F3
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Jan 2026 20:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC7129D293;
	Tue,  6 Jan 2026 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aH0fiRrJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71B52749D5;
	Tue,  6 Jan 2026 20:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767732422; cv=none; b=hHJUGIOK+fzy/gIC13QhN/ethuCuY5yDyAAbrIxIvfopULXM7TIClDWGrlBQfHZZmG+HoXkgvP1iY7nzkunAaH9QMvC1ps28k1RY8RbhN9gwDzhjdht5j94dGf+2uf4XNpoLtuAEgy2iK24rgl6dKvS/aAUpVPAp+TfcZzb/IRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767732422; c=relaxed/simple;
	bh=5GciWRNeDesprc5wddVQVxM2IcMxIdBAxMt2iGq4gk0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=r5RR1f+gUfUywypaRdZwlhyle4njZaW8gu319B5wtVRLt2vJAJg8rqykGZ9i27vnnVVRvRfPqB6JXkLAfbYU0JoqHF46sYZe84nrIUSOsi/zlFN68urMeY1k2JuQNccsSkRpoBLO5OIaQy0fdp1p+/7r4LY0j9EcOijoi+/gOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aH0fiRrJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 7B8EB2016FF9; Tue,  6 Jan 2026 12:47:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B8EB2016FF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767732420;
	bh=AY6Msj5KiNAXUZMujFdimcaR6Y4L46KP9IklLiE96Cw=;
	h=From:To:Cc:Subject:Date:From;
	b=aH0fiRrJeM/D6hm3cT/X7+jnT70M9i5wEaU7Ijn4DUrLPy+g0Ad0u+MAKp2oaDlHj
	 oanN8r3LQJ5pSA6tBbZJpshcH48ZHvv+/qaOWhHXAfrea1C32cX4pYRRaiuqvhZOSK
	 Sn0pjop7NMo6Naobg/QJ9zm5+nYXbDf3hxStPEP0=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH V2,net-next, 0/2] net: mana: Add support for coalesced RX packets
Date: Tue,  6 Jan 2026 12:46:45 -0800
Message-Id: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
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


