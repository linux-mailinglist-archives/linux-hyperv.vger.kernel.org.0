Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF5AC96F
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Sep 2019 23:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406830AbfIGVlc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 7 Sep 2019 17:41:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44365 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732468AbfIGVlc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 7 Sep 2019 17:41:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so5475154pgl.11;
        Sat, 07 Sep 2019 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rar7+a8LD0KANAp/lVeGtNr0VZS4OVkIBwxcWjVF7fo=;
        b=kwSx+U26sg/1ZFJEwjbGN++gHnIHb25rHZQsX7kQge9MWN2Wn/8QiDbNh5Yx/3ecs0
         1zEkIP8zO8k8w4wnReHUF009lMiHIidZHKDpcJx6DabjzX3j+xIFQpAF6Am1pHQScsyx
         A2iliUkyQT0+XOOHJdQ2Uf7WvinVvPa0XTTlUL5NwE0EoE/Jd8nqZndeJn1xBgJf8JLy
         GesKao2qJon0PnciwA1FJofqTgS8vpb+86V6Mn/Z0cGUv1AGRaKYz5CmQ9OEkLlr+e/Y
         1jaz9g9YSTdBJ83S6AWzyyrD7cza1zehSuSFX1wB42VOeTMc9t9QlzckCkzKCaKVKELm
         3I6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rar7+a8LD0KANAp/lVeGtNr0VZS4OVkIBwxcWjVF7fo=;
        b=sQ/EsivDa61yO7abIv7ZRltQmHrKoSm2w+YSO1mqhTPRTYurgtD6Cq9k2HmfXyqlfC
         KCnUEhuEmX6sKRmRMP25poUA8ke0fBe8aK9HSMGbVxmUpcnSY8jKPLU2DcT3swOTFI5j
         GjG+SS/D0pZ2axk7SAFkAEk6qVadvb9ynSGEpoZdVtxfOJ41FJjMGFdQ5gKAkBmheIZw
         xvGmLjw6m0RUS3JAvkNgolol/LoZ9hZ26TT74nmzRJrZntzTaDkcD9zQjq0ix+yOHaFB
         w0pgVN6v9+cs/jKiaobzxMy0MQEwS94LhFVf/2KtR2KKsHCHR/tfr/G0w46JMR+9yyJl
         Bc9A==
X-Gm-Message-State: APjAAAWLq28DDOCuDVAIteh9zdjOhgwfzf5OETI+ThhAehSOEgfwZbxu
        ASWS+uxPTa2JdCNIaCVpstw=
X-Google-Smtp-Source: APXvYqwoZAkoLr5to9U2rXC0sBG3iafTZgw6qEDbSJDElFdfik0viB+6vT7qjTj7VVZh0WLTfkqGzA==
X-Received: by 2002:a62:1658:: with SMTP id 85mr19104372pfw.195.1567892491692;
        Sat, 07 Sep 2019 14:41:31 -0700 (PDT)
Received: from localhost.localdomain ([112.79.80.177])
        by smtp.gmail.com with ESMTPSA id h11sm9078516pgv.5.2019.09.07.14.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 07 Sep 2019 14:41:30 -0700 (PDT)
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
Subject: [PATCH 2/3] xen/ballon: Avoid calling dummy function __online_page_set_limits()
Date:   Sun,  8 Sep 2019 03:17:03 +0530
Message-Id: <854db2cf8145d9635249c95584d9a91fd774a229.1567889743.git.jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1567889743.git.jrdr.linux@gmail.com>
References: <cover.1567889743.git.jrdr.linux@gmail.com>
In-Reply-To: <cover.1567889743.git.jrdr.linux@gmail.com>
References: <cover.1567889743.git.jrdr.linux@gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

__online_page_set_limits() is a dummy function and an extra call
to this function can be avoided.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/xen/balloon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 4e11de6..05b1f7e 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -376,7 +376,6 @@ static void xen_online_page(struct page *page, unsigned int order)
 	mutex_lock(&balloon_mutex);
 	for (i = 0; i < size; i++) {
 		p = pfn_to_page(start_pfn + i);
-		__online_page_set_limits(p);
 		__SetPageOffline(p);
 		__balloon_append(p);
 	}
-- 
1.9.1

