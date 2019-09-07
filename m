Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29BAAAC96B
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Sep 2019 23:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbfIGVlS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 7 Sep 2019 17:41:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42856 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732468AbfIGVlS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 7 Sep 2019 17:41:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id y1so4760475plp.9;
        Sat, 07 Sep 2019 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wEzd7dh/YfO3zGLSxxCdwFOAGiIma8fe0owdbCkXYmQ=;
        b=EF6LYsvWkXNSwOEXeE/6qHUB7pHfQ83htTle+NmPGwqybQ6Pt0jKRg4Wa27sovW/ni
         NmrFujKRHtQXBDBdP9pkAfvI/6w4T+Y436JlzgoPW7FqV4ThEqdq7dako9+HV19cPW4n
         /uZifgpZfEjT1YGD9+BmbMXz3a54nSaZZ/2PoVfnygssJ6+GC5SuurZ99ysJED63QoPf
         act/g/bReiNpFjOvKy+IJTpJWLw4EZQb53OaOxz4GoJb+2ZCDr1qolmeiWXw2XPvBuxu
         XKQ/cNXPoDcQN5fBaoqD+XzWJqozOZfyfMy9465SkLtiM2n+LCifhb0iKgepQvpSwQcs
         px7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wEzd7dh/YfO3zGLSxxCdwFOAGiIma8fe0owdbCkXYmQ=;
        b=MS1UI8OoFx+YmORGsCwmZ0B+DjXnYly08qstRQoad9xVx25uNhmKpNQSaACIVnYzIO
         QrKOQ5cBTtApEnaF8Mzv1M7xj9p0UY+5HVLhCzOcQ6MumR45JiLanJOp87kUvY8YALvW
         FYhhXH6GSo1IpO4zBCB9xbOzjRn4ea2pkchzcMNRBj+mAP3Ad+92+4uP1M3w9ChLm04W
         ucx676jPeseQlgnr9G5h0E6ptGoPyeNd47R+9tnEq/WlYwF9fN0bldYh57Rz87jdIihQ
         uGG8C39fdOwWk7C9vHqFOZu5XwpJNr6K2kTE4NEMe2fuR03yK6SWxJUMYAOKCB9ty/Hq
         ISLg==
X-Gm-Message-State: APjAAAUCqQKAvZf9kzc/ARSx9eoPk+QDA2owT8Kk6YjE2LBpVoXTAdOJ
        zAK7RUj6DXR8HxV7JmUM0GM=
X-Google-Smtp-Source: APXvYqz+VvW5vydphQSj0ObTAVGfP2jazOrVP9sq7QamakSG2pDZ3tjxjHqAy590l89owgeU1hfKhg==
X-Received: by 2002:a17:902:8686:: with SMTP id g6mr16403651plo.175.1567892477461;
        Sat, 07 Sep 2019 14:41:17 -0700 (PDT)
Received: from localhost.localdomain ([112.79.80.177])
        by smtp.gmail.com with ESMTPSA id h11sm9078516pgv.5.2019.09.07.14.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 07 Sep 2019 14:41:15 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, akpm@linux-foundation.org,
        david@redhat.com, osalvador@suse.com, mhocko@suse.com,
        pasha.tatashin@soleen.com, dan.j.williams@intel.com,
        richard.weiyang@gmail.com, cai@lca.pw
Cc:     linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH 0/3] Remove __online_page_set_limits()
Date:   Sun,  8 Sep 2019 03:17:01 +0530
Message-Id: <cover.1567889743.git.jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

__online_page_set_limits() is a dummy function and an extra call
to this can be avoided.

As both of the callers are now removed, __online_page_set_limits()
can be removed permanently.

Souptick Joarder (3):
  hv_ballon: Avoid calling dummy function __online_page_set_limits()
  xen/ballon: Avoid calling dummy function __online_page_set_limits()
  mm/memory_hotplug.c: Remove __online_page_set_limits()

 drivers/hv/hv_balloon.c        | 1 -
 drivers/xen/balloon.c          | 1 -
 include/linux/memory_hotplug.h | 1 -
 mm/memory_hotplug.c            | 5 -----
 4 files changed, 8 deletions(-)

-- 
1.9.1

