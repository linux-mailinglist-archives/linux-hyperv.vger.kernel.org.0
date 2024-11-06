Return-Path: <linux-hyperv+bounces-3268-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBDE9BF1EA
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 16:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F497285729
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F0202637;
	Wed,  6 Nov 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgliIiu3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B307B20110E;
	Wed,  6 Nov 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907793; cv=none; b=iFu5Kt1yz4wuKWBWDoaPNMdd2PtqzM3MGFtHf9ln8Ijlx5APGyDfqY74huaiZ5pNTXzNWdFPc8h7fal3PnUfOVLiBDvZs9TV+6lHTbKkeTXzSzIi/2Fdh5mRs56z/tFqTzLmtTpjMphS92UbcCmnWSRCiVAnNfuCXOo7gaxnJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907793; c=relaxed/simple;
	bh=MAPHfbJLtZHhnegHWlKCHcZuDm68IfEs5pmSWtKlIVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lOe7FObIkMEmqvwFUTB0ZnCckKEOv+eDeL+sJGHeAZbK5dbcI8N+4qFts7v4zWy9hjeIZJb3c+l9zULhnvrC8ky3EYW2L4tKCWxOy3ou6JQNFGXivrjqKfUrCRivLtJIqBt2IA+bbrlpEpEi58jixJ75ICTR1jXsDWaVgRlHGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgliIiu3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72061bfec2dso6326658b3a.2;
        Wed, 06 Nov 2024 07:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730907791; x=1731512591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xGmuTOkwDF5EWyglbyKZX3cdG70GKqEHWRe2DvKnQV4=;
        b=fgliIiu3SF5PQusg6jkiR6rh/D9VycQaCtJ4nqUicmSSmtF/+CCv1P02ylOxeXV/8e
         BIOd8lsyHR2AFRnlGljXL2hGB/eLkH5N4B+jZi8f2UiaCzznZBdzwxVozKAdKi1ha2hT
         cOR9opGGYSQGCXpVhKNs3i+5GdHdhxRjxMPY4XS1oZhdaYvmY8IHHy6b9Gw5E+O8e5fN
         ejVeqCae5uuuGzeTNW4X7ae2gzSuWBwvjf89liZYbaLHeG00dGUPKI4vHFt/QARrU33q
         nKXSq9Q/2/WOaqe0KClyU7rkossdzy4NJUNntLauyNwTEwc5UEJgkPB8YzmVHTTXS1FL
         z6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907791; x=1731512591;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGmuTOkwDF5EWyglbyKZX3cdG70GKqEHWRe2DvKnQV4=;
        b=kwSXQmcpBxcBKHvmbW+pFRcz8nxTkrmztvoWddF538sjLmEN+ryfElqsUBQMxSJ56p
         KXgT3PVFlrz/rkWUJzBBpQW2/Nhfguf/qlwYwuqNANocnVq4s64FJriXTK90+3Ah3nqN
         MvkEphgPPKA5+0Y3YrEFTNBv6fDtqOrmc7451KHLAMb1jE9tYUnwEmBZaT+XsX4PrLAN
         cyesjGaC++Jz2kVx3CaGvFNd9V8g7wEF9HMqkS1P29FAfVauIaUZkwlYCZeeaJQ6Lzxe
         Pl7QMWjbramZOe6XmCTzof2YiDRXqJ/wr3Mshc4SfokU/VhQ4Q6/ZbTDqX7usVG+hL1P
         R7Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWYsRh6FPBfMKarQyUGn563x8UgLs62GRm2qetuDbqGiPc8ntlUiRSmxCE0+1qh1Iby/7OmtZRGxPO513w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz42emC5ZNNjZAB1f1GYzw4z5TVL8DLPt6W5TL/ebVRTwH+RLX
	5fwQm4nbmlMuArsdU4Jw43b+POSOIvPBNdW0sKLWoYn9WMU2cjCX
X-Google-Smtp-Source: AGHT+IFlc3Oj7+Z6MEUkJsrzrLppVGEp2sZo+n/ULuOix484rupL6/GH3IpnCJ+NWD0Mf5afKgKeFw==
X-Received: by 2002:a05:6a21:2d89:b0:1d9:2ba5:912b with SMTP id adf61e73a8af0-1dba54e7e8bmr27251321637.36.1730907790879;
        Wed, 06 Nov 2024 07:43:10 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2e9203sm12159431b3a.142.2024.11.06.07.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:43:10 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	vkuznets@redhat.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Drivers: hv: util: Two fixes in util_probe()
Date: Wed,  6 Nov 2024 07:42:45 -0800
Message-Id: <20241106154247.2271-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Patch 1 fixes util_probe() to not force the error return value to
ENODEV when the util_init function fails -- just return the error
code from util_init so the real error code is displayed in messages.

Patch 2 fixes a more serious race condition between initialization
of the VMBus channel and initial operations of the user space
daemons for KVP and VSS. The fix reorders the initialization in
util_probe() so the race condition can't happen.

The two fixes are functionally independent, but Patch 2 introduces
the util_init_transport function that parallels the existing code
for the util_init function. Doing Patch 1 first avoids an
inconsistency in the error handling in similar code for these two
parts of util_probe().

This series is v2 of a single patch first posted by Dexuan Cui
to fix the race condition.[1] I've taken over the patch per
discussion with Dexuan.

[1] https://lore.kernel.org/linux-hyperv/20240909164719.41000-1-decui@microsoft.com/

Michael Kelley (2):
  Drivers: hv: util: Don't force error code to ENODEV in util_probe()
  Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet

 drivers/hv/hv_kvp.c       |  6 ++++++
 drivers/hv/hv_snapshot.c  |  6 ++++++
 drivers/hv/hv_util.c      | 13 ++++++++++---
 drivers/hv/hyperv_vmbus.h |  2 ++
 include/linux/hyperv.h    |  1 +
 5 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.25.1


