Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8436407184
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Sep 2021 20:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhIJS6a (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Sep 2021 14:58:30 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:54089 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJS63 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Sep 2021 14:58:29 -0400
Received: by mail-wm1-f42.google.com with SMTP id i3so1892722wmq.3
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Sep 2021 11:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=74RskVbk//PRkglKFcvtXGD3fWcff4Awvw+HwAVQv2I=;
        b=dPRX33XQ9cfzE/0ebgVYSO08w3IGQR7ca5g1p4M6MyKo5MIIv1YeO6CSqDqhXYY1C/
         mzPhDK+jDLx00YJHzwkm5fPnu4RK0LbJoRtWGlEB76MVsdYAtMx7XkMgSNpSVS3hsdfK
         DdphpHRsmtO7Cr718xkSR8381s8KjTcdfq+bnOOh4cIRCAigr4vp+RjHzTlX9mIQLXou
         jXAQ3JEE8lbsWoRLSg7MKguayo//gdqhQjLKh5aGSYiLFMD1pHcN8u7XMy5YZLqB6q2F
         HYtSa/9Ey4zXNbzC/JHlNIRJg3EEwz0EFoe8QrjqmEz4wfvbzxlEjwVCEPQAFhmD1jH1
         U2lw==
X-Gm-Message-State: AOAM533ujh5bp7XQWcsvMZZ2NY+tqOahSjOAzFrO10j9zXuVDBgC+cRS
        43g+4nUEgvgU+GRTpgNE10kWLv467wE=
X-Google-Smtp-Source: ABdhPJz6OvLhyFiLnRALh0Qs+h3QOPfnREWm/0JpniVUvqv1hAo4CYRAEteC0aAtcYhL7kvCtF3yFg==
X-Received: by 2002:a7b:c104:: with SMTP id w4mr3866730wmi.160.1631300237339;
        Fri, 10 Sep 2021 11:57:17 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y4sm5015351wmi.22.2021.09.10.11.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 11:57:16 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v2 0/2] Remove on-stack cpumask in hv_apic.c
Date:   Fri, 10 Sep 2021 18:57:12 +0000
Message-Id: <20210910185714.299411-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu (2):
  asm-generic/hyperv: provide cpumask_to_vpset_noself
  x86/hyperv: remove on-stack cpumask from hv_send_ipi_mask_allbutself

 arch/x86/hyperv/hv_apic.c      | 43 ++++++++++++++++++++--------------
 include/asm-generic/mshyperv.h | 21 +++++++++++++++--
 2 files changed, 45 insertions(+), 19 deletions(-)

-- 
2.30.2

