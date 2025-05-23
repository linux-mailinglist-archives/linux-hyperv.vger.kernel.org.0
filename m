Return-Path: <linux-hyperv+bounces-5646-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50701AC274C
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 18:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52771BA595E
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 16:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01AB296D13;
	Fri, 23 May 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLMaqmBQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34787225D7;
	Fri, 23 May 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016945; cv=none; b=T75JEoOu4vMQmWP1jXiATs+QPzqmgHtUfUaaGD0SDBqdl/tZk6nnG5mPuACh1+C0MHcy2egRKXk3RVOiciH5EFQZ7ZP5Hhjo1Jt0yDGcmIK2w4K0g1humN30Za2PK2wRzPODRmJB+gfxwLMzHeruk39sVX2YxCDUfCcLf4ILapo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016945; c=relaxed/simple;
	bh=fDObmogM+dfq6hZJ4xJNyjAocz1Nh6uxvjdVqYWVN1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uwdEcSdxJ6kFJAC5qGZkHuk/xF4TH5ByNNtUA9nFDfHj9vaRvgPJ/qEv6yCdjFUrh/WGSP8HD7/cToyeqNxmIMFNMRFVDbEbdaH3QwVpqM5RO326DO5NtwnabO0GjkYXe5QlhcRtSqOFW4thnXkZsYQxkLhlHCs0jI96vwxCdls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLMaqmBQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30820167b47so147926a91.0;
        Fri, 23 May 2025 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748016943; x=1748621743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Ci3isxxhsp5k7AjuUnYW4WXxlffmz+Qa/1SXSaaPCI=;
        b=BLMaqmBQivR3vehb4LPODls7Rx6Vjt/6vAJB2417+68he/0kVHL13V2gB5zAGzNl20
         k5t957AQ/fKHhf89ihAawrwblWOkvptgVbYmllNbwp4qGeCWcNtfIvViDHS9ZbYZLlqy
         pAiTIFbUIiXtYxYZ0wdI3TP3tjY78oWtUEnzCWcDneoqjWODdYIhegnLK9PXmDeJZ2D7
         459BMi5nZkBtg+nb/wkwWuRgOAcRhoewct2Mz9dktbj9+Rpy+SM+9mXPlXTIvG1KMxG6
         dhVahLL0VaKBvZ+8pndRan3/PfIkMaoo13rf/TfJq+KDVji1lSk3LEeYZR31UYMuE3oq
         XfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748016943; x=1748621743;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Ci3isxxhsp5k7AjuUnYW4WXxlffmz+Qa/1SXSaaPCI=;
        b=YfddyV1QeHXlQtLCxKkLaPdfSCMWVzJxQS9KncUid5qhf/O1qLR7P3uaNiwj97ErQa
         s10kA13SGgCYZ/A64059kol+RlTsLTzYrMJ8vk6OKl+9brGmAkDyyYS78I1ERdHPiGfk
         mI6mO1vQnN/XIIF6EI2c0KQAPZNriXjs92CpHQ3jiSvNHIhJdABiZl1rhplHcmcARL6O
         4UfY9ejMn4yvHNI642PPh97FetztLotjp8x8I3TKiyoYvw1DUDlnUZA3qgrSc/UDTyQZ
         2dcYBrrgCkar4eTeyoDdVDkrcDkIDB0BCr3LgjjeFQLv3dl1apS4VrD/XQ3fVRqdXQ49
         GE0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2Z0qSth2KxW2sejGfXfPgCjPKUBK3aKq4jbIJX+X57bkHFpBDaS54cSxaTDMl8s9LLQm1EGRyHrPurnaV@vger.kernel.org, AJvYcCWSppcEZbQY/qPumSzSfL46P3zdwdqlxDa27iCEqA1nReAPONZ8/KHYIZx40Y8pFedi/uUTi9GjfQtqNw==@vger.kernel.org, AJvYcCX97712fV7nREKw4zUdfBC++mvJXlh9/WqXbwDniOZWpBxi/PPgZh/BDk9HzZTsQzJen937anlkNwd+v+MB@vger.kernel.org
X-Gm-Message-State: AOJu0YzS+mCJTPRnu4HWHjmW32Cu2f495BqWa/AxB6RArKbwillWpha3
	7SKJxJQNYxJaSe4/E7jF8ur5UfsD99Ys6q/bmkWP4Lcju3G1MQMhaO9M
X-Gm-Gg: ASbGnct2vQz7KvZN+MLb5RCX+OV/IBjQvyFeQHWAwWw6CAJFj3NUbucG3FFZttrNEg6
	ilaYheIKI3tVw6cpg3z3v8VFat9K3Il3N2rRxH/QwOf41FcP3sp45KGGmtNIUgwheitJOS2AcLh
	ueK9w5V8DM3imnRUs4m4KRovVm9O1F9v1lckWs4BdXXNA+aX1UtTQn81ElE3HBPmDXvMEXIgQGG
	TTe3iZEsN4yHsUzNTeOWJQDb1ZICjVJUBpZMzMZ5OotQkdTnAtZhHgq0SMecZ5xQT++XjpcVxMV
	5ETRQck3dVyUbdx+RJC0c/YIig6fLuZEDyO6UjSjqgQkOcZIpAT2/kA3RGt3i3kP0hcWYw6QfDD
	RsuJbQBbrDGU0OWiGDMQDSOS6cuExTZ2uSiiC6G33
X-Google-Smtp-Source: AGHT+IE8pcy7Z2wW7SrWmR8EeORXq3Lf3Mz2nUIbKMce/zPJlwY6YhtwhHMP/X+hsVmxnhhRfKeaCQ==
X-Received: by 2002:a17:90b:3889:b0:2ff:5267:e7da with SMTP id 98e67ed59e1d1-3110ac9b71fmr132826a91.3.1748016943353;
        Fri, 23 May 2025 09:15:43 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365d46ffsm7526565a91.25.2025.05.23.09.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 09:15:43 -0700 (PDT)
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
Subject: [PATCH v3 1/4] mm: Export vmf_insert_mixed_mkwrite()
Date: Fri, 23 May 2025 09:15:19 -0700
Message-Id: <20250523161522.409504-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523161522.409504-1-mhklinux@outlook.com>
References: <20250523161522.409504-1-mhklinux@outlook.com>
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
index 5cb48f262ab0..58ba40a676c9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2688,6 +2688,7 @@ vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
 {
 	return __vm_insert_mixed(vma, addr, pfn, true);
 }
+EXPORT_SYMBOL_GPL(vmf_insert_mixed_mkwrite);
 
 /*
  * maps a range of physical memory into the requested pages. the old
-- 
2.25.1


