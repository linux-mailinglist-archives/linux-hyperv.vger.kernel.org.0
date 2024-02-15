Return-Path: <linux-hyperv+bounces-1543-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D83D855BCF
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Feb 2024 08:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8BB2979B7
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Feb 2024 07:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D359C1078B;
	Thu, 15 Feb 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IswGuisa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4900EDDD2;
	Thu, 15 Feb 2024 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983317; cv=none; b=tdgxCUUFHZOmQL89YEnaMew5YuWG1iZenPwQAxA/ZKGHcWXZIRzotwIKknYzgsuMniUOlMU/kUTrcUPmOW7XofXzv8hj/sQr2+Bvqx+X4GzM9TB4Sjo5DH/VhPb85b90p8S83viPE5PTPIbwCaWorddSFwUl5KTqtLsp4tooIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983317; c=relaxed/simple;
	bh=1myF0+7CAQJlrW9WQP3I8BhY6dru7lL/Fpez2iZz7Uk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=I4mGjZrlRzBuTTxoA4X7wzXxcctFz8H8lDgNTwnUxvfeFY02srrQNZNXNW6t7jn3nly90FFvlXGkFJgAFwW4bdRc9I2WtT305+nyU5ZS1H1zfKQCscKecjQ9piq0onGicsr3QW0NfvK73kFHL0s6IC3NDsVxWvo7mvX+EvBrQJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IswGuisa; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e2e6bcc115so246639a34.3;
        Wed, 14 Feb 2024 23:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707983315; x=1708588115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MSaqb+bxw0CGDMOKNrR2CK7UsJmuYZviEvXzmRbWfBs=;
        b=IswGuisa7fhC4cTSKF7WEvOTvTgxe0px/OGVFotK6hztVfsei3JGzWCyipLS3YdJGD
         pXitCfB6MJb0EFYlUb0no0qjI6hp4uVhe8aTC4mTDr5/467D0YyMCAEgFIdydM0knZae
         PZhA4h3joOb8FDNyR/+67pYnF8XwL3MoT0cNRvDSZCt326u9AxWbmPeXny3fJ6aswT7L
         ik/8i8JRE8S8PDRIlO+nIGONoIfLvTJ8rbSbSvm6NjFjkKBg/pN+ix0pD+qUldnFibwl
         LzTJ5R4ccplUYT+XgloRe2bp+7vyqbc2/+maadMKsbK9kz4jds6nda8r23ne/tBDzJgf
         rf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707983315; x=1708588115;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSaqb+bxw0CGDMOKNrR2CK7UsJmuYZviEvXzmRbWfBs=;
        b=LqYoJJXUkRU7ia8aYjiPTznaivRONRJQ20icXmw6Bs6MNIVWTTBE+/qbMc6OXbS9qs
         KWagfpSWybN4XshgC4r+hyKmDHfD9uFWuNqINqp+Ba0RFK2Qdek5Pn3QcH4CUGJHQ/KC
         Ob75/ohQs8vOuCH2jU5QrJSWBPYmDVXlbtw7YjHK5hD3E29Q4JcEnXH2AhrBV4WI1zVk
         JwQ0NGVJvQsjI+1c25TE0l5UW2dcsCKw27vIZEBCEpGZn8NJh1KebrYzZQ/KgAHvMACq
         FRuefDj9lHoWKDFHoYCwShg5LWcCqwxtrpe9MGa2cZJV5qv5QhlRjYrDh3EC6E29xM1v
         5vCA==
X-Forwarded-Encrypted: i=1; AJvYcCX7Q9eyzHnf+ynwtk+/SAp5o1jvBWX3tZ1WLR/nyVcI54ZhOQ1u5c1d8RSq7iBcM+bDOX4OK+SCdjJQ04Vdp50wl2j59wC/xFZQ5v2oMktw2WUlqWAkmRJtT0mrrW6Sa4SwVSz8pBEXgvDB+BRkdcyP1W8hef4Nu4N17+zKtc+2bLZm/Moc
X-Gm-Message-State: AOJu0YznMPm4dJU41mzxp6PtXCAuq3Zvofji0tlB6DafZPSz5F/8tieR
	K+KAab250ZaUUg3Y335LwFGTuW3EPcHSlmgfr3oVgevngupoJPZW
X-Google-Smtp-Source: AGHT+IH0ODOG4PT3r69euSPbO6oSs5a/IldFGsN/oMqdGOu5ZZ7gf0DkdnkUphYjxYEwxUGWsVyUHw==
X-Received: by 2002:a05:6830:148c:b0:6e2:e7f1:4b36 with SMTP id s12-20020a056830148c00b006e2e7f14b36mr1123260otq.5.1707983315183;
        Wed, 14 Feb 2024 23:48:35 -0800 (PST)
Received: from mhkubun.hawaii.rr.com (076-173-166-017.res.spectrum.com. [76.173.166.17])
        by smtp.gmail.com with ESMTPSA id j64-20020a638043000000b005d7994a08dcsm694240pgd.36.2024.02.14.23.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 23:48:34 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v2 1/1] PCI: hv: Fix ring buffer size calculation
Date: Wed, 14 Feb 2024 23:48:23 -0800
Message-Id: <20240215074823.51014-1-mhklinux@outlook.com>
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

For a physical PCI device that is passed through to a Hyper-V guest VM,
current code specifies the VMBus ring buffer size as 4 pages.  But this
is an inappropriate dependency, since the amount of ring buffer space
needed is unrelated to PAGE_SIZE. For example, on x86 the ring buffer
size ends up as 16 Kbytes, while on ARM64 with 64 Kbyte pages, the ring
size bloats to 256 Kbytes. The ring buffer for PCI pass-thru devices
is used for only a few messages during device setup and removal, so any
space above a few Kbytes is wasted.

Fix this by declaring the ring buffer size to be a fixed 16 Kbytes.
Furthermore, use the VMBUS_RING_SIZE() macro so that the ring buffer
header is properly accounted for, and so the size is rounded up to a
page boundary, using the page size for which the kernel is built. While
w/64 Kbyte pages this results in a 64 Kbyte ring buffer header plus a
64 Kbyte ring buffer, that's the smallest possible with that page size.
It's still 128 Kbytes better than the current code.

Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Changes in v2:
* Use SZ_16K instead of 16 * 1024
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 1eaffff40b8d..baadc1e5090e 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -465,7 +465,7 @@ struct pci_eject_response {
 	u32 status;
 } __packed;
 
-static int pci_ring_size = (4 * PAGE_SIZE);
+static int pci_ring_size = VMBUS_RING_SIZE(SZ_16K);
 
 /*
  * Driver specific state.
-- 
2.25.1


