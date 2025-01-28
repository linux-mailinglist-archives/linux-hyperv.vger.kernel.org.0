Return-Path: <linux-hyperv+bounces-3785-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1203FA20F1A
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 17:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078287A11E8
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1826C1F540F;
	Tue, 28 Jan 2025 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcG1JrdC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC51F3D22;
	Tue, 28 Jan 2025 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082831; cv=none; b=tjFRNIPkjujgXKOj3p5m7krBIgujiuDOr4hji+2hi3vCrB+N+pcVQmKFt9rXvyI+vrqOtLcYGBZ5qfWjZG/8cb3rtlATarWC37ddasHT5CthAL21YyQv9IqopDn48/NZeE/XngyMTOaQ+0vI4oL5AfhoxRw6ncU737mVp8X/UfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082831; c=relaxed/simple;
	bh=0apevGxU/vjXUpALtZpvGMtdZWEFFMKEjme9pPLPLUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfV28NOlKf54wdskNZtoIIRj7uJwvNxpXjc+ItyHl4u1QehQ1/kSNvLh/2ho/+FlRzHgf7tZSI0nlzVJ7TINszzkpR0OgMZpeosgijc3s6AYfYagTMrIJF2dS4mvIoSOOJWeW6eptkhVNhjYpH7ZxJMCdMSuYwW+s0XV60eZ3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcG1JrdC; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e46ebe19489so8046111276.2;
        Tue, 28 Jan 2025 08:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738082828; x=1738687628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMvm/r15/IoRSGXQB6/DA+TEMaJ7ANsfTm/M8ejHi4g=;
        b=JcG1JrdCVLojMviXIlcYu0/9NQrUSinV4+OtWo7PQA7usDayAJOlobYlGRIPF/bAn5
         vnvAFuJF11TWv6VGs1Exz03uC/sSA6cc7Rkt6ZYBK0LXoincgQUlvP0k9MuK8UY4VMmn
         t+de0CCb1Xq7LLk4DCL+4HNiOltYZPEXsYC8vQi1bWOToMNM2M91i17RBG4mvOjW5Cfr
         KhiOSf+hErclbnZ7q+irtlU7rrwdmBxXmb5QzaWk+Wn9AxVpxW11XOyO0YDemQw3wLpB
         T6OvP/g3cUsTj6p8xEdKcAEBTERCDrG/Z8KyZlEY9JcDVmGrdrvaN3SiJ8aO0ALvmP5c
         X75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738082828; x=1738687628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMvm/r15/IoRSGXQB6/DA+TEMaJ7ANsfTm/M8ejHi4g=;
        b=ZUbDRi7nuVdwlmyeTjRyFJAczOQgRhHUdkNhi+TXvR5n2exP5qyO9XrYUcUvOglsJC
         Lprh2SNRI0yL2vFSGE51nec8Pxu9edu3TEvtc8GIifKdqZ1PLlsFQ2PC1J4w07/ydTJx
         Tvks67sSWjvjFpHp5/+wwKt9Qc2mMa+IUrpDBtIKQ9hjYKRmqIstfGh3NQv8rzqFDfgB
         stp5KT7pSDhBZy6T2UNoXi46LNjFK2J7CNkIDrN8POk1EBJhp32/xidVtDlFNJMjwSzv
         kS/iTojIGz0GaTbNMXG49UzeH+jZCx/dOhwGwUyG5WY3QpmqTK39rGq0/30VC019QMFC
         JXEA==
X-Forwarded-Encrypted: i=1; AJvYcCXZxtqTXNsg1Uz4Vjr0VFHDaIQS+frp/jLwz4VFfQAbVd9juPN9AK/JhMfRrPib8oxjZwwxi9H5RsU8@vger.kernel.org, AJvYcCXfT86TJ3YZXuRqatVHCajDssJrROClNm64fhQiuLUAh030JvVqVCYmfn0J96rTtFXfoj9GLTXFaoeckMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2VF8M1E6ls31P82PljtwwH0u5tCIqqmocuiySFijEj3l9LyfH
	ULyZlJYTQDdhm5BXoBVD9hUWwZfIxukDH8dS/adFEiqg9qDImd8QY//i9hql
X-Gm-Gg: ASbGncuHvmjUTiZnP9mPlqxpRjpWv/e7uwAFLrGcF8mxrIdy/HAgR9Yk/rz9cyrK+hH
	a4LaWJA3bfh+kjlqOlWycpEWmXD3A6hywjYNKs1Kd19bRNeyCtXk4b52jqDF7k6IDniTauQPhQa
	kvUjcHs2qKIA3lrGVbbxOIJ+ykjMbFM6fKODyMyAhnzt/9XDsAgl6EoFA5LnKzGg+Wh2xEHbvW/
	YB63LkQQlAcE6pQSYLJbCdHTf2uV484WfVb6SYBnFyHIc0yIIwTtvpZHH2412bKWbibCakv71zw
	YJ/EQjdE1fHgKmSCFWzyXeEb9s8HZyYt1pnoskzOJSzGrM1oTIKFS0cCEWq+BQ==
X-Google-Smtp-Source: AGHT+IGRPj3/cc5+8Iz+fYUcf8o4fSPeh9b5K+i2Rg5PPrIKaCamFUEL1iBnWZ+nQqwSgF6c0Ldf6Q==
X-Received: by 2002:a05:690c:a91:b0:6f0:22d3:e142 with SMTP id 00721157ae682-6f6eb677d1fmr332227657b3.9.1738082828372;
        Tue, 28 Jan 2025 08:47:08 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f78953b155sm7926567b3.24.2025.01.28.08.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:47:08 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v2 12/13] PCI: hv: Switch hv_compose_multi_msi_req_get_cpu() to using cpumask_next_wrap()
Date: Tue, 28 Jan 2025 11:46:41 -0500
Message-ID: <20250128164646.4009-13-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250128164646.4009-1-yury.norov@gmail.com>
References: <20250128164646.4009-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling cpumask_next_wrap_old() with starting CPU == nr_cpu_ids
is effectively the same as request to find first CPU, starting
from a given one and wrapping around if needed.

cpumask_next_wrap() is a proper replacement for that.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index c39316966de5..44d7f4339306 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1757,8 +1757,7 @@ static int hv_compose_multi_msi_req_get_cpu(void)
 
 	spin_lock_irqsave(&multi_msi_cpu_lock, flags);
 
-	cpu_next = cpumask_next_wrap_old(cpu_next, cpu_online_mask, nr_cpu_ids,
-				     false);
+	cpu_next = cpumask_next_wrap(cpu_next, cpu_online_mask);
 	cpu = cpu_next;
 
 	spin_unlock_irqrestore(&multi_msi_cpu_lock, flags);
-- 
2.43.0


