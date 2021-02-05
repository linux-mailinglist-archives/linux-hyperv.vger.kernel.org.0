Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33C2311379
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Feb 2021 22:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhBEV01 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Feb 2021 16:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhBEVZt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Feb 2021 16:25:49 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B1DC061756
        for <linux-hyperv@vger.kernel.org>; Fri,  5 Feb 2021 13:25:08 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u15so4240026plf.1
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Feb 2021 13:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aUXrpziOFgOBjICrHGUiwqXiEaV03TWfgHvW+zy0D54=;
        b=WcAmCCU3/t7kPh1K8/akc1DrzCrXDyk/iZOAJKSJrADTfkbNIjK0r3dx41KqCJtCKJ
         aGzKGRnW4IKWQDydwf1HfN3UOZHg/8j9oAuZbZ2XZdW/wfOtKPvVlAvpFVyiDAA/3Q+s
         q5U6g72e2pEwLAwDvYrmPKXH46iTxyIH7nFUvN08p2QdZxHK4wXyuwB+jPIRRYRWLoha
         pho8o2NYN2nJCIWXpSIR+sLVtPoc0EQZg2ulsSNOyvmxGMeHynACuNpB25FfY1TPVSSX
         CAXSDsx3k0ZarM/2ZxJNoGKYTcNnQHnArpcAgr0h+1BvoAmHsUtmzU5+wcqdGhVsadvh
         f5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUXrpziOFgOBjICrHGUiwqXiEaV03TWfgHvW+zy0D54=;
        b=oJqI9pCails2sFcLSJfW5pk31DtKgtZVEBwAtcuQFY4t0jjsXyxipwM6m+UEdt/wXH
         O6Z4zIpKr3oUzMAmmmBtJDcObwd5AP3FEPqALxghdNL+SlPERwLtk/5nrS18OMguNtW3
         pgpzrmWLTuSXTO3oyR6NiJYJCiY8jCz/61+NUyIR3IuoLsLZ59BianmeFr2dvCywZMpx
         VC/nW46fk7JrUydKcVvnhFyW16IL3OGU0lGdbX3WIF71cO7wcZRolm9c+fidnrD/y5Us
         Y0jpRbBsM/58uxu8L4sGntTkjrQG6r3pVu65eejMYlamwZo//uuonOxvaVWc3I+Ox4bD
         gESw==
X-Gm-Message-State: AOAM530Yq+3i0v9QDZnIKZ3nNATOiVPb/JsCWbcE/Ps1wqzLkurOxrp3
        /f7KPNcd/sNPTIc4r3Pu1HM=
X-Google-Smtp-Source: ABdhPJz+Lw+mr7LZ83+S2+kSXcTne3za7Wpdmr+fld46Yn+N8T8Pzoi2Vot3Yn1iAnmlSaStpSSAJw==
X-Received: by 2002:a17:90a:7888:: with SMTP id x8mr6152961pjk.69.1612560308000;
        Fri, 05 Feb 2021 13:25:08 -0800 (PST)
Received: from vm-122.slytdz3n204uxoeeqq2h5obquh.xx.internal.cloudapp.net ([51.141.169.192])
        by smtp.gmail.com with ESMTPSA id h15sm7828607pfo.84.2021.02.05.13.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 13:25:07 -0800 (PST)
From:   "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
To:     andres@anarazel.de
Cc:     haiyangz@microsoft.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, melanieplageman@gmail.com,
        sashal@kernel.org, mikelley@microsoft.com, sthemmin@microsoft.com
Subject: [PATCH v2 0/2] scsi: storvsc: Parameterize nr_hw_queues
Date:   Fri,  5 Feb 2021 21:24:45 +0000
Message-Id: <20210205212447.3327-1-melanieplageman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203010904.hywx5xmwik52ccao@alap3.anarazel.de>
References: <20210203010904.hywx5xmwik52ccao@alap3.anarazel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Though the convention on this list seems to be to start a new thread for
a new version of the patch, because I made the mistake of sending the
first patch as an attachment, I've included both the original patch
inline as well as the updates in this patchset.

Melanie Plageman (Microsoft) (2):
  scsi: storvsc: Parameterize number hardware queues
  scsi: storvsc: Make max hw queues updatable

 drivers/scsi/storvsc_drv.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

-- 
2.20.1

