Return-Path: <linux-hyperv+bounces-3269-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A44EE9BF1EC
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 16:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87541C23A64
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 15:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D50203703;
	Wed,  6 Nov 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7A484n4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2082022D1;
	Wed,  6 Nov 2024 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907793; cv=none; b=eTgjbtWuYIsDIeEwXRaFP0f21Nz0GkcY9wOT0CxFD0eYBAunHfZwq2aqAWK4mNMiYFnragZPq1Hjl0PIyGD3EVqEXO/BB9fR/Ja03WBXlqnCQEKpCP0w5Ks+9btZFwyvEie1XRkdBCim9PUdqFDbPGIdJIZxaw7LKm9wgA8JOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907793; c=relaxed/simple;
	bh=/zS4rHp/Hc8Im00JLYZ7il0zKi/FfwN8/dYxinyXBLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KgYw3KPNGo0Ya+T0ngKgzjAJWe8Np47KYpyyZG8QpBUjufptR+OJRYLuFQmdrIm54NYKv9N8DaE4Qm9aIYML3fxGX7JXjWVHFa5QRWExqBeREqnOhbHhQ7DV+b9uYB8XQmV/vIaDTy54nyRB/5c2cmU08IEVF81Fe3a/mH0i7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7A484n4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea9739647bso4943478a12.0;
        Wed, 06 Nov 2024 07:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730907792; x=1731512592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XKPFQifwAlPUKlGKrauY2NTcSBP0FbZ+JbSf6jtQ6SI=;
        b=E7A484n4TlENUSV6VGM1arsRtfMsPH4+UAYvMtta0FERnhoWHB6ZhoptGES1BpHd+p
         QdrBXn/wbR2oj4dfiUzkmx+KNtcOT4dFXiHWbvKYgUklDy5ndEFyT3o33M035xX8MSsC
         4sr71uZhFnfbKltgPMM+VJBiMuUW1MZd7t9pxLDgC9KBbQhiq6hEUXW9d45uEvqVoUDn
         51JgwgOegwu/FJk6kABzDK738KXtUo2vITj7ivVerF88BSmfvq3zmlEF9tMFrinzFxeE
         1Uxg5nei23XTL9YoVukIkemZRajNeHKcpQc26yNC4tdXTVEwrAxSqwV6Pk+t3gSqYVCi
         UxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907792; x=1731512592;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKPFQifwAlPUKlGKrauY2NTcSBP0FbZ+JbSf6jtQ6SI=;
        b=sICyCiIY0bPZMFzq48M75vd12rlOsO4b+kNKVJ6W0F8HrBX73qclp9wKD10hhhHQJ1
         JgW+ZnQ37sT7NqGiqsEHY0zLNH9Ww2eRAnAH45SpM44YhOM16u1p6e0ARYebDEMGaIYJ
         a+hPnJZsY0Ba2SuCUoMB0M5gDsaOFPwNpnjYIhCfb/LytnEvoOdyk1mM58mMGQvZNiU9
         bk7NvzyIF2dOAy16MxoaZcAy+3qA1iL8CELq4BIH/cWR3waBQ0t/TpFEXR1GQ1RcMd9K
         5l8phQPArZtciP92l9xLjUxItc4BAlWscpTltNtc3Qr77RtjSMb5riI4h1SOfmpOKPSJ
         o2JA==
X-Forwarded-Encrypted: i=1; AJvYcCVYlabOSYhVRgA/5wBlTtexL+QkZvGurr9kYxbnoN0uniIuopewBc/z9Jehwu0fPdcuZI4v9Dhisyrih7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+nGYtt+EztAkW1TZpEGo/8FXt3ih6B0kGhPhHR+YDcbMvr8d
	RC/ps1U8I/YGmYIECxyJVPHkSYiKlEpjYCEf1NKANlept3sEm467
X-Google-Smtp-Source: AGHT+IEhwlqYUXuRMza+wBUb7ZYJYdahvXYYEonKwOarpN0Evb1igYe6fWpDaCgfPxNudrIaxdP3Ew==
X-Received: by 2002:a05:6a21:e88:b0:1d8:f171:dccd with SMTP id adf61e73a8af0-1d9a851e08dmr50053872637.37.1730907791632;
        Wed, 06 Nov 2024 07:43:11 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2e9203sm12159431b3a.142.2024.11.06.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:43:11 -0800 (PST)
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
Subject: [PATCH v2 1/2] Drivers: hv: util: Don't force error code to ENODEV in util_probe()
Date: Wed,  6 Nov 2024 07:42:46 -0800
Message-Id: <20241106154247.2271-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106154247.2271-1-mhklinux@outlook.com>
References: <20241106154247.2271-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

If the util_init function call in util_probe() returns an error code,
util_probe() always return ENODEV, and the error code from the util_init
function is lost. The error message output in the caller, vmbus_probe(),
doesn't show the real error code.

Fix this by just returning the error code from the util_init function.
There doesn't seem to be a reason to force ENODEV, as other errors
such as ENOMEM can already be returned from util_probe(). And the
code in call_driver_probe() implies that ENODEV should mean that a
matching driver wasn't found, which is not the case here.

Suggested-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v2: None. This is the first version of Patch 1 of this series.
The "v2" is due to changes to Patch 2 of the series.

 drivers/hv/hv_util.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index c4f525325790..370722220134 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -590,10 +590,8 @@ static int util_probe(struct hv_device *dev,
 	srv->channel = dev->channel;
 	if (srv->util_init) {
 		ret = srv->util_init(srv);
-		if (ret) {
-			ret = -ENODEV;
+		if (ret)
 			goto error1;
-		}
 	}
 
 	/*
-- 
2.25.1


