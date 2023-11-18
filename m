Return-Path: <linux-hyperv+bounces-977-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5987F0090
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Nov 2023 16:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED82E1C208BB
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Nov 2023 15:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C19718C2D;
	Sat, 18 Nov 2023 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcd/ITOD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E641992;
	Sat, 18 Nov 2023 07:51:32 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a877e0f0d8so32646977b3.1;
        Sat, 18 Nov 2023 07:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322691; x=1700927491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an+B6x9GS644FA4Rk778Y0CGpfaOfqQCwN2Xt25DKlo=;
        b=Rcd/ITOD2m9aVQEloHhk6b5W/g9VVxTP+FPhjUibMHhWW+UyofAYE6E6XaVsJkelaa
         1FurLJpmQTQYUnOTAh0zWbO9krO0XDjwL4EVEAn3GtQ7yUqdGDDpLETHf8RYSUFv1rKF
         gqviN3RgiEj1Qp+Uuxmo+9oIPJbBOvRvzGeQQOV9tISy1tjFL0dHiQN0rlpUsDQddOGX
         EaA6OHurJPnWpPYHuibF2zCJsnHLurNrqzCmIQUEEXlo24TWwJPPFPXCMG9DXzU14Hgt
         Bullw6uV/qUGM4ONhmO4sCeLyyzIzzpvyQsGMrmObCPErIcy1/uidjFId4F+tlqAZqa5
         mP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322691; x=1700927491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=an+B6x9GS644FA4Rk778Y0CGpfaOfqQCwN2Xt25DKlo=;
        b=VfOJabkPz1FtLH/mZcmCRAioTgckNPotClE7g9dlseGJI+TNgxph7rhwpZEDxWmvP6
         T+BIGKJqBk2ZdJboGgB3tyHsGMHo4OlD20JU9IK7aDRDmC1dtgBHS2gShAOUbBXl+EVG
         xl+DVtkryBh4dmpAITxCB29iwidOeQ5YPkZLKR3K9b7pNf7zR71ybI6S5inGwMmiOe3o
         H3EiSk4ssZ2sle8a+tWbOhzB6fK+I8A/AVeSMwkLQq8Sog7mi03aayGmhqQDgTjkpkny
         AHeqVDj9WxvPifSCcW530EBRZSEshi3n32RAmzvG7bZAP60h8wMZvjSJ1qQiE4km1fDV
         9V0Q==
X-Gm-Message-State: AOJu0YzKs71rDIY0H7+VRnRtu01Yfu5301Eke8Ely9Q6lukNR2F/rqpa
	Y1/C1875PwYFhZWsH3d7I7OktnglCF/BvlW5
X-Google-Smtp-Source: AGHT+IHbvXN7lio1g9e2seZANV3yFJAOfMLAbKKE1aiTJhcFrm7juiKH6C+xV9/Loyma/Ox9uC7NIg==
X-Received: by 2002:a0d:cb45:0:b0:5c9:3442:9c8c with SMTP id n66-20020a0dcb45000000b005c934429c8cmr941390ywd.21.1700322691140;
        Sat, 18 Nov 2023 07:51:31 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id i78-20020a819151000000b005a7bf9749c8sm1173851ywg.4.2023.11.18.07.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:30 -0800 (PST)
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
	Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 14/34] PCI: hv: switch hv_get_dom_num() to use atomic find_bit()
Date: Sat, 18 Nov 2023 07:50:45 -0800
Message-Id: <20231118155105.25678-15-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
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
2.39.2


