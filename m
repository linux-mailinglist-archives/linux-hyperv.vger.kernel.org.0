Return-Path: <linux-hyperv+bounces-4825-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6467A814C6
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 20:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301C5886A80
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 18:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCC723ED6A;
	Tue,  8 Apr 2025 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRmO57m/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523F1223714;
	Tue,  8 Apr 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137421; cv=none; b=hMJ/4tXAb6CbNjICiVs2BO1/yOnPJdM4YEE5Wig5IlsIuAL0NqezxCmtmJDeMSt3PKDo79w2MO/Zn+ABFrgPTsquwPnzYxeB7/W//9zSTAQStddzUE5u4oE4Pw4O7JcBaIaC1rUD/SJUMvHemxRnjhM7ruOHmpMR5+kxAFN8rqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137421; c=relaxed/simple;
	bh=wD5ahpPvrj9YGUpVfKlQbaf6J2IZrto7N6zjWU6k7ss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ACRDlDwQudm29JFzPSQuAy07KwCGEnYW4GKBm7sA2VwLt5c1gcoSKnrLRy0q377ys8oKj9ShExjdFknb/iyAMazhEQnJe4hjmAph+Zpw3EKotLv7lEaj03sWvxPaBebz1lG1gWOjZSCo25fb0iPEIA6XOmWJg8G/mTo0S9b+X8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRmO57m/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736c062b1f5so5021462b3a.0;
        Tue, 08 Apr 2025 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744137419; x=1744742219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sQx5kL2HMBRicxt7p/SiPvwoIXxU9EbXiMpn/Q8TNZ0=;
        b=ZRmO57m/BSuz4byoJqcSHucL3JgZlhK7IJXsunbom6BELEofhmpV/jxa4C+G60ojAl
         i1M5h9zIVqPZw8BR4LQMsMUzcDnudw0cHUFEkn17h7JWEz7nsqcIgbggnsNDgryQ7nBi
         sTAqedYl3DJSJB0B4dP+LMuNb2vKU5bsn6fSoHCvibJM43bcI6wU3buSsIPc6H/z5BPV
         1DpryzpFVOUE5bNlPWelfrcTH+BsR7GogsNlHuWlKru3Swu3beJvugvZTvQU6AH2W1/T
         5hpe1Hq0QvP05I9dysO9kQJIhkt3IrSg8TwzO/BUIA1L904vLj8PVxYem6dwVKN3vMt1
         glAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137419; x=1744742219;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sQx5kL2HMBRicxt7p/SiPvwoIXxU9EbXiMpn/Q8TNZ0=;
        b=Qs0ovEtBn4EHTpWccHV5FIALNCwgUSkwHWFzeeLlv4P8htWarRERji4D6A35xybc9k
         hgY/DQoejnEa2s7u9g4UaSJ72mMHUB9eKndwSx9NHg/oo3vAsUnP7fwYo+kSvvPhBVQB
         uOryOBytmvNKRPv3EXiOO4b96XdrejYIg7pA8y+YJHEl4WElJKOvDcsMJjogs3OYRLX1
         PvvBHYWk/y+Jn4e6XJTFa/pvleRScbI4MO3dK5nu7dQ2uGLzqM/dmJ4Q1+Xa6GpBFnp/
         2D2NIc7xuM7sHLX0i6FhQlFjY5bwwsaZOw97J8+/zNZDKWNCwX+ddnE1IxubelolrTXO
         9dOg==
X-Forwarded-Encrypted: i=1; AJvYcCV760YrF/whxtZq9l+8fbYi28aFMZZonpwgeJB9P6M91eq3Y9/lS6G02lyNebELr6e+3un9HeUo9ofbEKCi@vger.kernel.org, AJvYcCVi6Es4uXa2nsOcj4flpt4PwPTWkSZ7HJxztbzsFMUSFNRaL1Hgx1wKc7syhQ9G+Wbg8+tR4+Lr/o7CxQ==@vger.kernel.org, AJvYcCWdEhFabwM5NwZulT/CyX3PMimstQ6Vy6tJnJbpn7Fr0DRFLAAjhFD+qLjfetnLJZWytWtYzFvmCGM0ZIOZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwnMV9nec0mnbFi1Ub6M7/kr1MJtDv3EBd5TnLCZO2sff4xj9Ow
	P2OMbxFWQMg11DWrje6WZT3HBixjQl/vph0b1VtfwQJtNNKgY6qw
X-Gm-Gg: ASbGnctIRS6KJGLvVgszL7RaVP+1QG5FPQNE++Nk6svME5CKOFvGfLC/ciYQjoJ7iZ6
	YtH1p9sPA41mY9tqR2xB9BhlV8iYtNOsk8FT3elxFHr/tY7GJTyp5MMqFDsOVz2edxQfrZjyjrV
	MIz8fpPejRsg8BLM8KgaZV2aLHiAIvEzo1w84+GjXh3t+8C4WLzXUie2U/QsiuCW5ry3biUsB9S
	pUTzoS0ehPz1sU/O/Jc0qwfp2dT+ly406BCsbrLczQnrug0Oj2fhRFQCsXLqxNqT2jB+1GCmM0Y
	xmspp78pM/WJIsYYReY5IzBr0Di2LPSSeB+Fsrw82foLCho+X97S2RjaQrVDU/OYkZg6QhCgGmo
	Iz6olZm8PnRcKWNIibSNu/+4=
X-Google-Smtp-Source: AGHT+IEjwArdNPWWYuDFcDmnKKWKrgBr6kLPXpKsC7dfbpRyYKqI8aTmyy8lbfzaFKrF/1/S/MR/dw==
X-Received: by 2002:a05:6a00:1152:b0:736:ab21:6f37 with SMTP id d2e1a72fcca58-73bae30912bmr152104b3a.0.1744137419397;
        Tue, 08 Apr 2025 11:36:59 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d32b2sm10960469b3a.5.2025.04.08.11.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:36:59 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: jayalk@intworks.biz,
	simona@ffwll.ch,
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
Subject: [PATCH 1/3] mm: Export vmf_insert_mixed_mkwrite()
Date: Tue,  8 Apr 2025 11:36:44 -0700
Message-Id: <20250408183646.1410-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408183646.1410-1-mhklinux@outlook.com>
References: <20250408183646.1410-1-mhklinux@outlook.com>
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
which can be built as a module. For consistency with the related function
vmf_insert_mixed(), export without the GPL qualifier.

Commit cd1e0dac3a3e ("mm: unexport vmf_insert_mixed_mkwrite") is
effectively reverted.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 mm/memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory.c b/mm/memory.c
index 9d0ba6fe73c1..883ad53d077e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2660,6 +2660,7 @@ vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
 {
 	return __vm_insert_mixed(vma, addr, pfn, true);
 }
+EXPORT_SYMBOL(vmf_insert_mixed_mkwrite);
 
 /*
  * maps a range of physical memory into the requested pages. the old
-- 
2.25.1


