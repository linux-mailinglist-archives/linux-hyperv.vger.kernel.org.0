Return-Path: <linux-hyperv+bounces-2440-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED0790A69D
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2024 09:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563A7B29983
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2024 07:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812E1862B5;
	Mon, 17 Jun 2024 07:11:25 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41739FFB;
	Mon, 17 Jun 2024 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608285; cv=none; b=CpGlpHa5YTa1/kJBYHKkw0OgTyRECDrXmtqN+seZfI2q8x25Qx5mA9IszQV7lgo2Vr6J5Lqw3uhbg7Ii6tUC3SBg+FPhXYTthiDZrHZ0J7G4F2P+qVevTrxg+caDny5aYda6H+r9dDUj2vB/9bHFkhdTwo6a+1jySXKnA/SlyOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608285; c=relaxed/simple;
	bh=XWQ+qDwz2PAtc3IT4zdlFtNhLeXIlAT/T/wXydCL2WA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V/sUxcN1tE/yfZpwDZBOn3TgJKNqFID1Gditr+03obLK6de7CBRLuojnoRJVR8QEVqnXw8U0/ED/gN428AxAWGVydaWhHAkHgeq9NLw7RmJEWPG1LOML2UBdrmgh3UZcMpKIUKlpNJvxAosWxrn6wq3qfitAtmxW0nI6bP1NbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b97b5822d8so1982943eaf.3;
        Mon, 17 Jun 2024 00:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718608283; x=1719213083;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPdollrdzmZvPOrkAD6RqNZZPh5XUrVz9dGfzPzpStA=;
        b=GfxwF10C18gqZRlnT8oT/SXet5DRJ1/nFv3qIBCfpXgdneXVdFsrZRcd/OJOqFs+x8
         GwIxze9RaS2uCe1R6yNqjPiCBTkCU7Pgc+4a36XhicVbpOZwajHHqe5qZ/QkrUP43Qa6
         yzaBmp4hXUtid3yL/b8wG0jcTNa6DVYjVrz/MGPI/f3A3nrKlCdlDOVhN7DWRRq4sG5V
         yrK52UjEO0+EflXTP7H7b1J8tMe6qBjOVRe+lOU7KbSXlXhkTs1SMy7ASiOvklq2hUii
         2YpOov9wfzb/e+dYDuv/DR3BoKWCb7mDx9YTpe+gm0POCQE1bSgqicIBBA/2Fi+ILHuA
         cbWw==
X-Forwarded-Encrypted: i=1; AJvYcCVWt+tUzmYPo9oNnJCX4nX75HnZyvmj385KKxAhghkgjasMa/YplZLiOYyx6++Trf0V8Qd61DXzqK+cbKI/f+v6+Kph00JX+h1CFDC6lk0SHzFVOh4lCARhdK7gNHBEkUqxn4ytvFaqawWS
X-Gm-Message-State: AOJu0YzS8ueO2ioJfzfU7zJ58iqIZ8nLQTe49rQxvM9FBBMC9ZbPrBBk
	vjZ9Lb1hEeLuMFdakENjf0hbpiueEuC6trEjmjivz4g1Si9NT6XN
X-Google-Smtp-Source: AGHT+IEFUow7QG4Rb5PNS66rqOoWQI3Y3sbno3Od44HERyxz1r3RxnDxeVT3wvm8ZtAXztua0ZngGQ==
X-Received: by 2002:a05:6358:70cd:b0:19f:6bb4:e21b with SMTP id e5c5f4694b2df-19fb4ee8deamr1148327255d.16.1718608282664;
        Mon, 17 Jun 2024 00:11:22 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee3ba4241sm5208415a12.82.2024.06.17.00.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 00:11:22 -0700 (PDT)
Date: Mon, 17 Jun 2024 07:11:17 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for v6.10-rc5
Message-ID: <Zm_hlTTK0pZFMujj@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20240616

for you to fetch changes up to 831bcbcead6668ebf20b64fdb27518f1362ace3a:

  Drivers: hv: Cosmetic changes for hv.c and balloon.c (2024-06-06 06:03:29 +0000)

----------------------------------------------------------------
hyperv-fixes for v6.10-rc5
 - Some cosmetic changes for hv.c and balloon.c (Aditya Nagesh)
 - Two documentation updates (Michael Kelley)
 - Suppress the invalid warning for packed member alignment (Saurabh Sengar)
 - Two hv_balloon fixes (Michael Kelley)
----------------------------------------------------------------
Aditya Nagesh (1):
      Drivers: hv: Cosmetic changes for hv.c and balloon.c

Michael Kelley (4):
      hv_balloon: Use kernel macros to simplify open coded sequences
      hv_balloon: Enable hot-add for memblock sizes > 128 MiB
      Documentation: hyperv: Update spelling and fix typo
      Documentation: hyperv: Improve synic and interrupt handling description

Saurabh Sengar (1):
      tools: hv: suppress the invalid warning for packed member alignment

 Documentation/virt/hyperv/clocks.rst   |  21 ++--
 Documentation/virt/hyperv/overview.rst |  22 ++--
 Documentation/virt/hyperv/vmbus.rst    | 143 ++++++++++++++-----------
 drivers/hv/hv.c                        |  37 ++++---
 drivers/hv/hv_balloon.c                | 190 ++++++++++++++-------------------
 tools/hv/Makefile                      |   1 +
 6 files changed, 208 insertions(+), 206 deletions(-)

