Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B369189E6B
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2020 16:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCRPAX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Mar 2020 11:00:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39037 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726680AbgCRPAW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Mar 2020 11:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584543621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vM5m3AgHzQ8TLHWUI0zWYeLWIk49n7q4tlPXYDa1gEQ=;
        b=FWcITW8h9pdTlAORXzYB3p0IJSisHmFknF2lLYFTUKgXIEtdJfdUWnyj8ghbIj2+AG4UBc
        AD0fZW8/YSUZBiUnpUw1X0pMWeIMc5aEg0/7XI81AWpaQwCz1qn0kqFJ++Uc6DfJAdvl76
        e2UYJ3id9J1YOilW7WfU/vFsRZVuS1k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-LN6gdBhPNlKCI2Mbj224og-1; Wed, 18 Mar 2020 11:00:20 -0400
X-MC-Unique: LN6gdBhPNlKCI2Mbj224og-1
Received: by mail-wr1-f72.google.com with SMTP id q18so12454780wrw.5
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Mar 2020 08:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vM5m3AgHzQ8TLHWUI0zWYeLWIk49n7q4tlPXYDa1gEQ=;
        b=AxqTp71Cs/IWVC7Z234xJMfgAzKGfi3VKTJeb1sypOABj+LFDdjj7XhqTzdQswtGK9
         GgRG0weU5+iPLaE/Kl8iup/zAGYc4u3TEk1FJEdjVQPTfSscaaKAJYib6TUAuxgBOqMR
         pU4DQXLB46xEOy0S375bFs2FcmnoWhZds5oymjWdGg++BG+gN52GSPpStFuI9JHR5CMx
         9Kau1RCrQsevSd0XmPaoMdPtfN6R9P+aiJIMpS2BeotJMlPXwc96xGPGmkCUrMr09EWa
         +C2Vio2AMK0uNm1vPIMumv0m1hp/4ghJSM9LngYe4500CPhPptCVfBfizmOjix90Q8mr
         GmhQ==
X-Gm-Message-State: ANhLgQ0aTr+Fo6BsSnt9SRPh7t8lDZNXpvr56bfuuU4Y8blGIqYHzdJF
        g15sDF02rl9UAloqMZ3IOvHNTfDN4UnXLDmhJzhYCMQni3S0vMhe64rQsgpm/rAzDrA2fDXU49q
        V0lHjbXOp4VlZzFfWn5VKIyKx
X-Received: by 2002:a5d:474c:: with SMTP id o12mr6171275wrs.156.1584543618664;
        Wed, 18 Mar 2020 08:00:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv+zT1QJmX75ZvxUY39VsKhPCv6bUGTeJatv+Ce8GRjcg/v0Lus2RekaAdHVMZwveqCGhi86Q==
X-Received: by 2002:a5d:474c:: with SMTP id o12mr6171235wrs.156.1584543618411;
        Wed, 18 Mar 2020 08:00:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x13sm4631033wmj.5.2020.03.18.08.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 08:00:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org, Yumei Huang <yuhuang@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Milan Zamazal <mzamazal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 0/8] mm/memory_hotplug: allow to specify a default online_type
In-Reply-To: <20200318144119.GD30899@MiWiFi-R3L-srv>
References: <20200317104942.11178-1-david@redhat.com> <20200318130517.GC30899@MiWiFi-R3L-srv> <87d0993gto.fsf@vitty.brq.redhat.com> <20200318144119.GD30899@MiWiFi-R3L-srv>
Date:   Wed, 18 Mar 2020 16:00:15 +0100
Message-ID: <874kul3dz4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

> Is there a reason hyperV need boot with small memory, then enlarge it
> with huge memory? Since it's a real case in hyperV, I guess there must
> be reason, I am just curious.
>

It doesn't really *need* to but this can be utilized in e.g. 'hot
standby' schemes I believe. Also, it may be enough if the administrator
is just trying to e.g. double the size of RAM but the VM is already
under memory pressure. I wouldn't say that these cases are common but
afair bugs like 'I tried adding more memory to my VM and it just OOMed'
were reported in the past.

-- 
Vitaly

