Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1686118CE1
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2019 16:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLJPqZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Dec 2019 10:46:25 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42032 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJPqZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Dec 2019 10:46:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id x13so28257plr.9;
        Tue, 10 Dec 2019 07:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SEVzYm5jNJz4VDppe7/WWH/36/csGHzBj+3YG9crYxM=;
        b=eNKUlyZV+9AK1rbPzSc599PR8/HSVo0lodnmDdgldEBN+E8992+FTU0pFM/BGwnRcH
         JAxUwICUHyHn0fe2PDB8IPK5J2ulLLVCxPCSoIlVq8ink6QYMpUvg1wtEFYTmJtG0Aq4
         FmagRIeEWF8vc3f1ZIDGXaygRrcXQp33KVybMXUp+hupPuuye2cNt4jaGv8NnO6Ppe5q
         VXiAhpSunwIaX/0TC1mVYTkVImYNC0+dqChCaIQNefOMfwRwAadw5Jf/TWrRIMxV8SeV
         WNhnXbn+tv/bK4U0imlAM3QUz5SYnzTbw+8Zatgv3E7/216iAUJUsnt7mvF7/g4XMaKl
         97eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SEVzYm5jNJz4VDppe7/WWH/36/csGHzBj+3YG9crYxM=;
        b=sshqrgdjhvBwda3JhTZAOLU66b43vsew2XVdRlvYFg0pB8UCTvhdB/rxqHZz6cwO5o
         x7bPlzcpqIPVhAvLiMqjxYFJxWgjZy3/BiQeT3WGIjE5UUosQhWsMEMsvXyY7iQ/+RcY
         Wkol/J4lT/13MWZbjRMmizTxUsGqKZ1aS+0DMgXaouy8n+NnZgJrtf3B+8vOPtSpnLrW
         3gv448C2J+8bdd0C/vycFevZdYH6wXOGfaEdxoWQeQxWQfWDkNSi0ZSHJEXonl7m96uD
         CLn6uZ6YgQrvDLEuKAt+GUIAPLmCuC9GZX4PJF/hLnrhSWph8tKkawL4puVpdd7LodEp
         oBrA==
X-Gm-Message-State: APjAAAWQLC2OSsiZ4YsYf4pITonxqdEone3UyQA7RqPQ4Dr5N1EK6F63
        WfCKr0StA84+yEsI6q5IROI=
X-Google-Smtp-Source: APXvYqytYp0R9zyeFlRgYBWM3uJZ4gUjN8fiMjYfYdCW0CrSvIjuPbzjXajrvhEJz9y++TYaz9rvHA==
X-Received: by 2002:a17:902:aa8f:: with SMTP id d15mr36828933plr.80.1575992784728;
        Tue, 10 Dec 2019 07:46:24 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id k13sm4113815pfp.48.2019.12.10.07.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 07:46:24 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, jgg@ziepe.ca,
        dave.hansen@linux.intel.com, david@redhat.com, namit@vmware.com,
        richardw.yang@linux.intel.com, christophe.leroy@c-s.fr,
        tglx@linutronix.de, Tianyu.Lan@microsoft.com, osalvador@suse.de,
        michael.h.kelley@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH 0/4] x86/Hyper-V: Add Dynamic memory hot-remove function
Date:   Tue, 10 Dec 2019 23:46:07 +0800
Message-Id: <20191210154611.10958-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V provides dynamic memory hot add/remove function.
Memory hot-add has already enabled in Hyper-V balloon driver.
Now add memory hot-remove function.

Tianyu Lan (4):
  mm/resource: Move child to new resource when release mem region.
  mm/hotplug: Expose is_mem_section_removable() and offline_pages()
  Hyper-V/Balloon: Call add_memory() with dm_device.ha_lock.
  x86/Hyper-V: Add memory hot remove function

 drivers/hv/hv_balloon.c | 707 ++++++++++++++++++++++++++++++++++++++++++------
 kernel/resource.c       |  38 ++-
 mm/memory_hotplug.c     |   2 +
 3 files changed, 664 insertions(+), 83 deletions(-)

-- 
2.14.5

