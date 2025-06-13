Return-Path: <linux-hyperv+bounces-5900-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D92EAD8A05
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 13:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83150189A982
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 11:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D1B2D8DCD;
	Fri, 13 Jun 2025 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtLu7mVt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426092D5C96;
	Fri, 13 Jun 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749812937; cv=none; b=tCkSx669ezxAlcJmVtcGnd8zHUn7Ol2op5OhPrhr4Yrz55idTCmBVlVal03rZWDFEYddzUiscC5F7yNBu2y2tmg0Mq2+GOvx9rnSxYov3ecZcxPF227ZkxcWbZpSP1PXHULObI5eKh+MSQ+82IRLTc9e7oGTj4OhnQXSnsLKjPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749812937; c=relaxed/simple;
	bh=qpED5RneP071FcS910odYqSdpMX7aA1qp1GZ8YptsVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tsC1p50r2eTAC5cTc2AwWi9LEykaEqyXggHK6hTNz/9Gu/86gIQAlJDW0FiGlwXlG+HCfT3bDkhoXilct98GHDLrr2mkJ7LdYFrKTf2+ivoV7PYskLoJGA5u0kSQGLguXxni3ukPZ6Yt1iN4IwyAQWJCszTXaq7cJs/7IIHyD+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtLu7mVt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235e1d4cba0so19200995ad.2;
        Fri, 13 Jun 2025 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749812935; x=1750417735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrqTpVYTUrU+ceEisjCQ8uxeM+STV7VUnkv+XUZSFN8=;
        b=gtLu7mVtNHJ5I14YtlE9fNcyacHHSjdl+CiGL5f8WDGQ+q+c7B3Xsz3inxlCWJRC9r
         MvuGWcfknod+csYugkAGR6ceWqNoog7vb9X30Kqtwiqpu1QBwbaz/AjTIAXEWvhSyJRQ
         PlcTJ8AoUuKCDyW4I7cAsfzHYbRsXNaeYTtVbZfqdYGt6HylYPtW2GA7s2ANkJf1zD7e
         E/lnhtfMy11lu5CKlnZAg5ayenzEmg4Sv3TVu7YTICncku1GxBWzH0NxRwMC72ct/E5Y
         T4ePvJILGWO7//5VGZQiokfz+ndB/zHXtcvC0fX/31NHKcNtFcmTlVTar7GrgR+yYEgU
         GNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749812935; x=1750417735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrqTpVYTUrU+ceEisjCQ8uxeM+STV7VUnkv+XUZSFN8=;
        b=T8/Al7m5RFwRWcUmuWpnzZBCVeaVrwXASVQyhiF0pirfhRSzXdhCM9POkQyJFGlM0I
         xCTNzUXcVI5MLMsIIqWPB7E9POF9SwIHwsRzj03D0Ys+GR+1Y2IKwVv4DVoNfqmLBnCq
         cRhpxRgE7VmhfEI1CUrCtdqzA/4uopoWHZ9ySaltWwr7RzT4BhPrCpqsT9WMx5ZQ0DHp
         wo7998WQh7ZmqtDgJF4qf3PGUeRzuLZBExkEWfi4O0lnaKKmS9jWhE7ThOUEqsKCb20r
         tTapvut8nI3ue+IHP26g5LkQi2I+EAuBkjxH2Jrbsu31feir222KznppMff6XLpdVUsG
         Gs/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIOsSAB3rXeUFuUr9nyGz3kOElhNuylhjFKynwxaXc1ukDlhUzX+Wgza0+RwSxiFhEOJHw6ko4hX+1OoA=@vger.kernel.org, AJvYcCVODRDvgpB48ATtH265YRMBmxZJSwKNnQS2Tr8o4tHij+rsiSV/p9qjMOSUzeFHwITbskKBEgsPL/R2H1aO@vger.kernel.org
X-Gm-Message-State: AOJu0YxSpL/kET+UTfiVaJiX6l3d/GI1cXBkz1CbQ+8X1HyYrwTxOYpr
	z0URLYDN6CL4sh8I3v3fZA/b4sH8frjfyDVLpP7jQUXsq2K5f5Xzq/xkDVHKaOT0
X-Gm-Gg: ASbGncvhXLUh4HjGDXROrgAwf2mQOn09mYTjmtn40oKacgpDpFXb4XiaiE/YRIY8+70
	7a+IfeCXuZnX0nX7jaI+MzJI4vc6Ml3pmukJv72LsV86wT+TJi8fsvL11DqOYE3B00Ky3UR14wh
	9sZNysmANRVIcjy6zbEULZyx8Nw4J2yE20v7M0ld8bs8b4W0qU3xdmD8OA5WeR53l431NVAMxid
	A0Y5FLAx2HrWY+uk/I+xVvi5bTTV10c/x+DaENQJZpaiZKzEpY9RxVZmB6Wa01Kd+YuRjZHvSl+
	9BfSzA7vy7GLl8bxjyp/XZm+jAHD75xO77kmyOnrpDetz4rJXaVvQhcCFQi4D48LrkO8FxCJBK8
	ogWJn1tCqBdyQE+3aKZ3r5nZ4
X-Google-Smtp-Source: AGHT+IGxnGVdLNa3QM4N3nCtfUL7gEmFwOsKPaTJVix/l5Pmfv+2ZMvQlVHBL9KFupuE57locHOuIw==
X-Received: by 2002:a17:903:249:b0:235:e71e:a37b with SMTP id d9443c01a7336-2365dafffc8mr38168085ad.34.1749812935514;
        Fri, 13 Jun 2025 04:08:55 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:d53a:6918:4c22:f91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a19e3sm11894235ad.82.2025.06.13.04.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:08:55 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvijayab@amd.com,
	Neeraj.Upadhyay@amd.com
Cc: Tianyu Lan <tiala@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC Patch v2 4/4] x86/Hyper-V: Allow Hyper-V to inject Hyper-V vectors
Date: Fri, 13 Jun 2025 07:08:29 -0400
Message-Id: <20250613110829.122371-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250613110829.122371-1-ltykernel@gmail.com>
References: <20250613110829.122371-1-ltykernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

When Secure AVIC is enabled, call Secure AVIC
function to allow Hyper-V to inject STIMER0 interrupt.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 3d1d3547095a..3b99fffb9ffd 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -132,6 +132,10 @@ static int hv_cpu_init(unsigned int cpu)
 		wrmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 	}
 
+	/* Allow Hyper-V stimer vector to be injected from Hypervisor. */
+	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
+		apic_update_vector(cpu, HYPERV_STIMER0_VECTOR, true);
+
 	return hyperv_init_ghcb();
 }
 
-- 
2.25.1


