Return-Path: <linux-hyperv+bounces-2947-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C57B496CDA5
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56FA1C225E4
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64200148853;
	Thu,  5 Sep 2024 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCcuerbz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A3C126C1C;
	Thu,  5 Sep 2024 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509865; cv=none; b=rYXBwAdZJUtAdo8xtqn4Rn6SalLFZBELt4vNNcWfCJBF6vdpoQGKpFmbSnKa6aLHXUDSPbiLCMlTPAs1DwtuSZmCuLmaNXfUgUnJybfhk3w8MZ53K+082LrDGzRZBGzfkFYTgJ8ZHT3dF5OqGdjGtBCRGfz9ewLVGlEeaabqLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509865; c=relaxed/simple;
	bh=8cHGr+GH14IwDdxFnQ/5Ipz4yJW72zoitNYtP9WhIjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YCc8Aq/EUUoJCEH04rXupwPc4ZaMbc3Wf555Ao/3PQcbDiMFiu1G5+HQpI9vJe3kelMq7LVBPc4VXR8t+OySSVt7GDfGu2j8GZnMPejqfemqNyaQ0iuODcVyCiTLwYNSJFx0MQQsBx3e299fUHq2jf/+3Pby+k14VRVv76uozt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCcuerbz; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5dc93fa5639so212534eaf.1;
        Wed, 04 Sep 2024 21:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509863; x=1726114663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K4M9q+kN73VYSDW6L8zxKtLlMvaCoXBGrFd+VEAeAfA=;
        b=KCcuerbzLH/pqN1eBTAZMOxqR0LiDKdB69BSMXbAFfjtCGkKdLsZ7QrPWKQaTnhH8i
         5BNc7eTwPgKAo6RmXwYrgoWOHiuucPwM/MNzJzIJFt7vYIs7PECFFM9ArKjrHmrU174k
         4ngrZHXQ/d/mk8q55TumYXzlqRkGEHqzQ+/n/iao3YBh8CXy5PaFXFflJStbdmgOBdGh
         fUTzcm4OQqCSxnPkDtSbNJt6qnt/GsPWaEYavi0MJLRs+eZVnDiqNBc2hUiiPE627bc8
         ulu1sD7BXLUrGrRrA7wDHG6HSCvVmOWDAd615NNR3Z3N6XT+fIVarz/uA+jPlXO0mybz
         lm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509863; x=1726114663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4M9q+kN73VYSDW6L8zxKtLlMvaCoXBGrFd+VEAeAfA=;
        b=FQDd8IIfElWIC6Y/YEksXAXUJ8+19xrsgRbRvTkZ8icFNz12lbiKlTvi192wrJ7ugP
         08o6FiI5ihd5rcKlq1dsWLyJF5HsGj8k9nRRqnHxTbU0tEWraAgf3lr/JD0rC5xVIjzJ
         du1yVuylWX/g2WcujeqwPFo/bkuBdiJOVVskq7rA9/xtL32y/L9PU09guSi8mTjlGipA
         838NOqNhJCHKG+c3jwiWSF0GrvGerC9+qKq/bTAkiSdUZvDoc6SjDlzCCA3HU/JKTMKq
         OVkpVMzBWUefB0qdfOvYxqv6P4kXxThkjeqzy7TGz6tc26SMqym3M7jIcUFgLV4fi9Qk
         9PBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcTLjAEjZDWoO6mvnqtKrogJmJqi7xwJT3tXcG/9cOzGkZMwdxnMLJwClT33nuiaYKmIJwjsUDVmI3nwLQ@vger.kernel.org, AJvYcCWOVD4DpJMAwlp06GnfTX60vYhbYSDXOtEZHeU+EYJWkwKMOlrTu/WZgbR0YeWgmcZeuTCj0Xh3W4b/gmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi71ovY7pfBqGirtKG9b5ul7wCgSV29uXqu20u+OWOe66bbOpI
	U6VbbhpyqBR9zVzHewqNOmTPNhVpNIE2b//DS2mUyNDZAepiwFOULB04Ew==
X-Google-Smtp-Source: AGHT+IE346rXlPlagQTZcOHpZl4+DAe05+tRp5bqoGWXkgCQc9psXkFiWkYrSTnLTh/SBEscY60t2g==
X-Received: by 2002:a05:6871:3a28:b0:251:2755:5a33 with SMTP id 586e51a60fabf-277d05f9b26mr18381175fac.39.1725509862578;
        Wed, 04 Sep 2024 21:17:42 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:17:42 -0700 (PDT)
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
Subject: [PATCH 00/24] Convert serio-related drivers to use new cleanup facilities
Date: Wed,  4 Sep 2024 21:17:05 -0700
Message-ID: <20240905041732.2034348-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series converts drivers found in drivers/input/serio as well as a
few of input drivers using serio to use new __free() and guard() cleanup
facilities that simplify the code and ensure that all resources are
released appropriately.

First patch introduces serio_pause_rx guard that pauses delivery of
interrupts/data for a given serio port by calling serio_pause_rx()
helper and automatically resumes it by calling serio_resume_rx() when
needed.

The following 8 patches make use if this new guard.

The rest of the patches switch serio drivers to use guard(mutex),
guard(spinlock*) and other cleanup functions to simplify the code.

Thanks!

Dmitry Torokhov (24):
  Input: serio - define serio_pause_rx guard to pause and resume serio ports
  Input: libps2 - use guard notation when temporarily pausing serio ports
  Input: alps - use guard notation when pausing serio port
  Input: byd - use guard notation when pausing serio port
  Input: synaptics - use guard notation when pausing serio port
  Input: atkbd - use guard notation when pausing serio port
  Input: sunkbd - use guard notation when pausing serio port
  Input: synaptics-rmi4 - use guard notation when pausing serio port in F03
  Input: elo - use guard notation when pausing serio port
  Input: gscps2 - use guard notation when acquiring spinlock
  Input: hyperv-keyboard - use guard notation when acquiring spinlock
  Input: i8042 - tease apart interrupt handler
  Input: i8042 - use guard notation when acquiring spinlock
  Input: ps2-gpio - use guard notation when acquiring mutex
  Input: ps2mult - use guard notation when acquiring spinlock
  Input: q40kbd - use guard notation when acquiring spinlock
  Input: sa1111ps2 - use guard notation when acquiring spinlock
  Input: serport - use guard notation when acquiring spinlock
  Input: serio - use guard notation when acquiring mutexes and spinlocks
  Input: serio_raw - use guard notation for locks and other resources
  Input: serio-raw - fix potential serio port name truncation
  Input: sun4i-ps2 - use guard notation when acquiring spinlock
  Input: userio - switch to using cleanup functions
  Input: xilinx_ps2 - use guard notation when acquiring spinlock

 drivers/input/keyboard/atkbd.c        |   8 +-
 drivers/input/keyboard/sunkbd.c       |   5 +-
 drivers/input/mouse/alps.c            |   4 +-
 drivers/input/mouse/byd.c             |   5 +-
 drivers/input/mouse/synaptics.c       |   6 +-
 drivers/input/rmi4/rmi_f03.c          |   4 +-
 drivers/input/serio/gscps2.c          | 114 +++++----
 drivers/input/serio/hyperv-keyboard.c |  38 ++-
 drivers/input/serio/i8042.c           | 327 +++++++++++++-------------
 drivers/input/serio/libps2.c          |  28 ++-
 drivers/input/serio/ps2-gpio.c        |   4 +-
 drivers/input/serio/ps2mult.c         |  25 +-
 drivers/input/serio/q40kbd.c          |  10 +-
 drivers/input/serio/sa1111ps2.c       |   8 +-
 drivers/input/serio/serio.c           | 164 +++++--------
 drivers/input/serio/serio_raw.c       | 125 ++++------
 drivers/input/serio/serport.c         |  27 +--
 drivers/input/serio/sun4i-ps2.c       |   8 +-
 drivers/input/serio/userio.c          | 141 ++++++-----
 drivers/input/serio/xilinx_ps2.c      |  15 +-
 drivers/input/touchscreen/elo.c       |   8 +-
 include/linux/serio.h                 |   3 +
 22 files changed, 487 insertions(+), 590 deletions(-)

-- 
Dmitry


