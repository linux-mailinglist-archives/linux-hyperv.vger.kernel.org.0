Return-Path: <linux-hyperv+bounces-2519-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD979923B51
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jul 2024 12:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73641284C77
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jul 2024 10:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7121581F8;
	Tue,  2 Jul 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7UJYtf8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F1157E84
	for <linux-hyperv@vger.kernel.org>; Tue,  2 Jul 2024 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915784; cv=none; b=HUEHC3Msf6XGGiCf/VskScZLQ4PL3E3c3Mno7F80IwoqAkt7kuqVfL5hi3DDPZEP2znJinVMdnSggWbewrO7p4t/HPbPfPR+SgVOTVkebpQzTE4DVyiUzzCNYL2LEIM5ZaBsmHGYJYtSKDH6MOWY2Jino9E9oqVOYhJVmr74Sw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915784; c=relaxed/simple;
	bh=4Le8quVgFAcKD2wFWrjYAA/byX2EOZURbYhW25GpjkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YtVospfSS8nuoEgp4dlvSO6cfo1QRwmQJ630TdLa2CUUHt0SZI4/EPfuIBKnZ65/5cf/wJrxlk4SHo3b3P92pWuhRu2qsko4QiSTReW9jU0XHmFOHxpxvqd7fA6ISuT26jcIDKf2l8NdXxe/F6wzNGnb6TTRctZn6gY51KSVFDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7UJYtf8; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d566b147ffso2604301b6e.2
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Jul 2024 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719915782; x=1720520582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpfI5oQE+OU8qQAyeewD45dKFtmGigutxKDzfnbpKtw=;
        b=C7UJYtf8XZ6vmE3TMcFaqFOsLYRvYmMcNbQmtdqWtaBzrcs2r01R47o6xPZavLmfpm
         C+JSLw75HfHOUhj9alK4wmOJydwp2EgG5lFYYh8lSjGSHCbj9RWf1GEfBfLExR4yPiS7
         cj6eY0cMFvdiOYxsnCy7SJaLlW/XBTl3Ko81N45SGIOhVkOLd7VwNfvOR57kqBzmkuvt
         fb8kxYtc53OA9/wilF1+gE5bHIePqgOIIa9moH8DGMlIZP4tflQGMrNO0NlU3Fc9F42F
         +3+/IAmY5wOsYMPhW9gNhB7wAW+TSYiOP8w/Ty8qfovp1flnMWn7kA+F0kcMmYYa9gnf
         g3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719915782; x=1720520582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpfI5oQE+OU8qQAyeewD45dKFtmGigutxKDzfnbpKtw=;
        b=sGYi/2TCTxuz3XWwQer7wV7MlmuobUZetOZBOv02TeLYw+zxmxbSOSvPhLkD/XiV99
         FDWawuqPRDehF6PfhyuO6hGARh7tNEZ4LASxoIwFMFLIyvWecD/uoUxPKrL7zK9590/U
         8pZIW2L8+HxEhfyN1thKLUbMMo9eCYSoaOJP7DO1/hvAhYGCq/2QmICzeCXbDH1Yx4AO
         TdfF2NRkCZ1ZKUEW8GflsOJ65n95ftrYT1z8SJy/wSR3Nb0C2lpQ1DxYbYcW6x8dLhC5
         hZFQcxCTxjBoGLPsGeBqBwlzEzfC5fjD017k9cJcFX+sU4bs4dwfFmuDEiLQ5di1zFpn
         jHCg==
X-Gm-Message-State: AOJu0Yz9SOF92mkjhyvh8bG/k/YHiSaTCB3WmN0a3MWiV/QSHt398UhK
	FL1wTBuKlmmo0yM/MgUELYVfbchFA1J7HUH6AgvCA7nXA/BUDCE3bvtzg9RD
X-Google-Smtp-Source: AGHT+IHXyzM1xM4vXzJjpiV3Wuf76eQt/1Cs+mQ8Fmuo6x1I5e73qd+v7gdV68IQ5yM/m0TpsSxWUQ==
X-Received: by 2002:a05:6808:308f:b0:3d5:5c77:fc01 with SMTP id 5614622812f47-3d6b30f51camr10809536b6e.16.1719915782273;
        Tue, 02 Jul 2024 03:23:02 -0700 (PDT)
Received: from lab-vm-annandaa-0607173234-role-0.. ([20.171.95.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ac424sm8077629b3a.161.2024.07.02.03.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 03:23:01 -0700 (PDT)
From: Anthony Nandaa <profnandaa@gmail.com>
To: linux-hyperv@vger.kernel.org,
	decui@microsoft.com,
	mhklinux@outlook.com,
	wei.liu@kernel.org
Cc: kys@microsoft.com,
	Anthony Nandaa <profnandaa@gmail.com>
Subject: [PATCH v2] tools: hv: lsvmbus: change shebang to use python3
Date: Tue,  2 Jul 2024 10:22:50 +0000
Message-Id: <20240702102250.13935-1-profnandaa@gmail.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In many modern Linux distros, running `lsvmbus` returns the error:
```
/usr/bin/env: 'python': No such file or directory
```
because 'python' doesn't point anywhere.

Now that python2 has reached EOL as of January 1, 2020 and is no longer
maintained[1], these distros have python3 instead.

Also, the script isn't executable by default because the permissions are
set to mode 644.

Fix this by updating the shebang in the `lsvmbus` to use python3 instead
of python. Also fix the permissions to be 755 so that is executable by
default, which matches other similar scripts in `tools/hv`.

The script is also tested and verified that is compatible with
python3.

[1] https://www.python.org/doc/sunset-python-2/

Signed-off-by: Anthony Nandaa <profnandaa@gmail.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
v2:
* change the commit message body to conform to guidelines.
---
 tools/hv/lsvmbus | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 tools/hv/lsvmbus

diff --git a/tools/hv/lsvmbus b/tools/hv/lsvmbus
old mode 100644
new mode 100755
index 55e7374bade0..23dcd8e705be
--- a/tools/hv/lsvmbus
+++ b/tools/hv/lsvmbus
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
 import os
-- 
2.39.4


