Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E36D186EEC
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2020 16:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbgCPPqi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Mar 2020 11:46:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55180 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731555AbgCPPqi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Mar 2020 11:46:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id n8so18208092wmc.4;
        Mon, 16 Mar 2020 08:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MGxsdsEHOherRp17TfnieaB5yDaVnKlVFdsLG6O6di8=;
        b=oL4V0XiJUl0pyMqtuz3VhR8GPGJoG7vOUtpR6rC9zsfo1qOZHsYivABB7NUvcGiz1e
         sfxrfxW7paJLp0irUM7RTIN+VzmPzXFtVdUXuNoeDnqCmKekXAsr7XG6++VQIpLB1+JA
         cuvl9SmepE+bsebhf8z1tAx1SsefZtDwG6COs55PXVxwzXtJPi7ivMgdPkgMSvHAj5gF
         4CzkvnHIMseJ3mXHhRxjXFG6fMeBTEDJYw+qjNJBGWh58bCFAlmHU4gt7X7/RGKbui2S
         +aAou35g4lUrmiZJ/aHG60EIoZ8NTXSQiczLSUCz8l/88siefNZxd/A0xj3JY+PlZqam
         Uo7g==
X-Gm-Message-State: ANhLgQ1d3Rd6//v0DYoCJFd77yfZgu+ucdBobkmVsipcnvMC2F2s46Np
        SFpqOGjbPOGz3vYkpB/46+26LJRj
X-Google-Smtp-Source: ADFU+vsGSsWLNS4mewW6bBNA5vuq21jmrlZnKO0gV6Uo/M+U90aT4ZqfpnzmH6VqcbrIirthoenViQ==
X-Received: by 2002:a05:600c:218f:: with SMTP id e15mr30190351wme.152.1584373596535;
        Mon, 16 Mar 2020 08:46:36 -0700 (PDT)
Received: from localhost ([37.188.132.163])
        by smtp.gmail.com with ESMTPSA id y189sm138209wmb.26.2020.03.16.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:46:35 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:46:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 4/5] mm/memory_hotplug: convert memhp_auto_online to
 store an online_type
Message-ID: <20200316154634.GX11482@dhcp22.suse.cz>
References: <20200311123026.16071-1-david@redhat.com>
 <20200311123026.16071-5-david@redhat.com>
 <20200316152459.GV11482@dhcp22.suse.cz>
 <f6088e93-9cb6-08ee-ac89-8cab289dc460@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6088e93-9cb6-08ee-ac89-8cab289dc460@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon 16-03-20 16:34:06, David Hildenbrand wrote:
[...]
> Best I can do here is to also always online all memory.

Yes that sounds like a cleaner solution than having a condition that
doesn't make much sense at first glance.

-- 
Michal Hocko
SUSE Labs
