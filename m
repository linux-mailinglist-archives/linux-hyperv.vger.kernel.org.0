Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 231D413A441
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jan 2020 10:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgANJvA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Jan 2020 04:51:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38613 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANJvA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Jan 2020 04:51:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so11477473wrh.5;
        Tue, 14 Jan 2020 01:50:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pEjFsFpCypBmbTAAbsMBZocao2aRdb0v8F3qtUDClnU=;
        b=mPUrjxnJuhzLL6qO+w/054KsvJgIDO7sUnVlRYpRV7Mz3vliCbrPKwx8aDVPAZJwmf
         vmTlJvYItaH4e/DXzOhZBf2VNHEdF/+YgFMWhVRbeo2EWJn/rgySIkedTegRC8lUsrHM
         Xas+L3urUcUoXwKIYThrnO3VfxwcbfTVrV9Yf1X8udgtp+90I3Rw5OBraQ39GZSjBOTg
         DPJUUofDdOfRJIyaNTkxiSsMUGLZTWqtoSvdxBCyr5kC5CUDTAdkQvlF09fqKqPaTy+K
         nwOWZ/2k+EBykmOvN2li4SJjwufyTcw30TTc8qlvZulpKCm6Jo6FL7ezU6K8fOg9UhM2
         Dk3Q==
X-Gm-Message-State: APjAAAXUrFzL++3bRG7fzGyEzMXlBWVhRj+GDhYA0LufIuWaa6EgN/2E
        luSq5RdmkQKJxQp678TkwMc=
X-Google-Smtp-Source: APXvYqzcd9TQA5n6FKsfqJRldrVd7OL4sZZDEncBCpJwnaTi+pv49H3QMRWm9zPqXoTATkShHQWBlg==
X-Received: by 2002:adf:a746:: with SMTP id e6mr24863095wrd.329.1578995459210;
        Tue, 14 Jan 2020 01:50:59 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id b10sm19428113wrt.90.2020.01.14.01.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 01:50:58 -0800 (PST)
Date:   Tue, 14 Jan 2020 10:50:57 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        vkuznets <vkuznets@redhat.com>,
        "eric.devolder@oracle.com" <eric.devolder@oracle.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "osalvador@suse.de" <osalvador@suse.de>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>
Subject: Re: [EXTERNAL] Re: [RFC PATCH V2 2/10] mm: expose
 is_mem_section_removable() symbol
Message-ID: <20200114095057.GK19428@dhcp22.suse.cz>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
 <20200107130950.2983-3-Tianyu.Lan@microsoft.com>
 <20200107133623.GJ32178@dhcp22.suse.cz>
 <99a6db0c-6d73-d982-58b3-7a0172748ae4@redhat.com>
 <SG2P153MB0349F85FB0C1C02F55391F6D92350@SG2P153MB0349.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2P153MB0349F85FB0C1C02F55391F6D92350@SG2P153MB0349.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon 13-01-20 14:49:38, Tianyu Lan wrote:
> Hi David & Michal:
> 	Thanks for your review. Some memory blocks are not suitable for hot-plug.
> If not check memory block's removable, offline_pages() will report some failure error
> e.g, "failed due to memory holes" and  "failure to isolate range". I think the check maybe
> added into offline_and_remove_memory()? This may help to not create/expose a new
> interface to do such check in module.

Why is a log message a problem in the first place. The operation has
failed afterall. Does the driver try to offline an arbitrary memory?
Could you describe your usecase in more details please?
-- 
Michal Hocko
SUSE Labs
