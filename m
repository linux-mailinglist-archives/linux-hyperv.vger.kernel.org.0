Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971DA437EAB
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Oct 2021 21:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhJVTdg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 Oct 2021 15:33:36 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:36474 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbhJVTdg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 Oct 2021 15:33:36 -0400
Received: by mail-wr1-f47.google.com with SMTP id o20so935387wro.3;
        Fri, 22 Oct 2021 12:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jbuKIQSCwzkXZ8PiOn6lg1oGS0F/5XrQqKN1fJRk0eE=;
        b=sNQ2qDLFfK13TPWNAI/lrbzwQnw4vakgRbMWsuQQdeuDhinVuB952D8B7qqm056pWX
         LFsN5fWBn68ifFh3mRvd8TF4jmZ5tsxxtzw1mBxRWLxDXGNaSrSV7cFA0hAV0I9k7v57
         Q1o9tziwv/8owwE6JBvOLMi73VXEATI5dGQqoiTXbvyCxFXXwqc4+BUfSSFa4ONd6BHJ
         VdCifXAydt4xHisozBCSZ7mArCG0jieonl5jGc7igVutkmMvD6diWqqi5dtgMcpVH9fC
         1JwB2TYcNZbgm/53Nc71JnUS/TqqPiu8uv/vZkMlHqaX5oVGV5Y5B+cVIANQ/EdDnfRl
         U2Cw==
X-Gm-Message-State: AOAM532mWWZfowkadgEaH/xj/XWq9JOjaa7GYrgx7ilRomv5iWaCZ6MX
        E+g1CJkPRRlpbowSAMDEHuo=
X-Google-Smtp-Source: ABdhPJzsrThF/p3joVoauzAo4KxaJrPZ0oPLCaOVWy8Uvhg+geEcbaEuv0TfRHw7brlW/XpwIoYonA==
X-Received: by 2002:adf:a4c5:: with SMTP id h5mr2202732wrb.38.1634931077289;
        Fri, 22 Oct 2021 12:31:17 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a16sm8645811wrs.30.2021.10.22.12.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:31:16 -0700 (PDT)
Date:   Fri, 22 Oct 2021 19:31:15 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V fixes for 5.15
Message-ID: <20211022193115.l5doheww7ljub6dj@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit f5c20e4a5f18677e22d8dd2846066251b006a62d:

  x86/hyperv: Avoid erroneously sending IPI to 'self' (2021-10-06 15:56:45 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20211022

for you to fetch changes up to 8017c99680fa65e1e8d999df1583de476a187830:

  hyperv/vmbus: include linux/bitops.h (2021-10-22 19:16:08 +0000)

This patch has in fact stayed in linux-next for two days. I just
realized before sending the pull-request that it had a typo in its
subject line, so I fixed it. That's why you may not find this version in
linux-next yet.

Wei.

----------------------------------------------------------------
hyperv-fixes for 5.15
  - Fix vmbus ARM64 build (Arnd Bergmann)
----------------------------------------------------------------
Arnd Bergmann (1):
      hyperv/vmbus: include linux/bitops.h

 drivers/hv/hyperv_vmbus.h | 1 +
 1 file changed, 1 insertion(+)
