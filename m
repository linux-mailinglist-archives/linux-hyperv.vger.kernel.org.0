Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E4039B8F7
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jun 2021 14:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFDM0y (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Jun 2021 08:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230025AbhFDM0w (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Jun 2021 08:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622809506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=T1WL3P0Jah1FRVj8EdxTUun4/hVMeybsNLS0++AfbT0=;
        b=VFdX7czRrNw/CMJOni6iqJ7eauGJRFM+p4UIVatuwyOUllo6p+RD6de27C0gQWDUqdI3Vi
        O7I6VcsrrBfA7Mlmb/9FFLZNhdPgp5O/5LxU9WfB8lD0G3ouvcCCQ/DduFn/7sDEkMVFhk
        yKvc7fQCPvdnKDKw2JXZ86LTSICec9Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-AbzOWcnZMaiTw_Ou0l_Xyg-1; Fri, 04 Jun 2021 08:25:04 -0400
X-MC-Unique: AbzOWcnZMaiTw_Ou0l_Xyg-1
Received: by mail-ed1-f70.google.com with SMTP id h18-20020a05640250d2b029038cc3938914so4902010edb.17
        for <linux-hyperv@vger.kernel.org>; Fri, 04 Jun 2021 05:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=T1WL3P0Jah1FRVj8EdxTUun4/hVMeybsNLS0++AfbT0=;
        b=HuIiun95xKiuQ9P6OMYoyldo+NYEw9Wr3XBz7cxPVyrDMhUspGWYB0cxjNZvdT0Eb6
         dPLH3ZpE8Umfs1zcFbFkcMeum12dijU2z+VvFhApoQpWGC6a2o3NkM0fCyzgi3DymVlf
         lXtW6Y/xqKC/G8m8z5jR4MoR2pn9V6+KQdKpvC1ukhweOs1RbKGpF+aofUb4ql9dgyuL
         /T8KlB62Sv7P0Hq4yYJusut7p0eIDdjcOyy/tBy9nxablowMoEb/yw5V7OLqF8F4zvvJ
         X8Q5X5TKwXAJZkqPGAI/xaDMYe7jjcFA97KigxsaOfPYKKgfgXcYbFQGQBGnAczPCuIi
         7eYg==
X-Gm-Message-State: AOAM533HhXh/uWnPYbqjUfcsaqJD0+1vTKmHD7ovs98mH3s9+rVMvU3P
        00Do0ClAjrjrX3eHAaq/xM8qEH67J30AkVMOAWNocZONdlDS9Mi+EuA4XjyQRf5RBNEvTVT71Pm
        Oyqh1B1+MoERY/4OEQacoS60s
X-Received: by 2002:a17:906:a294:: with SMTP id i20mr3970587ejz.330.1622809503414;
        Fri, 04 Jun 2021 05:25:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfBZrM0jIbqGlvYiCojcZlu9rkqXCZiG0w6fufb5vpo1LYyrvNtiveJmLUv90tBUtvyXi0ew==
X-Received: by 2002:a17:906:a294:: with SMTP id i20mr3970577ejz.330.1622809503266;
        Fri, 04 Jun 2021 05:25:03 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e22sm3207492edv.57.2021.06.04.05.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 05:25:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Matthew Wilcox (Oracle) <willy@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>, wei.liu@kernel.org,
        Dexuan Cui <decui@microsoft.com>
Subject: [bug report] Commit ccf953d8f3d6 ("fb_defio: Remove custom
 address_space_operations") breaks Hyper-V FB driver
Date:   Fri, 04 Jun 2021 14:25:01 +0200
Message-ID: <87v96tzujm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

Commit ccf953d8f3d6 ("fb_defio: Remove custom address_space_operations")
seems to be breaking Hyper-V framebuffer
(drivers/video/fbdev/hyperv_fb.c) driver for me: Hyper-V guest boots
well and plymouth even works but when I try starting Gnome, virtual
screen just goes black. Reverting the above mentioned commit on top of
5.13-rc4 saves the day. The behavior is 100% reproducible. I'm using
Gen2 guest runing on Hyper-V 2019. It was also reported that Gen1 guests
are equally broken.

Is this something known?

-- 
Vitaly

