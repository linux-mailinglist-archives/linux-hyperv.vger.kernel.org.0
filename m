Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 038E11327CD
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2020 14:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgAGNg1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jan 2020 08:36:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39494 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgAGNg1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jan 2020 08:36:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so53947646wrt.6;
        Tue, 07 Jan 2020 05:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AH8QrVtR12IeR8yMYo+97ujGygRwsjvu4AYsXyeVsN4=;
        b=Jvp+5VtcpYOml5Xnhk48gWmHYAeEUI3AvmIrtkYy0R1QdyM953N7vZmAZZJC5NSGyu
         yi8USaYbD1xM0Ql2wz6wWfiAI2C5jDcqGtIseHx1QKvB/lbZ7hfmNlN1DsPZkuaZ+O1R
         +VNTVLOfvtz/s6yPz9cWSNUP+Q6U6+W359kX64ACVs6x1WTkieV7Lz4NMSW7EyFL03uP
         RJ5RJf6JuWZyM2CekHmzrvfWl3mxg82W/aYsQBoocgmFzZnFm4JDCeUmhuEWyIqwIrDQ
         e21jw9srnYuvEVxZQSinWWBYUxsNozTG6Ehb+rFFmNZ+OrflljfssybxGOLPKdnNa2pR
         jMjw==
X-Gm-Message-State: APjAAAXXgmoUJVdkv8WYW6rdnc90bEoekvcIfBi+RictlR/rJazK1zMV
        H0Xbqv4jN8a3Y/kcjInbBbg=
X-Google-Smtp-Source: APXvYqySoHfDDMFqCr5GWL3JYiV6OuinzTu6RicyZZaXwH3sb5A8n5AylBh2i39PXkBOr0Awbsiv4g==
X-Received: by 2002:adf:db84:: with SMTP id u4mr111448345wri.317.1578404185319;
        Tue, 07 Jan 2020 05:36:25 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f16sm76245530wrm.65.2020.01.07.05.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:36:24 -0800 (PST)
Date:   Tue, 7 Jan 2020 14:36:23 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     lantianyu1986@gmail.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, akpm@linux-foundation.org,
        michael.h.kelley@microsoft.com, david@redhat.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vkuznets@redhat.com, eric.devolder@oracle.com,
        vbabka@suse.cz, osalvador@suse.de, pavel.tatashin@microsoft.com,
        rppt@linux.ibm.com
Subject: Re: [RFC PATCH V2 2/10] mm: expose is_mem_section_removable() symbol
Message-ID: <20200107133623.GJ32178@dhcp22.suse.cz>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
 <20200107130950.2983-3-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107130950.2983-3-Tianyu.Lan@microsoft.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue 07-01-20 21:09:42, lantianyu1986@gmail.com wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Hyper-V balloon driver will use is_mem_section_removable() to
> check whether memory block is removable or not when receive
> memory hot remove msg. Expose it.

I do not think this is a good idea. The check is inherently racy. Why
cannot the balloon driver simply hotremove the region when asked?
-- 
Michal Hocko
SUSE Labs
