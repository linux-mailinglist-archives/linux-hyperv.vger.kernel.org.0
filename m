Return-Path: <linux-hyperv+bounces-1182-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA2B8026E2
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Dec 2023 20:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6A11C208BD
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Dec 2023 19:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27DD182AA;
	Sun,  3 Dec 2023 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpXNJ8kG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EDB109;
	Sun,  3 Dec 2023 11:33:36 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d7346442d4so9640527b3.2;
        Sun, 03 Dec 2023 11:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632012; x=1702236812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEaUDtVEXhS2xSrmOtKVY2kz6kMUS/zN4/Y90wQZFHs=;
        b=kpXNJ8kG88GPN/GZxBXgTw8UcxjPNB/NZksq4B8wRRjAkeLjxfknRYp0tErs6RvmsG
         U0J+A5sWZs/FMw1GZZz2ZJMgvNpr9EaC6Gf/E43UDsnklcbrx4Exa00xG1go6y18Zrst
         iLyNFj4vahdrbt1ZxS4jH7HrNK8k5JeMe49+LWINmzroKkbQGl9ZTye/GPRkxFq4O8HJ
         8m3PGAFkt2rC88HHTJ2zjFf5fZu6rWTNckDs+0Q3rQNyOcrGJhjJByHY+GIjrDMOGLAw
         wpLRmJDsv8rkdIr/wvdvIE8H3lWuvoxJiFR3AEwAU1xYLVp/whrMyQiP7l24IDuuZ2f6
         aUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632012; x=1702236812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEaUDtVEXhS2xSrmOtKVY2kz6kMUS/zN4/Y90wQZFHs=;
        b=TYK5BVxSWmfDsx8qrqY81jHxxCZwzMihC7qwAMg36rTDxNmppmxpVkeXJCPmcCu1PY
         hwUgVV3QbHIC0Sv0iV8KzOuUNTxBmLElrDHlJPRh3/wRDEgANTe9bgNy2mxJoRY2Bj/q
         CUFw+MavXZKx+3hsZmPgaBLEN/exNP+iKUsIYFzSipA+9da4eFkrGIjbJ3pKxWrea/tj
         JDXFC9Tx9zFHr8FzuZ7Rwb8jQ/vi7HC7BThJPUZ5nGmDbH1K5IiI9/CEVGI2ag8OcIBL
         P50FGjTIMu7Oa995tYW/Xm83Pjo14F/ieu7tCEEVfZLa1q2O65+1RMtDPGuw8Mqf7XqB
         7OpA==
X-Gm-Message-State: AOJu0Yy3/SyaRlAsOOGLEGusQpShOyFmhxLc6vFlcFw/tIZK0/2CE/Y1
	2bWS7jsJnxRea9/HTbl4rF0rhI/1w1sGDQ==
X-Google-Smtp-Source: AGHT+IFwlxbZmbVc92xt+VMP3rP0BOnEAVGzjU8EWbb35CAGKD2MV1oUsEubzmorbR3mspDtYKW6Og==
X-Received: by 2002:a05:690c:70a:b0:5d7:70a0:ea01 with SMTP id bs10-20020a05690c070a00b005d770a0ea01mr1159765ywb.7.1701632012538;
        Sun, 03 Dec 2023 11:33:32 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id v184-20020a0dd3c1000000b005ccdfce2860sm2753736ywd.98.2023.12.03.11.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:32 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v2 14/35] PCI: hv: switch hv_get_dom_num() to use atomic find_bit()
Date: Sun,  3 Dec 2023 11:32:46 -0800
Message-Id: <20231203193307.542794-13-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function traverses bitmap with for_each_clear_bit() just to allocate
a bit atomically. We can do it better with a dedicated find_and_set_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/pci/controller/pci-hyperv.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 30c7dfeccb16..033b1fb7f4eb 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3605,12 +3605,9 @@ static u16 hv_get_dom_num(u16 dom)
 	if (test_and_set_bit(dom, hvpci_dom_map) == 0)
 		return dom;
 
-	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
-		if (test_and_set_bit(i, hvpci_dom_map) == 0)
-			return i;
-	}
+	i = find_and_set_bit(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
 
-	return HVPCI_DOM_INVALID;
+	return i < HVPCI_DOM_MAP_SIZE ? i : HVPCI_DOM_INVALID;
 }
 
 /**
-- 
2.40.1


