Return-Path: <linux-hyperv+bounces-5896-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6C0AD89FC
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 13:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A5116E457
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 11:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0DA2D4B5D;
	Fri, 13 Jun 2025 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdmmgIrd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBDC22068B;
	Fri, 13 Jun 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749812934; cv=none; b=Wu1Z/Qb/TtUnrlu8v/v/R6difN1v7MW9DkumjAdCQf0r25wuDE+82uMWlqGE7lQb4QxrB+71PZhzeDzCa6QIYJtxHHlyjtGksH6tV2QpoGnws/9uj+HT8XWjssD5MPtm9LSNuqaEdQOnao3h0TeCqkVqETJztLj90lmoBtJpoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749812934; c=relaxed/simple;
	bh=4ZmYl19ZVBeKUlO6U56EX5YHWNNn4kxHUrvh4WTyAcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uAjRbgyBrdhuzAFRi5Q8pxG3lCv26/XE5imM5qoa4F8eJstvaPDK+fA0Lg/tiLYFIYlzpZu19w5ulmdyp7f0K4kNCgLRciyLgVtipmSRQCre7dWec2OPz8f77c9T9ZjXVNFMqDB1l8DNZPR/YR2tsOT1kJ05zDRgsrzVh9Ty6wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdmmgIrd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2349f096605so25672535ad.3;
        Fri, 13 Jun 2025 04:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749812932; x=1750417732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UG32TGcANI3qLAGV3WJoCw/aQlSzTDaqi5YO4w0X89E=;
        b=cdmmgIrdcLImYhux7xD8mniesoGVD6QFgielxGLnoLkGyw6WwkrXUT0ARKVc2E+AvZ
         eAgsoCRS6hC3mNgmyOaXdFJoerloRSR2ClyX8GPlfJnOa8ShSsTQ+jrJnBJDowyil0Wg
         Bwo7iBZjl+ib/d6rABTJwI2/zhnKzemO5AwGxxO7SLdTc3zrSm1omD7Enm+8L+UNdJaJ
         lRxeh15Cg9HD/dxhBqOPQTuiJsdeQqytigCwt+3f9uPZasm0VBIxSX/5+lGiQ/UPr7SF
         COCrz+c5m5BAcOAW9OtTGoynmsszuymCxX+HCi3/kjTC8Z+0hwNfLZ08TH3SL9ICEjQX
         hR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749812932; x=1750417732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UG32TGcANI3qLAGV3WJoCw/aQlSzTDaqi5YO4w0X89E=;
        b=pPH8sV7wSsaaCVg6Qp63HwQp0iPnIvDD+7AacjPkNHUIzn88nutpw1z5WK9cSpw8n6
         e5VlGmMYIvw4NcAfs+QFvi1nYTaP9zbPTqLRWP15Fbpn2N9esPRfjcIloDge1gYgrNu7
         hkZd6r79OuKOZ77yhRouB0MN9L2sD6v/l7E1xYe4T3WoaNCRDRlBOiDNmA9VOQTuHlCT
         r+chTbiIbMLT9H9H65t030QqODEIKWTcOagVmDB7Jnq2HkXEvKT5lZsZR4lODq6IduBQ
         aB9oANP5uXDI/EXxV77DA1bp7dCLVUL3VaXl4Yge3wRn/arIgX4/Q6JpeqY2QGqarvc2
         0I2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6p4nfmThfPXoWb+t0WkC9WyZOQzNE1mZbYnNOh7W1AADYGbPkUpwGal07bfdWUnKfRMQz8el60h2Kpb4w@vger.kernel.org, AJvYcCVUQTEMu3Fre24atM0w8Fn/Q8ykRSkxscHnVyd1OmG1BRLFAS91GJeKXYepxj3oJEdLZ2sKLROhr9jedC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqdEPJtb9uvr+8SipSrDIaF2BypieLoPh5oQfO+xCwcRec2Qkm
	uu4//g7RPJqFV3A79Blbb0uxbcf/q1WM7TcGmcmg8bdg7AfCKbamVk3k
X-Gm-Gg: ASbGncu9wG0yJpARS0tyDBgMwgH1qbtetr1IExq6lao9CfiK1NDO03SQJfBEtvrn2Z6
	PYbw9gK7DxaBSp97kyuf7ImbydBKqGMYqqgHSOVIbNZGA1PHCJDdCM6YRPnI48i0LnMSK+xLMuz
	mSc5qsyUE0B+YtnrEZwPTHCJCfJkscYhFCEq6k1fPxaBYcROATTvE291qcrCu8GO4GFgmPDL2x1
	vyzlTTvpiMHqAqjHD85Te0HDsqCbYFPcfCcPEclAGTNlOX+q5VPTNkcFNQxDg/08XlupXTpfsWj
	zxo1zLytB4UVTWHACxljj2lnnMCrjAkuxuYDM+o2dU5Ys4r78rVxn9DyEM5k5cIABdLyFr9x6th
	nyOvsf+ZMkr5LWcVT5RqzYYtJ
X-Google-Smtp-Source: AGHT+IEg75MtvTyzxuVaXiWd8ZY6BHLfIR34xmyg2qByK8+D5qOW19JCRZKmuNegwXXeV7dKiM99Gw==
X-Received: by 2002:a17:902:d507:b0:235:1966:93a9 with SMTP id d9443c01a7336-2365d8917cfmr37609905ad.3.1749812931980;
        Fri, 13 Jun 2025 04:08:51 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:d53a:6918:4c22:f91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a19e3sm11894235ad.82.2025.06.13.04.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:08:51 -0700 (PDT)
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
Subject: [RFC Patch v2 0/4] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V platform
Date: Fri, 13 Jun 2025 07:08:25 -0400
Message-Id: <20250613110829.122371-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

Secure AVIC is a new hardware feature in the AMD64
architecture to allow SEV-SNP guests to prevent the
hypervisor from generating unexpected interrupts to
a vCPU or otherwise violate architectural assumptions
around APIC behavior.

Each vCPU has a guest-allocated APIC backing page of
size 4K, which maintains APIC state for that vCPU.
APIC backing page's ALLOWED_IRR field indicates the
interrupt vectors which the guest allows the hypervisor
to send.

This patchset is to enable the feature for Hyper-V
platform. Patch "Expose x2apic_savic_update_vector()"
is to expose new fucntion and device driver and arch
code may update AVIC backing page ALLOWED_IRR field to
allow Hyper-V inject associated vector.

This patchset is based on the AMD patchset "AMD: Add
Secure AVIC Guest Support"
https://lkml.org/lkml/2025/6/10/1579

Change since v1:
       - Remove the check of Secure AVIC when set APIC backing page
       - Use apic_update_vector() instead of exposing new interface
       from Secure AVIC driver to update APIC backing page and allow
       associated interrupt to be injected by hypervisor.

Tianyu Lan (4):
  x86/Hyper-V: Not use hv apic driver when Secure AVIC is available
  drivers/hv: Allow vmbus message synic interrupt injected from Hyper-V
  x86/Hyper-V: Not use auto-eoi when Secure AVIC is available
  x86/Hyper-V: Allow Hyper-V to inject Hyper-V vectors

 arch/x86/hyperv/hv_apic.c      | 3 +++
 arch/x86/hyperv/hv_init.c      | 4 ++++
 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 drivers/hv/hv.c                | 2 ++
 4 files changed, 11 insertions(+)

-- 
2.25.1

