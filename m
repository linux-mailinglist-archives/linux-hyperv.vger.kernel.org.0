Return-Path: <linux-hyperv+bounces-2948-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E30796CDA9
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092B31F22573
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC2E155392;
	Thu,  5 Sep 2024 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nso2Bgyr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726FB1552E0;
	Thu,  5 Sep 2024 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509868; cv=none; b=G/cUykWofGONwULkza4zMHfmSgJk5mFrcs3jpwPydb6eYLvmGwO9bWI0cBU40Hjr/6nVA6QUBBMQ2dJmceqNMwsJF1vEFPQqUN2F0ewg8P6NURUqKfCm4hydvE+CZXbY4ejUFVQlumJ44F63jgSpiE05RFB/yDFpxDGvjrdfsgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509868; c=relaxed/simple;
	bh=6p25Gf4otRQlWovvwdYJlg/QmPufJ3SpgDun2WG9K0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ub2+hHRbcVLH0yPgmvOQxRdMyVUyuU2cLY/oxI9GdhPkhorwL9HqrYL1oPHWcgCl5QB3bZYfqvY35isBtAhHvCdE3tbe0Kh4NIHfj9XFxXfZ5+5z/8Pkw9I5LrNQ8ZTgp5KJSg+h7VOjvJgpqYDZpRRwAJdrnCM6GU5SVoDtPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nso2Bgyr; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3df096e70f1so170311b6e.3;
        Wed, 04 Sep 2024 21:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509864; x=1726114664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSQ5nHDaIzTNEy48GC2iLuCGQVf+qFQuSKyHZ16Sx1U=;
        b=Nso2Bgyrn4QIQVh3Jncgdo91yYrdPo+4UOO5KySe+bwhrDXvI0JRmjsXxZaDUjJoet
         Aqs1/hVHLBDbu95URtZAWWKNQbt/wCcl5culcVJmyAEzOwSeMbex1SboPqnY4egRdKOd
         9EyhSS6WGVGhKqGxlx+PiTlx4QBeS7+K3a5beTcm+Szbbc7lVmwzpR3HAJIfI9G+05W/
         6D8vPU9MPJejYHXvdJ3Q3db27jCHGRtivVXXcGdxJAKw7tE+nNdOpnurljrSNtxTkzMz
         snvMPrKbf4LqXQ6rwPmIdIihJNxSvD1Lf4Z2IU3l9Nbz3XhWZcJRJyqZAgz+uDr4kR2D
         e0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509864; x=1726114664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSQ5nHDaIzTNEy48GC2iLuCGQVf+qFQuSKyHZ16Sx1U=;
        b=iKbOFaFetas7SNEwyf5Ted0hH4rfAbZCR6F/mclYwReP1LMPzwR67PXVLnOVUum0jF
         /JeHSvbewQm0PvnGqlgQ79N3rufK33WFXYUT2uufjbwvueMnmK9YUO9nOSCj77k5HbFh
         hZZmuIcHbhPRW/ZHWvscqnjLqStMTlaUV+re80HmXrtQ1myR1B2lzn/8nhbxFeLeukMe
         RvMre3cvawWco6qgiPHPc9Pkzbipk0cScbt8qfLH/pwkvnltZMljmPAMTd4BHmEmro5K
         kqfzZolfotDqJdpAjcN9kuxhCcfP/Z6TK2zXoxepjRZRY1mP+6vTTgA8ZNJE5KCR6/0r
         0UnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNPWZQknYBtGMEh9+LR8I6l0ePWoUARKC18AhPWClRa2d/NVfMe7XzqfZtfKMBBHKJcto3V11Y6gOcXKVH@vger.kernel.org, AJvYcCUdj9vcWneX/Zg1UlHHell7Wd91QS5IW8/zmFlmA+vp4Acivzf8YOWNe5scOU61mx8aWba7l80VC52+Fbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXaY+Qk5SeSHSAEsF5YuL6aBFunZkMgXtm4MDmC/4BA/1P2GTV
	WVvqv34Ocbk3X/ySNKmi53BQy6Ob6rOfLtqvlidyHSPjfEG1L3/sePUQKA==
X-Google-Smtp-Source: AGHT+IFOWA+kffVJfvYihB03juJQybTpapwcpoQKqlaiy/ZyXN6NKX8+I0jp6NbDCWaxTJ0rpgLL2A==
X-Received: by 2002:a05:6808:10c3:b0:3d9:e109:a6d3 with SMTP id 5614622812f47-3df1c98f83dmr19335301b6e.26.1725509864123;
        Wed, 04 Sep 2024 21:17:44 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:17:43 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Helge Deller <deller@gmx.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Samuel Holland <samuel@sholland.org>,
	Lyude Paul <thatslyude@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 01/24] Input: serio - define serio_pause_rx guard to pause and resume serio ports
Date: Wed,  4 Sep 2024 21:17:06 -0700
Message-ID: <20240905041732.2034348-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905041732.2034348-1-dmitry.torokhov@gmail.com>
References: <20240905041732.2034348-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serio_pause_rx() and serio_continue_rx() are usually used together to
temporarily stop receiving interrupts/data for a given serio port.
Define "serio_pause_rx" guard for this so that the port is always
resumed once critical section is over.

Example:

	scoped_guard(serio_pause_rx, elo->serio) {
		elo->expected_packet = toupper(packet[0]);
		init_completion(&elo->cmd_done);
	}

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/serio.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/serio.h b/include/linux/serio.h
index 1911827bbe0d..f4ca0aa37553 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -6,6 +6,7 @@
 #define _SERIO_H
 
 
+#include <linux/cleanup.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
@@ -161,4 +162,6 @@ static inline void serio_continue_rx(struct serio *serio)
 	spin_unlock_irq(&serio->lock);
 }
 
+DEFINE_GUARD(serio_pause_rx, struct serio *, serio_pause_rx(_T), serio_continue_rx(_T))
+
 #endif
-- 
2.46.0.469.g59c65b2a67-goog


