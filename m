Return-Path: <linux-hyperv+bounces-1346-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC092816263
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 Dec 2023 22:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9F21C20B2C
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 Dec 2023 21:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BA6487A1;
	Sun, 17 Dec 2023 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRu8j86U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804447F5E;
	Sun, 17 Dec 2023 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7b712c0fddeso105172139f.3;
        Sun, 17 Dec 2023 13:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702848737; x=1703453537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmbqyg8DlPfTFd2i7Pq7CSSoO2EKi7vPmJ3JWLvLT/0=;
        b=bRu8j86UzgZyzul0WLkMKrXg5yptjcnbMajexDB/NJvdN+i7mwYogTus4IW8+Lb47S
         yjcdGsunzfu4991TGJjzuHLMvcx/YxEngIUBwlvptlzYbJBDHesYt3lPPTO0XqL2Epjr
         1gm5pewh2+mkweNdnvU3FLfIAL2tdUZXk26FG/H+FqnpDnCW3R6TBiOoyVw4U7Gq+dT1
         Ew5qQrAtHH5HYhGaiaRBDqUmxcFEd3MvfaodmsoTABdLIGU7QPqDF49vbHFjTnQ+ZVgF
         mMl4QLni+iT/2ilDeLJo/fLdh8L5DkzFcKJsW8mQwoyL3sxL14XIV0IFRrf9FL66ws31
         RYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702848737; x=1703453537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmbqyg8DlPfTFd2i7Pq7CSSoO2EKi7vPmJ3JWLvLT/0=;
        b=ID0cfezKj1xxUwT1e1Q0VeroYwbPcaS5mjCQz805Za6kMETYnyWZpn6Y0Rl3rNJtK2
         Kf7hKuCMdn2XNva2R3baDsdGfQC3lGpsz19B+5UDoxbX4UEG3edJl37MtW4q8ehrO/Vq
         be3gT0j6mxZZmXbLlqlHPN5vLcd/+gwat2MyXZPPdbbRlPs6SO6+bP3lEBesMro45vHs
         fbAXmd0KwwjNQvTRPgLJ5lo4EiZJVtEsRpG9BMN0qBV3MPlNNk/jMWvoZ2dH8feet3oy
         jzqDkHIRdui0SalxFMu28YyDW6tF5AKvoEHk4bG9lnq9p4NPGdB5Cq+xJ/yP0lR3Zo7f
         cLZA==
X-Gm-Message-State: AOJu0Yz4Y9OtBpERs4wzfVBXWFyV2m/eWL/PCR6JKX4eStvOcTucBbKr
	lKlHx3u3Kov//ucdz7yhBxw=
X-Google-Smtp-Source: AGHT+IGAuTlKV94hm6wDKtVMsfNvhtkgut+zQtFBpXFM/a4yc/ad0PU72wafUkqYWbPZtt7KeLcB1g==
X-Received: by 2002:a6b:700f:0:b0:7ac:cb6b:616a with SMTP id l15-20020a6b700f000000b007accb6b616amr15401775ioc.8.1702848737189;
        Sun, 17 Dec 2023 13:32:17 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:9c41:1dd2:7d5d:e008])
        by smtp.gmail.com with ESMTPSA id eq17-20020a05690c2d1100b005e181bc7d2esm5307181ywb.54.2023.12.17.13.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 13:32:16 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	yury.norov@gmail.com,
	leon@kernel.org,
	cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com,
	vkuznets@redhat.com,
	tglx@linutronix.de,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: schakrabarti@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH 0/3] net: mana: add irq_spread()
Date: Sun, 17 Dec 2023 13:32:11 -0800
Message-Id: <20231217213214.1905481-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add irq_spread() function that makes the driver working 15% faster than
with cpumask_local_spread()

Yury Norov (3):
  cpumask: add cpumask_weight_andnot()
  cpumask: define cleanup function for cpumasks
  net: mana: add a function to spread IRQs per CPUs

 .../net/ethernet/microsoft/mana/gdma_main.c   | 28 +++++++++++++++++++
 include/linux/bitmap.h                        | 12 ++++++++
 include/linux/cpumask.h                       | 17 +++++++++++
 lib/bitmap.c                                  |  7 +++++
 4 files changed, 64 insertions(+)

-- 
2.40.1


