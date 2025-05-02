Return-Path: <linux-hyperv+bounces-5294-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 849D1AA69A4
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 06:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D831BC4638
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 04:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711E41A01BF;
	Fri,  2 May 2025 04:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmXYmWqg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA228F1;
	Fri,  2 May 2025 04:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746158737; cv=none; b=swaThrqAnwmIIsCtzPkIWUNPA7ZUBYJtpE7tOAjIo6724ezM9wAEHp4DbyUViE4r7psSxHtT90LRODgsJSaCe7CSu3miRZ7PvAiFG/2FBmKAv2hSDcbWS4A6sptMwnZvShUl4Rxz9RSxXOSoebYygj/1Y5rb8ltubM82QiyQb9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746158737; c=relaxed/simple;
	bh=Herm4mI4MQu9v+PgieE1gM3WAIMWwSLD8Dn7isc+SlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LctGujHuOolK/ee5LP5xQrEGvzGtaU585mtHU2MvjlabATCnz6ZT3lp9owVpwaZvJ7pbxU8qjc05u1MeIuv9JuynC411QuJYFEWdpo0EjQnySFkUOFRoIguf7ygJvL6jFIVHEGamRayuC6WGo6kkAJSZHDYrlfXpFr/CRSUxtGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmXYmWqg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30549dacd53so1464422a91.1;
        Thu, 01 May 2025 21:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746158735; x=1746763535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=neyfZ9mZhPKX7BwXaaWBbaQGQo+eJ96uiikp+k/5vSs=;
        b=jmXYmWqgnOwugls7PXJavzzflvHT7FfoO0MuXnWkkxhCXvnk3t/KNSMWP8OXbk40hP
         SnvRUiPriWMjZObFtepUR6iwLQ37GCvJZEbE1vn1IasOVmVkP+YmD4khYP0fnrqGZIYe
         R1sqmb4MkBCCbNcCjIS0MIrNvKLP7riJaPtvsQ1Iz94tprGKnpd64/xgLf5ZQLxwib+A
         BMNYOlpZkCIJndp9iZuVAt7IKSKtXSF6Q3bhVyCWIZeBPpHpWMIuB94P9HnE9PWpohuZ
         6qGLB1s0gx8n751cHnT4I4UeknAQ31gVMlj1Bup5cihOpVBJgD8o6bCN4p0xxcnx0WcQ
         QwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746158735; x=1746763535;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=neyfZ9mZhPKX7BwXaaWBbaQGQo+eJ96uiikp+k/5vSs=;
        b=LoR1c7Z4Nji/PXlYPJI1DyG9JGwSWAQKf31dctOGdaf7aFSe1LMDcwHm2MUadfIJRK
         ThAkyq6VBDlcmjD+RlBgKuZb43h1GVeSz/vv1bLoEYt/rFywAfGMhyuVX6faTneZk0TO
         C+UM9qI5jbBMKBYQ9a1HR83lcCDfO7B9sHzKlfVPv4h+T6/LvT1M8+bEKX4BizdlflSA
         OquUoJJq1GNbZMIzcVU8rZGlRTn7xZGh/PeoLfTkR6gyS4Oz35R0fBcc54q0pj0Q0YWq
         VrWVqmRqQk0UgAav8gVDvAb/poplP7iW2btpo4BhuJGSJjC5bV/pGv7D9eCAM6O4+8xJ
         oTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+3979BQPjAv3Jsux8ydO55oSew7PL7NtoN53QTxqB0/buzEUT0pd69dQKoxaz08j7ve9WId5l6tugsyuN@vger.kernel.org, AJvYcCVqfVYIRhsz+2TGAz9Ae+0wjhtGBqBsUgRL0t+2trzM+n/5nC9xc8AcmDkFj7OxLQRxSh3/qeba6GSX9w==@vger.kernel.org, AJvYcCXp4ENoEMULmvktkKA7+2LR3rvTssaWNOYVDECaHljOE3W5tPrzrP7pjprKEdQL/bcFL4Y15yM82hsyaUoz@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQ+MWX3S5cjMMJ5Zgxm22yylqSooKK6KusSvm19bOeocAkrvt
	KP5fFnfJaRm/XyoGxtsnWRiA7IzG+6XuJMxL7SJ8sb+VG0NS6SE1
X-Gm-Gg: ASbGncs+ecQogK4Edk0gIFPtvFYSL485g0lnqZlr7azdjIM2FyMpeG4LexMO3pABQ45
	cxoMZ3KmDfC2GgHYFV6KEoZzUJav7N5mMK+GUXUbXUtMvCCWS9wil1ezexbr7JAFrJkIFu8HN6a
	C6Nko/ZCgV+uZTsNYZ05dEzMNCfTE2E7G7KkwwiewBXlg7c//WwQVz/r0Hw+H6CLs7AahtOQ7M2
	WwVLeAoxo3sC8ZKj2y7ojC9I7FGivkDdZKHlYF9+aWZe/EY0W1xj4oK2UQEA1kJfEiMxz9iqdxW
	YbyqU4lOjIB1foVEvlYbdh16samUemBBvA000sKsaXkylKXh1YMFayhkrv1pfR1EfQ07c3q8gxu
	y5he6OrBAzgj30u41U0M=
X-Google-Smtp-Source: AGHT+IHo2Zl48y0lzt5k/TuCCUIjgSsIhm63oyFJMf1DlpPvH0HpvIhbqVlFBj5QVLZttS82nNSB0w==
X-Received: by 2002:a17:90b:2752:b0:2fa:1e56:5d82 with SMTP id 98e67ed59e1d1-30a4e2387f3mr2569507a91.17.1746158735128;
        Thu, 01 May 2025 21:05:35 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e108fb836sm4510635ad.141.2025.05.01.21.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 21:05:34 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: simona@ffwll.ch,
	deller@gmx.de,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	akpm@linux-foundation.org
Cc: weh@microsoft.com,
	tzimmermann@suse.de,
	hch@lst.de,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/3] mm: Export vmf_insert_mixed_mkwrite()
Date: Thu,  1 May 2025 21:05:23 -0700
Message-Id: <20250502040525.822075-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250502040525.822075-1-mhklinux@outlook.com>
References: <20250502040525.822075-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Export vmf_insert_mixed_mkwrite() for use by fbdev deferred I/O code,
which can be built as a module.

Commit cd1e0dac3a3e ("mm: unexport vmf_insert_mixed_mkwrite") is
effectively reverted.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v2:
* Exported as GPL symbol [Christoph Hellwig]

 mm/memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory.c b/mm/memory.c
index 424420349bd3..24dc2aacea62 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2698,6 +2698,7 @@ vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
 {
 	return __vm_insert_mixed(vma, addr, pfn, true);
 }
+EXPORT_SYMBOL_GPL(vmf_insert_mixed_mkwrite);
 
 /*
  * maps a range of physical memory into the requested pages. the old
-- 
2.25.1


