Return-Path: <linux-hyperv+bounces-6032-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF1AEC414
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 04:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34B11BC6BEF
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 02:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D45262BE;
	Sat, 28 Jun 2025 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXqml5Rq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1D8EEAA
	for <linux-hyperv@vger.kernel.org>; Sat, 28 Jun 2025 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751077362; cv=none; b=uvgCW85eOVGnUS/bflGZCbublgtUNMvtz14h+MavfzAJ7iWKEymFFip7jnfcL+J8G0lsr+Vovy0sZpA4/VDfK/fT2w2gOPGHLQfxsCOSWtMwil7s3HfANHCi2WMJ3xfl+2cDZIfGZqynFlEUjxUgeA1MlRNgXZHPb/udgNhx30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751077362; c=relaxed/simple;
	bh=qAgOtHsOcSHfk7POh0nKDNBnAI6aMZpFS5d/YP5MU8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ch1c4ooNdSVDb/2mUzWmrtaBcQ6Xj75NLt+vaxdom6nYkfwdWZNQ/3wC3a41m37wKqbMmnQESox4UVuX0NcGMggu2VFKk2LM/s2j43wYUMhUvcE8oSY4SbMhYxiEZVWD/LVQJrABkOHTMqoq0G0cF5TdDC7sBzEuf1t4HCjq00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXqml5Rq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235d6de331fso2225815ad.3
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Jun 2025 19:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751077360; x=1751682160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CPcv6kvybXsNl3rWWRTO+foyotd5fuA49lRIROBBmc0=;
        b=NXqml5RqrCZ+HRabzoGJOZmwxBRHB8ObPfLFf0QdZYmb6kQIQabxisLgWZRKCJQbnt
         5Pm+VV0M1noA4Mwh3l9JH1CWyoBhF83NwwPFbi0zWGVb+jYPHbFeKYWhSd8swNDsFDLK
         ds8wDagjFVEqlsJnHJJf89QFHDJnQLu+0wEG12zNSM2htdBfqWk/SGe1AH9TFw7bK7rp
         t1ZlsHih7RloJGRT86g5ox2RO5smI5QNe2IZRqDJmkX90V+tu4YpNDD2M63565zEYsFb
         XJnDpRNx+FsfZDVe3/0H028/gNpJ7rYfCApq0KJgXhXi/dSa6HffhtYFgZZR6HeEenTi
         qVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751077360; x=1751682160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPcv6kvybXsNl3rWWRTO+foyotd5fuA49lRIROBBmc0=;
        b=JLSev+djSfI02P43g+TSv13AjMMxwdxeJuc49A0PlDq7SQ7iLNAsoXxE5rxoTdgUHO
         DX5tnerfhF7XyXAKbVa8c0zgxANWQ/vWfPvsS/CdfbTrKcdLH0wdbjD4euY3jUkm+JnJ
         YIf6N2sJ8PVaUq4pz1l05F5R0jfJRv3iSlPRmEVpYRE39HA46Th+61bJzAOarx2E9Mzz
         JKLsBmlpAyfBuq6Xau5PDAe0V7Mb8l9aFk/M2dEM9JFdfWgVF8ctGyAzEMzhtkeR3E98
         IgtZ9Cc9lZp0pcfehRxRjOTJaNAD3rQ4znQ1NeEYnQ4xBoXeRW7o8+1ZDqmDcuUon0rl
         bSvA==
X-Forwarded-Encrypted: i=1; AJvYcCVv6JxcY0L6gtG62B5DzeXYM++RPsxpzfAgxazThg8P2ie49aMttis3S4yZVJMdb2ycPbbxDal9+a9XGD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBlv3vavIxL0azMhhA6HdI11OM6ORpbnhNeav72wBvIzqDVttF
	egwvxeK3ZQBeKmyXiIFL1dWc8jOH7/aPTcW11Vj7uIT2mOdui2uLZEYToZA+Q7Gktm8=
X-Gm-Gg: ASbGncsavnKomVHISDEACMTbzPAnl0a9zlncVhSWtVUn6PmOo9wLxJoG/xLWgVOS2nY
	HhOoEPEw8icOkqbmoD0lykDjdYUgBCbaCvmI4hADZLzS0vgn0Q5sXHZzNE4WCJ2jp7jKe+8iPAn
	i+BpFl60HiW9F6tQM7EzuNtGQQDjlwmyniwXf2XwAmt+57jwrEy0C9dmVEdov7zbZK4i5cdWeV/
	9IfHc+4eOq2JEUfhjxmYW7bI/xs6nCZiYd1bby3eTSTbioB4VMBzi/q1E1zz4xvjd6mWrYpBxiQ
	zOfu5UWESd15W8C7R3EFrHabjH69VAf4RNwJU0/go+FD7YtVePNq0GBLRGXxXL7RnoTbATHDvzs
	xqQXGDMv3axX5RNtjelyS1ZlAR6RwYTjR7DftH4u44/N5F6v2
X-Google-Smtp-Source: AGHT+IEPhxsVm8ecDe9U8fL2ppp0XaIE64cx/GjV1YN/74cfYVW2GvvBOslOZ4Jlb8kQi8pf84YFAg==
X-Received: by 2002:a17:903:187:b0:234:f200:51a1 with SMTP id d9443c01a7336-23ac38185admr78066025ad.9.1751077359966;
        Fri, 27 Jun 2025 19:22:39 -0700 (PDT)
Received: from fc42.mshome.net (p3655040-ipxg13201funabasi.chiba.ocn.ne.jp. [114.145.228.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3d35edsm26182045ad.257.2025.06.27.19.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 19:22:39 -0700 (PDT)
From: yasuenag@gmail.com
To: namjain@linux.microsoft.com
Cc: eahariha@linux.microsoft.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	ssengar@linux.microsoft.com,
	Yasumasa Suenaga <yasuenag@gmail.com>
Subject: [PATCH v5 0/1] tools/hv: fcopy: Fix incorrect file path conversion
Date: Sat, 28 Jun 2025 11:22:16 +0900
Message-ID: <20250628022217.1514-1-yasuenag@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yasumasa Suenaga <yasuenag@gmail.com>

Hi Naman,

Thanks a lot for your advise!
I updated commit message. This version does not have any code changes
from v4.

I hope this patch would go well.


Best regards,

Yasumasa


Yasumasa Suenaga (1):
  tools/hv: fcopy: Fix incorrect file path conversion

 tools/hv/hv_fcopy_uio_daemon.c | 37 +++++++++++++---------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

-- 
2.49.0


