Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1E27A52D
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jul 2019 11:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbfG3JuE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jul 2019 05:50:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35712 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfG3JuE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jul 2019 05:50:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id r21so46162628qke.2;
        Tue, 30 Jul 2019 02:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q1N8QIjRCQVvQCWPk5TXtEOdMdSZgm2VIBTcTaRGuaQ=;
        b=tBV0OSKUjbGcVEybvEEXJbS+xtRtKj+ThiR3p6SLTOq1UmTRsuSkL8C0xJUh3xNuUM
         yikq5vG8VuybYVMT0jmA9wDMYlxJLMSXsdKOxkzUwxvZXKLdv7d5IziFjzbgNpIVN1ff
         utPBeFqzm1BLHgEaqmC5pBsjNoJlK0MVXD5PHn8lyX7KdVRguZ+JoaWTTAr63Bo3jjgU
         cN8EHhOq4082O7xnwS2TzHpQaNPquiB4f4cLI702PhbFp/lFroJqj4Wf3srwFX2JfaWS
         UYLozUYy6zZ28Sn79shH7AKUWmXQRBE4bxY71hztOtXYWDFTyDCHofJ5YivbaFnsMgTM
         fGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q1N8QIjRCQVvQCWPk5TXtEOdMdSZgm2VIBTcTaRGuaQ=;
        b=IeMOeXtqQyIqjFlm6w2fVsjkY7mVTgOn5bE2/IlqEC14rCl8CONDwdg09nALt/Wgkf
         /f5i/e5m3lMVu6XQayjuzWl1q33WRZ0ZBnJ2jcFTVTD0D4uRGy45OclykZjnljtuhTtI
         XgAD2XrMvrS84mIJ9xzb2CIY4yuO+cK2PHEjcmT36UzmdXnlWLlgsrenV/0KYBtheRQZ
         bhWNTHf2zRXvv7ZwzhwVZqwiv1N67MF3e7CDCdNkowrMqE8Ex/bDzBFPiGIzpFCP3bRN
         8xuHV+XSjJWcwXgvwPXwBhudlBZf/P6MbR6zc6N28OkmNvAVKI5loFy2KtRratNPxpos
         IxLw==
X-Gm-Message-State: APjAAAUP80l8Yp14jJAcYZdfiZnrBJqHfH+9c2ZjFppjXKP6/Q9F2hDE
        SB/Eshc53XrNFr2fmr/PzbI=
X-Google-Smtp-Source: APXvYqyQkhjaWwuoTireCkhChIt3cJL2odow9d/c5cI6mdhcnnLYbd4Z8s9b332F3kQn3GONmpoh2w==
X-Received: by 2002:a37:4e92:: with SMTP id c140mr69434079qkb.48.1564480203629;
        Tue, 30 Jul 2019 02:50:03 -0700 (PDT)
Received: from AzureHyper-V.3xjlci4r0w3u5g13o212qxlisd.bx.internal.cloudapp.net ([13.68.195.119])
        by smtp.gmail.com with ESMTPSA id d9sm28198078qke.136.2019.07.30.02.50.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 02:50:03 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
X-Google-Original-From: Himadri Pandya <himadri18.07@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Himadri Pandya <himadri18.07@gmail.com>
Subject: [PATCH 0/2] Drivers: hv: Remove dependencies on guest page size
Date:   Tue, 30 Jul 2019 09:49:42 +0000
Message-Id: <20190730094944.96007-1-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V assumes page size to be 4KB. This might not be the case on ARM64
architecture. The first patch in this patchset introduces a hyer-v
specific function for allocating a zeroed page which can have a
different implementation on ARM64 to address the issue of different
guest and host page sizes. The second patch removes dependencies on
guest page size in vmbus by using hyper-v specific page symbol and
functions. 

Himadri Pandya (2):
  x86: hv: Add function to allocate zeroed page for Hyper-V
  Drivers: hv: vmbus: Remove dependencies on guest page size

 arch/x86/hyperv/hv_init.c       |  8 ++++++++
 arch/x86/include/asm/mshyperv.h |  1 +
 drivers/hv/connection.c         | 14 +++++++-------
 drivers/hv/vmbus_drv.c          |  6 +++---
 4 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.17.1

