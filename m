Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC4E3154B8
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Feb 2021 18:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhBIRMO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Feb 2021 12:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhBIRLS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Feb 2021 12:11:18 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39748C061574
        for <linux-hyperv@vger.kernel.org>; Tue,  9 Feb 2021 09:10:38 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z22so13463836qto.7
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Feb 2021 09:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGCKDGlYFsAeKQ35sA7FkMGa834n9jSKpCwstkq+wOE=;
        b=mo+pconEnJ4FIzl3q2FWypeMdt+vrl79NlUaRO+jmv3ACE/33zoZ2wTBbSkq5UUXS0
         NURjuExjJTDxPO/QUaK/HxjUKkso06oyJiy+POQmKyTS0xhcw1cqWLvM5jRAQqfIVqzI
         c7fUoo7toEmgft3UX6CLAQa/tNsWDIq7ZbFl2GqwPcAtUeaEmDB6l8cPQRRCXl7t/yxX
         Ta8Y0opDhpZH2JM8Tsj9mhydqZzcBFxfAgduzaAsmoPmwuelNCYCxMoTGU7nwHx19uBJ
         +orKlnCHqRqlxyf9Ro3aKA5KJoxoqCFjEPQmxjVpIbTgCeO3GABYHWeh+iM8E8cVG8Pm
         VVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGCKDGlYFsAeKQ35sA7FkMGa834n9jSKpCwstkq+wOE=;
        b=tbKHjUKevbzDCbiQn8mIByBoD2gQU+27C1Ctn9A+J9uxdCGWe2hSKgsoSi3SBwr3fw
         dDo4tvkCOzE5QRtZSpGARVO7WrjP2O/PNdntONuYcDVbwe2ZYAL1KWkLauEsYaDIrfpj
         4odqqrP54PSROm2nYNgMIVrmyy5uZcynSf9agPpqVoOUYLYXk5ayANnCNJJ28d326TdX
         I25o4QmSJVOQJOBgEpwjlglK1q1p6IaWQSHl/jpA59MsF7pyFL0+bRHbpphuMUgbGBGA
         JxF7pGpJrAx9emg4DTt9NUDBjyiS84Of5uRAzyLLb/KOZpwDzojTi9tX3IqhragOR0fI
         O/KQ==
X-Gm-Message-State: AOAM533EDGC3WHLT/cUp+8VE+kqaVTpFvU+shfIDly8hwm3oGowS7x05
        hbyXc9cbSV++HTn9p+qmO8c=
X-Google-Smtp-Source: ABdhPJxYYvjDsHzOEgoEcAw/Goa3e09yKH+iXNZvArYDrnHXC1xyGiAv7mTLiV4AMDdWVtrjjL0Nhw==
X-Received: by 2002:ac8:d03:: with SMTP id q3mr20856475qti.19.1612890636952;
        Tue, 09 Feb 2021 09:10:36 -0800 (PST)
Received: from localhost.localdomain (pool-96-245-155-29.phlapa.fios.verizon.net. [96.245.155.29])
        by smtp.gmail.com with ESMTPSA id i65sm19416610qkf.105.2021.02.09.09.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:10:36 -0800 (PST)
From:   Melanie Plageman <melanieplageman@gmail.com>
To:     wei.liu@kernel.org
Cc:     andres@anarazel.de, haiyangz@microsoft.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, melanieplageman@gmail.com,
        mikelley@microsoft.com, sashal@kernel.org, sthemmin@microsoft.com
Subject: Re: [PATCH 2/2] scsi: storvsc: Make max hw queues updatable
Date:   Tue,  9 Feb 2021 12:10:07 -0500
Message-Id: <20210209171007.65316-1-melanieplageman@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208115116.wpuznzvf75duifsi@liuwe-devbox-debian-v2>
References: <20210208115116.wpuznzvf75duifsi@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Melanie Plageman (Microsoft) <melanieplageman@gmail.com>

> This patch contains a section which seems to be a copy&paste error
> from another email.

I don't think that there are any unintentional portions to the email.
Andres gave me feedback on my patch. I addressed his feedback in an
updated version of the patch but wanted to include additional context
and points which did not belong in the commit message. After some
research online, I was led to believe that doing so below the commit
message was an appropriate way to add relevant context to the patch
which may not belong in the commit message (using --annotate or
--compose with git-send-email). The patch still applied cleanly for me.

My intent was the following:
I received feedback on the code in the patch and wanted to address that
feedback with an updated version of the patch. I also wanted to respond
inline to the specific comments with text to continue the discussion.
Additionally, I wanted to make sure that the new patch showed a clear
diff with the old patch so that it was clear what I changed in response
to feedback. If I had started a new thread with this new version, I
feared a two-patch set would no longer make sense, as the two commits
should be fixed up together in a final version.

What would have been the appropriate way to achieve this that aligns
more closely with the convention of the list?

> Also, please use get_maintainers.pl to CC the correct maintainers. You
> can configure git-sendemail such that the correct people are CC'ed
> automatically. The storvsc code normally goes via the storage
> maintainers' tree.
>
> If you have any question about how to use the get_maintainers.pl script
> or the upstreaming process in general, let me know.

I created this CC list after running get_maintainers.pl on my patch (and
then used git-send-email to send it). It returned these people and
lists:

K. Y. Srinivasan [kys@microsoft.com]
Haiyang Zhang [haiyangz@microsoft.com]
Stephen Hemminger [sthemmin@microsoft.com]
Sasha Levin [sashal@kernel.org]

James E.J. Bottomley [jejb@linux.ibm.com]
Martin K. Petersen [martin.petersen@oracle.com]

[linux-hyperv@vger.kernel.org]
[linux-scsi@vger.kernel.org]
[linux-kernel@vger.kernel.org]

I chose to CC the four people listed as suporters for Hyper-V core and drivers
and exclude SCSI maintainers, as this patch doesn't seem to have much impact
outside of storvsc. Same rationale for excluding the SCSI list and main linux
kernel list.

Regards,
Melanie
