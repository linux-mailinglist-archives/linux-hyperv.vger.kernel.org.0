Return-Path: <linux-hyperv+bounces-8147-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0739CF38BE
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 13:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60E02315018E
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 12:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA08131986F;
	Mon,  5 Jan 2026 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="S3ujpSA/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EDE33439D;
	Mon,  5 Jan 2026 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616138; cv=pass; b=AI16VD0CSC8Cbe5oDZvr9sgA3RMcM+PCRaI/JZnt8B8sVP/65E6U0rYkL+MqSY3e4vYCeueLYtTCQtPXPvKG+OqMKAPph+rmSZBCcyOIPfo2QINMe7bono9H/97Bkwppzs5cTY4VGyvkvha/d6R0MB+dohU9fAHzO2V2c93HocM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616138; c=relaxed/simple;
	bh=sXUEgWsvX+EqRvdfdhN5jZPw6lCndf14R9pGl/1pQEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QfcplayEMs6oIAbkTRQQwZ0QpfkASlqzIUU9CehMhNwnc56kD8cxex416Zp89Fwx6DsVT95N60deLyojYmnM3LPUbmYozc6YnNqjAdPW9PDlhhXgaJXDXD23RvL7xSSVMtr71c1iAKq7ztj5ZCSecaA+wttM2qt7vTYqdelPFP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=S3ujpSA/; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1767616130; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IDinyRQciuzoo2uQEfpotrtjhbTOsBgbunQSJ5E2fRTCIjw/CrEgqS/W/hqaKIav1b1yvp7Sv4RlURj6VRIs20l8B7GrZqLMveh0PaQFbOP9ORUV1MVuKP/S9GaYOuvFVWkFuIPAfRY/2QWFjyTQW9HCTuETFAJc8AlT4oFxTak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767616130; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Lv1Yh6zj+Fw0W+yne6drrS5s9HjhMtqsKmNNkEIv2JY=; 
	b=BpfhIrU1Dz3Fiujb+8dU7QLgDbZbht5uBe1Or3T8lZWCNPlp7+EsE8UfL+97Sl+SL9uPSf1aPu1+nx6VyRWaug6Oz6K7Dce+oOLuMG0QnhNBvC0+QSgPjVY/hBMYjJSGTjXAS4NsijKjJXJIeoXMmM0f7JwONf3HZweEu2pIIMA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767616130;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Lv1Yh6zj+Fw0W+yne6drrS5s9HjhMtqsKmNNkEIv2JY=;
	b=S3ujpSA/0sEHAlmopM5yW/nzHFD/5F4lTodhFbweA/fmNVi+KX0cXXzzqOT9kbpo
	jk+WD9isFrUkv+ps+rlniJ67MJMEZpYxrSrwVsYCWOA5sGwdxgbuqBIeDH741ZkfnaU
	fgRrpkLd5nwqknFm9J+ZVk1YhekngfXZqUurceCQ=
Received: by mx.zohomail.com with SMTPS id 1767616127413649.9710805203148;
	Mon, 5 Jan 2026 04:28:47 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH v2 0/2] Fixes for movable pages
Date: Mon,  5 Jan 2026 12:28:35 +0000
Message-Id: <20260105122837.1083896-1-anirudh@anirudhrb.com>
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

v2:
  - Added "Fixes:" tag
  - Got rid of the utility function to get intercept GPA and instead
    integrated the rather small logic into the GPA intercept handling
    function.
  - Dropped patch 3 since it was applied to the fixes tree.

Anirudh Rayabharam (Microsoft) (2):
  hyperv: add definitions for arm64 gpa intercepts
  mshv: handle gpa intercepts for arm64

 drivers/hv/mshv_root_main.c | 15 ++++++------
 include/hyperv/hvhdk.h      | 47 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 7 deletions(-)

-- 
2.34.1


