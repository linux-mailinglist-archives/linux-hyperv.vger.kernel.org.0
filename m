Return-Path: <linux-hyperv+bounces-8360-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7170DD39834
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Jan 2026 18:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D974030010CF
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Jan 2026 17:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEBF1D798E;
	Sun, 18 Jan 2026 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC5y9GVw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC929500976
	for <linux-hyperv@vger.kernel.org>; Sun, 18 Jan 2026 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768755776; cv=none; b=dxPWOAAm5PzLwlLXiEeocSyKdhKsOnvOW5UBH6dImVA5RUjUGiQpdVz/zAKcLTyiOX1t371uXP+/LA3j9EFeHQFlfc33DsSu3JIT4OX8Rp5Hq09laMzXQpbALR4modwfU+D/qq3mDBkjTAMEQ87CxFDoz5Y4HeirM8nZyfEfiNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768755776; c=relaxed/simple;
	bh=twzUG/3AjOfMMPYomGUOPbcCEi4NPF834XhrQbjN9rQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rvah5nTpMMq9hYEHGCkxF8Pb9kvRQuP4A+25et5zau4E5mwUc9slvEDzb8xZKQ/4641XWiFhrH4PKcFa/Z48YpKoaHNymLVXUqXfm6Idw+r0b9vbk5V5q+wJowWrUnHQwvisoM/eAPmZVMXuhITWv7TKegpVSP36AzXjl0zNwMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gC5y9GVw; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-81345800791so2153600b3a.0
        for <linux-hyperv@vger.kernel.org>; Sun, 18 Jan 2026 09:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768755774; x=1769360574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bNLpQwv6x4AVFBP8uMEikkKSaNejL9z6qE3ug9GA0tY=;
        b=gC5y9GVwBnlP/CalntdpaJEESzpCqCMAUDWEm3n4mq0aNZocEoY8FVJcxvRLKiNaIy
         8AhZ4IJE+xC6pnWfp6VMN7AES8HFm+lbdID/dENc9FB5wONyJXEjnAThb5WqrCP3Igul
         yJQyQ6bb/X4MwgM+KXOstNbzjdP6KXYEj4KbXbxjhIczZV2sRmASUQCeBooHkA0D/Jlo
         He85aKxIwhVzg9/0JgZAGpRcfEVn6O5lKpyA1LrAFBq4to9o7kw8ln0Z7du4wmRPa7RV
         uTkZBQ8ny16GxXG4Zov3Oqvl35y7ecqYqxqimjMZG9IIsObibgjSrzZwbxfDH8i4IXcc
         3aFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768755774; x=1769360574;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bNLpQwv6x4AVFBP8uMEikkKSaNejL9z6qE3ug9GA0tY=;
        b=n83z+s3NYUPtxHduXLlPW9x0yv5AjyWNnDdIMJWt5vxeY3qlNpJifNwzAEaHcWmaYt
         i2V99jKZgXulilFzjEYtdsoCa1eKx2WDG+Me53kC4ECRocaIZGnjgMXAEerne5qP9zgi
         gJnvqrG0qMKn4O0PPRWWBhYrhUvEqxOAKhEZhU4ZXW3V6MPbZqHJaMN7FVvG93RSXv5r
         K1NFq6PIcVMvnQKfqrZ5VRC6ENheJqNDF/7ctvWuZYFwQ+KU8q2k4VRii2htiiVC5EFx
         CZv78qcSvMSnq6P9KKPUOo2X9RcJA+Ne9mnm34iYVP0KjyeeR/GEy3x1Lidoi0iFrRuG
         z+lg==
X-Forwarded-Encrypted: i=1; AJvYcCWyGvpBSAvDOk8wVuSNqV7KTJzSY3wRT5DakaFL9aLR6DqxedTAhFJ4X1qtIq8nzttA5I4YjRIGjB3mvqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA7rixBwmx4QzZRmoamQNgbygnJXTNkZsu/DsbLLqVmqPqHWe/
	erGZJu+QVznmLXEmc0AqH6UeGLdvMFC9gYfCqoXjCbOAXNA2quU5TlZc
X-Gm-Gg: AY/fxX62su1j//Zkqo3Dx2/5+iiaeDNlGL2iiuLy826IVOFdPVlq5alK0hLIGt/WF5m
	Z/6kL50P85q2hBUvfjXxAj50OQdllZC6jRhP0N60RUKlxRIzjJxaOOHhMW//e8Sz8UGos8sJSVw
	IHNT4/rnyZm5n+iX3fPbSNqI/ITjcfmNrQufK7CuAEfuG6U+JyNTBCAT1LAyj8fut9AfkSRJ+HG
	PVWRY4YRpMFaRfu/NbGdFIKI/RrUTdeo0ifNGn+27nRbtB38RhEr0w++wwsn6daPjgzEQoF2e4b
	QhhyRHTs1Uy3dihPJ4KV+sApBoiNc7W9Yzk43BuMqEqnydQ5ckSAIpD7HKFLHPklxozLqyzqKWd
	zQ/1+IfAMVG/0eXSNXj2UVwiI+tQAbOQ/F6ScpY5is8NB6/lxGnR67Akcq4/kqIIUW5BQcez+y1
	hW34zTxk+U7oH6l5/tAZmhLiRrwt6RQ6pYeeKNJBolaCTeVmooc5n0QwQweQ9g7yWy+FWi8WutV
	iie
X-Received: by 2002:a05:6a00:3397:b0:81f:4566:cce8 with SMTP id d2e1a72fcca58-81fa184d5b5mr6837551b3a.55.1768755774223;
        Sun, 18 Jan 2026 09:02:54 -0800 (PST)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1094bfasm7050390b3a.1.2026.01.18.09.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 09:02:53 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mshv: Fix compiler warning about cast converting incompatible function type
Date: Sun, 18 Jan 2026 09:02:45 -0800
Message-Id: <20260118170245.160050-1-mhklinux@outlook.com>
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

In mshv_vtl_sint_ioctl_pause_msg_stream(), the reference to function
mshv_vtl_synic_mask_vmbus_sint() is cast to type smp_call_func_t. The
cast generates a compiler warning because the function signature of
mshv_vtl_synic_mask_vmbus_sint() doesn't match smp_call_func_t.

There's no actual bug here because the mis-matched function signatures
are compatible at runtime. Nonetheless, eliminate the compiler warning
by changing the function signature of mshv_vtl_synic_mask_vmbus_sint()
to match what on_each_cpu() expects. Remove the cast because it is then
no longer necessary.

No functional change.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601170352.qbh3EKH5-lkp@intel.com/
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/mshv_vtl_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 2cebe9de5a5a..7bbbce009732 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -845,9 +845,10 @@ static const struct file_operations mshv_vtl_fops = {
 	.mmap = mshv_vtl_mmap,
 };
 
-static void mshv_vtl_synic_mask_vmbus_sint(const u8 *mask)
+static void mshv_vtl_synic_mask_vmbus_sint(void *info)
 {
 	union hv_synic_sint sint;
+	const u8 *mask = info;
 
 	sint.as_uint64 = 0;
 	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
@@ -999,7 +1000,7 @@ static int mshv_vtl_sint_ioctl_pause_msg_stream(struct mshv_sint_mask __user *ar
 	if (copy_from_user(&mask, arg, sizeof(mask)))
 		return -EFAULT;
 	guard(mutex)(&vtl2_vmbus_sint_mask_mutex);
-	on_each_cpu((smp_call_func_t)mshv_vtl_synic_mask_vmbus_sint, &mask.mask, 1);
+	on_each_cpu(mshv_vtl_synic_mask_vmbus_sint, &mask.mask, 1);
 	WRITE_ONCE(vtl_synic_mask_vmbus_sint_masked, mask.mask != 0);
 	if (mask.mask)
 		wake_up_interruptible_poll(&fd_wait_queue, EPOLLIN);
-- 
2.25.1


