Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00CD31183A
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Feb 2021 03:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhBFCbT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Feb 2021 21:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhBFCa6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Feb 2021 21:30:58 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A952C08EE26
        for <linux-hyperv@vger.kernel.org>; Fri,  5 Feb 2021 16:25:49 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id s24so4508404pjp.5
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Feb 2021 16:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9z7HiRQOXNcKj26ngMfVUQzjZopiZl0XCgeKk+JxQyY=;
        b=ZiWFXEAYuzxolEIlDjntKSNjNrm/60QhIQLS0fjIgrwpvlXmA4ukOIwIk5GznGR3Xl
         HUsZCFzG3IBd39d5a2YIDlVd+Ltog2FBmU/u23KRtQSfxT02D3tuLbz2IhHFCAZHcmBR
         /olIQefxjQKdz39Lz5ekpQdk2Sl4TD74fZH6kax35PyH/evqYKj0QKA55pp3riZ6O0MS
         6suQNKLUJk9hgDzcK7WoM1UePzeZz/XS2m9gZ8Uq4rq0InZSYXozmFLhhrvAcjDgFoJB
         7XcXRYnMu/67BXk1LS7y5OHThP/pQlWO3sJOXjQbS2ewXeodZgSj3DhrikudTQzXagNQ
         64mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9z7HiRQOXNcKj26ngMfVUQzjZopiZl0XCgeKk+JxQyY=;
        b=Lgj1geggk2/eiNODVXBxX3PSUC1AOj1Ww4JP0k23RZbSZtWye2i2qSfVTsP78SgALu
         0KeYTHTIZKazJXNuGHLDzrpQI28k09AKVcE4Wd2YvmaI5oMYPr0sxgY4KcjeePID+lOl
         9iA+LljI1tYMdtK+qLpQdxRn0JQt8k99rG0r0Ro1DVm/scSFB74ujDZEh7JXxK9j3d/9
         vDqFRbeJ1tNGYvGIotyW39lTPmBmVCjm/KIql25uhGr9ZNdJjxG5kzuBXcaBXTmxt5yp
         Tawxi7ruNHzJ7+JR5P8hHmvlVvx/j2Qvl0aAylbNWRcXJwxBw94xzmud6YHxxQC1+WBh
         IOZg==
X-Gm-Message-State: AOAM531oNRbXHo0e1lFr0MUIOrivQSNpooSyPERIE39iX560FewlXyrv
        BWeg8xmdnr9/2XS+wmONe/A=
X-Google-Smtp-Source: ABdhPJx8mmCZnsuGz6MQrJF/xAKEvK+WWZEDKWZQdzppVaeAifjYH0Cvk6bRZehrTdbmIBIciDkuhg==
X-Received: by 2002:a17:902:e884:b029:e1:50bb:683 with SMTP id w4-20020a170902e884b02900e150bb0683mr6390230plg.61.1612571148937;
        Fri, 05 Feb 2021 16:25:48 -0800 (PST)
Received: from vm-122.slytdz3n204uxoeeqq2h5obquh.xx.internal.cloudapp.net ([51.141.169.192])
        by smtp.gmail.com with ESMTPSA id x3sm11498811pfp.98.2021.02.05.16.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 16:25:48 -0800 (PST)
From:   "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
To:     mikelley@microsoft.com
Cc:     andres@anarazel.de, haiyangz@microsoft.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, melanieplageman@gmail.com,
        sashal@kernel.org, sthemmin@microsoft.com
Subject: Re: [PATCH v1] scsi: storvsc: Parameterize nr_hw_queues
Date:   Sat,  6 Feb 2021 00:25:29 +0000
Message-Id: <20210206002529.1908-1-melanieplageman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <MWHPR21MB1593548108E39D9DB9B18A4AD7B49@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <MWHPR21MB1593548108E39D9DB9B18A4AD7B49@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Yes.  If you look at other code in storvsc_drv.c, you'll see the use of
> "dev_err" for outputting warning messages.  Follow the pattern of
> these other uses of "dev_err", and that should eliminate the
> checkpatch error.

I'm not sure I can use the dev_warn/dev_error macros (or the storvsc_log
macro which uses dev_warn) in storvsc_drv_init(), as it seems like it is
meant to be used with a device, and, at driver initialization, I'm not
sure how to access a specific device.

I originally used printk() after looking for an example of a driver
printing some logging message before erroring out in its init function
and had found this in drivers/scsi/iscsi_tcp.c

static int __init iscsi_sw_tcp_init(void)
{
        if (iscsi_max_lun < 1) {
                printk(KERN_ERR "iscsi_tcp: Invalid max_lun value of %u\n",
                       iscsi_max_lun);
                return -EINVAL;
        }
...
}

Unfortunately, the thread has split in two because of some issues with my
original mail. This message has the other updates I've made to the patch [1].

> I'm in agreement that the current handling of I/O queuing in the storvsc
> has problems.  Your data definitely confirms that, and there are other
> data points that indicate that we need to more fundamentally rethink
> what I/Os get queued where.  Storvsc is letting far too many I/Os get
> queued in the VMbus ring buffers and in the underlying Hyper-V.
>
> Adding a module parameter to specify the number of hardware queues
> may be part of the solution.  But I really want to step back a bit and
> take into account all the data points we have before deciding what to
> change, what additional parameters to offer (if any), etc.  There are
> other ways of limiting the number of I/Os being queued at the driver
> level, and I'm wondering how those tradeoff against adding a module
> parameter.   I'm planning to jump in on this topic in just a few weeks,
> and would like to coordinate with you.

There are tradeoffs to reducing the number of hardware queues. It may
not be the right solution for many workloads. However, parameterizing
the number of hardware queues, given that the default would be the same
as current state, doesn't seem like it would be harmful.

virtio-scsi, for example, seems to provide num_queues as a configuration
option in virtscsi_probe() in drivers/scsi/virtio_scsi.c

  num_queues = virtscsi_config_get(vdev, num_queues) ? : 1;
  num_queues = min_t(unsigned int, nr_cpu_ids, num_queues);

And then use that value to set nr_hw_queues in the scsi host:
  ...
  shost->nr_hw_queues = num_queues;

In fact, it may be worth modifying the patch to allow setting the number
of hardware queues to any number above zero.

I made it a module parameter to avoid having to change the interface at
any point above storvsc in the stack to allow for configuration of this
parameter.

[1] https://lore.kernel.org/linux-hyperv/20210205212447.3327-3-melanieplageman@gmail.com/
