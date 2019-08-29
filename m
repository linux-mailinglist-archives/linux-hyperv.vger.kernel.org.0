Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF398A0E88
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2019 02:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfH2AIf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Aug 2019 20:08:35 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:43806 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfH2AIe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Aug 2019 20:08:34 -0400
Received: by mail-ed1-f52.google.com with SMTP id h13so1924296edq.10;
        Wed, 28 Aug 2019 17:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:references:mime-version;
        bh=xumOPnbGJ7cJyCLuLqJrCbBhj31yluZcv0TSABm5hIk=;
        b=nmeB65EJ5fgm04f8+vY6gdupp0VzYKYF4aI+eQq5CPypfrXPu9BVwGB6vGXHMLE7qG
         WuZGkaAxUDx9xCoD7p0tdgKDce8/jJDKHPvbeMwhEclDkQDOA6Ryl83jq7qEWyGgA6tx
         yqShHQDtgNlcBZkuaF4BQpjst6+8iHTBPfzWWlGXGfElIAtMfk9L0G1+CCpobJf8xCnm
         ElURu0OUyZXoVNXhV9Gx2vhp5oFfNBL/rs9qBJHG71Jv3oRFAzlDvd5x2Z6Q/sG7v4cf
         nPW17JRaFXRzdQaORNebyvyzRKpuPUgeND5B4dQiYuMXtv+RwkG679BYdEldhWtXkASV
         PXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:references
         :mime-version;
        bh=xumOPnbGJ7cJyCLuLqJrCbBhj31yluZcv0TSABm5hIk=;
        b=ira3mHqUtp2gv4MXxaImuTA46ZbvGli5YVX0EnueH+fwCBg4AqBijLoQ9vYCegz8KS
         tIV2RyXGjO7TYiGbuU01TiiISIQvptgNhnKzzcRXwlyKc0FtQKvfLpR5Ksgf6ukCRPGC
         iCiXvpG+Xa5+NEs98bV9ZU6FyeSy2u+rVUnjzifdS8UIsXsNHKHRtn3WV0FVxrZDoPbi
         aNEvKqlPGr10VivJSSKjDcYTmtMvr2JHLBeC4yKdyvhCNiA17qOo5uAugqyvkmdWuS4E
         8bMo1MumR52NqDm0EApV35or31Zs1gapzLU5ISDS1mro93fMI6qmso+2e9mgljys4J6V
         9GbA==
X-Gm-Message-State: APjAAAVqAcRA8DIG2tVoLQxaUyNLG8f/pJIDRtj4pW2QX2Nayyk0iWtP
        W5iHXbp7TUbWuQ1v6FxbGpc=
X-Google-Smtp-Source: APXvYqwnztlHP9wejSKsy5GjOEek1bCp/Na5WdTXLcyY0Ufnex1Cu88ug20O0hBMzgorn2dRL5G03A==
X-Received: by 2002:a50:f19a:: with SMTP id x26mr6846144edl.144.1567037312658;
        Wed, 28 Aug 2019 17:08:32 -0700 (PDT)
Received: from [192.168.1.105] (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id h6sm122868eds.48.2019.08.28.17.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 17:08:31 -0700 (PDT)
Date:   Thu, 29 Aug 2019 02:08:29 +0200
From:   Krzysztof Wilczynski <kswilczynski@gmail.com>
Subject: RE: [PATCH v2] PCI: hv: Make functions only used locally static in
 pci-hyperv.c
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Message-Id: <1567037309.11524.1@gmail.com>
References: <20190826154159.9005-1-kw@linux.com>
        <20190828221846.6672-1-kw@linux.com>
        <DM6PR21MB133796BB3D4A41278C513332CAA30@DM6PR21MB1337.namprd21.prod.outlook.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello Haiyang,

Thank you for feedback.

[...]
> The second line should be aligned next to the "(" on the first line.
> Also the first line is now over 80 chars.

Sorry about this.  I will fix it in v3.  Thank you for pointing this 
out.

To address both the alignment and line length of 
hv_register_block_invalidate(),
I took a hint from the way how hv_compose_msi_req_v1() is current 
formatted.  I
hope that this would be acceptable.

Krzysztof


