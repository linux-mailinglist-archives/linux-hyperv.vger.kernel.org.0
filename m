Return-Path: <linux-hyperv+bounces-3552-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5A49FDC0C
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Dec 2024 19:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C72160A9D
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Dec 2024 18:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973C21A0706;
	Sat, 28 Dec 2024 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av5U7meb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBD81A00F8;
	Sat, 28 Dec 2024 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735411823; cv=none; b=jz4EpvYyQgPkUh/l/YQxsLOTrg1weroKpXksfIVnwp163M9db3qBQmpl7aBV4BYXVH1f5PpX8TChluKo37KltBD31qDdtZ2W7AQm2CCOZQmeNcMgaaUal9dN9l33RDCjSjKoyazng+6PVtOW5wbj6hqeMk9ITqNxVeGh17MoKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735411823; c=relaxed/simple;
	bh=iW9ylujeTdndT37/iM7oaUQu1ZpcpSzb4qLxy9BPmQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtjGxmTROAs0eGTmdkmbhVVVeGPIh6DvoE6Oc6bVudHf6c8vsMF05qXxqEV2RzybHtyFTmemPMaL1wK1Q9Xwrl+ZL2Bs6EZFMHh3PClTh4RZ4V7HlGzbIGXnbD9sIwqRd4+882z+xTC1p0nJzah+FaqHdnRy3vB24WgopezoJyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av5U7meb; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e398484b60bso8677342276.1;
        Sat, 28 Dec 2024 10:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411821; x=1736016621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OLhVdLNIy86InjJpjUKoLKMqO34Ru2M3pMOZX0/BuM=;
        b=Av5U7meb/h9zYMV0VA43DnuVDG+OIdsKCMKbsToFnECDo6zaon2D3Kr1z4EsJ2qXA1
         RE6kEJfuOWdhYJNg1wY4USxkjDaelkbOyMKPlby3U8xYR4Y6wvIxKLvmR94372bO60+j
         NcDGzBic0ttjPtHqaukJkuXYDH6fUVmw9TtxdSXtleQyfWFc8ySUypTamfosfutvmai2
         kMRTaHxztwtowqr3szoYo0ElJ4oIS80NsHeLYVwIEyyy/KcfQ4sMfdyeuMRp2l5Yg3/B
         yFZCZSQ7TdWjK/ID/j3D2R1f8EPc14Omr0HgqprUvXCY5e0jl5RqE8uDgEk7PGrmCl9K
         wrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411821; x=1736016621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OLhVdLNIy86InjJpjUKoLKMqO34Ru2M3pMOZX0/BuM=;
        b=GWCc4Kf72JAW9IHEBg/+sY4V2sfWDQfbUpSNRdZmsJeozRYHRC6auIO0IVGGiCweg4
         IkavztH0Ke4vIklx8XcLgXTkM1Vb/eNnMecvAWu0LWpDeQgKEV57pBtTrkcw8uY8awYL
         nv5Gg5QVy87SFk5Q0kq2uzMcRsbBW9K4iSVkV7zT5EJ332htGq+6Y0qJ+Vc/WCDC121A
         opjouFZW/C5aALIaIA6LE+wcmam5E5bmzj9HxN6ZMwnlIXbePIWjy2trymUxak6NE2Qd
         iqYZTpIMkxGN3zNem+aHG1qWiBovssukGRQ0k9xu3x0DosULmK1mxOr+aCxd3yljaLew
         lx5w==
X-Forwarded-Encrypted: i=1; AJvYcCU+DmxbRm1/UwVfiIn4uYka/Q/7U6vvaTNLfxM/Zok3AYu+M8XOfiuKtqAtINnJ6/EwTECITKUFOVdMsSE=@vger.kernel.org, AJvYcCV1eYuMv4SQQsRPjBv1Ia44/guhXGaUEJv6DHjMI6pMPngCNkte+p9MqutLA5YyujWar1rqUm+taiWQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXtH9JzoaJk1/EJR0GXUC1sqnpOWMskx/wqX7J0ZlvoSJW5NF
	mjsw3MVDF4YC+U3MeJ0yAUdUps8Vsb45FkhU8yMLFtBoH4S72OQvVLseky5s
X-Gm-Gg: ASbGncuTkHaqT7G5UWWSAOT4a9nrjedpcikCuUigEAhsxHNdDhVX0uNh/9Zj2yCpYYK
	eLepMHGf5A4LjwpMWtfJ6UU5NXVAQimSns4bLhUIdCdh/XMWB31WTf/rlcZKRx84da0OfcR0apZ
	V5qKi3qgp9WPKxlwnLVNtVkIbwH6QIQXnaAoyVvv7cd0F0wHSANhIpEO+38vcN7tJn2ZS/CQMXO
	AsnwGOafuaGcjQ8rIformfuLopng6R5p1CVLEOUe+dV4wg+0+890IGMX+RFeKu+7VMwvDGMO5dt
	/ub6W+W3mGvLgCXH
X-Google-Smtp-Source: AGHT+IFcN0Go12HlexbfvKdqPGehFZUpfM2D5CjlN3akVq3/w+FTn+K4qrCtvr5d4IqwedfN8cLy+A==
X-Received: by 2002:a05:690c:490c:b0:6e2:43ea:552 with SMTP id 00721157ae682-6f3f8110ed5mr204402267b3.16.1735411821056;
        Sat, 28 Dec 2024 10:50:21 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e743ba07sm47965447b3.28.2024.12.28.10.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:50:19 -0800 (PST)
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
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 13/14] PCI: hv: switch hv_compose_multi_msi_req_get_cpu() to using cpumask_next_wrap()
Date: Sat, 28 Dec 2024 10:49:45 -0800
Message-ID: <20241228184949.31582-14-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241228184949.31582-1-yury.norov@gmail.com>
References: <20241228184949.31582-1-yury.norov@gmail.com>
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

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 86d1c2be8eb5..f8ebf98248b3 100644
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


