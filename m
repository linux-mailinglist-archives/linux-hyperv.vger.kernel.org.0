Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C447418BD15
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 17:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgCSQwR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 12:52:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35796 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgCSQwQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 12:52:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id m3so3175474wmi.0;
        Thu, 19 Mar 2020 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hB9EOmeEoQOPuImvB9jQhgdyqLRUd97IR5tYRMN/KRg=;
        b=Y4xc6fEDR9ZHOybEP5BSWaD2bCPXt0bWNVHUYEZEoiO95Tr1osrH5Jg+ukA+i2z9Ui
         8736XBhtjQpD23VoNl2wnLTxw7vrkSpl4aRfQH9IlWPeTp5zvZ+U8x4yrhdcaNZXo5e4
         9Gq9vqwItg4qNpX2rl4QntOkZcN/mPIoowB3YasVy5lknqPdaWhmmIKjvHsbTW8leN3u
         95GD69hDivtRX2YaRauGxLAAMBOiLXlYhZYAptC84AAB3U+edwC07k7IGUDAU32IoeEA
         rkttdRg5/vN0IIDtzGg9TNzJMsegxA7CBENS/LuzyaKZfMDg73to4nj9d6CtbP+kl/Tp
         Z8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hB9EOmeEoQOPuImvB9jQhgdyqLRUd97IR5tYRMN/KRg=;
        b=Kuuvk2/9GgTPS+zdkgWWLLl+BrX3Q6ERbYwEv/JeZHdHclWB1iC26SNKkmOnWviCsy
         mcceZ8O0cjJVs8b04zI6pLPACJn1fpdCjSLey8CY8seLwtsS9j6w1fWiEksUNy2EoHlL
         AD84gUPPr1vofGVz6FwJV+xUEPzo6Avoo34xhAwVOXNdynr5/13HAdh5lVEsD0RoxU5n
         tpgyLkIxFBbN4/KcoAoK53oX8/e5MdRzRmABnHTal59EzWTsxugKQru7Ort2fHLHmfk7
         p5+eVkJEUo6BU6XKYNu2Gy+fCL4zWFwp9klP1WtEu1fLEFwsNfPNdoAjRfeKxvN+8ISC
         Fw6A==
X-Gm-Message-State: ANhLgQ2FTvbp1/kLTuW4JHqDaHR/Pi9etQE10CEirYylY/WJCm88l20p
        RNaoCQU9wndoBgo2NJPWGYFJUKIbLh8BRF2y0Dc=
X-Google-Smtp-Source: ADFU+vv1zSb3f06esRnDQl+NjMCVPD282wJZ/FHh2w2P8kdQDmilSBiF4CcKHzLjYAQ03eTB5GFF5fFsJ6f1/h7dKu8=
X-Received: by 2002:a05:600c:2709:: with SMTP id 9mr4778011wmm.30.1584636735093;
 Thu, 19 Mar 2020 09:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200319131221.14044-1-david@redhat.com> <20200319131221.14044-7-david@redhat.com>
In-Reply-To: <20200319131221.14044-7-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 19 Mar 2020 17:52:04 +0100
Message-ID: <CAM9Jb+jaia-AxpvxsTOVxYg_S=xZy2UY5srARA2J2_DkXPgZ7g@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] mm/memory_hotplug: unexport memhp_auto_online
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> All in-tree users except the mm-core are gone. Let's drop the export.
>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index da6aab272c9b..e21a7d53ade5 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -71,7 +71,6 @@ bool memhp_auto_online;
>  #else
>  bool memhp_auto_online = true;
>  #endif
> -EXPORT_SYMBOL_GPL(memhp_auto_online);
>
>  static int __init setup_memhp_default_state(char *str)
>  {
> --
> 2.24.1

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>
>
