Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEAF17A972
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Mar 2020 16:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgCEP7F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Mar 2020 10:59:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35307 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgCEP7F (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Mar 2020 10:59:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id r7so7685737wro.2;
        Thu, 05 Mar 2020 07:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aCB9L1TCzoGV2wPRhB/5CLpoAqtfcOA7EFraTWxgd74=;
        b=cqGlS1xk7wG0NnLLcjcuNia/wPD/dnf24mXs/sLI6jPUC9sTUEK4xUiJrtdGm1k53s
         BrI43owyJlBG4F0A9J/7YKfRMBqT7atv6xN6RkA1QUU4MdfCvGg8G2+1NYCB9paT2AtS
         srO6t25Ffjt8N3N0wyZd7/l20k+j2vdJ6jOYHpA1UZXKjxR0+ucRwhqgWSsSZm3ZWpKh
         ZN9ShH0gabqZaVCZuqZFxrqcF7DYPCAqfez+Ij8Ghyr6femvl/Xvrv24/ZCQYGivhP76
         B2aRW91+zQeyNysegH6VCL+P9vFA/k5aBB6f00iK+Tus9p+m8k881o+ExJQvvKXwJW42
         UshQ==
X-Gm-Message-State: ANhLgQ1x3HPWuoXlJ9e8VSeFrkJnUa2GYrJGq1eJ3hE2J4t1sVXOo3Bn
        ESn9A2DrnBEpluTq4uDY0yQ=
X-Google-Smtp-Source: ADFU+vvMwTPvKadCAFBemUxuFtpBthjV2ZtzZjzNC6JbbgqinjgxbqNSGThIPS/v5DHroI6F6JDlCg==
X-Received: by 2002:a5d:5290:: with SMTP id c16mr2345631wrv.235.1583423944306;
        Thu, 05 Mar 2020 07:59:04 -0800 (PST)
Received: from debian (41.142.6.51.dyn.plus.net. [51.6.142.41])
        by smtp.gmail.com with ESMTPSA id p15sm9453994wma.40.2020.03.05.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:59:03 -0800 (PST)
Date:   Thu, 5 Mar 2020 15:59:02 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        sashal@kernel.org, haiyangz@microsoft.com
Subject: [GIT PULL] Hyper-V commits for 5.6-rc
Message-ID: <20200305155901.xmstcqwutrb6s7pi@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

Sasha Levin recently stepped down as the Hyper-V tree maintainer and I
(along with Haiyang Zhang) will be responsible for sending Hyper-V
patches to you.

This is mostly a "dry-run" attempt to sort out any wrinkles on my end.
If I have done something stupid, let me know.

Please pull from the signed tag below.

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
tags/hyperv-fixes-signed

for you to fetch changes up to 5313b2a58ef02e2b077d7ae8088043609e3155b0:

  HID: hyperv: NULL check before some freeing functions is not needed.
(2020-03-05 14:17:11 +0000)

----------------------------------------------------------------
- Update MAINTAINERS file for Hyper-V.
- One cleanup patch for Hyper-V HID driver.

----------------------------------------------------------------
Lucas Tanure (1):
      HID: hyperv: NULL check before some freeing functions is not needed.

Sasha Levin (1):
      Hyper-V: Drop Sasha Levin from the Hyper-V maintainers

Wei Liu (1):
      Hyper-V: add myself as a maintainer

 MAINTAINERS              | 2 +-
 drivers/hid/hid-hyperv.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)
