Return-Path: <linux-hyperv+bounces-8030-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37857CC3A22
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 15:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B82BF30D48D1
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097D530DD3A;
	Tue, 16 Dec 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="tx1jQlyM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA7313532;
	Tue, 16 Dec 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895362; cv=pass; b=Rxq3P62w4RU9WcvAu9ysuF1DKTGDtcpz+Gj4spLZj0f0DLg+ZB2j33kMGINLk8vZVu37QbVyeAbKZJ7U4iGhLRIKiJ8BiRBKElkiT/tzZbXlFNrBqYU4l2mijbLh+4Giu2hUbfvSi9KtFKCzhNT9jBc52TVHKGYfNGzonZBPkFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895362; c=relaxed/simple;
	bh=iTG5kudv0LLqMSfUADCRTDCdWv3Bb2JZP3g2DxjmPBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ht0m08IpDCzCTJcJ/F51VkOJ+bBm4lHyAHZlRxzull6uIhPcJFIHCQEjPzhT0xl0DQfpM/GNSRFv0pm2gTKDkPnK1S0eLROIc9USboZ46I/adzFLiP40BaaJppd+h1/xWc4C/6W55A4DVdXpYW4h/f9OwJgj64rzqyAeFAjGqF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=tx1jQlyM; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1765895343; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bwT1jyUkcMrddUns2lPM06gls4cAMpu60XShULHqKKhiA51CNrMdUZYiGE3LFmkhikR7mEU49dZaCRwFbOnfcCbyyTZoVNL0QHEuhaP8DAKGVMYfJIsVBJ0rvQEW7b+r276/gW6X4VAObMQr3zblCJinuPvNTp1pfwJz99Hsknk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765895343; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=92HO9inEmk9leCSO2rvQ+LumJHx4Ox4JH2MG3d3mlfs=; 
	b=BiJtnLkOUdd1Coq3yuEMrLMsgCKcG15BWSo7BmVQJvWktcxsxTZGMdQRQblFsJVdAJz3THMNFH1Nu+OM1w3vfsRkLioZFPJuxONjqlOWc6DfOLw8sW+OWT3H/BTuwSuVb5FwjrlhaIS3SErWUd0vleUpUEpBmDfYv0LR45HhuZA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765895343;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=92HO9inEmk9leCSO2rvQ+LumJHx4Ox4JH2MG3d3mlfs=;
	b=tx1jQlyMT6OKIO9dvlLZ+CJe7A9uJ9oPZ5I1aDLQq4dsLiZLwyeN7iFc389sKjLB
	95z8jdTSMxOVMpSUrptH87Mbrzx91UcHd/GTn0hsLT5kknFyvnAmo2yPaBjx62VDk6A
	DvATtM+C0lpLgAnuiaIxncLy44KCYiCI/HnlHNRM=
Received: by mx.zohomail.com with SMTPS id 1765895341555361.763133173876;
	Tue, 16 Dec 2025 06:29:01 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH 0/3] Fixes for movable pages
Date: Tue, 16 Dec 2025 14:20:27 +0000
Message-Id: <20251216142030.4095527-1-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>

Fix movable pages for arm64 guests by implementing a GPA intercept
handler.

Fix an improper cleanup issue in the region invalidation failure path.

Anirudh Rayabharam (Microsoft) (3):
  hyperv: add definitions for arm64 gpa intercepts
  mshv: handle gpa intercepts for arm64
  mshv: release mutex on region invalidation failure

 drivers/hv/mshv_regions.c   |  4 +++-
 drivers/hv/mshv_root_main.c | 38 +++++++++++++++++++++++-------
 include/hyperv/hvhdk.h      | 47 +++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 10 deletions(-)

-- 
2.34.1


